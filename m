Return-Path: <linux-kernel+bounces-262164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419893C1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938151F269EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1521B19DF4B;
	Thu, 25 Jul 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LTxN39Xm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33019D89C;
	Thu, 25 Jul 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909849; cv=none; b=ghC560B3BUsvRe6Flz5bsO2V0YiKSIWKGHKUlBJBL+UQmYqbceQA9GhXaZ7Ayk2d7QyGAioUJZtu/aoofZ4h7+drJRRe9kOFFVEyzjN7HeCHua2MjaDkeM9LlnoQ8WTNbVlwBzlKAKh1pL7JdZgMLlRPJ7Tge//dMfIEO+OQhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909849; c=relaxed/simple;
	bh=wRssKQ+1OIJGuYLy0ESuCIbNp0p0oU1mZzW67Jh/n1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqOa2EC2kTyzNbAD0zizcq+fuRI0Ca7oJvitRDpDm8+sfE1dRIs5XG7JIa4wx0wdOrgivy8YATrS9b2Sd1CKiN/SWCkLBkhmKnjJZL8houmgIKGzlu3BA2uO3nQEf7trPMpaKzw1085Jy6zrriMg3cbSLjFluDJy3UOZKIyt2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LTxN39Xm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909847; x=1753445847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wRssKQ+1OIJGuYLy0ESuCIbNp0p0oU1mZzW67Jh/n1g=;
  b=LTxN39XmwcM/sAwQQXfuw9ZvrqSauGDB9Eo1RSuPj6V0gT9DUThAzk8v
   J8KM5xzAUHVvoK6JGOA4PEt6My1b3631DbKcDm3ocfBQxnIUiMsuPvKp5
   Evvf4ZgiXB4gOIKkfwqv1d+qkansZ45qsriGifVhpRlftNVPvOLN1xiQY
   AzdpifhwTyAmhH9qxUw+C87B0bFHMy9Z4jGRMCux0ohEWPHo2xIwtHJHA
   3mJhBr3J22yyLjBwpecnGPWFnM7DPEwSIPgS2r60/aygbmPTE3fAcVMLa
   wL1KfRdQHPRLSsIUlSzD6lZqcD0u2l0C43HDzAjp8WFIVeVZBNxrA3M3C
   g==;
X-CSE-ConnectionGUID: hjVQhlwNR/6pLqFcgIL99w==
X-CSE-MsgGUID: W62ijLapRjCznpwQWsAUWg==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="197092716"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:17:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:17:04 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:17:02 -0700
From: <pierre-henry.moussay@microchip.com>
To: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 17/17] riscv: dts: microchip: add PIC64GX Curiosity Kit dts
Date: Thu, 25 Jul 2024 13:16:09 +0100
Message-ID: <20240725121609.13101-18-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

The Curiosity-GX10000 (PIC64GX SoC Curiosity Kit) is a compact SoC
prototyping board featuring a Microchip PIC64GX SoC
PIC64GC-1000. Features include:
- 1 GB DDR4 SDRAM
- Gigabit Ethernet
- microSD-card slot

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../dts/microchip/pic64gx-curiosity-kit.dts   | 114 ++++
 arch/riscv/boot/dts/microchip/pic64gx.dtsi    | 616 ++++++++++++++++++
 3 files changed, 731 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/pic64gx.dtsi

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index e177815bf1a2..78ba2952a164 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += pic64gx-curiosity-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts b/arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts
new file mode 100644
index 000000000000..2eda33689893
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2021 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "pic64gx.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define RTCCLK_FREQ	1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip Pic64GX Curiosity Kit";
+	compatible = "microchip,pic64gx-curiosity-kit", "microchip,pic64gx";
+
+	aliases {
+		ethernet0 = &mac0;
+		serial1 = &mmuart1;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <RTCCLK_FREQ>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hss: hss-buffer@bfc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xbfc00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+};
+
+
+&mac0 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+
+	phy0: ethernet-phy@b {
+		reg = <0xb>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-1-8-v;
+	status = "okay";
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
+
+&gpio0 {
+	status ="okay";
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "MIPI_CAM_RESET", "MIPI_CAM_STANDBY";
+};
+
+&gpio1 {
+	status ="okay";
+	gpio-line-names =
+		"", "", "LED1", "LED2", "LED3", "LED4", "LED5", "LED6",
+		"LED7", "LED8", "", "", "", "", "", "",
+		"", "", "", "", "HDMI_HPD", "", "", "GPIO_1_23";
+};
+
+&gpio2 {
+	status ="okay";
+	gpio-line-names =
+		"", "", "", "", "", "", "SWITCH2", "USR_IO12",
+		"DIP1", "DIP2", "", "DIP3", "USR_IO1", "USR_IO2", "USR_IO7", "USR_IO8",
+		"USR_IO3", "USR_IO4", "USR_IO5", "USR_IO6", "", "", "USR_IO9", "USR_IO10",
+		"DIP4", "USR_IO11", "", "", "SWITCH1", "", "", "";
+};
diff --git a/arch/riscv/boot/dts/microchip/pic64gx.dtsi b/arch/riscv/boot/dts/microchip/pic64gx.dtsi
new file mode 100644
index 000000000000..2cf42e741ba9
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/pic64gx.dtsi
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2024 Microchip Technology Inc */
+
+/dts-v1/;
+#include "dt-bindings/clock/microchip,pic64gx-clock.h"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip PIC64GX SoC";
+	compatible = "microchip,pic64gx";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <1000000>;
+
+		cpu0: cpu@0 {
+			compatible = "sifive,e51", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <16384>;
+			reg = <0>;
+			riscv,isa = "rv64imac";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "c", "zicntr",
+					       "zicsr", "zifencei", "zihpm";
+			clocks = <&clkcfg CLK_CPU>;
+			status = "disabled";
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu1: cpu@1 {
+			compatible = "sifive,u54-mc", "sifive,rocket0",
+				     "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <1>;
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm";
+			clocks = <&clkcfg CLK_CPU>;
+			tlb-split;
+			next-level-cache = <&cctrllr>;
+			status = "okay";
+
+			cpu1_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu2: cpu@2 {
+			compatible = "sifive,u54-mc", "sifive,rocket0",
+				     "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <2>;
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm";
+			clocks = <&clkcfg CLK_CPU>;
+			tlb-split;
+			next-level-cache = <&cctrllr>;
+			status = "okay";
+
+			cpu2_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu3: cpu@3 {
+			compatible = "sifive,u54-mc", "sifive,rocket0",
+				     "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <3>;
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm";
+			clocks = <&clkcfg CLK_CPU>;
+			tlb-split;
+			next-level-cache = <&cctrllr>;
+			status = "okay";
+
+			cpu3_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu4: cpu@4 {
+			compatible = "sifive,u54-mc", "sifive,rocket0",
+				     "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <4>;
+			riscv,isa = "rv64imafdc";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm";
+			clocks = <&clkcfg CLK_CPU>;
+			tlb-split;
+			next-level-cache = <&cctrllr>;
+			status = "okay";
+			cpu4_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+			};
+		};
+	};
+
+	refclk: mssrefclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	syscontroller: syscontroller {
+		compatible = "microchip,pic64gx-sys-controller",
+			     "microchip,mpfs-sys-controller";
+		mboxes = <&mbox 0>;
+	};
+
+	scbclk: mssclkclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <80000000>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		cctrllr: cache-controller@2010000 {
+			compatible = "microchip,pic64gx-ccache",
+				     "microchip,mpfs-ccache",
+				     "sifive,fu540-c000-ccache", "cache";
+			reg = <0x0 0x2010000 0x0 0x1000>;
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1024>;
+			cache-size = <2097152>;
+			cache-unified;
+			interrupt-parent = <&plic>;
+			interrupts = <1>, <3>, <4>, <2>;
+		};
+
+		clint: clint@2000000 {
+			compatible = "sifive,fu540-c000-clint",
+				     "sifive,clint0";
+			reg = <0x0 0x2000000 0x0 0xC000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>;
+		};
+
+		plic: interrupt-controller@c000000 {
+			compatible = "sifive,fu540-c000-plic",
+				     "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>,
+					      <&cpu4_intc 11>, <&cpu4_intc 9>;
+			riscv,ndev = <186>;
+		};
+
+		pdma: dma-controller@3000000 {
+			compatible = "microchip,pic64gx-pdma",
+				     "microchip,mpfs-pdma",
+				     "sifive,pdma0";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic>;
+			interrupts = <5 6>, <7 8>, <9 10>, <11 12>;
+			dma-channels = <4>;
+			#dma-cells = <1>;
+		};
+
+		clkcfg: clkcfg@20002000 {
+			compatible = "microchip,pic64gx-clkcfg",
+				     "microchip,mpfs-clkcfg";
+			reg = <0x0 0x20002000 0x0 0x1000>,
+			      <0x0 0x3E001000 0x0 0x1000>;
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		ccc_se: clock-controller@38010000 {
+			compatible = "microchip,pic64gx-ccc",
+				     "microchip,mpfs-ccc";
+			reg = <0x0 0x38010000 0x0 0x1000>,
+			      <0x0 0x38020000 0x0 0x1000>,
+			      <0x0 0x39010000 0x0 0x1000>,
+			      <0x0 0x39020000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		ccc_ne: clock-controller@38040000 {
+			compatible = "microchip,pic64gx-ccc",
+				     "microchip,mpfs-ccc";
+			reg = <0x0 0x38040000 0x0 0x1000>,
+			      <0x0 0x38080000 0x0 0x1000>,
+			      <0x0 0x39040000 0x0 0x1000>,
+			      <0x0 0x39080000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		ccc_nw: clock-controller@38100000 {
+			compatible = "microchip,pic64gx-ccc",
+				     "microchip,mpfs-ccc";
+			reg = <0x0 0x38100000 0x0 0x1000>,
+			      <0x0 0x38200000 0x0 0x1000>,
+			      <0x0 0x39100000 0x0 0x1000>,
+			      <0x0 0x39200000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		ccc_sw: clock-controller@38400000 {
+			compatible = "microchip,pic64gx-ccc",
+				     "microchip,mpfs-ccc";
+			reg = <0x0 0x38400000 0x0 0x1000>,
+			      <0x0 0x38800000 0x0 0x1000>,
+			      <0x0 0x39400000 0x0 0x1000>,
+			      <0x0 0x39800000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		mmuart0: serial@20000000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20000000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <90>;
+			current-speed = <115200>;
+			clocks = <&clkcfg CLK_MMUART0>;
+			status = "disabled"; /* Reserved for the HSS */
+		};
+
+		mmuart1: serial@20100000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20100000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <91>;
+			current-speed = <115200>;
+			clocks = <&clkcfg CLK_MMUART1>;
+			status = "disabled";
+		};
+
+		mmuart2: serial@20102000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20102000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <92>;
+			current-speed = <115200>;
+			clocks = <&clkcfg CLK_MMUART2>;
+			status = "disabled";
+		};
+
+		mmuart3: serial@20104000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20104000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <93>;
+			current-speed = <115200>;
+			clocks = <&clkcfg CLK_MMUART3>;
+			status = "disabled";
+		};
+
+		mmuart4: serial@20106000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20106000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <94>;
+			clocks = <&clkcfg CLK_MMUART4>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		/* Common node entry for emmc/sd */
+		mmc: mmc@20008000 {
+			compatible = "microchip,pic64gx-sd4hc", "cdns,sd4hc";
+			reg = <0x0 0x20008000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <88>;
+			clocks = <&clkcfg CLK_MMC>;
+			max-frequency = <200000000>;
+			status = "disabled";
+		};
+
+		spi0: spi@20108000 {
+			compatible = "microchip,pic64gx-spi",
+				     "microchip,mpfs-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20108000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <54>;
+			clocks = <&clkcfg CLK_SPI0>;
+			status = "disabled";
+		};
+
+		spi1: spi@20109000 {
+			compatible = "microchip,pic64gx-spi",
+				     "microchip,mpfs-spi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20109000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <55>;
+			clocks = <&clkcfg CLK_SPI1>;
+			status = "disabled";
+		};
+
+		qspi: spi@21000000 {
+			compatible = "microchip,pic64gx-qspi",
+				     "microchip,coreqspi-rtl-v2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x21000000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <85>;
+			clocks = <&clkcfg CLK_QSPI>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@2010a000 {
+			compatible = "microchip,pic64gx-i2c",
+				     "microchip,mpfs-i2c",
+				     "microchip,corei2c-rtl-v7";
+			reg = <0x0 0x2010a000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&plic>;
+			interrupts = <58>;
+			clocks = <&clkcfg CLK_I2C0>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@2010b000 {
+			compatible = "microchip,pic64gx-i2c",
+				     "microchip,mpfs-i2c",
+				     "microchip,corei2c-rtl-v7";
+			reg = <0x0 0x2010b000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&plic>;
+			interrupts = <61>;
+			clocks = <&clkcfg CLK_I2C1>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+
+		can0: can@2010c000 {
+			compatible = "microchip,pic64gx-can",
+				     "microchip,mpfs-can";
+			reg = <0x0 0x2010c000 0x0 0x1000>;
+			clocks = <&clkcfg CLK_CAN0>, <&clkcfg CLK_MSSPLL3>;
+			interrupt-parent = <&plic>;
+			interrupts = <56>;
+			status = "disabled";
+		};
+
+		can1: can@2010d000 {
+			compatible = "microchip,pic64gx-can",
+				     "microchip,mpfs-can";
+			reg = <0x0 0x2010d000 0x0 0x1000>;
+			clocks = <&clkcfg CLK_CAN1>, <&clkcfg CLK_MSSPLL3>;
+			interrupt-parent = <&plic>;
+			interrupts = <57>;
+			status = "disabled";
+		};
+
+		mac0: ethernet@20110000 {
+			compatible = "microchip,pic64gx-macb",
+				     "microchip,mpfs-macb",
+				     "cdns,macb";
+			reg = <0x0 0x20110000 0x0 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&plic>;
+			interrupts = <64>, <65>, <66>, <67>, <68>, <69>;
+			local-mac-address = [00 00 00 00 00 00];
+			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
+			clock-names = "pclk", "hclk";
+			resets = <&clkcfg CLK_MAC0>;
+			status = "disabled";
+		};
+
+		mac1: ethernet@20112000 {
+			compatible = "microchip,pic64gx-macb",
+				     "microchip,mpfs-macb",
+				     "cdns,macb";
+			reg = <0x0 0x20112000 0x0 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&plic>;
+			interrupts = <70>, <71>, <72>, <73>, <74>, <75>;
+			local-mac-address = [00 00 00 00 00 00];
+			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
+			clock-names = "pclk", "hclk";
+			resets = <&clkcfg CLK_MAC1>;
+			status = "disabled";
+		};
+
+		gpio0: gpio@20120000 {
+			compatible = "microchip,pic64gx-gpio",
+				     "microchip,mpfs-gpio";
+			reg = <0x0 0x20120000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <51>, <51>, <51>, <51>,
+				     <51>, <51>, <51>, <51>,
+				     <51>, <51>, <51>, <51>,
+				     <51>, <51>;
+			clocks = <&clkcfg CLK_GPIO0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <14>;
+			status = "disabled";
+		};
+
+		gpio1: gpio@20121000 {
+			compatible = "microchip,pic64gx-gpio",
+				     "microchip,mpfs-gpio";
+			reg = <0x0 0x20121000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <52>, <52>, <52>, <52>,
+				     <52>, <52>, <52>, <52>,
+				     <52>, <52>, <52>, <52>,
+				     <52>, <52>, <52>, <52>,
+				     <52>, <52>, <52>, <52>,
+				     <52>, <52>, <52>, <52>;
+			clocks = <&clkcfg CLK_GPIO1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <24>;
+			status = "disabled";
+		};
+
+		gpio2: gpio@20122000 {
+			compatible = "microchip,pic64gx-gpio",
+				     "microchip,mpfs-gpio";
+			reg = <0x0 0x20122000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>,
+				     <53>, <53>, <53>, <53>;
+			clocks = <&clkcfg CLK_GPIO2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <32>;
+			status = "disabled";
+		};
+
+		rtc: rtc@20124000 {
+			compatible = "microchip,pic64gx-rtc",
+				     "microchip,mpfs-rtc";
+			reg = <0x0 0x20124000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <80>, <81>;
+			clocks = <&clkcfg CLK_RTC>, <&clkcfg CLK_RTCREF>;
+			clock-names = "rtc", "rtcref";
+			status = "disabled";
+		};
+
+		usb: usb@20201000 {
+			compatible = "microchip,pic64gx-musb",
+				     "microchip,mpfs-musb";
+			reg = <0x0 0x20201000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <86>, <87>;
+			clocks = <&clkcfg CLK_USB>;
+			interrupt-names = "dma", "mc";
+			status = "disabled";
+		};
+
+		mbox: mailbox@37020000 {
+			compatible = "microchip,pic64gx-mailbox",
+				     "microchip,mpfs-mailbox";
+			reg = <0x0 0x37020000 0x0 0x58>,
+			      <0x0 0x2000318C 0x0 0x40>,
+			      <0x0 0x37020800 0x0 0x100>;
+			interrupt-parent = <&plic>;
+			interrupts = <96>;
+			#mbox-cells = <1>;
+			status = "disabled";
+		};
+
+		syscontroller_qspi: spi@37020100 {
+			compatible = "microchip,pic64gx-qspi",
+				     "microchip,coreqspi-rtl-v2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x37020100 0x0 0x100>;
+			interrupt-parent = <&plic>;
+			interrupts = <110>;
+			clocks = <&scbclk>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.30.2


