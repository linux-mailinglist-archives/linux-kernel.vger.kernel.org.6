Return-Path: <linux-kernel+bounces-261978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B693BEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77794B23071
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF419882E;
	Thu, 25 Jul 2024 09:18:16 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B8197549;
	Thu, 25 Jul 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899095; cv=none; b=JfTLvG5Uw1vERo9lEd672Lgev1zoPAOydFE1YEXrlaC/NP27qFjMbQnUwCreTe1RHXHXakIRtGD0JnU6NalwnRpD6IGBo/UhHY/ynf+cgA/kQ/A8y9uztXCmwnYUthvVo1t2BCrARD3WQOB6WTxxqPuNLlCWSV3gcdfL2Pzu24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899095; c=relaxed/simple;
	bh=JZZiGgNqHGwl2hHhFknYl3fCucm3OuVpCG/yNlcpAIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YVe4u2f/SGlFatCzqEhq+N3Y4WUJZOB3hVb16F00b9nkHS4UrTKugwtnr5SY7InJRedDX0qRyX5/Ryb1LV5ZLYpzqHWjUKWBay65WrRF5WMryYWHouDVGV9J6EgPNtZzgRPecy7MT/w86YLau06TsM1fVfwkkNI0Lc6/D4Nzeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA7662023AA;
	Thu, 25 Jul 2024 11:18:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 741532023AB;
	Thu, 25 Jul 2024 11:18:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CFF741820F77;
	Thu, 25 Jul 2024 17:18:10 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH 2/3] arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
Date: Thu, 25 Jul 2024 16:59:07 +0800
Message-Id: <1721897948-6306-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add PDM micphone sound card support, configure the pinmux.

This sound card supports recording sound from PDM microphone
and convert the PDM format data to PCM data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 7ed75fb287df..7ad65469625f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -104,6 +104,20 @@ simple-audio-card,codec {
 			sound-dai = <&bt_sco_codec 1>;
 		};
 	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
 };
 
 &adc1 {
@@ -361,6 +375,17 @@ &lpuart5 {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_pdm>;
+	pinctrl-1 = <&pinctrl_pdm_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &mu1 {
 	status = "okay";
 };
@@ -564,6 +589,22 @@ MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__PDM_CLK			0x31e
+			MX93_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM00	0x31e
+			MX93_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM01	0x31e
+		>;
+	};
+
+	pinctrl_pdm_sleep: pdmgrpsleep {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__GPIO1_IO08			0x31e
+			MX93_PAD_PDM_BIT_STREAM0__GPIO1_IO09		0x31e
+			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
+		>;
+	};
+
 	pinctrl_sai1: sai1grp {
 		fsl,pins = <
 			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
-- 
2.34.1


