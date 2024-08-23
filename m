Return-Path: <linux-kernel+bounces-298766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ADB95CB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F7C281E05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3991C187353;
	Fri, 23 Aug 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5C9pyqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C084F88C;
	Fri, 23 Aug 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412195; cv=none; b=iOONNm+oc28lGYUvs+q9r2Y5dpdY1j9l7ylas6Pn39tmr1oJs2yo6A0rPGfCvFSjWPHhOTBFkeFap5L1e0D72Ofdjdx/kmDbux1hp6dpHUGbvlY2npnRsQeCFDOgWCj61kYhCm2NOBovsdD3+4SyXdhIrGPx+BEbwEH0CWFTQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412195; c=relaxed/simple;
	bh=xQE216ocBHq+xIY/QMEPgFRg/QumScGZ2C4WlmFG3d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bm8/juLvbrEqf/YgpgA/Ioba9ssD36SmEVIh2Ju+6BBdAfitX/pJA0EqBZmt43D7qmfAIUMxym5uKrbFlqOa9aeqo+pNXCMBNit8fnnrKgB21iHwo9uMbZyR6Gb9u8ihy6rc9Ru2gwBvSARCBTNPMnTp8WRocnrTCdgwOV6iXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5C9pyqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248AFC32786;
	Fri, 23 Aug 2024 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724412194;
	bh=xQE216ocBHq+xIY/QMEPgFRg/QumScGZ2C4WlmFG3d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G5C9pyqL7N7Dy3J08b9Qjhhoy/4zzUYpFnzvZwIuZdzUOBIarktytWsxmxQy5Lknd
	 2Ui+18KzXS7tPeBQmSuCN/P0+3u7Io5RA2mMPQ7C1IM8Q+qe5rGiHk9uYr2lJfPkWW
	 7EFYpaRtmXcSIwLvNC6M/tYhgSWaARfLf9+j34xKEH6kBKoA5mfVLidFtoVqFejw0A
	 Y6DsjPFQtjFXm3JJuI3dPaCjcvi0uASCzdQBZjt83NTnn/OTm+7byudLbDzeZl0zwx
	 kpjYTas/G+MJoNRoYlgkSd9bn1oHIlRgyzdIoXKCpBISzCTeAjMbVrUXCqRVo8UMZK
	 QFzqK18QwsHLw==
Message-ID: <2774e7e5-8c03-4f38-90c3-b414bc6af255@kernel.org>
Date: Fri, 23 Aug 2024 14:23:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Robert Nelson <robertcnelson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Jared McArthur <j-mcarthur@ti.com>, Jason Kridner
 <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>,
 Drew Fustini <drew@beagleboard.org>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240822170440.265055-2-robertcnelson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22/08/2024 20:04, Robert Nelson wrote:
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

<snip>

> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;

Why do you need OBSCLK for Ethernet MAC?
The OBSCLK is connected to the Ethernet PHY via C406 which is not even populated.
It seems that the PHY is clocked by a crystal oscillator X5 so doesn't really
need OBSCLK in the stock configuration?

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
> +	wkup_uart0_pins_default: wkup-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
> +			J722S_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
> +			J722S_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
> +			J722S_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x04c, PIN_INPUT_PULLUP, 0)	/* (C7) WKUP_I2C0_SCL */
> +			J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	gbe_pmx_obsclk: gbe-pmx-obsclk-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x0004, PIN_OUTPUT, 1) /* (A10) MCU_SPI0_CS1.MCU_OBSCLK0 */
> +		>;
> +	};
> +};
> +
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by Device Manager firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	bootph-all;
> +	status = "reserved";
> +};
> +
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <100000>;
> +	bootph-all;
> +	status = "okay";
> +
> +	tps65219: pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vsys_5v0>;
> +		buck2-supply = <&vsys_5v0>;
> +		buck3-supply = <&vsys_5v0>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo3-supply = <&vdd_3v3>;
> +		ldo4-supply = <&vdd_3v3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		system-power-controller;
> +		ti,power-button;
> +		bootph-all;
> +
> +		regulators {
> +			buck1_reg: buck1 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck2_reg: buck2 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-name = "VDDSHV5_SDIO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allow-bypass;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-name = "VDD_1V2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-name = "VDDA_PHY_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-name = "VDDA_PLL_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +	};
> +
> +	rtc: rtc@68 {
> +		compatible = "dallas,ds1340";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&sdhci1 {
> +	/* SD/MMC */
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vdd_sd_dv>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	disable-wp;
> +	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
> +	cd-debounce-delay-ms = <100>;
> +	ti,fails-without-test-cd;
> +	bootph-all;
> +	status = "okay";
> +};

-- 
cheers,
-roger

