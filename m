Return-Path: <linux-kernel+bounces-174165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390B8C0B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E91F2100B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332C149C5A;
	Thu,  9 May 2024 05:34:23 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29315149C4F;
	Thu,  9 May 2024 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232862; cv=none; b=rdkEhHOCwsbQLKQXJA657T9ZJ/Z8hNdV0sD1+cU48m6n7Qc1+MjIua/pep9OmEsQq7V6zCmFbPaBr+pNjBvvGI6QfMb3tN5NYj8/t/6qvoWaqqiXK4F0ZYeOT3R/X6KFIrLixo2KMa8iH/JEHIfSzeshpSXE3UPZrwETV3pBTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232862; c=relaxed/simple;
	bh=m2MfUlMl9KxyWVYEaAkVFeSM4ZuXjRKHohyzQ3AsLrE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=i4MEZXONSpIciERRspkTJc7qtYfeGgFfOrkXbWlbddqBDeUjiZ8Pncb/VZ/GHNyJUKKF3jsGhnu5yhGAp8zBd3FHszFE59Y5dhqwT+eGaGHBFMIWxKOewjwl+hvlOTXddxUG9AqIwysa3JXfuX4NGiB4MRpG59JEblfMWkySF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68E76201EF4;
	Thu,  9 May 2024 07:34:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EBD6200B37;
	Thu,  9 May 2024 07:34:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D140180222F;
	Thu,  9 May 2024 13:34:17 +0800 (+08)
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
Subject: [PATCH 2/2] arm64: dts: imx8mp-evk: add bt-sco sound card support
Date: Thu,  9 May 2024 13:14:58 +0800
Message-Id: <1715231698-451-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715231698-451-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715231698-451-1-git-send-email-shengjiu.wang@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 8be5b2a57f27..b2225cb710b6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -114,6 +114,11 @@ reg_vext_3v3: regulator-vext-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	audio_codec_bt_sco: audio-codec-bt-sco {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8960-audio";
@@ -145,6 +150,25 @@ simple-audio-card,codec {
 
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
+			sound-dai = <&sai2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&audio_codec_bt_sco 1>;
+		};
+	};
+
 	sound-hdmi {
 		compatible = "fsl,imx-audio-hdmi";
 		model = "audio-hdmi";
@@ -608,6 +632,17 @@ &pwm4 {
 	status = "okay";
 };
 
+&sai2 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -880,6 +915,15 @@ MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
 		>;
 	};
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00	0xd6
+		>;
+	};
+
 	pinctrl_sai3: sai3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
-- 
2.34.1


