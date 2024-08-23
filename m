Return-Path: <linux-kernel+bounces-298414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875F95C6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00471282BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCF13D24D;
	Fri, 23 Aug 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCzaPm3Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE731144D15;
	Fri, 23 Aug 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399196; cv=none; b=dcjgw67UtZFcqfePixbxiF3EJvKlQyvHfGHc4Ob0YKNt+6UoIWRcGtrtNkiMlB/SajdFnxjcoaeWHxjQ0BLUAPBcrfxB9c9QL08880UL1XzdImA+fzhHXWfnPW/oXEu302sx60KP9lgr6ESD/XBDPprZJEZW+2vPHZqSwFrso4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399196; c=relaxed/simple;
	bh=dVhrStm6VCdIVBNPY1MNczmlACvDurEmjAod7j9nIsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPEA6SxBvncalbivP6JtTO9mdlYqmiux18ZsQPh3YcmUlnDm7fgxdiJsCSs8MgflK/+0dPg7qHDCwYjTmx1iYOlHwwpmA6hDBpB6lfKImKNEP5PpvpAj6Jn9UUNWCwbQTDg5o3Mf/vSfYukl6SevvxJEzR1dZslO1nOEt/0UN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCzaPm3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B1CC4AF09;
	Fri, 23 Aug 2024 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724399196;
	bh=dVhrStm6VCdIVBNPY1MNczmlACvDurEmjAod7j9nIsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCzaPm3Y11Agh2VdGrHyRo7L9mI+ctnBAZa75U0UHY94w1SPbu3SYydG2BwlwjPhW
	 PqfCbdDs3SrePnb+z3LMpbqwI25obg0tuVfEurHk36MEmDzaDcQvrcyi/Hb7kVEvdu
	 9OVIGpGqdehWOWrwGs41d5dX070bajoyC8jPGgb3/FhqwWaIQDBIdgw6OuiF6RvT7s
	 yBBM3vahNiy6Z/gdeZmVf6inhdhzSOIDccTiIEUHWlQufn9oXhYekTZc75DmRBCVjT
	 Kq3i2J/8770gmfWPC9jg3qfW6TjEfZ7/fkYtQOEQY7yYta5BehC8YlBKPegJq1umcy
	 k320Ggb1hpRCw==
Date: Fri, 23 Aug 2024 09:46:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, 
	Jai Luthra <j-luthra@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
	Jason Kridner <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>, 
	Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
Message-ID: <dlfqejfb2lhbopybt5x6maoonw37krin6iezmwnngjflcbn425@5xn25d3gkxkn>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822170440.265055-2-robertcnelson@gmail.com>

On Thu, Aug 22, 2024 at 12:04:40PM -0500, Robert Nelson wrote:
> BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM67A,
> which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> cores for low-power, low-latency GPIO control.
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Andrew Davis <afd@ti.com>
> CC: Jai Luthra <j-luthra@ti.com>
> CC: Roger Quadros <rogerq@kernel.org>
> CC: Siddharth Vadapalli <s-vadapalli@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> CC: linux-arm-kernel@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
commit msg. There is no single need to store automated output of
get_maintainers.pl in the git log. It can be easily re-created at any
given time, thus its presence in the git history is redundant and
obfuscates the log.

If you need it for your own patch management purposes, keep it under the
--- separator.

> ---
> Changes since v2:
>  - added led indictors
>  - sdhci1 use MMC1_SDCD.GPIO1_48 for card detect
>  - cleaned up order of status = "okay"
>  - wkup_i2c0 moved to 100000
>  - eeprom added atmel,24c32
>  - rtc added dallas,ds1340
>  - sdhci1 use ti,fails-without-test-cd
> Changes since v1:
>  - fixed incorrect vdd-3v3-sd-pins-default name
>  - updated hdmi VDD_1V2 regulator for production pcb
>  - switched device tree name from k3-j722s-beagley-ai to k3-am67a-beagley-ai
>  - removed cpsw_port2 node
>  - enable UHS support for MMCSD
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 406 ++++++++++++++++++
>  2 files changed, 407 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e20b27ddf901..c89c9b8bab38 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>  
>  # Boards with J722s SoC
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb

So am67 is J772s? Then why calling it am67a?

>  dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
>  
>  # Boards with J784s4 SoC
> diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> new file mode 100644
> index 000000000000..c8cbb875d4c7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * https://beagley-ai.org/
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation
> + */

...

> +	vsys_5v0: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		bootph-all;
> +	};
> +
> +	vdd_3v3: regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vsys_5v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-mmc1 {

Keep consistent naming of the nodes. Why this is sometimes "1" sometimes
"mmc"?

Please use name for all fixed regulators which matches current format
recommendation: 'regulator-[0-9]v[0-9]'
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46

> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv: regulator-TLV71033 {

No upper-case characters.

See DTS coding style.

> +		compatible = "regulator-gpio";
> +		regulator-name = "tlv71033";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_5v0>;
> +		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +		bootph-all;
> +	};
> +
> +	vsys_io_1v8: regulator-vsys-io-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_io_1v2: regulator-vsys-io-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_default>;
> +
> +		led-0 {
> +			gpios = <&main_gpio0 11 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "default-off";
> +			default-state = "off";
> +		};
> +
> +		led-1 {
> +			gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +

Drop blank line.

> +	main_i2c0_pins_default: main-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
> +			J722S_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (B22) I2C0_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_uart0_pins_default: main-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
> +			J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0244, PIN_OUTPUT, 7) /* (A24) MMC1_SDWP.GPIO1_49 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x023c, PIN_INPUT, 0) /* (H22) MMC1_CMD */
> +			J722S_IOPAD(0x0234, PIN_OUTPUT, 0) /* (H24) MMC1_CLK */
> +			J722S_IOPAD(0x0230, PIN_INPUT, 0) /* (H23) MMC1_DAT0 */
> +			J722S_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H20) MMC1_DAT1 */
> +			J722S_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (J23) MMC1_DAT2 */
> +			J722S_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
> +			J722S_IOPAD(0x0240, PIN_INPUT, 7) /* (B24) MMC1_SDCD.GPIO1_48 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	mdio_pins_default: mdio-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
> +			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
> +		>;
> +	};
> +
> +	rgmii1_pins_default: rgmii1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
> +			J722S_IOPAD(0x0150, PIN_INPUT, 0) /* (AD27) RGMII1_RD1 */
> +			J722S_IOPAD(0x0154, PIN_INPUT, 0) /* (AE24) RGMII1_RD2 */
> +			J722S_IOPAD(0x0158, PIN_INPUT, 0) /* (AE26) RGMII1_RD3 */
> +			J722S_IOPAD(0x0148, PIN_INPUT, 0) /* (AE27) RGMII1_RXC */
> +			J722S_IOPAD(0x0144, PIN_INPUT, 0) /* (AD23) RGMII1_RX_CTL */
> +			J722S_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AF27) RGMII1_TD0 */
> +			J722S_IOPAD(0x0138, PIN_OUTPUT, 0) /* (AE23) RGMII1_TD1 */
> +			J722S_IOPAD(0x013c, PIN_OUTPUT, 0) /* (AG25) RGMII1_TD2 */
> +			J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
> +			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
> +			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	led_pins_default: led-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x002c, PIN_OUTPUT, 7) /* (K26) OSPI0_CSn0.GPIO0_11 */
> +			J722S_IOPAD(0x0030, PIN_OUTPUT, 7) /* (K23) OSPI0_CSn1.GPIO0_12 */
> +		>;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (B23) EXTINTn */
> +		>;
> +	};
> +
> +	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0254, PIN_OUTPUT, 7) /* (E25) USB0_DRVVBUS.GPIO1_50 */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
> +
> +	assigned-clocks = <&k3_clks 227 0>;
> +	assigned-clock-parents = <&k3_clks 227 6>;
> +	status = "okay";
> +};
> +
> +&cpsw3g_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio_pins_default>;
> +	status = "okay";
> +
> +	cpsw3g_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy0>;
> +	status = "okay";
> +};
> +
> +&main_gpio1 {
> +	status = "okay";
> +};
> +
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	bootph-all;
> +	status = "okay";
> +};
> +
> +&mcu_pmx0 {
> +

Drop blank line

> +	wkup_uart0_pins_default: wkup-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
> +			J722S_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
> +			J722S_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
> +			J722S_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
> +		>;
> +		bootph-all;
> +	};

Best regards,
Krzysztof


