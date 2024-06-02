Return-Path: <linux-kernel+bounces-198197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032918D74C6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0C21F21D1D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE938DE5;
	Sun,  2 Jun 2024 10:41:12 +0000 (UTC)
Received: from mail-m1045.netease.com (mail-m1045.netease.com [154.81.10.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089F381DE;
	Sun,  2 Jun 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717324872; cv=none; b=JlGSUwBQeQm58a3lUU4Fw56MmbYjNhPmJVXcCwkLH5cbuOkkKcz/0CjmRC4SD/FvjNmM2/NNfu+HCt+yFMoz9bL2utCxqxN3ZhGG8SK5zCo6fhhVgoiIrXV0UuBmhl/zaU0w4+EPGHhnqhGCbxydSK6vChUOvX7Pf4I2FluJs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717324872; c=relaxed/simple;
	bh=GhY+Imn1e9OwETt/ifR5ZlhhgFS2q2YWhUDW4HTjV6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpU4VTQYK9G6GU/yaogcaSxfMZZ9aZVYdWkjNRjFgupJ68kEUM93UOJDKzSf/6qov7B/bqCqsdxAll74Y4DmZ1NqT934BrAv3qkrshLYgMQ7bMa7wcRHxAoWOUcZlB1YdDigU+zPqgkfo5by7wZE7c+ocrfI6EIMTwrdSfbvh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=154.81.10.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:69f0:352b:5c48:c47b:2d45])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8B1DD7E0150;
	Sun,  2 Jun 2024 18:40:25 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/2] arm64: dts: mediatek: Add Bananapi BPI-R3 mini
Date: Sun,  2 Jun 2024 18:40:21 +0800
Message-Id: <20240602104021.387713-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240602104021.387713-1-amadeus@jmu.edu.cn>
References: <20240602104021.387713-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSk4eVk9OS0xJTx4fTh8YHVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBTUIdS0FITkkZQU4YT0NBGE9MGUFJH09OWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8fd88944ff03a2kunm8b1dd7e0150
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6Eww*EzNRH0M9Cg8XTyIv
	FBNPCQhVSlVKTEpMSElPQ0lNSENJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBTUIdS0FITkkZQU4YT0NBGE9MGUFJH09OWVdZCAFZQUpITklMNwY+

The Bananapi BPI-R3 mini is a development board with the
MediaTek MT7986A (Filogic 830) SoC.

Key Features:
  2GB DDR4 RAM
  8GB eMMC flash
  128MB Nand flash
  MT7976C DBDC WiFi
  1x FAN connector
  1x NANO SIM slot
  1x USB2.0 Type-A
  1x M.2 Key B USB
  1x M.2 Key M PCIe
  2x 2.5GbE EN8811H Ethernet
  Type-C PD 12V Power supply

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../mediatek/mt7986a-bananapi-bpi-r3-mini.dts | 480 ++++++++++++++++++
 2 files changed, 481 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 37b4ca3a87c9..14af5681d0ee 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-xiaomi-ax3000t.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-acelink-ew-7886cax.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-mini.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dts
new file mode 100644
index 000000000000..683b7394ff79
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dts
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "mt7986a.dtsi"
+
+/ {
+	model = "Bananapi BPI-R3 mini";
+	chassis-type = "embedded";
+	compatible = "bananapi,bpi-r3-mini", "mediatek,mt7986a";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		key-reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		/* cooling level (0, 1, 2, 3) - pwm inverted */
+		cooling-levels = <255 128 64 0>;
+		pwms = <&pwm 0 10000>;
+		#cooling-cells = <2>;
+	};
+
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-modem";
+		radio-type = "wwan";
+		reset-gpios = <&pio 15 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&pio 13 GPIO_ACTIVE_HIGH>;
+	};
+
+	dcin: regulator-12vd {
+		compatible = "regulator-fixed";
+		regulator-name = "12vd";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1.8vd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&dcin>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3vd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&dcin>;
+	};
+
+	reg_5v_vbus: regulator-5v-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "5v_vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&dcin>;
+	};
+
+	/* labeled A_EN8811_PWR in schematic */
+	reg_phya: regulator-phya {
+		compatible = "regulator-fixed";
+		gpio = <&pio 16 GPIO_ACTIVE_LOW>;
+		regulator-name = "reg_phya";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	/* labeled B_EN8811_PWR in schematic */
+	reg_phyb: regulator-phyb {
+		compatible = "regulator-fixed";
+		gpio = <&pio 17 GPIO_ACTIVE_LOW>;
+		regulator-name = "reg_phyb";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_keyb: regulator-vcc-keyb {
+		compatible = "regulator-fixed";
+		gpio = <&pio 20 GPIO_ACTIVE_LOW>;
+		regulator-name = "vcc_keyb";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_3p3v>;
+	};
+};
+
+&cpu_thermal {
+	cooling-maps {
+		map-cpu-active-high {
+			/* active: set fan to cooling level 3 */
+			cooling-device = <&fan 3 3>;
+			trip = <&cpu_trip_active_high>;
+		};
+
+		map-cpu-active-med {
+			/* active: set fan to cooling level 2 */
+			cooling-device = <&fan 2 2>;
+			trip = <&cpu_trip_active_med>;
+		};
+
+		map-cpu-active-low {
+			/* active: set fan to cooling level 1 */
+			cooling-device = <&fan 1 1>;
+			trip = <&cpu_trip_active_low>;
+		};
+	};
+};
+
+&crypto {
+	status = "okay";
+};
+
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	status = "okay";
+
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-mode = "2500base-x";
+		phy-handle = <&phy14>;
+		phy-supply = <&reg_phya>;
+	};
+
+	gmac1: mac@1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-mode = "2500base-x";
+		phy-handle = <&phy15>;
+		phy-supply = <&reg_phyb>;
+	};
+
+	mdio: mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
+&mdio {
+	phy14: phy@14 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <14>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <20000>;
+		reset-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&pio>;
+		interrupts = <48 IRQ_TYPE_EDGE_FALLING>;
+		airoha,pnswap-rx;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				function = LED_FUNCTION_LAN;
+				color = <LED_COLOR_ID_AMBER>;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				function = LED_FUNCTION_LAN;
+				color = <LED_COLOR_ID_GREEN>;
+				default-state = "keep";
+			};
+		};
+	};
+
+	phy15: phy@15 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <15>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <20000>;
+		reset-gpios = <&pio 47 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&pio>;
+		interrupts = <46 IRQ_TYPE_EDGE_FALLING>;
+		airoha,pnswap-rx;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				function = LED_FUNCTION_WAN;
+				color = <LED_COLOR_ID_AMBER>;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				function = LED_FUNCTION_WAN;
+				color = <LED_COLOR_ID_GREEN>;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+		size = <256>;
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_flash_pins>;
+	status = "okay";
+
+	spi_nand: flash@0 {
+		compatible = "spi-nand";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
+&mmc0 {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	hs400-ds-delay = <0x14014>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	non-removable;
+	no-sd;
+	no-sdio;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pio {
+	i2c0_pins: i2c0-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c";
+		};
+	};
+
+	mdio_pins: mdio-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio";
+		};
+	};
+
+	spi_flash_pins: spi-flash-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+		conf-pu {
+			pins = "SPI2_CS", "SPI2_HOLD", "SPI2_WP";
+			drive-strength = <8>;
+			mediatek,pull-up-adv = <0>; /* bias-disable */
+		};
+		conf-pd {
+			pins = "SPI2_CLK", "SPI2_MOSI", "SPI2_MISO";
+			drive-strength = <8>;
+			mediatek,pull-down-adv = <0>; /* bias-disable */
+		};
+	};
+
+	mmc0_pins_default: mmc0-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			mediatek,pull-down-adv = <2>; /* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>; /* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>; /* pull-up 10K */
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		mux {
+			function = "emmc";
+			groups = "emmc_51";
+		};
+		conf-cmd-dat {
+			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
+			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
+			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
+			input-enable;
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>; /* pull-up 10K */
+		};
+		conf-clk {
+			pins = "EMMC_CK";
+			drive-strength = <6>;
+			mediatek,pull-down-adv = <2>; /* pull-down 50K */
+		};
+		conf-ds {
+			pins = "EMMC_DSL";
+			mediatek,pull-down-adv = <2>; /* pull-down 50K */
+		};
+		conf-rst {
+			pins = "EMMC_RSTB";
+			drive-strength = <4>;
+			mediatek,pull-up-adv = <1>; /* pull-up 10K */
+		};
+	};
+
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clk", "pcie_wake", "pcie_pereset";
+		};
+	};
+
+	pwm_pins: pwm-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm0", "pwm1_0";
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		mux {
+			function = "uart";
+			groups = "uart1";
+		};
+	};
+
+	wf_led_pins: wf-led-pins {
+		mux {
+			function = "led";
+			groups = "wifi_led";
+		};
+	};
+
+	wf_dbdc_pins: wf-dbdc-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_dbdc";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
+			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
+			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
+			       "WF1_TOP_CLK", "WF1_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins>;
+	status = "okay";
+};
+
+&ssusb {
+	vusb33-supply = <&vcc_keyb>;
+	vbus-supply = <&reg_5v_vbus>;
+	status = "okay";
+};
+
+&trng {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&usb_phy {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&wifi {
+	pinctrl-names = "dbdc";
+	pinctrl-0 = <&wf_dbdc_pins>, <&wf_led_pins>;
+	status = "okay";
+};
-- 
2.25.1


