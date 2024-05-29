Return-Path: <linux-kernel+bounces-193253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9798D2940
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FBE1F258CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41275DDAB;
	Wed, 29 May 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aopIU6H9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D6D27A;
	Wed, 29 May 2024 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941059; cv=none; b=Ts3QmpXP/qCSsA24MF9EnfEPjPxInByvM0jHQnaJHAJ2q78lz9exmbAZR65GrlK8/oVmcF4Ji/7bh0QpcZvA2W3M5Dm2h1ustsP7iAd3PoX2nnlHppajtrV7+COPqKrZb9PAZXJpHUlpmpILDWnfa6voQt0ICsFf+qF2buY1hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941059; c=relaxed/simple;
	bh=iCwacVP+fcBaS3qxBrWlpvGpWPI6CSiUHt/DGTElfzc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HbGkNlqI+va8d75SIm7Bl2dOiFvqu0bN8fVBiBo61zLD+sxwbsTbk4uwA8risqgAehbtNXbjXLPyMIpTFkdPTERF2AR/d89eKtCRSj2fqcnB5UzEHcF6vL5V48qb0LwWr4o7QAp5dB3I8Gmn//q+Dp/H+SEtKOAoa5RMUR92On0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aopIU6H9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716941053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3UyPJg9jT2CCb8WYackyvrQqiNArMyehuNffpOyzV0=;
	b=aopIU6H9EgsMSPt5ksrdKvzYWVMSYnAv2ZZsRbRs6kY6ufPI1al1Ybb7H0E4bvwLghJgxE
	2wcZlU+nRH0GPEf7mREx0QwcFM/MCf1lNDzNXytcVFnQlLe6pDiGMak36dMuYLb1y47bE4
	XA63nI2swkNGCCv7RCZDjwK5RuwoQPHgsGWPDpqDB005aYyMIfrQF6la0I6DU1gxrZ49JT
	Nhp6NcZ4iqFxFZzy1eea8Du0PXwgGJYgQxpsvBgb86IYs/rW8eAwOVMKNnDx9lysxk7C56
	ZhZJfxwtP3gLgTRXWXfSytwbEc9aLVrHUlyMrgqWze0/vcqoR8mzwN2UuLoBOg==
Date: Wed, 29 May 2024 02:04:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alexey Charkov <alchark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Diederik de Haas
 <didi.debian@cknow.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
In-Reply-To: <646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <5122636.irdbgypaU6@phil> <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
 <6230150.aeNJFYEL58@phil>
 <CABjd4YyRJS0AGehuBTDn8ys9uRRkGc0Usme3GX1POq3AQiWTBA@mail.gmail.com>
 <646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de>
Message-ID: <7b09e18e850ff0832bd7236810b83e64@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2024-05-28 18:08, Quentin Schulz wrote:
> On 5/28/24 5:42 PM, Alexey Charkov wrote:
>> On Tue, 28 May 2024 at 19:16, Heiko Stuebner <heiko@sntech.de> wrote:
>>> Am Dienstag, 28. Mai 2024, 17:01:48 CEST schrieb Dragan Simic:
>>>> On 2024-05-28 16:34, Heiko Stuebner wrote:
>>>>> Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
>>>>>> On 2024-05-28 11:49, Alexey Charkov wrote:
>>>>>>> Do you think this can be merged for 6.11? Looks like there hasn't
>>> been
>>>>>>> any new feedback in a while, and it would be good to have 
>>>>>>> frequency
>>>>>>> scaling in place for RK3588.
>>>>>>> 
>>>>>>> Please let me know if you have any reservations or if we need any
>>>>>>> broader discussion.
>>>>> 
>>>>> not really reservations, more like there was still discussion going 
>>>>> on
>>>>> around the OPPs. Meanwhile we had more discussions regarding the 
>>>>> whole
>>>>> speed binning Rockchip seems to do for rk3588 variants.
>>>>> 
>>>>> And waiting for the testing Dragan wanted to do ;-) .
>>>> 
>>>> I'm sorry for the delays.
>>> 
>>> Was definitly _not_ meant as blame ;-) .
>>> 
>>> The series has just too many discussions threads to unravel on half
>>> an afternoon.
>> 
>> FWIW, I think the latest exchange we had with Quentin regarding the 
>> OPPs
>> concluded in “false alarm”, given that this version of the series only
>> introduces a subset of them which should apply to all RK3588(s)
> 
> Correct.
> 
> However... I'm wondering if we shouldn't somehow follow the same
> pattern we have used for the rk3399 OPPs? We have a file for the
> "true" RK3399 OPPs, then the OP1 variant and the RK3399T.

If I'm not mistaken, the separate rk3399-*opp*.dtsi files were
added when the need arose.

> We already know there are a few variants of RK3588 with different
> OPPs: RK3588(S/S2?), RK3588J and RK3588M. I wouldn't be surprised if
> the RK3582 (though this one has already one big cluster (or two big
> cores) fewer than RK3588) has different OPPs as well?

Do we already have supported boards that use the RK3588J and
RK3588M variants of the RK3588 SoC?  If yes, we should separate
the relevant OPPs into the separate .dtsi files, but if not, we
should wait until the need arises.

> So. We have already discussed that the OPPs in that patch are valid
> for RK3588(S) but they aren't for the other variants.

.. which applies currently if there are already other RK3588
variants in use on the supported boards.

> In the downstream kernel, any OPP whose opp-supported-hw has a first
> value masked by BIT(1) return non-0 is supported by RK3588M. In the
> downstream kernel, any OPP whose opp-supported-hw has a first value
> masked by BIT(2) return non-0 is supported by RK3588J.
> 
> This means that, for LITTLE clusters:
> - opp-1608000000 not supported on RK3588J
> - opp-1704000000 only supported on RK3588M (but already absent in this
> patch series)
> - opp-1800000000 only supported on RK3588(S), not RK3588J nor RK3588M
> 
> For big clusters:
> - opp-1800000000 not supported on RK3588J
> - opp-2016000000 not supported on RK3588J
> - opp-2208000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2256000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2304000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2352000000 only supported on RK3588(S), not RK3588J nor RK3588M
> - opp-2400000000 only supported on RK3588(S), not RK3588J nor RK3588M
> 
> This is somehow also enforced in downstream kernel by removing the OPP
> nodes directly (hence, not even requiring the check of
> opp-supported-hw value), c.f.:
> https://git.theobroma-systems.com/tiger-linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
> https://git.theobroma-systems.com/tiger-linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588m.dtsi
> 
> You'll not that the RK3588J also has less OPPs for the GPU and NPU
> (but those should also be masked by the opp-supported-hw value).

