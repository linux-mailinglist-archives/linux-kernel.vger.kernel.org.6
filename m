Return-Path: <linux-kernel+bounces-267251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E4940F09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D521C22720
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47898198E88;
	Tue, 30 Jul 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pXV5FhZ0"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD41198852;
	Tue, 30 Jul 2024 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335169; cv=none; b=i6Xsin0qPqn+wzUXsAmMWGBKC4JwfgTgKXXXMqcoQXI8VFZokmDRWL+absFrlAP6H0II7twsD4wL33MBNqR3YJoMz1xcN7XE8NVNXK5uCVTwQz+1F+SU8d2rfw1KZNgy93cD/axI494/D92ewadaMrUy76o0Eqog6WnhQy2/iVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335169; c=relaxed/simple;
	bh=VRT27zWbeDQke5YXXoLe54VC0fWjVtHdXaGX54cgdSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5MBKoJ9wRpp0/Fi8ckvlQsqqmocuqw0Sg0T7W9XBF9B+6pl4Uqrrp1C5W0EhayBtKftH0BbdTK5MVYBIRkxJGc3APPm+l+NTJ0/jfkmOC63bERm20v4w0Y4MA2x36tlNGr4i91k2kVCRm5EP7vDodtMKzSA74/43uNxwmOD/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pXV5FhZ0; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=78LDr
	SXBIML4MBJyGM/7X+o10jrE35IS+c/XcwufibA=; b=pXV5FhZ05UJZy5/yMMj3a
	ZUWaFCug8Esq4jWgQqtKljONh/Dd+akdoYfdVWPtFcqSQRRX6Sk0ADQfLBA1DaNF
	XieP7YrarpiI/7+JxNoFkMMm5mb40AzFlM6O9PpRtKWOHw7DbRqCrjaSD3X8KHwL
	bl1fn0tUVUGFYCW8rC2Y/Y=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3f_div6hmxPMCFA--.50877S4;
	Tue, 30 Jul 2024 18:24:39 +0800 (CST)
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
Subject: [PATCH v3 2/2] arm64: dts: rockchip: Add support for rk3588 based Cool Pi CM5 GenBook
Date: Tue, 30 Jul 2024 18:24:33 +0800
Message-Id: <20240730102433.540260-3-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730102433.540260-1-andyshrk@163.com>
References: <20240730102433.540260-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f_div6hmxPMCFA--.50877S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyfZF15AF45AF1fGFWrGrg_yoWfKr1rp3
	ZxurZakrZ7ZrWUJw4DXa4xKF18Ww4vka97Cr93XF48KrWj93WDWFnF9r1fAF1kJrs7Xw43
	AF98ury7tF42qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRbyCdUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRgsXmVOB3Gb2gACsd

Cool Pi CM5 GenBook works as a carrier board connect with CM5 [0].

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

This patch add basic support to bringup eMMC/USB HOST/WiFi/TouchPad/
Battery/PCIE NVME, and can also drive a HDMI output with out of tree
hdmi patches.

[0] https://www.crowdsupply.com/shenzhen-tianmao-technology-co-ltd/genbook-rk3588

Signed-off-by: Andy Yan <andyshrk@163.com>

---

Changes in v3:
- Use "coolpi,pi-cm5-genbook" instead of "coolpi,genbook"
- Wrap commit message by a maximum 75 chars per line

Changes in v2:
- rename dts to rk3588-coolpi-cm5-genbook
- enable touchpad
- enable battery
- descripte it as CoolPi CM5 GenBook

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 2 files changed, 350 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 4861987457a4..1b30aa8d9876 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -122,6 +122,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-armsom-sige7.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-genbook.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
new file mode 100644
index 000000000000..6418286efe40
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -0,0 +1,349 @@
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
+	model = "CoolPi CM5 GenBook";
+	compatible = "coolpi,pi-cm5-genbook", "coolpi,pi-cm5", "rockchip,rk3588";
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
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <9800000>;
+		voltage-max-design-microvolt = <4350000>;
+		voltage-min-design-microvolt = <3000000>;
+	};
+
+	charger: dc-charger {
+		compatible = "gpio-charger";
+		charger-type = "mains";
+		gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
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
+&i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m3_xfer>;
+
+	cw2015@62 {
+		compatible = "cellwise,cw2015";
+		reg = <0x62>;
+
+		cellwise,battery-profile = /bits/ 8 <
+			0x17 0x67 0x69 0x63 0x63 0x62 0x62 0x5F
+			0x52 0x73 0x4C 0x5A 0x5B 0x4B 0x42 0x3A
+			0x33 0x2D 0x29 0x28 0x2E 0x31 0x3C 0x49
+			0x2C 0x2C 0x0C 0xCD 0x30 0x51 0x50 0x66
+			0x74 0x74 0x75 0x78 0x41 0x1B 0x84 0x5F
+			0x0B 0x34 0x1C 0x45 0x89 0x92 0xA0 0x13
+			0x2C 0x55 0xAB 0xCB 0x80 0x5E 0x7B 0xCB
+			0x2F 0x00 0x64 0xA5 0xB5 0x10 0x18 0x21
+			>;
+
+		cellwise,monitor-interval-ms = <3000>;
+		monitored-battery = <&battery>;
+		power-supplies = <&charger>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5m3_xfer>;
+
+	touchpad: touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
+		hid-descr-addr = <0x0020>;
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


