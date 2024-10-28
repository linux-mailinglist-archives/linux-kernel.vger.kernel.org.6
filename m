Return-Path: <linux-kernel+bounces-384642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59369B2CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84F41C21D04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752701D5ACF;
	Mon, 28 Oct 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMmK/HCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720018C939;
	Mon, 28 Oct 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111062; cv=none; b=RGgi1g1m/8ZYT1IineR2FIij965QfDtxEScEP0K2j+b3AFzymkdQONp2SY81tV32tXcPRjyDlLftQUczCCiueHws/IznREnr99JcekyIjCw+/BPCORqpA6Hgi06f2bUm2Q/3gDPleHu32+sAEue5UDz7mLjx52eAWNpXO3uOQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111062; c=relaxed/simple;
	bh=NZY1+Ssx85kUHoilLgO+B6qDtQ06eiMsdics2ydE8Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6YdjhjDv42qgwoGCcr2UiKOPoJyWXtF1AahNxQgzbE/T3ZC+y7xVLpxZV5m8S8ml1++QRZua+MLoq61qmfrsPNXzSvHaxR9t3PsrgjlArsIMsVgA32i9HrMb6dSY9tkDTNiLyS2mfxWmoYxcJRJMXTmLn5XCZ7D7oS2w9beLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMmK/HCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F8FC4CEC3;
	Mon, 28 Oct 2024 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730111062;
	bh=NZY1+Ssx85kUHoilLgO+B6qDtQ06eiMsdics2ydE8Vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dMmK/HCOFVtg0ZaN1e6xteqSlyVPkqHRzdFiUs2HD0yLwpupAlCDl1egOXGSa8pg6
	 ScyzSYbCrCY21KCXms5jKNB0ZJ8mJLjDNJad7mlk264FT7jl++vDGCeTsgOqt6N5ql
	 y25+JCxRm9brgj+lxxQINp8MtoM0+fCkp0YMg7LItKYUJPzAq8wvswgJG2JYlmfqeG
	 n0L6ID8e/hQnZJXT1K6duZuSNQc8Jk4zbqx1NXR4y1JNAm5nzrXER06Jmvk5tplaPp
	 90+g2EBiuTipVKsonS24X4CLBWXwCBRxxe4Uv3CXHBGzBF2G6Gq5jt/0CPw2kQ6hah
	 la0m9W1zXztdw==
Message-ID: <f4150aa3-4c0e-45fa-9c9c-879ac04c4364@kernel.org>
Date: Mon, 28 Oct 2024 11:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: imx8mp: add aristainetos3 board
 support
To: Heiko Schocher <hs@denx.de>, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241028082332.21672-1-hs@denx.de>
 <20241028082332.21672-3-hs@denx.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241028082332.21672-3-hs@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2024 09:23, Heiko Schocher wrote:
> Add support for the i.MX8MP based aristainetos3 boards from ABB.
> 
> The board uses a ABB specific SoM from ADLink, based on NXP
> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
> with small differences, which are all catched up in
> devicetree overlays. The kernel image, the basic dtb
> and all dtbos are collected in a fitimage. As bootloader
> is used U-Boot which detects in his SPL stage the carrier
> board by probing some i2c devices. When the correct
> carrier is probed, the SPL applies all needed dtbos to
> the dtb with which U-Boot gets loaded. Same principle
> later before linux image boot, U-Boot applies the dtbos
> needed for the carrier board before booting Linux.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> checkpatch dropped the following warnings:
> arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi:248: warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented -- check ./Documentation/devicetree/bindings/
> 
> ignored, as this compatible string is usedin other dts too, for example in
> 
> arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> 
>  arch/arm64/boot/dts/freescale/Makefile        |    5 +
>  .../imx8mp-aristainetos3-adpismarc.dtsi       |   64 +
>  .../imx8mp-aristainetos3-adpismarc.dtso       |   14 +
>  .../imx8mp-aristainetos3-helios-lvds.dtsi     |   89 ++
>  .../imx8mp-aristainetos3-helios-lvds.dtso     |   13 +
>  .../imx8mp-aristainetos3-helios.dtsi          |  103 ++
>  .../imx8mp-aristainetos3-helios.dtso          |   13 +
>  .../imx8mp-aristainetos3-proton2s.dtsi        |  176 +++
>  .../imx8mp-aristainetos3-proton2s.dtso        |   13 +
>  .../imx8mp-aristainetos3a-som-v1.dts          |   18 +
>  .../imx8mp-aristainetos3a-som-v1.dtsi         | 1210 +++++++++++++++++
>  11 files changed, 1718 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aristainetos3a-som-v1.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 9d3df8b218a2..7c3586509b8b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -163,6 +163,11 @@ imx8mn-tqma8mqnl-mba8mx-usbotg-dtbs += imx8mn-tqma8mqnl-mba8mx.dtb imx8mn-tqma8m
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-lvds-tm070jvhg33.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx-usbotg.dtb
>  
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3a-som-v1.dtb \
> +			  imx8mp-aristainetos3-adpismarc.dtbo \
> +			  imx8mp-aristainetos3-proton2s.dtbo \
> +			  imx8mp-aristainetos3-helios.dtbo \
> +			  imx8mp-aristainetos3-helios-lvds.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
> new file mode 100644
> index 000000000000..cc0cddaa33ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtsi
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&ecspi1 {
> +	spidev0: spi@0 {
> +		reg = <0>;
> +		compatible = "rohm,dh2228fv";

Hm? I have some doubts, what device is here?

> +		spi-max-frequency = <500000>;
> +	};
> +};
> +
> +&ecspi2 {
> +	spidev1: spi@0 {
> +		reg = <0>;
> +		compatible = "rohm,dh2228fv";
> +		spi-max-frequency = <500000>;
> +	};
> +};
> +
> +&i2c2 {
> +	/* SX1509(2) U1001@IPi SMARC Plus */
> +	gpio8: i2c2_gpioext0@3e {

Uh, no, please never send us downstream code.

Please follow DTS coding style in all upstream submissions.

Also:
Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		/* GPIO Expander 2 Mapping :
> +		 * - 0: E_GPIO1_0	<=>	IPi SMARC Plus CN101_PIN29: E_GPIO1_0
> +		 * - 1: E_GPIO1_1	<=>	IPi SMARC Plus CN101_PIN31: E_GPIO1_1
> +		 * - 2: E_GPIO1_2	<=>	IPi SMARC Plus CN101_PIN32: E_GPIO1_2
> +		 * - 3: E_GPIO1_3	<=>	IPi SMARC Plus CN101_PIN33: E_GPIO1_3
> +		 * - 4: E_GPIO1_4	<=>	IPi SMARC Plus CN101_PIN35: E_GPIO1_4
> +		 * - 5: E_GPIO1_5	<=>	IPi SMARC Plus CN101_PIN36: E_GPIO1_5
> +		 * - 6: E_GPIO1_6	<=>	IPi SMARC Plus CN101_PIN37: E_GPIO1_6
> +		 * - 7: E_GPIO1_7	<=>	IPi SMARC Plus CN101_PIN38: E_GPIO1_7
> +		 * - 8: E_GPIO2_8	<=>	IPi SMARC Plus CN101_PIN40: E_GPIO2_8
> +		 * - 9: TP1002		<=>	IPi SMARC Plus TP1002 (won't use)
> +		 * - 10: TP1003		<=>	IPi SMARC Plus TP1003 (won't use)
> +		 * - 11: TP1004		<=>	IPi SMARC Plus TP1004 (won't use)
> +		 * - 12: TP1005		<=>	IPi SMARC Plus TP1005 (won't use)
> +		 * - 13: TP1006		<=>	IPi SMARC Plus TP1006 (won't use)
> +		 * - 14: TP1007		<=>	IPi SMARC Plus TP1007 (won't use)
> +		 * - 15: TP1008		<=>	IPi SMARC Plus TP1008 (won't use)
> +		 * - 16: OSCIO		<=>	IPi SMARC Plus TP1001 (won't use)
> +		 */
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		compatible = "semtech,sx1509q";
> +		reg = <0x3e>;
> +
> +		semtech,probe-reset;
> +		gpio-controller;
> +		interrupt-controller;
> +
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +

Drop

> +};
> +
> +&flexcan1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
> new file mode 100644
> index 000000000000..5a9adccbf7cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-adpismarc.dtso
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +/dts-v1/;
> +/plugin/;
> +
> +#include "imx8mp-aristainetos3-adpismarc.dtsi"
> +
> +&{/} {
> +	model = "Aristainetos3 ADLink PI SMARC carrier";
> +	compatible = "abb,aristainetos3-adpismarc", "imx8mp-aristianetos3",
> +		     "abb,aristianetos3-som", "fsl,imx8mp";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

And why this is DTSO, I have no clue...

> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
> new file mode 100644
> index 000000000000..55aabd6fc1f7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtsi
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +&{/} {
> +	panel: panel {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lcd0_vdd_en>;
> +		compatible = "lg,lb070wv8";
> +		backlight = <&lvds_backlight>;
> +		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&ldb_lvds_ch0>;
> +			};
> +		};
> +	};
> +};
> +
> +&gpio3 {
> +	mipi_lvds_select {

No, read coding style.


> +		gpio-hog;
> +		gpios = <23 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "mipi_lvds_select";
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
> +	fsl,data-mapping = "jeida";
> +	fsl,data-width = <24>;
> +	remote-endpoint = <&panel_in>;
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
> +	status = "okay";
> +};
> +
> +&media_blk_ctrl {
> +	/*
> +	 * The internal divider will always divide the output LVDS clock by 7
> +	 * so our display needs 33246000 Hz, so set VIDEO_PLL1 to
> +	 * 33246000 * 7 = 232722000 Hz
> +	 */
> +	assigned-clock-rates = <500000000>, <200000000>, <0>, <0>, <232722000>;
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
> new file mode 100644
> index 000000000000..06d1883b962a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios-lvds.dtso
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +/dts-v1/;
> +/plugin/;
> +
> +#include "imx8mp-aristainetos3-helios-lvds.dtsi"
> +
> +&{/} {
> +	model = "Aristainetos3 helios LVDS carrier";
> +	compatible = "abb,aristainetos3-helios-lvds", "abb,aristainetos3-helios", "abb,aristianetos3-som", "fsl,imx8mp";

Read not only DTS coding style, but also kernel coding style. Lines are
supposed to be wrapped according to kernel coding style.


> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
> new file mode 100644
> index 000000000000..b4b1cb3b0cb3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dtsi
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Heiko Schocher <hs@denx.de>
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +&{/} {
> +	helios_gpio_leds {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "gpio-leds";
> +
> +		helios_blue {

So this was absolutely never tested.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "helios:blue";

Use function and color instead.

I finished review here. Rest of the code does not look good, really. You
have so many, really so many, trivial issues which tools point out, that
using humans for such review is just waste of our time.

Best regards,
Krzysztof


