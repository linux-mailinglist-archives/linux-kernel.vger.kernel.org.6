Return-Path: <linux-kernel+bounces-525880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8DFA3F6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372F53BBAB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0420FA93;
	Fri, 21 Feb 2025 14:05:13 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B75204C02
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146712; cv=none; b=IenLOZ4oJTn6isSAJ+VDSZl0ENljRJ/QmNlRZgKwMe2SblLqQ9G/qjpC6hjn1f6UIN0egMuwfbp9AsFm67HZsbuQeEvr+Cw2zU6NioJask4j0X9WylmvMDSjh4cLY83gohG9bCsRySeyW3EoIN0TxmOYJ+KUt2ZSdWIDs/M/xOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146712; c=relaxed/simple;
	bh=+JLjXWKiRg+EQ4ENsImXRR1E80JN9eVBk/Ontn9bJF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=heW76YQo0HaPH51EttTCX0Tke7fikxTENIRZ+Wajlrh7dvvKxhCS2kxp5EinMOrXMgsuu5mrYYK/NHTMDUrosqDIuoqsBrXzj1/StDTaT8PDvx8lQgmRNprN1gtYTI9Shc3M90wU6UEDEz1PqkJonytJQw6UBxj2J/Xs34iRdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzsMf5YhgzRdr;
	Fri, 21 Feb 2025 15:05:02 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzsMd6ZDmzX2K;
	Fri, 21 Feb 2025 15:05:01 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 21 Feb 2025 15:04:36 +0100
Subject: [PATCH v2 4/5] arm64: dts: rockchip: add overlay for PX30 Ringneck
 Haikou Video Demo adapter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-ringneck-dtbos-v2-4-310c0b9a3909@cherry.de>
References: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
In-Reply-To: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds support for the video-demo-adapter DEVKIT ADDON CAM-TS-A01
(https://embedded.cherry.de/product/development-kit/) for the Haikou
devkit with PX30 Ringneck SoM.

The Video Demo adapter is an adapter connected to the fake PCIe slot
labeled "Video Connector" on the Haikou devkit.

Itss main feature is a Leadtek DSI-display with touchscreen and a camera
(that is not supported yet because the expected clock rate by the driver
cannot be exactly reached by the clock driver). To drive these
components a number of additional regulators are grouped on the adapter
as well as a PCA9670 gpio-expander to provide the needed additional
gpio-lines.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   5 +
 .../rockchip/px30-ringneck-haikou-video-demo.dtso  | 190 +++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b40b82bd07223f542c17704e7844f002bb31e1c5..0f7c5c55c8b8be11e3fd7a69995ce1c17b22c80d 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4-core-mb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-lvds-9904379.dtbo
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-video-demo.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-bpi-p2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
@@ -196,6 +197,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-haikou-lvds-9904379.dtb
 px30-ringneck-haikou-haikou-lvds-9904379-dtbs := px30-ringneck-haikou.dtb \
 	px30-ringneck-haikou-lvds-9904379.dtbo
 
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-haikou-video-demo.dtb
+px30-ringneck-haikou-haikou-video-demo-dtbs := px30-ringneck-haikou.dtb \
+	px30-ringneck-haikou-video-demo.dtbo
+
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-vz-2-uhd.dtb
 rk3568-wolfvision-pf5-vz-2-uhd-dtbs := rk3568-wolfvision-pf5.dtb \
 	rk3568-wolfvision-pf5-display-vz.dtbo \
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..7d9ea5aa598486680191d52e4c87af59f7b0e579
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ *
+ * DEVKIT ADDON CAM-TS-A01
+ * https://embedded.cherry.de/product/development-kit/
+ *
+ * DT-overlay for the camera / DSI demo appliance for Haikou boards.
+ * In the flavour for use with a Ringneck system-on-module.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/px30-cru.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+&{/} {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&dc_12v>;
+		pwms = <&pwm0 0 25000 0>;
+	};
+
+	cam_afvdd_2v8: regulator-cam-afvdd-2v8 {
+		compatible  = "regulator-fixed";
+		gpio = <&pca9670 2 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "cam-afvdd-2v8";
+		vin-supply = <&vcc2v8_video>;
+	};
+
+	cam_avdd_2v8: regulator-cam-avdd-2v8 {
+		compatible  = "regulator-fixed";
+		gpio = <&pca9670 4 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "cam-avdd-2v8";
+		vin-supply = <&vcc2v8_video>;
+	};
+
+	cam_dovdd_1v8: regulator-cam-dovdd-1v8 {
+		compatible  = "regulator-fixed";
+	        gpio = <&pca9670 3 GPIO_ACTIVE_LOW>;
+	        regulator-max-microvolt = <1800000>;
+	        regulator-min-microvolt = <1800000>;
+	        regulator-name = "cam-dovdd-1v8";
+	        vin-supply = <&vcc1v8_video>;
+	};
+
+	cam_dvdd_1v2: regulator-cam-dvdd-1v2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&pca9670 5 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-name = "cam-dvdd-1v2";
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	vcc1v8_video: regulator-vcc1v8-video {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vcc1v8-video";
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	vcc2v8_video: regulator-vcc2v8-video {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "vcc2v8-video";
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	video-adapter-leds {
+		compatible = "gpio-leds";
+
+		video-adapter-led {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pca9670 7 GPIO_ACTIVE_HIGH>;
+			label = "video-adapter-led";
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&display_subsystem {
+	status = "okay";
+};
+
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "leadtek,ltk050h3148w";
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc1v8_video>;
+		reset-gpios = <&pca9670 0 GPIO_ACTIVE_LOW>;
+		vci-supply = <&vcc2v8_video>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_dphy {
+	status = "okay";
+};
+
+&dsi_out {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* OV5675, GT911, DW9714 are limited to 400KHz */
+	clock-frequency = <400000>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&touch_int>;
+		pinctrl-names = "default";
+		reset-gpios = <&pca9670 1 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&vcc2v8_video>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+	};
+
+	pca9670: gpio@27 {
+		compatible = "nxp,pca9670";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&pca9670_resetn>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	pca9670 {
+		pca9670_resetn: pca9670-resetn {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	touch {
+		touch_int: touch-int {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};

-- 
2.48.1


