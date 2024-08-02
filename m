Return-Path: <linux-kernel+bounces-272318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB57945A37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7E1F22618
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C51C37A9;
	Fri,  2 Aug 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ethVp+8m"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E551C378A;
	Fri,  2 Aug 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588335; cv=none; b=dOehU3tKbmJ0VFEJkSaH1dgizs2LbPhsD+NnOL1uFQjUzt1RLDsW5tUhxJRj8jwJiWeaPt3j1DRU3ov14vzFc7xpfTeK9cZNmHjF/voT2WbQPCWodLyEFs8tW2Hpl/I1F3qnJ/aua4/GERVDxZ4h52RmZ80ybo60UPI11kUYuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588335; c=relaxed/simple;
	bh=Q6lmEiRmr975I1TYSOtBAxJxCGpB+TnOSXNmRDZICks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyLddDvVmu2JKCuy0k1MsnuVnP5RpR1DGLGVK1Mypkr3QsswczGFzNtEKr9W1ZKcWqYDAs/5WByL8cQsjpREuStPSTgToQ8UXMtlL9e+W67+GsmcMX9fWtavfjWfer+/qO8ZLQ6dGK3e6w+wDtTzYKmzndoXkDWHHWr2glhtbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ethVp+8m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588333; x=1754124333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6lmEiRmr975I1TYSOtBAxJxCGpB+TnOSXNmRDZICks=;
  b=ethVp+8m+xc12opiewl7DQpf36zf7OTxIRvKcXZefZGZMR6mzDKfEqK8
   9XkEVxgZdvYPwidrv6r2L32o5whaT/WVYhwg+BEnkQB/7cQMmtlThrw+8
   Gu0GlY8R5UHNRA6t0caAAJJsxTvA4/nkth5DiDlzMAapDvYVtl7DmZXFp
   J4PTm7HLgAVqk6/PjrDaa9QjwO34MKhuGiE+Bni5N6GXqr0YxMxE5WYxZ
   InLjgnJXiznrfhKkczTsC0ADns2GmK71FsD15zvavXPf3Ga+/8BaZC592
   gZo40TYQehE+2IMDQB5Lng0fIZhfQRpDtqkfnSFquoXJscfMus/6yT9gd
   Q==;
X-CSE-ConnectionGUID: LYEUG+dsQgOZlljD5sjyvQ==
X-CSE-MsgGUID: iVEbaZ1hRVub8fnsmf6FyQ==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="30020950"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:45:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:44:51 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:44:48 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/6] ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nodes
Date: Fri, 2 Aug 2024 11:44:29 +0300
Message-ID: <20240802084433.20958-3-andrei.simion@microchip.com>
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
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 20b2497657ae..f0035b093b16 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -88,6 +88,14 @@ memory@60000000 {
 		reg = <0x60000000 0x20000000>;
 	};
 
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	sound: sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sama7g5ek audio";
@@ -244,6 +252,7 @@ mcp16502@5b {
 			regulators {
 				vdd_3v3: VDD_IO {
 					regulator-name = "VDD_IO";
+					pvin1-supply = <&reg_5v>;
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-initial-mode = <2>;
@@ -264,6 +273,7 @@ regulator-state-mem {
 
 				vddioddr: VDD_DDR {
 					regulator-name = "VDD_DDR";
+					pvin2-supply = <&reg_5v>;
 					regulator-min-microvolt = <1350000>;
 					regulator-max-microvolt = <1350000>;
 					regulator-initial-mode = <2>;
@@ -285,6 +295,7 @@ regulator-state-mem {
 
 				vddcore: VDD_CORE {
 					regulator-name = "VDD_CORE";
+					pvin3-supply = <&reg_5v>;
 					regulator-min-microvolt = <1150000>;
 					regulator-max-microvolt = <1150000>;
 					regulator-initial-mode = <2>;
@@ -305,6 +316,7 @@ regulator-state-mem {
 
 				vddcpu: VDD_OTHER {
 					regulator-name = "VDD_OTHER";
+					pvin4-supply = <&reg_5v>;
 					regulator-min-microvolt = <1050000>;
 					regulator-max-microvolt = <1250000>;
 					regulator-initial-mode = <2>;
@@ -326,6 +338,7 @@ regulator-state-mem {
 
 				vldo1: LDO1 {
 					regulator-name = "LDO1";
+					lvin-supply = <&reg_5v>;
 					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
@@ -342,6 +355,7 @@ regulator-state-mem {
 
 				vldo2: LDO2 {
 					regulator-name = "LDO2";
+					lvin-supply = <&reg_5v>;
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <3700000>;
 
-- 
2.34.1


