Return-Path: <linux-kernel+bounces-326269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE479765B9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE01C2309F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52019E96A;
	Thu, 12 Sep 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Nu+vAQnn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DD19307E;
	Thu, 12 Sep 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133600; cv=none; b=n54fzuTn5fcNSbaBAIzzrag4tXMilXvGUEkIo2uTHELmh4VoVuH/tW09e500tBKrPHJLH9vR+kF/q380xiQhoTa4UZc5h3kJk2Ui17xoliv4lU2JKxIQL/D2Y80uIwoRMMGmuj4+wkpJJsdpi/ZYw390xZOLn0NfnGFqV9sPeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133600; c=relaxed/simple;
	bh=x9MZ4i7i6o6MmiE6TuNgzQILdZZGvsilrySuI6sanyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D1atFGdpPbGUJjxrz7Pcz8WmXMlm4JnE8nXAlskX3HeJYwWRV1jZiwAS2rKtciKBgV+e7gLmRe8oFbI/HgRJbMYfdKkZ6lD9EvRHlsntSGkYef3Q3+gSKIuuNoBDD62JgNDyMbFkqnQJyVbbGbfN25S2DcLl64iWK4l9hKvA2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Nu+vAQnn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726133599; x=1757669599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x9MZ4i7i6o6MmiE6TuNgzQILdZZGvsilrySuI6sanyE=;
  b=Nu+vAQnnc5Q1RBRcVEeDxvnoP+0gNZeiuL0z9nc8QFJjvf18Vlj0QSaY
   K7eRF0sYyup9oFhlF2xLIQEtLz9/zFwYZ9gE9fwKJvTWlAS51PYOD+8Gu
   ZryLxCIdfvJyMZxQuKHxXt3ivO9x69ttC0DSp/dr9SV4h3JCKS1QLUupT
   P/9nRvvyrEwm9DuhCmTE8yxgmExltEja6qyuhshulsoBxNHM/9E15OnQG
   udktMKUx3PDZC93HxUmBu78KOYHqj7IpKDCWeEIdG+7UNcCXkyU7GzTuy
   I83qjpDyTZ6ZkSGpqrUuvY9Nqnwwyy8anbCJeu4pGCvb9V9vZ5J9HgItk
   g==;
X-CSE-ConnectionGUID: BCOxaM+xQw2ODPMijRn+Xg==
X-CSE-MsgGUID: ApUAX4bvS0O/r4wqYbJuEg==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="262677950"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2024 02:33:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 12 Sep 2024 02:33:13 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 12 Sep 2024 02:33:10 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2] ARM: dts: microchip: sam9x60: Add missing property atmel,usart-mode
Date: Thu, 12 Sep 2024 12:33:07 +0300
Message-ID: <20240912093307.40488-1-andrei.simion@microchip.com>
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

base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
-- 
2.34.1


