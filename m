Return-Path: <linux-kernel+bounces-286427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9BC951AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6041C20E06
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A11B1402;
	Wed, 14 Aug 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HryQXZDZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A31B012C;
	Wed, 14 Aug 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638543; cv=none; b=MFIRQjmvwcbJo+DKL9fRuX+OOmk10OhIg1C33vZ+gusLImIKJS5Vd5ignNVOI6NXkMiJCtV7j1pq8m1LnOxmsx5ueNLg8z4WY6yeKIk0lqgd8LheneUthzC8orfdIAqHl13JTAOA5lKFL6BWJE3/V2ZPqrJxVn9ZOJNVy2t6Sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638543; c=relaxed/simple;
	bh=mLOlgtKR8N4/buBydiYFH5jL9U593nFfcXNp9zC3q9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7sed/T8brXaVTbsl4EqhY2efots/WXQQOuhjpNPZQ7GQ5lYbk0UlITP+TutCZt5wyoZ0PNQvgjhuK+pjmC4L+Od0apWbefUqhxfSs0rjzWI5AFMg4zWv5Uvma1EKj8L0xvKjgNWzQgdluMOTHOxW+b/lq4fbs3g486RC+RBUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HryQXZDZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723638542; x=1755174542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLOlgtKR8N4/buBydiYFH5jL9U593nFfcXNp9zC3q9A=;
  b=HryQXZDZHYltIfoO437e6z3Zv2R4Eoavhyi3AO9I7l1CywWwATbejWAh
   5J66xfug0npXSd9L3RKKxEu/k3+NLyvKyi0AoSEkhPDKEtoXw7EOOjhKI
   Gx4NJdTMP4L8W0Mx3hePUP585gPDeT9Hn/OGXRsW2z/utsOEzNVQaiNTS
   DS74Tm0IuFsce+CXCocaIaOFuknf6LfHfuQ9M0NUKDDcuWTbjSuKmcYQQ
   Ig5hEVYh5sLZiQdnjKozb8tZ/duX8TEuIyTcRN1DKcsad2AO0Bj9JerVA
   CVNXfAujXS4zdeP/4HCoUjp78ZZp51V/jnsixwokrpIbf11w2Exp/EeXQ
   w==;
X-CSE-ConnectionGUID: 4X+cfYNUS7iIAk4JdwvsDg==
X-CSE-MsgGUID: pylmEuSuTFKq5hzROma4GQ==
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="30486702"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 05:29:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 05:28:41 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 05:28:39 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <cristian.birsan@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 1/5] ARM: dts: microchip: Clean up spacing and indentation
Date: Wed, 14 Aug 2024 15:26:29 +0300
Message-ID: <20240814122633.198562-2-andrei.simion@microchip.com>
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

Checkpatch.pl reports some ERRORS related
to coding style (spacing and indentation).
So clean up : checkpatch.pl --fix-inplace

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
Split the bloated patch into small patches on topics
based on comments:
https://lore.kernel.org/linux-arm-kernel/89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev/
---
 arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts  | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 8 ++++----
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts      | 8 ++++----
 arch/arm/boot/dts/microchip/at91sam9263ek.dts         | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
index 04cb7bee937d..1279dfb38300 100644
--- a/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
+++ b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
@@ -7,7 +7,7 @@
  *			HCE Engineering
  *
  * Derived from at91sam9g35ek.dts by:
- * 	Copyright (C) 2012 Atmel,
+ *	Copyright (C) 2012 Atmel,
  *      2012 Nicolas Ferre <nicolas.ferre@atmel.com>
  */
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
index f3ffb8f01d8a..eab7efe2d5a3 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
@@ -258,10 +258,10 @@ pinctrl_i2c1_default: i2c1_default {
 				};
 
 				pinctrl_i2c1_gpio: i2c1_gpio {
-                                        pinmux = <PIN_PD4__GPIO>,
-                                                 <PIN_PD5__GPIO>;
-                                        bias-disable;
-                                };
+					pinmux = <PIN_PD4__GPIO>,
+						 <PIN_PD5__GPIO>;
+					bias-disable;
+				};
 
 
 				pinctrl_isc_base: isc_base {
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..54f5672285e4 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -407,10 +407,10 @@ pinctrl_i2c1_default: i2c1_default {
 	};
 
 	pinctrl_i2c1_gpio: i2c1_gpio {
-                pinmux = <PIN_PD19__GPIO>,
-                         <PIN_PD20__GPIO>;
-                bias-disable;
-        };
+		pinmux = <PIN_PD19__GPIO>,
+			 <PIN_PD20__GPIO>;
+		bias-disable;
+	};
 
 	pinctrl_key_gpio_default: key_gpio_default {
 		pinmux = <PIN_PD0__GPIO>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index ce8baff6a9f4..d872d9652194 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -86,7 +86,7 @@ pinctrl@fffff200 {
 				mmc0 {
 					pinctrl_board_mmc0: mmc0-board {
 						atmel,pins =
-							<AT91_PIOE 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH 	/* PE18 gpio CD pin pull up and deglitch */
+							<AT91_PIOE 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH	/* PE18 gpio CD pin pull up and deglitch */
 							 AT91_PIOE 19 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PE19 gpio WP pin pull up */
 					};
 				};
-- 
2.34.1


