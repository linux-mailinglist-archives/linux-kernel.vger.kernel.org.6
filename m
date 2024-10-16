Return-Path: <linux-kernel+bounces-368883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E329A160A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637492853BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338EB1D5153;
	Wed, 16 Oct 2024 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="hA6Z918F"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880F1534E6;
	Wed, 16 Oct 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120418; cv=pass; b=ChNFK3pw7R8//1onH1FATu/xCyuP+9j2tRt8lzDOU/avVd9tTii4yEooOk3OPk1c6ilHuKJCpQG3UTp57jRVTrKQJKFDO7m23F9T+WxrewOe0I0BmWIBSfNOWjeYtIkbB3IzwR84x5MQH3cGSxWHw0oFnAcAwu8X5zEA6oLSH40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120418; c=relaxed/simple;
	bh=47umO8V09/pHYxDopyQA9itjQD6ZNG/tA6qt9x7NCco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9NPk/H2pamSFkzZz2wgDr503aFRnPszuO5JpVSaSXN2qcIv/vbHZ4WCZC026hGKgi75p4q5qnE117Bpah/fmLibL/kfSZn9QWi4mMUpbw+hLe/Kh+/uOSqx6rKs7kkksgFnnfXItTspjGueL4fPzGvA/6iGtbmqND5TNgBs5RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=hA6Z918F; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1729120403; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RFXUxcs6R7OSbIhX0xErZlijcXym/AkiHarohEdpFsNuIqB/vfYSfbeI2RycLNAo8kWIXS7iCzrtybt6ThIFfzuCOuMK3iqKQIeK9Oxe6f9+zCrsc8qboEhd0NTJVbz8KFPbNhFZgVhzUQAuRJOzcEG1uYjC3piwX92jdJ+0SLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729120403; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d1U5ck68BlRdeK+nMbK5e/7F6C8Up0+xpHm6xStt/gE=; 
	b=ZqDvomeVK9MtqMn0MgkCwZ2eGqdDlJtDQCrGZK51cpZd9BZ9tIT30tNKQ1f90jt6zZHujMHsga7yBs9eWziTycKnXOZ4x/9DM9PO+JFJ11uZkWtqSvSAF9k92KU1Yyv71c9/TB24HUtxx8ldTWkCAP6MYJdlTpDdGIkyicOUxGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729120403;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d1U5ck68BlRdeK+nMbK5e/7F6C8Up0+xpHm6xStt/gE=;
	b=hA6Z918F8AOnmQJhFceVD9CMQX3klqufIPN4jaAB1mJ9UJBFdPiW4FLdotn3o3VD
	UxZxNj2ciPXqxOJCElqaONhUDOP3w0ZhISJ4RYDeYsxJN+b3tEOqwoArhY4jkx2Mwqu
	S+KzA6zOP61u0z21y/yfuEgePNbeXPHSMdzzBOE82AsF4TNGdfxT8jVRaP7NN+1sBnL
	GsRP/3ax6f53L3Hfu5uZeBfEwR1s5sebnkQ2zFhP7hE/jHXy5/IPaOtHQt+qRTv2ejy
	cP3go3Ad6Cg9Gkjg3nV6hJt8/07TTO8YZ7ma/opjN8588fMR2wSwE5oE47HseQE1Uom
	79PFFWzcXw==
Received: by mx.zohomail.com with SMTPS id 1729120401655618.3690272997727;
	Wed, 16 Oct 2024 16:13:21 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH RESEND 2/2] ARM: dts: sunxi: add support for RerVision A33-Vstar board
Date: Thu, 17 Oct 2024 07:13:02 +0800
Message-ID: <20241016231302.1042278-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016231302.1042278-1-uwu@icenowy.me>
References: <20241016231302.1042278-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

RerVision A33-Vstar board is a board based on their A33-Core1 SoM (A33
SoC + 512MiB DRAM + 4GiB eMMC + AXP223 PMIC), with multiple peripherals:

- MicroSD card slot
- 4.0mm/1.7mm DC jack connected to ACIN of AXP223 (and a XH2.54 2-pin
  connector for alternative 5V DC IN)
- OTG-capable microUSB port
- Reserved pads for soldering Li-ion battery and/or 3V RTC battery
- 3 LRADC-attached keys and 2 fixed function power/reset keys
- AP6212 Wi-Fi/BT combo module
- On-board GL850G hub attached to the USB host port of A33, and a
  RTL8152 USB Ethernet chip at the downstream of the hub
- Onboard microphone (not supported yet) and headphone jack
- 3 UART ports as PH2.0 3-pin connectors (UART2 one is currently used as
  debug output and others are ignored yet)

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Resend with the needing DT binding fix already landed in linux-next.

 arch/arm/boot/dts/allwinner/Makefile          |   1 +
 .../dts/allwinner/sun8i-a33-vstar-core1.dtsi  |  96 ++++++++
 .../boot/dts/allwinner/sun8i-a33-vstar.dts    | 205 ++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-a33-vstar-core1.dtsi
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dts

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index cd0d044882cf8..d548f4a2621a1 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -215,6 +215,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a33-olinuxino.dtb \
 	sun8i-a33-q8-tablet.dtb \
 	sun8i-a33-sinlinx-sina33.dtb \
+	sun8i-a33-vstar.dtb \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
 	sun8i-a83t-bananapi-m3.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a33-vstar-core1.dtsi b/arch/arm/boot/dts/allwinner/sun8i-a33-vstar-core1.dtsi
new file mode 100644
index 0000000000000..ba794b842ec4e
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-a33-vstar-core1.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+#include "sun8i-a33.dtsi"
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	drive-strength = <40>;
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp22x: pmic@3a3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
+	};
+};
+
+#include "axp223.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2350000>;
+	regulator-max-microvolt = <2650000>;
+	regulator-name = "vdd-dll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-avcc";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
diff --git a/arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dts b/arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dts
new file mode 100644
index 0000000000000..9f5c29b3df46d
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dts
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+/dts-v1/;
+#include "sun8i-a33-vstar-core1.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Rervision A33-Vstar";
+	compatible = "rervision,a33-vstar",
+		     "rervision,a33-core1",
+		     "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &r8152;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
+	};
+
+	wifi_pwrseq: pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL6 */
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+	};
+};
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
+&ehci0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub@1 {
+		/* Onboard GL850G hub which needs no extra power sequence */
+		compatible = "usb5e3,608";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		r8152: ethernet@4 {
+			/*
+			 * Onboard Realtek RTL8152 USB Ethernet,
+			 * with no MAC address programmed
+			 */
+			compatible = "usbbda,8152";
+			reg = <4>;
+		};
+	};
+};
+
+&lradc {
+	vref-supply = <&reg_aldo3>;
+	status = "okay";
+
+	button-191 {
+		label = "V+";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <191011>;
+	};
+
+	button-391 {
+		label = "V-";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <391304>;
+	};
+
+	button-600 {
+		label = "BACK";
+		linux,code = <KEY_BACK>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pg_pins>;
+	vmmc-supply = <&reg_dldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>; /* PL7 */
+		interrupt-names = "host-wake";
+	};
+};
+
+/*
+ * Our WiFi chip needs both DLDO1 and DLDO2 to be powered at the same
+ * time, with the two being in sync. Since this is not really
+ * supported right now, just use the two as always on, and we will fix
+ * it later.
+ */
+&reg_dldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi0";
+};
+
+&reg_dldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi1";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&sound {
+	/* TODO: on-board microphone */
+
+	simple-audio-card,widgets = "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+		"Left DAC", "DACL",
+		"Right DAC", "DACR",
+		"Headphone Jack", "HP";
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pg_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+		host-wakeup-gpios = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		shutdown-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	};
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.47.0


