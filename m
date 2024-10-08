Return-Path: <linux-kernel+bounces-355424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D954E995245
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A423B25C53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF51DFDB0;
	Tue,  8 Oct 2024 14:38:51 +0000 (UTC)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01C1DE4FC;
	Tue,  8 Oct 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398331; cv=none; b=ulQ8uBGrzx1FvXIpTHqCMMn3jT0qgdZ7RAEfKGD9ah2ZAV4b7QAhZhg9mXVm9dZw5sSYHx0EwM6hVTQbBdLMTzPo3rj//RU83rKCiWMiSmd77DeYGLJLrtn0K4GZ8usV3Va4wN7Q+iueMLkjDolOhTC6Z/zfUL3qRqHBjX8TwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398331; c=relaxed/simple;
	bh=VcM1xBe9c8/OlwJ1oGR8S8iqaUYMXkj2nAS5F8XmuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIzXpUlxGZ+fBg9PebPTZcWTeRacsyShsI0ip7w2JcVnMyGo3vTRGnb5vWvTOI3hFlg7LilW+2NPjzoaBqtz+ue8F+TbWn6GKyQcAiETG1nqL7Zmu+2DZ2ZSj4rBYKAetdz3PUoMn1Tc4qSXq4iaN0p5qJOlFaTi+0sx907c0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36E31BFB9D;
	Tue,  8 Oct 2024 16:38:46 +0200 (CEST)
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 4/4] arm64: dts: imx8mm-kontron: Add DL (Display-Line) overlay with LVDS support
Date: Tue,  8 Oct 2024 16:37:46 +0200
Message-ID: <20241008143804.126795-5-frieder@fris.de>
In-Reply-To: <20241008143804.126795-1-frieder@fris.de>
References: <20241008143804.126795-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Kontron Electronics DL i.MX8MM consists of the BL i.MX8MM board
and a 7" LVDS panel. Provide an overlay that enables the panel.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v3:
* Fix LVDS bridge input port reference

Changes for v2:
* Update copyright year
* Use exisitng MIPI DSI output port from imx8mm.dtsi
* Fix pinctrl for GPIO hogs
* Fix property order in i2c2 node
* Use generic node name for touchscreen
---
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 189 ++++++++++++++++++
 2 files changed, 193 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index f04c22b7de72e..d8af069139920 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -244,6 +244,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
+imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
+
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
+
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
new file mode 100644
index 0000000000000..1db27731b581c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "imx8mm-pinfunc.h"
+
+&{/} {
+	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+	};
+
+	panel {
+		compatible = "jenson,bl-jt60050-01a", "panel-lvds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+		enable-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+		height-mm = <86>;
+		width-mm = <154>;
+
+		panel-timing {
+			clock-frequency = <51200000>;
+			hactive = <1024>;
+			vactive = <600>;
+			hsync-len = <1>;
+			hfront-porch = <160>;
+			hback-porch = <160>;
+			vsync-len = <1>;
+			vfront-porch = <12>;
+			vback-porch = <23>;
+		};
+
+		port {
+			panel_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_mux_sel_hdmi {
+	status = "disabled";
+};
+
+&dsi_mux_sel_lvds {
+	status = "okay";
+};
+
+&mipi_dsi_out {
+	remote-endpoint = <&bridge_in_dsi_lvds>;
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio3>;
+
+	panel-rst-hog {
+		gpio-hog;
+		gpios = <20 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-reset";
+	};
+
+	panel-stby-hog {
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-standby";
+	};
+
+	panel-hinv-hog {
+		gpio-hog;
+		gpios = <24 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "panel-horizontal-invert";
+	};
+
+	panel-vinv-hog {
+		gpio-hog;
+		gpios = <25 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "panel-vertical-invert";
+	};
+};
+
+&hdmi {
+	status = "disabled";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 8>;
+		reset-gpios = <&gpio3 23 0>;
+		irq-gpios = <&gpio3 22 0>;
+	};
+};
+
+&lvds {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			bridge_in_dsi_lvds: endpoint {
+				remote-endpoint = <&mipi_dsi_out>;
+				data-lanes = <1 2>;
+			};
+		};
+
+		port@2 {
+			reg = <2>;
+
+			bridge_out_panel: endpoint {
+				remote-endpoint = <&panel_out_bridge>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x19
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x19
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000083
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000083
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x19
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x19
+		>;
+	};
+};
-- 
2.46.0


