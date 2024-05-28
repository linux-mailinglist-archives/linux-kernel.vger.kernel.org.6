Return-Path: <linux-kernel+bounces-192683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946A8D209D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2791C2352D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13538171652;
	Tue, 28 May 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QeEqJxVj"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7B16C456;
	Tue, 28 May 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910883; cv=none; b=m+LIk7FfsNf7BbvUW013nfNuy6YeQs69GkarA49NhghxUJqAIFb04aXB4IOI7BcKMn06aIPfi6rs5zfaVlPorqsn2PvUovCsccDhFr4Kv5qk4Ol5vifS3UG0Pr9/CEYq97N0YBGS7L4khy+BZKck43zz7YibtDKx0bbxEUd6z4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910883; c=relaxed/simple;
	bh=pqJKnCRBIjENJflCKkvhY+fveTWQh6vIao0ZlVHi+lw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DaL/+aPoQzhZ1j1b7g8RNg4qPONE+udN49E8ZlSF5lot4ZilrQJKx5fCccapQKE7YpiJpIOpvwRRoVCdClwI45OwQRSLLvM56PGmztTRkgTDbau+78jMxvvnFyvkEHQ2U+PQ5zp4aNF6Zd7lptDx3rt9Z5/djdRusND2rLKv6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QeEqJxVj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716910877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCx4sci/j/ylDmcMcirdOkvH40gRMFOmC34x4Z8Beas=;
	b=QeEqJxVjm2/QOiCLBaUc2sOWKWUxXKZNDOmWLeInuCCi4/oeFnQzeBxkcNSHpETwkoEnv2
	TMv4WSP3ngi11r2vlmRL+uSs8gQBEm3Xjv9VMOd9BY+kuteaBay1CtWpvTJnA1sZx15gT6
	pVH7xNO+80gJWPJ/0dOMEs3ytCatm/LimXQTXnINOWCV9RZ5P3QYrml8uuX7LVIvu8p/vC
	FOIeBCCdYBG8nkLKbzzPY3h/rC02+NzmArb+kIRPc4btJKi7WsnQC62RQSKlEObiZi38Ax
	jxBbJTNG6MorI7Vrk6xN0PaILzqBInDleUcsWU6Ht/7pSkqCFR5Qcul3mB5Crw==
Date: Tue, 28 May 2024 17:41:17 +0200
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
In-Reply-To: <6230150.aeNJFYEL58@phil>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <5122636.irdbgypaU6@phil> <8727e1c29bd6f562a7fc3de0ddac62cf@manjaro.org>
 <6230150.aeNJFYEL58@phil>
Message-ID: <e67ee8b92ff657a3cf4a1046450639e7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-28 17:16, Heiko Stuebner wrote:
> Am Dienstag, 28. Mai 2024, 17:01:48 CEST schrieb Dragan Simic:
>> On 2024-05-28 16:34, Heiko Stuebner wrote:
>> > Am Dienstag, 28. Mai 2024, 16:05:04 CEST schrieb Dragan Simic:
>> >> On 2024-05-28 11:49, Alexey Charkov wrote:
>> >> > On Mon, May 6, 2024 at 1:37 PM Alexey Charkov <alchark@gmail.com>
>> >> > wrote:
>> >> >>
>> >> >> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
>> >> >> active cooling on Radxa Rock 5B via the provided PWM fan.
>> >> >>
>> >> >> Some RK3588 boards use separate regulators to supply CPUs and their
>> >> >> respective memory interfaces, so this is handled by coupling those
>> >> >> regulators in affected boards' device trees to ensure that their
>> >> >> voltage is adjusted in step.
>> >> >>
>> >> >> This also enables the built-in thermal sensor (TSADC) for all boards
>> >> >> that don't currently have it enabled, using the default CRU based
>> >> >> emergency thermal reset. This default configuration only uses on-SoC
>> >> >> devices and doesn't rely on any external wiring, thus it should work
>> >> >> for all devices (tested only on Rock 5B though).
>> >> >>
>> >> >> The boards that have TSADC_SHUT signal wired to the PMIC reset line
>> >> >> can choose to override the default reset logic in favour of GPIO
>> >> >> driven (PMIC assisted) reset, but in my testing it didn't work on
>> >> >> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
>> >> >> support PMIC assisted reset after all.
>> >> >>
>> >> >> Fan control on Rock 5B has been split into two intervals: let it spin
>> >> >> at the minimum cooling state between 55C and 65C, and then accelerate
>> >> >> if the system crosses the 65C mark - thanks to Dragan for suggesting.
>> >> >> This lets some cooling setups with beefier heatsinks and/or larger
>> >> >> fan fins to stay in the quietest non-zero fan state while still
>> >> >> gaining potential benefits from the airflow it generates, and
>> >> >> possibly avoiding noisy speeds altogether for some workloads.
>> >> >>
>> >> >> OPPs help actually scale CPU frequencies up and down for both cooling
>> >> >> and performance - tested on Rock 5B under varied loads. I've dropped
>> >> >> those OPPs that cause frequency reductions without accompanying
>> >> >> decrease
>> >> >> in CPU voltage, as they don't seem to be adding much benefit in day to
>> >> >> day use, while the kernel log gets a number of "OPP is inefficient"
>> >> >> lines.
>> >> >>
>> >> >> Note that this submission doesn't touch the SRAM read margin updates
>> >> >> or
>> >> >> the OPP calibration based on silicon quality which the downstream
>> >> >> driver
>> >> >> does and which were mentioned in [1]. It works as it is (also
>> >> >> confirmed by
>> >> >> Sebastian in his follow-up message [2]), and it is stable in my
>> >> >> testing on
>> >> >> Rock 5B, so it sounds better to merge a simple version first and then
>> >> >> extend when/if required.
>> >> >>
>> >> >> [1]
>> >> >> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com/
>> >> >> [2]
>> >> >> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
>> >> >>
>> >> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> >> >> ---
>> >> >
>> >> > Hi Heiko,
>> >> >
>> >> > Do you think this can be merged for 6.11? Looks like there hasn't been
>> >> > any new feedback in a while, and it would be good to have frequency
>> >> > scaling in place for RK3588.
>> >> >
>> >> > Please let me know if you have any reservations or if we need any
>> >> > broader discussion.
>> >
>> > not really reservations, more like there was still discussion going on
>> > around the OPPs. Meanwhile we had more discussions regarding the whole
>> > speed binning Rockchip seems to do for rk3588 variants.
>> >
>> > And waiting for the testing Dragan wanted to do ;-) .
>> 
>> I'm sorry for the delays.
> 
> Was definitly _not_ meant as blame ;-) .

Thanks, but I do blame myself a bit for not doing it earlier. :)

> The series has just too many discussions threads to unravel on half
> an afternoon.

Yes, we've touched quite a few areas, for some of which I've already
started working on the associated patches.  That was one of the reasons
for the delays.

>> > So this should definitly make it into 6.11 though, as there is still
>> > a lot of time.
>> >
>> >> As I promised earlier, I was going to test this patch series in
>> >> detail.
>> >> Alas, I haven't managed to do that yet, :/ due to many reasons, but
>> >> I still remain firmly committed to doing that.
>> >>
>> >> Is -rc4 the cutoff for 6.11?  If so, there's still time and I'll do my
>> >> best to test and review these patches as soon as possible.
>> >
>> > As early as possible, the hard cutoff would be -rc6 though.
>> > I guess I'll just start picking the easy patches from the series.
>> 
>> I'll do my best to have the patches tested and reviewed in detail 
>> ASAP.
>> As a suggestion, perhaps it would be better to take the series as a
>> whole,
>> so we don't bring partial merging into the mix.
> 
> Patches need to work individually anyway (in correct order of course),
> so like starting at the top with the general thermal stuff should not
> create issues ;-)

Of course, but I might actually have some comments and suggestions
for some of the patches, and addressing those suggestions, if we end up
agreeing on them, would be a bit messy if some of the patches in the
series become merged first.

