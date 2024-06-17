Return-Path: <linux-kernel+bounces-216573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C05190A1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A7FB20F42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C093D6A;
	Mon, 17 Jun 2024 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KSbrv0S2"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB223A9;
	Mon, 17 Jun 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586590; cv=none; b=rfbVJ9/7+8nLgVCOH8RzDI8RHnvquBRlnJXbhs8NX2Ssv8wD88UOq7dAy0YugadxPu9hZvOaX2qhhRoj+fxZrnQELa5zR9bBi8+IGBV3l0f3+bvP8t2LpEwDMzBaQwm4mQuniAfZU2WwG6ni9unlFCFzHUxXG6f5DHi+VdJmBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586590; c=relaxed/simple;
	bh=oVJ7ztvv8Q1H/fJbpmo4v7f/h4u9eLNCYYXrSwrODB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um9QV+lGktQudFIbe4LVj7q65b2BfmvUXLxbYY4l8xF7NsPyFKI3RXp9/J56LPnHCvWA5VbEMNVZWDvOS3E42nbsB5ypseUhgYN2rJ6bTcXOKyfUuDflWAN6oQw7MDZYSlX0Bb2Tr3LnlvIQiCrh1H2CIGCj0aLDcy46qqoxoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KSbrv0S2; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JM/OxoS8Im0bLJpAAqk1Wmh9EQPXOP9Skidv0H0GI2I=;
	b=KSbrv0S2WsFiFe67JGprZ4pko1VBxgi1aBXpRgEF8kgM7sIGHnIXJiDemki06n
	2Ynur6AEiGTtkZ3dc8rIFezEIm2MjRa1GN5mKPmloSjdWwNBSVtX6GAH0H7nJ2Rq
	3fo7YyFgOY4krDbJm5OUfN9YG26QUugAlDU0ynk7L0Znk=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADnL0+8jG9mzQ3NCA--.30806S3;
	Mon, 17 Jun 2024 09:09:17 +0800 (CST)
Date: Mon, 17 Jun 2024 09:09:15 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK
 minimal board dts
Message-ID: <Zm+Mu33s2+8G579d@dragon>
References: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
 <20240605-imx95-dts-v3-v6-3-2ce275ed0e80@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-imx95-dts-v3-v6-3-2ce275ed0e80@nxp.com>
X-CM-TRANSID:C1UQrADnL0+8jG9mzQ3NCA--.30806S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar4UKFy3WryDGFyxCrW5GFg_yoW3JF45pr
	93Z3y7KrykJrZrJry8GwnFyF4UJw4kCr1v9rZrW3W0kw13ZwsFgwnYkrn8JrWqvws8Zw13
	JFZrZr47K3WqgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYKZXUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGB0BZV6Nn45YdwAAsM

On Wed, Jun 05, 2024 at 09:22:50AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add a minimal dts for i.MX95 19x19 EVK board:
>  - lpuart1 as console
>  - sdhc1/2 as storage
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 200 ++++++++++++++++++++++
>  2 files changed, 201 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 1b1e4db02071..c3fef4e4d8dd 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -239,6 +239,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>  
>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> new file mode 100644
> index 000000000000..2c2f3cfbe11a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx95.dtsi"
> +
> +/ {
> +	model = "NXP i.MX95 19X19 board";
> +	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
> +
> +	aliases {
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		serial0 = &lpuart1;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux_cma: linux,cma {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0 0x80000000 0 0x7F000000>;
> +			size = <0 0x3c000000>;
> +			linux,cma-default;
> +			reusable;
> +		};
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VDD_SD2_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <12000>;
> +		enable-active-high;

enable-active-high right after line of gpio = <... GPIO_ACTIVE_HIGH>;

Shawn

> +	};
> +};
> +
> +&lpuart1 {
> +	/* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&mu7 {
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc1>;
> +	bus-width = <8>;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&scmi_iomuxc {
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
> +			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX      0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x15fe
> +			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x13fe
> +			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe
> +			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe
> +			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe
> +			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe
> +			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe
> +			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe
> +			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe
> +			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe
> +			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x15fe
> +			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x13fe
> +			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe
> +			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe
> +			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe
> +			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe
> +			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
> +		>;
> +	};
> +};
> 
> -- 
> 2.37.1
> 


