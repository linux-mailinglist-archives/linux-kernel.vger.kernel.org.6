Return-Path: <linux-kernel+bounces-322574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4B972B01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA9B1F252A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BA186E2A;
	Tue, 10 Sep 2024 07:41:19 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38754184545;
	Tue, 10 Sep 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954078; cv=none; b=QBW7KP2JzdhPs20wInaK/IX8x5Bewun//X6t1hd+zy1j0IQ/5s51l6/edHXB0tiF3FvwGhBYyTX4PjYfjL1boNh2f3rB+Y55zlJfQmL3ym79v1Enh9sR1n8naQkOWGuGvYyLNI0HABPhhEGLDewJMiNf2l0fLJU/tkhOPyNXzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954078; c=relaxed/simple;
	bh=8uO+euh4dZ2JsdT0ibbqmLE0P4Hx3ZTvP4vIhWtm14Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=WYtLeeghPuzCXgHOkL0OyB7BjC3oBLlIpIEdwvsg8cCP1GISwwQf3XUgpOuu1k9pZ6wGe8f+PLxiDa3WybGiLU56fBXKbL5AH3Eds/T0NAPd5JlDfWb8hXxHMjIhg41lOo7/bK2FMCe+t08Am081DqMukQouWhVVmLzFen1GHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A90F200633;
	Tue, 10 Sep 2024 09:41:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 202E7200649;
	Tue, 10 Sep 2024 09:41:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7F089180031E;
	Tue, 10 Sep 2024 15:41:08 +0800 (+08)
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
Subject: [PATCH 3/3] arm64: dts: imx93-9x9-qsb: Add PDM microphone sound card support
Date: Tue, 10 Sep 2024 15:19:32 +0800
Message-Id: <1725952772-30357-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1725952772-30357-1-git-send-email-shengjiu.wang@nxp.com>
References: <1725952772-30357-1-git-send-email-shengjiu.wang@nxp.com>
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
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index d213a5343803..1340f5462d11 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -122,6 +122,18 @@ simple-audio-card,codec {
 		};
 	};
 
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
+
 	sound-wm8962 {
 		compatible = "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
@@ -266,6 +278,12 @@ pcal6524: gpio@22 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pcal6524>;
 
+		mic-can-sel-hog {
+			gpio-hog;
+			gpios = <17 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+
 		exp-sel-hog {
 			gpio-hog;
 			gpios = <22 GPIO_ACTIVE_HIGH>;
@@ -355,6 +373,15 @@ &lpuart1 { /* console */
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
@@ -535,6 +562,14 @@ MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
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
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
-- 
2.34.1


