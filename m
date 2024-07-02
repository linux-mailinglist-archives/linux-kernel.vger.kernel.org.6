Return-Path: <linux-kernel+bounces-237222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1891EDA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB32845FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF92BCFF;
	Tue,  2 Jul 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HJNsOiXH"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731DC179AF;
	Tue,  2 Jul 2024 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893506; cv=none; b=hAbewWlEPyGgU3yEf0McH02BlanbLGhiGuDGWqbCltkVYsSyFOEmns6UNPb3ARuIfGNPiY2h2bSOjx3jJgVH25lMnV85sdOdZPc/cGJcNygC5LOnzzifdcloXOW/K97nKpkS+S6IgQlUZRd4i3kEUTFabjAkS82JJ5+LmMHbBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893506; c=relaxed/simple;
	bh=WNIW031Xge/X5WvEvR0amu3sR8nBLxBVhMO5x3XuHjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIQFpiJMPbRrYb2y2HjtE63++X3C0IoYPjJSbNj8UWHmYFO9KKgafXKJEZXcfLz2qrI7v8BjcJKfBBUNTBpttkRzKIKx+bKeFTWLwpy0O1wbsn6rThjlTzOhK7poYRhFLP8TeF6vYkpwoVabZ5U1kiqIsftIlRMqIuU0xX3l9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HJNsOiXH; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=BTf0yHthWHICtLSK/4rntYV8tS0Sys4XbAF0SFXsaC0=;
	b=HJNsOiXHTnRtwPG9Yg2kDVOz0ZaPKpUOwUKh9QdsOwWcJfN2PswQTkaJv5FUNf
	RB19sXXFqakH8VNhlfWjYirz298MUUMwISDVVYsUIaQdtlKFIXzf42kLnapoHENC
	JfTd3ZTmLJBKjEgo8WPmxAkBNqmTYQlHc4Ug2Y/FffJ4c=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgC3H4nSfYNmasI+AA--.7783S3;
	Tue, 02 Jul 2024 12:11:00 +0800 (CST)
Date: Tue, 2 Jul 2024 12:10:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] arm64: dts: imx8qm: add lvds subsystem
Message-ID: <ZoN90rHfpK7niqEr@dragon>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
 <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com>
X-CM-TRANSID:Ms8vCgC3H4nSfYNmasI+AA--.7783S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4DKF4kJw48Cw4DAr4fKrg_yoWrWw1rpF
	9rCa12qF1IyFyI9r9xKF18Krn5G3s8tF4j9ry3GrWjyrsxJry7tan3Cr1kury8XF42v3y0
	gFn0qr1FkrnIvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO8nOUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhUQZWZv-d3PvwAAs7

On Mon, Jul 01, 2024 at 11:03:28AM -0400, Frank Li wrote:
> Add irqsteer, pwm and i2c in lvds subsystem.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 77 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 10 +++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> new file mode 100644
> index 0000000000000..1da3934847057
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +&qm_lvds0_lis_lpcg {
> +	clocks = <&lvds_ipg_clk>;
> +	clock-indices = <IMX_LPCG_CLK_4>;
> +};
> +
> +&qm_lvds0_pwm_lpcg {
> +	clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
> +		 <&lvds_ipg_clk>;
> +	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +};
> +
> +&qm_lvds0_i2c0_lpcg {
> +	clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
> +		 <&lvds_ipg_clk>;
> +	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +};
> +
> +&qm_pwm_lvds0 {
> +	clocks = <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
> +		 <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
> +};
> +
> +&qm_i2c0_lvds0 {
> +	clocks = <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
> +		 <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
> +};
> +
> +&lvds0_subsys {
> +	interrupt-parent = <&irqsteer_lvds0>;
> +
> +	irqsteer_lvds0: interrupt-controller@56240000 {
> +		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";

Is compatible "fsl,imx8qm-irqsteer" documented in bindings?

Shawn

> +		reg = <0x56240000 0x1000>;
> +		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic>;
> +		#interrupt-cells = <1>;
> +		clocks = <&qm_lvds0_lis_lpcg IMX_LPCG_CLK_4>;
> +		clock-names = "ipg";
> +		power-domains = <&pd IMX_SC_R_LVDS_0>;
> +
> +		fsl,channel = <0>;
> +		fsl,num-irqs = <32>;
> +	};
> +
> +	lvds0_i2c1_lpcg: clock-controller@56243014 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x56243014 0x4>;
> +		#clock-cells = <1>;
> +		clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
> +			 <&lvds_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names = "lvds0_i2c1_lpcg_clk",
> +				     "lvds0_i2c1_lpcg_ipg_clk";
> +		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
> +	};
> +
> +	i2c1_lvds0: i2c@56247000 {
> +		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg = <0x56247000 0x1000>;
> +		interrupts = <9>;
> +		clocks = <&lvds0_i2c1_lpcg IMX_LPCG_CLK_0>,
> +			 <&lvds0_i2c1_lpcg IMX_LPCG_CLK_4>;
> +		clock-names = "per", "ipg";
> +		assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates = <24000000>;
> +		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
> +		status = "disabled";
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index 61986e0639e53..1e8511e8d8577 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -560,11 +560,20 @@ clk_spdif1_rx: clock-spdif1-rx {
>  		clock-output-names = "spdif1_rx";
>  	};
>  
> +	lvds_ipg_clk: clock-controller-lvds-ipg {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "lvds0_ipg_clk";
> +	};
> +
>  	/* sorted in register address */
>  	#include "imx8-ss-cm41.dtsi"
>  	#include "imx8-ss-audio.dtsi"
>  	#include "imx8-ss-vpu.dtsi"
>  	#include "imx8-ss-gpu0.dtsi"
> +	#include "imx8-ss-lvds0.dtsi"
> +	#include "imx8-ss-lvds1.dtsi"
>  	#include "imx8-ss-img.dtsi"
>  	#include "imx8-ss-dma.dtsi"
>  	#include "imx8-ss-conn.dtsi"
> @@ -576,3 +585,4 @@ clk_spdif1_rx: clock-spdif1-rx {
>  #include "imx8qm-ss-conn.dtsi"
>  #include "imx8qm-ss-lsio.dtsi"
>  #include "imx8qm-ss-audio.dtsi"
> +#include "imx8qm-ss-lvds.dtsi"
> 
> -- 
> 2.34.1
> 


