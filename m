Return-Path: <linux-kernel+bounces-362929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B699BB55
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301D1B2109D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A075514B077;
	Sun, 13 Oct 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ou90+BeG"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00637231CA0;
	Sun, 13 Oct 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728849534; cv=none; b=GIu2Bw8Qz/43snLYA+AoFypprffvvUopQ09HJnfKqdfInAcyk/5e53hNWJMRLh8p5dZneK/CSkq/mKBF17b34929drH3kE6D5zMBk5AGcvnTQSDlco4bGr2uYu6qA5G98g1QFmaKv08w9wHfPFSC/mdxkrAws5yThIX06zMu+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728849534; c=relaxed/simple;
	bh=m2KmuaylEuNGJskRhDGtp6lcqLMZv+Dz7xzvH/AwMOE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=I7EQ0fb162N6hJ/aQbVIpZ4QLLswMXTZ9N1++bLwJel54HMNpfcCn/MLO2fBuGIn5Fdkxylqx3a1KjSlO07jy7yq2E1rljo86IMHhAo85AQHiLZWzNHs8FrTakjz6LjOj2+fWhxw7T18WGQUChZsU73taIaV06G18uMiHhMZC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ou90+BeG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728849522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFjzkSGJ68/8aNuPbT1GRdATADanaYwLAEjat1mrxdo=;
	b=Ou90+BeGk04Rs765b04PfD3xGuKAzayo2Vj5hq1h8cwtfQyjNwL0eSmxHBd7xTN52O0Tiu
	W90wi9GbpFqcoYHpMpxeiBJ4UMLFp0VdkFUCsaPHKFLhB36shGndDAxaH1E6E/NJ0W/Ap2
	xHUMOgiUCCU05+4asb+YdakQe24Bw5ct5qrU9M2NT2oKIXwphMDjgzjLowva3wmf3qrnUI
	SwtMeKJHqlWXsUrFIlDPO33rFQNucVxiC8xD7HWwSwrhDYbRfRbvYUXzyL5Ed9KXmYaG6v
	FDFq15Cv50F+60uhGHcO8QCn/khYxnrkYs8p0U2I4Rf7qEPpuA/2FAA4Cna2sA==
Date: Sun, 13 Oct 2024 21:58:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/5] Binding and driver for gated-fixed-clocks
In-Reply-To: <20240906082511.2963890-1-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de>
Message-ID: <3dd94272e827703c2a2a390fcbd9ff5b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-09-06 10:25, Heiko Stuebner wrote:
> Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) 
> have
> external oscillators on the board to generate the needed 100MHz 
> reference
> clock the PCIe3 controller needs.
> 
> Often these clock generators need supplies to be enabled to run.
> 
> Modelling this clock has taken a number of shapes:
> - The rk3568 Rock-3a modelled the generator-regulator as "phy-supply" 
> [0]
>   &pcie30phy {
>   	phy-supply = <&vcc3v3_pi6c_03>;
>   	status = "okay";
>   };
>   which is of course not part of the binding
> 
> - On the Rock-5-ITX the supply of the clock generator is controlled by
>   the same gpio as the regulator supplying the the port connected to 
> the
>   pcie30x4 controller, so if this controller probes first, both
>   controllers will just run. But if the pcie30x2 controller probes 
> first
>   (which has a different supply), the controller will stall at the 
> first
>   dbi read.
> 
> There are other types too, where an 25MHz oscillator supplies a PLL
> chip like the diodes,pi6c557 used on Theobroma Jaguar and Tiger boards.
> 
> As we established in v1 [1], these are essentially different types, so
> this series attempts to solve the first case of "voltage controlled
> oscillators" as Stephen called them.
> 
> With the discussion in v2, gated-fixed-clock was deemed one possible
> nice naming, so I did go with that.

Thanks, I find "gated-fixed-clock" a much better choice.

> Stephen also suggested reusing more of clk-gpio to not re-implement the
> gpio handling wrt. sleeping and non-sleeping gpios.
> 
> Though instead of exporting masses of structs and ops, 
> gated-fixed-clock
> is quite close to the other gpio-clocks, so I've put it into the 
> clk-gpio
> file.

Just checking, what's the current state of this patch series?
Would another review help with getting it accepted?

> changes in v4:
> - fix example node-name in binding (Rob)
> - add Rob's and Conor's Reviewed-by
> - which -> with in patch 2 message (Diederik)
> - store rate as unsigned long (with a temporary u32 to make
>   of_property_read_u32 happy) (Stephen)
> - add static to struct clk_ops (Stephen)
> - match table sentinel (Stephen)
> - some formatting (Stephen)
> 
> changes in v3:
> - rename to gated-fixed-clock (Conor)
> - move into clk-gpio
> - some tiny cleanups to the existing clk-gpio drivers
> 
> changes in v2:
> - drop the Diodes PLLs for now, to get the first variant right
> - rename stuff to voltage-oscillator / clk_vco as suggested by Stephen
> - require vdd-supply in the binding
> - enable-gpios stays optional, as they often are tied to vdd-supply
> - drop deprecated elements that were left in from the fixed clock 
> binding
> 
> [0] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts#n605
> [1] 
> https://lore.kernel.org/linux-clk/b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org/
> 
> Heiko Stuebner (5):
>   dt-bindings: clocks: add binding for gated-fixed-clocks
>   clk: clk-gpio: update documentation for gpio-gate clock
>   clk: clk-gpio: use dev_err_probe for gpio-get failure
>   clk: clk-gpio: add driver for gated-fixed-clocks
>   arm64: dts: rockchip: fix the pcie refclock oscillator on Rock 5 ITX
> 
>  .../bindings/clock/gated-fixed-clock.yaml     |  49 +++++
>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   |  38 +++-
>  drivers/clk/clk-gpio.c                        | 206 ++++++++++++++++--
>  3 files changed, 277 insertions(+), 16 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml

