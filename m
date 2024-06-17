Return-Path: <linux-kernel+bounces-216586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9FD90A1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911861F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD23D51D;
	Mon, 17 Jun 2024 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="E3PcAbLY"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74B79CE;
	Mon, 17 Jun 2024 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588441; cv=none; b=CyFSOUpd9bDgVa/FG5qx6rnIrX7jnh5HoWOjBPTmGWm8ciTOXUyEiOxZXr/50GHz2zE511H5wSnKExAleugafo+lDIypZzdZu0B+kZSGnezEcUkAppdKLYTc5+RYjBY/TwMSYUEI73a9ZV+G1VQGBFBw+YZaIBLSbv5NIT+rm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588441; c=relaxed/simple;
	bh=zm2QmYSlPPOUfGKpEjMcX7HJpO8NnCnQ8rj14q4adJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB19NgbfYBrl06o2FXlfgLShe502879fAvrg6Ll8YYFXqCfqOEp+QaEaunzQTDBNwZqa6kWuN6dt2NF4xaAPvWmxTuI7vWEGbH2/hPR89oNzrLVivQ9fU9TYI3f8x0hkqkREOoawWZK6CablPdYVSu5Q9a9P2izHaBJ+VhgRkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=E3PcAbLY; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=I+p47SL6dimu9f+zi9duzMmWriyBTBtbi5NfLRZ8KGA=;
	b=E3PcAbLY8b8ZmRtbnWsycS2VEqnn4zWApJc4ZFgz0IBl3rI7U4YG8wVW1JbQMv
	dJ+BU/v0crlUWJH5/A94Q6IK4KmT+7WORoBT3dDQ6j2vnorDiByCPCZNE8HoU7Gw
	zIF0q+JqbYb2NQsLkZGrFIHxj5QTRZ+dKQgI5dBQtIr2c=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrACH7voClG9mgKELCA--.41844S3;
	Mon, 17 Jun 2024 09:40:19 +0800 (CST)
Date: Mon, 17 Jun 2024 09:40:18 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/13] ARM: dts: imx6qdl-kontron-samx6i: add
 SDIO_PWR_EN support
Message-ID: <Zm+UAlzIKKH0IPQm@dragon>
References: <20240606090206.2021237-1-mwalle@kernel.org>
 <20240606090206.2021237-9-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090206.2021237-9-mwalle@kernel.org>
X-CM-TRANSID:ClUQrACH7voClG9mgKELCA--.41844S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWDCr4kXw45ur4UCr4xXrb_yoW8tr48pF
	s3GrZagrykWry3tay3Ga42kr4rCw4kC3s7uw12gFy8AFy7Z3WUur97Krn8A3Z5XFs8Zw4a
	kry3Zr9rA3Z2v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz1v3UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQMBZV6NnP+BgAAAsD

On Thu, Jun 06, 2024 at 11:02:01AM +0200, Michael Walle wrote:
> The module can enable/disable the SD card power supply and has
> it's dedicated pin SDIO_PWR_EN for that reason. This is esp.
> useful to be able to reset the SD card if it was in an UHS mode.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  .../dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi   | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> index 4d3cd338a707..d36743e47552 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i.dtsi
> @@ -61,6 +61,18 @@ reg_3p3v_s5: regulator-3p3v-s5 {
>  		vin-supply = <&reg_smarc_suppy>;
>  	};
>  
> +	reg_sdio: regulator-sdio {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_sdio>;
> +		regulator-name = "V_3V3_SD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <20000>;
> +		enable-active-high;

enable-active-high right after line of GPIO_ACTIVE_HIGH.

Shawn

> +	};
> +
>  	reg_smarc_lcdbklt: regulator-smarc-lcdbklt {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -640,6 +652,12 @@ MX6QDL_PAD_SD1_CMD__PWM4_OUT 0x1b0b1
>  		>;
>  	};
>  
> +	pinctrl_reg_sdio: reg-sdiogrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0 /* SDIO_PWR_EN */
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
> @@ -692,7 +710,6 @@ MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
>  
>  			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x1b0b0 /* CD */
>  			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x1b0b0 /* WP */
> -			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0 /* PWR_EN */
>  		>;
>  	};
>  
> @@ -795,6 +812,7 @@ &usdhc3 {
>  	pinctrl-0 = <&pinctrl_usdhc3>;
>  	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
>  	wp-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +	vmmc-supply = <&reg_sdio>;
>  	no-1-8-v;
>  };
>  
> -- 
> 2.39.2
> 


