Return-Path: <linux-kernel+bounces-302297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A295FC54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8636F1F228D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3AB19E825;
	Mon, 26 Aug 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TGlLk8Vg"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961319D8AA;
	Mon, 26 Aug 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709586; cv=none; b=FHxqyivJgCdySi9u5DRIIWlxhQHhRejtw3uMDDwNo1UzJhN1a01Qs5xBuvEdE4cN2O/U6ijk/89X22xBfHmY2lwuksKlnGfeGFaLSoajoK010WkGx5UzT58bsW5i+otAvf9Kn1m9RNXR8XVSiGMUWUoSdVowL7m+knAGFZKo16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709586; c=relaxed/simple;
	bh=GDszkwtsOty2wp4CxZ2pjndItFDDIbFDEaqrdeW6Y9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ob7Dq9dXuJ2B4tAYOXANdFKxkSo3zum4MClCF6rfEVkw4B3dDiYAnIjoBvH93z0u0A4dN4y/cM9ppNxrYtisZhSFX6TDhUwp6MPfTw/V4wAMg+wT4dd86/s8urx6vPDUej+NOX6B/ICqEizYQi6uf0jJYv00FnfU8bYJa43OMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TGlLk8Vg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E4C022506E;
	Mon, 26 Aug 2024 23:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709580;
	bh=3BT5+sdVfi/hhHm41S0oCipG1TuIyy/krE/KMNZy3nQ=; h=From:To:Subject;
	b=TGlLk8VgGaUQlvmMGksUcTvyqmdSNTz1KAPPhqm4Pb0pRl7/8ShAi2BfTSwibzu7D
	 ruGUn1CV7a/FUXx+Ym/VuCvK/M14d46nKHRU/x/aIM2OUqOKOgyp3CRzwfEyp1G3kX
	 kkXxUO2CA4lhi33nw5URTvliqLEkqZ3UNCr44ql+WpARwRg9r/348f/rymmJEhZw3k
	 gxOSDzj+j9CsiVRv4GhEJo+poUju1e03V58JGd7+Ka5y42Uaa0fKKRy+LMZX6Sgx/b
	 5Iv+R4pb2Jd4o/I4YVMNV0xSr/e0qbLNyTfeErpc1dc2z25bZpxDB+szf6KS+83Sgl
	 p5m8szGO0Li3g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/10] arm64: dts: colibri-imx8x: Add USB3803 HUB
Date: Mon, 26 Aug 2024 23:59:18 +0200
Message-Id: <20240826215922.13225-7-francesco@dolcini.it>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add USB3803 HUB, this is required for Bluetooth and USB
functionalities.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index f6afce016ff2..7c728208f385 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -113,6 +113,26 @@ &i2c0 {
 	pinctrl-0 = <&pinctrl_i2c0>, <&pinctrl_sgtl5000_usb_clk>;
 	status = "okay";
 
+	/* USB HUB USB3803 */
+	usb-hub@8 {
+		compatible = "smsc,usb3803";
+		reg = <0x8>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12000000>, <12000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb3503a>;
+		bypass-gpios = <&gpio_expander_43 5 GPIO_ACTIVE_LOW>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "refclk";
+		disabled-ports = <2>;
+		initial-mode = <1>;
+		intn-gpios = <&lsio_gpio3 4 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio_expander_43 4 GPIO_ACTIVE_LOW>;
+	};
+
 	/* Touch controller */
 	touchscreen@2c {
 		compatible = "adi,ad7879-1";
-- 
2.39.2


