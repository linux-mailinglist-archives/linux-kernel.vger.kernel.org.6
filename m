Return-Path: <linux-kernel+bounces-302327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C395FC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DD01F223C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B019DFBB;
	Mon, 26 Aug 2024 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bA198KmG"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097119D09D;
	Mon, 26 Aug 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710552; cv=none; b=ezBK7vCsU7VwIWZWQqBJ+3GYYjkU7SsApJV68TTgfwh4q74x/nQ9It5d1FlkRLyYCWZh8dOzuqHGutcaKWJ4d6ceRs3HMWZCoeBY6eaay80+B8UmBj1dZEX7HU/MwMpWhYKiLxDSz+EIaoSHfDLAwa5c8mNq8YDslZkwPmJFj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710552; c=relaxed/simple;
	bh=qyK5NkFVXK1BEFnRomHaUtbr+6Ra6z8Iia55bU63S2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSAzQdRd21Lh3tWl6BYGwy7EQ8zYSZlg/DhULm8p7nY5pySj4aYjj+FF78GJ8vA+TTrzAxDQvBGwiYp5fI4EL+1lypJlp6HDHxsANx8Ey703bhD9iPPb8zjNQdgRWUq56NekLciAj51guRUk999U8CSmPC712Pv2/IRyp9tp7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bA198KmG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 22DAA1FB32;
	Tue, 27 Aug 2024 00:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724710548;
	bh=DkVycQN7gL9DLGIpvZam7zsKP66vaTuFkt2lFhh/8bc=; h=From:To:Subject;
	b=bA198KmGGdM96QJtGMLAbOGilFOcfgeKJJs/ueFbTsuCgLzvabl5h83Ra+wj3lnAI
	 SA3MLCBWwAneeS1Sp3dYLbt42TJikvtoFpJaggDacfqLvnjs50Vcfywe3FakDhCCMM
	 /aiehRlNgf8CZpeIOG5a7ofheNXWGN65GD6YN9DgaPbdjIWK11kB4RdGVPc/MtoaTA
	 1T1oeiDwNUw6wxfVv691VtnI1FJCxB0uIX/gMfkcE1Rx9D5NhK9fLtaMVL78L8mpjp
	 BUQGdagGbiaqkTg6lvEB29cx5DLR6y3p5Rxw5ZbxbphGCvODCWV9PYzFrKd9IfUiSR
	 PN9mTieWNyyZA==
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
Subject: [PATCH v1 3/5] arm64: dts: imx8-apalis: Add audio support
Date: Tue, 27 Aug 2024 00:15:39 +0200
Message-Id: <20240826221541.15669-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826221541.15669-1-francesco@dolcini.it>
References: <20240826221541.15669-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add audio support to Apalis-iMX8QM and its carrier boards. These includes:
* On SOM i2s sound card
* On SOM spdif sound card
* Enabling Audiomix and Asynchronous Sample Rate Converter

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  | 26 ++++--
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 26 ++++--
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 26 ++++--
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 80 +++++++++++++++++--
 4 files changed, 136 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index deecb96a1596..5f24356ad4e2 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -22,9 +22,13 @@ &adc1 {
 	status = "okay";
 };
 
-/* TODO: Audio Mixer */
+&amix {
+	status = "okay";
+};
 
-/* TODO: Asynchronous Sample Rate Converter (ASRC) */
+&asrc0 {
+	status = "okay";
+};
 
 /* TODO: Display Controller */
 
@@ -104,13 +108,25 @@ &lsio_pwm3 {
 
 /* TODO: Apalis BKL1_PWM */
 
-/* TODO: Apalis DAP1 */
+/* Apalis DAP1 */
+&sai1 {
+	status = "okay";
+};
 
-/* TODO: Apalis Analogue Audio */
+&sai5 {
+	status = "okay";
+};
+
+&sai5_lpcg {
+	status = "okay";
+};
 
 /* TODO: Apalis SATA1 */
 
-/* TODO: Apalis SPDIF1 */
+/* Apalis SPDIF1 */
+&spdif0 {
+	status = "okay";
+};
 
 /* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
index 5438923a905c..4ec2227750f4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -62,9 +62,13 @@ &adc1 {
 	status = "okay";
 };
 
-/* TODO: Audio Mixer */
+&amix {
+	status = "okay";
+};
 
-/* TODO: Asynchronous Sample Rate Converter (ASRC) */
+&asrc0 {
+	status = "okay";
+};
 
 /* TODO: Display Controller */
 
@@ -191,13 +195,25 @@ &lsio_pwm3 {
 
 /* TODO: Apalis BKL1_PWM */
 
-/* TODO: Apalis DAP1 */
+/* Apalis DAP1 */
+&sai1 {
+	status = "okay";
+};
 
-/* TODO: Apalis Analogue Audio */
+&sai5 {
+	status = "okay";
+};
+
+&sai5_lpcg {
+	status = "okay";
+};
 
 /* TODO: Apalis SATA1 */
 
-/* TODO: Apalis SPDIF1 */
+/* Apalis SPDIF1 */
+&spdif0 {
+	status = "okay";
+};
 
 /* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
index f6654fdcb147..606d9328ac99 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -94,9 +94,13 @@ &adc1 {
 	status = "okay";
 };
 
-/* TODO: Audio Mixer */
+&amix {
+	status = "okay";
+};
 
-/* TODO: Asynchronous Sample Rate Converter (ASRC) */
+&asrc0 {
+	status = "okay";
+};
 
 /* TODO: Display Controller */
 
@@ -240,13 +244,25 @@ &lsio_pwm3 {
 
 /* TODO: Apalis BKL1_PWM */
 
-/* TODO: Apalis DAP1 */
+/* Apalis DAP1 */
+&sai1 {
+	status = "okay";
+};
 
-/* TODO: Apalis Analogue Audio */
+&sai5 {
+	status = "okay";
+};
+
+&sai5_lpcg {
+	status = "okay";
+};
 
 /* TODO: Apalis SATA1 */
 
-/* TODO: Apalis SPDIF1 */
+/* Apalis SPDIF1 */
+&spdif0 {
+	status = "okay";
+};
 
 /* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index e53683e49e03..0f334c268a99 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -126,6 +126,13 @@ reg_usb_phy: regulator-usb-hsic1 {
 		regulator-name = "usb-phy-dummy";
 	};
 
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "+V1.8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -198,11 +205,32 @@ linux,cma {
 		};
 	};
 
-	/* TODO: Apalis Analogue Audio */
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,name = "apalis-imx8qm";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+	};
 
 	/* TODO: HDMI Audio */
 
-	/* TODO: Apalis SPDIF1 */
+	/* Apalis SPDIF1 */
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif0>;
+		spdif-in;
+		spdif-out;
+	};
 
 	touchscreen: touchscreen {
 		compatible = "toradex,vf50-touchscreen";
@@ -227,6 +255,10 @@ touchscreen: touchscreen {
 
 };
 
+&asrc0 {
+	fsl,asrc-rate  = <48000>;
+};
+
 &adc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc0>;
@@ -334,7 +366,23 @@ &i2c1 {
 	clock-frequency = <100000>;
 	status = "okay";
 
-	/* TODO: Audio Codec */
+	/* On Module Audio Codec */
+	sgtl5000: audio-codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sgtl5000>;
+		#sound-dai-cells = <0>;
+		VDDA-supply = <&reg_module_3v3_avdd>;
+		VDDD-supply = <&reg_vref_1v8>;
+		VDDIO-supply = <&reg_module_3v3>;
+	};
 
 	/* USB3503A */
 	usb-hub@8 {
@@ -729,13 +777,31 @@ &mu2_m0 {
 
 /* TODO: Apalis BKL1_PWM */
 
-/* TODO: Apalis DAP1 */
-
-/* TODO: Analogue Audio */
+/* Apalis DAP1 */
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
 
 /* TODO: Apalis SATA1 */
 
-/* TODO: Apalis SPDIF1 */
+/* Apalis SPDIF1 */
+&spdif0 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif0>;
+	status = "okay";
+};
 
 /* TODO: Thermal Zones */
 
-- 
2.39.2


