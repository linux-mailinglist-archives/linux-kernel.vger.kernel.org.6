Return-Path: <linux-kernel+bounces-286429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC2951ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B981C21580
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56C1B143F;
	Wed, 14 Aug 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HlqUe5Qs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F81B0133;
	Wed, 14 Aug 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638545; cv=none; b=YFssxwS8M0i1nxyNuF/hwP2rLeL1FbB13rwq7Rx57zSlu0R74hdyvEKgeY4LpnD7dYQ+6dm7F/FbAZFz1pyp1szVzayUDPBDN2urgeY21MKBAUjPTo+6hcCh/NKlh8bivZ0D3RgJOUPedEE4Zv8mrxP0QZKp7YUCBwYyTeyAKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638545; c=relaxed/simple;
	bh=WP/ROJkdOwdUcM3+NljtX8Z5RSGhAGr5wjegqaT3RQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbNbGM9YRLIZ0cb5lgNQ7eMPkHcIK6+7hXUau9yOILgwZ310F+YEqrALhrzF6X4WlnpqZSHdtmZyjfDdg/Ys4DIZkI+NH2D00MV1WXvx/ygp8HPcK/xaOnmhKNfTui0YQBOwnBPmBaBi8Xz9ffpE8ZHIe6G0mAz6zyFiJEz09uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HlqUe5Qs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723638544; x=1755174544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WP/ROJkdOwdUcM3+NljtX8Z5RSGhAGr5wjegqaT3RQ4=;
  b=HlqUe5Qsu0B+IXbWkcs8gbcEozXP0SaQBHb5GTr4ERGI9Bx8n2hbIKyD
   hWq/AU32iHBkFpnbv+KfV6KTaAGtN+/vkfvEjPclx1jkiQlRu/Q6J12Qb
   brLqKrxauFq/nlvQ/L+iqDV/07Yd0pXHRkEtBsLiWlG1cLLfr5FfuIxKr
   Jvoue30mxUzJtnqadsCS2E4mK10egJYLVnf++SH/WWi4g/Tleh7mNVKIo
   1RQGHyrS7VrDWInv2pqVkavR7+yZLlEsGJxfkObABmUeuBDoIeFHhxK9R
   HQ4cwY0+2CmBJMpeSaNnwHZ4/DgYP7okiG1RF2UW/PSCqb0QMmZuK3dpt
   Q==;
X-CSE-ConnectionGUID: 4X+cfYNUS7iIAk4JdwvsDg==
X-CSE-MsgGUID: MXhR95nzR7GXGZXUSxjNfg==
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="30486704"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 05:29:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 05:28:47 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 05:28:45 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <cristian.birsan@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 3/5] ARM: dts: microchip: Rename the pmic node
Date: Wed, 14 Aug 2024 15:26:31 +0300
Message-ID: <20240814122633.198562-4-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814122633.198562-1-andrei.simion@microchip.com>
References: <20240814122633.198562-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Rename the pmic node according to the devicetree
specification.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
Split the bloated patch into small patches on topics
based on comments
https://lore.kernel.org/linux-arm-kernel/89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev/
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
index 4617805c7748..2114b2ad9a91 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -67,7 +67,7 @@ &i2c1 {
 	scl-gpios = <&pioA PIN_PD20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
-	mcp16502@5b {
+	pmic@5b {
 		compatible = "microchip,mcp16502";
 		reg = <0x5b>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..412cc65472ff 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -141,7 +141,7 @@ &i2c0 {
 	i2c-sda-hold-time-ns = <350>;
 	status = "okay";
 
-	mcp16502@5b {
+	pmic@5b {
 		compatible = "microchip,mcp16502";
 		reg = <0x5b>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 54f5672285e4..e4648682c994 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -187,7 +187,7 @@ i2c6: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
-		mcp16502@5b {
+		pmic@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
 			status = "okay";
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
index 40f4480e298b..dd0370cd41b4 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -236,7 +236,7 @@ i2c1: i2c@600 {
 		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
-		mcp16502@5b {
+		pmic@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
 			status = "okay";
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


