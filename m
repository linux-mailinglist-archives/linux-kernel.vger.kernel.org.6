Return-Path: <linux-kernel+bounces-302294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D128095FC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B4B21565
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147F19CD12;
	Mon, 26 Aug 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="E00Xvnct"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920A143757;
	Mon, 26 Aug 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709583; cv=none; b=q2C99j+gJe3/V6eVOwQfUjSyvdz/NGB7TTntPPhwnT1hctALh5XjEgznyzLlO8dGIdvOn/OKTYS/+Oo5Vr6xrYZm5C6cCbE8H27Z3kiF4JHHNQPysx1ZFmCUWtF8BKxHTDOhEMD2bIMEHDQxk6rvDXNesRqOG0db7qQ/p5TRk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709583; c=relaxed/simple;
	bh=8gstfm0mCuTrJCakY7iF+V9AvoPlqCRi7LblwbKhD/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l85tgKZwiz8RhqtpgfuenXvCvCT4GqPPGbZ6DT5TYvz+FFOLvE5D9zCKljr9+ZL7Fe5NVUT7M8CE0NtOs1eie9mS3hRIQOlbCjbAgzKNUU8G6pg5JgMjhSCw1920nP6NSiHt1XTD5w1ClnyDyQEP9ui6K2vZTBEybIvSVeRyNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=E00Xvnct; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D393525017;
	Mon, 26 Aug 2024 23:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709577;
	bh=FqS9Cyqz6dpZP7Sy6v7YHLIg5mvaiCVwUco5tXm5AtM=; h=From:To:Subject;
	b=E00Xvnctnr914ljcx0lMhPItjT2yllJhU4NdnQZ/cMynt27qriKwln66X5LlTWaZd
	 wEu/9N4Y+ptxTXI0lutfe81P97dGOYgAtFfFJ1vXXoq6OB+1Qd/1++hEgHJHVp3zSN
	 5Hw9y4I0cYGAFcF0+Mbmusl4/puXvCX+fss970C5kiTp+hUkyvfXvcYBEi428Am3xq
	 35WyXulJO6rTiKv31XnNVkv+oTnO8ZiSqLM3J1ID57ZglGHnUTUK/KvBMAmMz/xqw3
	 2+7WPgJhv9BWFU2Jk/3HTJkAq2BL3C7gxlFHBaGpnNTiiDEHv3dD+7pu3NTwEix4xw
	 u2OAvwkNQUGLw==
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
Subject: [PATCH v1 01/10] arm64: dts: colibri-imx8x: Add usb support
Date: Mon, 26 Aug 2024 23:59:13 +0200
Message-Id: <20240826215922.13225-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826215922.13225-1-francesco@dolcini.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
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
index 49d105eb4769..1199e311d6f9 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -23,12 +23,31 @@ key-wakeup {
 		};
 	};
 
+	extcon_usbc_det: usbc-det {
+		compatible = "linux,extcon-usb-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_det>;
+		id-gpio = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;
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


