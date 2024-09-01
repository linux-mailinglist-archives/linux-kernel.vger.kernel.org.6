Return-Path: <linux-kernel+bounces-310145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C396757C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BDD1C20EEF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2815D143887;
	Sun,  1 Sep 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="T7CEVjhe"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492320DF4;
	Sun,  1 Sep 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725177567; cv=none; b=ZO8b0TweuTLEY4cTTJtAcCq7DNnHWVdBzma1ZLcL/T8vVs0S1BK6ysoJ4DuIvXGq0o+vdApQZrCpBEsIPVeMa3qycfDoPIQH99XnO+Zzs5lRGAvbgHLBP+ac5G777l/+dST6xah2YaeUSQj9b434gtMLMWBZ7z7C/oNkoeazJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725177567; c=relaxed/simple;
	bh=a2kidhWeojYryJ/xxzsSm6QTIlTXLqBi8GpnPi7z4L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ7hBErMbV6jpzFbpDdaLsbYSW7R69BxAN0d/DRFSfrmfsoIJ11DRk3M2LH1N9/LEQmlYw8kqTstR1wpWBcpnG5QH3+A0kSPs3BJZz+Z/T/HYkhQvfY2DJL3cvGLSsoP4iW0V7iSyub5h5HFYyLWah7UDnwin5p7iaZiWSQUPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=T7CEVjhe; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SW4e72Gn1WlbM1MAD5yKOvGbaTnltYqXI4s/S95ijb0=;
	b=T7CEVjhe0wsTg0qq7jwjBjbjiUrNqq0KbicqEyXc17A8JGb4H+I3ixiA73wLYH
	vTP1o7rmqzfbNPT/hhORWWIscNRS7hH3KySPcjXJFXzxAmup5tl62dGrfyhacZSR
	I/NXqfKCks2+Nkpma0MlE7khQkRYYOYw7SddQ0l16cQxE=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCnDja6HtRmujtDAA--.28677S3;
	Sun, 01 Sep 2024 15:58:52 +0800 (CST)
Date: Sun, 1 Sep 2024 15:58:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: shawnguo@kernel.org, krzk+dt@kernel.org, festevam@gmail.com,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <ZtQeumbOCfygsbMT@dragon>
References: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
X-CM-TRANSID:Mc8vCgCnDja6HtRmujtDAA--.28677S3
X-Coremail-Antispam: 1Uf129KBjvJXoWfGF48tw4xGw15WFyxJw43KFg_yoWDKFy5pr
	93A3yUGr1ktF1DAas5AFn7Wr15C397Wa1v9wnrua40kF4vvry7tFW5KF15CrWDJrs8Zw40
	gFyjvrW7urnIgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYuWLUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAxNZWbUC2IpzgAAsc

On Fri, Aug 23, 2024 at 05:31:57PM +0530, Tarang Raval wrote:
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard
> 
> 	* Wi-Fi
> 	* Audio
> 	* SD card
> 	* RTC
> 	* CAN bus
> 	* USB OTG
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
> 
> Changes in v2:
> 
> 1. Updated the node name and pinctrl name.
> 2. Removed the 'regulators' container.
> 3. Removed a stray blank line.
> 4. Removed non-existent properties.
> 5. Removed unused node and pinctrl:
>    -modem-reset
>    -pinctrl_uart1
> 6. Defined the CAN transceiver reset GPIO separately.
> 
> Change in v3:
> 
> 1. Removed 'can-connector'.
> 2. Use USB connector instead of extcon_usb.
> 3. Changed id-gpio to id-gpios.
> 4. Use Level trigger IRQ in the CAN node.
> 5. Corrected the compatible property of RTC.
> 6. Added blank lines to separate the pinctrl groups.
> ---
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  | 326 ++++++++++++++++++
>  1 file changed, 326 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> index 7d2cb74c64ee..0a7c8acd8f5d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> @@ -11,6 +11,113 @@ / {
>  	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
>  	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
>  		"fsl,imx8mm";
> +
> +	connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb_otg>;
> +		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			high_speed_ep: endpoint {
> +				remote-endpoint = <&usb_hs_ep>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		led-1 {
> +		        label = "buzzer";
> +		        gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +		        default-state = "off";
> +		};
> +	};
> +
> +	osc_can: clock-osc-can {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <16000000>;
> +		clock-output-names = "osc-can";
> +	};
> +
> +	reg_audio: regulator-audio {
> +	        compatible = "regulator-fixed";
> +	        regulator-name = "wm8904_supply";
> +	        regulator-min-microvolt = <1800000>;
> +	        regulator-max-microvolt = <1800000>;
> +	        regulator-always-on;
> +	};
> +
> +	reg_wifi_vmmc: regulator-wifi-vmmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100>;
> +		off-on-delay-us = <20000>;
> +	};
> +
> +	sound-wm8904 {
> +	        compatible = "simple-audio-card";
> +	        simple-audio-card,bitclock-master = <&dailink_master>;
> +	        simple-audio-card,format = "i2s";
> +	        simple-audio-card,frame-master = <&dailink_master>;
> +	        simple-audio-card,name = "wm8904-audio";
> +	        simple-audio-card,mclk-fs = <256>;
> +	        simple-audio-card,routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN2L", "Line In Jack",
> +			"IN2R", "Line In Jack",
> +			"Headphone Jack", "MICBIAS",
> +			"IN1L", "Headphone Jack";
> +
> +	        simple-audio-card,widgets =
> +	                "Microphone","Headphone Jack",
> +	                "Headphone", "Headphone Jack",
> +	                "Line", "Line In Jack";
> +
> +	        dailink_master: simple-audio-card,codec {
> +	                sound-dai = <&wm8904>;
> +	        };
> +
> +	        simple-audio-card,cpu {
> +	                sound-dai = <&sai3>;
> +	        };
> +	};
> +
> +	sound-spdif {
> +	        compatible = "fsl,imx-audio-spdif";
> +	        model = "imx-spdif";
> +	        spdif-controller = <&spdif1>;
> +	        spdif-out;
> +	        spdif-in;
> +	};
> +};
> +
> +/* CAN BUS */
> +&ecspi2 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_ecspi2>;
> +        status = "okay";
> +
> +        can: can@0 {
> +                compatible = "microchip,mcp2515";
> +                reg = <0>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&pinctrl_canbus>;
> +                clocks = <&osc_can>;
> +                interrupt-parent = <&gpio1>;
> +                interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
> +                spi-max-frequency = <10000000>;
> +        };
>  };
>  
>  &fec1 {
> @@ -40,7 +147,129 @@ vddio: vddio-regulator {
>  	};
>  };
>  
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	rtc@32 {
> +		compatible = "epson,rx8025";
> +		reg = <0x32>;
> +	};
> +
> +	wm8904: audio-codec@1a {

Could you sort I2C device nodes in slave/unit address?

> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> +		clock-names = "mclk";
> +		DCVDD-supply = <&reg_audio>;
> +		DBVDD-supply = <&reg_audio>;
> +		AVDD-supply = <&reg_audio>;
> +		CPVDD-supply = <&reg_audio>;
> +		MICVDD-supply = <&reg_audio>;
> +	};
> +};
> +
> +/* AUDIO */
> +&sai3 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_sai3>;
> +        assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> +        assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +        assigned-clock-rates = <24576000>;
> +        status = "okay";
> +};
> +
> +&spdif1 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_spdif1>;
> +        assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
> +        assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +        assigned-clock-rates = <24576000>;
> +        clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
> +                <&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
> +                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
> +                <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
> +                <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
> +                <&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
> +        clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
> +                "rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
> +        status = "okay";
> +};
> +
> +/* USBOTG */
> +&usbotg1 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		usb_hs_ep: endpoint {
> +			remote-endpoint = <&high_speed_ep>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +        dr_mode = "host";
> +        status = "okay";
> +};
> +
> +/* Wifi */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_wifi_vmmc>;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	non-removable;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Could you move these two into the property list above which ends with
'status'?

Shawn

> +	wifi: wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +/* SD-card */
> +&usdhc2 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_usdhc2>;
> +        pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +        pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +        bus-width = <4>;
> +        status = "okay";
> +};
> +
>  &iomuxc {
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_SS0_ECSPI2_SS0  		0x82
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
> +		>;
> +	};
> +
> +	pinctrl_usb_otg: usbotggrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x140   /* otg_id */
> +			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x19    /* otg_vbus */
> +		>;
> +	};
> +
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
> @@ -60,4 +289,101 @@ MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
>  			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                0x19
>  		>;
>  	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +	        fsl,pins = <
> +	                MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL                  0x400001c3
> +	                MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA                  0x400001c3
> +	        >;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +	        fsl,pins = <
> +	                MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC             0xd6
> +	                MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK              0xd6
> +	                MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK                0xd6
> +	                MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0             0xd6
> +	                MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0             0xd6
> +	        >;
> +	};
> +
> +	pinctrl_spdif1: spdif1grp {
> +	        fsl,pins = <
> +	                MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT                0xd6
> +	        >;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK                 0x190
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                 0x1d0
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0             0x1d0
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1             0x1d0
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2             0x1d0
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3             0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp{
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x194
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     	0x1d4
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         	0x196
> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     	0x1d6
> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     	0x1d6
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10             0x41    /* wl_reg_on */
> +			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9                0x41    /* wl_host_wake */
> +			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K      0x141   /* LP0: 32KHz */
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +	        fsl,pins = <
> +	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x190
> +	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d0
> +	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d0
> +	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d0
> +	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d0
> +	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d0
> +	        >;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +	        fsl,pins = <
> +	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x194
> +	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d4
> +	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d4
> +	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d4
> +	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d4
> +	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d4
> +	        >;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +	        fsl,pins = <
> +	                MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         	0x196
> +	                MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         	0x1d6
> +	                MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     	0x1d6
> +	                MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     	0x1d6
> +	                MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     	0x1d6
> +	                MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     	0x1d6
> +	        >;
> +	};
>  };
> -- 
> 2.34.1
> 


