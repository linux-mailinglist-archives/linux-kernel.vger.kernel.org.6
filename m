Return-Path: <linux-kernel+bounces-192598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818208D1F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25AEB22C26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A749170851;
	Tue, 28 May 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SrjPBIbO"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404EF16FF30;
	Tue, 28 May 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908513; cv=none; b=FUaOhkPKPLNwWfGsaE/3RG3FP6DWPpKoQCZqu3IHXJ6BWHhUXnYVyVOIeeLRje7qu77U+TiHbl5zNsuiE/AEd7V/dYW1X6ki3jeI66ohuMc2kXTibbXq+aXVlUGK/ybA5jfVju2FptZJLGbsgV1dO5T8pn1Ed48kBS8y0/lQPLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908513; c=relaxed/simple;
	bh=+c4A3JerB0xupH1a7XXNQREUxEJtN/+ZzWnCqhsCUPc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FrUI4Ord8sCQqb+Jb3buoehIaJqfgYsQ8/gf5oYDD3hwTfELz40tDFCavfCBwriNx2Ej/2f4XO9/pVK/rT4zFrF81498NL0X9PhA9DZ1kXmux5XDRu32KJsER+0LjH/JxWr9ur8fqSvavYkq7jBEhexhHSjPBAMV+yxbT9Duc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SrjPBIbO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716908509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTliwcQUwlXfpyzNkH7+3TEPpHv8Li6OUQHn1YDk4Fc=;
	b=SrjPBIbOw4eZdlN/lXyx4lnXvyGApnt42U//NCwDoha9Dj2K/3HO+djVQnT1dkkoouYQme
	6ObDD7JR1vSs5lLmyM2GIoe4rZZQTSZA4XyTkCwlPcuEXTC0HsJQK7W0DYmIbGGipU+080
	/33zX+GipGSCAnw3U6Rm0+6QDwVXyd+pUXrjYLXEpp6Xqa+bi/5NDwLoOTOAPP8xXGfpHW
	RK8oX4E9Ei8SvzhHQ43fF0Y9fkeezFpU9soRoljKia3sNBtBYn47rlz3E6LDuwbEa9Xo13
	XOgiq7xnQzwsyTMf8CyBLfUIbSqLL1IVyyjy6hdnL4W9pABMgOLBST3YzbEO7w==
Date: Tue, 28 May 2024 17:01:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, Diederik de
 Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
In-Reply-To: <5122636.irdbgypaU6@phil>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <CABjd4YyuDsWGbSfNyqcW3s=59p8adVf5Js79PYyKFqfyM71dxA@mail.gmail.com>
 <ea2311d7a41162a847d37ce05d0fc441@manjaro.org> <5122636.irdbgypaU6@phil>
Message-ID: <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-28 16:34, Heiko Stuebner wrote:
> Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
>> On 2024-05-28 11:49, Alexey Charkov wrote:
>> > On Mon, May 6, 2024 at 1:37 PM Alexey Charkov <alchark@gmail.com>
>> > wrote:
>> >>
>> >> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
>> >> active cooling on Radxa Rock 5B via the provided PWM fan.
>> >>
>> >> Some RK3588 boards use separate regulators to supply CPUs and their
>> >> respective memory interfaces, so this is handled by coupling those
>> >> regulators in affected boards' device trees to ensure that their
>> >> voltage is adjusted in step.
>> >>
>> >> This also enables the built-in thermal sensor (TSADC) for all boards
>> >> that don't currently have it enabled, using the default CRU based
>> >> emergency thermal reset. This default configuration only uses on-SoC
>> >> devices and doesn't rely on any external wiring, thus it should work
>> >> for all devices (tested only on Rock 5B though).
>> >>
>> >> The boards that have TSADC_SHUT signal wired to the PMIC reset line
>> >> can choose to override the default reset logic in favour of GPIO
>> >> driven (PMIC assisted) reset, but in my testing it didn't work on
>> >> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
>> >> support PMIC assisted reset after all.
>> >>
>> >> Fan control on Rock 5B has been split into two intervals: let it spin
>> >> at the minimum cooling state between 55C and 65C, and then accelerate
>> >> if the system crosses the 65C mark - thanks to Dragan for suggesting.
>> >> This lets some cooling setups with beefier heatsinks and/or larger
>> >> fan fins to stay in the quietest non-zero fan state while still
>> >> gaining potential benefits from the airflow it generates, and
>> >> possibly avoiding noisy speeds altogether for some workloads.
>> >>
>> >> OPPs help actually scale CPU frequencies up and down for both cooling
>> >> and performance - tested on Rock 5B under varied loads. I've dropped
>> >> those OPPs that cause frequency reductions without accompanying
>> >> decrease
>> >> in CPU voltage, as they don't seem to be adding much benefit in day to
>> >> day use, while the kernel log gets a number of "OPP is inefficient"
>> >> lines.
>> >>
>> >> Note that this submission doesn't touch the SRAM read margin updates
>> >> or
>> >> the OPP calibration based on silicon quality which the downstream
>> >> driver
>> >> does and which were mentioned in [1]. It works as it is (also
>> >> confirmed by
>> >> Sebastian in his follow-up message [2]), and it is stable in my
>> >> testing on
>> >> Rock 5B, so it sounds better to merge a simple version first and then
>> >> extend when/if required.
>> >>
>> >> [1]
>> >> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com/
>> >> [2]
>> >> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
>> >>
>> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> ---
>> >
>> > Hi Heiko,
>> >
>> > Do you think this can be merged for 6.11? Looks like there hasn't been
>> > any new feedback in a while, and it would be good to have frequency
>> > scaling in place for RK3588.
>> >
>> > Please let me know if you have any reservations or if we need any
>> > broader discussion.
> 
> not really reservations, more like there was still discussion going on
> around the OPPs. Meanwhile we had more discussions regarding the whole
> speed binning Rockchip seems to do for rk3588 variants.
> 
> And waiting for the testing Dragan wanted to do ;-) .

I'm sorry for the delays.

> So this should definitly make it into 6.11 though, as there is still
> a lot of time.
> 
>> As I promised earlier, I was going to test this patch series in 
>> detail.
>> Alas, I haven't managed to do that yet, :/ due to many reasons, but
>> I still remain firmly committed to doing that.
>> 
>> Is -rc4 the cutoff for 6.11?  If so, there's still time and I'll do my
>> best to test and review these patches as soon as possible.
> 
> As early as possible, the hard cutoff would be -rc6 though.
> I guess I'll just start picking the easy patches from the series.

I'll do my best to have the patches tested and reviewed in detail ASAP.
As a suggestion, perhaps it would be better to take the series as a 
whole,
so we don't bring partial merging into the mix.

