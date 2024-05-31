Return-Path: <linux-kernel+bounces-197503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641C8D6B80
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E791D1F286EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BE78C9C;
	Fri, 31 May 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lY00Jlkh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D811CAA6;
	Fri, 31 May 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190705; cv=none; b=J+A1tsDxQskyjMmP3FZ+zsbK07cm+7cMAsguoIznp+c0MwRd/HimvhvNuqyQX/EMceT5Qnz4l01lZD8Sc0IZsc/u+m47UXvSLa6CUNSfUcxMGkKAPc/DZ2PNGP+zBnAs8mB6+gue8AtGytGfKPSmOnNj4+iRZW7oWGs7xaXuThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190705; c=relaxed/simple;
	bh=VF5huSIXEGspnsYcYrVm6cTWXK90solzuMmSiSuO6uY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BDTtXj3kVPqMGEgG+QPcs2ZYAen4gjF9mefPpv9sh1nM6YJFaHa1IMo31Uayn65swX4SmzYNhL0sr0d3PgsL+oTPXfGj8ZTKDNkYb7qacpjl5I1jvRckskmi3LHbisW+kJPYsSjodjEXKfoLJDTiRDXu9CaJaxUHQPL/ub+l73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lY00Jlkh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717190694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jww2qZI1db4LLxX4ddTJs3O/960dbOvvlMlYQYu9OhE=;
	b=lY00JlkhEeFaQAD6/CPV34Box50rDsxRCnJhPcrckinMIimIB2a+vL0dC2/10rznzsFNTM
	HpicKiI70a8tubn7YogGYe4aVV5iJY4gMVHOA1kLWpzW6RfkpjWioyrZ+pN0dMdDjbT1hi
	0scxBkRlDJ7B5znOVfryeCtRcBd4CvvWJNDkZB6Rk/u34Ep/9jtkFXWGRIE07Dp5JTlJvC
	BpZvNk6Xwu11785eyHPD7KUmyNxwlUNKy57BXqr53H/h1f3sEhC2E+fiFQvzrg8Tm7wi9n
	QsgiyHgZ2FP8zCwMTuRfnEytkZJU6SVZAYW4ItOHwVAlYZdzEtayK4AV5yvuTg==
Date: Fri, 31 May 2024 23:24:53 +0200
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
In-Reply-To: <607f4da8-99b2-4379-9567-4bfd2744eab3@kwiboo.se>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org>
 <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
 <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
 <82db817a908b761d8c3d73ea04714314@manjaro.org>
 <607f4da8-99b2-4379-9567-4bfd2744eab3@kwiboo.se>
Message-ID: <66677077acf4e970444cea829436fd0a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas,

On 2024-05-31 13:27, Jonas Karlman wrote:
> On 2024-05-30 21:31, Dragan Simic wrote:
> [snip]
> 
>>>>>> That way we'll have no roadblocks if, at some point, we end up 
>>>>>> with
>>>>>> having
>>>>>> different OPPs defined for the RK3588 and the RK3588S variants.  
>>>>>> Or
>>>>>> maybe
>>>>>> even for the RK3582, which we don't know much about yet.
>>>>> 
>>>>> Guess we'll deal with that one once we stumble upon an actual 
>>>>> RK3582
>>>>> board out in the wild and heading to the mainline kernel tree :)
>>>> 
>>>> Of course, that was just an example for the future use.
>>> 
>>> In fact, I've just discovered that Radxa has recently released Rock 
>>> 5C
>>> Lite which is based on RK3582, and starts at just $29 for the 1GB
>>> version, making it interesting for tinkering. Especially given that
>>> its GPU, one of the big-core clusters and one of the VPU cores seem 
>>> to
>>> be disabled in software (u-boot) rather than in hardware, which means
>>> there is some chance that a particular SoC specimen would actually
>>> have them in a working condition and possible to re-enable at no 
>>> cost.
>>> Ordered myself one to investigate :)
>> 
>> Yes, I also saw the RK3582-based ROCK 5C Lite a couple of days ago. :)
>> It seems that the disabled IP blocks are detected as defective during
>> the manufacturing, which means that they might work correctly, or 
>> might
>> actually misbehave.  It seems similar to the way old three-core AMD
>> Phenom II CPUs could sometimes be made quad-core.
> 
> I can confirm that the RK3582 include ip-state in OTP indicating
> unusable cores, any unusable cpu core cannot be taken online and stalls
> Linux kernel a few extra seconds during boot.

Thanks for this confirmation!

> Started working on a patch for U-Boot to remove any broken cpu core
> and/or cluster nodes, similar to what vendor U-Boot does, adopted to
> work with a mainline DT for RK3588.

Nice, thanks for working on that. :)

> On one of my ROCK 5C Lite board one of the cpu cores is unusable, 
> U-Boot
> removes the related cpu cluster nodes. On another ROCK 5C Lite board 
> one
> rkvdec core is only marked unusable and all cpu cores can be taken
> online, U-Boot does nothing in this case. Guessing we should apply
> similar policy as vendor U-Boot and disable cores anyway.

Just checking, you're referring to disabling the rkvdec core only,
for the latter case?

> Following commit contains early work-in-progress and some debug output.
> 
> https://github.com/Kwiboo/u-boot-rockchip/commit/8cdf606e616baa36751f3b4adcfaefc781126c8c
> 
> Booting ROCK 5C Lite boards using U-Boot generic-rk3588_defconfig:
> 
> ROCK 5C Lite v1.1 (RK3582 with 1 bad cpu core):
> 
>   cpu-code: 3582
>   cpu-version: 08 10
>   data: fe 21
>   package: 11
>   specification: 01
>   ip-state: 10 00 00
>   bad-state: cpu core 4
> 
> ROCK 5C Lite v1.1 (RK3582 with 1 bad rkvdec core):
> 
>   cpu-code: 3582
>   cpu-version: 08 00
>   data: fe 21
>   package: 11
>   specification: 01
>   ip-state: 00 80 00
>   bad-state: rkvdec core 1

Thanks again for these nice details!

