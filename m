Return-Path: <linux-kernel+bounces-192486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BFD8D1DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4ABB20FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7E16F293;
	Tue, 28 May 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Qpa544JQ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F913A868;
	Tue, 28 May 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905116; cv=none; b=tyy8qObQGW501xMxHVwH50NwRIzF1hk6JsIXQhyVaB1Go3igkTNB1OFvfAwXPxuNxJyv6eC97/y7XfNuM9NRjAv/9gntQgPtJC7wK+CcGdcDjYonNovPXVWnbEq25yC+PKWmxhnYlrDw1djWpZzZd0KWlYqOo+iTn3men0MnRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905116; c=relaxed/simple;
	bh=ai1bdbgFELvr6pDqfI7dJqTlHep0caFvUJ3T3nYdQ0o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BY5lmSJbCXcVyQ916YzjeeipryKHAGkOEK4lC5/gfTF1MghrDaCdjB5lGH+rsBAY2ucukoCBHAqnVsMCZ80XE5F5WbP23J+4jf8cXQuNakEqZ2eC9FTAN98fsfql1wjqz4c3leDGtoS6bIsK92lkC0bIoYKSqaZludss4NY7vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Qpa544JQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716905104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR6PGtpqWBgYYKVijGtKvPaDw/ijTAXs71XPwiba6AE=;
	b=Qpa544JQMDRkOoJe07nQK4xF57CXLvIAu1zNfexR5ACS74dObK/J6x0QvxowEYvSoHexfG
	njg4A9zygVo2Bi5T9/8djj1eKPiTFEXsDChECQBHjrc/YksEDoncs6ijzENIdJ952Ya1nM
	jxv2xfXH1y0PBlg4rGHT82kTA7qMUKgUlmFcnnM+yiiZ/WUMUtyIUzjc9+hbfD9l0ilKqZ
	Figaw1QH6Bt52xZx2R4VY+lhNS32Q9RIxGaenr8Fnq9DbF3dN4RiSKYGcEN1eII19wU5Z0
	hTcflr4ivNsNUph387Ff4L4ZEa3f+ZcQJqgDXNSthuL6uMS3jjhtVc4bTcg+9A==
Date: Tue, 28 May 2024 16:05:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
In-Reply-To: <CABjd4YyuDsWGbSfNyqcW3s=59p8adVf5Js79PYyKFqfyM71dxA@mail.gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <CABjd4YyuDsWGbSfNyqcW3s=59p8adVf5Js79PYyKFqfyM71dxA@mail.gmail.com>
Message-ID: <ea2311d7a41162a847d37ce05d0fc441@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey and Heiko,

On 2024-05-28 11:49, Alexey Charkov wrote:
> On Mon, May 6, 2024 at 1:37 PM Alexey Charkov <alchark@gmail.com> 
> wrote:
>> 
>> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
>> active cooling on Radxa Rock 5B via the provided PWM fan.
>> 
>> Some RK3588 boards use separate regulators to supply CPUs and their
>> respective memory interfaces, so this is handled by coupling those
>> regulators in affected boards' device trees to ensure that their
>> voltage is adjusted in step.
>> 
>> This also enables the built-in thermal sensor (TSADC) for all boards
>> that don't currently have it enabled, using the default CRU based
>> emergency thermal reset. This default configuration only uses on-SoC
>> devices and doesn't rely on any external wiring, thus it should work
>> for all devices (tested only on Rock 5B though).
>> 
>> The boards that have TSADC_SHUT signal wired to the PMIC reset line
>> can choose to override the default reset logic in favour of GPIO
>> driven (PMIC assisted) reset, but in my testing it didn't work on
>> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
>> support PMIC assisted reset after all.
>> 
>> Fan control on Rock 5B has been split into two intervals: let it spin
>> at the minimum cooling state between 55C and 65C, and then accelerate
>> if the system crosses the 65C mark - thanks to Dragan for suggesting.
>> This lets some cooling setups with beefier heatsinks and/or larger
>> fan fins to stay in the quietest non-zero fan state while still
>> gaining potential benefits from the airflow it generates, and
>> possibly avoiding noisy speeds altogether for some workloads.
>> 
>> OPPs help actually scale CPU frequencies up and down for both cooling
>> and performance - tested on Rock 5B under varied loads. I've dropped
>> those OPPs that cause frequency reductions without accompanying 
>> decrease
>> in CPU voltage, as they don't seem to be adding much benefit in day to
>> day use, while the kernel log gets a number of "OPP is inefficient" 
>> lines.
>> 
>> Note that this submission doesn't touch the SRAM read margin updates 
>> or
>> the OPP calibration based on silicon quality which the downstream 
>> driver
>> does and which were mentioned in [1]. It works as it is (also 
>> confirmed by
>> Sebastian in his follow-up message [2]), and it is stable in my 
>> testing on
>> Rock 5B, so it sounds better to merge a simple version first and then
>> extend when/if required.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com/
>> [2] 
>> https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
>> 
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
> 
> Hi Heiko,
> 
> Do you think this can be merged for 6.11? Looks like there hasn't been
> any new feedback in a while, and it would be good to have frequency
> scaling in place for RK3588.
> 
> Please let me know if you have any reservations or if we need any
> broader discussion.

As I promised earlier, I was going to test this patch series in detail.
Alas, I haven't managed to do that yet, :/ due to many reasons, but
I still remain firmly committed to doing that.

Is -rc4 the cutoff for 6.11?  If so, there's still time and I'll do my
best to test and review these patches as soon as possible.

