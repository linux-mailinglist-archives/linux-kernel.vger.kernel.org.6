Return-Path: <linux-kernel+bounces-523666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C731A3D9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9932A189F547
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63D1F790B;
	Thu, 20 Feb 2025 12:20:48 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEB1F463E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054047; cv=none; b=faD93PCJcfBhxLjhZP0QjJKR8dSdszSGnGuq+/2O7tWR9zoB0oYe3+L12idOo3jT8X52myBlKBX9vRNwTQlKW5sxgD4GzIPB/0jrUsyo2m4Ye/2m/3GhqRIuNYIk91JXa4D3Ke84iAwApKs/EfpR/cPedKst2sCKwaxV09BBghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054047; c=relaxed/simple;
	bh=T1iXvRyD29yOzLTQL99Z3lF9EZFdZpHfsWETfDgieRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBm+65/HQ2bzc27TUTthhUhqBVp4KOvMA6FfBvTz6NSZqO8XzNbCO6DtqcvlWhjttz72KZAObiMfVQ56GYks40eQ9z6BAx3fqcNWALLu7Khq3ON4dwiJmIQgwhzUnuFrCZf1XnWXumDFGcz3bgIzcP9UzTVLYGvXqs6m9mVfceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzC5d0BYnzmGV;
	Thu, 20 Feb 2025 13:20:37 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzC5c2rkSzGKM;
	Thu, 20 Feb 2025 13:20:36 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Thu, 20 Feb 2025 13:20:12 +0100
Subject: [PATCH 3/5] arm64: dts: rockchip: add support for
 HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-ringneck-dtbos-v1-3-25c97f2385e6@cherry.de>
References: <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
In-Reply-To: <20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de>
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

The HAIKOU-LVDS-9904379 adapter is an adapter for PX30 Ringneck with the
Haikou carrierboard. It is to be inserted in the fake PCIe slot labelled
Video Connector.

This adapter expects an Admatec 9904379 1024x600 LVDS display with
backlight and touchscreen. An EEPROM is also found on the adapter.

This adds support for this adapter on PX30 Ringneck when inserted in
Haikou carrierboard.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   5 +
 .../px30-ringneck-haikou-lvds-9904379.dtso         | 130 +++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e4d9c48b95bba204f50697480d06e9a4071e56d3..b40b82bd07223f542c17704e7844f002bb31e1c5 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4-core-mb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-lvds-9904379.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-bpi-p2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
@@ -191,6 +192,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5c.dtb
 # result of the application of <overlay-1>.dtbo and other listed overlays on top
 # of <base>.dtb.
 
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-haikou-lvds-9904379.dtb
+px30-ringneck-haikou-haikou-lvds-9904379-dtbs := px30-ringneck-haikou.dtb \
+	px30-ringneck-haikou-lvds-9904379.dtbo
+
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-vz-2-uhd.dtb
 rk3568-wolfvision-pf5-vz-2-uhd-dtbs := rk3568-wolfvision-pf5.dtb \
 	rk3568-wolfvision-pf5-display-vz.dtbo \
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-lvds-9904379.dtso b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-lvds-9904379.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..3fc088a5636a24b40a8536b28a210fce79f6d333
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-lvds-9904379.dtso
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ *
+ * HAIKOU-LVDS-9904379 adapter for PX30 Ringneck and Haikou carrierboard.
+ *
+ * This adapter needs to be plugged in the fake PCIe connector called Video
+ * Connector on Haikou carrierboard.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+&{/} {
+	backlight_lvds: backlight-lvds {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 255>;
+		default-brightness-level = <255>;
+		num-interpolated-steps = <255>;
+		power-supply = <&vcc3v3_baseboard>;
+		pwms = <&pwm0 0 25000 0>;
+	};
+
+	panel {
+		compatible = "admatec,9904379", "panel-lvds";
+		backlight = <&backlight_lvds>;
+		data-mapping = "vesa-24";
+		height-mm = <126>;
+		power-supply = <&vcc3v3_baseboard>;
+		width-mm = <224>;
+
+		panel-timing {
+			clock-frequency = <49500000>;
+			hactive = <1024>;
+			hback-porch = <90>;
+			hfront-porch = <90>;
+			hsync-len = <90>;
+			vactive = <600>;
+			vback-porch = <10>;
+			vfront-porch = <10>;
+			vsync-len = <10>;
+		};
+
+		port {
+			panel_in_lvds: endpoint {
+				remote-endpoint = <&lvds_out_panel>;
+			};
+		};
+	};
+};
+
+&display_subsystem {
+	status = "okay";
+};
+
+&dsi_dphy {
+	status = "okay";
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* EEPROM and GT928 are limited to 400KHz */
+	clock-frequency = <400000>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt928";
+		reg = <0x14>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&touch_int &touch_rst>;
+		pinctrl-names = "default";
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		AVDD28-supply = <&vcc3v3_baseboard>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+	};
+
+	eeprom@54 {
+		reg = <0x54>;
+		compatible = "st,24c04", "atmel,24c04";
+		pagesize = <16>;
+		size = <512>;
+		vcc-supply = <&vcc3v3_baseboard>;
+	};
+};
+
+&lvds {
+	status = "okay";
+};
+
+&lvds_out {
+	lvds_out_panel: endpoint {
+		remote-endpoint = <&panel_in_lvds>;
+	};
+};
+
+&pinctrl {
+	touch {
+		touch_int: touch-int {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		touch_rst: touch-rst {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
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


