Return-Path: <linux-kernel+bounces-197595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED08D6CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213231C22DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726C12F5A0;
	Fri, 31 May 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZOGwrFSs"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967D12F5B8;
	Fri, 31 May 2024 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198793; cv=none; b=P093EDzxdysDLKpf1CwsYLO6kj/IurtQ3/8OLQiYMqzY9013tzbM2NWGC/j6qgt1ydDHSRcGyO9clDPW14eNkRAAUA4R4ljmf7YMvv3jGsVUcbN3CZhK9UcWNvj+ubPNHj+NdpUrDwsuuzuB47wjp6zM3xbo4CeQqPJp11Favds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198793; c=relaxed/simple;
	bh=+B3B1B+g8fE8BJ8TASgPdm+uogD9ZfQaE+9ND0gv1pI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P6J4wCTIeALieCapeFQHorubRR160YEFhYZ4hr1qNFpq0I4ac6q7mzDplZkYgfQT+dqH9CqLFy02cguzewz2jmVyPUH8fZMgd5SOrL9BwbuHItwR8eNc7BTlYGMBa5bhcX3kChE5Qq2G+0nKgZ9aTjwD0Y7BBcDmH5RZH456gUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZOGwrFSs; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717198788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kc8wjIrdYAxjt7EjGwSxy0E0ldbUq9FWdaX7wPmdMFk=;
	b=ZOGwrFSsE9140iRXKfuif9Lont71yZB0NhWcJvuZT5imXE7nlQrHys0tXYG4QEJy94qouu
	GoeV2faCN8ClwwFWZpFobR+U3t45f4wYEIJ/OQuM6L7MOcICjOrYqt7jl+pIvQ2gLTIxKR
	XO0gVylzWUQVGIU2r/FxPRZq7uXZUcJd9kk9UQJAwlNAq4G6pofSfZquYn9ZD6sJdg/clY
	06GQwX8Qa+tPKqf4no/i4FxZtmn0EDm/LYYMx3CtdOS6ovidVWWY9iChB3VYRy4xPphAqo
	HLo4mx0sNMc7s37LKs/Kv6hbDUtUFfsyeuEJionhX2Tc6+aNXBcKWAMzjrQ2tQ==
Date: Sat, 01 Jun 2024 01:39:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 wens@kernel.org, daniel.lezcano@linaro.org, didi.debian@cknow.org,
 krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
In-Reply-To: <33ee8446-aa01-47df-8e20-5ae2d384ed0e@kwiboo.se>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org>
 <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
 <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
 <82db817a908b761d8c3d73ea04714314@manjaro.org>
 <607f4da8-99b2-4379-9567-4bfd2744eab3@kwiboo.se>
 <66677077acf4e970444cea829436fd0a@manjaro.org>
 <33ee8446-aa01-47df-8e20-5ae2d384ed0e@kwiboo.se>
Message-ID: <82301b2c4effe105e7238f6c3e3ffc8f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-01 01:15, Jonas Karlman wrote:
> On 2024-05-31 23:24, Dragan Simic wrote:
>> On 2024-05-31 13:27, Jonas Karlman wrote:
>>> On 2024-05-30 21:31, Dragan Simic wrote:
>>> [snip]
>>> 
>>>>>>>> That way we'll have no roadblocks if, at some point, we end up
>>>>>>>> with
>>>>>>>> having
>>>>>>>> different OPPs defined for the RK3588 and the RK3588S variants.
>>>>>>>> Or
>>>>>>>> maybe
>>>>>>>> even for the RK3582, which we don't know much about yet.
>>>>>>> 
>>>>>>> Guess we'll deal with that one once we stumble upon an actual
>>>>>>> RK3582
>>>>>>> board out in the wild and heading to the mainline kernel tree :)
>>>>>> 
>>>>>> Of course, that was just an example for the future use.
>>>>> 
>>>>> In fact, I've just discovered that Radxa has recently released Rock
>>>>> 5C
>>>>> Lite which is based on RK3582, and starts at just $29 for the 1GB
>>>>> version, making it interesting for tinkering. Especially given that
>>>>> its GPU, one of the big-core clusters and one of the VPU cores seem
>>>>> to
>>>>> be disabled in software (u-boot) rather than in hardware, which 
>>>>> means
>>>>> there is some chance that a particular SoC specimen would actually
>>>>> have them in a working condition and possible to re-enable at no
>>>>> cost.
>>>>> Ordered myself one to investigate :)
>>>> 
>>>> Yes, I also saw the RK3582-based ROCK 5C Lite a couple of days ago. 
>>>> :)
>>>> It seems that the disabled IP blocks are detected as defective 
>>>> during
>>>> the manufacturing, which means that they might work correctly, or
>>>> might
>>>> actually misbehave.  It seems similar to the way old three-core AMD
>>>> Phenom II CPUs could sometimes be made quad-core.
>>> 
>>> I can confirm that the RK3582 include ip-state in OTP indicating
>>> unusable cores, any unusable cpu core cannot be taken online and 
>>> stalls
>>> Linux kernel a few extra seconds during boot.
>> 
>> Thanks for this confirmation!
>> 
>>> Started working on a patch for U-Boot to remove any broken cpu core
>>> and/or cluster nodes, similar to what vendor U-Boot does, adopted to
>>> work with a mainline DT for RK3588.
>> 
>> Nice, thanks for working on that. :)
>> 
>>> On one of my ROCK 5C Lite board one of the cpu cores is unusable,
>>> U-Boot
>>> removes the related cpu cluster nodes. On another ROCK 5C Lite board
>>> one
>>> rkvdec core is only marked unusable and all cpu cores can be taken
>>> online, U-Boot does nothing in this case. Guessing we should apply
>>> similar policy as vendor U-Boot and disable cores anyway.
>> 
>> Just checking, you're referring to disabling the rkvdec core only,
>> for the latter case?
> 
> No, the vendor U-Boot will remove cluster2 if no cpu core is bad.
> 
> RK3582 policy:
> - always remove gpu node
> - always remove both rkvdec nodes
> - remove bad rkvenc node, if both are normal, remove rkvenc1 anyway
> 
> RK3583 policy:
> - remove bad rkvdec node, if both are normal, remove rkvdec1 anyway
> - remove bad rkvenc node, if both are normal, remove rkvenc1 anyway
> 
> CPU core policy:
> - remove both cores within a cluster having a bad core
> - if core4~7 are all normal, remove core6 and core7 anyway

Thanks for the clarification.  Though, what's RK3583, is there
really another SoC variant?  I've heard only about the RK3582.

I think that the upstream U-Boot policy should be to follow closely
what the OTP data says about unusable portions of the SoC.  IOW, just
disable what OTP specifically says to be unusable, exactly as Alexey
already proposed. [1]

Though, the disabling of the GPU and the rkvdec would be an exception
to the "disable only what OTP says" rule, but that could be justified
by the absence of the related OTP data.

[1] 
https://lore.kernel.org/linux-rockchip/CABjd4YxdM+cM+z7ou3=DF2SrFM0235DSTZ45o0NsKBwGrgW8Bg@mail.gmail.com/

>>> Following commit contains early work-in-progress and some debug 
>>> output.
>>> 
>>> https://github.com/Kwiboo/u-boot-rockchip/commit/8cdf606e616baa36751f3b4adcfaefc781126c8c
>>> 
>>> Booting ROCK 5C Lite boards using U-Boot generic-rk3588_defconfig:
>>> 
>>> ROCK 5C Lite v1.1 (RK3582 with 1 bad cpu core):
>>> 
>>>   cpu-code: 3582
>>>   cpu-version: 08 10
>>>   data: fe 21
>>>   package: 11
>>>   specification: 01
>>>   ip-state: 10 00 00
>>>   bad-state: cpu core 4
>>> 
>>> ROCK 5C Lite v1.1 (RK3582 with 1 bad rkvdec core):
>>> 
>>>   cpu-code: 3582
>>>   cpu-version: 08 00
>>>   data: fe 21
>>>   package: 11
>>>   specification: 01
>>>   ip-state: 00 80 00
>>>   bad-state: rkvdec core 1
>> 
>> Thanks again for these nice details!

