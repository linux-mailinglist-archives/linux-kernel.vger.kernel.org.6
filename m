Return-Path: <linux-kernel+bounces-211338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7D905041
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF21B2106D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F5F16EBE7;
	Wed, 12 Jun 2024 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="baylP864"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AE16E893;
	Wed, 12 Jun 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187454; cv=none; b=MFE5m8oJMuNbSY4UuqtrlOqP2sWM2us6vsFKxPdl4u2e4U0pYtBsLiwBB/gBILe2+r3AFZx5C2nIXFXCrTfyySVN13ALIyFqLHFY33sNa98CG0LxB1/gNM869w5Dn7/AojuvrDfUpD6kpV7lO9Rw9mxPrK+YvkqgwW4Pzv0KNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187454; c=relaxed/simple;
	bh=uEVXytN0su4uO31CCDzPwmBSkgNmoh/AYGceJbx2wJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gTVqLW3LFd0mOVEbVmwLU8sf4oLUGq6h2cZkyIAgknyEzHKmqmx14XTXgIstD063/qM2gqIubqd9MffW0VAaHpqbRNaflAvxmLVO4bddjngMxthxYjwfdETIvDVz+1vPV6p4/BWALO9OI0nmX/kJ+Io2gADcGGsywn18bUCo0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=baylP864; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57D021BF203;
	Wed, 12 Jun 2024 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718187450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CfBySjCLhdPg25qelMt2+tvslyXTXvLTckrLcGn3QEc=;
	b=baylP864iq/ua2yedrZZPQeSvLYCrueoxX0C0+8cwhMaJ5bbdxW2zob4gCWTUIeOko2y7h
	jy8zAKnY0McE6ftj+OdlOAWvUq5duntD/Z118FHUixiOI+7sannftpGC7nRkYuXNlIT1tD
	DKlycYfJ3M4p6f45rC9qHonot5c7nL/IYpyjdsjqMxAsCCHgHQ7sIFts5YjBhS29/ZT8l3
	qatd9SrA2oFAwNvY2B0XtdTlHf4BAwLRL8FNwOpeStplSiCKm+5Z4TEL4IW3Vr25MtoYDo
	YEaeF8nBxsLBvVbHHdh20V3GKRz+ClaC+yXyOPyTEDX3bEcdSZBSoqe2NY9bgw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Jun 2024 12:17:27 +0200
Subject: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add HDMI output
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-imx8mp-msc-sm2s-hdmi-v1-1-6c808df5205d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALZ1aWYC/x3MPQqAMAxA4atIZgM1/iBeRRxsGzVDVBoQQby7x
 fEb3nvAOAkbDMUDiS8xOfaMqiwgbPO+MkrMBnLUuK4iFL17PVEtoCkZblEFm7g43/vW1xQgp2f
 iRe5/O07v+wFF1HH2ZgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Adam Ford <aford173@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Enable the HDMI output of the MSC SM2-MB-EP1 carrier board based the
SM2S-IMX8PLUS SMARC module.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
index da4b1807c275..83194ea7cb81 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
@@ -46,6 +46,24 @@ codec_dai: simple-audio-card,codec {
 	};
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
 &i2c1 {
 	sgtl5000: audio-codec@a {
 		compatible = "fsl,sgtl5000";
@@ -92,6 +110,15 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_smarc_gpio>;
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x10
+		>;
+	};
+
 	pinctrl_sai2: sai2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC   0xd6

---
base-commit: 2ef5971ff345d3c000873725db555085e0131961
change-id: 20240612-imx8mp-msc-sm2s-hdmi-4df0b8b5b32c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


