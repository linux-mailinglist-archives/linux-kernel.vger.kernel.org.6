Return-Path: <linux-kernel+bounces-197585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96B8D6CCE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4631F237B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B284E0D;
	Fri, 31 May 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="eluFq7dW"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BB8287C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717197322; cv=none; b=Fz8Zg2PAcPWZxhD8UzKd1YTzJFq800ZFAr7Duo2Zkdk6OlPIsHE+3zplHxdzDE7UaXDznfbyDDvkLnDg7w2AIpiH7AmkxT6ei9FYPMf6stM7lDTpRpKawYIgD+LTnkF1uwWxEdro4w9jABrNE6IjmK4cqjP2FMOL729x3lwvVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717197322; c=relaxed/simple;
	bh=ZEP4WV2Hz3N7FDd90cgmwrRwy533OH85Lf+6xaB9wqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEcT4QguxHq29ReIrZb5q6lmVHZiJUG2lScNd/PsWKHfCiN4Xk1TIRfyO2AVHC8jvIGhxhwfoxm12k2TpPOuYhpGc2JlFWGXvYJx7E3p0+iWJxumi2kaj/CMHElUsvu0zNRzzrcJshJT77CbWM/aIFh/Xk7H+i2Zb6C0ZqYIbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=eluFq7dW; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1717197310;
 bh=NT5VlfpAzQy5RqRKCg0k7PinYB0pq9c+JH44HfHvY7g=;
 b=eluFq7dWDBPkW+exCejdkAN4T+k2Y9LF/M8JHAC2ell/udmPgto3k/ewXzaafSlaa5EGEGY4+
 QZe1o426QDPplYp3Hw1+4UTC1zuLAKb4s06xn7ke5zNoprAk8wogymAERT/AhwrIzJkdijiD/Y6
 m43Z0asJr2R1xJKf4R35tjNUgTdF+znt4+U6ic/8rtOpCe5B0y9YzW68gsVzMpBod84zzMFep+n
 etLENzhCsIgcLWXnS4Mo5Ug/PYrXFJ2DHjo+MsbY/zt4owuMqmjgkIyRRPEcpZWXoY/rmuBabWS
 oibkrfBV+Yd7gsA1QNHdm2wXX5KEUXZORKWbp8PtkmOw==
Message-ID: <33ee8446-aa01-47df-8e20-5ae2d384ed0e@kwiboo.se>
Date: Sat, 1 Jun 2024 01:15:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, wens@kernel.org, daniel.lezcano@linaro.org,
 didi.debian@cknow.org, krzysztof.kozlowski+dt@linaro.org,
 viresh.kumar@linaro.org
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org>
 <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
 <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
 <82db817a908b761d8c3d73ea04714314@manjaro.org>
 <607f4da8-99b2-4379-9567-4bfd2744eab3@kwiboo.se>
 <66677077acf4e970444cea829436fd0a@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <66677077acf4e970444cea829436fd0a@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 665a59fe0b82eeef13908f0a

Hello Dragan,

On 2024-05-31 23:24, Dragan Simic wrote:
> Hello Jonas,
> 
> On 2024-05-31 13:27, Jonas Karlman wrote:
>> On 2024-05-30 21:31, Dragan Simic wrote:
>> [snip]
>>
>>>>>>> That way we'll have no roadblocks if, at some point, we end up 
>>>>>>> with
>>>>>>> having
>>>>>>> different OPPs defined for the RK3588 and the RK3588S variants.  
>>>>>>> Or
>>>>>>> maybe
>>>>>>> even for the RK3582, which we don't know much about yet.
>>>>>>
>>>>>> Guess we'll deal with that one once we stumble upon an actual 
>>>>>> RK3582
>>>>>> board out in the wild and heading to the mainline kernel tree :)
>>>>>
>>>>> Of course, that was just an example for the future use.
>>>>
>>>> In fact, I've just discovered that Radxa has recently released Rock 
>>>> 5C
>>>> Lite which is based on RK3582, and starts at just $29 for the 1GB
>>>> version, making it interesting for tinkering. Especially given that
>>>> its GPU, one of the big-core clusters and one of the VPU cores seem 
>>>> to
>>>> be disabled in software (u-boot) rather than in hardware, which means
>>>> there is some chance that a particular SoC specimen would actually
>>>> have them in a working condition and possible to re-enable at no 
>>>> cost.
>>>> Ordered myself one to investigate :)
>>>
>>> Yes, I also saw the RK3582-based ROCK 5C Lite a couple of days ago. :)
>>> It seems that the disabled IP blocks are detected as defective during
>>> the manufacturing, which means that they might work correctly, or 
>>> might
>>> actually misbehave.  It seems similar to the way old three-core AMD
>>> Phenom II CPUs could sometimes be made quad-core.
>>
>> I can confirm that the RK3582 include ip-state in OTP indicating
>> unusable cores, any unusable cpu core cannot be taken online and stalls
>> Linux kernel a few extra seconds during boot.
> 
> Thanks for this confirmation!
> 
>> Started working on a patch for U-Boot to remove any broken cpu core
>> and/or cluster nodes, similar to what vendor U-Boot does, adopted to
>> work with a mainline DT for RK3588.
> 
> Nice, thanks for working on that. :)
> 
>> On one of my ROCK 5C Lite board one of the cpu cores is unusable, 
>> U-Boot
>> removes the related cpu cluster nodes. On another ROCK 5C Lite board 
>> one
>> rkvdec core is only marked unusable and all cpu cores can be taken
>> online, U-Boot does nothing in this case. Guessing we should apply
>> similar policy as vendor U-Boot and disable cores anyway.
> 
> Just checking, you're referring to disabling the rkvdec core only,
> for the latter case?

No, the vendor U-Boot will remove cluster2 if no cpu core is bad.

RK3582 policy:
- always remove gpu node
- always remove both rkvdec nodes
- remove bad rkvenc node, if both are normal, remove rkvenc1 anyway

RK3583 policy:
- remove bad rkvdec node, if both are normal, remove rkvdec1 anyway
- remove bad rkvenc node, if both are normal, remove rkvenc1 anyway

CPU core policy:
- remove both cores within a cluster having a bad core
- if core4~7 are all normal, remove core6 and core7 anyway

Regards,
Jonas

> 
>> Following commit contains early work-in-progress and some debug output.
>>
>> https://github.com/Kwiboo/u-boot-rockchip/commit/8cdf606e616baa36751f3b4adcfaefc781126c8c
>>
>> Booting ROCK 5C Lite boards using U-Boot generic-rk3588_defconfig:
>>
>> ROCK 5C Lite v1.1 (RK3582 with 1 bad cpu core):
>>
>>   cpu-code: 3582
>>   cpu-version: 08 10
>>   data: fe 21
>>   package: 11
>>   specification: 01
>>   ip-state: 10 00 00
>>   bad-state: cpu core 4
>>
>> ROCK 5C Lite v1.1 (RK3582 with 1 bad rkvdec core):
>>
>>   cpu-code: 3582
>>   cpu-version: 08 00
>>   data: fe 21
>>   package: 11
>>   specification: 01
>>   ip-state: 00 80 00
>>   bad-state: rkvdec core 1
> 
> Thanks again for these nice details!


