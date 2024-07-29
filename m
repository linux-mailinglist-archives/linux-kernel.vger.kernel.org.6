Return-Path: <linux-kernel+bounces-264983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F993EAD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D901F21E76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A4A7C6EB;
	Mon, 29 Jul 2024 01:59:23 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44D78283;
	Mon, 29 Jul 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218363; cv=none; b=g75+oaCEF5TvvmYXZc7BAtbhHrtQe2w1Hy1QwG8qX4eHkcWju846oj1gyLbZJv/FwahgRpdviIl/MCMva+mGJm01pbSpQ6E/RRxbTSgIlivUXuosHfpFF3MgUTDWrjnWAQr+AyxeQZPpu5ZUEckSh2oAVqx7PXYoq9Ww+0e/ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218363; c=relaxed/simple;
	bh=RY6dQrLhBnat8376gBmKhLU6cahF5wDO87eQQG+/kLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MQmKT6ZQTOx+2wQCUQOstFn7yiHV6vd64ZNtUsE57CnF3AG0SD4WzGPXzEE5LuuQzvtGfQXGhY/EVZ6vqPZ5ZzywSaJc0g+EoyUf5DAhGEw9Q9YpULarseKFvUGrJNQMxhowZ4qB/O7EGS8MoNma+mlalLF5n8Re/4Di7nCaxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 913F0200134;
	Mon, 29 Jul 2024 03:59:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5954A201262;
	Mon, 29 Jul 2024 03:59:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B9F62181D0F9;
	Mon, 29 Jul 2024 09:59:12 +0800 (+08)
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
Subject: [PATCH v2 2/4] arm64: dts: imx93-11x11-evk: add bt-sco sound card support
Date: Mon, 29 Jul 2024 09:39:57 +0800
Message-Id: <1722217199-10640-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
References: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
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
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index a15987f49e8d..5ebf25726c33 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -80,6 +80,30 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		off-on-delay-us = <12000>;
 		enable-active-high;
 	};
+
+	bt_sco_codec: bt-sco-codec {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
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
 };
 
 &adc1 {
@@ -345,6 +369,17 @@ &mu2 {
 	status = "okay";
 };
 
+&sai1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai1>;
+	pinctrl-1 = <&pinctrl_sai1_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -528,6 +563,24 @@ MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
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
+	pinctrl_sai1_sleep: sai1sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
+			MX93_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
+			MX93_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
+			MX93_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
+		>;
+	};
+
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-- 
2.34.1


