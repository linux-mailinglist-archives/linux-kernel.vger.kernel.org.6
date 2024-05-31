Return-Path: <linux-kernel+bounces-198026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959E8D7292
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918831F21B29
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316D2E414;
	Sat,  1 Jun 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="IAoiJYPj"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82628224CC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717282181; cv=none; b=YbCSzXutJ849g9UYwzj2SZ0chsjHCQ5pSlRavGd0SOAtk1u+VWsfOEUZhvSeejxnUb12wnz3aBz+9DSLpQ9SGRQ6xssHfYKbWFOXpZsJwudOWM7OFMuU03cm/A7WL5F0AG7byPxqFBuB2Jn105Ac+T9oXWSwm8CvKGH0doj65Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717282181; c=relaxed/simple;
	bh=Jkb8Hqv95DRnRm/NxgOPNaIghiPJOHpb1eOciF3qDFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epzv7nRyMdAlcvgxJu7z7vFVodREnlri6m6fQ0Jdxq6Pk7NTsrNsSF3hZPuPj5nPDjm126W4x9rYOtlXEwNWpwVKpdcdMnvaE7e2Woqs050aQTwoqeINwCodBc2SJlriXV5Htl0YeQ9k0e81QIrS9YaMpc7izeRbVQRdXCywp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=IAoiJYPj; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1717282140;
 bh=/k1PnOZIBQq7/TC/41KnYN6gtYkoZOfq1Q0coM4QxJ4=;
 b=IAoiJYPjI70b9FQJs5+yPAOaADoe2lOr7mk54a47iJK6LaeVzR2nJkjDq6UjqUQQBh16oLSWp
 OmRJwWHT34EDXPILh1QGR5YjCTwOMH01HciscOIbH3tC6FLs/j5k9D7n3pLWGwoFcbUJQaq5oN7
 VpL5ScVekby+AqKHPUXblKBpcs29IyoO7bkofK8WRfKZt+bUarmEqrnIRSwLEwL6o51DdjatHKw
 9ngdlaRlPFkozI4PqSd2Qy0ugLtd9NlQaHrFsDcOglTKQRqwcJqUYb8/AYRtV+FGGT3hxn3Bu+X
 rm3KRfIibp1Lrn9kcPqcE1genx0e0W02xye8Dlsl8BnQ==
Message-ID: <e4e0c2a4-0d63-434f-ba52-6aaf571e30a5@kwiboo.se>
Date: Sat, 1 Jun 2024 01:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
To: Alexey Charkov <alchark@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
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
 <CABjd4YxdM+cM+z7ou3=DF2SrFM0235DSTZ45o0NsKBwGrgW8Bg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CABjd4YxdM+cM+z7ou3=DF2SrFM0235DSTZ45o0NsKBwGrgW8Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 665a5e1290b1ee9784da9536

Hi Alexey,

On 2024-05-31 13:44, Alexey Charkov wrote:
> Hi Jonas,
> 
> On Fri, May 31, 2024 at 3:27 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey and Dragan,
>>
>> On 2024-05-30 21:31, Dragan Simic wrote:
>>> Hello Alexey,
>>>
>>
>> [snip]
>>
>>>>>>> That way we'll have no roadblocks if, at some point, we end up with
>>>>>>> having
>>>>>>> different OPPs defined for the RK3588 and the RK3588S variants.  Or
>>>>>>> maybe
>>>>>>> even for the RK3582, which we don't know much about yet.
>>>>>>
>>>>>> Guess we'll deal with that one once we stumble upon an actual RK3582
>>>>>> board out in the wild and heading to the mainline kernel tree :)
>>>>>
>>>>> Of course, that was just an example for the future use.
>>>>
>>>> In fact, I've just discovered that Radxa has recently released Rock 5C
>>>> Lite which is based on RK3582, and starts at just $29 for the 1GB
>>>> version, making it interesting for tinkering. Especially given that
>>>> its GPU, one of the big-core clusters and one of the VPU cores seem to
>>>> be disabled in software (u-boot) rather than in hardware, which means
>>>> there is some chance that a particular SoC specimen would actually
>>>> have them in a working condition and possible to re-enable at no cost.
>>>> Ordered myself one to investigate :)
>>>
>>> Yes, I also saw the RK3582-based ROCK 5C Lite a couple of days ago. :)
>>> It seems that the disabled IP blocks are detected as defective during
>>> the manufacturing, which means that they might work correctly, or might
>>> actually misbehave.  It seems similar to the way old three-core AMD
>>> Phenom II CPUs could sometimes be made quad-core.
>>>
>>
>> I can confirm that the RK3582 include ip-state in OTP indicating
>> unusable cores, any unusable cpu core cannot be taken online and stalls
>> Linux kernel a few extra seconds during boot.
>>
>> Started working on a patch for U-Boot to remove any broken cpu core
>> and/or cluster nodes, similar to what vendor U-Boot does, adopted to
>> work with a mainline DT for RK3588.
> 
> Superb - it's great to have a patch for it already, thank you for working on it!
> 
>> On one of my ROCK 5C Lite board one of the cpu cores is unusable, U-Boot
>> removes the related cpu cluster nodes. On another ROCK 5C Lite board one
>> rkvdec core is only marked unusable and all cpu cores can be taken
>> online, U-Boot does nothing in this case. Guessing we should apply
>> similar policy as vendor U-Boot and disable cores anyway.
> 
> Is there any misbehavior / instability if you just keep all the
> unmarked cores online?

I will run some tests during the weekend and get back with results later.

> 
> I think from an end-user perspective it would be better to just enable
> everything that works, as the reason to unconditionally disable some
> IP blocks even when they are "good" is quite likely not a technical
> one but rather a marketing one. It's hard to justify selling chips
> with different sets of working IP blocks under the same label and the
> same price, making it easier to just trim them all to a lowest common
> denominator. On the other hand, once a person has already bought a
> device where some IP blocks work even if they are not supposed to, why
> not make use of them? It costs nothing, hurts noone...

I agree, it is probably more related to marketing, licensing and/or
what is tested.

Vendor U-Boot apply following logic/policy for rk3582 (and rk3583).

RK3582 policy:
- always remove gpu
- always remove both rkvdec cores
- remove bad rkvenc core, if both are normal, remove rkvenc1 anyway

RK3583 policy:
- always keep gpu
- remove bad rkvdec core, if both are normal, remove rkvdec1 anyway
- remove bad rkvenc core, if both are normal, remove rkvenc1 anyway

CPU core policy:
- remove both cores within a cluster having a bad core
- if core4~7 are all normal, remove core6 and core7 anyway

Regards,
Jonas

> 
> Best regards,
> Alexey


