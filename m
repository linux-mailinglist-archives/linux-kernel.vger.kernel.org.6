Return-Path: <linux-kernel+bounces-234985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1940191CDF7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39CD1F21DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105488626C;
	Sat, 29 Jun 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="V4byZGAC"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7768286A;
	Sat, 29 Jun 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675579; cv=none; b=UQskC26OeNXmwT2ybMdlSjqTPUsuobAmPPIMq857yhBdXqtXBkjh0HfLbmL1Z/iHTD46sZvh8GaB2xXEwJIGwFIuiL/WG6PlxuUZdxrOiVXFCHQzxx3sSAdGLFyJVVZK9GaGM3blUiOnky2p7MvTXVhaSWFzHLHC+QXU3AZo5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675579; c=relaxed/simple;
	bh=e1w7tCSLitbegU/39rbUW0dPY3lV0G8wundqNPTKVuQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QbI3XwVe98WmDubjRdXgZ+Q5/rTTMJycLjJN5QGHe84CViZKfyourWSJda5hZb9UlEV8CLkVmUN7jwdy576f6qEUxuq5rpi8rSOG3T7kb42/ufsa4nrUdtadTozpYt9Hnv8REkv9LBkJJfi0Vg5xHe0/gST3lPruv94fFWm5afQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=V4byZGAC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719675574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waJk0JDcbLWa+5H3B25h3EW4Cq2sMa/N3FgnU9ZkX8E=;
	b=V4byZGACLv04ZtZJX0XW7hDYfYzQyfjHrsAxRhVnWkFGcZgnTvqQ7hsUZA/AUfZfXX68OX
	vvoR5lletgqIyYtMJZ65y7J92czOxX084lEEkSCAAWBhDRu3dr9zRXM/XWJ8WCkBNQzpBp
	rzvZy+UL3RezqvoEJy9V0LB/+6Bmj0gZ3VJh7QwrQqRZZenIzYkqEdxGgWHSYpB0TyozIh
	VFbYYOR997H3SNksm1WlcK/A4V/jb/1Zv51Iyn8hNr1nK7UM7nVO9v8ZXQmK2r0X/o7Gql
	wkTczVVuwjO4zHOazBz7iVFCQFTU0nhKR9WrIPhWkQtlVtn26mo7K6Lh1G+Q3w==
Date: Sat, 29 Jun 2024 17:39:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] arm64: dts: rockchip: Add optional GPU OPP voltage ranges
 to RK356x SoC dtsi
In-Reply-To: <f10d5a3c425c2c4312512c20bd35073c@manjaro.org>
References: <446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org>
 <7679413.EvYhyI6sBW@diego> <f10d5a3c425c2c4312512c20bd35073c@manjaro.org>
Message-ID: <36170f8485293b336106e92346478daa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-29 17:25, Dragan Simic wrote:
> On 2024-06-29 17:10, Heiko Stübner wrote:
>> Am Samstag, 29. Juni 2024, 07:11:24 CEST schrieb Dragan Simic:
>> 
>>> +#ifndef RK356X_GPU_NPU_SHARED_REGULATOR
>> 
>> is there some reason for this duplicating of opps?
>> 
>> The regulator framework should pick the lowest supported voltage
>> anyway, so it seems you're just extending them upwards a bit.
>> 
>> So I really don't so why we'd need to sets here.
> 
> The reason is improved strictness.  Having the exact GPU OPP voltages
> required for the boards whose GPU regulators can provide those exact
> voltages makes it possible to detect misconfigurations much easier,
> just like it was the case with the board dts misconfiguration that
> resulted in the recent DCDC_REG2 patch. [1]
> 
> If we had GPU OPP voltage ranges in place instead, the aforementioned
> issue would probably remain undetected for some time.  It wouldn't be
> the end of the world, :) of course, but the resulting increased power
> consumption isn't one of the desired outcomes.
> 
> [1] 
> https://lore.kernel.org/linux-rockchip/e70742ea2df432bf57b3f7de542d81ca22b0da2f.1716225483.git.dsimic@manjaro.org/

On second thought, after seeing that the RK3399 CPU and GPU OPPs
already specify voltage ranges, I think it would be better to drop
the distinction between the separate strict voltages and the voltage
ranges in this patch, and to add some additional debugging messages
to drivers/opp/of.c that would allow any misconfiguration issues to
be rather easily detected.

>> Also the voltage-range thing makes sense for non-gpu-npu-sharing
>> boards, when the supplying regulator does not fully support the
>> direct single-value voltage.
>> 
>> (rk3399-puma was such a case if I remember correctly)
>> 
>> So I really see no reason for this duplication.
> 
> Perhaps we could rename the RK356X_GPU_NPU_SHARED_REGULATOR macro
> accordingly in the v2, to RK356X_GPU_OPP_VOLTAGE_RANGES, for example,
> with some additional explanations in the patch description and the
> RK356x SoC dtsi file itself.
> 
>>>  		opp-200000000 {
>>>  			opp-hz = /bits/ 64 <200000000>;
>>>  			opp-microvolt = <825000>;
>>> @@ -222,6 +229,37 @@ opp-800000000 {
>>>  			opp-hz = /bits/ 64 <800000000>;
>>>  			opp-microvolt = <1000000>;
>>>  		};
>>> +#else
>>> +		opp-200000000 {
>>> +			opp-hz = /bits/ 64 <200000000>;
>>> +			opp-microvolt = <825000 825000 1000000>;
>>> +		};
>>> +
>>> +		opp-300000000 {
>>> +			opp-hz = /bits/ 64 <300000000>;
>>> +			opp-microvolt = <825000 825000 1000000>;
>>> +		};
>>> +
>>> +		opp-400000000 {
>>> +			opp-hz = /bits/ 64 <400000000>;
>>> +			opp-microvolt = <825000 825000 1000000>;
>>> +		};
>>> +
>>> +		opp-600000000 {
>>> +			opp-hz = /bits/ 64 <600000000>;
>>> +			opp-microvolt = <825000 825000 1000000>;
>>> +		};
>>> +
>>> +		opp-700000000 {
>>> +			opp-hz = /bits/ 64 <700000000>;
>>> +			opp-microvolt = <900000 900000 1000000>;
>>> +		};
>>> +
>>> +		opp-800000000 {
>>> +			opp-hz = /bits/ 64 <800000000>;
>>> +			opp-microvolt = <1000000 1000000 1000000>;
>>> +		};
>>> +#endif /* RK356X_GPU_NPU_SHARED_REGULATOR */
>>>  	};
>>> 
>>>  	hdmi_sound: hdmi-sound {
>>> 
>> 
>> 
>> 
>> 
>> 
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

