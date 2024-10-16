Return-Path: <linux-kernel+bounces-367670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850089A0527
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BAF1F227F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD6204F9A;
	Wed, 16 Oct 2024 09:13:06 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6C205E11;
	Wed, 16 Oct 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069985; cv=none; b=E6Doh60JcwkIh73DvCgNznoifyiPcG3Ksi3kG5Qe5MX1xEoKEBJgERhF469svCBXfhHx4zylo39X0Pkvrl/9UAWqZtt0xa/zLuPJfvw0BlCiLfa/tuoc5HpwZ7tD0GaBU6QwUO82u/iblQnPRA0mQH47qbeuzPenxwSbs28Pd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069985; c=relaxed/simple;
	bh=Q7YiFkq6G86CYppOK/tGA2/5+gyUMdTXdv0mAC/q77Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=bVwuB4dZ+/q7FRkpmkC582gCIoMu7/k1RLLPteRNGN1D5iBGD2/gqm8G3NG1HtxyOdBIDTZDLalU4iX+D9dz+O5tyelprIHBOXX+icvTD5yc08lItzq2p+3XCduAWL5u9cIAgPGDHG5+nWG2h25VkEjxKn84pMNRVKYjbIaDUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E68231A199B;
	Wed, 16 Oct 2024 11:12:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE4DF1A18D9;
	Wed, 16 Oct 2024 11:12:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 187131939E62;
	Wed, 16 Oct 2024 17:12:55 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 3/3] arm64: dts: imx93-9x9-qsb: Add PDM microphone sound card support
Date: Wed, 16 Oct 2024 16:49:17 +0800
Message-Id: <1729068557-10073-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1729068557-10073-1-git-send-email-shengjiu.wang@nxp.com>
References: <1729068557-10073-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add PDM micphone sound card support, configure the pinmux.

This sound card supports recording sound from PDM
microphone and convert the PDM format data to PCM data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index eb872014c11d..10f931e334e2 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -122,6 +122,20 @@ simple-audio-card,codec {
 		};
 	};
 
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
+
 	sound-wm8962 {
 		compatible = "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
@@ -271,6 +285,12 @@ exp-sel-hog {
 			gpios = <22 GPIO_ACTIVE_HIGH>;
 			output-low;
 		};
+
+		mic-can-sel-hog {
+			gpio-hog;
+			gpios = <17 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
 	};
 
 	pmic@25 {
@@ -355,6 +375,15 @@ &lpuart1 { /* console */
 	status = "okay";
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX93_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &mu1 {
 	status = "okay";
 };
@@ -468,6 +497,14 @@ MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
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
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
-- 
2.34.1


