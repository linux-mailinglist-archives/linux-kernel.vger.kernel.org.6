Return-Path: <linux-kernel+bounces-292029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E707956A52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410FD1C2348E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598616C864;
	Mon, 19 Aug 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="PhczWMGR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kmmytZUD"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEF16C6B8;
	Mon, 19 Aug 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069063; cv=none; b=Ld5/V3uEO6YkUu/u272UDAfDSv0J47Y74ZHh5sq469ob2W+IJt5D3uLy+5NzM2UIYY2T9OaYufVe+k4alU7lm1Bw2uNk9lALYTFzQMZ8Npp0rpnnL0lj7rX6+MZZoSt+EuqHSg1iMjmbGNmZFd067FgN92Z0dzZBwk5UYynVoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069063; c=relaxed/simple;
	bh=jt3X7Dp3GOsKdhViF5WKqlL/EOisRMMtZTRVkyM7kro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgHT9Fl1PPWfp19KMA0rmQKNVH7mz9on5iEaGbifWvWPObwJNR42K00AFGEGcKfiqe0bh6gTdQRYRTT6mbGXgBsRw0h3TpwxxSqoa5/5EGP3s/Iz+pfkobjbSN4LoHSzNIHm43f3FmVJja+l9MSfYJ9Y3ea/+mV2sJA0RKxcAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=PhczWMGR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kmmytZUD reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069062; x=1755605062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0SlXCCw4Mb+wJuWMy9mCBZ3oqJ3u01WKvVCVP+AX2bk=;
  b=PhczWMGRGjAZXUXNzT4XZr6naGYTxDww70MNwy2K2k3bv8te7iOYXjoh
   FEsf9IYpB0TadOGVql96DAG3v9tGhEyFulmmVvv8UWbrlTmnwl1DsrhoS
   npy07jcOCP3lLSyG5tmvs0ltcnF1V33xEesXJLn0S21/yzxZOWm/lnxHb
   BC5/3XSvEi/7K2yDRVk9MhRTjgS9CbPAS0ih/wFKgFvRkxjHTBVs4m0xX
   CNLg6qY9JzaHIOfwoCLpC0sLvEaYBmuYB+OOkE4XVztrZAX1vhy5+X3La
   HrUt9j6oEqghVrlzBCw2yQm9Nq8dMY0IuI6/FA7CRGpYJ6gArodGWHPjE
   A==;
X-CSE-ConnectionGUID: B7+aeSK4R3CEr/4qs/fr+w==
X-CSE-MsgGUID: Br1r+I6eQVm482yVQYFs9w==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467134"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:21 +0200
X-CheckPoint: {66C334C4-26-FF00FE11-F2A862FD}
X-MAIL-CPID: 2425E8545625AC393F4300E139099ADB_5
X-Control-Analysis: str=0001.0A782F1F.66C334C5.0050,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC5801688FD;
	Mon, 19 Aug 2024 14:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069056; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=0SlXCCw4Mb+wJuWMy9mCBZ3oqJ3u01WKvVCVP+AX2bk=;
	b=kmmytZUD1pExS6UZm6J8BMNTV8oQ1tsxKtUUAsE7up9qFT6vbmIJYU1BSijT99lNBuNNwa
	4XJ6GCqGYt+tln1SCUMnvH5+/pM7GViDx2xuGEe0u4JyDzSfkH2194wV+VYomItP5yayRr
	3MonDSL1G2tUrsyIcbVHQwUFeD0ehyte7mlgxuptA4ebdFbE6SOo4vOjhgOEycXAOVm5rC
	sLaw2Artak+T66EnXbXMfqjJCwFbJa53kNaJ4LACdGrtzcSTxr0WX0TDsa871/u5lO47Sz
	62N6iKeTbz5sVy7qcf6kv5afaWDWhKElyyNO1wjVx0XCLfE7joh7fsYpWjnNgg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 08/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: add GPIO line names
Date: Mon, 19 Aug 2024 14:03:22 +0200
Message-Id: <20240819120328.229622-9-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 643d006fbf8fd..3f8726180bba2 100644
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


