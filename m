Return-Path: <linux-kernel+bounces-302329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209195FCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6ED1F22425
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752DD19D090;
	Mon, 26 Aug 2024 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="sA7ykRwb"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0519AA56;
	Mon, 26 Aug 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710731; cv=none; b=GledC9QgxpwwF+AgjPIuLPU1HvU86NY3qcvxfg4dh7Yrki3NrYX2HAQb+KZh2o/qR/7JT9frOwzjhkFBlzvZl21Sfn98VXs34MpmCt2PXj+JLcuP3iAdII6fa3+oRYEXhXnORfchzQJDvykJIjyzvWTml/VW/OtsPunA3PaKAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710731; c=relaxed/simple;
	bh=EvfZTqBJL12t6mFgZb86TwqIKRWH7UJBX/legWWlWHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y07PsN7PfN5LA1Gj9kc0fFm3/3CF2w+lb7hs8HWIXpoeudFuPuW+rMIjcKwn3dwxpQzMgXvfOAKsTsfbeXjCUwKPGI4Y+GZwvNTNHseGo1wHZYdq7XNR+Z/LJurC+oYRLZdAjXASsMf/iaS7Qs6fG4q+x91rlajwjUiVXrRPN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=sA7ykRwb; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 30AE620AB8;
	Tue, 27 Aug 2024 00:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724710728;
	bh=w9FOpP0smQQETF357GYaHfHvRLm2uvOxgYwdEM8b1XY=; h=From:To:Subject;
	b=sA7ykRwbOOhXKwa9exJywSAVs3uRoX3XQnBBrOwqqbwLEbOB7JUTspkTKF8DA2xFI
	 SaRnyPa7Wz1d7zCIu/B81/y/c6KJeTjDqHY9ePLEHDMKpKTmnoMr8W3akPwpXe749D
	 4r34/WO4T+BH+SjeYcpRAath8qln7ZJFfdExWqGZ5FPPDVsq9fPcoswHvLBKl6u5vp
	 UweOOmSek6FQYNxbDl+3H0CloCLXnMQkJAUpytmD8YaK4+vCNmV+uTbquvFcK2+JY/
	 VccZUyS992HKdiHKNIR9k4AV2ksMWgtyzcXv9goiLBlzZFlpkqTUiaeyuz1nncbry8
	 /uhKn8rHOVj1A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 4/5] arm64: dts: imx8-apalis: Add nau8822 audio-codec to apalis eval v1.2
Date: Tue, 27 Aug 2024 00:18:42 +0200
Message-Id: <20240826221842.16010-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826221541.15669-1-francesco@dolcini.it>
References: <20240826221541.15669-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Add support for audio-codec NAU88C22 present on the Apalis Evaluation
Board v1.2 carrier board.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../dts/freescale/imx8-apalis-eval-v1.2.dtsi  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
index f5c6a0164f36..5862b24fb764 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
@@ -51,6 +51,40 @@ reg_can2: regulator-can2 {
 		regulator-name = "5V_SW_CAN2";
 		startup-delay-us = <10000>;
 	};
+
+	sound-carrier {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,name = "apalis-nau8822";
+		simple-audio-card,routing =
+			"Headphones", "LHP",
+			"Headphones", "RHP",
+			"Speaker", "LSPK",
+			"Speaker", "RSPK",
+			"Line Out", "AUXOUT1",
+			"Line Out", "AUXOUT2",
+			"LAUX", "Line In",
+			"RAUX", "Line In",
+			"LMICP", "Mic In",
+			"RMICP", "Mic In";
+		simple-audio-card,widgets =
+			"Headphones", "Headphones",
+			"Line Out", "Line Out",
+			"Speaker", "Speaker",
+			"Microphone", "Mic In",
+			"Line", "Line In";
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&nau8822_1a>;
+			system-clock-frequency = <12288000>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+		};
+	};
 };
 
 /* Apalis CAN1 */
@@ -69,6 +103,13 @@ &flexcan2 {
 &i2c2 {
 	status = "okay";
 
+	/* Audio Codec */
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+	};
+
 	/* Power/Current Measurement Sensor */
 	hwmon@40 {
 		compatible = "ti,ina219";
@@ -87,6 +128,18 @@ eeprom@57 {
 	};
 };
 
+&sai0 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 /* Apalis MMC1 */
 &usdhc2 {
 	pinctrl-0 = <&pinctrl_usdhc2_4bit>, <&pinctrl_mmc1_cd>;
@@ -105,6 +158,15 @@ &usdhc3 {
 };
 
 &iomuxc {
+	pinctrl-0 = <&pinctrl_cam1_gpios>,
+		    <&pinctrl_esai0_gpios>, <&pinctrl_fec2_gpios>,
+		    <&pinctrl_gpio3>, <&pinctrl_gpio4>, <&pinctrl_gpio_keys>,
+		    <&pinctrl_gpio_usbh_oc_n>, <&pinctrl_lpuart1ctrl>,
+		    <&pinctrl_lvds0_i2c0_gpio>, <&pinctrl_lvds1_i2c0_gpios>,
+		    <&pinctrl_mipi_dsi_0_1_en>, <&pinctrl_mipi_dsi1_gpios>,
+		    <&pinctrl_mlb_gpios>, <&pinctrl_qspi1a_gpios>,
+		    <&pinctrl_sata1_act>, <&pinctrl_sim0_gpios>,
+		    <&pinctrl_usdhc1_gpios>;
 
 	pinctrl_enable_3v3_mmc: enable3v3mmcgrp {
 		fsl,pins = <IMX8QM_USDHC1_DATA4_LSIO_GPIO5_IO19	0x00000021>; /* MXM3_148 */
@@ -121,4 +183,11 @@ pinctrl_enable_can1_power: enablecan1powergrp {
 	pinctrl_enable_can2_power: enablecan2powergrp {
 		fsl,pins = <IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21	0x00000021>; /* MXM3_156 */
 	};
+
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <IMX8QM_SAI1_RXC_AUD_SAI0_TXD	0xc600006c>, /* MXM3_196 */
+			   <IMX8QM_SPI0_CS1_AUD_SAI0_TXC	0xc600004c>, /* MXM3_200 */
+			   <IMX8QM_SAI1_RXFS_AUD_SAI0_RXD	0xc600004c>, /* MXM3_202 */
+			   <IMX8QM_SPI2_CS1_AUD_SAI0_TXFS	0xc600004c>; /* MXM3_204 */
+	};
 };
-- 
2.39.2


