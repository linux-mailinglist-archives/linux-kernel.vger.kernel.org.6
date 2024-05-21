Return-Path: <linux-kernel+bounces-185481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86228CB55E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E40FB2125A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748214A084;
	Tue, 21 May 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WmUJOd+U"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1A149DE8
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326592; cv=none; b=ZJ47XRbBfS3YHLV0lX1hC4sQ2taahojxhEQ/DidA6nIyeYNr2AqZ52ps8kvswem++FJLpA9U/FmxSMKai1otT+7oBXpV2A3ego/18tTithaGb4b9vaY6Y3dGvqQXXaQgZ4e//9lmx6Dg+PK49t12bLQb73rf2numcJOMnWIQ4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326592; c=relaxed/simple;
	bh=oJAR0JEMrgvGe5LIGteqChSMbHGoJgTek4qkf3lz0cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgXY5MGJ+wGtzhJ9LiK6PXVPYo7rUpIJ8svfpdMTM/9dlkyJ2z4FTDEwfds79rflTDJARbrFLE92TMJRKuXVwqagZ7mUSeilxsGLg+TV6FcjFQVOjEczYG3DktUI7GqBPc0ee3vi2vICLDcBdwLN/oE3sz3hhe8K1BnmCdNJQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WmUJOd+U; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716326586; bh=CmSAkttODhbKp85tjcpWYGhjDoxl8BSc0syM5HwkoRU=;
 b=WmUJOd+URZVr4Mw6Xv7HTQGmZwOC8gZqrBMcTxcOaqQ7/MFWCxIGE5OfXwHTwqOFtxBqOBr2/
 z/CivdaO1qjt2jviPnyPeaDJ4lFxqftIZoIauJq9TeqqbumamrP+FcEqyB54mZfz2rhTKQlC+3g
 tb71HpnoHap44NZDZS6n5nNi3q3TwK1B43JPnq5vJfojGPGF6X3h63cV1jjTe3CkGGL5Yb5tIqv
 FPzsjE/t4CB8m8JKDaSEIfToBTS3af4B1jPqRXxq2mIF6yVgLwXU5n1VxsxZmM6pK+MsoGUdPnw
 jGFPUgoEQaCJx/yhBBvOgdfJRA4XIrdP1tH08TQHHCOg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add Radxa ROCK S0
Date: Tue, 21 May 2024 21:22:43 +0000
Message-ID: <20240521212247.1240226-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521212247.1240226-1-jonas@kwiboo.se>
References: <20240521212247.1240226-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664d10b68b6b0c828344b110

Radxa ROCK S0 is a single-board computer based on the Rockchip RK3308B
SoC in an ultra-compact form factor.

Add initial support for eMMC, SD-card, Ethernet, WiFi/BT and USB.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-rock-s0.dts      | 293 ++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1a4b154121fa..22f7ba98175b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-s0.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-anbernic-rg351m.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-anbernic-rg351v.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
new file mode 100644
index 000000000000..bd6419a5c20a
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "rk3308.dtsi"
+
+/ {
+	model = "Radxa ROCK S0";
+	compatible = "radxa,rock-s0", "rockchip,rk3308";
+
+	aliases {
+		ethernet0 = &gmac;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_led>;
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vdd_log: regulator-1v04-vdd-log {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1040000>;
+		regulator-max-microvolt = <1040000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_ddr: regulator-1v5-vcc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_ddr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_io: regulator-3v3-vcc-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vdd_core: regulator-vdd-core {
+		compatible = "pwm-regulator";
+		pwms = <&pwm0 0 5000 1>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_core";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <827000>;
+		regulator-max-microvolt = <1340000>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_reg_on>;
+		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_core>;
+};
+
+&emmc {
+	cap-mmc-highspeed;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_pwren>;
+	vmmc-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&gmac {
+	clock_in_out = "output";
+	phy-handle = <&rtl8201f>;
+	phy-supply = <&vcc_io>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtl8201f: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac_rst>;
+			reset-assert-us = <20000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&io_domains {
+	vccio0-supply = <&vcc_io>;
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc_io>;
+	vccio3-supply = <&vcc_io>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rtc_32k>;
+
+	bluetooth {
+		bt_reg_on: bt-reg-on {
+			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		host_wake_bt: host-wake-bt {
+			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	gmac {
+		mac_rst: mac-rst {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		pwr_led: pwr-led {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_reg_on: wifi-reg-on {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wifi_wake_host: wifi-wake-host {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pin_pull_down>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	max-frequency = <50000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm43430a1-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_wake_host>;
+	};
+};
+
+&sdmmc {
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
+	status = "okay";
+};
+
+&uart4 {
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43430a1-bt";
+		clocks = <&cru SCLK_RTC32K>;
+		clock-names = "lpo";
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wakeup";
+		device-wakeup-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reg_on &bt_wake_host &host_wake_bt>;
+		vbat-supply = <&vcc_io>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.43.2


