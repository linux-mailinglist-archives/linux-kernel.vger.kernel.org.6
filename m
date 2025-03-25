Return-Path: <linux-kernel+bounces-575673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BCA7059C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76583A5AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50D251790;
	Tue, 25 Mar 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PmxVGHTh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24F18A6AB;
	Tue, 25 Mar 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918133; cv=none; b=Rn96fzV65uwe/aibVTaYAtClqTD6pYA0lQa+gwG1vi17SWo2h0rfZkz0A53T+GFoTd761dLAiqGzq+gHNFt4vjFpzOaQ9zp7hpiOt2PqDFvqJthXxNaAAOaczXES8pYf3ss9P99tsHak5zFkSJS+Zdn7r+NLiN2YQmXr4Q3vIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918133; c=relaxed/simple;
	bh=jfgSiqLCqwkZI4qYAO/dSdiUYlqbnqAIsGKA2fS7izw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqHgvtj2G+43cEwRMw07bw8SNVKpqESUBcOHL4SRgPj0KKTIpHaq52o1LOxGG/sly0JDvSsJ24OBwQOz/AyxHjEikws6IUEq5BjUCBP1h6Dtufn6A/YSL7W7srCUFsNZEHexMLOV8/2A2WXKL7s4Xp319fU3UHeXUvOo0YX3NIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PmxVGHTh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742918131; x=1774454131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfgSiqLCqwkZI4qYAO/dSdiUYlqbnqAIsGKA2fS7izw=;
  b=PmxVGHTh+d5Am8/eFdrEtYTgLwHEr6kGm25vwmL3/drOXVXNjnuQDrOn
   69/lX0zfabu5QfXGtxod3xOqiO6Ezg9SphDfV1/Crn8Kkl8WBO+WlXZiM
   Gyt9PnCSBlwdw+GC56laCfp22cv/7w/ikeK/6fZEH1tJrN6E6vE5+GImv
   KjGDhLu80MZkAJBtKU7uB7vS5VE/c/7J/gEnlknQTHVb9PYvGSnCLNIKL
   RBTWuagrSx6fy4uZpqOk3GO1BVPEm9k5Ieai6xv2nVoGRQq62MGK5rlwZ
   sAPMkOhELzpM0RI8Z6dt/8U1YQXGrzsTKAP71BYrNPt+BCQKZH2XwwKZ6
   A==;
X-CSE-ConnectionGUID: 5ZRRXf5LQVCIU2dRAgtdWw==
X-CSE-MsgGUID: ptw/juAZTZWwDMU9R8w8+g==
X-IronPort-AV: E=Sophos;i="6.14,275,1736838000"; 
   d="scan'208";a="40152236"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2025 08:55:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 08:54:54 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 25 Mar 2025 08:54:54 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>
CC: <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 4/4] ARM: dts: microchip: sama7g5: Adjust clock xtal phandle
Date: Tue, 25 Mar 2025 08:55:10 -0700
Message-ID: <95c33a95347b098bd32861a59bf6ec658c52f65d.1742916867.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742916867.git.Ryan.Wanner@microchip.com>
References: <cover.1742916867.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Adjust clock xtal phandles to match the new xtal phandle formatting.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 18 ++++++++----------
 arch/arm/boot/dts/microchip/sama7g5.dtsi       |  4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 2543599013b1..79bf58f8c02e 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -35,16 +35,6 @@ aliases {
 		i2c2 = &i2c9;
 	};
 
-	clocks {
-		slow_xtal {
-			clock-frequency = <32768>;
-		};
-
-		main_xtal {
-			clock-frequency = <24000000>;
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -512,6 +502,10 @@ spi11: spi@400 {
 	};
 };
 
+&main_xtal {
+	clock-frequency = <24000000>;
+};
+
 &gmac0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -917,3 +911,7 @@ &vddout25 {
 	vin-supply = <&vdd_3v3>;
 	status = "okay";
 };
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 17bcdcf0cf4a..250c9e98a8bb 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -117,12 +117,12 @@ map1 {
 	};
 
 	clocks {
-		slow_xtal: slow_xtal {
+		slow_xtal: clock-slowxtal {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 		};
 
-		main_xtal: main_xtal {
+		main_xtal: clock-mainxtal {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 		};
-- 
2.43.0


