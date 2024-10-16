Return-Path: <linux-kernel+bounces-367796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DFE9A06EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B340C2850B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FD207200;
	Wed, 16 Oct 2024 10:20:12 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EC206E72;
	Wed, 16 Oct 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074012; cv=none; b=D1mATugZ7/FjUwoFHRxYEV1VBtaFXbmVpwBcU9dhu7hD8jj6hzl33eFE29Tw7VqT1zgJyEw/SKuZ69lnO/FmseyU3XGxDlEEaVikuVyLzrsZ3QT+pCAUscLnhn6D6n7du7u2Rg66xVj9fuOUDpkq7cNCeL6fvNW05MRmW57r8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074012; c=relaxed/simple;
	bh=Te3L1RQ5DewJWd1Z3e2P5wkvR0V2l67blCbbLb58RjQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=ebjjA9/hk5X0jRdpCkq/qkldOVVfTOaIgS8FvKq9m6g0YqZaNIeNA2soTyT91U8KHL1uAdZA54FkSerqM2+OlrRaVSn3c98qGGOm4PDLsRgX44oqrDOZW3t8I3CcPjtgujdUp/LV6b/iHKErHAJWhlAdbFwsOe8UiRqEBo88Rbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56BCB201F6C;
	Wed, 16 Oct 2024 12:20:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24D09201F78;
	Wed, 16 Oct 2024 12:20:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7939F183DC03;
	Wed, 16 Oct 2024 18:20:07 +0800 (+08)
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
Subject: [PATCH 3/3] arm64: dts: imx8ulp-evk: Add spdif sound card support
Date: Wed, 16 Oct 2024 17:56:31 +0800
Message-Id: <1729072591-10439-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
References: <1729072591-10439-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add spdif sound card support, configure the pinmux.

This sound card supports only playback sound
through HDMI interface.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 7d6d332fa779..290a49bea2f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -107,6 +107,18 @@ simple-audio-card,codec {
 			sound-dai = <&bt_sco_codec 1>;
 		};
 	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		audio-cpu = <&spdif>;
+		audio-codec = <&spdif_out>;
+	};
+
+	spdif_out: spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
 };
 
 &cm33 {
@@ -187,6 +199,15 @@ &sai5 {
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_spdif>;
+	pinctrl-1 = <&pinctrl_spdif>;
+	assigned-clocks = <&cgc2 IMX8ULP_CLK_SPDIF_SEL>;
+	assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SPLL3_PFD1_DIV1>;
+	status = "okay";
+};
+
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1>;
@@ -325,6 +346,12 @@ MX8ULP_PAD_PTF24__I2S5_RXD3	0x43
 		>;
 	};
 
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF25__SPDIF_OUT1    0x43
+		>;
+	};
+
 	pinctrl_typec1: typec1grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF3__PTF3           0x3
-- 
2.34.1


