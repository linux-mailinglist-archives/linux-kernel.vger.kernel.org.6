Return-Path: <linux-kernel+bounces-393759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B79BA4E5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9911F218A8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF2158D87;
	Sun,  3 Nov 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ajM9f15y"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C124430;
	Sun,  3 Nov 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730626935; cv=none; b=bTmgRZMxB/vulvseZXI9rhi9CiVnS1sK+2A5CcaxnfxPRH8LR/iMXzk0uY3qO9aQwjGRogaEmQAfRWoQIvMGomt/8V0Zb9vrdyiF+kol1S1FWH1tSzVLxLVTooB8ua3gpGKBJqonAZriBo0te6q16sI9Lv0wosUI9l709jzk18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730626935; c=relaxed/simple;
	bh=cZxwdJqEF4aV/Id6tMuBM/Tmyw0egE4tRWZspLjDTgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmOHocjY+MjdhUggzFytH/WtmUNnI5hlSYCPUtpdLVTMMOUdkfer4rC/khKsYZIWC4eEpVnp7wgc7vsR+4X0LJuYT46qMqJmWh4Nqbs3X+tVOpT7KwDgPem+mjND0tCbOWVxDXYvNjIgYXk7eA/3S47hDFwhkE222ERTwU3RG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ajM9f15y; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gG3g4T/V6QXJNP3M75v7lRnmYRX1pDXFI55Y6KYmLLE=;
	b=ajM9f15y7uUiIc3dJLr5X26AVfkZXRzq5RjyHWUgexfwmkMynXnuhPQdu3Nkr+
	jW/JIF5WjmvJZVIxwU8NcdbKpy3HBMF2TUteu5n83ANaaPIHZnEGa4dqwEtOt/UL
	frGMte7Ct/LKQzQBmAQ00B5tjjo063ou6UqSWV384xGhs=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAHzjY7RSdnHaOOAQ--.15656S3;
	Sun, 03 Nov 2024 17:41:17 +0800 (CST)
Date: Sun, 3 Nov 2024 17:41:15 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp: add aristainetos3 board
 support
Message-ID: <ZydFO6b6oe9widaa@dragon>
References: <20241031151238.67753-1-hs@denx.de>
 <20241031151238.67753-4-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031151238.67753-4-hs@denx.de>
X-CM-TRANSID:M88vCgAHzjY7RSdnHaOOAQ--.15656S3
X-Coremail-Antispam: 1Uf129KBjvAXoWDXF4kJryfGFWkJr48urWxJFb_yoWrZrWkuo
	WYvFn5AF4UK34UZ3ZxKr17Cw4UXrn3Kr43KayDtrW3GF1ftFZYy342gayjqr48tr1FqFyk
	CayfGa4rAayIvw1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc8nYDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQyMZWcmsdbyxgABs-

On Thu, Oct 31, 2024 at 04:12:37PM +0100, Heiko Schocher wrote:
> Add support for the i.MX8MP based aristainetos3 boards from ABB.
> 
> The board uses a ABB specific SoM from ADLink, based on NXP
> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
> with small differences.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
> Changes in v2:
> - worked in comments from Krzysztof
>   - removed unneeded dtbos and build now dtbs for each
>     carrierboard.
>   - removed user spidev entries, as I do not know the
>     real spi devices connected to...
>   - call dtb check targets as described in cover letter
>     and fixed warnings except warnings see below:
> not fixed dtb check warnings
> - pci (warning pops up for each new dtb from this patch, but
>   also for a lot of other boards, which are already in tree)
> imx8mp-aristainetos3-adpismarc.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> imx8mp-aristainetos3-adpismarc.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
>         from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
> - proton2s dtb specific:
>   - rs485
>     imx8mp-aristainetos3-proton2s.dtb: serial@30a60000: rs485-rts-delay:0: 0 is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/serial/fsl-imx-uart.yaml#
>     imx8mp-aristainetos3-proton2s.dtb: serial@30a60000: rs485-rts-delay:1: 0 is not of type 'array'
>         from schema $id: http://devicetree.org/schemas/serial/fsl-imx-uart.yaml#
>     imx8mp-aristainetos3-proton2s.dtb: serial@30a60000: Unevaluated properties are not allowed ('linux,rs485-enabled-at-boot-time', 'rs485-rts-active-low', 'rs485-rts-delay' were unexpected)
>         from schema $id: http://devicetree.org/schemas/serial/fsl-imx-uart.yaml#
>     do not see, what I am doing wrong, also rs485 works fine
>   - led driver
>     imx8mp-aristainetos3-proton2s.dtb: /soc@0/bus@30800000/i2c@30a30000/tlc59108@40: failed to match any schema with compatible: ['ti,tlc59108']
>     I use the comaptible entry used in drivers/leds/leds-tlc591xx.c
>     Ah, may because file
>     Documentation/devicetree/bindings/leds/leds-tlc591xx.txt
>     is not converted to yaml?
>   - pinctrl driver
>     adding 'gpio-line-names' leads in a warning as this property
>     is not checked yet (and so a warning is dropped).
>     add this check in new patch
>     dt-bindings: pinctrl: sx150xq: allow gpio line naming
>     in v2
> 
>  arch/arm64/boot/dts/freescale/Makefile        |    5 +
>  .../imx8mp-aristainetos3-adpismarc.dts        |   38 +
>  .../imx8mp-aristainetos3-helios-lvds.dtso     |  115 ++
>  .../freescale/imx8mp-aristainetos3-helios.dts |   99 ++
>  .../imx8mp-aristainetos3-proton2s.dts         |  162 +++
>  .../imx8mp-aristainetos3a-som-v1.dtsi         | 1116 +++++++++++++++++
>  6 files changed, 1535 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 9d3df8b218a2..40dcd24bf494 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -163,6 +163,11 @@ imx8mn-tqma8mqnl-mba8mx-usbotg-dtbs += imx8mn-tqma8mqnl-mba8mx.dtb imx8mn-tqma8m
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-lvds-tm070jvhg33.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-usbotg.dtb
>  
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-adpismarc.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-helios.dtb
> +imx8mp-aristainetos3-helios-lvds-dtbs += imx8mp-aristainetos3-helios.dtb imx8mp-aristainetos3-helios-lvds.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-helios-lvds.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-proton2s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dts
> new file mode 100644
> index 000000000000..4e50f53b5b08
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx8mp-aristainetos3a-som-v1.dtsi"
> +
> +&{/} {
> +	model = "Aristainetos3 ADLink PI SMARC carrier";
> +	compatible = "abb,imx8mp-aristanetos3-adpismarc",
> +		     "abb,imx8mp-aristanetos3-som",
> +		     "fsl,imx8mp";
> +};
> +
> +&i2c2 {
> +	gpio8: pinctrl@3e {
> +		compatible = "semtech,sx1509q";
> +		reg = <0x3e>;
> +
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		semtech,probe-reset;
> +		gpio-controller;
> +		interrupt-controller;
> +

Nit: can we drop these newlines in middle of property list?

> +		interrupt-parent = <&gpio6>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +};
> +
> +&flexcan1 {

Try to keep labeling nodes alphabetically.

> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
> new file mode 100644
> index 000000000000..db73b9b3870a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	model = "Aristainetos3 helios carrier with LVDS";
> +	compatible = "abb,imx8mp-aristanetos3-helios",
> +		     "abb,imx8mp-aristanetos3-som",
> +		     "fsl,imx8mp";
> +
> +	panel_lvds: panel-lvds {
> +		compatible = "lg,lb070wv8";
> +		power-supply = <&reg_vcc_disp>;
> +		backlight = <&lvds_backlight>;
> +
> +		port {
> +			in_lvds0: endpoint {
> +				remote-endpoint = <&ldb_lvds_ch0>;
> +			};
> +		};
> +	};
> +
> +	reg_vcc_disp: regulator-disp {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd0_vcc_en>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "disp_power_en_2v8";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;

Have enable-active-high here.

> +		regulator-boot-on;
> +		regulator-always-on;
> +		enable-active-high;
> +	};
> +
> +

Unneeded newlines.

> +};
> +
> +&gpio3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio3_hog>;
> +
> +	lvdssel-hog {
> +		gpio-hog;
> +		gpios = <23 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "LVDSSEL";
> +	};
> +};
> +
> +&hdmi_blk_ctrl {
> +	status = "disabled";
> +};
> +
> +&hdmi_pvi {
> +	status = "disabled";
> +};
> +
> +&hdmi_tx {
> +	status = "disabled";
> +};
> +
> +&hdmi_tx_phy {
> +	status = "disabled";
> +};
> +
> +&irqsteer_hdmi {
> +	status = "disabled";
> +};
> +
> +&ldb_lvds_ch0 {
> +	remote-endpoint = <&in_lvds0>;
> +};
> +
> +&lcdif1 {
> +	status = "disabled";
> +};
> +
> +&lcdif2 {
> +	status = "okay";
> +};
> +
> +&lcdif3 {
> +	status = "disabled";
> +};
> +
> +&lvds_backlight {
> +	status = "okay";
> +};
> +
> +&lvds_bridge {
> +	/* IMX8MP_CLK_MEDIA_LDB = IMX8MP_CLK_MEDIA_DISP2_PIX * 7 */
> +	assigned-clock-rates = <232820000>;
> +	status = "okay";
> +};
> +
> +&media_blk_ctrl {
> +	/*
> +	 * currently it is not possible to let display clocks configure
> +	 * automatically, so we need to set them manually
> +	 */
> +	assigned-clock-rates = <500000000>, <200000000>, <0>,
> +		/* IMX8MP_CLK_MEDIA_DISP2_PIX = pixelclk of lvds panel */
> +		<33260000>, <0>,
> +		/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_LDB * 2 */
> +		<465640000>;
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts
> new file mode 100644
> index 000000000000..1313c80d28ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx8mp-aristainetos3a-som-v1.dtsi"
> +
> +&{/} {
> +	model = "Aristainetos3 helios carrier";
> +	compatible = "abb,imx8mp-aristanetos3-helios",
> +		     "abb,imx8mp-aristanetos3-som",
> +		     "fsl,imx8mp";
> +
> +	led-controller {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			function-enumerator = <20>;
> +			gpios = <&pca6416 12 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function-enumerator = <20>;
> +			gpios = <&pca6416 13 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		led-2 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function-enumerator = <20>;
> +			gpios = <&pca6416 14 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +

One newline is good enough.

> +		led-3 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_BLUE>;
> +			function-enumerator = <20>;
> +			gpios = <&pca6416 15 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&ethphy1 {
> +	status = "disabled";
> +};
> +
> +&fec {
> +	status = "disabled";
> +};
> +
> +&i2c1 {
> +	eeprom@57 {
> +		compatible = "atmel,24c64";
> +		reg = <0x57>;
> +	};
> +};
> +
> +&i2c3 {
> +	pca6416: gpio@20 {
> +		compatible = "ti,tca6416";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "DIN0_CON",
> +			"DIN1_CON",
> +			"DIN2_CON",
> +			"DIN3_CON",
> +			"DIN4_CON",
> +			"DIN5_CON",
> +			"DIN6_CON",
> +			"DIN7_CON",
> +			"PM102_RES",
> +			"COMx_RES",
> +			"BPL_RES",
> +			"PC_RES",
> +			"LED_RED",
> +			"LED_YELLOW",
> +			"LED_GREEN",
> +			"LED_BLUE";
> +	};
> +
> +	rtc@68 {
> +		compatible = "st,m41t00";
> +		reg = <0x68>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
> new file mode 100644
> index 000000000000..0dd491fbf67a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "imx8mp-aristainetos3a-som-v1.dtsi"
> +
> +&{/} {
> +	model = "Aristainetos3 proton2s carrier";
> +	compatible = "abb,imx8mp-aristanetos3-proton2s",
> +		     "abb,imx8mp-aristanetos3-som",
> +		     "fsl,imx8mp";
> +
> +	watchdog {
> +		/* MAX6371KA */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_watchdog_gpio>;
> +		compatible = "linux,wdt-gpio";

Begin property list with compatible.

> +		always-running;
> +		gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +		hw_algo = "level";
> +		/* Reset triggers in 3..9 seconds */
> +		hw_margin_ms = <1500>;
> +		status = "okay";

Unneeded "okay" status.

> +	};
> +};
> +
> +&ethphy1 {
> +	status = "disabled";
> +};
> +
> +&eqos {
> +	max-speed = <100>;
> +};
> +
> +&ecspi1{
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +};
> +
> +&fec {
> +	status = "disabled";
> +};
> +
> +&gpio1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio_proton2s>;
> +
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "POWER",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "", "", "", "";
> +};
> +
> +&gpio6 {
> +	gpio-line-names =
> +		"RELAY0", "RELAY1", "RELAY2",
> +		"HEATER", "FAN", "SPARE",
> +		"CLEAR", "FAULT";
> +};
> +
> +&i2c2 {
> +	tlc59108@40 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,tlc59108";
> +		reg = <0x40>;

Begin property list with compatible and reg.

> +
> +		led@0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			function-enumerator = <20>;
> +			reg = <0x0>;

Move 'reg' up.

> +		};
> +
> +		led@1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function-enumerator = <20>;
> +			reg = <0x1>;
> +		};
> +
> +		led@2 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function-enumerator = <21>;
> +			reg = <0x2>;
> +		};
> +
> +		led@3 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			function-enumerator = <21>;
> +			reg = <0x3>;
> +		};
> +
> +		led@4 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_BLUE>;
> +			function-enumerator = <21>;
> +			reg = <0x4>;
> +		};
> +
> +		led@5 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			function-enumerator = <22>;
> +			reg = <0x5>;
> +		};
> +
> +		led@6 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function-enumerator = <22>;
> +			reg = <0x6>;
> +		};
> +
> +		led@7 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_BLUE>;
> +			function-enumerator = <22>;
> +			reg = <0x7>;
> +		};
> +	};
> +
> +	rtc1: rtc@68 {
> +		compatible = "dallas,ds1339";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-0 = <&pinctrl_uart1>;
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&pinctrl_uart2>;
> +};
> +
> +&uart3 {
> +	pinctrl-0 = <&pinctrl_uart3>;
> +};
> +
> +&uart4 {
> +	linux,rs485-enabled-at-boot-time;
> +	rs485-rts-active-low;
> +	rs485-rts-delay = <0 0>;
> +	rts-gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usdhc1 {
> +	status = "disabled";
> +};
> +
> +&wdog1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> new file mode 100644
> index 000000000000..ced35e1d72b7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> @@ -0,0 +1,1116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "imx8mp.dtsi"
> +
> +/ {
> +	model = "ADLINK LEC-iMX8MP-Q-N-4G-32G";
> +	compatible = "abb,imx8mp-aristanetos3-som", "fsl,imx8mp";
> +
> +	aliases {
> +		mmc0 = &usdhc3;	/* eMMC */
> +		mmc1 = &usdhc2;	/* MicroSD */
> +		ethernet0 = &eqos;
> +		ethernet1 = &fec;

Sort them alphabetically.

> +	};
> +
> +	chosen {
> +		bootargs = "console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200";
> +		stdout-path = &uart2;
> +	};
> +
> +	connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +
> +		port {
> +			usb_dr_connector: endpoint {
> +				remote-endpoint = <&usb3_dwc>;
> +			};
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_YELLOW>;
> +			function-enumerator = <0>;
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};
> +	};
> +
> +	lvds_backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lvds_bklt_en>;
> +		pwms = <&pwm2 0 50000 0>;
> +		enable-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +		status = "disabled";

Move 'status' to the end of property list.

> +
> +		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
> +				     10 11 12 13 14 15 16 17 18 19
> +				     20 21 22 23 24 25 26 27 28 29
> +				     30 31 32 33 34 35 36 37 38 39
> +				     40 41 42 43 44 45 46 47 48 49
> +				     50 51 52 53 54 55 56 57 58 59
> +				     60 61 62 63 64 65 66 67 68 69
> +				     70 71 72 73 74 75 76 77 78 79
> +				     80 81 82 83 84 85 86 87 88 89
> +				     90 91 92 93 94 95 96 97 98 99
> +				    100>;
> +		default-brightness-level = <80>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/* Memory size 512 MiB..8 GiB will be filled by U-Boot */
> +		reg = <0x0 0x40000000 0 0x08000000>;
> +	};
> +
> +	pcie0_refclk: pcie0-refclk {

Can we name the node clock-xxx?

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	reg_can1_stby: regulator-can1-stby {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan1_reg>;

> +		enable-active-high;
> +		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;

Flip these two.

> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "can1-stby";
> +	};
> +
> +	reg_can2_stby: regulator-can2-stby {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan2_reg>;
> +		enable-active-high;
> +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "can2-stby";
> +	};
> +
> +	reg_dp83867_2v5: regulator-enet {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio7 15 GPIO_ACTIVE_HIGH>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "enet_2v5";
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb1_host_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usb1_vbus>;
> +		enable-active-high;
> +		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "usb1_host_vbus";
> +		regulator-always-on;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
> +		enable-active-high;
> +		gpio = <&gpio2 19 0>; /* SD2_RESET */

GPIO_ACTIVE_HIGH

> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VDD_3V3_SD";
> +		off-on-delay-us = <12000>;
> +		startup-delay-us = <100>;
> +		vin-supply = <&buck4>;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&clk {
> +	clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
> +		 <&clk_ext3>, <&clk_ext4>;
> +	clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
> +		      "clk_ext3", "clk_ext4";
> +	assigned-clocks = <&clk IMX8MP_CLK_A53_SRC>,
> +			  <&clk IMX8MP_CLK_A53_CORE>,
> +			  <&clk IMX8MP_CLK_NOC>,
> +			  <&clk IMX8MP_CLK_NOC_IO>,
> +			  <&clk IMX8MP_CLK_GIC>,
> +			  <&clk IMX8MP_CLK_AUDIO_AHB>,
> +			  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>,
> +			  <&clk IMX8MP_AUDIO_PLL1>,
> +			  <&clk IMX8MP_AUDIO_PLL2>,
> +			  <&clk IMX8MP_VIDEO_PLL1>;
> +};
> +
> +&ecspi1{
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs2>;
> +	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW &gpio1 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&ecspi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +/* eth0 */
> +&eqos {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eqos_rgmii>;
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	snps,force_thresh_dma_mode;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: eqos-ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +			ti,min-output-impedance;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
> +			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use = <5>;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x1>;
> +		};

Have a newline between nodes.

> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x2>;
> +		};
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x4>;
> +		};
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x8>;
> +		};
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0xf0>;
> +		};
> +	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <5>;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x1>;
> +			snps,map-to-dma-channel = <0>;
> +		};
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x2>;
> +			snps,map-to-dma-channel = <1>;
> +		};
> +		queue2 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x4>;
> +			snps,map-to-dma-channel = <2>;
> +		};
> +		queue3 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0x8>;
> +			snps,map-to-dma-channel = <3>;
> +		};
> +		queue4 {
> +			snps,dcb-algorithm;
> +			snps,priority = <0xf0>;
> +			snps,map-to-dma-channel = <4>;
> +		};
> +	};
> +

Unneeded newline.

> +};
> +
> +/* eth1 */
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec_rgmii>;
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +			reset-gpio = <&gpio4 2 GPIO_ACTIVE_LOW>;
> +
> +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
> +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_75_NS>;
> +			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +

Nit: no newline in middle of property list.

> +			ti,min-output-impedance;
> +			ti,dp83867-rxctrl-strap-quirk;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can1_stby>;
> +	status = "disabled";
> +};
> +
> +&flexcan2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_can1_stby>;
> +	status = "disabled";
> +};
> +
> +&hdmi_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&hdmi_pvi {
> +	status = "okay";
> +};
> +
> +&hdmi_tx {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi>;
> +	status = "okay";
> +};
> +
> +&hdmi_tx_phy {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	scl-gpios = <&gpio5 14 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	pmic: pmic@25 {
> +		compatible = "nxp,pca9450c";
> +		reg = <0x25>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		/*
> +		 * i.MX 8M Plus Data Sheet for Consumer Products
> +		 * 3.1.4 Operating ranges
> +		 * MIMX8ML8CVNKZAB
> +		 */
> +		regulators {
> +			buck1: BUCK1 {	/* VDD_SOC (dual-phase with BUCK3) */
> +				regulator-name = "buck1";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-ramp-delay = <3125>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck2: BUCK2 {	/* VDD_ARM */
> +				regulator-name = "buck2";
> +				nxp,dvs-run-voltage = <950000>;
> +				nxp,dvs-standby-voltage = <850000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-ramp-delay = <3125>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck4: BUCK4 {	/* VDD_3V3 */
> +				regulator-name = "buck4";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck5: BUCK5 {	/* VDD_1V8 */
> +				regulator-name = "buck5";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck6: BUCK6 {	/* NVCC_DRAM_1V1 */
> +				regulator-name = "buck6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo1: LDO1 {	/* NVCC_SNVS_1V8 */
> +				regulator-name = "ldo1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo2: LDO2 {	/* VDDA_1V8 */
> +				regulator-name = "ldo2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo3: LDO3 {	/* VDDA_1V8 */
> +				regulator-name = "ldo3";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4: LDO4 {	/* PMIC_LDO4 */
> +				regulator-name = "ldo4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo5: LDO5 {	/* NVCC_SD2 */
> +				regulator-name = "ldo5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
> +	scl-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	#address-cells = <1>;
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c5>;
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c6>;
> +	pinctrl-1 = <&pinctrl_i2c6_gpio>;
> +	scl-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	/* TPM - ST33TPHF2XI2C U2301 */
> +	tpm: tpm@2e {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tpm_irq>;
> +		compatible = "st,st33ktpm2xi2c", "tcg,tpm-tis-i2c";
> +		reg = <0x2e>;
> +
> +		label = "tpm";
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
> +		status = "okay";
> +	};
> +
> +	/* SX1509(0) U2605 */
> +	gpio6: pinctrl@3f {
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		compatible = "semtech,sx1509q";
> +		reg = <0x3f>;
> +
> +		semtech,probe-reset;
> +		gpio-controller;
> +		interrupt-controller;
> +
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	/* SX1509(1) U2606 */
> +	gpio7: pinctrl@70 {
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		compatible = "semtech,sx1509q";
> +		reg = <0x70>;
> +
> +		semtech,probe-reset;
> +		gpio-controller;
> +		interrupt-controller;
> +
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
> +
> +		gpio6-cfg {
> +			pins = "gpio6";
> +			output-high;
> +		};
> +
> +		gpio7-cfg {
> +			pins = "gpio7";
> +			output-high;
> +		};
> +	};
> +
> +	/* RTC U2607 */
> +	rtc0: rtc@51 {

I2C slave nodes should be sorted in addresses.

> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&irqsteer_hdmi {
> +	status = "okay";
> +};
> +
> +&lcdif1 {
> +	status = "disabled";
> +};
> +
> +&lcdif2 {
> +	status = "disabled";
> +};
> +
> +/* HDMI */
> +&lcdif3 {
> +	status = "okay";
> +

Unneeded newline.

Shawn

> +};
> +
> +&lvds_bridge {
> +	status = "disabled";
> +};
> +
> +&mipi_dsi {
> +	status = "disabled";
> +};
> +
> +&pcie{
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie>;
> +	reset-gpio = <&gpio4 20 GPIO_ACTIVE_LOW>;
> +	fsl,tx-deemph-gen1 = <0x1f>;
> +	fsl,max-link-speed = <3>;
> +	status = "okay";
> +};
> +
> +&pcie_phy{
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	clocks = <&pcie0_refclk>;
> +	clock-names = "ref";
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm2>;
> +	#pwm-cells = <3>;
> +	status = "okay";
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	adp-disable;
> +	hnp-disable;
> +	srp-disable;
> +	dr_mode = "otg";
> +	usb-role-switch;
> +	role-switch-default-mode = "peripheral";
> +	status = "okay";
> +
> +	port {
> +		usb3_dwc: endpoint {
> +			remote-endpoint = <&usb_dr_connector>;
> +		};
> +	};
> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usb3_1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +/* SD slot */
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +/* eMMC */
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	vmmc-supply = <&buck4>;
> +	vqmmc-supply = <&buck5>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_ecspi1: aristainetos3-ecspi1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x82
> +			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x82
> +			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x82
> +			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x40000
> +		>;
> +	};
> +
> +	pinctrl_ecspi1_cs2: aristainetos3-ecspi1-cs2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x40000
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: aristainetos3-ecspi2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
> +			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
> +			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
> +			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40000
> +		>;
> +	};
> +
> +	pinctrl_eqos_rgmii: aristainetos3-eqos-rgmii-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x3
> +			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x3
> +			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x91
> +			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x91
> +			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x91
> +			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x91
> +			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
> +			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x91
> +			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x1f
> +			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x1f
> +			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x1f
> +			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x1f
> +			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x1f
> +			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
> +			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22				0x19
> +		>;
> +	};
> +
> +	pinctrl_fec_rgmii: aristainetos3-fec-rgmii-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
> +			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
> +			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
> +			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
> +			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
> +			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
> +			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
> +			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
> +			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
> +			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
> +			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
> +			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x19
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: aristainetos3-flexcan1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX			0x154
> +			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX			0x154
> +		>;
> +	};
> +
> +	pinctrl_flexcan1_reg: aristainetos3-flexcan1-reg-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: aristainetos3-flexcan2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX         0x154
> +			MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
> +		>;
> +	};
> +
> +	pinctrl_flexcan2_reg: aristainetos3-flexcan2-reg-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154
> +		>;
> +	};
> +
> +	pinctrl_gpio3_hog: aristainetos3-gpio3-hog-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23	0xd6
> +		>;
> +	};
> +
> +	pinctrl_gpio_led: aristainetos3-gpio-led-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
> +		>;
> +	};
> +
> +	pinctrl_gpio_proton2s: aristainetos3-gpio-proton2s-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07	0x19
> +		>;
> +	};
> +
> +	pinctrl_hdmi: aristainetos3-hdmi-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000019
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x40000019
> +		>;
> +	};
> +
> +	pinctrl_i2c1: aristainetos3-i2c1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
> +			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c1_gpio: aristainetos3-i2c1-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14	0x1c3
> +			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15	0x1c3
> +		>;
> +	};
> +
> +	pinctrl_i2c2: aristainetos3-i2c2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3
> +			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c2_gpio: aristainetos3-i2c2-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1c3
> +			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1c3
> +		>;
> +	};
> +
> +	pinctrl_i2c3: aristainetos3-i2c3-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3
> +			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c3_gpio: aristainetos3-i2c3-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x1c3
> +			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x1c3
> +		>;
> +	};
> +
> +	pinctrl_i2c5: aristainetos3-i2c5-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL	0x400001c3
> +			MX8MP_IOMUXC_SAI5_MCLK__I2C5_SDA	0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c6: aristainetos3-i2c6-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL	0x400001c3
> +			MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3
> +		>;
> +	};
> +
> +	pinctrl_i2c6_gpio: aristainetos3-i2c6-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x1c3
> +			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20	0x1c3
> +		>;
> +	};
> +
> +	pinctrl_lcd0_vcc_en: aristainetos3-lcd0-vcc-en-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13	0xd6
> +		>;
> +	};
> +
> +	pinctrl_lvds_bklt_en: aristainetos3-lvds-bklt-en-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0xd6
> +		>;
> +	};
> +
> +	pinctrl_pcie: aristainetos3-pcie-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61
> +			MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20	0x41
> +		>;
> +	};
> +
> +	pinctrl_pmic: aristainetos3-pmic-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x41
> +		>;
> +	};
> +
> +	pinctrl_pwm1: aristainetos3-pwm1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_pwm2: aristainetos3-pwm2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_tpm_irq: aristainetos3-tpm-irq-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0xd6
> +		>;
> +	};
> +
> +	pinctrl_uart1: aristainetos3-uart1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart2: aristainetos3-uart2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
> +			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
> +			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x140
> +			MX8MP_IOMUXC_SD1_DATA5__UART2_DCE_CTS	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart3: aristainetos3-uart3-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_ALE__UART3_DCE_RX	0x140
> +			MX8MP_IOMUXC_NAND_CE0_B__UART3_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_uart4: aristainetos3-uart4-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX    0x140
> +			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX    0x140
> +			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x140
> +			MX8MP_IOMUXC_NAND_DATA02__UART4_DCE_CTS 0x140
> +		>;
> +	};
> +
> +	pinctrl_usb1_vbus: aristainetos3-usb1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x19
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: aristainetos3-usdhc1-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: aristainetos3-usdhc1-100mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x194
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d4
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d4
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: aristainetos3-usdhc1-200mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x196
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d6
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d6
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: aristainetos3-usdhc2-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
> +
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: aristainetos3-usdhc2-100mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: aristainetos3-usdhc2-200mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x196
> +			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
> +			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
> +			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT 0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: aristainetos3-usdhc2-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x40000080
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_vmmc: aristainetos3-usdhc2-vmmc-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: aristainetos3-usdhc3-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: aristainetos3-usdhc3-100mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: aristainetos3-usdhc3-200mhz-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
> +			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
> +			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
> +			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
> +			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
> +			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
> +			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
> +			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
> +		>;
> +	};
> +
> +	pinctrl_watchdog_gpio: aristainetos3-wdog-gpio-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06	0x19
> +		>;
> +	};
> +
> +	pinctrl_wdog: aristainetos3-wdog-grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xc6
> +		>;
> +	};
> +};
> -- 
> 2.20.1
> 


