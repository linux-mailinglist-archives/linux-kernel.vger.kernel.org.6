Return-Path: <linux-kernel+bounces-272322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA51945A40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11372B2382F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D611C4621;
	Fri,  2 Aug 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W/hE+pUW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FE1C3F14;
	Fri,  2 Aug 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588338; cv=none; b=vD62U7Kbo0OHKED2/cr+87s+EXYMe75HEsUMvHJz7TynU6Lx1grRwJQDOUhBdK5xZqLXz2JjpQS/p3j26zf67S+Is81g1+0OvOfpxvK/0S4jVCTEfMj/+ytKKSTSe+FVcEtZCFPumQPdFkB5Rj/GX04jRstm/8tZgLRqkc0vO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588338; c=relaxed/simple;
	bh=NkzjrWmY9GxHW4qybd1qDhh4ZKci0hr+K7IaFyByWAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYqhy0xewLF/3BsX1bQlmVm+U3ZXPbpIfG55Df6Zt9imW+6OO+t+heEboPfW15GmSFf2NIptcWX6mJR0aBg0SLXVAoNZeA2/MWMDStwR5U3FMRwbBNQw9sJHLTGsWTJ/7up6spHbMJaJ0kBhFFuTguIcH3Z2faG4h//ejdbRPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W/hE+pUW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588338; x=1754124338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NkzjrWmY9GxHW4qybd1qDhh4ZKci0hr+K7IaFyByWAk=;
  b=W/hE+pUWX+m34TK0xf+DYTblJHNErngpJ+ndDutV0O2Z+PjO2W8XTDqa
   DV2LFpdf6v/cSJNs+OjrxMNDt2Bon0PimJAVQwgNWMFs7u8qNUZllCvvl
   /F8j+XQ1WW67Kx7l0SjqaueKZSm8ajk868HMSChfM0QKH9XXN9VbBxH4i
   Nv5zg+b94FaQTTnsZvNlilCSU/6Up5KoeYbUWq0qlxAVshJHsGtPqWFgB
   EctK7itlLsPLxIKMn5YzPMbcLn1CpuAuC2h20h1PhoSyTCzE2/1sfH8tw
   LPqCrNI27U2FadEzA2PpjiMPNhUtIsvzshPtlDAoFMkJRiD07ETEFP2mZ
   A==;
X-CSE-ConnectionGUID: W9KqdMcXRKuEFdpNV+qlRg==
X-CSE-MsgGUID: Yv6uE7HJQBy2b86uGBUtOA==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="260922556"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:45:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:45:05 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:45:02 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 6/6] ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC nodes
Date: Fri, 2 Aug 2024 11:44:33 +0300
Message-ID: <20240802084433.20958-7-andrei.simion@microchip.com>
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
 .../boot/dts/microchip/at91-sama5d29_curiosity.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..a9d409ad7726 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -84,6 +84,14 @@ memory@20000000 {
 		device_type = "memory";
 		reg = <0x20000000 0x20000000>;
 	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &adc {
@@ -150,6 +158,7 @@ mcp16502@5b {
 		regulators {
 			vdd_3v3: VDD_IO {
 				regulator-name = "VDD_IO";
+				pvin1-supply = <&reg_5v>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-initial-mode = <2>;
@@ -169,6 +178,7 @@ regulator-state-mem {
 
 			vddio_ddr: VDD_DDR {
 				regulator-name = "VDD_DDR";
+				pvin2-supply = <&reg_5v>;
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-initial-mode = <2>;
@@ -192,6 +202,7 @@ regulator-state-mem {
 
 			vdd_core: VDD_CORE {
 				regulator-name = "VDD_CORE";
+				pvin3-supply = <&reg_5v>;
 				regulator-min-microvolt = <1250000>;
 				regulator-max-microvolt = <1250000>;
 				regulator-initial-mode = <2>;
@@ -211,6 +222,7 @@ regulator-state-mem {
 
 			vdd_ddr: VDD_OTHER {
 				regulator-name = "VDD_OTHER";
+				pvin4-supply = <&reg_5v>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-initial-mode = <2>;
@@ -234,6 +246,7 @@ regulator-state-mem {
 
 			LDO1 {
 				regulator-name = "LDO1";
+				lvin-supply = <&reg_5v>;
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
@@ -249,6 +262,7 @@ regulator-state-mem {
 
 			LDO2 {
 				regulator-name = "LDO2";
+				lvin-supply = <&reg_5v>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
-- 
2.34.1


