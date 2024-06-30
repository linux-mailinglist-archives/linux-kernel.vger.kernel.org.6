Return-Path: <linux-kernel+bounces-235206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF191D18F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AD61C21147
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263113C819;
	Sun, 30 Jun 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xijdSS3a"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893391E878;
	Sun, 30 Jun 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719749103; cv=none; b=D+kjd13S3dYMd00L6fRIJ/gfIdSdc80iV5hnRQxJA1/CW5Vzjgy3oR41qRAe6oqT4roj48FCGMwbWpQDj5qM+ut+16LaqM/KgTXuYSw4hEcv2IG/rokfuCWXrOIH0+7T+dZGLF9SBMSInah/xMTmkKMOOgz8+NKzCfHAZZusOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719749103; c=relaxed/simple;
	bh=ZGeCkR4eyTZzDu74/Z9/uMzS9VCgO3vqz79Y8FXSUw0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fAb2dmnA4EUw+EDUJ7qVAcwLuuWOw3sqxgbkQaCDqsmJll/F5vHbQ8DHlOE8kgVL8qS1Jq8rlc0iKso6dkPHX484wZp8xK5dnGUL+JaypswfaVnOG+xEcC5fylPux+FjAznSyKaLDa5t+P8hiFXgcoN8K9+uzWGBduEbKEGoDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xijdSS3a; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719749090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFDAT09nN49Spp46jcoBUcRUG83635qOZGI6QRXikpo=;
	b=xijdSS3akntF2fpE3PdMZh3GNMO6DX61vCUYCAoN0tFC89r1D3dgt9kEdGGe9tFjf98yKq
	7hnO+UNGmTIhU9ANjl14VBsd0uf6d8CjMQqIQksul6YiX89oX1LvnjrimgWEdGrfIKEDSf
	yvwFRYyy+2OIA+FbxIrkMxKiB43i9WFn0U49sAUBbupGm3z4C5iVmbVUHCc2LHictkLJm5
	VjPKeXK+yhZl7Ksg9TrXb0EKnSiXMexw0z1m+QJyKG9DqvoCOp9z6ui+1B0ZbWuy1vjpKn
	5HqDVetACiLsE2pWWIlJmTt8flFvcQlQSrNVzqQYt7Wh3DXeqcUU9gSp0vxzEQ==
Date: Sun, 30 Jun 2024 14:04:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add GPU OPP voltage ranges to
 RK356x SoC dtsi
In-Reply-To: <2442162.AJoTavkB1d@bagend>
References: <bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org>
 <2442162.AJoTavkB1d@bagend>
Message-ID: <b8951ac4e29184fa35919c6ab85b8f87@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-06-30 00:01, Diederik de Haas wrote:
> On Saturday, 29 June 2024 18:39:02 CEST Dragan Simic wrote:
>> Add support for voltage ranges to the GPU OPPs defined in the SoC dtsi 
>> for
>> RK356x.  These voltage ranges are useful for RK356x-based boards that 
>> are
>> designed to use the same power supply for the GPU and NPU portions of 
>> the
>> SoC, which is described further in the following documents:
>> 
>>   - Rockchip RK3566 Hardware Design Guide, version 1.1.0, page 37
>>   - Rockchip RK3568 Hardware Design Guide, version 1.2, page 78
> 
> That was interesting to read, thanks.
> Now I understand the difference between rk809(-5) and rk817(-5).

I'm glad it was useful. :)

> But AFAIUI the above description described why there were separate 
> tables for
> rk809 and rk817 in v1. But that was dropped in v2. So it seems to me 
> the
> (commit) message should be updated accordingly?

I also thought about removing that description in the v2, but it 
actually
doesn't hurt to provide an example of what the GPU OPP voltage ranges 
are
useful for.

> I also expected that (for v1) there would be a similar construct as was
> recently added for rk3588. But I should interpret Heiko's comments as 
> that
> strategy should not be applied to rk356x?

The trouble with applying the same strategy, which was the initial plan
for the v1, is that the need for voltage ranges depends on one of the 
board
features, i.e. the GPU and NPU voltage regulators.  As such, it still 
has
to affect the RK356x SoC dtsi, which may warrant separate 
rk356x-gpu-range.dtsi,
for example, but the troubles would arise later if we had another 
similar
dtsi variant, because we'd then have to split the SoC dtsi into four 
variants,
which would hardly be warranted or sustainable.

That's why the v1 went with a macro instead.  However, there are already
numerous unresolved examples of what that macro tries to solve in the 
RK3399
SoC dtsi files, so the conclusion was that we need a more systemic 
solution,
which will be the upcoming debugging facilities in the OPP handling.  
Those
facilities will allow us to detect possible issues with the 
misconfigured
DT voltages on all SoCs and boards, which the v1 macro would have solved 
in
another way, but only for the RK356x.

>> The values for the exact GPU OPP voltages and the lower limits for the 
>> GPU
>> OPP voltage ranges differ from the values found in the vendor kernel 
>> source
>> (cf. downstream commit f8b9431ee38e ("arm64: dts: rockchip: rk3568: 
>> support
>> adjust opp-table by otp")). [1][2]
> 
> Why? In their latest update Rockchip changed it to the values as 
> specified in
> the links. My assumption is that based on extensive testing they did 
> and/or
> the feedback they got from the client/customers, they felt the need to 
> change
> it to the values they did.
> 
> I think we should follow their values unless we have an explicit and 
> very good
> reason to deviate from that.

There's a rather good reason, which was provided in the patch 
description
right below, but I can see you've already disagreed with it. :)

>> However, our values have served us well so far, so let's keep them for 
>> now,
> 
> And I don't think that qualifies as a (very) good reason.
> I think it's reasonable to assume that far more (stress) testing has 
> been done
> with the downstream code, then has happened with the upstream code.
> Hopefully that'll change in the future, but I don't think we're there 
> yet.

They key in the patch description is "for now". :)  I'd much rather 
leave
the exact voltages unchanged for now, and get that covered a bit later, 
either
in a separate follow-up patch (or in the v3 that would be a two-patch 
series,
as the patch 2/2), which would be good for possibly doing any regression
tracking later, or do it later as part of supporting the CPU and GPU 
binning.

> When we/upstream adds npu support, I think we should also follow 
> downstream's
> OPP values, unless we have a very good reason to deviate from that.

That would make sense, especially because we haven't had the NPU 
supported
before in the mainline.

>> until we actually start supporting the CPU and GPU binning, together 
>> with
>> the related voltage adjustments.
> 
> I may not fully understand what you mean by that, but I think it's 
> (again)
> reasonable to assume that Rockchip has far more insight into this then 
> we do.

Basically, I meant that (my) plan is to work on supporting the CPU and 
GPU
binning, at which point the voltages would also be adjusted according to
the downstream.

>> [1] 
>> https://github.com/rockchip-linux/kernel/commit/f8b9431ee38ed561650be7092ab
>> 93f564598daa9
>> [2] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650
>> be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi

