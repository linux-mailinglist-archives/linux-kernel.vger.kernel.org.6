Return-Path: <linux-kernel+bounces-325840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FD975EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4877E1C21B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A0126C13;
	Thu, 12 Sep 2024 02:21:38 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB278C60;
	Thu, 12 Sep 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107697; cv=none; b=PpSVaHKtUnN2LAUzKYLUXwxUZ8U+XBhyj1DCqUAFRzjwTOc67IeUMSShwVrrB7sil+dBTtHzu15L3BCPlHGa/3htcnbduHwixodSgKXXdrWoFprpiGyb1a4kcjYIOjYbkH1pG1QxTXB/BRwohUEvqNhUCObSUl6KDaoSc661Ack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107697; c=relaxed/simple;
	bh=KDmxcKwGwGQ3nj3fgrmRiyM3MVNRhWhZIYTIX7h8S+Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=OVe+xOOBzxJyVzmK6djLV5hYWU4MX/HAmAvWGnkfXt2NMN8xbjvOzmKdiUlHTiZxN0VWwvJwNYVe3CG90B2EZNMNcewkJ30nLTgmcHCwAhciuh+sg+k/bhR6N+wFTlf6DNXSAt2r3PgNcPK007yqgMf8O8Im8sgPajN6eQJywtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D97A1A065A;
	Thu, 12 Sep 2024 04:21:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D6B0D1A1B14;
	Thu, 12 Sep 2024 04:21:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 44C9D1840303;
	Thu, 12 Sep 2024 10:21:27 +0800 (+08)
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
Subject: [PATCH v2 2/3] arm64: dts: imx93-9x9-qsb: add bt-sco sound card support
Date: Thu, 12 Sep 2024 09:59:40 +0800
Message-Id: <1726106381-1138-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add bt-sco sound card, which is used by BT HFP case.
It supports wb profile as default

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index 10f3366b8253..f44300225656 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -12,6 +12,11 @@ / {
 	model = "NXP i.MX93 9x9 Quick Start Board";
 	compatible = "fsl,imx93-9x9-qsb", "fsl,imx93";
 
+	bt_sco_codec: bt-sco-codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
@@ -98,6 +103,25 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		off-on-delay-us = <12000>;
 	};
 
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
 	sound-wm8962 {
 		compatible = "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
@@ -339,6 +363,16 @@ &mu2 {
 	status = "okay";
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clk IMX93_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -507,6 +541,15 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
+			MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
+			MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00		0x31e
+			MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00		0x31e
+		>;
+	};
+
 	pinctrl_sai3: sai3grp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO12__SAI3_RX_SYNC		0x31e
-- 
2.34.1


