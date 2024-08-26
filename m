Return-Path: <linux-kernel+bounces-302292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1893595FC34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFA0282598
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4819D092;
	Mon, 26 Aug 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="K7VcqpHP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C619B5AA;
	Mon, 26 Aug 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709582; cv=none; b=OC7OT3pXjA0fflqtU9WqsFdnKg+emEAUcqhqsVRz3k2D58D5FWY3rs5vNgqLHK35YQZCDFt/LPLjBOf2vdTTGLqYjKhdCIhL64U+Ld99IJ4zcXpeE/787svIUVhGxoTWoXCXaixe3GYFZ0lKYiES5GtegGYkm9WHNlfm4mNqzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709582; c=relaxed/simple;
	bh=XR3+/XvFK/lGAg4QJBVMznE/rdaGCmVxL+TEQ0JcQLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh3LWNcfBotqrgwYWDDt4ZZuNpUYZHmbIoR5doiKRshnJXiEpudhDgY7E0z4b6q1BQTrXn7DXB+1OgHi5dkk1pE2dCu5pd8FPEWK+WjBV9fnKaJ2K5j8a8QFHwutU/rQ18gfaDEjrmaDzp66lWyYHqy+chNIIvYQqI5MbmX4woA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=K7VcqpHP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id ACE3B25068;
	Mon, 26 Aug 2024 23:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709579;
	bh=a6VuMP+XHJVX+Qc/uL/hJS3JhoWqTXPpjFhR6W1QxPs=; h=From:To:Subject;
	b=K7VcqpHPIqJruVrv6v7eieZpRF3ZrjR1nsAtKxMiu/xickc5VR7HcAnPkV0K6JBrS
	 kqdWE+grgP7WVESTMFTRJscStRTlM3WXWuM4zFDa+Wg3dUnRWgnJivL5fXChhdkoCa
	 2pA0TsOG0F5qG4HI+NFMNS/AYYygEC2QxilT++5D/xmJZCG7Yek1nU9eLD3llaJHP3
	 pJrUT2xIMLpu+BA26inqcy0wrzSBkAVRgZ7OJX9DonJoD+5CO2rla0PYKN3DiP90xe
	 V7g9Mm1AdU7iJQopqq8ed+g3AWvPiGHRbmG5m4DwEokFb/n0UmxRtLcj+RoUyU9TrI
	 IUkf82GPyyzBw==
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
Subject: [PATCH v1 04/10] arm64: dts: colibri-imx8x: Add sound card
Date: Mon, 26 Aug 2024 23:59:16 +0200
Message-Id: <20240826215922.13225-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826215922.13225-1-francesco@dolcini.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
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
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index aa9c45c290b9..1d22002103c4 100644
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
@@ -109,6 +133,21 @@ touchscreen@2c {
 		status = "disabled";
 	};
 
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
 	gpio_expander_43: gpio@43 {
 		compatible = "fcs,fxl6408";
 		reg = <0x43>;
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


