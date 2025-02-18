Return-Path: <linux-kernel+bounces-518741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C3A39401
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC473B521C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897DC1D5ACD;
	Tue, 18 Feb 2025 07:42:49 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082C1CEAD3;
	Tue, 18 Feb 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864569; cv=none; b=QerN3YW1+G0rpjdJQNMcG/XIy5muFeEQigFSSvK9k0hx/WAOQj5WbuxNUWsQvZlFnSv/3FUqLi80YNpB5XwvOm/JaCF5hDQKzwfZchBPftGpYub1bXVwS9AyT4I+/qAo76oXtB1DYv6A5S3zpwLbnTYDxx31ahsUZwZX0pvA424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864569; c=relaxed/simple;
	bh=0DXTL1IPm6qXY4ykIm4VAQ4Aa8K1rUuptSLtaYfs968=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEGzVLyEPmZ9UOac3xLYHvLF2heBFBRsrcfVYS4YU3gcWvmZJcdGFxsV6cUBXddRTl4tnBcbN9EHPl4VPi3i7hG3nTmusH84arKxxlpDtZ7B0kU7gU/2cYhwtRPHdZY/q2V46lry2O1hOzTDDzcCQrCcQh1nAVf+NBnhlSsvNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFi-00G0MD-1a;
	Tue, 18 Feb 2025 08:42:46 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v3 05/15] arm64: dts: imx8mm-phycore-som: add descriptions to nodes
Date: Tue, 18 Feb 2025 08:41:46 +0100
Message-Id: <20250218074156.807214-6-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
References: <20250218074156.807214-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Yannic Moog <y.moog@phytec.de>

Add missing EEPROM and RTC descriptions. Also use eMMC with
lower-case "e".

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- no change
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 7e859c65317a..cced82226c6d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -290,6 +290,7 @@ sn65dsi83: bridge@2d {
 		status = "disabled";
 	};
 
+	/* EEPROM */
 	eeprom@51 {
 		compatible = "atmel,24c32";
 		pagesize = <32>;
@@ -297,6 +298,7 @@ eeprom@51 {
 		vcc-supply = <&reg_vdd_3v3_s>;
 	};
 
+	/* RTC */
 	rv3028: rtc@52 {
 		compatible = "microcrystal,rv3028";
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
@@ -307,7 +309,7 @@ rv3028: rtc@52 {
 	};
 };
 
-/* EMMC */
+/* eMMC */
 &usdhc3 {
 	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
 	assigned-clock-rates = <400000000>;
-- 
2.34.1


