Return-Path: <linux-kernel+bounces-251782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0202B9309B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243F41C20A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDD6EB55;
	Sun, 14 Jul 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XEXtfazI"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30EA5A11D;
	Sun, 14 Jul 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720956590; cv=none; b=srh7OOKOKm/CjNk9ZYlWCpGImo9RwTrbzr4Y5QqGmhaE6MZFg2iBWjrkSD2YfVx3HCixDr0S0nE9R4TdyqR3l2Sdcqgef68SkMTgRk/pDd1et6u60xF7Azpy0pNxKkRlDNhEEvq2ojzi3Kd2cT7FheY/Qw+LmOICyt6YZcpPYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720956590; c=relaxed/simple;
	bh=fwMzq9U51piCaZXODQeQGvPWX8J/khLZmw2gBRBu2Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psqNElbRE9Ksdgd4i8fz3j8c7M7Xn97IV1/xoCSIkz/kVJzMXvZjeq3ZBFYsuKSvGkMabgaDfMCTrC8fkjQHbgszDkOlDyW7awsPqpyjScouC84MHWmokZJFLGXei83GnW0Ol6lPfbI+MBwuI6neDOTi/s5LpjHG6sRkQc00fVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XEXtfazI; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=d3J6S
	vNXBsns1DTi/FIiA8oHfdDp4cxENdp93hHRPEY=; b=XEXtfazI+9Ht6UM0Rojb/
	aMjJLyPuSMeA3cP4ylNYO9lAyZWhvgKQS6BUxunOH/5SUOGpAPybpmWd6gMfMBm/
	feTKNF3AiFXB6vrmu7BfJNQQp9r67ErJO9Wn5LoOLFlsKkFbjfYUy5oT2zNOiFDT
	eMeEDT88S3MXR1Kr19r1qs=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wD3v711tpNm6c94CQ--.57334S3;
	Sun, 14 Jul 2024 19:28:57 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: dsimic@manjaro.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add support for rk3588 GenBook
Date: Sun, 14 Jul 2024 19:28:51 +0800
Message-Id: <20240714112851.1048184-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240714112851.1048184-1-andyshrk@163.com>
References: <20240714112851.1048184-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v711tpNm6c94CQ--.57334S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyfZF15AF1xXr17CFW5GFg_yoW3Cw4fp3
	ZxursxKrWkurWUJw4DZa4xKF1rKw4vka92kr93XF48KrWj93WDW3Z29rn3AF1kJrn7Jw43
	AFy5Zry7tF42qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_AwIUUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hwcXmWXy-0MeAAAs8

Cool Pi GenBook works as a mother board connect with CM5 [0].

Specification:
- Rockchip RK3588
- LPDDR5X 8/32 GB
- eMMC 64 GB
- HDMI Type A out x 1
- USB 3.0 Host x 1
- USB-C 3.0 with DisplayPort AltMode
- PCIE M.2 E Key for RTL8852BE Wireless connection
- PCIE M.2 M Key for NVME connection
- eDP panel with 1920x1080

This patch add basic support to bringup eMMC/USB HOST/WiFi
and can also drive a HDMI output with out of tree hdmi patches.

[0] https://www.crowdsupply.com/shenzhen-tianmao-technology-co-ltd/genbook-rk3588

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3588-coolpi-genbook.dts    | 296 ++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 8fa469db400c..0fad54939bbd 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -122,6 +122,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-genbook.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts
new file mode 100644
index 000000000000..28357c6f05fb
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-genbook.dts
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "rk3588-coolpi-cm5.dtsi"
+
+/ {
+	model = "RK3588 CoolPi GenBook";
+	compatible = "coolpi,genbook", "coolpi,pi-cm5", "rockchip,rk3588";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		enable-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		power-supply = <&vcc12v_dcin>;
+		pwms = <&pwm6 0 25000 0>;
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		heartbeat_led: led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		wlan_led: led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		};
+
+		charging_red: led-2 {
+			function = LED_FUNCTION_CHARGING;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio3 RK_PD2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <7000000>;
+		regulator-max-microvolt = <7000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <7000000>;
+		regulator-max-microvolt = <7000000>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_lcd: vcc3v3-lcd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_lcd";
+		enable-active-high;
+		gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcdpwr_en>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_pwren>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc5v0_usb_host0: vcc5v0_usb30_host: vcc5v0-usb-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&gmac0 {
+	status = "disabled";
+};
+
+/* M.2 E-Key */
+&pcie2x1l0 {
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreq &pcie_wake &pcie_rst &wifi_pwron &bt_pwron>;
+	status = "okay";
+};
+
+&pcie2x1l2 {
+	status = "disabled";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+/* M.2 M-Key ssd */
+&pcie3x4 {
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+	status = "okay";
+};
+
+&pinctrl {
+	lcd {
+		lcdpwr_en: lcdpwr-en {
+			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bl_en: bl-en {
+			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_pwren: usb-pwren {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		usb_otg_pwren: usb-otg-pwren {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		usb_host_pwren: usb-host-pwren {
+			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	wifi {
+		bt_pwron: bt-pwron {
+			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_clkreq: pcie-clkreq {
+			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_rst: pcie-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		wifi_pwron: wifi-pwron {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_wake: pcie-wake {
+			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm6 {
+	pinctrl-0 = <&pwm6m1_pins>;
+	status = "okay";
+};
+
+&sdmmc {
+	status = "disabled";
+};
+
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim2_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_usb_host0>;
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+/* For Keypad */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* Type C port */
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+/* connected to a HUB for camera and BT */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+/* USB A out */
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.34.1


