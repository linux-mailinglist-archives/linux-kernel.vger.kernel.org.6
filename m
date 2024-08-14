Return-Path: <linux-kernel+bounces-286431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D423B951AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDCA1F23883
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A91B29AC;
	Wed, 14 Aug 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ovly0nob"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841811B1405;
	Wed, 14 Aug 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638547; cv=none; b=hp/+HAdn6q9Cnwc/CF0FZfDeRMKCiGDmO2GZEx6ULfrlGSqPSXBMOv0w8oftfn+hnkH53LwN/Acu1HiDULtXgQUIWRBL4cS1Eycif/7XIf+Hu5LEKBXEsgaOJxKSYscZO0V8TiEJBh7a6Lb9M0p6V92vxO2HkwJQdtPPgCMnmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638547; c=relaxed/simple;
	bh=wGBNrZAgSwNLFlDxMURocSgxExuuUV8DBTJJByC1j2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3byDbONir5PeW/x5Vpmd2J4N7RnWj+1VLvBg7PyCttpygA878sFAF+v0MBlynePembUrUNLB/UIEZJ/ihhbAVOGLgL6UpnZpEcrP5flzrd+5ZnyceGxurCDo9N4YmnY+ndtv9UmS/Z/0KFEjf8wOj2gC8cD2FgqLTFXRagFL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ovly0nob; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723638545; x=1755174545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wGBNrZAgSwNLFlDxMURocSgxExuuUV8DBTJJByC1j2Q=;
  b=ovly0nobfa0jQfCvyE0CuAsqCly/wiCCT3nbxJy/lYuADvaiQgzj8SES
   fL7VvjtZ4RN+bUyGnvzCQOYwR2CdVNikost/fbGKWm3h5zrfnm8A5D690
   GgJo+V8y8tlpb+tqgKZ9wI0RXemrgZlghbB6uKy3lBDXcavKDddgwJbFz
   G2HFTFdQ89kKgDqo7BWKL0TFSZoqukY8DFCy9RuopEzGj+Y4z3tNjgGWD
   m6M09FgDYUyveu1l1YZTmQeR7B6hKP6cMQkH1GhrI7vIhrMimk99eGV8/
   E+N/ouJPLRLl49vPaozE8AknX1BWAy6KNBN+Jpy3nnMSVcOXqER8Ru254
   A==;
X-CSE-ConnectionGUID: 4X+cfYNUS7iIAk4JdwvsDg==
X-CSE-MsgGUID: EOo2/jyrQaGxbdzSPD7gBg==
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="30486705"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 05:29:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 05:28:50 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 05:28:47 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <cristian.birsan@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 4/5] ARM: dts: microchip: Rename the usb node
Date: Wed, 14 Aug 2024 15:26:32 +0300
Message-ID: <20240814122633.198562-5-andrei.simion@microchip.com>
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

Rename the usb node according to devicetree
specification and update the label according
with the node-specific standard as: ohci, ehci
or gadget.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
Split the bloated patch into small patches on topics
based on comments:
https://lore.kernel.org/linux-arm-kernel/89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev/
---
 arch/arm/boot/dts/microchip/aks-cdu.dts                  | 4 ++--
 arch/arm/boot/dts/microchip/animeo_ip.dts                | 2 +-
 arch/arm/boot/dts/microchip/at91-ariag25.dts             | 4 ++--
 arch/arm/boot/dts/microchip/at91-ariettag25.dts          | 6 +++---
 arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts     | 6 +++---
 arch/arm/boot/dts/microchip/at91-dvk_som60.dts           | 6 +++---
 arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi      | 6 +++---
 arch/arm/boot/dts/microchip/at91-foxg20.dts              | 4 ++--
 arch/arm/boot/dts/microchip/at91-gatwick.dts             | 4 ++--
 arch/arm/boot/dts/microchip/at91-kizbox.dts              | 2 +-
 arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi     | 4 ++--
 arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts          | 6 +++---
 arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi  | 4 ++--
 arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts       | 2 +-
 arch/arm/boot/dts/microchip/at91-lmu5000.dts             | 4 ++--
 arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts    | 2 +-
 arch/arm/boot/dts/microchip/at91-q5xr5.dts               | 4 ++--
 arch/arm/boot/dts/microchip/at91-qil_a9260.dts           | 4 ++--
 arch/arm/boot/dts/microchip/at91-sam9_l9260.dts          | 2 +-
 arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts   | 6 +++---
 arch/arm/boot/dts/microchip/at91-sam9x60ek.dts           | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts    | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts  | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts  | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts         | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts      | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts    | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts         | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts    | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts    | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts    | 6 +++---
 arch/arm/boot/dts/microchip/at91-sama5d4ek.dts           | 6 +++---
 arch/arm/boot/dts/microchip/at91-som60.dtsi              | 4 ++--
 arch/arm/boot/dts/microchip/at91-tse850-3.dts            | 6 +++---
 arch/arm/boot/dts/microchip/at91-vinco.dts               | 6 +++---
 arch/arm/boot/dts/microchip/at91-wb45n.dts               | 2 +-
 arch/arm/boot/dts/microchip/at91-wb45n.dtsi              | 4 ++--
 arch/arm/boot/dts/microchip/at91-wb50n.dts               | 6 +++---
 arch/arm/boot/dts/microchip/at91-wb50n.dtsi              | 4 ++--
 arch/arm/boot/dts/microchip/at91rm9200.dtsi              | 4 ++--
 arch/arm/boot/dts/microchip/at91rm9200ek.dts             | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9260.dtsi             | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9260ek.dts            | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9261.dtsi             | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9261ek.dts            | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9263.dtsi             | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9263ek.dts            | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi    | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi             | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts         | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9n12.dtsi             | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9n12ek.dts            | 4 ++--
 arch/arm/boot/dts/microchip/at91sam9rl.dtsi              | 2 +-
 arch/arm/boot/dts/microchip/at91sam9rlek.dts             | 2 +-
 arch/arm/boot/dts/microchip/at91sam9x5.dtsi              | 6 +++---
 arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi            | 6 +++---
 arch/arm/boot/dts/microchip/ethernut5.dts                | 4 ++--
 arch/arm/boot/dts/microchip/evk-pro3.dts                 | 4 ++--
 arch/arm/boot/dts/microchip/mpa1600.dts                  | 2 +-
 arch/arm/boot/dts/microchip/pm9g45.dts                   | 4 ++--
 arch/arm/boot/dts/microchip/sam9x60.dtsi                 | 6 +++---
 arch/arm/boot/dts/microchip/sama5d2.dtsi                 | 6 +++---
 arch/arm/boot/dts/microchip/sama5d3.dtsi                 | 6 +++---
 arch/arm/boot/dts/microchip/sama5d3xmb.dtsi              | 6 +++---
 arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi          | 2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi                 | 6 +++---
 arch/arm/boot/dts/microchip/tny_a9263.dts                | 2 +-
 arch/arm/boot/dts/microchip/usb_a9260_common.dtsi        | 4 ++--
 arch/arm/boot/dts/microchip/usb_a9263.dts                | 4 ++--
 70 files changed, 158 insertions(+), 158 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
index 742fcf525e1b..52e166c8a365 100644
--- a/arch/arm/boot/dts/microchip/aks-cdu.dts
+++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
@@ -50,13 +50,13 @@ macb0: ethernet@fffc4000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 15 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/animeo_ip.dts b/arch/arm/boot/dts/microchip/animeo_ip.dts
index 29936bfbeeb7..911c8d9ee013 100644
--- a/arch/arm/boot/dts/microchip/animeo_ip.dts
+++ b/arch/arm/boot/dts/microchip/animeo_ip.dts
@@ -136,7 +136,7 @@ ubi@60000 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			atmel,vbus-gpio = <&pioB 15 GPIO_ACTIVE_LOW>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/microchip/at91-ariag25.dts b/arch/arm/boot/dts/microchip/at91-ariag25.dts
index 713d18f80356..fedcf30a924e 100644
--- a/arch/arm/boot/dts/microchip/at91-ariag25.dts
+++ b/arch/arm/boot/dts/microchip/at91-ariag25.dts
@@ -173,11 +173,11 @@ &usart3 {
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	status = "okay";
 	num-ports = <3>;
 };
 
-&usb1 {
+&ehci {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-ariettag25.dts b/arch/arm/boot/dts/microchip/at91-ariettag25.dts
index 2c52a71752c2..04a001d5c236 100644
--- a/arch/arm/boot/dts/microchip/at91-ariettag25.dts
+++ b/arch/arm/boot/dts/microchip/at91-ariettag25.dts
@@ -73,15 +73,15 @@ timer@1 {
 	};
 };
 
-&usb0 {
+&ohci {
 	num-ports = <3>;
 	status = "okay";
 };
 
-&usb1 {
+&ehci {
 	status = "okay";
 };
 
-&usb2 {
+&gadget {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
index 1279dfb38300..0e11fa5ba36c 100644
--- a/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
+++ b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
@@ -56,7 +56,7 @@ &usart2 {
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0 /* &pioD 18 GPIO_ACTIVE_LOW */
 			   &pioD 19 GPIO_ACTIVE_LOW
@@ -65,11 +65,11 @@ &pioD 20 GPIO_ACTIVE_LOW
 	status = "okay";
 };
 
-&usb1 {
+&ehci {
 	status = "okay";
 };
 
-&usb2 {
+&gadget {
 	atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-dvk_som60.dts b/arch/arm/boot/dts/microchip/at91-dvk_som60.dts
index ededd5b0d27b..cfb8b6586eb5 100644
--- a/arch/arm/boot/dts/microchip/at91-dvk_som60.dts
+++ b/arch/arm/boot/dts/microchip/at91-dvk_som60.dts
@@ -81,15 +81,15 @@ &macb1 {
 	status = "okay";
 };
 
-&usb0 {
+&gadget {
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi
index 3542ad8a243e..32c9c37a4a5c 100644
--- a/arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi
@@ -145,15 +145,15 @@ ethernet-phy@1 {
 	};
 };
 
-&usb0 {
+&gadget{
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-foxg20.dts b/arch/arm/boot/dts/microchip/at91-foxg20.dts
index 9dfd5de808d1..506703cd9691 100644
--- a/arch/arm/boot/dts/microchip/at91-foxg20.dts
+++ b/arch/arm/boot/dts/microchip/at91-foxg20.dts
@@ -45,7 +45,7 @@ timer@2 {
 				};
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 6 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -131,7 +131,7 @@ watchdog@fffffd40 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/at91-gatwick.dts b/arch/arm/boot/dts/microchip/at91-gatwick.dts
index 551300fd7746..f036c6a5821b 100644
--- a/arch/arm/boot/dts/microchip/at91-gatwick.dts
+++ b/arch/arm/boot/dts/microchip/at91-gatwick.dts
@@ -111,11 +111,11 @@ spidev@0 {
 	};
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 	/delete-property/atmel,oc-gpio;
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-kizbox.dts b/arch/arm/boot/dts/microchip/at91-kizbox.dts
index 307663b4eec2..984ff0db4d8e 100644
--- a/arch/arm/boot/dts/microchip/at91-kizbox.dts
+++ b/arch/arm/boot/dts/microchip/at91-kizbox.dts
@@ -175,7 +175,7 @@ &watchdog {
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	num-ports = <1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
index a44d92305dbb..6ccf4b94abe3 100644
--- a/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi
@@ -223,11 +223,11 @@ ubi@20000 {
 	};
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts b/arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts
index fec7269088d1..fa0a0d884111 100644
--- a/arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts
+++ b/arch/arm/boot/dts/microchip/at91-kizbox3-hs.dts
@@ -296,14 +296,14 @@ i2c6: i2c@600 {
 	};
 };
 
-&usb0 {
+&gadget {
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi b/arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi
index 42640fe6b6d0..ebf92ba1d66c 100644
--- a/arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-kizboxmini-common.dtsi
@@ -157,12 +157,12 @@ ubi@20000 {
 	};
 };
 
-&usb0 {
+&ohci {
 	num-ports = <1>;
 	status = "okay";
 };
 
-&usb1 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts b/arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts
index c07d3076a9bc..914261d31a2a 100644
--- a/arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts
+++ b/arch/arm/boot/dts/microchip/at91-kizboxmini-mb.dts
@@ -13,7 +13,7 @@ / {
 		     "atmel,at91sam9x5", "atmel,at91sam9";
 };
 
-&usb0 {
+&ohci {
 	num-ports = <2>;
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-lmu5000.dts b/arch/arm/boot/dts/microchip/at91-lmu5000.dts
index f8863d7c0798..04a743cb646d 100644
--- a/arch/arm/boot/dts/microchip/at91-lmu5000.dts
+++ b/arch/arm/boot/dts/microchip/at91-lmu5000.dts
@@ -130,12 +130,12 @@ &usart2 {
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	num-ports = <2>;
 	status = "okay";
 };
 
-&usb1 {
+&gadget {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1_vbus_gpio>;
 	atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
index f71377c9b757..b6767f8a8285 100644
--- a/arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
@@ -297,7 +297,7 @@ &dbgu {
 	atmel,use-dma-rx;
 };
 
-&usb0 {
+&gadget {
 	status = "okay";
 
 	atmel,vbus-gpio = <&pioD 28 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/microchip/at91-q5xr5.dts b/arch/arm/boot/dts/microchip/at91-q5xr5.dts
index 9cf60b6f695c..8d91810b2b42 100644
--- a/arch/arm/boot/dts/microchip/at91-q5xr5.dts
+++ b/arch/arm/boot/dts/microchip/at91-q5xr5.dts
@@ -167,12 +167,12 @@ &pinctrl_usart0_dcd
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	num-ports = <2>;
 	status = "okay";
 };
 
-&usb1 {
+&gadget {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-qil_a9260.dts b/arch/arm/boot/dts/microchip/at91-qil_a9260.dts
index 5ccb3c139592..51451cd24f26 100644
--- a/arch/arm/boot/dts/microchip/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/microchip/at91-qil_a9260.dts
@@ -42,7 +42,7 @@ timer@2 {
 				};
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -114,7 +114,7 @@ shdwc: poweroff@fffffd10 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/at91-sam9_l9260.dts b/arch/arm/boot/dts/microchip/at91-sam9_l9260.dts
index 2fb51b9aca2a..907c4ff1334b 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9_l9260.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9_l9260.dts
@@ -105,7 +105,7 @@ nand0: nand@40000000 {
 			status = "okay";
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index b9ffd9e5faac..74de7777d08b 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -482,14 +482,14 @@ timer1: timer@1 {
 	};
 };
 
-&usb0 {
+&gadget {
 	atmel,vbus-gpio = <&pioA 27 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
 			   &pioD 18 GPIO_ACTIVE_HIGH
@@ -499,7 +499,7 @@ &pioD 18 GPIO_ACTIVE_HIGH
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
index 3b38707d736e..b9a21f9f9a6d 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
@@ -641,14 +641,14 @@ timer1: timer@1 {
 	};
 };
 
-&usb0 {
+&gadget {
 	atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
 			   &pioD 15 GPIO_ACTIVE_HIGH
@@ -658,7 +658,7 @@ &pioD 15 GPIO_ACTIVE_HIGH
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
index eab7efe2d5a3..8a9207cb8e08 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
@@ -30,14 +30,14 @@ chosen {
 	};
 
 	ahb {
-		usb0: gadget@300000 {
+		gadget: usb@300000 {
 			atmel,vbus-gpio = <&pioA PIN_PD20 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@400000 {
+		ohci: usb@400000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0 /* &pioA PIN_PD20 GPIO_ACTIVE_HIGH */
 					   &pioA PIN_PA27 GPIO_ACTIVE_HIGH
@@ -48,7 +48,7 @@ &pioA PIN_PA27 GPIO_ACTIVE_HIGH
 			status = "okay";
 		};
 
-		usb2: ehci@500000 {
+		ehci: usb@500000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
index 15239834d886..bd09d21ec4d2 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
@@ -239,14 +239,14 @@ &uart3 {
 	status = "okay";
 };
 
-&usb0 {
+&gadget {
 	atmel,vbus-gpio = <&pioA PIN_PA16 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
 			   &pioA PIN_PA10 GPIO_ACTIVE_HIGH
@@ -257,7 +257,7 @@ &pioA PIN_PA10 GPIO_ACTIVE_HIGH
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	phy_type = "hsic";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
index 412cc65472ff..66eef92d7f7a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -574,14 +574,14 @@ &uart4 {
 	status = "okay";
 };
 
-&usb0 {
+&gadget {
 	atmel,vbus-gpio = <&pioA PIN_PB13 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0
 			   &pioA PIN_PA6 GPIO_ACTIVE_HIGH
@@ -591,7 +591,7 @@ &pioA PIN_PA6 GPIO_ACTIVE_HIGH
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index e4648682c994..50186626fd3b 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -766,21 +766,21 @@ &uart3 {
 	status = "okay";
 };
 
-&usb0 {
+&gadget {
 	atmel,vbus-gpio = <&pioA PIN_PD23 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	num-ports = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb_default>;
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	phy_type = "hsic";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
index e4ae60ef5f8a..117d049191a5 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
@@ -40,14 +40,14 @@ main_xtal {
 	};
 
 	ahb {
-		usb0: gadget@300000 {
+		gadget: usb@300000 {
 			atmel,vbus-gpio = <&pioA PIN_PB11 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@400000 {
+		ohci: usb@400000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0
 					   &pioA PIN_PB12 GPIO_ACTIVE_HIGH
@@ -58,7 +58,7 @@ &pioA PIN_PB12 GPIO_ACTIVE_HIGH
 			status = "okay";
 		};
 
-		usb2: ehci@500000 {
+		ehci: usb@500000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 4bab3f25b855..ae3b7842deb4 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -39,14 +39,14 @@ main_xtal {
 	};
 
 	ahb {
-		usb0: gadget@300000 {
+		gadget: usb@300000 {
 			atmel,vbus-gpio = <&pioA PIN_PA31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@400000 {
+		ohci: usb@400000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0 /* &pioA PIN_PB9 GPIO_ACTIVE_HIGH */
 					   &pioA PIN_PB10 GPIO_ACTIVE_HIGH
@@ -57,7 +57,7 @@ &pioA PIN_PB10 GPIO_ACTIVE_HIGH
 			status = "okay";
 		};
 
-		usb2: ehci@500000 {
+		ehci: usb@500000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
index c287b03d768b..189f1b3ae24d 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
@@ -284,14 +284,14 @@ timer1: timer@1 {
 	};
 };
 
-&usb0 {	/* USB Device port with VBUS detection. */
+&gadget {/* USB Device port with VBUS detection. */
 	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	status = "okay";
 };
 
-&usb1 {	/* 3-port Host. First port is unused. */
+&ohci {	/* 3-port Host. First port is unused. */
 	atmel,vbus-gpio = <0
 			   &pioE 3 GPIO_ACTIVE_HIGH
 			   &pioE 4 GPIO_ACTIVE_HIGH
@@ -302,6 +302,6 @@ &pioE 4 GPIO_ACTIVE_HIGH
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
index b66570080894..b44d15c9cc19 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
@@ -175,7 +175,7 @@ timer1: timer@1 {
 	};
 };
 
-&usb0 {
+&gadget {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
index 5662992cf213..35ece73a1a03 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts
@@ -276,14 +276,14 @@ pinctrl_vcc_mmc0_reg_gpio: vcc_mmc0_reg_gpio_default {
 			};
 		};
 
-		usb0: gadget@500000 {
+		gadget: usb@500000 {
 			atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;	/* PE9, conflicts with A9 */
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@600000 {
+		ohci: usb@600000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0
 					   &pioE 3 GPIO_ACTIVE_LOW
@@ -294,7 +294,7 @@ &pioE 4 GPIO_ACTIVE_LOW
 			status = "okay";
 		};
 
-		usb2: ehci@700000 {
+		ehci: usb@700000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts
index 8adf567f2f0f..ec7dfb03dce1 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d4_ma5d4evk.dts
@@ -15,14 +15,14 @@ chosen {
 	};
 
 	ahb {
-		usb0: gadget@400000 {
+		gadget: usb@400000 {
 			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0
 					   &pioE 11 GPIO_ACTIVE_LOW
@@ -31,7 +31,7 @@ &pioE 14 GPIO_ACTIVE_LOW
 			status = "okay";
 		};
 
-		usb2: ehci@600000 {
+		ehci: usb@600000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
index 95d701d13fef..ae64182d0264 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts
@@ -157,14 +157,14 @@ pinctrl_vcc_mmc1_reg: vcc_mmc1_reg {
 			};
 		};
 
-		usb0: gadget@400000 {
+		gadget: usb@400000 {
 			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0
 					   &pioE 11 GPIO_ACTIVE_HIGH
@@ -175,7 +175,7 @@ &pioE 14 GPIO_ACTIVE_HIGH
 			status = "okay";
 		};
 
-		usb2: ehci@600000 {
+		ehci: usb@600000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
index 20ac775059ca..35296dbb7a39 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d4ek.dts
@@ -191,14 +191,14 @@ pinctrl_mxt_ts: mxt_irq {
 			};
 		};
 
-		usb0: gadget@400000 {
+		gadget: usb@400000 {
 			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0 /* &pioE 10 GPIO_ACTIVE_LOW */
 					   &pioE 11 GPIO_ACTIVE_LOW
@@ -207,7 +207,7 @@ &pioE 12 GPIO_ACTIVE_LOW
 			status = "okay";
 		};
 
-		usb2: ehci@600000 {
+		ehci: usb@600000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/microchip/at91-som60.dtsi b/arch/arm/boot/dts/microchip/at91-som60.dtsi
index 39474a112b16..1c649e0e995f 100644
--- a/arch/arm/boot/dts/microchip/at91-som60.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-som60.dtsi
@@ -211,13 +211,13 @@ ubi@e0000 {
 	};
 };
 
-&usb0 {
+&gadget {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 	atmel,vbus-gpio = <&pioC 14 GPIO_ACTIVE_HIGH>;
 };
 
-&usb1 {
+&ohci {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb_vbus &pinctrl_usb_oc>;
 	num-ports = <3>;
diff --git a/arch/arm/boot/dts/microchip/at91-tse850-3.dts b/arch/arm/boot/dts/microchip/at91-tse850-3.dts
index 9d58a3931207..5bab12604dfa 100644
--- a/arch/arm/boot/dts/microchip/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/microchip/at91-tse850-3.dts
@@ -275,7 +275,7 @@ phy0: ethernet-phy@3 {
 	};
 };
 
-&usb0 {
+&gadget {
 	status = "okay";
 
 	pinctrl-names = "default";
@@ -283,7 +283,7 @@ &usb0 {
 	atmel,vbus-gpio = <&pioC 31 GPIO_ACTIVE_HIGH>;
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 
 	num-ports = <1>;
@@ -291,7 +291,7 @@ &usb1 {
 	atmel,oc-gpio = <&pioC 15 GPIO_ACTIVE_LOW>;
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-vinco.dts b/arch/arm/boot/dts/microchip/at91-vinco.dts
index ecbdacf48708..5e025f3be1b6 100644
--- a/arch/arm/boot/dts/microchip/at91-vinco.dts
+++ b/arch/arm/boot/dts/microchip/at91-vinco.dts
@@ -155,14 +155,14 @@ pinctrl_usba_vbus: usba_vbus {
 			};
 		};
 
-		usb0: gadget@400000 {
+		gadget: usb@400000 {
 			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "disabled";
 		};
 
-		usb1: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <0
 					   &pioE 11 GPIO_ACTIVE_LOW
@@ -171,7 +171,7 @@ &pioE 12 GPIO_ACTIVE_LOW
 			status = "disabled";
 		};
 
-		usb2: ehci@600000 {
+		ehci: usb@600000 {
 			/* 4G Modem */
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/at91-wb45n.dts b/arch/arm/boot/dts/microchip/at91-wb45n.dts
index ef73f727f7bd..6b8f02b4aebe 100644
--- a/arch/arm/boot/dts/microchip/at91-wb45n.dts
+++ b/arch/arm/boot/dts/microchip/at91-wb45n.dts
@@ -28,7 +28,7 @@ &watchdog {
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-wb45n.dtsi b/arch/arm/boot/dts/microchip/at91-wb45n.dtsi
index 430c75358086..9299e7fe4990 100644
--- a/arch/arm/boot/dts/microchip/at91-wb45n.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-wb45n.dtsi
@@ -121,7 +121,7 @@ logs@7fa0000 {
 	};
 };
 
-&usb0 {
+&ohci {
 	num-ports = <2>;
 	atmel,vbus-gpio = <
 		&pioB 12 GPIO_ACTIVE_HIGH
@@ -138,7 +138,7 @@ &spi0 {
 	cs-gpios = <&pioA 14 0>, <&pioA 7 0>, <0>, <0>;
 };
 
-&usb2 {
+&gadget {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_board_usb2>;
 	atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/microchip/at91-wb50n.dts b/arch/arm/boot/dts/microchip/at91-wb50n.dts
index ec2becf6133b..d5480b9e5342 100644
--- a/arch/arm/boot/dts/microchip/at91-wb50n.dts
+++ b/arch/arm/boot/dts/microchip/at91-wb50n.dts
@@ -88,15 +88,15 @@ &spi1 {
 	status = "okay";
 };
 
-&usb0 {
+&gadget {
 	status = "okay";
 };
 
-&usb1 {
+&ohci {
 	status = "okay";
 };
 
-&usb2 {
+&ehci {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/microchip/at91-wb50n.dtsi b/arch/arm/boot/dts/microchip/at91-wb50n.dtsi
index 74b249bb6351..280ef9b98a71 100644
--- a/arch/arm/boot/dts/microchip/at91-wb50n.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-wb50n.dtsi
@@ -181,13 +181,13 @@ user@6ae0000 {
 	};
 };
 
-&usb0 {
+&gadget {
 	atmel,vbus-gpio = <&pioB 13 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
 };
 
-&usb1 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <&pioA 2 GPIO_ACTIVE_LOW>;
 	atmel,oc-gpio = <&pioA 4 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/microchip/at91rm9200.dtsi b/arch/arm/boot/dts/microchip/at91rm9200.dtsi
index 16c675e3a890..bbb7bdc152be 100644
--- a/arch/arm/boot/dts/microchip/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/microchip/at91rm9200.dtsi
@@ -662,7 +662,7 @@ usart3: serial@fffcc000 {
 				status = "disabled";
 			};
 
-			usb1: gadget@fffb0000 {
+			gadget: usb@fffb0000 {
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffb0000 0x4000>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -702,7 +702,7 @@ &pioB 1 GPIO_ACTIVE_HIGH
 			status = "disabled";
 		};
 
-		usb0: ohci@300000 {
+		ohci: usb@300000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00300000 0x100000>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91rm9200ek.dts b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
index 4624a6f076f8..3089912dd6be 100644
--- a/arch/arm/boot/dts/microchip/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/microchip/at91rm9200ek.dts
@@ -43,7 +43,7 @@ timer@2 {
 				};
 			};
 
-			usb1: gadget@fffb0000 {
+			gadget: usb@fffb0000 {
 				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
 				atmel,pullup-gpio = <&pioD 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
@@ -89,7 +89,7 @@ rtc: rtc@fffffe00 {
 			};
 		};
 
-		usb0: ohci@300000 {
+		ohci: usb@300000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9260.dtsi b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
index e56d5546554c..1ba88aded4ca 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
@@ -637,7 +637,7 @@ macb0: ethernet@fffc4000 {
 				status = "disabled";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				compatible = "atmel,at91sam9260-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -742,7 +742,7 @@ gpbr: syscon@fffffd50 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9260ek.dts b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
index 6bd60dce8378..ed259e2cb853 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
@@ -45,7 +45,7 @@ timer@2 {
 				};
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -131,7 +131,7 @@ gpbr: syscon@fffffd50 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9261.dtsi b/arch/arm/boot/dts/microchip/at91sam9261.dtsi
index 307b60658014..6492f6a88879 100644
--- a/arch/arm/boot/dts/microchip/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9261.dtsi
@@ -77,7 +77,7 @@ ahb {
 		#size-cells = <1>;
 		ranges;
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -142,7 +142,7 @@ tcb0: timer@fffa0000 {
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				compatible = "atmel,at91sam9261-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9261ek.dts b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
index 045cb253f23a..4d9269cc5f32 100644
--- a/arch/arm/boot/dts/microchip/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9261ek.dts
@@ -31,7 +31,7 @@ main_xtal {
 	};
 
 	ahb {
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			status = "okay";
 		};
 
@@ -136,7 +136,7 @@ timer1: timer@2 {
 				};
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioB 29 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/microchip/at91sam9263.dtsi b/arch/arm/boot/dts/microchip/at91sam9263.dtsi
index 75d8ff2d12c8..a6c2ba5ce7d4 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9263.dtsi
@@ -636,7 +636,7 @@ macb0: ethernet@fffbc000 {
 				status = "disabled";
 			};
 
-			usb1: gadget@fff78000 {
+			gadget: usb@fff78000 {
 				compatible = "atmel,at91sam9263-udc";
 				reg = <0xfff78000 0x4000>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -768,7 +768,7 @@ fb0: fb@700000 {
 			status = "disabled";
 		};
 
-		usb0: ohci@a00000 {
+		ohci: usb@a00000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00a00000 0x100000>;
 			interrupts = <29 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index ecf4960c88fa..a8ea36db4c04 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -61,7 +61,7 @@ macb0: ethernet@fffbc000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fff78000 {
+			gadget: usb@fff78000 {
 				atmel,vbus-gpio = <&pioA 25 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -207,7 +207,7 @@ data@7ca0000 {
 			};
 		};
 
-		usb0: ohci@a00000 {
+		ohci: usb@a00000 {
 			num-ports = <2>;
 			status = "okay";
 			atmel,vbus-gpio = <&pioA 24 GPIO_ACTIVE_HIGH
diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
index 4e7cfbbd4241..1ca5227bfae2 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
@@ -90,7 +90,7 @@ macb0: ethernet@fffc4000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				pinctrl-0 = <&pinctrl_usb1_vbus_gpio>;
 				pinctrl-names = "default";
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
@@ -211,7 +211,7 @@ data@7ca0000 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
index 325c63a53118..40a34fe95a19 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
@@ -913,7 +913,7 @@ spi1: spi@fffa8000 {
 				status = "disabled";
 			};
 
-			usb2: gadget@fff78000 {
+			gadget: usb@fff78000 {
 				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00600000 0x80000
 				       0xfff78000 0x400>;
@@ -964,7 +964,7 @@ fb0: fb@500000 {
 			status = "disabled";
 		};
 
-		usb0: ohci@700000 {
+		ohci: usb@700000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -973,7 +973,7 @@ usb0: ohci@700000 {
 			status = "disabled";
 		};
 
-		usb1: ehci@800000 {
+		ehci: usb@800000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00800000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts b/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
index 071db4f16313..dbcc243dafe8 100644
--- a/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
@@ -174,7 +174,7 @@ flash@0 {
 				};
 			};
 
-			usb2: gadget@fff78000 {
+			gadget: usb@fff78000 {
 				atmel,vbus-gpio = <&pioB 19 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -303,14 +303,14 @@ data@4000000 {
 			};
 		};
 
-		usb0: ohci@700000 {
+		ohci: usb@700000 {
 			status = "okay";
 			num-ports = <2>;
 			atmel,vbus-gpio = <&pioD 1 GPIO_ACTIVE_LOW
 					   &pioD 3 GPIO_ACTIVE_LOW>;
 		};
 
-		usb1: ehci@800000 {
+		ehci: usb@800000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/microchip/at91sam9n12.dtsi b/arch/arm/boot/dts/microchip/at91sam9n12.dtsi
index 8dc04e9031a6..0ada88b307d2 100644
--- a/arch/arm/boot/dts/microchip/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9n12.dtsi
@@ -738,7 +738,7 @@ pwm0: pwm@f8034000 {
 				status = "disabled";
 			};
 
-			usb1: gadget@f803c000 {
+			gadget: usb@f803c000 {
 				compatible = "atmel,at91sam9260-udc";
 				reg = <0xf803c000 0x4000>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -748,7 +748,7 @@ usb1: gadget@f803c000 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x00100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9n12ek.dts b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
index 643c3b2ab97e..734975137ef9 100644
--- a/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9n12ek.dts
@@ -142,7 +142,7 @@ hlcdc_panel_output: endpoint@0 {
 				};
 			};
 
-			usb1: gadget@f803c000 {
+			gadget: usb@f803c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usb1_vbus_sense>;
 				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
@@ -180,7 +180,7 @@ nand@3 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <1>;
 			atmel,vbus-gpio = <&pioB 7 GPIO_ACTIVE_LOW>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/microchip/at91sam9rl.dtsi b/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
index 7436b5c862b1..406696600b51 100644
--- a/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
@@ -282,7 +282,7 @@ adc0: adc@fffd0000 {
 				atmel,adc-startup-time = <40>;
 			};
 
-			usb0: gadget@fffd4000 {
+			gadget: usb@fffd4000 {
 				compatible = "atmel,at91sam9rl-udc";
 				reg = <0x00600000 0x100000>,
 				      <0xfffd4000 0x4000>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9rlek.dts b/arch/arm/boot/dts/microchip/at91sam9rlek.dts
index a57351270551..ca6b035c4301 100644
--- a/arch/arm/boot/dts/microchip/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9rlek.dts
@@ -172,7 +172,7 @@ &pinctrl_adc0_ad5
 				status = "okay";
 			};
 
-			usb0: gadget@fffd4000 {
+			gadget: usb@fffd4000 {
 				atmel,vbus-gpio = <&pioA 8 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/microchip/at91sam9x5.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
index a7456c2191fa..9f5e13296294 100644
--- a/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
@@ -847,7 +847,7 @@ spi1: spi@f0004000 {
 				status = "disabled";
 			};
 
-			usb2: gadget@f803c000 {
+			gadget: usb@f803c000 {
 				compatible = "atmel,at91sam9g45-udc";
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
@@ -886,7 +886,7 @@ pwm0: pwm@f8034000 {
 			};
 		};
 
-		usb0: ohci@600000 {
+		ohci: usb@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -895,7 +895,7 @@ usb0: ohci@600000 {
 			status = "disabled";
 		};
 
-		usb1: ehci@700000 {
+		ehci: usb@700000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi
index 9618b8d965b0..f489397458b4 100644
--- a/arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9x5ek.dtsi
@@ -144,7 +144,7 @@ &usart0 {
 	status = "okay";
 };
 
-&usb0 {
+&ohci {
 	num-ports = <3>;
 	atmel,vbus-gpio = <0 /* &pioD 18 GPIO_ACTIVE_LOW *//* Activate to have access to port A */
 			   &pioD 19 GPIO_ACTIVE_LOW
@@ -153,11 +153,11 @@ &pioD 20 GPIO_ACTIVE_LOW
 	status = "okay";
 };
 
-&usb1 {
+&ehci {
 	status = "okay";
 };
 
-&usb2 {
+&gadget {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_board_usb2>;
 	atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/microchip/ethernut5.dts b/arch/arm/boot/dts/microchip/ethernut5.dts
index ad7a0850252a..fcc75c522897 100644
--- a/arch/arm/boot/dts/microchip/ethernut5.dts
+++ b/arch/arm/boot/dts/microchip/ethernut5.dts
@@ -60,7 +60,7 @@ macb0: ethernet@fffc4000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -101,7 +101,7 @@ data@20000 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/evk-pro3.dts b/arch/arm/boot/dts/microchip/evk-pro3.dts
index 6d519d02d190..1bcb350ec2bd 100644
--- a/arch/arm/boot/dts/microchip/evk-pro3.dts
+++ b/arch/arm/boot/dts/microchip/evk-pro3.dts
@@ -35,7 +35,7 @@ usart2: serial@fffb8000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -45,7 +45,7 @@ watchdog@fffffd40 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/mpa1600.dts b/arch/arm/boot/dts/microchip/mpa1600.dts
index 005c2758e229..96489d568f5d 100644
--- a/arch/arm/boot/dts/microchip/mpa1600.dts
+++ b/arch/arm/boot/dts/microchip/mpa1600.dts
@@ -57,7 +57,7 @@ ssc1: ssc@fffd4000 {
 			};
 		};
 
-		usb0: ohci@300000 {
+		ohci: usb@300000 {
 			num-ports = <1>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/pm9g45.dts b/arch/arm/boot/dts/microchip/pm9g45.dts
index c349fd3758a6..202ead5ff464 100644
--- a/arch/arm/boot/dts/microchip/pm9g45.dts
+++ b/arch/arm/boot/dts/microchip/pm9g45.dts
@@ -139,12 +139,12 @@ data@900000 {
 			};
 		};
 
-		usb0: ohci@700000 {
+		ohci: usb@700000 {
 			status = "okay";
 			num-ports = <2>;
 		};
 
-		usb1: ehci@800000 {
+		ehci: usb@800000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 551b46894f47..f4f654696c65 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -74,7 +74,7 @@ ahb {
 		#size-cells = <1>;
 		ranges;
 
-		usb0: gadget@500000 {
+		gadget: usb@500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "microchip,sam9x60-udc";
@@ -88,7 +88,7 @@ usb0: gadget@500000 {
 			status = "disabled";
 		};
 
-		usb1: ohci@600000 {
+		ohci: usb@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -97,7 +97,7 @@ usb1: ohci@600000 {
 			status = "disabled";
 		};
 
-		usb2: ehci@700000 {
+		ehci: usb@700000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index 5f8e297e19ed..e00bcdfa061b 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -126,7 +126,7 @@ nfc_sram: sram@100000 {
 
 		};
 
-		usb0: gadget@300000 {
+		gadget: usb@300000 {
 			compatible = "atmel,sama5d3-udc";
 			reg = <0x00300000 0x100000
 			       0xfc02c000 0x400>;
@@ -136,7 +136,7 @@ usb0: gadget@300000 {
 			status = "disabled";
 		};
 
-		usb1: ohci@400000 {
+		ohci: usb@400000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00400000 0x100000>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -145,7 +145,7 @@ usb1: ohci@400000 {
 			status = "disabled";
 		};
 
-		usb2: ehci@500000 {
+		ehci: usb@500000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/sama5d3.dtsi b/arch/arm/boot/dts/microchip/sama5d3.dtsi
index d4fc0c1dfc10..ac179e5820a8 100644
--- a/arch/arm/boot/dts/microchip/sama5d3.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3.dtsi
@@ -1064,7 +1064,7 @@ nfc_sram: sram@200000 {
 			ranges = <0 0x200000 0x2400>;
 		};
 
-		usb0: gadget@500000 {
+		gadget: usb@500000 {
 			compatible = "atmel,sama5d3-udc";
 			reg = <0x00500000 0x100000
 			       0xf8030000 0x4000>;
@@ -1074,7 +1074,7 @@ usb0: gadget@500000 {
 			status = "disabled";
 		};
 
-		usb1: ohci@600000 {
+		ohci: usb@600000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -1083,7 +1083,7 @@ usb1: ohci@600000 {
 			status = "disabled";
 		};
 
-		usb2: ehci@700000 {
+		ehci: usb@700000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/sama5d3xmb.dtsi b/arch/arm/boot/dts/microchip/sama5d3xmb.dtsi
index 3652c9e24124..c4afdf729337 100644
--- a/arch/arm/boot/dts/microchip/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3xmb.dtsi
@@ -165,14 +165,14 @@ watchdog@fffffe40 {
 			};
 		};
 
-		usb0: gadget@500000 {
+		gadget: usb@500000 {
 			atmel,vbus-gpio = <&pioD 29 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
 			status = "okay";
 		};
 
-		usb1: ohci@600000 {
+		ohci: usb@600000 {
 			num-ports = <3>;
 			atmel,vbus-gpio = <&pioD 25 GPIO_ACTIVE_HIGH
 					   &pioD 26 GPIO_ACTIVE_LOW
@@ -181,7 +181,7 @@ &pioD 27 GPIO_ACTIVE_LOW
 			status = "okay";
 		};
 
-		usb2: ehci@700000 {
+		ehci: usb@700000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi
index 5d9e97fecf83..47b889f7e77b 100644
--- a/arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi
@@ -216,7 +216,7 @@ watchdog@fffffe40 {
 			};
 		};
 
-		usb0: gadget@500000 {
+		gadget: usb@500000 {
 			atmel,vbus-gpio = <&pioD 29 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
index 58ceed997889..58cd45a5758e 100644
--- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
@@ -109,7 +109,7 @@ vdec0: vdec@300000 {
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
 		};
 
-		usb0: gadget@400000 {
+		gadget: usb@400000 {
 			compatible = "atmel,sama5d3-udc";
 			reg = <0x00400000 0x100000
 			       0xfc02c000 0x4000>;
@@ -119,7 +119,7 @@ usb0: gadget@400000 {
 			status = "disabled";
 		};
 
-		usb1: ohci@500000 {
+		ohci: usb@500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH 2>;
@@ -128,7 +128,7 @@ usb1: ohci@500000 {
 			status = "disabled";
 		};
 
-		usb2: ehci@600000 {
+		ehci: usb@600000 {
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH 2>;
diff --git a/arch/arm/boot/dts/microchip/tny_a9263.dts b/arch/arm/boot/dts/microchip/tny_a9263.dts
index 62b7d9f9a926..f788bf61ae72 100644
--- a/arch/arm/boot/dts/microchip/tny_a9263.dts
+++ b/arch/arm/boot/dts/microchip/tny_a9263.dts
@@ -47,7 +47,7 @@ timer@2 {
 				};
 			};
 
-			usb1: gadget@fff78000 {
+			gadget: usb@fff78000 {
 				atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/microchip/usb_a9260_common.dtsi b/arch/arm/boot/dts/microchip/usb_a9260_common.dtsi
index 8744b5f6f792..997555441a9a 100644
--- a/arch/arm/boot/dts/microchip/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/microchip/usb_a9260_common.dtsi
@@ -39,7 +39,7 @@ macb0: ethernet@fffc4000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fffa4000 {
+			gadget: usb@fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -111,7 +111,7 @@ data@7ca0000 {
 			};
 		};
 
-		usb0: ohci@500000 {
+		ohci: usb@500000 {
 			num-ports = <2>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/microchip/usb_a9263.dts b/arch/arm/boot/dts/microchip/usb_a9263.dts
index 45745915b2e1..73458f2e5216 100644
--- a/arch/arm/boot/dts/microchip/usb_a9263.dts
+++ b/arch/arm/boot/dts/microchip/usb_a9263.dts
@@ -52,7 +52,7 @@ macb0: ethernet@fffbc000 {
 				status = "okay";
 			};
 
-			usb1: gadget@fff78000 {
+			gadget: usb@fff78000 {
 				atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
@@ -139,7 +139,7 @@ data@7ca0000 {
 			};
 		};
 
-		usb0: ohci@a00000 {
+		ohci: usb@a00000 {
 			num-ports = <2>;
 			status = "okay";
 		};
-- 
2.34.1


