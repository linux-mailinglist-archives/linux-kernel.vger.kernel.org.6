Return-Path: <linux-kernel+bounces-312583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8796986F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB14C1F244B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440681B9827;
	Tue,  3 Sep 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="NEou14+1"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39D1A3058;
	Tue,  3 Sep 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354774; cv=none; b=IGtFcXfNFJv9mrLtzpFKXccJfZy8GwLJDiuMlBejKg7B82yLTS8+kdF+rNA+xXKENMk04l4zxlPruiE9E1sbCdOB3KuNYMuYFXK+OLiR6Iey4ybVwc/cxlN/RlfqahCWUpON0/IWUuzUj0WSUXo+IduJ0WsDaxKR4FZ47TDA3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354774; c=relaxed/simple;
	bh=9XvQ/6OqAiaBOwkGflHFGODOmFJ6/8mF088q1hFj1OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tt3OXkhy98kg4yMJH9Z5TkjMZ/790LDtDN48UnHwV1st0vK3b9EhvAeXYsawMxvoq5x6x0lj78Jhom6u90YRebrdHaRioRO0LCpNxvaNNPYcfg4uo34UY44jo4VOjtilt/nyttp+YfWuhZt4OdAkUVRxLGc8X9L/3aC6iXBRFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=NEou14+1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 8F69422A40;
	Tue,  3 Sep 2024 11:12:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725354765;
	bh=1uJRT9w6VzFZ43zEIq8MJXYGvGTADZRg7pm2/OMaHvY=; h=From:To:Subject;
	b=NEou14+1AVnFtYn8HyoB8jVDAYsnOLhQtcFTT3NAtLDCbHqmr2HzIKvyPIClinkYb
	 vscA/o5FsTfUh6hMnNIxfrLXhAyq3St9Shr434pnWeOig94WvbpK8VUKj6uTYsCJcU
	 vY36MlqTDp3UTKgguTdV7n6lFB4ySPP6GDPOoXn46ganP9bXROHQXb+8Iiv6lxZ6LM
	 J8NA2tVfXQH2iB/v7f4Mlz6deC+Z0kj4y0egz31BeRSj8wYy0WqhxA2RndvjwciUaV
	 68rQvEJK3tL/y95idlmjW2vRlTQyVtZ+S7E0qOYXfyFafI4vdSyAiDxEmoC8KcKev/
	 rArVtjJ67sKcg==
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
Subject: [PATCH v2 4/5] arm64: dts: imx8-apalis: Add nau8822 audio-codec to apalis eval v1.2
Date: Tue,  3 Sep 2024 11:12:30 +0200
Message-Id: <20240903091231.20035-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903091231.20035-1-francesco@dolcini.it>
References: <20240903091231.20035-1-francesco@dolcini.it>
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
v2: no changes
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


