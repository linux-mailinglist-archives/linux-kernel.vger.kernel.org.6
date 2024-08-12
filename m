Return-Path: <linux-kernel+bounces-283233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD394EEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DE8282D50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670F17C7CB;
	Mon, 12 Aug 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hez2GInC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319953370;
	Mon, 12 Aug 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470811; cv=none; b=FJHl9L97oYLoaj6BuC7No2JTbDCM5xn4uQ0My4Pv7uKh1Ok+b5jlTgC9MQkZX302CFDxXRNvclrddeyoZddej+j1BZ6VFFrCippfDFUqLUbhpPfQf2SFt1xi5mxP6bY+rRHeV6VCFG5/Zi6QoyQUTLTHcdgpeZrtqI06cmlKwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470811; c=relaxed/simple;
	bh=CW+JyWTtYsuhG5Gpiplg7QBsDcC745rTZaDNCynvXBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/p7eOwJPfGtS86eL8zOzF5UUvZ2F9GtCk/0FNL1oNhk6GuAIDMQrz/5UoQnLlC9M03NMf5pY1fcltLKA1vInHo+KUK6PLYGhw4No92nsfKuXo5+OHJHgAG6ZH+3Yc6NJKMZQ/UAmSQdUCxDMtADfCFv3nTx6f007DYe258OBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hez2GInC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470809; x=1755006809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CW+JyWTtYsuhG5Gpiplg7QBsDcC745rTZaDNCynvXBI=;
  b=hez2GInCC7nUv2KMw4Esstu1L343BGX7U4PyrfcMjuzEF2nHKuZVZGOT
   OCzWNcIO3BqDSH0uABFSRhYURFsxZVWGUCsZHa83P5DfftlLo7UhKtNtY
   e6fzbg+uXnidMlmw7KT6k9yJ/vHYhe3NV0CLz76s6XWYpt8YQwva62g+K
   28mx4XV4uUt4pnaS7TQczWbDN9uzdhQLoOyNF/dtSy5vC0MoQBCy4Nt3o
   +yKFFm4y7sSGZKUS4HGkZJH/P5y4QQ7xWBy2bBYgNyS5QiyvlTPw8bbJ1
   xFjwuKawhx/TC0xEQuR07ZTAHykpTWMwkwjbDm4BVaEv2kFlOPGlBxjEU
   A==;
X-CSE-ConnectionGUID: CCa8pu3sRVyU2VrCDEmycQ==
X-CSE-MsgGUID: y77NAz5oT9qwWlhxjrEBmg==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="261298128"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:53:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:58 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:56 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 7/7] ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC nodes
Date: Mon, 12 Aug 2024 16:52:31 +0300
Message-ID: <20240812135231.43744-8-andrei.simion@microchip.com>
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

Align with the datasheet by adding regulator-5v which
supplies each node from the regulator using phandle to
regulator-5v through pvin[1-4]-supply and lvin-supply.

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- drop (lvin|pvin[1-4])-supply from each regulators sub-node
- add lvin-supply, pvin[1-4]-supply to PMIC node
---
 .../boot/dts/microchip/at91-sama5d29_curiosity.dts  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 6b02b7bcfd49..951a0c97d3c6 100644
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
@@ -144,6 +152,11 @@ &i2c0 {
 	mcp16502@5b {
 		compatible = "microchip,mcp16502";
 		reg = <0x5b>;
+		lvin-supply = <&reg_5v>;
+		pvin1-supply = <&reg_5v>;
+		pvin2-supply = <&reg_5v>;
+		pvin3-supply = <&reg_5v>;
+		pvin4-supply = <&reg_5v>;
 		status = "okay";
 		lpm-gpios = <&pioBU 0 GPIO_ACTIVE_LOW>;
 
-- 
2.34.1


