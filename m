Return-Path: <linux-kernel+bounces-310270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21414967744
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE52809D9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98718592E;
	Sun,  1 Sep 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="T9hPvvmt"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908517B433;
	Sun,  1 Sep 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206269; cv=none; b=iKkpi54bkOWIkEo70CZwKTqj5v+d1nGurtwKmKrFg3iuO09VMrk3w0EwowD/+4QEtPszVqc7vsru8wiv6r8pJTaXhQ9/7B5DyoKOsnDexbVCPbbBBDmB+vhbD5FKQ9Gu5kGu/GKcnL4GulXmZYw/uHCMPSnphRQ0EjRAfjA47kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206269; c=relaxed/simple;
	bh=Oy4yxmX1JX+gOfwgTqDINTY65VmJhtOj/OGOHXiZZc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sbn/TMGLvQZp/sb50kZJZ/7pmMQ0m/AXW2AG1/OEP66ySptwZRxs2nT1Q0cMepCsg4cNSsZ7DFHgY+TkgF5wtt3M6fIICddZ1m7memWICBS/BYA6Ve3zFbwJuNqg4qFtWHGumisDFYEPFwwyWPOWoiSIGeJ9ddXszMyJg753r7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=T9hPvvmt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0E6A71F9F1;
	Sun,  1 Sep 2024 17:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206256;
	bh=1Ob0e+Qn93ij7b7IP/gAJRwe1k4eBRmfkKD7MG+ku9Y=; h=From:To:Subject;
	b=T9hPvvmtU3tFcc8K/o9OoQXZ4QBU3svlnRyQENkuKCcsGDZis59iIJLVMyJXpWl+l
	 1VhHhW537nFvOfIr7mycg9izXvX2QC5wUevKfpr0IE3Xsk4j4EI/ZGbwDGmPyUwMr2
	 VUuKObO239ajmFjlWL4F3y+ClKnod0FARrAAcvg3bjTqHvjlua/hy4BlO5DNsBUbh/
	 eUw+4niY8xfqrJYvvb9J5BB/z644/a61Y3xRGeT73H/aWU9UZbUVLw0T/7h04Cy1kG
	 Sq7o8Xsgp9q046qA2S19PbSdZErH8mB7xCc5GUcASCakzR1Mazi/FzDFOlqs08bSd9
	 w++QBy4BOtB6Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 01/10] arm64: dts: colibri-imx8x: Add usb support
Date: Sun,  1 Sep 2024 17:57:12 +0200
Message-Id: <20240901155721.7912-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add USB HOST and OTG support to Colibri-iMX8X carrier boards.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Fix 'id-gpios' property, s/id-gpio/id-gpios/
---
 .../dts/freescale/imx8x-colibri-aster.dtsi    | 26 +++++++++++++
 .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 26 +++++++++++++
 .../dts/freescale/imx8x-colibri-iris.dtsi     | 26 +++++++++++++
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 37 +++++++++++++++++--
 4 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
index bc659066e19a..c02dfdd75b60 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
@@ -7,6 +7,10 @@ &colibri_gpio_keys {
 	status = "okay";
 };
 
+&extcon_usbc_det {
+	status = "okay";
+};
+
 /* Colibri Ethernet */
 &fec1 {
 	status = "okay";
@@ -38,6 +42,28 @@ &lpuart3 {
 	status = "okay";
 };
 
+/* USB PHY for usbotg3 */
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg1 {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	status = "okay";
+};
+
+/* USB PHY for usbotg1 */
+&usbphy1 {
+	status = "okay";
+};
+
 /* Colibri SDCard */
 &usdhc2 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 9af769ab8ceb..91de84772e1c 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -23,6 +23,10 @@ &colibri_gpio_keys {
 	status = "okay";
 };
 
+&extcon_usbc_det {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -90,6 +94,28 @@ &fec1 {
 	status = "okay";
 };
 
+/* USB PHY for usbotg3 */
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg1 {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	status = "okay";
+};
+
+/* USB PHY for usbotg1 */
+&usbphy1 {
+	status = "okay";
+};
+
 /* Colibri SD/MMC Card */
 &usdhc2 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
index 8d06925a8ebd..a6b013cc6929 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -21,6 +21,10 @@ &colibri_gpio_keys {
 	status = "okay";
 };
 
+&extcon_usbc_det {
+	status = "okay";
+};
+
 /* Colibri FastEthernet */
 &fec1 {
 	status = "okay";
@@ -108,6 +112,28 @@ &lsio_pwm2 {
 	status = "okay";
 };
 
+/* USB PHY for usbotg3 */
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg1 {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	status = "okay";
+};
+
+/* USB PHY for usbotg1 */
+&usbphy1 {
+	status = "okay";
+};
+
 /* Colibri SD/MMC Card */
 &usdhc2 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 49d105eb4769..56de45fb05e7 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -23,12 +23,31 @@ key-wakeup {
 		};
 	};
 
+	extcon_usbc_det: usbc-det {
+		compatible = "linux,extcon-usb-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+		id-gpios = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh1_reg>;
+		gpio = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
+		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usbh_vbus";
+	};
 };
 
 /* TODO Analogue Inputs */
@@ -329,6 +348,20 @@ &lsio_pwm2 {
 
 /* TODO On-module i2s / Audio */
 
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	extcon = <&extcon_usbc_det &extcon_usbc_det>;
+	hnp-disable;
+	power-active-high;
+	srp-disable;
+	vbus-supply = <&reg_usbh_vbus>;
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "host";
+};
+
 /* On-module eMMC */
 &usdhc1 {
 	bus-width = <8>;
@@ -356,10 +389,6 @@ &usdhc2 {
 	no-1-8-v;
 };
 
-/* TODO USB Client/Host */
-
-/* TODO USB Host */
-
 /* TODO VPU Encoder/Decoder */
 
 &iomuxc {
-- 
2.39.2


