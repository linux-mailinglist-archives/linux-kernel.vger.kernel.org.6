Return-Path: <linux-kernel+bounces-178544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C948C4F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566ED1F210BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0713D8BF;
	Tue, 14 May 2024 10:08:08 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91764CCC;
	Tue, 14 May 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681287; cv=none; b=Fa5RZAOkveMdiIMzRI4/whnjMQW+6i/AHwsXV3basJidtGy5hK66pbwVkJpkVnaPFFT87y7J8+yjG8m6vTJsHV84z7ZAk8/WflllJwaieNtgZ89kSiKpJej1J27xpdiYhhQCTh3tUzNelY3lTK31gOy+Z1nLh2uBTORWI9ewy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681287; c=relaxed/simple;
	bh=xjDz2Izt0vEcEs30HE8QpAJZW65ZIRs1wI1ol9QNFdU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=HNqH4sM5gDYYTzUqqhYAScmi0SwklvMLjWdess8tyO4wPyHxaE6i1dgTX4haH5jBpYgNkQzWhltS9/JsxQfpMNHCvx0UcZKi7AczJ68CWFVz2jO4V9QW6RMZSIzu63ys+RkrFXHSyNV0r1c9JXkMJUOZyrHeekuvE44EiiYxAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 38CCD1A1D45;
	Tue, 14 May 2024 11:53:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E53A51A1910;
	Tue, 14 May 2024 11:53:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 93FDF180222F;
	Tue, 14 May 2024 17:53:02 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 6/6] arm64: dts: imx8mp: Add reset-controller sub node for audio_blk_ctrl
Date: Tue, 14 May 2024 17:33:30 +0800
Message-Id: <1715679210-9588-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Audio Block Control contains clock distribution and gating
controls, as well as reset handling to several of the AUDIOMIX
peripherals. Especially the reset controls for Enhanced Audio
Return Channel (EARC) PHY and Controller

Add reset-controller sub-node for audio_blk_ctrl.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 459c4a54d30e..f94702ad4210 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1565,7 +1565,7 @@ sdma2: dma-controller@30e10000 {
 			};
 
 			audio_blk_ctrl: clock-controller@30e20000 {
-				compatible = "fsl,imx8mp-audio-blk-ctrl";
+				compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon", "simple-mfd";
 				reg = <0x30e20000 0x10000>;
 				#clock-cells = <1>;
 				clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
@@ -1582,6 +1582,11 @@ audio_blk_ctrl: clock-controller@30e20000 {
 				assigned-clocks = <&clk IMX8MP_AUDIO_PLL1>,
 						  <&clk IMX8MP_AUDIO_PLL2>;
 				assigned-clock-rates = <393216000>, <361267200>;
+
+				audio_blk_ctrl_rst: reset-controller {
+					compatible = "fsl,imx8mp-audiomix-reset";
+					#reset-cells = <1>;
+				};
 			};
 		};
 
-- 
2.34.1


