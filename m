Return-Path: <linux-kernel+bounces-272320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBD945A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23601F22A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5C1C37AC;
	Fri,  2 Aug 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iyQcqatp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52321C37A8;
	Fri,  2 Aug 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588337; cv=none; b=PN8wAkyJjr/mnjkp0vo1dU+0bEwcqHvdtQy8KuDn6j4z15hLEiiBWDrwkKEeJLWxNLzfxJDklURFyAAC93MPmvlmuNYwZaVd6moWe083dV2DFSjVnAWsPIzAdEqCQlL93tiuwrNFJDqOmWwXplOlOwa7i9zZws2wsvbAgzcXHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588337; c=relaxed/simple;
	bh=TejsSOhsOmKqusJ8lQXtEWqTMOoMoF+0PREYZbGSir4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSjUEAPJVg79/QvKV4YW/9RuWSNzeRMppTEsdqj5RKQE7HJA4hIZJQ4I2GFq3VPUaoCmi0gtO6SbCvoZX187mPmkBJRKuRvXJFFRHiwWCgVSwbRRFKtfpILORAUzx2MfWNg8EW51mBp0nnMBLLYl8hJJfvHZcBeaIfPVHgB/ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iyQcqatp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588335; x=1754124335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TejsSOhsOmKqusJ8lQXtEWqTMOoMoF+0PREYZbGSir4=;
  b=iyQcqatpiNcb+RaCmsC0tLhDu8AKyEt8sICYvCPtXiL5CFme8192OHMp
   jKhMGsRKVNauIl2i/mC3H9Q3yBNYdFbGJtifdFbj63VVsjNJy3JXL76dh
   cuLFEngyliHpebqRRElYkrNvmD09PN+2XYRjm3FbkLa96SWd7kTOs7Pjw
   PyuXPeOW6UJMI/4hvmCM1ZK6k6+m6bp4dAZgn7kp34KMu11oO3rrLYEx1
   x20FWrJOvTgD+NwuSrMOPkJ0AGmV4TRQIGr75ZT/JYaqTBInzrhuhXiIx
   o5G96d9mWo3fSfPqErb812Ous/CZv4QpuOClWVFTp92RE2+0rgD6Y2/mG
   A==;
X-CSE-ConnectionGUID: LYEUG+dsQgOZlljD5sjyvQ==
X-CSE-MsgGUID: SwBcd4ZQQwGJpAocKFfWww==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="30020953"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:45:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:44:58 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:44:55 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 4/6] ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC nodes
Date: Fri, 2 Aug 2024 11:44:31 +0300
Message-ID: <20240802084433.20958-5-andrei.simion@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..20ef12a321fb 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -78,6 +78,14 @@ led-blue {
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_MAIN_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &adc {
@@ -196,6 +204,7 @@ mcp16502@5b {
 			regulators {
 				vdd_io_reg: VDD_IO {
 					regulator-name = "VDD_IO";
+					pvin1-supply = <&reg_5v>;
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-initial-mode = <2>;
@@ -215,6 +224,7 @@ regulator-state-mem {
 
 				VDD_DDR {
 					regulator-name = "VDD_DDR";
+					pvin2-supply = <&reg_5v>;
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
 					regulator-initial-mode = <2>;
@@ -234,6 +244,7 @@ regulator-state-mem {
 
 				VDD_CORE {
 					regulator-name = "VDD_CORE";
+					pvin3-supply = <&reg_5v>;
 					regulator-min-microvolt = <1250000>;
 					regulator-max-microvolt = <1250000>;
 					regulator-initial-mode = <2>;
@@ -253,6 +264,7 @@ regulator-state-mem {
 
 				VDD_OTHER {
 					regulator-name = "VDD_OTHER";
+					pvin4-supply = <&reg_5v>;
 					regulator-min-microvolt = <600000>;
 					regulator-max-microvolt = <1850000>;
 					regulator-initial-mode = <2>;
@@ -271,6 +283,7 @@ regulator-state-mem {
 
 				LDO1 {
 					regulator-name = "LDO1";
+					lvin-supply = <&reg_5v>;
 					regulator-min-microvolt = <2500000>;
 					regulator-max-microvolt = <2500000>;
 					regulator-always-on;
@@ -286,6 +299,7 @@ regulator-state-mem {
 
 				LDO2 {
 					regulator-name = "LDO2";
+					lvin-supply = <&reg_5v>;
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
-- 
2.34.1


