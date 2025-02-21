Return-Path: <linux-kernel+bounces-525878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1CA3F6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD123B92F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079220F060;
	Fri, 21 Feb 2025 14:05:12 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36461EB1B9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146712; cv=none; b=oBKPJzLTDRjNVWfrpyv7kHZCbj6GEpIVdSpwZ2LdW2ph0G7yszHftnrRrt0jgu3wleIOyDAIvBM5YYK/+o6uKWtbKtyM2D+u2rdCUoxIrdxt5tRE1iBzk0t6W+90fv+pYVoH7MxAK3oOKWCjEySBt1YdVVFdOavlTUMFhn5eEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146712; c=relaxed/simple;
	bh=T1iXvRyD29yOzLTQL99Z3lF9EZFdZpHfsWETfDgieRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kfzb6VWAl0uOzsYeJl3o4pVgUFWbqdPRlfnjghr7S6Qc18xRaAULUf02kzxLJ7Y31MU2pwxto0hc2vPOr5dNHkfkrWuwtS4QRXu6Z2TVBJ4Xg8v1bF/vZCSqO7B/DlQgOdx7mdXPQomyYxQStmPA6QzYQ3jBU6geYog09Feq8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzsMd6d7rzVYM;
	Fri, 21 Feb 2025 15:05:01 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzsMd2HNBzYZB;
	Fri, 21 Feb 2025 15:05:01 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 21 Feb 2025 15:04:35 +0100
Subject: [PATCH v2 3/5] arm64: dts: rockchip: add support for
 HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-ringneck-dtbos-v2-3-310c0b9a3909@cherry.de>
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


