Return-Path: <linux-kernel+bounces-534121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF300A46301
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFE118962CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33A2222C5;
	Wed, 26 Feb 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SvrskYHZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301B21C9E7;
	Wed, 26 Feb 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580555; cv=none; b=Eyya6EzITsxUG3UdaJbwd8VX+cb4/x1mx2hhKs9AcRTVqTO88lS1//OlW2dl0FR6Z+JzpHMuS78qQXdbtTDV7LMw7+/LPAlKiveEDgIyMwUZpeIfaDy6xKPPIAWOa80bK0zh4mSd6cWbat3afyldXJfQI+2SQXccL4eYnCaLFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580555; c=relaxed/simple;
	bh=h68gsh2XEk8LO4IEBYVLcCuerDrPBhtD2D2GRTB8yzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAVmYiwo4KO3Drb9sKzTrvjTQwbvJr/tSjpdBs0vyITUw7gxvHex1mO5BqNY1x0+SuNRyCuc0FQ4cIzrOFZN2qTTExbafyGR5zZ0JqUakrdd6MdIrHIuwwcVe7V3m6uHVRK1aHTxNMwJJHBkShLz/O3bBjA1vS0vJpnuq0symq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SvrskYHZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740580552;
	bh=h68gsh2XEk8LO4IEBYVLcCuerDrPBhtD2D2GRTB8yzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SvrskYHZYjMsocmKfAxUKmqMkvx05rKHkcpXkK4y1Hb0BSIomRFS9wcKjLK/FfDzW
	 SRJGnKnMNSd3vnCySTQ74kp0ZhLKJQpX/4j8fh5fmEScfcVicULdLqGy1Ri9YtQ34G
	 3pBEVQmaHakN8XAZ3gq1CFCAuGlnQ/U0ZdRDeeWGdU76wwHaPfnS64S/2EmtaFytAi
	 kT56/ixj77tgiWqDjG8VQSeoMAkd2BS2PPGRp35qcOiCsBzEJpQcJ1PW0HqJ/KkNNj
	 65KUxpSWJOePnVIsT+vcJ41/jgMF5V1Sm+mle9V336TAM8r9PEUTXIPzXxz8BtOnXH
	 98xZh49YNX3qw==
Received: from apertis-1.home (2a01cb088CcA73006086F5F072c6a07a.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:8cca:7300:6086:f5f0:72c6:a07a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA22017E066F;
	Wed, 26 Feb 2025 15:35:51 +0100 (CET)
From: Julien Massot <julien.massot@collabora.com>
Date: Wed, 26 Feb 2025 15:35:28 +0100
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8395-radxa-nio-12l: Add Radxa
 8 HD panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-radxa-panel-overlay-v1-2-9e8938dfbead@collabora.com>
References: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
In-Reply-To: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
To: kernel@collabora.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

The Radxa 8 HD touchscreen can be used with various Radxa board
and is sold appart from the Radxa NIO 12L development kit.

Add a DTS overlay for this panel.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  2 +
 .../mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso  | 64 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index ae1147eca9a915f117487101e2ad4acead97adfe..58484e8300632edbdef24bbda33ccf00db9df937 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -100,9 +100,11 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l-8-hd-panel.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
 
 # Device tree overlays support
 DTC_FLAGS_mt7986a-bananapi-bpi-r3 := -@
 DTC_FLAGS_mt7986a-bananapi-bpi-r3-mini := -@
 DTC_FLAGS_mt7988a-bananapi-bpi-r4 := -@
+DTC_FLAGS_mt8395-radxa-nio-12l := -@
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..5d633f61a62c3175fbfa133f3ea5b1a6a0b0fec5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Radxa Display 8 HD touchscreen module
+ * Copyright (C) 2025 Collabora Ltd.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "radxa,display-8hd-ad002", "jadard,jd9365da-h3";
+		reg = <0>;
+		backlight = <&backlight>;
+		vdd-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
+		vccio-supply = <&mt6360_ldo2>;
+		reset-gpios = <&pio 108 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel_default_pins>;
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&disp_pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_default_pins>;
+	status = "okay";
+};
+
+&dsi0_out {
+	remote-endpoint = <&dsi_panel_in>;
+};
+
+&mipi_tx0 {
+	status = "okay";
+};
+
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		interrupts-extended = <&pio 132 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&pio 132 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 133 GPIO_ACTIVE_HIGH>;
+		VDDIO-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+	};
+};

-- 
2.48.1


