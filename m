Return-Path: <linux-kernel+bounces-346237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF69098C193
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F351C242CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96791C9EC9;
	Tue,  1 Oct 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vQxGIm96"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744D199FA2;
	Tue,  1 Oct 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796421; cv=none; b=lDQpdMfKtFwkEBzxrkVGKjdVUzHwfbnS04TuzcX/xGnWABXGcEUCk49hZpu4o444+r9VPow0T8hTcZp3egI2sC2c2jA3cQXDsSUKnSM1tqzPiMSrP2EPOvvr/RcO7lRr9HHi1CGKVu1dQVbpjdb2PWq6SZaZwjDflSu466jh+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796421; c=relaxed/simple;
	bh=1CS7IXXxhzCsaOS2yUbRx7snP+l4ECpOpnDYr7z3/x0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7jHmG4MGSDoI7f+B4hO5VEXFrwi1V+c97ZvB+xwsmav8GRjiW3A6LsC7AXdqNAtuEVHwBCmAF38TEhm6pcMW8QlSEgUIj4mdeJ887sQ70Qv8bFV0bAEH9GMN7K7uZN7vOfN3T6keDqQHXhfPI8c7EDK+w6Y3F3CMp7kE422ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vQxGIm96; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727796419; x=1759332419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1CS7IXXxhzCsaOS2yUbRx7snP+l4ECpOpnDYr7z3/x0=;
  b=vQxGIm96AuK4i2jpmocNHC0Ib8nssCOifkOC5iQXNjLwKPjRGQPPTFga
   dP2qQd65JKAyoUjp+hpq1JrxPARxCxFyjKNhqrMDDUxrnF9rZ8lZ+8+Pt
   OQhlx9+YGwaHD7fLzX1J2IJj9klqRs2ey1E4ob+XssmEotoG5HJ/JM1Jw
   o/Mwk16YdjgGaLkG2pumYyc307sN/QhU/WDbGcKMIim+8bSekqqf7wVEU
   qeRb2mJGeXsoK2D7hp9raWxWstLgXT10QoCbS2Vdfg6SdJlfC6ZFJUvM/
   wR35BmQqAy1hfiLwxOLdSuccmR28ZtYz25uPHd2PUUcNvDTy8GGY/n665
   g==;
X-CSE-ConnectionGUID: C4iJhjyxTv2OpDXExwgrvQ==
X-CSE-MsgGUID: JxhGita2T7CwsJ2FUh7IEA==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="35727105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 08:26:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 08:26:38 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 08:26:34 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 1/4] ARM: dts: microchip: Rename the eeprom nodename
Date: Tue, 1 Oct 2024 18:25:38 +0300
Message-ID: <20241001152541.91945-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001152541.91945-1-andrei.simion@microchip.com>
References: <20241001152541.91945-1-andrei.simion@microchip.com>
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


