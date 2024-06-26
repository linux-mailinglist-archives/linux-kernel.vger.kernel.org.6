Return-Path: <linux-kernel+bounces-231072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910C9185C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AFA283C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CA18C355;
	Wed, 26 Jun 2024 15:28:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6A1849EF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415680; cv=none; b=o/xuklwGU7QvrFBPTvULDJPvbj2+oA5yP9AxQdy1b5XePS6pJujCenxeG7fo4dtwp5bfnz2V0S3Et6rIELakjy3eI9jrvI/TRltOk7BQQU0SbIhW9a0Zk+T8tGExRUTBSGSJ2FHeymp2XXO7y9BcRjD0ASwatGR7shsGDrV3A5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415680; c=relaxed/simple;
	bh=Kv1NvV85mc8UzjseAZn/4ePFw0jrEK/F5NNIoImd5+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kc3rrCPMUPNzZfGP18fGyPGPZcaJ7l43wdQLx3S58IBAKYio/cTCnvrbHTF3PsCPEXQrK9FKzfKfN33kDGprXVyyRmuwhYG9NNw3A0CmqdD7h59Ucl3BtSlYF2T7M4YXFc0waDPclrf/r/WUF88yBmM+dHIsZbgqUkIJIsBXIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sMUYn-0007Ih-WB; Wed, 26 Jun 2024 17:27:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: "robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, Sascha Hauer" <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de,
	Lucas Stach <l.stach@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-evk: enable HDMI
Date: Wed, 26 Jun 2024 17:27:43 +0200
Message-Id: <20240626152744.4023647-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Enable the DT nodes for HDMI TX and PHY and add the pinctrl for the few
involved pins that are configurable.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 8be5b2a57f27..ef67eca9e348 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -353,6 +353,20 @@ &flexcan2 {
 	status = "disabled";/* can2 pin conflict with pdm */
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
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -549,6 +563,10 @@ &lcdif1 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &micfil {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
@@ -784,6 +802,15 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c3
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x19
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x19
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
-- 
2.39.2


