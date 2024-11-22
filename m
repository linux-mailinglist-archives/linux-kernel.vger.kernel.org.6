Return-Path: <linux-kernel+bounces-417911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5199D5AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F041F21DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504ED18A6DC;
	Fri, 22 Nov 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qvhy0YmW"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BB17DFEF;
	Fri, 22 Nov 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262754; cv=none; b=EmRBGc0VLgz/lAyyxtz/v1yi2r3edstIisT93xpOoM0Fsu63fg7hQ6Z2ls8XAJnRfVVdNAoKRjW6V3z+Dmcq0Zggd1myUkcbgpbHfpbYSX/mG7RqAC39VLK5b0NWLaxMzUM/W4YM1+/IVu6vo32cq3yOoXYHS/pO/tGmPrzfV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262754; c=relaxed/simple;
	bh=Q0ovU3OhZyQAKh6JD8vsd/LxmR77/KK30xGFf4W2R0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEl9eE8Vst9u2HKwc4YxSA/VXIgiVcOxLuPZfZVuTpVDNAs+7KHNYZPyjJZTjkbZptuvgpr/bKvPwV43XxgPIKanpN1k0zA65Z3efxg9bhdyzIlClrg5ZGSDjzBoYHn0IPausATrYiELVF6ifRtlUffgpH8K748O28u3PQLKtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qvhy0YmW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732262753; x=1763798753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0ovU3OhZyQAKh6JD8vsd/LxmR77/KK30xGFf4W2R0Y=;
  b=Qvhy0YmWLwaO1o2T2TsdnD1o2yFiyCVWhnDu7fXQwQIurR/B75jR5ryv
   hOfySV+KT4WRQhBkDXuNiaaPHnxd/LSkNo7L8VX+seCwOffndujUN7nTR
   4CZbQBpKtzauqB022OpdtjiEXVJ3HcSBhtSBFYWT+22tcXE/ZEEKI2eao
   VRfidFS0nKXFw4eVka2TnwrZ567i1jiUXj0UJvflH4liAS3RF0Asfu8AT
   tMTXRj9UHv9Gq+n9TuFQk8DZEG/Lzbo6tPu08tY5O5AlqkjpOMVQ88Jb+
   0c/tE6lZJWDfiXBR+/Vx/8JBr3tI5oPWQsAUukkyl7NGiXRZJo927NAec
   w==;
X-CSE-ConnectionGUID: seBZEJAOQsKqub7xMw7SQA==
X-CSE-MsgGUID: 6ch+yPC7SWGGP1PoJryrgg==
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="34661813"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2024 01:05:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Nov 2024 01:05:44 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 22 Nov 2024 01:05:42 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/2] ARM: dts: microchip: sam9x7: Move i2c address/size to dtsi
Date: Fri, 22 Nov 2024 10:05:22 +0200
Message-ID: <20241122080523.3941-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122080523.3941-1-mihai.sain@microchip.com>
References: <20241122080523.3941-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Since these properties are common for all i2c subnodes,
move them to SoC dtsi from board dts.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 .../dts/microchip/at91-sam9x75_curiosity.dts  |  2 --
 arch/arm/boot/dts/microchip/sam9x7.dtsi       | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
index 87b6ea97590b..d453800f8e35 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
@@ -88,8 +88,6 @@ &flx6 {
 };
 
 &i2c6 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flx6_default>;
 	i2c-analog-filter;
diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index beb1f34b38d3..aedba0a8318f 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -151,6 +151,8 @@ i2c4: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -220,6 +222,8 @@ i2c5: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -312,6 +316,8 @@ i2c11: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -362,6 +368,8 @@ i2c12: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -533,6 +541,8 @@ i2c6: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -583,6 +593,8 @@ i2c7: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -633,6 +645,8 @@ i2c8: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -702,6 +716,8 @@ i2c0: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -771,6 +787,8 @@ i2c1: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -840,6 +858,8 @@ i2c2: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -909,6 +929,8 @@ i2c3: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -984,6 +1006,8 @@ i2c9: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -1034,6 +1058,8 @@ i2c10: i2c@600 {
 				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
-- 
2.47.0


