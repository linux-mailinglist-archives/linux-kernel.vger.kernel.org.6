Return-Path: <linux-kernel+bounces-347485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0493098D34E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEC51F23078
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D21D0147;
	Wed,  2 Oct 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YJq2yA0a"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A61CF5FD;
	Wed,  2 Oct 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872284; cv=none; b=a5LJsnlYgPS5JlSwXFPeutia1yYtRpd0+99G9Xf7/7jhPLGbAiv/bHEgiFgzmPM6gy+e0JNHbJe/r4sJ5FT2uH+ukY0kYAC1W9KOhzJO5S+UXiAFX4KUcJ5lU+bVy4J1MSBofKpuyp9zKfAf7nCIEiVjPTMcnKsNwLLYck24zW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872284; c=relaxed/simple;
	bh=WO/smrGD3ebukNODU46ka2YZTqKp5vMEaPeLMx5s4eM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br8NyZ6yEnSIrJX6EbKPIna4pNUMDFuqsDFDlm7hIxTAxgdD7Q+I6nj+hPpNWW1bDPeBJggn/K3RUipQiJ5m58NABkxqP5FHBToLvOST0A0zRoDawrILs7aTrPOEVpZX3NpZDLy9IiEEbO/1mXSBbLq0Mmu28+aLIEXF+PdtjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YJq2yA0a; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727872282; x=1759408282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WO/smrGD3ebukNODU46ka2YZTqKp5vMEaPeLMx5s4eM=;
  b=YJq2yA0adWcApgxeykNlFVcfbRbQs7AjbSs5zMy5T9KBDo5Zm24lZnsl
   mCCFkYof0DYJW6LxZunKJ+rrIpmpugFmHykzEaeXiz/0nA2vXUy8BmW8x
   7t2pwFcSA1YZfmZgWxBlCZPr7WXa6g/SMJIaQV5B30ZP73Fg/l04Mdu15
   tQIVY4UYzBz76MgLhFrOpkiCH+SOuMwVNUN0mScPDuo6xeN6jZLct5+DG
   5lI71Y6CqoATbGqNxFl+cGeOCKFOU6wzc2WEBGkgze0De3a0ERVIveVjm
   GlyucBsywaUKgJU5GTnjAQCDLxbvFiYECY8CWvGJpsdA4oojqCBv/jr9B
   Q==;
X-CSE-ConnectionGUID: gsXlODJpTSiMie2QZcRNiA==
X-CSE-MsgGUID: GPr5NJK3SbGQKzA578Xe0w==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="33109839"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 05:31:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 05:31:00 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 2 Oct 2024 05:30:58 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v3 1/3] ARM: dts: microchip: Rename the eeprom nodename
Date: Wed, 2 Oct 2024 15:30:09 +0300
Message-ID: <20241002123010.111028-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002123010.111028-1-andrei.simion@microchip.com>
References: <20241002123010.111028-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align the eeprom nodename according to devicetree specification and
at24.yaml

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v2 -> v3:
- no change

v1 -> v2:
- adjust commit message length
---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts   | 2 +-
 arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts | 2 +-
 arch/arm/boot/dts/microchip/at91sam9260ek.dts         | 2 +-
 arch/arm/boot/dts/microchip/at91sam9263ek.dts         | 2 +-
 arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi | 2 +-
 arch/arm/boot/dts/microchip/sama5d34ek.dts            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
index 95ecb7d040a8..8ac85dac5a96 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi
@@ -106,7 +106,7 @@ i2c0: i2c@f8028000 {
 				scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
-				at24@50 {
+				eeprom@50 {
 					compatible = "atmel,24c02";
 					reg = <0x50>;
 					pagesize = <8>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
index 200b20515ab1..e4ae60ef5f8a 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts
@@ -231,7 +231,7 @@ i2c1: i2c@fc028000 {
 				scl-gpios = <&pioA PIN_PC7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
-				at24@50 {
+				eeprom@50 {
 					compatible = "atmel,24c02";
 					reg = <0x50>;
 					pagesize = <8>;
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
index 6680031387e8..4bab3f25b855 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts
@@ -411,7 +411,7 @@ i2c1: i2c@fc028000 {
 				scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 				status = "okay";
 
-				at24@54 {
+				eeprom@54 {
 					compatible = "atmel,24c02";
 					reg = <0x54>;
 					pagesize = <16>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9260ek.dts b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
index 720c15472c4a..6bd60dce8378 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9260ek.dts
@@ -165,7 +165,7 @@ button-4 {
 	i2c-gpio-0 {
 		status = "okay";
 
-		24c512@50 {
+		eeprom@50 {
 			compatible = "atmel,24c512";
 			reg = <0x50>;
 		};
diff --git a/arch/arm/boot/dts/microchip/at91sam9263ek.dts b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
index ce8baff6a9f4..bad7dbecba3c 100644
--- a/arch/arm/boot/dts/microchip/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9263ek.dts
@@ -253,7 +253,7 @@ button-right-click {
 	i2c-gpio-0 {
 		status = "okay";
 
-		24c512@50 {
+		eeprom@50 {
 			compatible = "atmel,24c512";
 			reg = <0x50>;
 			pagesize = <128>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
index 565b99e79c52..4e7cfbbd4241 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek_common.dtsi
@@ -220,7 +220,7 @@ usb0: ohci@500000 {
 	i2c-gpio-0 {
 		status = "okay";
 
-		24c512@50 {
+		eeprom@50 {
 			compatible = "atmel,24c512";
 			reg = <0x50>;
 			vcc-supply = <&reg_3v3>;
diff --git a/arch/arm/boot/dts/microchip/sama5d34ek.dts b/arch/arm/boot/dts/microchip/sama5d34ek.dts
index bffd61397cb5..18943b873fff 100644
--- a/arch/arm/boot/dts/microchip/sama5d34ek.dts
+++ b/arch/arm/boot/dts/microchip/sama5d34ek.dts
@@ -36,7 +36,7 @@ i2c0: i2c@f0014000 {
 			i2c1: i2c@f0018000 {
 				status = "okay";
 
-				24c256@50 {
+				eeprom@50 {
 					compatible = "atmel,24c256";
 					reg = <0x50>;
 					pagesize = <64>;
-- 
2.34.1


