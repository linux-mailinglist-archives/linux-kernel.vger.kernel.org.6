Return-Path: <linux-kernel+bounces-264982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AF93EAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40444281355
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CE79952;
	Mon, 29 Jul 2024 01:59:22 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BF2AD22;
	Mon, 29 Jul 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218362; cv=none; b=dz8WeAsvH/xRCaZXhQs166JAgQeto16KySPEwnbFrJc3pIDBlo4H2M9KHJJSQZhCdUEGvH/raUSk5p/6g2uAz4xg/Ch3sj4okyCd4J8NA4H0iZ/86plGxco4sTqqoGridTozWfY1EB376zoNE/S8A8VSJMgzMf6uKl8DORZJFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218362; c=relaxed/simple;
	bh=DJ1+0NjE2txB032P4LbwVyInM4QKCyeTVhltYyOLv/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G6Ay1YGWqXobiwE0ex2S3gukStbMYHuTi4HM+GjD4JbNkLtgixdsjwBrfuwD47YQG6xeFbFwazlSI9ZMgC8howMcjPZbT387Rm6PwQvbnvMrndUqEk6YbW2nez1p1JaqNwVFEMC1B9fd+8SV8WLdvbMQR67gJWS6HpzM8ZlbTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D68F1A0CFE;
	Mon, 29 Jul 2024 03:59:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 35B171A06E4;
	Mon, 29 Jul 2024 03:59:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9A77C18002A2;
	Mon, 29 Jul 2024 09:59:11 +0800 (+08)
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
Subject: [PATCH v2 1/4] arm64: dts: imx93: Add #sound-dai-cells property
Date: Mon, 29 Jul 2024 09:39:56 +0800
Message-Id: <1722217199-10640-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
References: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add #sound-dai-cells property for audio cpu dai modules
'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 4a3f42355cb8..e8fd008d6333 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -425,6 +425,7 @@ sai1: sai@443b0000 {
 				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 				dmas = <&edma1 22 0 FSL_EDMA_RX>, <&edma1 21 0 0>;
 				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
@@ -524,6 +525,7 @@ micfil: micfil@44520000 {
 				clock-names = "ipg_clk", "ipg_clk_app", "pll8k";
 				dmas = <&edma1 29 0 5>;
 				dma-names = "rx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
@@ -846,6 +848,7 @@ sai2: sai@42650000 {
 				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 				dmas = <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
 				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
@@ -859,6 +862,7 @@ sai3: sai@42660000 {
 				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
 				dmas = <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
 				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
@@ -878,6 +882,7 @@ xcvr: xcvr@42680000 {
 				clock-names = "ipg", "phy", "spba", "pll_ipg";
 				dmas = <&edma2 65 0 FSL_EDMA_RX>, <&edma2 66 0 0>;
 				dma-names = "rx", "tx";
+				#sound-dai-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.34.1


