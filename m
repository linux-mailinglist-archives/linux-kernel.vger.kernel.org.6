Return-Path: <linux-kernel+bounces-195669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC2D8D5010
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F0E285E86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952E2E84E;
	Thu, 30 May 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GJ/mcUc5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB42381AD;
	Thu, 30 May 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087558; cv=none; b=k2JN32S3tAg6uJGksUWa3XYkWCCGlWdyscST3Hz1F4ixDHTn5jmqH0XAzq716jZrM94L5Jc5LVfWnFd4Kiah5YIDI6heHxtnPs004uAjBSZbxjbBb/sRytsFO4LJj42BKFkU2ad03icD7UxC9wLvJCp0Pi6AGjV4bpmwiYQxDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087558; c=relaxed/simple;
	bh=qk39gyoxbhJi8EsXfKjIIZOrf8Xqs46kclVgKA1fOQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXrSxqj8AXo8PLaWHX7EUxOnprzNZuDsHjYKukWqRYpMMsWlFpR4YiVWDCTYcG7npvXP98eECOeqygLM1KXSsSARPtbqBRunPWp9KMRkMVLBlDcMlEgSOxc/Oc1FCp5BORtf0HbAFJBNr+KoyD/QrAtkv5m4GygBYYk7kavg1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GJ/mcUc5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717087525; x=1717692325; i=w_armin@gmx.de;
	bh=+sbFBOIGtQJ3Z6s/6LeuAIc7SUZVUMxZptQ+dk3hhWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GJ/mcUc5SMM35HlKy0uKYdVmopHIV6Gj8lu3eUg8v3VjqEDcPIyeq0ESlqQRoHkj
	 CdYvWxBy05iADvHIRSEALQYJYi3G9Tz0I8MIWhpq20c7nNmhVa7Daxc6ZRFLaGruS
	 XQpt535kVhBWQbRQLBWfA52d4Uw4q4SG8fh2p9/LaVaxgq2OChti5jAGLDFs4Fe9i
	 q0r13n9krvQjyNKnoVZ5Gfu4/uGJS3xT/8zQkUBwLqDGBfSmjvIMHK3OMhAgCMKGT
	 u39cdch5NuflPsTOxWH8IXrXjis+/7qVTXGTU8BYxTENm6ZBhbGbjHgJ1WtcTo37I
	 t0bYyIIl6uh34VTqGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiHl-1rqWYk0FTT-00MpAK; Thu, 30
 May 2024 18:45:25 +0200
Message-ID: <5b9e47cb-3d9a-4d12-9d48-fc03111a0240@gmx.de>
Date: Thu, 30 May 2024 18:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <fa79f3c2-666f-48b8-b39a-f598107b2293@gmx.de>
 <0dc7a7c6-a426-424a-8321-471569ee6835@roeck-us.net>
 <bd197671-4fef-4cdb-8472-b46151e9008b@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <bd197671-4fef-4cdb-8472-b46151e9008b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZHIigq41HF2JUJXlrJyogOxGQild7NZ1LT/AJAx4lwzcV0KmnMI
 NaUz1XvUi3TePfwLsUaIUJj9AREifhScRm/KCXHztV7M8xUYkW9JV1MYcp+ENyN99rd1he9
 w/8U5TGXMQcrvtKTIqnS9f6uKvCdJYRGzSfeb4OtTDzwAbxg1qOH5cHj67NELYo45fbsPUw
 k4xC4iXzBPQsVjXHQFbBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q+Q83wcrc3E=;tmVdbGQHrEgFJ7O+7iXVU+34pJy
 r/t0Zt/P6uBGABIe1usO6EOHq/OQbHPxHPQHlwqhcgOnkM4lsCeMMSSmd3AUpwW9KJB3qE+DR
 THK2s03/LfnmrL6Q976ki2fiPLOuo1fyO/21gJ2fn/dtyxCY/wZsFAdndsI6j3/u/k8UySWRl
 kd3hZjozITc5IsyUtAYjxHgb0dmFGO8EydYOchqFIgbaDUzVfk9nyqnUZtiIoDekIn0ixV0ec
 RNvRXPtLY6I/fkkLWn44aCMAGSon2GJ6LvNvms2z4wE3Ejkem8oCfG4XN6ocfBabGofFCNjxJ
 b07Yyrm9ajvbccseseuTvczNDDnRo4YC7syBDsc6QYmMaKTZVdp+aAatfOD9J8HzSBuKFE2qL
 R6VgdOjmBCuVoPvt1FqI8Ig6AfKPug0gMrSDbTaPcD6oboHmgdlbk211UeurCYWaS7oVDpd6u
 0EeLAhmPKu3saa5dvYiwFpY3JPUGSAlJdrZkp/JoMJSTaptPFfXNyv8661MYZI4UwxxFLOte1
 DTG5saQyu0OkPA59ML1o75Q2vMbcUzSiU2cm9TgIk3GyJu0tCJJBQ6bKOHKeuAoBANPY098R0
 kE8gRCIcHZMIthrjkMqI2ImDJBrp66UwUbm+YsRXd1mYfbPLJwmih14LLU1OVyPkL8eB4oFZa
 ugHq1F0F+HOIyIuY3o6I4Ft7LhpFRMvvfUd9HPl9cpHdOR2RUNlj5KuuMxDP0m+yx7jcs8YR5
 Y9bELjDXKXqqyTwrRrWRFVzRqIghNHbc0E2SoJJuualLwroM4x4I2kOlKYzxAfxqUmbCR/J++
 H8sXkkYBHPeBgUnJSSYFyXmzBpMG5zzdgyOuj6NNB4ZZo=

Am 30.05.24 um 15:39 schrieb Guenter Roeck:

> On 5/30/24 06:23, Guenter Roeck wrote:
>> On 5/30/24 01:08, Armin Wolf wrote:
>> [ ... ]
>>>> +obj-$(CONFIG_SENSORS_SPD51118)=C2=A0=C2=A0=C2=A0 +=3D spd5118.o
>>>
>>> Hi,
>>>
>>> thank you for working on this, i am currently testing the driver on
>>> my machine.
>>> I already noticed the kconfig option is wrong, the correct one would
>>> be CONFIG_SENSORS_SPD5118.
>>>
>>
>> Oops. Thanks for noticing!
>>
>
> I fixed this up. I'll send v2 in a couple of days, probably early next
> week.
>
> If it is not too much trouble, could you send me a register dump ?
>
> Thanks,
> Guenter
>
>
# i2cdump 1 0x51
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 51 18 0a 86 32 03 32 00 00 00 00 00 ff 3c 00 00    Q???2?2......<..
10: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 00 00    ............p?..
20: 50 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00    P?..............
30: 00 c0 01 00 00 00 00 00 00 00 00 00 00 00 00 00    .??.............
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 30 10 12 02 04 00 40 42 00 00 00 00 b2 12 0d 00    0????.@B....???.
90: 00 00 00 00 a0 01 f2 03 7a 0d 00 00 00 00 80 3e    ....????z?....?>
a0: 80 3e 80 3e 00 7d 80 bb 30 75 27 01 a0 00 82 00    ?>?>.}??0u'??.?.
b0: 00 00 00 00 00 00 d4 00 00 00 d4 00 00 00 d4 00    ......?...?...?.
c0: 00 00 d4 00 00 00 88 13 08 88 13 08 20 4e 20 10    ..?...?????? N ?
d0: 27 10 1a 41 28 10 27 10 c4 09 04 4c 1d 0c 00 00    '??A(?'????L??..
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

# i2cdump 1 0x53
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 51 18 0a 86 32 03 32 00 00 00 00 00 ff 3c 00 00    Q???2?2......<..
10: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 00 00    ............p?..
20: 50 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00    P?..............
30: 00 cc 01 00 00 00 00 00 00 00 00 00 00 00 00 00    .??.............
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 30 10 12 02 04 00 40 42 00 00 00 00 b2 12 0d 00    0????.@B....???.
90: 00 00 00 00 a0 01 f2 03 7a 0d 00 00 00 00 80 3e    ....????z?....?>
a0: 80 3e 80 3e 00 7d 80 bb 30 75 27 01 a0 00 82 00    ?>?>.}??0u'??.?.
b0: 00 00 00 00 00 00 d4 00 00 00 d4 00 00 00 d4 00    ......?...?...?.
c0: 00 00 d4 00 00 00 88 13 08 88 13 08 20 4e 20 10    ..?...?????? N ?
d0: 27 10 1a 41 28 10 27 10 c4 09 04 4c 1d 0c 00 00    '??A(?'????L??..
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................



