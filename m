Return-Path: <linux-kernel+bounces-346238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2398C195
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A328C1C23CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EA1CB320;
	Tue,  1 Oct 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Orrxk9oU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832E1C9EA3;
	Tue,  1 Oct 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796422; cv=none; b=rD+16Ta2N8dEwEaB9Z1OBL6r/XpP5LcR4TymWJbqKE84vvSjhx7KLoZTMm+haKUwxz5Ui6NdeEbcTEXK3YPYLOUR4wihU1ingwY3IVrV/aL+/kqX/9ZWbsYrupEJF4UGbmoje6RUfl9mnmDNfPciB2ZsHPSa6YGFwPENCofFQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796422; c=relaxed/simple;
	bh=SL4U8XMdyDnpU8gfWa0S+99lw78Ji/G7+KppA7QWofY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDK88bATFQhEm2yS311lIrtgcXKxzq1lW+hhqUTS++P+7cLA81an2T3MddCuskP/VWF7UFHCFCBAHjz2/AY7cQRwStMpZ9BsGCkWWHYpY1ru1JEK3/cGOcUjY7iZcFCeNfybf/Mc81LdZCs93WMcfYz4L2UR0fH6Vry/x/uPAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Orrxk9oU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727796421; x=1759332421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SL4U8XMdyDnpU8gfWa0S+99lw78Ji/G7+KppA7QWofY=;
  b=Orrxk9oUn7ve82Uw+npk5sFrI9lcioFEata7kw8hQgcu0VPHeyGALcf4
   Kd9Wub/YU+EDzkXMQrIZgqS9F21Rk3ylVMjoSO+ru56cAatLxNloRQFci
   CuA8V2Pa1M5KY8AFkXJWOeh6zHIqGrz3jEg6uh/JS0+1N8pCKj316whkN
   VVCsiuj8Ko+KmUJPao4OuQSYqqK9z6hd9M5qAuFu87bewL0pzRlxmePRY
   JF9L4OGIwEzvZp1FDP91yTubf2O56+XAnFOqLnvFJ3ppD/jw9oeFB1tuk
   RduUR/YTSo45+C/+xMas3Mzv4s1ib1dz/2XRppXoRTli0YT6Gqy3CeIhf
   A==;
X-CSE-ConnectionGUID: C4iJhjyxTv2OpDXExwgrvQ==
X-CSE-MsgGUID: IKlAB4FXQ9OYzRqppf5JAg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="35727107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 08:26:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 08:26:41 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 08:26:38 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 2/4] ARM: dts: microchip: Rename the pmic node
Date: Tue, 1 Oct 2024 18:25:39 +0300
Message-ID: <20241001152541.91945-3-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001152541.91945-1-andrei.simion@microchip.com>
References: <20241001152541.91945-1-andrei.simion@microchip.com>
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


