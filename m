Return-Path: <linux-kernel+bounces-525879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2353A3F6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBF3BD307
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A78920F09A;
	Fri, 21 Feb 2025 14:05:13 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033E1F4281
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146712; cv=none; b=GKGChuYcPC1o4O4a6HXB6wa94HzvTTsUQO5M5JuQnMnH+hdLpVWXJVOjjJXuF1haFLmVD/xCZ1YVeNVhY82dvNqDlWCCXyTJ85mducHixb6zQIZTKZoZ7d3zqFIFmto9ubtOen0XLFB4RWfruGbOpEMroNnDkv0IMZIrVoCEQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146712; c=relaxed/simple;
	bh=Fhu01hguLpxdSCdRiUt6ZoqGPPHRYI7QuUAEHmrpgaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VskyHRt2QIzAA5LT2S0/dqXr4EdXWzp1HffbIGtDm1ztaK6h/Md2wlo6c1/JEOPfhI4iHzSReREGFeKxHqfShThbqRs0VRlvkU6H+34yZfbF2DVJ7RI3cGLxwAqY8kwOnL8Wf4KoHiFws5Um+hkjz6RODqH53ctu9dwB1lfZUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzsMg2wt0zRTj;
	Fri, 21 Feb 2025 15:05:03 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzsMf5Yy2zYKb;
	Fri, 21 Feb 2025 15:05:02 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 21 Feb 2025 15:04:37 +0100
Subject: [PATCH v2 5/5] arm64: dts: rockchip: add overlay for RK3399 Puma
 Haikou Video Demo adapter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-ringneck-dtbos-v2-5-310c0b9a3909@cherry.de>
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
devkit with RK3399 Puma SoM.

The Video Demo adapter is an adapter connected to the fake PCIe slot
labeled "Video Connector" on the Haikou devkit.

Its main feature is a Leadtek DSI-display with touchscreen and a camera
(that is not supported yet because the expected clock rate by the driver
cannot be exactly reached by the clock driver). To drive these
components a number of additional regulators are grouped on the adapter
as well as a PCA9670 gpio-expander to provide the needed additional
gpio-lines.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   5 +
 .../rockchip/rk3399-puma-haikou-video-demo.dtso    | 166 +++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 0f7c5c55c8b8be11e3fd7a69995ce1c17b22c80d..a46ed20e977aedb7cca1a9c0ad15f5441e4fe177 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -63,6 +63,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinephone-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou-video-demo.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-plus.dtb
@@ -201,6 +202,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-haikou-video-demo.dtb
 px30-ringneck-haikou-haikou-video-demo-dtbs := px30-ringneck-haikou.dtb \
 	px30-ringneck-haikou-video-demo.dtbo
 
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou-haikou-video-demo.dtb
+rk3399-puma-haikou-haikou-video-demo-dtbs := rk3399-puma-haikou.dtb \
+	rk3399-puma-haikou-video-demo.dtbo
+
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-vz-2-uhd.dtb
 rk3568-wolfvision-pf5-vz-2-uhd-dtbs := rk3568-wolfvision-pf5.dtb \
 	rk3568-wolfvision-pf5-display-vz.dtbo \
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..0377ec860d35461b7d2d4ee1f20bdd4a076a5fe6
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ *
+ * DEVKIT ADDON CAM-TS-A01
+ * https://embedded.cherry.de/product/development-kit/
+ *
+ * DT-overlay for the camera / DSI demo appliance for Haikou boards.
+ * In the flavour for use with a Puma system-on-module.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/rk3399-cru.h>
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
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* OV5675, GT911, DW9714 are limited to 400KHz */
+	clock-frequency = <400000>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PC7 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio1 RK_PC7 GPIO_ACTIVE_HIGH>;
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
+		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mipi_out {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
+
+&mipi_dsi {
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
+&pinctrl {
+	pca9670 {
+		pca9670_resetn: pca9670-resetn {
+			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	touch {
+		touch_int: touch-int {
+			rockchip,pins = <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};

-- 
2.48.1


