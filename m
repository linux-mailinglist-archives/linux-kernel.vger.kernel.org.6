Return-Path: <linux-kernel+bounces-312253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB096940E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B851F2226D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8411CDFAF;
	Tue,  3 Sep 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o9S/VYix"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2571D6186;
	Tue,  3 Sep 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345907; cv=none; b=qszSew0DL8BOLhgaxtMcHY9csELVj87LNdDKDaT7wkKDM+ujAVa6QEpebP315y8aECnjyQwqnZh3JrQTMFg413q7YKHVy++/L/RdTRrOesw0Plllq/CXwx6plUzaKqiB7OfWZQoIqgF4d85XNa/q/Lj5zOJ8HBmXNWDtY7Dhixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345907; c=relaxed/simple;
	bh=lckxbndzn5SzNLl/X33gP9uFz9Zap1w5LoofaOwQ5xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Da66xAZTlOjJF1vKxfUWMxgcUQSR273mDPhfAoJocfdbHKMuJ7VcA9o1pI7Fc/ZnxNCipa01et0w+Whs7vBxXPme+islOpJk8zyw3WZkZEi6J6LRXF7SK0DNaiDxgr2j7Ma/x5dLR/ROv9ekXDZQ8XjJ8nJGunAhsg5oR1SP1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o9S/VYix; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345904; x=1756881904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lckxbndzn5SzNLl/X33gP9uFz9Zap1w5LoofaOwQ5xs=;
  b=o9S/VYixcyVP/m79C8k6V4ultBeMPVgfHcibM0cmf/tHLCVBpn/zNa15
   7aKXq20+f0VLHntU9RwQYgce2aHKtg1Uh75urRNmAVu5tUwEi+k7I2azP
   yuQ081hWMS/EKhqG+Be7Uv5ww+zdgNhNTYwqOrMsE7H3fdDQCt+4tmKqI
   4XIKoPIraK+4GMFCPySvHFC1b59TGaOS/TQhPWVUIGtP8GoDtXN6pgHgp
   gdsl/Tth3Tbf2ag3V1yCASMo69clSbIz8aTJWPUQAwn7yvYNL/hblrV60
   zrTaBEkcEfhtmG+tHSyCaD4uEq9UN6AFB0/xMLpG+/mqB6xm8ByGp2DfL
   A==;
X-CSE-ConnectionGUID: It3XBgicRp6ZNrxOO7XUJA==
X-CSE-MsgGUID: foXUXSFLRCi2m+eerstmgQ==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31150080"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:45:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:44:22 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:44:19 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v7 10/12] ARM: dts: at91: sam9x7: add device tree for SoC
Date: Tue, 3 Sep 2024 12:13:49 +0530
Message-ID: <20240903064349.49849-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree file for SAM9X7 SoC family.

Co-developed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v7:

- Enabled TCB node to add child nodes in the dts
- Removed sfr node to add it later in a different series with the right
  binding documentation
---
 arch/arm/boot/dts/microchip/sam9x7.dtsi | 1220 +++++++++++++++++++++++
 1 file changed, 1220 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi

diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
new file mode 100644
index 000000000000..beb1f34b38d3
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -0,0 +1,1220 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * sam9x7.dtsi - Device Tree Include file for Microchip SAM9X7 SoC family
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
+ */
+
+#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/at91-usart.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/pinctrl/at91.h>
+
+/ {
+	model = "Microchip SAM9X7 SoC";
+	compatible = "microchip,sam9x7";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&aic>;
+
+	aliases {
+		serial0 = &dbgu;
+		gpio0 = &pioA;
+		gpio1 = &pioB;
+		gpio2 = &pioC;
+		gpio3 = &pioD;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,arm926ej-s";
+			reg = <0>;
+			device_type = "cpu";
+		};
+	};
+
+	clocks {
+		slow_xtal: clock-slowxtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		main_xtal: clock-mainxtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+	};
+
+	sram: sram@300000 {
+		compatible = "mmio-sram";
+		reg = <0x300000 0x10000>;
+		ranges = <0 0x300000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sdmmc0: mmc@80000000 {
+			compatible = "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci";
+			reg = <0x80000000 0x300>;
+			interrupts = <12 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 12>, <&pmc PMC_TYPE_GCK 12>;
+			clock-names = "hclock", "multclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 12>;
+			assigned-clock-rates = <100000000>;
+			status = "disabled";
+		};
+
+		sdmmc1: mmc@90000000 {
+			compatible = "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci";
+			reg = <0x90000000 0x300>;
+			interrupts = <26 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 26>, <&pmc PMC_TYPE_GCK 26>;
+			clock-names = "hclock", "multclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 26>;
+			assigned-clock-rates = <100000000>;
+			status = "disabled";
+		};
+	};
+
+	apb {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		flx4: flexcom@f0000000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf0000000 0x200>;
+			ranges = <0x0 0xf0000000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+			status = "disabled";
+
+			uart4: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(8))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(9))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi4: spi@400 {
+				compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+				clock-names = "spi_clk";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(8))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(9))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(8))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(9))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx5: flexcom@f0004000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf0004000 0x200>;
+			ranges = <0x0 0xf0004000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+			status = "disabled";
+
+			uart5: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(10))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(11))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi5: spi@400 {
+				compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+				clock-names = "spi_clk";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(10))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(11))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+
+			i2c5: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(10))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(11))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		dma0: dma-controller@f0008000 {
+			compatible = "microchip,sam9x7-dma", "atmel,sama5d4-dma";
+			reg = <0xf0008000 0x1000>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
+			clock-names = "dma_clk";
+			status = "disabled";
+		};
+
+		ssc: ssc@f0010000 {
+			compatible = "microchip,sam9x7-ssc", "atmel,at91sam9g45-ssc";
+			reg = <0xf0010000 0x4000>;
+			interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 28>;
+			clock-names = "pclk";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(38))>,
+			       <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(39))>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		i2s: i2s@f001c000 {
+			compatible = "microchip,sam9x7-i2smcc", "microchip,sam9x60-i2smcc";
+			reg = <0xf001c000 0x100>;
+			interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 34>, <&pmc PMC_TYPE_GCK 34>;
+			clock-names = "pclk", "gclk";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(36))>,
+			       <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(37))>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		flx11: flexcom@f0020000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf0020000 0x200>;
+			ranges = <0x0 0xf0020000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
+			status = "disabled";
+
+			uart11: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(22))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(23))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c11: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(22))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(23))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx12: flexcom@f0024000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf0024000 0x200>;
+			ranges = <0x0 0xf0024000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
+			status = "disabled";
+
+			uart12: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(24))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(25))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c12: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(24))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(25))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		pit64b0: timer@f0028000 {
+			compatible = "microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b";
+			reg = <0xf0028000 0x100>;
+			interrupts = <37 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 37>, <&pmc PMC_TYPE_GCK 37>;
+			clock-names = "pclk", "gclk";
+		};
+
+		sha: crypto@f002c000 {
+			compatible = "microchip,sam9x7-sha", "atmel,at91sam9g46-sha";
+			reg = <0xf002c000 0x100>;
+			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
+			clock-names = "sha_clk";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(34))>;
+			dma-names = "tx";
+		};
+
+		trng: rng@f0030000 {
+			compatible = "microchip,sam9x7-trng", "microchip,sam9x60-trng";
+			reg = <0xf0030000 0x100>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
+			status = "disabled";
+		};
+
+		aes: crypto@f0034000 {
+			compatible = "microchip,sam9x7-aes", "atmel,at91sam9g46-aes";
+			reg = <0xf0034000 0x100>;
+			interrupts = <39 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
+			clock-names = "aes_clk";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(32))>,
+			       <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(33))>;
+			dma-names = "tx", "rx";
+		};
+
+		tdes: crypto@f0038000 {
+			compatible = "microchip,sam9x7-tdes", "atmel,at91sam9g46-tdes";
+			reg = <0xf0038000 0x100>;
+			interrupts = <40 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
+			clock-names = "tdes_clk";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(31))>,
+			       <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(30))>;
+			dma-names = "tx", "rx";
+		};
+
+		classd: sound@f003c000 {
+			compatible = "microchip,sam9x7-classd", "atmel,sama5d2-classd";
+			reg = <0xf003c000 0x100>;
+			interrupts = <42 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 42>, <&pmc PMC_TYPE_GCK 42>;
+			clock-names = "pclk", "gclk";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(35))>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
+		pit64b1: timer@f0040000 {
+			compatible = "microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b";
+			reg = <0xf0040000 0x100>;
+			interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 58>, <&pmc PMC_TYPE_GCK 58>;
+			clock-names = "pclk", "gclk";
+		};
+
+		can0: can@f8000000 {
+			compatible = "bosch,m_can";
+			reg = <0xf8000000 0x100>, <0x300000 0x7800>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <68 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 29>, <&pmc PMC_TYPE_GCK 29>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_GCK 29>;
+			assigned-clock-rates = <480000000>, <40000000>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
+			bosch,mram-cfg = <0x3400 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		can1: can@f8004000 {
+			compatible = "bosch,m_can";
+			reg = <0xf8004000 0x100>, <0x300000 0xbc00>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <30 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <69 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "int0", "int1";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 30>, <&pmc PMC_TYPE_GCK 30>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_GCK 30>;
+			assigned-clock-rates = <480000000>, <40000000>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
+			bosch,mram-cfg = <0x7800 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		tcb: timer@f8008000 {
+			compatible = "microchip,sam9x7-tcb","atmel,sama5d2-tcb", "simple-mfd", "syscon";
+			reg = <0xf8008000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&pmc PMC_TYPE_GCK 17>, <&clk32k 0>;
+			clock-names = "t0_clk", "gclk", "slow_clk";
+		};
+
+		flx6: flexcom@f8010000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8010000 0x200>;
+			ranges = <0x0 0xf8010000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+			status = "disabled";
+
+			uart6: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(12))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(13))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c6: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(12))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(13))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx7: flexcom@f8014000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8014000 0x200>;
+			ranges = <0x0 0xf8014000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
+			status = "disabled";
+
+			uart7: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(14))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(15))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c7: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(14))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(15))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx8: flexcom@f8018000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8018000 0x200>;
+			ranges = <0x0 0xf8018000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
+			status = "disabled";
+
+			uart8: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(16))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(17))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c8: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(16))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(17))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx0: flexcom@f801c000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf801c000 0x200>;
+			ranges = <0x0 0xf801c000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+			status = "disabled";
+
+			uart0: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(0))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(1))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi0: spi@400 {
+				compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+				clock-names = "spi_clk";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(0))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(1))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+
+			i2c0: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(0))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(1))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx1: flexcom@f8020000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8020000 0x200>;
+			ranges = <0x0 0xf8020000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+			status = "disabled";
+
+			uart1: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(2))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(3))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi1: spi@400 {
+				compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+				clock-names = "spi_clk";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(2))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(3))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(2))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(3))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx2: flexcom@f8024000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8024000 0x200>;
+			ranges = <0x0 0xf8024000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+			status = "disabled";
+
+			uart2: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(4))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(5))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi2: spi@400 {
+				compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+				clock-names = "spi_clk";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(4))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(5))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(4))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(5))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx3: flexcom@f8028000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8028000 0x200>;
+			ranges = <0x0 0xf8028000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+			status = "disabled";
+
+			uart3: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(6))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(7))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi3: spi@400 {
+				compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+				clock-names = "spi_clk";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(6))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(7))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(6))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(7))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		gmac: ethernet@f802c000 {
+			compatible = "microchip,sam9x7-gem", "microchip,sama7g5-gem";
+			reg = <0xf802c000 0x1000>;
+			interrupts = <24 IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 0 */
+				     <60 IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 1 */
+				     <61 IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 2 */
+				     <62 IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 3 */
+				     <63 IRQ_TYPE_LEVEL_HIGH 3>,	/* Queue 4 */
+				     <64 IRQ_TYPE_LEVEL_HIGH 3>;	/* Queue 5 */
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_PERIPHERAL 24>, <&pmc PMC_TYPE_GCK 24>, <&pmc PMC_TYPE_GCK 67>;
+			clock-names = "hclk", "pclk", "tx_clk", "tsu_clk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 67>;
+			assigned-clock-rates = <266666666>;
+			status = "disabled";
+		};
+
+		pwm0: pwm@f8034000 {
+			compatible = "microchip,sam9x7-pwm", "microchip,sam9x60-pwm";
+			reg = <0xf8034000 0x300>;
+			interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		flx9: flexcom@f8040000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8040000 0x200>;
+			ranges = <0x0 0xf8040000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
+			status = "disabled";
+
+			uart9: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(18))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(19))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c9: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(18))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(19))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		flx10: flexcom@f8044000 {
+			compatible = "microchip,sam9x7-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xf8044000 0x200>;
+			ranges = <0x0 0xf8044000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
+			status = "disabled";
+
+			uart10: serial@200 {
+				compatible = "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
+				clock-names = "usart";
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(20))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(21))>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				atmel,fifo-size = <16>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			i2c10: i2c@600 {
+				compatible = "microchip,sam9x7-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(20))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) |
+					 AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(21))>;
+				dma-names = "tx", "rx";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		matrix: matrix@ffffde00 {
+			compatible = "microchip,sam9x7-matrix", "atmel,at91sam9x5-matrix", "syscon";
+			reg = <0xffffde00 0x200>;
+		};
+
+		pmecc: ecc-engine@ffffe000 {
+			compatible = "microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc";
+			reg = <0xffffe000 0x300>, <0xffffe600 0x100>;
+		};
+
+		mpddrc: mpddrc@ffffe800 {
+			compatible = "microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc";
+			reg = <0xffffe800 0x200>;
+			clocks = <&pmc PMC_TYPE_SYSTEM 2>, <&pmc PMC_TYPE_CORE PMC_MCK>;
+			clock-names = "ddrck", "mpddr";
+		};
+
+		smc: smc@ffffea00 {
+			compatible = "microchip,sam9x7-smc", "atmel,at91sam9260-smc", "syscon";
+			reg = <0xffffea00 0x100>;
+		};
+
+		aic: interrupt-controller@fffff100 {
+			compatible = "microchip,sam9x7-aic";
+			reg = <0xfffff100 0x100>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			atmel,external-irqs = <31>;
+		};
+
+		dbgu: serial@fffff200 {
+			compatible = "microchip,sam9x7-dbgu", "atmel,at91sam9260-dbgu", "microchip,sam9x7-usart", "atmel,at91sam9260-usart";
+			reg = <0xfffff200 0x200>;
+			interrupts = <47 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
+			clock-names = "usart";
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(28))>,
+			       <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				 AT91_XDMAC_DT_PERID(29))>;
+			dma-names = "tx", "rx";
+			atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@fffff400 {
+			compatible = "microchip,sam9x7-pinctrl", "microchip,sam9x60-pinctrl", "simple-mfd";
+			ranges = <0xfffff400 0xfffff400 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* mux-mask corresponding to sam9x7 SoC in TFBGA228L package */
+			atmel,mux-mask = <
+					 /*  A		B	   C	      D	  */
+					 0xffffffff 0xffffefc0 0xc0ffd000 0x00000000	/* pioA */
+					 0x07ffffff 0x0805fe7f 0x01ff9f81 0x06078000	/* pioB */
+					 0xffffffff 0x07dfffff 0xfa3fffff 0x00000000	/* pioC */
+					 0x00003fff 0x00003fe0 0x0000003f 0x00000000	/* pioD */
+					 >;
+
+			pioA: gpio@fffff400 {
+				compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
+				reg = <0xfffff400 0x200>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				gpio-controller;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
+			};
+
+			pioB: gpio@fffff600 {
+				compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
+				reg = <0xfffff600 0x200>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 1>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				gpio-controller;
+				#gpio-lines = <26>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
+			};
+
+			pioC: gpio@fffff800 {
+				compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
+				reg = <0xfffff800 0x200>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 1>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				gpio-controller;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 4>;
+			};
+
+			pioD: gpio@fffffa00 {
+				compatible = "microchip,sam9x7-gpio", "microchip,sam9x60-gpio", "atmel,at91rm9200-gpio";
+				reg = <0xfffffa00 0x200>;
+				interrupts = <44 IRQ_TYPE_LEVEL_HIGH 1>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				#gpio-cells = <2>;
+				gpio-controller;
+				#gpio-lines = <22>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 44>;
+			};
+		};
+
+		pmc: clock-controller@fffffc00 {
+			compatible = "microchip,sam9x7-pmc", "syscon";
+			reg = <0xfffffc00 0x200>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+			#clock-cells = <2>;
+			clocks = <&clk32k 1>, <&clk32k 0>, <&main_xtal>;
+			clock-names = "td_slck", "md_slck", "main_xtal";
+		};
+
+		reset_controller: reset-controller@fffffe00 {
+			compatible = "microchip,sam9x7-rstc", "microchip,sam9x60-rstc";
+			reg = <0xfffffe00 0x10>;
+			clocks = <&clk32k 0>;
+		};
+
+		poweroff: poweroff@fffffe10 {
+			compatible = "microchip,sam9x7-shdwc", "microchip,sam9x60-shdwc";
+			reg = <0xfffffe10 0x10>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk32k 0>;
+			atmel,wakeup-rtc-timer;
+			atmel,wakeup-rtt-timer;
+			status = "disabled";
+		};
+
+		rtt: rtc@fffffe20 {
+			compatible = "microchip,sam9x7-rtt", "atmel,at91sam9260-rtt";
+			reg = <0xfffffe20 0x20>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&clk32k 0>;
+		};
+
+		clk32k: clock-controller@fffffe50 {
+			compatible = "microchip,sam9x7-sckc", "microchip,sam9x60-sckc";
+			reg = <0xfffffe50 0x4>;
+			clocks = <&slow_xtal>;
+			#clock-cells = <1>;
+		};
+
+		gpbr: syscon@fffffe60 {
+			compatible = "microchip,sam9x7-gpbr", "atmel,at91sam9260-gpbr", "syscon";
+			reg = <0xfffffe60 0x10>;
+		};
+
+		rtc: rtc@fffffea8 {
+			compatible = "microchip,sam9x7-rtc", "microchip,sam9x60-rtc";
+			reg = <0xfffffea8 0x100>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+			clocks = <&clk32k 0>;
+		};
+
+		watchdog: watchdog@ffffff80 {
+			compatible = "microchip,sam9x7-wdt", "microchip,sam9x60-wdt";
+			reg = <0xffffff80 0x24>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.25.1


