Return-Path: <linux-kernel+bounces-520110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96519A3A5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE933A43BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6926F47B;
	Tue, 18 Feb 2025 18:38:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDD26A1D4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903908; cv=none; b=jpnwEmdZDmg1EVWe5JZyYJ6DlDRZfnpXQ8vjKWGXjwo21i8W0XAM+wKwL5g8hyTH5Ai/f8INKsxmrGdNR9PwJ7/gXjDBR8RLtpaCMkuY0Kw7HyVzhQhwiwATFM9pVpJGUFkl00Cvg7WF53NpXc+3oWP1kqciodzmOyLqQRI1esc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903908; c=relaxed/simple;
	bh=ZKVdVgazIRw6bW7LXkyObO1onYtAKngJnsNMJi8dIos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj9o5m7I3sAdoF6JJy57ZNw2VrOdCr1TTdLSxVJXMRQAnSlcQlcS/YIUv0IsEP2sRq6D6qjh33VINI3DBODwYkvu4tUr+Ui//J4FuJadUaN8mopdJgxkRcNAbgqJU02dRxLwJmLbihi315hlSl3s1+qvbmB78DKRRqgANGeR7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSU2-0000Gz-PW; Tue, 18 Feb 2025 19:38:14 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSU2-001dan-1T;
	Tue, 18 Feb 2025 19:38:14 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSU2-00AL9G-15;
	Tue, 18 Feb 2025 19:38:14 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 18 Feb 2025 19:38:17 +0100
Subject: [PATCH v2 5/6] arm64: dts: imx8mp-skov: add revC BD500 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-skov-imx8mp-new-boards-v2-5-4040379742ea@pengutronix.de>
References: <20250218-skov-imx8mp-new-boards-v2-0-4040379742ea@pengutronix.de>
In-Reply-To: <20250218-skov-imx8mp-new-boards-v2-0-4040379742ea@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The BD500 replaces the touch display with 3 bicolor LEDs and a push
button on top of a Skov i.MX8-CPU revision C.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  1 +
 .../boot/dts/freescale/imx8mp-skov-revc-bd500.dts  | 91 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index ea4da899b44be0aaac745f6a0503bed3bb8ba20c..6ee3a7ffe4792106118b8201c1f5f51c8ecd0ff2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -197,6 +197,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-mi1010ait-1cp1.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-bd500.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-var-som-symphony.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-revc-bd500.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-revc-bd500.dts
new file mode 100644
index 0000000000000000000000000000000000000000..b816c6cd3bca60b14cf6bc7f40cb780aa893958d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-revc-bd500.dts
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "imx8mp-skov-reva.dtsi"
+
+/ {
+	model = "SKOV IMX8MP CPU revC - bd500";
+	compatible = "skov,imx8mp-skov-revc-bd500", "fsl,imx8mp";
+
+	leds {
+		led_system_red: led-3 {
+			label = "bd500:system:red";
+			color = <LED_COLOR_ID_RED>;
+			/* Inverted compared to others due to NMOS inverter */
+			gpios = <&gpioexp 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led_system_green: led-4 {
+			label = "bd500:system:green";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioexp 2 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led_lan1_red: led-5 {
+			label = "bd500:lan1:act";
+			color = <LED_COLOR_ID_RED>;
+			linux,default-trigger = "netdev";
+			gpios = <&gpioexp 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led_lan1_green: led-6 {
+			label = "bd500:lan1:link";
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "netdev";
+			gpios = <&gpioexp 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led_lan2_red: led-7 {
+			label = "bd500:lan2:act";
+			color = <LED_COLOR_ID_RED>;
+			linux,default-trigger = "netdev";
+			gpios = <&gpioexp 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led_lan2_green: led-8 {
+			label = "bd500:lan2:link";
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "netdev";
+			gpios = <&gpioexp 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-1 {
+			label = "S1";
+			linux,code = <KEY_CONFIG>;
+			gpios = <&gpioexp 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	gpioexp: gpio@20 {
+		compatible = "nxp,pca6408";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_exp>;
+		interrupts-extended = <&gpio4 28 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 29 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_vdd_3v3>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&iomuxc {
+	pinctrl_gpio_exp: gpioexpgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x0
+			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x0
+		>;
+	};
+};

-- 
2.39.5


