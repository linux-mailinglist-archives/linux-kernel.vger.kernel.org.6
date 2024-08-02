Return-Path: <linux-kernel+bounces-272321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE38945A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EC91F22BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75C1C4617;
	Fri,  2 Aug 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kL7pjbK9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAA1C3F00;
	Fri,  2 Aug 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588338; cv=none; b=PvDRYFdMZQAoe3m47tuH21u0d2N5045/RjonoOd99zhAcuYfX10QnW0OZT82afpONG0g5HpOsVA6/IO48xjweCCMFldYlpgevBPucjgNlM7ktpHLin5bPB2aXlUipxfduFa+hf7otST9P8MSNDcq4uS2s48vB4dZ0z+3yknLWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588338; c=relaxed/simple;
	bh=K29k24kzKneZWnfjHSTcWkTTvB22pIg9LKv6Kq+QW2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Bd4OPLzhrza2VGzJTGvncklBOs4YrdtvLLvZtC5YkkbG7uH+BQZShUKRqaOOQayq2nNxDc1jKvuMwfsed6l5spJgmPpCm3mR5jtBd6t596AAyeKeKXKYDqSYrcX3PUBr5qeajVk9lN/mfYW1SDXfTofrZDYWPvLApkbTlaYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kL7pjbK9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588337; x=1754124337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K29k24kzKneZWnfjHSTcWkTTvB22pIg9LKv6Kq+QW2c=;
  b=kL7pjbK9117LrhedeyLSCvI3QEikIHkQhPCxV3XknH+GAaYxnKWGF7HN
   2yvcVLMMNdyqldGBmJVwfgm5048sunD9MyYOwtY7ac0Ao4rVmpPSExlth
   ABWjtlcB7ksf7S1tsqWLi2HDALqr4+YxgRs/NQVluQj/EaDCi+cHnw4an
   LBJq6y1GAUy6rQSqK5jWSEYyP8A6b6xmePbRESBYIVdA6vSCcbGlsP4GA
   L1/KZO9gCPg8PyBI1lWNvmQQYegJVDNoUCehhvMoA5Zq56JX8FhFPz8Cn
   0mH32Q9X7mET44j/EbZYnq+xNnDDGfodCVwtocuNv+M1ymVY6stbUKj8G
   w==;
X-CSE-ConnectionGUID: LYEUG+dsQgOZlljD5sjyvQ==
X-CSE-MsgGUID: 2QWiiGLISm28f9hw4p1Jsg==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="30020954"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:45:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:45:02 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:44:59 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 5/6] ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PMIC nodes
Date: Fri, 2 Aug 2024 11:44:32 +0300
Message-ID: <20240802084433.20958-6-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802084433.20958-1-andrei.simion@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align with the datasheet by adding regulator-5v which supplies
each node from the regulator using phandle to regulator-5v through
pvin[1-4]-supply and lvin-supply.

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..21c6e7e645fa 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -31,6 +31,14 @@ main_xtal {
 		};
 	};
 
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-wilc1000";
 		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
@@ -76,6 +84,7 @@ mcp16502@5b {
 		regulators {
 			vdd_3v3: VDD_IO {
 				regulator-name = "VDD_IO";
+				pvin1-supply = <&reg_5v>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-initial-mode = <2>;
@@ -95,6 +104,7 @@ regulator-state-mem {
 
 			vddio_ddr: VDD_DDR {
 				regulator-name = "VDD_DDR";
+				pvin2-supply = <&reg_5v>;
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-initial-mode = <2>;
@@ -118,6 +128,7 @@ regulator-state-mem {
 
 			vdd_core: VDD_CORE {
 				regulator-name = "VDD_CORE";
+				pvin3-supply = <&reg_5v>;
 				regulator-min-microvolt = <1250000>;
 				regulator-max-microvolt = <1250000>;
 				regulator-initial-mode = <2>;
@@ -137,6 +148,7 @@ regulator-state-mem {
 
 			vdd_ddr: VDD_OTHER {
 				regulator-name = "VDD_OTHER";
+				pvin4-supply = <&reg_5v>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-initial-mode = <2>;
@@ -160,6 +172,7 @@ regulator-state-mem {
 
 			LDO1 {
 				regulator-name = "LDO1";
+				lvin-supply = <&reg_5v>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
@@ -175,6 +188,7 @@ regulator-state-mem {
 
 			LDO2 {
 				regulator-name = "LDO2";
+				lvin-supply = <&reg_5v>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 
-- 
2.34.1


