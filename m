Return-Path: <linux-kernel+bounces-286714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D16951E21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5570F1C20AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF431B3F1F;
	Wed, 14 Aug 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNjUEmDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6A1B3F16;
	Wed, 14 Aug 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648125; cv=none; b=S1g2V+a1yxe6hMalcVkz5ni4yWKOykV/HsMPVawb3U5TnoNP/ebaZjb0hjjmzYNeUTv1MTIrbrgvsHs2lS2XOvUNKZ4D+nglSlBEpOJRL4ZkB1IzW5DpZTplyXGSBcNHImgwBA9A4/DHCp8I4TuQF9sB5j76p/pHb8U8SZtplXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648125; c=relaxed/simple;
	bh=SZvyVh2V1+4Gp3vIv3/ZLR/kKe+e0kZautaIVLfreuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezkWAKihM7+27FnD6goLsTtIC4/4WndiRHnEmgu9JLbizSnDg+YRBFv/NMSzPDFWu9uOCKngaI5Bnc7DHLHj4omy3K5ArS/+G9wUtWPYrhaQvo0/DVL3mUzTqHO9E0+OXMIU+qFekkZgmbxzd3JzVTkNaRli5rl3i8YtMIqqbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNjUEmDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A0EC4AF09;
	Wed, 14 Aug 2024 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723648124;
	bh=SZvyVh2V1+4Gp3vIv3/ZLR/kKe+e0kZautaIVLfreuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YNjUEmDn1mSsXlW/vGysPxmLdl/k49FLh++MxjVDBMS8pojXhJV6U27kXmg8FPgZ1
	 iOBGUVuHmn3TJzxH2AHnAiKHRc7EcjVBE8jT1uBwJfu0L+chrwolPAfiyhrl3bVoPE
	 XQ8+yXPc3NTuCx3tCZmjE+5Prh+36faaWO4S1xM6iWs4sFugqPbcifmhW79l1ltWh/
	 X2M7NyA+sUrNrRA8MStAPuI8nhEMPDXPsctEnhLDWiuuYBN2VXCDSVtWF1xr+x45HY
	 8yMMXbC11feG52qEjwb3nTNJHqHpFeEfFkZufoWWba6KSjbMWnrCCOoS7Invj+6DTs
	 tgitiDVb8VddA==
Message-ID: <aac5ccf6-1b11-4ae8-857e-b344e0752212@kernel.org>
Date: Wed, 14 Aug 2024 17:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
To: Tarang Raval <tarang.raval@siliconsignals.io>, shawnguo@kernel.org,
 krzk+dt@kernel.org, festevam@gmail.com
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240814144957.93183-1-tarang.raval@siliconsignals.io>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240814144957.93183-1-tarang.raval@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 16:49, Tarang Raval wrote:
> This adds the following peripherals support for the Emtop i.MX8M Mini Baseboard
> 	* Wi-Fi
> 	* Audio
> 	* SD card
> 	* RTC
> 	* CAN bus
> 	* USB OTG
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  | 347 ++++++++++++++++++
>  .../boot/dts/freescale/imx8mm-emtop-som.dtsi  |   1 +
>  2 files changed, 348 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> index 7d2cb74c64ee..5ce8f21a0b1b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> @@ -11,6 +11,129 @@ / {
>  	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
>  	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
>  		"fsl,imx8mm";
> +
> +	extcon_usb: extcon_usb1otg {

Does not look like this follows DTS coding style.

Also, use generic node name - see other boards.

> +	        compatible = "linux,extcon-usb-gpio";
> +	        pinctrl-names = "default";
> +	        pinctrl-0 = <&pinctrl_extcon_usb>;
> +	        id-gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +	        enable-gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	modem_reset: modem-reset {
> +	        compatible = "gpio-reset";
> +	        reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> +	        reset-delay-us = <2000>;
> +	        reset-post-delay-ms = <40>;
> +	        #reset-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		beep {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		        label = "beep";
> +		        gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +		        default-state = "off";
> +		};
> +
> +		canbus_reset {

Really, no underscores...

> +			label = "canbus_reset";
> +			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
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
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

This is not a bus. No.

> +
> +		reg_audio: regulator-audio-vdd {
> +		        compatible = "regulator-fixed";
> +		        regulator-name = "wm8904_supply";
> +		        regulator-min-microvolt = <1800000>;
> +		        regulator-max-microvolt = <1800000>;
> +		        regulator-always-on;
> +		};
> +
> +		reg_wifi_vmmc: regulator@1 {

Heh? @1? What sort of bus is it?

> +			compatible = "regulator-fixed";
> +			regulator-name = "vmmc";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +			off-on-delay = <20000>;
> +			startup-delay-us = <100>;
> +		        enable-active-high;
> +		};
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
> +

Drop blank line.

> +};
> +
> +/* CAN BUS */
> +&ecspi2 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_ecspi2>;
> +        status = "okay";
> +
> +        canbus: mcp2515@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +                compatible = "microchip,mcp2515";
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&pinctrl_canbus>;
> +                reg = <0>;
> +                clocks = <&osc_can>;
> +                interrupt-parent = <&gpio1>;
> +                interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> +                spi-max-frequency = <10000000>;
> +                status = "okay";

Drop.

> +        };
>  };
>  
>  &fec1 {
> @@ -40,7 +163,130 @@ vddio: vddio-regulator {
>  	};
>  };
>  
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	rx8025: rtc@32 {
> +		compatible = "rx8025";
> +		reg = <0x32>;

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +	};
> +
> +	wm8904: wm8904@1a {
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
> +		status = "okay";

Where is it disabled?

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
> +/* Wifi */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_wifi_vmmc>;
> +	pm-ignore-notify;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	non-removable;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	brcmf: brcmf@1 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

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
> +        pinctrl-names = "default";      /* "state_100mhz", "state_200mhz"; */
> +        pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +        pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +        pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +        bus-width = <4>;
> +        status = "okay";
> +};
> +
> +/* USBOTG */
> +&usbotg1 {

Ordering looks odd. 'b' is before 'd'.


> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {

Do not upstream your code from vendor kernel directly. You *MUST* clean
it up from all downstream junk.


It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).



Best regards,
Krzysztof


