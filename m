Return-Path: <linux-kernel+bounces-333601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7597CB31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADE71F227DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34E19FA60;
	Thu, 19 Sep 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="mpEulwzZ"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F719E7EF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726757591; cv=none; b=VjUPAiXkJ9YMxQ8L9mj2cghgYbLlk9M/pUz0kiwkNF66J6NCRBS0RVZRzrynIewuqiPsAYthuhcYIh1lSeh3zfdXuPxgNaUso6pjDd9VIEku5Cj2YiV/GvWAO0YiI5jqM5AEAm+Wmo4GX4MTUcn7DZOo+4gufGsq1qVl9fIRug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726757591; c=relaxed/simple;
	bh=M0EcSHDGfqTisEuYQT1pdMPgep9J0/Xo+w//KwGAP78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJxRoIBQ+R+6FGPjx1d1fBIvSdj/MkvvFuUR+VEyTpEOv2pxRUYRocnUmPNDVYGlEpuDDCS1Lb+p9iKMQ9bPjiwuPOlypQFmy7FopFk2nkwFQWXUfMV9uUab9ogaPY/5QeTrsdqQXlBbgHfR3yyV7XfDFtULgF1zDo+p3tBetmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=mpEulwzZ; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726757584;
 bh=teuxzV9+u9x2HjAHfv9l6CJNvMJKX9WMrxe1ClqQ+ws=;
 b=mpEulwzZWc3q0ED0VQxdeo/AAIW80V3NVxQu78aJkUnGZAanTWQ8vvKzvbAZ7PvuYfccnB3f/
 CnHIqSx5l4RevQq6dT731YgI8y4BLbb/iACp6MhZa2D6KodrNBH9KVUijY6l5oDVKh/xXAqlTdP
 edKystVi/4QNjTLXxCh9bcikh+yi9W1VlvuiDOkh341BCCk0jQSsTo1M6DiNmECbkY+kXFuUww8
 +hTry/svicVKeItG//kaJ+A/zsEVoscan4uCnQaXnFFDLmqPNzFwPdIywEbhCmBczodvfdVrY9v
 fl1hqz7LQnR0PF+sL2u58yn5D2GlwUUCQkECp2zQAuLw==
Message-ID: <8c86229a-8cec-4d65-8194-ee8cdc6931dd@kwiboo.se>
Date: Thu, 19 Sep 2024 16:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: rockchip: add dts for Ariaboard
 Photonicat RK3568
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>,
 Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240914145549.879936-1-bigfoot@classfun.cn>
 <20240914145549.879936-4-bigfoot@classfun.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240914145549.879936-4-bigfoot@classfun.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ec3acd9010437d2fde8a28

Hi Junhao,

On 2024-09-14 16:55, Junhao Xie wrote:
> Add dts for Ariaboard Photonicat RK3568.
> 
> Working IO:
>     Debug UART
>     SDIO QCA9377 WiFi and Bluetooth
>     M.2 E-Key PCIe WiFi and Bluetooth
>     M.2 B-Key USB Modem WWAN
>     Ethernet WAN Port
>     MicroSD Card slot
>     eMMC
>     HDMI Output
>     Mali GPU
>     USB Type-A
> 
> Not working IO:
>     Ethernet LAN Port (Lack of SGMII support)
>     Power management MCU on UART4 (Driver pending)
> 
> Not working IO in MCU:
>     Battery voltage sensor
>     Board temperature sensor
>     Hardware Power-off
>     Hardware Watchdog
>     Network status LED
>     Real-time clock
>     USB Charger voltage sensor
> 
> About onboard power management MCU:
>     A heartbeat must be sent to the MCU within 60 seconds,
>     otherwise the MCU will restart the system.
>     When powering off, a shutdown command needs to be sent to the MCU.
>     When the power button is long pressed, the MCU will send a shutdown
>     command to the system. If system does not shutdown within 60 seconds,
>     the power will be turned off directly.
>     MCU only provides voltage for charger and battery.
>     Manufacturer removed RK8xx PMIC.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3568-photonicat.dts   | 591 ++++++++++++++++++
>  2 files changed, 592 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index fda1b980eb4b..56afd63cb9e2 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -130,6 +130,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-ok3588-c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb

This should probably be added where the rest of rk3568 dtb is located,
not with the rk3588 ones.

>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5-itx.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> new file mode 100644
> index 000000000000..b3f4fe485e42
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> @@ -0,0 +1,591 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	model = "Ariaboard Photonicat";
> +	compatible = "ariaboard,photonicat", "rockchip,rk3568";
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc0;
> +		mmc2 = &sdmmc1;
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +		device-chemistry = "lithium-ion";
> +		charge-full-design-microamp-hours = <6800000>;
> +		energy-full-design-microwatt-hours = <25000000>;
> +		voltage-max-design-microvolt = <4200000>;
> +		voltage-min-design-microvolt = <3400000>;
> +
> +		ocv-capacity-celsius = <25>;
> +		ocv-capacity-table-0 =  <4100000 100>, <4040000 90>,
> +					<3980000 80>, <3920000 70>,
> +					<3870000 60>, <3820000 50>,
> +					<3790000 40>, <3770000 30>,
> +					<3740000 20>, <3680000 10>,
> +					<3450000 0>;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	hdmi_con: hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	rfkill-modem {
> +		compatible = "rfkill-gpio";
> +		label = "M.2 USB Modem";
> +		radio-type = "wwan";
> +		reset-gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
> +		shutdown-gpios = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdda_0v9: regulator-0v9-vdda {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdda_0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc_1v8: regulator-1v8-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcca_1v8: regulator-1v8-vcca {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcca_1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc_3v3: regulator-3v3-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	/* actually fed by vcc_syson, dependent
> +	 * on pi6c clock generator
> +	 */
> +	vcc3v3_pcie: regulator-3v3-vcc-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc3v3_pi6c>;
> +	};
> +
> +	/* pi6c pcie clock generator */
> +	vcc3v3_pi6c: regulator-3v3-vcc-pi6c {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_pwren_h>;
> +		regulator-name = "vcc3v3_pi6c";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_syson>;
> +	};
> +
> +	vcc3v3_sd: regulator-3v3-vcc-sd {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc0_pwren>;
> +		regulator-boot-on;
> +		regulator-name = "vcc3v3_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	vcc3v3_sys: regulator-3v3-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_syson>;
> +	};
> +
> +	vcc3v4_rf: regulator-3v4-vcc-rf {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rf_pwr_en>;
> +		regulator-name = "vcc3v4_rf";
> +		regulator-min-microvolt = <3400000>;
> +		regulator-max-microvolt = <3400000>;
> +		vin-supply = <&vccin_5v>;
> +	};
> +
> +	vcc5v0_usb30_otg0: regulator-vcc5v0-usb30-otg0 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren_h>;
> +		regulator-name = "vcc5v0_usb30_otg0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vccin_5v>;
> +	};
> +
> +	vccin_5v: regulator-vccin-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vccin_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc_sysin: regulator-vcc-sysin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sysin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vccin_5v>;
> +	};
> +
> +	vcc_syson: regulator-vcc-syson {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_syson";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_sysin>;
> +	};
> +
> +	vdd_gpu: regulator-vdd-gpu {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm2 0 5000 1>;
> +		pwm-supply = <&vcc_syson>;
> +		regulator-name = "vdd_gpu";
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-ramp-delay = <6001>;
> +		regulator-settling-time-up-us = <250>;
> +	};
> +
> +	vdd_logic: regulator-vdd-logic {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm1 0 5000 1>;
> +		pwm-supply = <&vcc_syson>;
> +		regulator-name = "vdd_logic";
> +		regulator-min-microvolt = <500000>;
> +		regulator-max-microvolt = <1350000>;
> +		regulator-ramp-delay = <6001>;
> +		regulator-settling-time-up-us = <250>;
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&pmucru CLK_RTC_32K>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_reg_on_h &clk32k_out1>;
> +		post-power-on-delay-ms = <200>;
> +		reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&combphy0 {
> +	status = "okay";
> +};
> +
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gmac0 {
> +	status = "disabled";
> +	/* Motorcomm YT8521SC LAN port (require SGMII) */

nit: Please be consistent where comments is added, for recgulators above
the comments is above the node, suggest you move the comment above the
"&gmac0 {" line, and same for similar comments.

> +};
> +
> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
> +	assigned-clock-rates = <0>, <125000000>;
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&vcc_3v3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_rgmii_bus>;
> +	snps,reset-gpio = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 20000 100000>;

The snps,reset props is deprecated use resets props in phy node instad.

> +	status = "okay";
> +	/* Motorcomm YT8521SC WAN port */
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda_0v9>;
> +	avdd-1v8-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc_syson>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2m1_xfer>;
> +	status = "okay";
> +};
> +
> +&i2s0_8ch {
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +		rx-internal-delay-ps = <1500>;
> +		tx-internal-delay-ps = <1500>;
> +	};
> +};
> +
> +&pcie30phy {
> +	phy-supply = <&vcc3v3_pi6c>;
> +	status = "okay";
> +};
> +
> +&pcie3x2 {
> +	max-link-speed = <1>;
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x1m0_pins>;
> +	reset-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie>;
> +	status = "okay";
> +	/* M.2 E-Key for PCIe WLAN */
> +};
> +
> +&pinctrl {
> +	bt {
> +		bt_reg_on_h: bt-reg-on-h {
> +			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie_pwren_h: pcie-pwren-h {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdmmc0 {
> +		sdmmc0_pwren: sdmmc0-pwren {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		rf_pwr_en: rf-pwr-en {
> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb_host_pwren_h: usb-host-pwren-h {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_reg_on_h: wifi-reg-on-h {
> +			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc_3v3>;
> +	pmuio2-supply = <&vcc_3v3>;
> +	vccio1-supply = <&vcc_3v3>;
> +	vccio2-supply = <&vcc_1v8>;
> +	vccio3-supply = <&vcc_3v3>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_3v3>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;

Can be dropped, already in base dtsi.

> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +	/* eMMC */
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	no-1-8-v;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vcc_3v3>;
> +	status = "okay";
> +	/* Micro SD card slot */
> +};
> +
> +&sdmmc1 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sys>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +	/* Qualcomm Atheros QCA9377 */

nit: I would move this comment one line down just above the wifi node
below.

Regards,
Jonas

> +
> +	wifi: wifi@1 {
> +		reg = <1>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	dma-names = "tx", "rx";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,qca9377-bt";
> +		clocks = <&pmucru CLK_RTC_32K>;
> +		clock-names = "lpo";
> +		enable-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_reg_on_h>;
> +		vddio-supply = <&vcc_1v8>;
> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	/* Debug UART */
> +};
> +
> +&uart3 {
> +	dma-names = "tx", "rx";
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	dma-names = "tx", "rx";
> +	status = "okay";
> +	/* Onboard power management MCU */
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +	/* M.2 E-Key for USB Bluetooth */
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +	/* USB Type-A Port */
> +};
> +
> +&usb_host1_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +	/* M.2 B-Key for USB Modem WWAN */
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_host {
> +	phy-supply = <&vcc3v4_rf>;
> +	status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +	phy-supply = <&vcc5v0_usb30_otg0>;
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	phy-supply = <&vcc5v0_usb30_otg0>;
> +	status = "okay";
> +};
> +
> +&vop {
> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};
> +
> +&xin32k {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&clk32k_out1>;
> +};


