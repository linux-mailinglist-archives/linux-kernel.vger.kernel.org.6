Return-Path: <linux-kernel+bounces-347486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98998D351
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580B41C21748
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC11D52B;
	Wed,  2 Oct 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X5xjXmlm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86A1CFEAD;
	Wed,  2 Oct 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872285; cv=none; b=VrGI5ql4n2VRApOHfFK0qwTiD24WsEuL73Ww0UX727UwsoXyVAjrBPYZkuO3LzImggybCkTlkkE4MJIcO0RIMDOpAMGptIqgG+Cf/z6cDwkcs93bxORu5zpAKswjRrSJoauAY4pz/0kJd+DmCv0kaxzVIlyLzDaigfJsOzISda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872285; c=relaxed/simple;
	bh=t3xbVTB8hOmMcXYfqn1i/NT/cEx1oPiyHA9GkHRQSdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKVgwueNtSf8ZcZq5iBkTj7LmF0qB5seS48cb3Q3P5tM0p/R7zUPrLNXafIM4KRleh4CyrQJSt6WUy2VSAie+kZILhujFp5rUWGUngkGOngJJouddUX/B/mfRqF2m3T6FAn9rtum7Ol13uRDDSAORdevXA7lgTAa7ijZJo+hDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X5xjXmlm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727872283; x=1759408283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3xbVTB8hOmMcXYfqn1i/NT/cEx1oPiyHA9GkHRQSdk=;
  b=X5xjXmlmKzknYmah9LdvlVO8yOZp7MlcXI9XkvjM+yEIyI0gOMC9S+RL
   8b9Qlnh/lsuIm4fzkXLKDK9EqI8oWoPQih8iYKZ/Us3Akce/sAWu1G3z2
   atThU6AmWuDzy0UH59xtysygCiuLCN4MxdFoD7lN/Rid8bNowExoZCs+L
   xVygfK4qhGsguHThaZ6LGYKgp3u3lhzhH9dlacfZK7AK1F6toIFd0Ma3G
   W4Gn7PHRFvMcAHf7pp77DR01MRGKtooEIK27/IA9Yb6jLGdkUYfN15i6H
   xy54MSgtm/XlmkOZYYyw0hVPDNd+2MoY4B4SiOr1rmFDdLZnwqF9mdSKF
   w==;
X-CSE-ConnectionGUID: gsXlODJpTSiMie2QZcRNiA==
X-CSE-MsgGUID: qBkR5YYxTFyxNg5sSoVRKg==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="33109841"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 05:31:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 05:31:02 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 2 Oct 2024 05:31:00 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v3 2/3] ARM: dts: microchip: Rename the pmic node
Date: Wed, 2 Oct 2024 15:30:10 +0300
Message-ID: <20241002123010.111028-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002123010.111028-1-andrei.simion@microchip.com>
References: <20241002123010.111028-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Rename the pmic node according to the devicetree specification.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v2 -> v3:
- no change

v1 -> v2:
- act8865 to pmic nodename
- label pmic to act8865 for pmic
- rewrap commit message
---
 arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi    | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts        | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts          | 2 +-
 arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
index e5e21dff882f..a44d92305dbb 100644
--- a/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
@@ -85,7 +85,7 @@ led-3 {
 &i2c1 {
 	status = "okay";
 
-	pmic: act8865@5b {
+	act8865: pmic@5b {
 		compatible = "active-semi,act8865";
 		reg = <0x5b>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index c173f49cb910..ef11606a82b3 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -75,7 +75,7 @@ &i2c1 {
 	scl-gpios = <&pioA PIN_PD20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
-	mcp16502@5b {
+	pmic@5b {
 		compatible = "microchip,mcp16502";
 		reg = <0x5b>;
 		lvin-supply = <&reg_5v>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 951a0c97d3c6..b6684bf67d3e 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -149,7 +149,7 @@ &i2c0 {
 	i2c-sda-hold-time-ns = <350>;
 	status = "okay";
 
-	mcp16502@5b {
+	pmic@5b {
 		compatible = "microchip,mcp16502";
 		reg = <0x5b>;
 		lvin-supply = <&reg_5v>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 5e2bb517a480..9edf91c187c0 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -195,7 +195,7 @@ i2c6: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
-		mcp16502@5b {
+		pmic@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
 			lvin-supply = <&reg_5v>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
index 820033727088..5662992cf213 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
@@ -87,7 +87,7 @@ i2c0: i2c@f0014000 {
 			i2c1: i2c@f0018000 {
 				status = "okay";
 
-				pmic: act8865@5b {
+				act8865: pmic@5b {
 					compatible = "active-semi,act8865";
 					reg = <0x5b>;
 					status = "disabled";
diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index ed75d491a246..f7bcc96bcd19 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -244,7 +244,7 @@ i2c1: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
-		mcp16502@5b {
+		pmic@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
 			lvin-supply = <&reg_5v>;
diff --git a/arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi
index 830a0954ba1b..362806afef44 100644
--- a/arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi
@@ -79,7 +79,7 @@ ethernet-phy@7 {
 			};
 
 			i2c1: i2c@f0018000 {
-				pmic: act8865@5b {
+				act8865: pmic@5b {
 					compatible = "active-semi,act8865";
 					reg = <0x5b>;
 					status = "disabled";
-- 
2.34.1


