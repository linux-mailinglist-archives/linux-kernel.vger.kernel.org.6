Return-Path: <linux-kernel+bounces-260985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B693B13E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870EAB23ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E0158D8F;
	Wed, 24 Jul 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="R1sePdXz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TnPwgI35"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059615B141;
	Wed, 24 Jul 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825969; cv=none; b=seoAplP1jLBk7Tk5LM6EtjDCZiRxkCbnPc35iwptv7iVJXjBlxRA0khT0uTPou8hYNEbjHOl95Lpo8X1m77j9/ALpo+vRFqcULgl1hkBp+opdut1iaubY1CYyVO5ycr7xto2WOeFY9y+34Q1e+Qci6g/n7Pj2sOtzewMHh8W3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825969; c=relaxed/simple;
	bh=n8s2juL7eCJdkvIqb0WTgUlPlnHTFk6pVjjk9qw1kgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnjvRndcjJKz7cKlC4LDNS772qfU/S+aHPBYcaGhrzVvIkrObgDXF9M6rmUKOl337V29LiFVhEJfQHPvHC80kGTG3DzGahsHOuBXbkA/8ricB1CQr1ITn9iMpCTdm4zec0aVzGnyGqaOD/oeId3Pb0NEiFyuziXWiwfPCPSzhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=R1sePdXz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TnPwgI35 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825968; x=1753361968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AP3CmACjx9MeO5iBgbOcdKE6AYaFx62FwXf2X5MMjfQ=;
  b=R1sePdXzFUl7wMogxEuz8Qf1Gq7aKfO3xLp4QKmb05yd5gmjpUAIKtp5
   AABOANPYgk24KlgcyEUe4OTnsh6dy8Eb8wBySYYn9FhP4Gcv5RrVPyoZn
   sqwHG7S2aW6mDJzDBc3MpuCh0aDupkhKGDBNGH5yYT94qbLJpiFoazHCY
   gGhUwi6itehRn+MDld5vUcX+qmLhvdlV1rlYBhUaYiCvCH/MA9M5dt15U
   OCbgOme0Nz+UWQEP2s6Sl9y9je+R4u0NKYxRpG6iIiDCDR2oY82H4VxAg
   R9RYBfARlLiP2h8G1WtaC0RwGs7pHvgP5os4CuGW5EUNId3Df6MohUINg
   Q==;
X-CSE-ConnectionGUID: VZ9N35euSle9PhVeAVvcwQ==
X-CSE-MsgGUID: cb+yLvb9Sw6u1vNHVyfAHQ==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058831"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:26 +0200
X-CheckPoint: {66A0FAAE-13-6C016D47-F93F7C64}
X-MAIL-CPID: 8620C7E233D5AD188CB2F30B8FA624C8_0
X-Control-Analysis: str=0001.0A782F26.66A0FAAE.0100,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BB8F1633F3;
	Wed, 24 Jul 2024 14:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825965; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AP3CmACjx9MeO5iBgbOcdKE6AYaFx62FwXf2X5MMjfQ=;
	b=TnPwgI35Bj9TyxNUDW3YmnVCR+yh9CTohVmvry6k40Kijos9L9fNWwHLod35H7bwsTFP82
	WmsL5TJYdosyQgNZ+Mq7Wng3f5qONJD6KwbkxkgrYn1hY401wolbEqyyWn2pLHAPSahpbA
	YxRNEG1hbv49/YUcyc/Wuki0eW1aeqhTw5494nu0HL/jp7xbIGG2HRazHZcwgyuUmQswra
	XAgKmv9dPtgvoUP5QaV5sjr8IBxwoiNWk2Tq4ahlzRK4dduQiP9bNAwuwLJwMERvrmzwYs
	WqkeNXut7CET9fiPT9zhdCrPuRd3C52yYyJT+jxIcvJ9R5xk4fr2BzGMPk9zug==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: add GPIO line names
Date: Wed, 24 Jul 2024 14:58:56 +0200
Message-Id: <20240724125901.1391698-10-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Provide GPIO line names for userspace usage, e.g. libgpiod.

While at it, correct the line-name property for ENET[1,2]_INT# gpio hog
and LCD_BLT_EN.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index a8870544514f..b9a22d6c1de2 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -209,6 +209,16 @@ &flexcan2 {
 };
 
 &gpio1 {
+	gpio-line-names =
+		/* 00 */ "", "", "USB_C_ALERT#", "PMIC_IRQ#",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "", "BM2_TEMP_EVENT_MOD#",
+		/* 12 */ "PEX_INT#", "", "RTC_EVENT#", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "", "", "";
+
 	expander-irq-hog {
 		gpio-hog;
 		gpios = <12 GPIO_ACTIVE_LOW>;
@@ -227,21 +237,60 @@ rtc-irq-hog {
 &gpio2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio2>;
+
+	gpio-line-names =
+		/* 00 */ "", "", "", "",
+		/* 04 */ "", "", "", "AFE_RESET#",
+		/* 08 */ "AFE_SYNC", "AFE_DRDY", "MIPI_CSI_TRIGGER", "MIPI_CSI_SYNC",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "X1_19", "X1_29", "X1_25", "X1_21",
+		/* 20 */ "X1_23", "X1_17", "", "",
+		/* 24 */ "AFE_INT#", "", "X1_15", "",
+		/* 28 */ "", "", "", "";
 };
 
 &gpio3 {
+	gpio-line-names =
+		/* 00 */ "SD2_CD#", "", "", "",
+		/* 04 */ "", "", "", "SD2_RST#",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "ENET1_INT#", "ENET2_INT#",
+		/* 28 */ "", "", "", "";
+
 	ethphy-eqos-irq-hog {
 		gpio-hog;
 		gpios = <26 GPIO_ACTIVE_LOW>;
 		input;
-		line-name = "ENET0_IRQ#";
+		line-name = "ENET1_INT#";
 	};
 
 	ethphy-fec-irq-hog {
 		gpio-hog;
 		gpios = <27 GPIO_ACTIVE_LOW>;
 		input;
-		line-name = "ENET1_IRQ#";
+		line-name = "ENET2_INT#";
+	};
+};
+
+&gpio4 {
+	gpio-line-names =
+		/* 00 */ "", "", "", "",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "DP_INT", "", "";
+
+	dp-int-hog {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "DP_INT";
 	};
 };
 
@@ -378,7 +427,7 @@ expander2: gpio@72 {
 		#gpio-cells = <2>;
 		vcc-supply = <&reg_3v3>;
 		gpio-line-names = "LCD_RESET#", "LCD_PWR_EN",
-				  "LCD_BL_EN", "DP_EN",
+				  "LCD_BLT_EN", "DP_EN",
 				  "MIPI_CSI_EN", "MIPI_CSI_RST#",
 				  "USER_LED1", "USER_LED2";
 	};
-- 
2.34.1


