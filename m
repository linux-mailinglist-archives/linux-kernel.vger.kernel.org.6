Return-Path: <linux-kernel+bounces-264985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0DE93EADD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E11C2180F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40C7FBD1;
	Mon, 29 Jul 2024 01:59:26 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1E77F1B;
	Mon, 29 Jul 2024 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218365; cv=none; b=eHFeZ2LXd4rTi6obtyqsgi65nWJm0HwmvkrGESRlOXGfnQ3Rhc8h2zkGOaDWawNUhBMFuPQG86GSeAg1gHnIVeKBgjQMcyp22+x6RNyqi4f9j8rakhX4UTPsVPVHzk6wwMDrW6cFxCkqv33n/MNZKc5qj8459VD8Z+zATzcuO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218365; c=relaxed/simple;
	bh=U7Np1fALoLvcYwudL78JmNiASbH1dH46YPvNYqBt96U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lm3ZKwPy9eEOjGPo/gEqnkDfJjv0MHh0Jkn1pgKuxuYdnb59ErQrM7G+6B+h9IO0j59vA1CsUVSVDITuyAupuVJQmF6/79xS0jMqtYnhKEKdQ94bSLvvmqNruZ3anfrHawT9q0WbnvzsKt7jhXemDv+dYO9eRVqJQuk+qKhJRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB6C5201261;
	Mon, 29 Jul 2024 03:59:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94315200C5D;
	Mon, 29 Jul 2024 03:59:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 01991181D0F9;
	Mon, 29 Jul 2024 09:59:14 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH v2 4/4] arm64: dts: imx93-11x11-evk: Add audio XCVR sound card
Date: Mon, 29 Jul 2024 09:39:59 +0800
Message-Id: <1722217199-10640-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
References: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add audio XCVR sound card, which supports SPDIF TX & RX only,
eARC RX, ARC RX are not supported.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 5e4c162e0355..0bb39eda39c1 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -118,6 +118,19 @@ cpu {
 			};
 		};
 	};
+
+	sound-xcvr {
+		compatible = "fsl,imx-audio-card";
+		model = "imx-audio-xcvr";
+
+		pri-dai-link {
+			link-name = "XCVR PCM";
+
+			cpu {
+				sound-dai = <&xcvr>;
+			};
+		};
+	};
 };
 
 &adc1 {
@@ -467,6 +480,18 @@ &wdog3 {
 	status = "okay";
 };
 
+&xcvr {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_spdif>;
+	pinctrl-1 = <&pinctrl_spdif_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_SPDIF>,
+			 <&clk IMX93_CLK_AUDIO_XCVR>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>,
+			 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+	assigned-clock-rates = <12288000>, <200000000>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -678,6 +703,20 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
 		>;
 	};
 
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__SPDIF_IN		0x31e
+			MX93_PAD_GPIO_IO23__SPDIF_OUT		0x31e
+		>;
+	};
+
+	pinctrl_spdif_sleep: spdifsleepgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO22__GPIO2_IO22		0x31e
+			MX93_PAD_GPIO_IO23__GPIO2_IO23		0x31e
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-- 
2.34.1


