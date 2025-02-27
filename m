Return-Path: <linux-kernel+bounces-536141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320BDA47BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4351738EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5F22D790;
	Thu, 27 Feb 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HhbbG5fu"
Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com [220.197.32.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2422F3B0;
	Thu, 27 Feb 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655190; cv=none; b=BQA3Iqgob1EG3swU4kAN5dq3ZGC3UOeLXgHjmSljIvl7LLLYCb9NVityjZJkh6/IT5niR0BB3pYTVuE46sjqs6YD3zjlnnMLIH6OgCTGsUn6EkIyHpVKexXEgRVfzRPvgCysh2lxRrFvlqLLBDe/ngaK0LcWxtXNGpp7p4mJI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655190; c=relaxed/simple;
	bh=cpUJpUF0UDwirtPU9Yp2f7yhaMB7uZdu30MX6CTKwnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPGOpvvSOpMkvrCtV13hmq2aBjZMKYoxDUFylVWqY0/xX4dRkF/hQij+T6IXY5hgOlANlQ2Mc0NNUwKEmOmW2SZR27NQRBuXzx2mpEiStIjsQXV/SoH3/tnt8CtK4j6qHzZuCF9E0Q3nrGW0gXbcqWRwkttzLBbs/X9ddlWTl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HhbbG5fu; arc=none smtp.client-ip=220.197.32.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f9800;
	Thu, 27 Feb 2025 19:19:43 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3 15/15] arm64: dts: rockchip: Add RK3562 evb2 devicetree
Date: Thu, 27 Feb 2025 19:19:13 +0800
Message-Id: <20250227111913.2344207-16-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhJSFZOSEwZQ0JDQ0tJHUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
X-HM-Tid: 0a954722474d03afkunmc65f9800
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6PDo*UTISTg1JOE0QHk00
	CTdPCT1VSlVKTE9LTU5OSkNOSU5CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT0tDTTcG
DKIM-Signature:a=rsa-sha256;
	b=HhbbG5fuusBQVoZltx0jEhD9toFZ083qZfSc8+N3dZxxEK0R1z1UgRJ+sJvxzlSD1zDhNxCmTsScWwDv2bq/rubylHmtWY2vmMlZfig1bd87iFHz8iq38vXyF8L+pHqrBfS65DqeDDnsLEwC04IRPfcaOvWYBKbM+YVIJMVC3jg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=MURgJu57D0B2PXDSNKTSZrM4jxPxvul7+axt/E1n19E=;
	h=date:mime-version:subject:message-id:from;

From: Finley Xiao <finley.xiao@rock-chips.com>

DRAM: DDR4
Storage: eMMC
PMIC: RK809
Audio: Headphone and speaker
Interface:
- USB3.0 HOST
- USB2.0 HOST
- PCIe x4 slot(pcie2x1 available)
- SD card slot
- GMAC
- debug UART0

NOTE: the USB3.0 and the PCIe reuse the comboPHY, so the USB3.0 work in
USB2 only mode.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3562-evb2-v10.dts     | 520 ++++++++++++++++++
 2 files changed, 521 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index def1222c1907..216501eb8f36 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-d.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353p.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts
new file mode 100644
index 000000000000..f3669e965cbf
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3562.dtsi"
+
+/ {
+	model = "Rockchip RK3562 EVB V20 Board";
+	compatible = "rockchip,rk3562-evb2-v10", "rockchip,rk3562";
+
+	chosen: chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	adc_keys: adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc0 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-vol-up {
+			linux,code = <KEY_VOLUMEUP>;
+			label = "volume up";
+			press-threshold-microvolt = <17000>;
+		};
+
+		button-vol-down {
+			linux,code = <KEY_VOLUMEDOWN>;
+			label = "volume down";
+			press-threshold-microvolt = <414000>;
+		};
+
+		button-menu {
+			linux,code = <KEY_MENU>;
+			label = "menu";
+			press-threshold-microvolt = <800000>;
+		};
+
+		button-back {
+			linux,code = <KEY_BACK>;
+			label = "back";
+			press-threshold-microvolt = <1200000>;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+		work_led: led-0 {
+			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	dc_12v: dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk809 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - PDN (power down when low)
+		 */
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc3v3_pcie20: vcc3v3-pcie20 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie20";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <5000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb_host: vcc5v0-usb-host {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb_host";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc5v0_usb>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren>;
+	};
+
+	vcc5v0_usb_otg: vcc5v0-usb-otg {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc5v0_usb>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_otg_pwren>;
+	};
+
+	vcc3v3_clk: vcc3v3-clk {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_clk";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_sys: vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+};
+
+&combphy_pu {
+	status = "okay";
+};
+
+&gmac0 {
+	phy-mode = "rgmii-rxid";
+	clock_in_out = "output";
+
+	snps,reset-gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 20000 100000>;
+
+	tx_delay = <0x42>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmiim0_miim
+		     &rgmiim0_tx_bus2
+		     &rgmiim0_rx_bus2
+		     &rgmiim0_rgmii_clk
+		     &rgmiim0_rgmii_bus
+		     &ethm0_pins>;
+
+	phy-handle = <&rgmii_phy>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default", "pmic-sleep",
+			"pmic-power-off", "pmic-reset";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		wakeup-source;
+		#clock-cells = <1>;
+		clock-output-names = "rk808-clkout1", "rk808-clkout2";
+
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_logic";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_cpu";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_ddr";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_gpu";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc2v8_dvp: LDO_REG1 {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-name = "vcc2v8_dvp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_pmu";
+				regulator-state-mem {
+				regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vccio_acodec";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3_pmu";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_1v8";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pmu";
+				regulator-state-mem {
+				regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v8_dvp: LDO_REG9 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8_dvp";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_3v3";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc3v3_sd";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&mdio0 {
+	rgmii_phy: phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		clocks = <&cru CLK_GMAC_ETH_OUT2IO>;
+		assigned-clocks = <&cru CLK_GMAC_ETH_OUT2IO>;
+		assigned-clock-rates = <25000000>;
+	};
+};
+
+&pcie2x1 {
+	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie20>;
+	status = "okay";
+};
+
+&pinctrl {
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_host_pwren: usb-host-pwren {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usb_otg_pwren: usb-otg-pwren {
+			rockchip,pins = <0 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&saradc0 {
+	status = "okay";
+	vref-supply = <&vcc_1v8>;
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	full-pwr-cycle-in-suspend;
+	status = "okay";
+};
+
+&sdmmc0 {
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	status = "okay";
+};
+
+&sdmmc1 {
+	no-sd;
+	no-mmc;
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+	phy-supply = <&vcc5v0_usb_host>;
+};
+
+&u2phy_otg {
+	status = "okay";
+	phy-supply = <&vcc5v0_usb_otg>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn>;
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usbdrd_dwc3 {
+	status = "okay";
+	dr_mode = "host";
+	extcon = <&u2phy>;
+	maximum-speed = "high-speed";
+	phys = <&u2phy_otg>;
+	phy-names = "usb2-phy";
+	snps,dis_u2_susphy_quirk;
+	snps,usb2-lpm-disable;
+};
-- 
2.25.1


