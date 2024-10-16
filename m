Return-Path: <linux-kernel+bounces-367795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819E9A06E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B00B24862
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599F206E8F;
	Wed, 16 Oct 2024 10:20:11 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAB206071;
	Wed, 16 Oct 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074011; cv=none; b=MEAkAwZWqWn7bfuyjc9DQbRdOgkbmtksX1DqvRLMDjIyAY5oIGOqigaYtliCzfYYXavc9UVQLnwXQ88QT7TNZe2Rre4ggXTzTrmB9LLNlqSHbzRxCDs61ixEKEMyzzxfpy83fxJz593V2snEouH+4TPudM3FjznZqpJrpz5/Ov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074011; c=relaxed/simple;
	bh=pHeRz8l+69uRa213DsXwJ+2eugbFh8OguVFT2YNaeeg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=SE2z/2DTxg6aM64bYZnP1PEyC0seVBg/2nu42cDX45VtDaUSodeN55NfqwqnqCzL9bvQq7VusILABzG1VOSnh5eHTPc83z0bGZeI+0PSDuiB6Fl9Ng1fcGqyu3dTOntcW5n6cvdYEAgtdMsOYMJ8IhDrY1hM22w77EyribHwvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D9291A1DC7;
	Wed, 16 Oct 2024 12:20:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F3DE11A1012;
	Wed, 16 Oct 2024 12:20:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D4C7183DC02;
	Wed, 16 Oct 2024 18:20:06 +0800 (+08)
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
Subject: [PATCH 2/3] arm64: dts: imx8ulp-evk: Add bt-sco sound card support
Date: Wed, 16 Oct 2024 17:56:30 +0800
Message-Id: <1729072591-10439-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
References: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e937e5f8fa8b..7d6d332fa779 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -11,6 +11,11 @@ / {
 	model = "NXP i.MX8ULP EVK";
 	compatible = "fsl,imx8ulp-evk", "fsl,imx8ulp";
 
+	bt_sco_codec: bt-sco-codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = &lpuart5;
 	};
@@ -83,6 +88,25 @@ clock_ext_ts: clock-ext-ts {
 		clock-output-names = "ext_ts_clk";
 		#clock-cells = <0>;
 	};
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
+			sound-dai = <&sai5>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
 };
 
 &cm33 {
@@ -153,6 +177,16 @@ ptn5150_2: typec@3d {
 	};
 };
 
+&sai5 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai5>;
+	pinctrl-1 = <&pinctrl_sai5>;
+	assigned-clocks = <&cgc1 IMX8ULP_CLK_SAI5_SEL>;
+	assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SPLL3_PFD1_DIV1>;
+	fsl,dataline = <1 0x08 0x01>;
+	status = "okay";
+};
+
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1>;
@@ -282,6 +316,15 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF26__I2S5_TX_BCLK	0x43
+			MX8ULP_PAD_PTF27__I2S5_TX_FS	0x43
+			MX8ULP_PAD_PTF28__I2S5_TXD0	0x43
+			MX8ULP_PAD_PTF24__I2S5_RXD3	0x43
+		>;
+	};
+
 	pinctrl_typec1: typec1grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF3__PTF3           0x3
-- 
2.34.1


