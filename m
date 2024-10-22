Return-Path: <linux-kernel+bounces-375745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D619A9A47
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4996DB21502
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947761494A3;
	Tue, 22 Oct 2024 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iuC9htlc"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF321811F1;
	Tue, 22 Oct 2024 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580006; cv=none; b=rxPQwU87PW93FDEVcmKGk/xo0GksiLR8nUjuz8RWc0W6IeYl04097kwxAMbPBSMOatYTVo8HXrXtqOJ+ZuI1aaozAZrX4WrNJ3v7fSpDPf7ZbVAlsbLLDdSwGnuvm2MSUo4GBa/ryakQ6MCuytUzWvXTHjWFVUTy3NIluQllxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580006; c=relaxed/simple;
	bh=QabyGLfGo9D7o0GeOOFH5A21VcpbZCBSnnjRALjpon4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXo2Btpgfz9KUSA2sDO1XP9sR1uiW47T912HIQZpruCr5jvxFtGUfCObCSzKc71HfueiHEKwc7DyVL5GML8I3w9TE2SIXOVzv4TxQBsuulLQAELH9Z6OgLsURgVzLvQw2zD8hicc17hyrii5BWzFjPTLEfu3PDUfcksVbcnRfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iuC9htlc; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3Ey0LprXeMFdSZgnRemkWeQFZ8Dckiqkz1H7LCPkZU0=;
	b=iuC9htlcqSX5c4f2NBRBhYRrIVS+/Klg6R/JBdfnNLyigMCrSD67OQPu8aCMTJ
	676T6Xsiv+kW1Uvx1lYWx3PRI8HcsHb5mNzjVwA8lVqkiDkaM5AS5e6o7PU1ocnr
	jU4UHwCahSmnvPn2OaCakb526YuZf1CIbiGEn2ZwVlFUI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgA3fzWOSxdna7mXAA--.5542S3;
	Tue, 22 Oct 2024 14:52:00 +0800 (CST)
Date: Tue, 22 Oct 2024 14:51:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: shawnguo@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP
 Universal SMARC Carrier Board
Message-ID: <ZxdLjtXfuknBywru@dragon>
References: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
 <20241018091023.29286-2-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018091023.29286-2-bhavin.sharma@siliconsignals.io>
X-CM-TRANSID:Mc8vCgA3fzWOSxdna7mXAA--.5542S3
X-Coremail-Antispam: 1Uf129KBjvJXoWfGFy5KFy7Kr4rCrWDWrWfXwb_yoWkKFWfpr
	9ay39rCrnYyr1fAFykGF12kr15ZaykK3Wv934DWFy0yrWqyasrXrZY9Fn8Gr4DJws8Zw48
	ZFW8ZrWIkFnrKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4mhrUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQqAZWcXFF+d1QAAsV

On Fri, Oct 18, 2024 at 02:39:27PM +0530, Bhavin Sharma wrote:
> Adds the DTSI file for the Nitrogen8MP SMARC System on Module which
> is delivered with the Nitrogen8MP Universal SMARC Carrier Board.
> 
> Initial support includes:
> - Serial console
> - eMMC
> - SD card
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 349 ++++++++++++++++++
>  .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
>  3 files changed, 367 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 9d3df8b218a2..c7f4cf51dc14 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
> new file mode 100644
> index 000000000000..89f820ddad54
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Boundary Devices
> + * Copyright 2024 Silicon Signals Pvt. Ltd.
> + *
> + * Author : Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "imx8mp.dtsi"
> +
> +/ {
> +        model = "Boundary Device Nitrogen8MP SMARC SoM";
> +        compatible = "boundary,imx8mp-nitrogen-smarc-som", "fsl,imx8mp";

Use tab instead of space for indent.

It appears there are quite many such cases in this patch.

> +
> +	chosen {
> +        	stdout-path = &uart2;
> +	};
> +	
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
> +	        compatible = "regulator-fixed";
> +	        regulator-name = "VSD_3V3";
> +	        regulator-min-microvolt = <3300000>;
> +	        regulator-max-microvolt = <3300000>;
> +	        gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +	        enable-active-high;
> +	};
> +};
> +
> +&A53_0 {
> +        cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +        cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +        cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +        cpu-supply = <&buck2>;
> +};
> +
> +&i2c1 {
> +        clock-frequency = <400000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_i2c1>;
> +        status = "okay";
> +
> +        pmic@25 {
> +                compatible = "nxp,pca9450c";
> +                reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> +
> +                regulators {
> +                        buck1: BUCK1 {
> +                                regulator-name = "BUCK1";
> +                                regulator-min-microvolt = <600000>;
> +                                regulator-max-microvolt = <2187500>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                                regulator-ramp-delay = <3125>;
> +                        };
> +
> +                        buck2: BUCK2 {
> +                                regulator-name = "BUCK2";
> +                                regulator-min-microvolt = <600000>;
> +                                regulator-max-microvolt = <2187500>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                                regulator-ramp-delay = <3125>;
> +                                nxp,dvs-run-voltage = <950000>;
> +                                nxp,dvs-standby-voltage = <850000>;
> +                        };
> +
> +                        buck4: BUCK4 {
> +                                regulator-name = "BUCK4";
> +                                regulator-min-microvolt = <600000>;
> +                                regulator-max-microvolt = <3400000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        buck5: BUCK5 {
> +                                regulator-name = "BUCK5";
> +                                regulator-min-microvolt = <600000>;
> +                                regulator-max-microvolt = <3400000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        buck6: BUCK6 {
> +                                regulator-name = "BUCK6";
> +                                regulator-min-microvolt = <600000>;
> +                                regulator-max-microvolt = <3400000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        ldo1: LDO1 {
> +                                regulator-name = "LDO1";
> +                                regulator-min-microvolt = <1600000>;
> +                                regulator-max-microvolt = <3300000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        ldo2: LDO2 {
> +                                regulator-name = "LDO2";
> +                                regulator-min-microvolt = <800000>;
> +                                regulator-max-microvolt = <1150000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        ldo3: LDO3 {
> +                                regulator-name = "LDO3";
> +                                regulator-min-microvolt = <800000>;
> +                                regulator-max-microvolt = <3300000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        ldo4: LDO4 {
> +                                regulator-name = "LDO4";
> +                                regulator-min-microvolt = <800000>;
> +                                regulator-max-microvolt = <3300000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +
> +                        ldo5: LDO5 {
> +                                regulator-name = "LDO5";
> +                                regulator-min-microvolt = <1800000>;
> +                                regulator-max-microvolt = <3300000>;
> +                                regulator-boot-on;
> +                                regulator-always-on;
> +                        };
> +                };
> +        };
> +};
> +
> +&i2c6 {
> +        clock-frequency = <100000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_i2c6>;
> +        status = "okay";
> +
> +	mcp23018: gpio@20 {
> +	        compatible = "microchip,mcp23018";
> +	        gpio-controller;
> +	        #gpio-cells = <0x2>;
> +	        reg = <0x20>;
> +	        interrupts-extended = <&gpio4 22 IRQ_TYPE_LEVEL_LOW>;
> +	        interrupt-controller;
> +	        #interrupt-cells = <0x2>;
> +	        microchip,irq-mirror;
> +	        pinctrl-names = "default";
> +	        pinctrl-0 = <&pinctrl_mcp23018>;
> +	        reset-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +/* Console */
> +&uart2 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_uart2>;
> +        status = "okay";
> +};
> +
> +/* eMMC */
> +&usdhc1 {
> +        pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +        pinctrl-0 = <&pinctrl_usdhc1>;
> +        pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +        pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +        bus-width = <8>;
> +        non-removable;
> +        status = "okay";
> +};
> +
> +/* SD-card */
> +&usdhc2 {
> +        pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +        pinctrl-0 = <&pinctrl_usdhc2>;
> +        pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +        pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +        vmmc-supply = <&reg_usdhc2_vmmc>;
> +        bus-width = <4>;
> +        status = "okay";
> +};
> +
> +&wdog1 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_wdog>;
> +        fsl,ext-reset-output;
> +        status = "okay";
> +};
> +	
> +&iomuxc {
> +

Unneeded newline.

Shawn

> +	pinctrl_gpio_led: gpioledgrp {
> +	        fsl,pins = <
> +	                MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10                     	0x19
> +	        >;
> +	};
> +	
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL					0x400001c3
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA					0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c6: i2c6grp {
> +	        fsl,pins = <
> +	                MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL            			0x400001c3
> +	                MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA                 		0x400001c3
> +	        >;
> +	};
> +	
> +	pinctrl_mcp23018: mcp23018grp {
> +	        fsl,pins = <
> +        	        MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22            			0x1c0
> +                	MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27             			0x100
> +        	>;
> +	};
> +	
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14				0x1c0
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +	        fsl,pins = <
> +	                MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX                            0x40
> +	                MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX                            0x40
> +	        >;
> +	};
> +        
> +        pinctrl_usdhc1: usdhc1grp {
> +                fsl,pins = <
> +                        MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x10
> +                        MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x150
> +                        MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x150
> +                        MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x150
> +                        MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x10
> +                        MX8MP_IOMUXC_SD1_RESET_B__USDHC1_RESET_B 			0x140
> +                >;
> +        };
> +
> +        pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +                fsl,pins = <
> +                        MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x14
> +                        MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x154
> +                        MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x154
> +                        MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x154
> +                        MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x14
> +                >;
> +        };
> +
> +        pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +                fsl,pins = <
> +                        MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK        			0x12
> +                        MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD        			0x152
> +                        MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA4__USDHC1_DATA4    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA5__USDHC1_DATA5    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA6__USDHC1_DATA6    			0x152
> +                        MX8MP_IOMUXC_SD1_DATA7__USDHC1_DATA7    			0x152
> +                        MX8MP_IOMUXC_SD1_STROBE__USDHC1_STROBE  			0x12
> +                >;
> +        };
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +                fsl,pins = <
> +                        MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x190
> +                        MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d0
> +                        MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d0
> +                        MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d0
> +                        MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d0
> +                        MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d0
> +                >;
> +        };
> +
> +        pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +                fsl,pins = <
> +                        MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x194
> +                        MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d4
> +                        MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d4
> +                        MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d4
> +                        MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d4
> +                        MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d4
> +                >;
> +        };
> +
> +        pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +                fsl,pins = <
> +                        MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK                                0x196
> +                        MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD                                0x1d6
> +                        MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0                            0x1d6
> +                        MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1                            0x1d6
> +                        MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2                            0x1d6
> +                        MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3                            0x1d6
> +                >;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B				0x140
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts
> new file mode 100644
> index 000000000000..4a08fa38dcde
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Boundary Devices
> + * Copyright 2024 Silicon Signals Pvt. Ltd.
> + *
> + * Author : Bhavin Sharma <bhavin.sharma@siliconsignals.io> 
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mp-nitrogen-smarc-som.dtsi"
> +
> +/ {
> +	model = "Boundary Device Nitrogen8MP Universal SMARC Carrier Board";
> +	compatible = "boundary,imx8mp-nitrogen-smarc-universal-board", 
> +			"boundary,imx8mp-nitrogen-smarc-som", "fsl,imx8mp";
> +};
> -- 
> 2.43.0
> 


