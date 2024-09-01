Return-Path: <linux-kernel+bounces-310269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA2967741
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6142A281D41
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44518452D;
	Sun,  1 Sep 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RPwhOCUP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9317F394;
	Sun,  1 Sep 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206268; cv=none; b=dvwe6kbzSKs42taiisPqS6k5tqOsOMVxZLajb5DLxe6RTzBHKUerClWhWuIsnV/TVsAdJnnuQ86DcLYqcc+A8EIR7XrA/1YneuWQYijiGhUJKhmRZSG7JgZ3q0XZJLZDhC2GIXFB4k2H9LkBf+7fBBxSNfTSKQEZlZb4f263Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206268; c=relaxed/simple;
	bh=fMr2HWXnM6UrWgM7ClAXXDd7dYRaVVw74aBqRnYwhPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKBCokzZNHm+bL2O4aq98EW4uoIjnFvz+eK6JNLr8syZkXb1oNU/jvPQ8j7R0W+KNbXTN1EYgRLaHte0EQ1ELiKbI4JnQCfSKs0IjbqkBcjblRtm/3rYF3p3HdCdlnbVKOcc7TaWsFwsJMM9mzYXNVKa2+3ypskfey3KNI0rgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RPwhOCUP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DC7EB1FA59;
	Sun,  1 Sep 2024 17:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725206258;
	bh=KovUm7gxradhL47FySE0BJ+erGrrKC+Oq0JDZl3e670=; h=From:To:Subject;
	b=RPwhOCUPP40Pf7kjkF91XyIZ83X4ws79yzffJiGSWVmpSVldprSMhgdfqsVv1+WlS
	 3HpToBp+jH/O2CfbvOkHcLhHHeEAanXADugjdw4UaTvQCLz1WhjyNjlt8y/+RcEK5R
	 fRucT5LrsWNV1BoCEJA+KRCcYhgRK1dhjuVe7CwkO1bpZ9lYKH/01pIoj1DgR3ARUR
	 LZJpsnfUi8NHSMTY3LbtPLC26xaIhKefydvBKpZo/fmRzVMcDelz//BELZc625UTpz
	 y+425xP3ExcuG2jI8X6LuNBX5qOmTwpQ1OOU+BsEjwJbWFPh/t7h+GZcAlgd409Sla
	 b8OWZ8j3nl1pw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 04/10] arm64: dts: colibri-imx8x: Add sound card
Date: Sun,  1 Sep 2024 17:57:15 +0200
Message-Id: <20240901155721.7912-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901155721.7912-1-francesco@dolcini.it>
References: <20240901155721.7912-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add audio support for Colibri-iMX8X sound card.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: sort i2c nodes by address

fixup sound card
---
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 210db574b425..60cf4e400052 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -38,6 +38,13 @@ reg_module_3v3: regulator-module-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reg_module_3v3_avdd: regulator-module-3v3-avdd {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_AVDD_AUDIO";
+	};
+
 	reg_module_vref_1v8: regulator-module-vref-1v8 {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <1800000>;
@@ -55,6 +62,23 @@ reg_usbh_vbus: regulator-usbh-vbus {
 		regulator-min-microvolt = <5000000>;
 		regulator-name = "usbh_vbus";
 	};
+
+	sound-card {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,name = "colibri-imx8x";
+
+		dailink_master: simple-audio-card,codec {
+			clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+			sound-dai = <&sgtl5000_a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+		};
+	};
 };
 
 /* Colibri Analogue Inputs */
@@ -91,6 +115,21 @@ &i2c0 {
 	pinctrl-0 = <&pinctrl_i2c0>, <&pinctrl_sgtl5000_usb_clk>;
 	status = "okay";
 
+	sgtl5000_a: audio-codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0xa>;
+		#sound-dai-cells = <0>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12000000>, <12000000>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		VDDA-supply = <&reg_module_3v3_avdd>;
+		VDDD-supply = <&reg_module_vref_1v8>;
+		VDDIO-supply = <&reg_module_3v3>;
+	};
+
 	/* Touch controller */
 	touchscreen@2c {
 		compatible = "adi,ad7879-1";
@@ -373,7 +412,13 @@ &lsio_pwm2 {
 
 /* TODO on-module PCIe for Wi-Fi */
 
-/* TODO On-module i2s / Audio */
+/* On-module I2S */
+&sai0 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
 
 &usbotg1 {
 	adp-disable;
-- 
2.39.2


