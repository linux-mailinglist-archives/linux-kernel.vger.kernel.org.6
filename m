Return-Path: <linux-kernel+bounces-283230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA39694EEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A903282133
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC9186E5B;
	Mon, 12 Aug 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rIoc2ZH9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47822181310;
	Mon, 12 Aug 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470779; cv=none; b=Xab7aN0XRdn4t98mdCW9/OVv2Ir8T5i4S1/24woAcrRRGaeHRnZt2RsYR0cMJ1lQ/i3H72R++SnIXAPPSbZO4abvYlZ5iW88/X1KNeDeraZQiSGfeis+dYn99NzT6RRbBQv966dAKEkSjYnwNR4BfIBFvrziYym7LxRSXNNwqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470779; c=relaxed/simple;
	bh=zaUj7SzUowKlrBVjaV2JQOX+pztogGW6AKsHXIGv+RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCNFBjjgHE6MG9e9gLB2f+r1JVWh276UeEQwp0HiOHwfBfo4G50n04lWiCA22LV6wf7hkzy4UvQUhd7D4vqzR6z/Usp/5Br5V7KZ/ipDLwRcyxOSbFZzonISghNJmTfhSH8Fyo2shBQG8Enw3EktPCAD40Slu+O2qlm4j16jwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rIoc2ZH9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470778; x=1755006778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zaUj7SzUowKlrBVjaV2JQOX+pztogGW6AKsHXIGv+RA=;
  b=rIoc2ZH9Z3wOkWm3jV1Z0B3pDpIi/y65HXJqWTYw9I1OR5ttUQBh5gHu
   JEfytf5bc5tHqzdTh607bG+gXxMDlodbekOq4N+pi1w/eNnD4xomhegbB
   lCSgmNWozk4dPwCe3C9ruH03xPzhlL+C3UK2FGGQVEzYaJq2KUqMgGT7m
   erDZuUc3ZPxO1luqSszUzO9HW+f4oUUHRuZV8GbNRBL3UuvHq3bVqgx4t
   Mnih28Mfwrrz+SjJ4uhERFOnbv8uLXDDCvmHAeufLuQQ6hJGknLA9KgoY
   p5kxxkglw+E53QywkxAAo3hdWRmDfDhNISM5vZO73ysaRyF/KF+TEdXyP
   Q==;
X-CSE-ConnectionGUID: PBrTB/MiTDi13LaLj3S1lQ==
X-CSE-MsgGUID: rpT6IlL/TaewIPLKp1gM/Q==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="33289888"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:46 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:43 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 3/7] ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nodes
Date: Mon, 12 Aug 2024 16:52:27 +0300
Message-ID: <20240812135231.43744-4-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
References: <20240812135231.43744-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align with the datasheet by adding regulator-5v which supplies
each node from the regulator using phandle to regulator-5v
through pvin[1-4]-supply and lvin-supply.

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- drop (lvin|pvin[1-4])-supply from each regulators sub-node
- add lvin-supply, pvin[1-4]-supply to PMIC node
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 40f4480e298b..ed75d491a246 100644
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
@@ -239,6 +247,11 @@ i2c1: i2c@600 {
 		mcp16502@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
+			lvin-supply = <&reg_5v>;
+			pvin1-supply = <&reg_5v>;
+			pvin2-supply = <&reg_5v>;
+			pvin3-supply = <&reg_5v>;
+			pvin4-supply = <&reg_5v>;
 			status = "okay";
 
 			regulators {
-- 
2.34.1


