Return-Path: <linux-kernel+bounces-195740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4558D512A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687391F2214F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167447A58;
	Thu, 30 May 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R5oBB0t/"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61446556;
	Thu, 30 May 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090895; cv=none; b=p1RgvSmqBWeYFMoXCjCfO1SJWCOiAXdlC6OvHg5Z2xrfYJywQsjrbL6a6yc2oXPoIqy+GSvksFoXDgym6X6xuD5S3SS7ZmePHNQUY0ULM1kI2mmG53voZDexafYZ0z+gRx6rBzjLgCo7wEItoReuKb5htsMIVQQEXq7AhL6Cg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090895; c=relaxed/simple;
	bh=PN12H3vukIEUvh92k02PFG+Hv5AE+f0Wb7EmKyT6t+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJ1QpmYi8K1pHSrZw11XL4MHBBAdrPaZkKYh+fr9Vy3m7qvVPmn6OmsNBTz+3Ye1ObiLojfZWHUzFGCjVkSSDMKc8yi7I6pWGAHzy55xqQffnfOFRnzi1V+IwW1ER+JmK55JkvC9qAK2y0G/d2WM7Sl0he76YJROn1mIboXWD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R5oBB0t/; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717090861; x=1717695661; i=w_armin@gmx.de;
	bh=PN12H3vukIEUvh92k02PFG+Hv5AE+f0Wb7EmKyT6t+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R5oBB0t//IvSpkl7HJ2NoPH46s2VOu8fbNZn2ybZ4BTCZQqAbKQuasdUd1RC3XZ6
	 T1f/sbjSJAHaS1aMLomARyE3jZdDtyj1XDxbMwLmqNr5mityZo0WfH9EledvB4zK0
	 1EzcB8SzafP4dyi7OcB6XMFXrHELUQtMhSNQ+RYhxU9+H47cIpP7pzJ6WSGGiZPIe
	 0aw/8/B3QTlBZ9JNiXpF4UjRukY8A4bKMw5XAKPFctXI2K3hZn6TgZeVPRwUV6jd6
	 zQooaxHvQ0XEFtJuT0ZkcQobcMY7tFxh1eFry2HGIj1/wdINLnlXawsATv6aNaftB
	 tUF8RLuyUv6005hi5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1swDON03ZW-00jn0W; Thu, 30
 May 2024 19:41:01 +0200
Message-ID: <78c58496-78b2-48a5-b5df-74545fd58dc3@gmx.de>
Date: Thu, 30 May 2024 19:41:00 +0200
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
 <6f1ffb83-a64f-469d-b981-f0da0d2f02ac@gmx.de>
 <b8aa563a-5ca1-4624-a1c7-25744f15cfa9@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b8aa563a-5ca1-4624-a1c7-25744f15cfa9@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:50jYUZgJk05eSRj+dxdH12Nn8+NWXvjBbT/6mYeS+B5sN6BYufr
 rIe1hkHMideIRM91OMvZX5lV2zKwvkEDEHQBc5/lmZJ2InBeakTFzxS//fBPOG68jxRBZh3
 TKaCoVn9Jy5cZXAk0Um3VMqobFRVxJVBb67KL1WNTyOrEYu50hJjPqTnw0BZrJtrRL2xTq0
 RuF+T3T2uaryUM9Yb+ieg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lRtdwUgQvfo=;TKo1J+5irFvECnFjnhSYXPepOyf
 LTJOtA+Lj+KwmxVUPzIfTkxgAqFwP8yHG8zRCBu79R9mTOb+X2/PL7E4DMTiVq6DYzrexC83y
 eF6rpzWjz/hADw0O7zN433KD82XlZ+gm4LcGU0s3s23hu83XFKE88amr0GytEZjMQ0sxX5Knr
 1P1ggI4Ew72hD3pBlAuJHIuLhVnkyIuXF7jbeMRECQ5TmWDGIeXDXpVpX5Lc5Kuzo9HisJtRJ
 eRulCFM2DHXglDizy8o3vcwzOSZO6++rG4FMAr0BwxC+R3P+/+fES/6x2pBMxqEvPM7S2qK6i
 xF2d+mUPuloLrdwkq8lwAf82wXS8B3WxKWmomCgoYPZ28eEZXSaZo8kROsxDhcONgh/9XoW5J
 YRO2uJnZz2IW057AjqayYPH1VgCrVIOb3gjHIyQMkx6iPCB1kOtuebOIp7Q1ZG99Y5v+L3JVe
 jth4sIX10GCUATMUwOXqMJ4JiiicBOuuOR41hvbkoJKA/1wxq3qkpdlsUs7K7EbvY2/3cm6tT
 ApG5bIKrGGimXdzW6QWqSG17uE4Iy2QvatgoA/snJPYtH8a/aSgNETsI7mVzV3NhHTBo7Cnbg
 gNu12BmA7HujxUyKSAC5E367/47sDVem2Bta2lLM/0XsTpcYw1DrLhACiU4sZzLU9H0BBkVq0
 12HRuiA2zFhcppU7dt8LDlmJtq+g7tVJuqCgLQu4RrOQHWwNKaLIvQ8DzKWamdqkMKx+XlIZP
 2gdoeiEqhNbkcI0m50TPmdX2eAlMm17feLoeAPUjBR5+BEFUsvZdPQRq+sZZL+86sGwMq4u4e
 4Q84OS/JAQoEIjWFCYVmKZ0FGVwvAQidTIx3PWqLVaytQ=

Am 30.05.24 um 19:33 schrieb Guenter Roeck:

> On 5/30/24 10:03, Armin Wolf wrote:
>> Am 29.05.24 um 22:52 schrieb Guenter Roeck:
>>
> [ ... ]
>
>>> +
>>> +temp1_lcrit_alarm=C2=A0=C2=A0=C2=A0 Temperature low critical alarm
>>> +temp1_min_alarm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Temperature=
 low alarm
>>> +temp1_max_alarm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Temperature=
 high alarm
>>> +temp1_crit_alarm=C2=A0=C2=A0=C2=A0 Temperature critical alarm
>>
>> Maybe it would be a good idea to tell users that the alarm attributes
>> are sticky.
>>
>
> The driver auto-clears them after read, so they are only sticky in the
> sense
> that they will remain active until read. This is quite common for
> hardware
> monitoring devices. However, sure, I'll add a note.
>
> [ ... ]
>
>>> +static int spd5118_write_enable(struct regmap *regmap, u32 attr,
>>> long val)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (val && val !=3D 1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return regmap_update_bits(regmap, SPD5118_REG_TEMP=
_CONFIG,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPD5118_TS_DISABLE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val ? 0 : SPD5118_TS_DISABLE);
>>
>> The spd5118 spec says that we have to wait 10ms after enabling the
>> sensors before
>> we start reading temperature values, maybe we need a delay + locking
>> here?
>>
>
> I don't think that would add much if any value but a lot of complexity
> for little gain. I find it acceptable that the sensor returns 0 for a
> few ms
> after enabling it. Pretty much all chips have the same problem, so I am
> really not concerned about it.
>
>>> +
>>> +static struct i2c_driver spd5118_driver =3D {
>>> +=C2=A0=C2=A0=C2=A0 .class=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D I2C_CLASS_HWMON,
>>> +=C2=A0=C2=A0=C2=A0 .driver =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =
=3D "spd5118",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .of_match_table =3D spd511=
8_of_ids,
>>
>> The driver is missing suspend support, without it hibernation/S4
>> sleep will cause the
>> limit and config registers to be out of sync with the regmap cache.
>>
>
> Good point. Do you have a means to test this if I add suspend support ?
> I have not been able to figure out how to put my system into suspend.
>
> Thanks,
> Guenter
>
I think so, at least i can verify if S3 sleep works, but S4 sleep should w=
ork fine too.

Thanks,
Armin Wolf


