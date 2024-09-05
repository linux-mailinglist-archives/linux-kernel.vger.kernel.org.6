Return-Path: <linux-kernel+bounces-316741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112296D358
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C7E1C25A13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7D198833;
	Thu,  5 Sep 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kCMea8x5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D116F839;
	Thu,  5 Sep 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528697; cv=none; b=sEIjHECyM49yJuWkGJBWKChMT7NobH+0dffU6emE40leFNjjDjAGIlSkkGZ1hgULqnrdp+KwURCRyYuSNdBgsREpTn4kbIhPs3E8XMikqtGufoNZMWbSPW2gUbJ/aLLcXzfcyFhWGX5mXhCWJ+wherGg6NiR/8baRz1Z8SFI4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528697; c=relaxed/simple;
	bh=UD+4J9h5U556VSQaV+fZrmK1+8BUz0vKF0+AJcFrVJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s81029RbkecdgXvjKWb0wpcwSYq0HNxidUejUGNBd0vWvHGt41ZdlPJ9kN3wupSXDSAsV+bLcksPdc0zCbc5TcK130VpFpVnFAflYYuWpzd5akyHIsdb6R0l9ZwBHUV/zE4SKIca5m6A3gCe+gQJTNPalal8UEcpoZ0Il6ouHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kCMea8x5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725528696; x=1757064696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UD+4J9h5U556VSQaV+fZrmK1+8BUz0vKF0+AJcFrVJU=;
  b=kCMea8x5aWN9kSbkX375lJZS9RMHGt6jl2OUWvnQcEE5bVfbba4ha/Qb
   OyVUKAvSAc3RLD4ln2bI0k2vmZ6/AHwFQFHN3MZ+dIO7B5SuU3pRKQDgX
   hr6AwWTzaEXl2cy04aFt2ddQN5oHxi+DcuI7+n5yssEc15twHbK7NNBbu
   VmnWJ/8gNkpoQL3pDT0S/lF0KHDniVCNZ0bb7/C0a89DsO4n8rsG9WUoj
   iZ6U2I/xYz7bz6PenmBbGsXhedsghGgT5QN6oQoa+5vbDwcyyMGqk6WBu
   7HM5mi/Z80QqS1b20wASSEqi33PbRPKJyP/0Z67N/vkhmms6OW28xCrh8
   Q==;
X-CSE-ConnectionGUID: TvvipYo5T+CgffTOc9cuVg==
X-CSE-MsgGUID: cXs/9IlcQ0WGxfwHa6gH/w==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="31355457"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 02:31:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 02:30:53 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Sep 2024 02:30:51 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH] ARM: dts: microchip: sam9x60: Add missing property atmel,usart-mode
Date: Thu, 5 Sep 2024 12:30:46 +0300
Message-ID: <20240905093046.23428-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

~: make dtbs_check DT_SCHEMA_FILES=atmel,at91-usart.ymal
-> for all boards which inherit sam9x60.dtsi: serial@200: $nodename:0:
'serial@200' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$
serial@200: atmel,use-dma-rx: False schema does not allow True
serial@200: atmel,use-dma-tx: False schema does not allow True
serial@200: atmel,fifo-size: False schema does not allow [[16]]
-> Means : atmel,usart-mode = <AT91_USART_MODE_SERIAL> misses for uart:
0,1,2,3,4,6,7,8,9,10,11,12

Add to uart nodes the property atmel,usart-mode to specify the driver to be
used in serial mode to be compliant to atmel,at91-usart.yaml.

Fixes: 99c808335877 ("ARM: dts: at91: sam9x60: Add missing flexcom definitions")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 04a6d716ecaf..0ba424bba7cc 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -174,6 +174,7 @@ flx4: flexcom@f0000000 {
 				uart4: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -376,6 +377,7 @@ flx11: flexcom@f0020000 {
 				uart11: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -427,6 +429,7 @@ flx12: flexcom@f0024000 {
 				uart12: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -586,6 +589,7 @@ flx6: flexcom@f8010000 {
 				uart6: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -637,6 +641,7 @@ flx7: flexcom@f8014000 {
 				uart7: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -688,6 +693,7 @@ flx8: flexcom@f8018000 {
 				uart8: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -739,6 +745,7 @@ flx0: flexcom@f801c000 {
 				uart0: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -809,6 +816,7 @@ flx1: flexcom@f8020000 {
 				uart1: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -879,6 +887,7 @@ flx2: flexcom@f8024000 {
 				uart2: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -949,6 +958,7 @@ flx3: flexcom@f8028000 {
 				uart3: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -1074,6 +1084,7 @@ flx9: flexcom@f8040000 {
 				uart9: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |
@@ -1125,6 +1136,7 @@ flx10: flexcom@f8044000 {
 				uart10: serial@200 {
 					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
 						(AT91_XDMAC_DT_MEM_IF(0) |

base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba
-- 
2.34.1


