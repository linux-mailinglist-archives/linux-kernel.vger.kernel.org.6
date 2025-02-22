Return-Path: <linux-kernel+bounces-527289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE1A4093C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8DC1897FC1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A0199FA8;
	Sat, 22 Feb 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="c6yRzoZ7"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64111386B4;
	Sat, 22 Feb 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236021; cv=none; b=DP+GM01nfuzeRt1VceiaQE/J6Yt0E4K8eWLyoaFFyOloYp1ICW+UQ8Of2wnnIwc9wZrRFz6k0+43Ne6VpU9BCZujWIAA35CGlD/8TKTuflYKXnZe3GwMZNXtCcLG2DXsgyRivgEI5w2XFO+ahhSFauL84rMpMVtsi513Ag3pVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236021; c=relaxed/simple;
	bh=6NLFBN3CWzyMeAJspjzKbRmxaZ/SVUGadHwQchJrNYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/bzdqLkcU5zwCKhKfB8z7T8rxquLKlzJinYH2q2MYSHRNqz8C47gTDpPhoTSMjqcARRXCjfPKLZ/b8HM55ezcwDGlubpfg3VC4c5jW9NKtjWsJryBTzjIvkmafC9fke4kN5DfxoMiB2fXpk80PtzBpoMaGVALheOCL9SukhwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=c6yRzoZ7; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2nQ8cz+ZMHYSXRIH5DAYjBozA65aWA3+Pcc6gymbBPw=;
	b=c6yRzoZ7TOfjIHTinQI4VmzBcZeKdWNEFMQbjpEHOb/+iz3HrruWnyo36+Ifit
	KvXkqdUOa9r2oK8o7/O8jfaSyZ2/6HM9DvucBCioGKOa9zZ1rudSvXVObX6uua1h
	wmPFjDSP69nLS1EawgeRkiP8Mu7H9/BmXH/2v1U4mbEoQ=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDXVV295LlnNgd_CQ--.21192S3;
	Sat, 22 Feb 2025 22:52:47 +0800 (CST)
Date: Sat, 22 Feb 2025 22:52:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6ul: Add Variscite Concerto board
 support
Message-ID: <Z7nkvQ1dRFI+solj@dragon>
References: <20250127-varsom6ul-concerto-dts-v2-0-4dac29256989@bootlin.com>
 <20250127-varsom6ul-concerto-dts-v2-3-4dac29256989@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-varsom6ul-concerto-dts-v2-3-4dac29256989@bootlin.com>
X-CM-TRANSID:M88vCgDXVV295LlnNgd_CQ--.21192S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar47Zr4DCr4xAw17Cw1fCrg_yoWftr43pa
	ySk3ykXr1DXr47ta4kX3WqkF15Cws2kr929342g34UAFnrKa42vr1jgrn5Jr4DKrs8Gw4Y
	v3WqvrWjg3Wqgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UME__UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxv7ZWe5rOe-mAAAs8

On Mon, Jan 27, 2025 at 04:31:02PM +0100, Antonin Godard wrote:
> Add support for the Variscite Concerto Carrier Board with:
> 
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch
>   display (not configured)
> - USB Host + USB OTG Connector
> - 10/100 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - S-ATA
> - On-board DMIC
> 
> Product Page: https://www.variscite.com/product/single-board-computers/concerto-board
> 
> This file is based on the one provided by Variscite on their own kernel,
> but adapted for mainline.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile                 |   1 +
>  .../boot/dts/nxp/imx/imx6ul-var-som-concerto.dts   | 320 +++++++++++++++++++++
>  2 files changed, 321 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index 39a153536d2a..94c9bc94cc8e 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -329,6 +329,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-tx6ul-0010.dtb \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
> +	imx6ul-var-som-concerto.dtb \
>  	imx6ull-14x14-evk.dtb \
>  	imx6ull-colibri-aster.dtb \
>  	imx6ull-colibri-emmc-aster.dtb \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
> new file mode 100644
> index 000000000000..4955d5193be3
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for Variscite MX6 Concerto Carrier board with the VAR-SOM-MX6UL
> + * Variscite SoM mounted on it
> + *
> + * Copyright 2019 Variscite Ltd.
> + * Copyright 2025 Bootlin
> + */
> +
> +#include "imx6ul-var-som.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Variscite VAR-SOM-MX6UL Concerto Board";
> +	compatible = "variscite,mx6ulconcerto", "variscite,var-som-imx6ul", "fsl,imx6ul";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_key_back>, <&pinctrl_gpio_key_wakeup>;
> +
> +		key-back {
> +			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_BACK>;
> +		};
> +
> +		key-wakeup {
> +			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			label = "gpled2";
> +			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	status = "disabled";
> +};
> +
> +&fec2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet2>, <&pinctrl_enet2_gpio>, <&pinctrl_enet2_mdio>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy1>;
> +	phy-reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <100>;

Deprecated properties.  They should be described by ethernet-phy.

> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@3 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			micrel,rmii-reference-clock-select-25-mhz = <1>;
> +			micrel,led-mode = <0>;
> +			clocks = <&rmii_ref_clk>;
> +			clock-names = "rmii-ref";
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	rtc@68 {
> +		/*
> +		 * To actually use this interrupt
> +		 * connect pins J14.8 & J14.10 on the Concerto-Board.
> +		 */
> +		compatible = "dallas,ds1337";
> +		reg = <0x68>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rtc>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_enet2: enet2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
> +		>;
> +	};
> +
> +	pinctrl_enet2_mdio: enet2-mdiogrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
> +			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_enet2_gpio: enet2-gpiogrp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* fec2 reset */
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
> +			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
> +		>;
> +	};
> +
> +	pinctrl_gpio_key_back: gpio-key-backgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x17059 /* Back */
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpio-ledsgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x1b0b0	/* GPLED2 */
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
> +			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO05__PWM4_OUT		0x110b0
> +		>;
> +	};
> +
> +	pinctrl_rtc: rtcgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0 /* RTC alarm IRQ */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_DATA00__UART5_DCE_TX	0x1b0b1
> +			MX6UL_PAD_CSI_DATA01__UART5_DCE_RX	0x1b0b1
> +			MX6UL_PAD_GPIO1_IO09__UART5_DCE_CTS	0x1b0b1
> +			MX6UL_PAD_GPIO1_IO08__UART5_DCE_RTS	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usb_otg1_id: usbotg1idgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART3_TX_DATA__ANATOP_OTG1_ID	0x17059
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO01__WDOG1_WDOG_B	0x78b0
> +		>;
> +	};
> +
> +	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {

Out of alphabetic order.

> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059 /* Wakeup */
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x1b0b1 /* CD */
> +		>;
> +	};
> +};
> +
> +&pwm4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	status = "okay";
> +};
> +
> +&snvs_pwrkey {
> +	status = "disabled";
> +};
> +
> +&snvs_rtc {
> +	status = "disabled";
> +};
> +
> +&tsc {
> +	/*
> +	 * Conflics with wdog1 ext-reset-output & SD CD pins,
> +	 * so we keep it disabled by default.
> +	 */
> +	status = "disabled";
> +};
> +
> +/* Console UART */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +/* ttymxc4 UART */
> +&uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_otg1_id>;
> +	dr_mode = "otg";
> +	disable-over-current;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	dr_mode = "host";
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	/*
> +	 * To actually use ext-reset-output
> +	 * connect pins J17.3 & J17.8 on the Concerto-Board
> +	 */
> +	fsl,ext-reset-output;
> +};
> +
> +&usdhc1 {

Out of alphabetic order.

Shawn

> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
> +	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	status = "okay";
> +};
> 
> -- 
> 2.47.0.2.g7caf9f4c55.dirty
> 


