Return-Path: <linux-kernel+bounces-563198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601AA63890
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B687A5EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0FBA49;
	Mon, 17 Mar 2025 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="oBs63bR6"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E3C2E0;
	Mon, 17 Mar 2025 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742170740; cv=none; b=sHg8DCZWm66r2veQ2jjS9zbZns6cErjBFu8LXmGyahxXr0d17G/NkWUaXKhKa/zMh6hpBTaa7RnZ7E4BlcWxyb6R5XjjvUYSfkSORCJcNeZz7DUrMl87f11jYGaAGv/URybmMxzzlqrZZbv1t10T5lad02WKPxEqK5eM6V65t6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742170740; c=relaxed/simple;
	bh=hbpPhso1wVwmnKgxYXI3aP8Aky9+xH/tEaNE+s5b2v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6ySRvA3su7rzwB01+uOg8fRKRqQYMHBFiQJivTQm4vmuz92yl/QF9nhw/9oserWYeR9PE35fbLgGdY//ZUJu0Hp5fllqPsZvD7zja6HgfSejw2XbjvUONRzYAOvG22/U6bg6zjasGw2g543k+4tkBELesQmzeMv97fvHhbWRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=oBs63bR6; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742170729; x=1742775529; i=w_armin@gmx.de;
	bh=13079H0FVo1jR9XznP83rieuugxrmdQU/sLlv3uJayA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oBs63bR6sYyhxujt7jpRQnWFVxVx1wyMf1B87tmXahx3AQdaskU0bwp8TW1QsszH
	 5j5t22zyxXoTsRTFl61HXoQCDSizyRLOby165KrITHcPEMmPpjp+avRnQOMB/ZKPR
	 x5eG5GWJSvQna6dWEabCx3PzVStNshhWvJr5aIMjgiNYWJe4kgBg/ooO8tiz/eGx9
	 1N/UBZL0RN715Nf7ceG3kREHinWW+8OnY248V/SX3YGAWuiAaIHR5rTUJApl7IVk+
	 spOGVyJfezP9Y/ioFXV7t8URrEhMXMPpL2j8PgBzyloFmcAVVwZL9efp1RupGg5lo
	 ewJY/cT7uUilyKBF7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1sy29b3tbP-00tBzo; Mon, 17
 Mar 2025 01:18:49 +0100
Message-ID: <4ed90f54-bf42-4372-951a-b33f457ffa22@gmx.de>
Date: Mon, 17 Mar 2025 01:18:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control
 support
To: Rayan Margham <rayanmargham4@gmail.com>
Cc: jlee@suse.com, basak.sb2006@gmail.com, kuurtb@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
 <637B90F3-58C6-43B6-9822-5314C62138C6@gmail.com>
 <eaeaef7a-570e-4738-a420-4d5f61adf0bf@gmx.de>
 <CACzB==4QC+khEpw99ekp-DK=jzMebroCw5PeXmgS9GsHmPYfSw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CACzB==4QC+khEpw99ekp-DK=jzMebroCw5PeXmgS9GsHmPYfSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrqxPUBbGL5Y4qzC2qISsk4prvqguZ7fGFNPZ5hUtetOilDCPBx
 Kw1HCz3wrTxxPifGWa3/hEK77V4m/n01yUpdfSHtq3zAXzMdNhT9xiouiawPGX3CjpjIyM4
 YTLmrq9IiwHMGHhTfHzcS60UluwIoRP7WABgupYYRJqTkVFEj9inKeKSU2AD+pX1qurTzQK
 bZmVwWG8EmZ8RBO/29P/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1XTNh/yEvhM=;umEM4e9pLCW6rRmu83ygWzbmr9t
 K7ZA1bMSABoQsztegHd3KtGei9sEnYZ4zWos904SBH5KpfTIJaOKqmWdgqh/nuBRX3r1PdBHN
 rnCNc9iP57GvT8j/jYbDogAZVBRA70hceZ36LIRKNHUZCHMmG9pKDZyKB8lcrD0uNTN4v+JLQ
 RaLB5JmOHvm+3JIdNnV5wzF2S6fRIwWBEhkraMcJU7gAXCVxz1aHqHvXBKkGsHEvUo3wBHesI
 +rSi2IISBxjxtHWUOyDMVHgH6ygJbBYpBVB5/fsISG+4yBi0OnGgf5b3N8iMd22IgI2L+0s3Q
 ExHRLDfqZ5Qht06S16Xrn5cCz4f53j9lPoPCSvQh3oCBTQYYeMX6Xi9pzsKPrRocQEa7b6JNl
 hN5hyo0QnMZFWTSoGNmfL82tSE+wZAhq2v9IR+FJ/wYm0T/Tnz+UvGzx/RXLSeeDvIEVw5DZ2
 x2K9AeVEpPGfHv4MK6lQ7FGJtAgzzzHVcHHUw7DaMcLMP6JO4Mha7t4cFMm2TjlolzxdF0uid
 TPmUhoXEtvZ5Ms+Zgts4mwACY12RNvmViPICUy0sCm9WVUk+kTUoz0wXZLcujmGGamFvegNyr
 XFYkeQm7OrSvMCOo4We4HG+sjBY6xvKBc2Qs6iRa+enQjGIU3MW43B/MIF66017hQqQlnSkGP
 yg+zmKkVD6D1d6mIewY5sToNrNnjX/WQazpwffOKpVBuFrbWLcMoQvaYXSX52Qkz+2rPCUYel
 oJBhDU8/D8atvKMKWP7zTcJLfGOeXRf9fELDIrCZRxrzrEai8/npuU6cbgArWx1KmvUCWSY/N
 hHzagLuoE8TASVveErV8uju9wh0cs6xny5+E5ZrMone1vcEFmAhh7rE7Lxbw0G7wqeB672hUs
 5hPeTh7LBBfnlmE5YZVKCeVeQemYxl3NVgTCHwPP2ss6sHUF8cOb0OmtmeyvUj/yZ3NkMlHNp
 G75eCNcIi45X3Kbi2skGOYJeF4GUJ3cYp7QApsgoWnfkUO/yoORfAf2LRF06q33Ny/5egxM5U
 SixqNm0imhgJjvSFrFCN+XlNoQ8t/RI8FIihvOWMRsl3ttKOu2oKKBkP6wIf+ZGiKlTg6MU4a
 Ew1nqL/AxYtEfWxpNhRodIGhoe80rE2NxwhAD1AgShYYswrhRGAG0qKv2aK3tlcjUgyMUkl5t
 1zC7lSu923OpeUOGICTL879p0RhaLFlRcrsEJln26kGmnSEE98Iqhh2cxg9aqqGuF0Vgu1v6U
 HNU0iP/eAzB7W5SIeA2rs56qyDGseb/UngKjpn08nzsGILlhRnpm4jXKMmahjCm+tck1hcagk
 0U++AyeosYEcPXLjXCXrEvaj8mZLwiJC/QO7Jkr8Ngx8F7m1JzSP+AMz1zJeotx+iFgw6WbfI
 qWZK7oPYu9tmicN9Oj1FB18prH0+FsW5R8slJf1W96Ud7WOBASqypej6IwTohpbewC2IzX5Yg
 LNmB7sXv6aPjKMxPP5p/3eJNUjKY=

Am 13.03.25 um 19:21 schrieb Rayan Margham:

> Could i have the deb package, I can try to install it.

Alright, the .deb files for both the kernel image and the kernel headers a=
re available here:

	https://nextcloud.thetwins.xyz/s/oatc9DaW5XtiP9E

Thanks,
Armin Wolf

> On Tue, Mar 11, 2025 at 9:53=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 09.03.25 um 13:51 schrieb Rayan Margham:
>>
>>> I=E2=80=99m so sorry I=E2=80=99ve been in a mental health unit for the=
 past month, are you still working on the driver I would love to test anyt=
hing you provide me now
>>>
>>> Bestest regards
>>> Rayan Margham
>> Oh my, i wish you all the best for recovery.
>>
>> Can you compile the current -rc kernel with this patch series applied? =
If no then i can give you a .deb package containing the kernel and the
>> modified acer-wmi driver.
>>
>> Thanks,
>> Armin Wolf
>>
>>>> On 5 Mar 2025, at 00:24, Armin Wolf <W_Armin@gmx.de> wrote:
>>>>
>>>> =EF=BB=BFAm 15.02.25 um 18:45 schrieb Armin Wolf:
>>>>
>>>>> This experimental patch series aims to add fan control support to th=
e
>>>>> acer-wmi driver. The patches are compile-tested only and need to be
>>>>> tested on real hardware to verify that they actually work.
>>>>>
>>>>> I CCed two users who requested support for this feature. I would be
>>>>> very happy if both of you could test those patches and report back.
>>>>>
>>>>> I am ready to help you both with compiling a custom linux kernel for
>>>>> testing this series.
>>>> Any updates from the two people with Acer hardware?
>>>>
>>>> Thanks,
>>>> Armin Wolf
>>>>
>>>>> Changes since v2:
>>>>> - remove duplicate include and replace hwmon_pwm_mode with
>>>>>     hwmon_pwm_enable in second patch
>>>>>
>>>>> Armin Wolf (3):
>>>>>     platform/x86: acer-wmi: Fix setting of fan behavior
>>>>>     platform/x86: acer-wmi: Add fan control support
>>>>>     platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-=
51
>>>>>
>>>>>    drivers/platform/x86/acer-wmi.c | 298 +++++++++++++++++++++++++++=
++---
>>>>>    1 file changed, 273 insertions(+), 25 deletions(-)
>>>>>
>>>>> --
>>>>> 2.39.5
>>>>>
>>>>>

