Return-Path: <linux-kernel+bounces-363624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DC99C4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A911C20844
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB6156879;
	Mon, 14 Oct 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TtANocIQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9E14B08E;
	Mon, 14 Oct 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896857; cv=none; b=LJ7BuQyxkW1hXL/rwJM6SFQDhgO3UZ94DyCR9Qtr7/DcUlPHSHiP9ZTWy0LCvJDDstov361jLy2t09fugK3raML7weMNz4cDV73rrwuDT2lZGohGZuzExMM4uewwodr0dasNChHNXfSsaUmgTvmbzag4+Jeun6S9TaxrBD/EINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896857; c=relaxed/simple;
	bh=x9fwqOuMwQjgugPY531AN6iYwGmRq07cheBKmsfoejk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9/v9BWKbmmTJy2ce74a/eIQel5mNX4YNmEJH0uDC8NfcFlJsUyRTpLlVPBsdMBG7BOrxRcV8sAzI6VMwfsVj3rLrMNGQWboTnXqoJX6n9DcXfauBATZRTrFUcKKuSbTdAsARJUV6DPSoBK/1jg98EufOgRAZuRy2ICa8niw0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TtANocIQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728896855; x=1760432855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x9fwqOuMwQjgugPY531AN6iYwGmRq07cheBKmsfoejk=;
  b=TtANocIQus9XEQ1/+RQ/He+vUTfDKAdjHFvUXyv4VvEJMW4Os+w+VGVO
   fd5Ka5/RNd8jJ3ds5Pcb1uvgdEGEy5+qf1i4vptL8bADr43xj3Inot2Ts
   GJB8gdaaZlPRSPQdGBVmggPz4ZCL6jtWi7cHhv2aYt4o1AdDvhPpn3VLg
   4jFerKE/thQcl/pgVvOgP48LSxW1Y1c6uP73IT0+RMGYgB7y/EjJhmITo
   1NAQzRt8gNP6YiYSsq9lJDCTgJk5xvktkw9zXbyPbQPn1DvN/kCeviA0X
   SHxtblWwMqanenBTfOLGcIH7nQIskFxVpq/+aml9lsTmySbQoFdq9lqzz
   g==;
X-CSE-ConnectionGUID: OewlYZ9kR2OdPvJxEyQCYQ==
X-CSE-MsgGUID: gGbDHvaUTX6N7AHqgavBrg==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="200399574"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 02:07:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 02:07:00 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 14 Oct 2024 02:06:58 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 RESEND] ARM: dts: microchip: sam9x60: Add missing property atmel,usart-mode
Date: Mon, 14 Oct 2024 12:06:41 +0300
Message-ID: <20241014090641.44596-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the atmel,usart-mode property to the UART nodes. This ensures
compliance with the atmel,at91-usart.yaml schema and resolves the errors
below:
serial@200: $nodename:0: 'serial@200' does not match
'^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
serial@200: atmel,use-dma-rx: False schema does not allow True
serial@200: atmel,use-dma-tx: False schema does not allow True
serial@200: atmel,fifo-size: False schema does not allow [[16]]

These errors indicate that the property
atmel,usart-mode = <AT91_USART_MODE_SERIAL> is missing for
UART nodes 0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 11, and 12.

Fixes: 99c808335877 ("ARM: dts: at91: sam9x60: Add missing flexcom definitions")
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- reword commit message
- add Acked-by received in V1
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

base-commit: 7f773fd61baa9b136faa5c4e6555aa64c758d07c
-- 
2.34.1


