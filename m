Return-Path: <linux-kernel+bounces-443362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2019EEE21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094CC28636B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E7223E82;
	Thu, 12 Dec 2024 15:53:07 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63F223C6A;
	Thu, 12 Dec 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018786; cv=none; b=ViJr/kNu5sirT0c1/HVGMM2aUYPt2osCzwppBtAcLx3mmO+m3nrsjfaVXapBXZwrYsSdppEMrz/79hajXnVotBEmo9QeSp1E2/J4HRvlkrzNekowMATAlsCvdMVvOXb9zUfFdtdtmTGyRiCr+K0xSo4135hIOxY2EQ9AMAfJG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018786; c=relaxed/simple;
	bh=KuQ8PAcDGsjyoshMSkZQUSMVcSegeVk46GL1zQMRlks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTabazJy2VIOUp+io4ToKgJRE8kZkL9Yts/fuVAg9qyFbuojZ5SlRnJTtVAybUgnwJgNJPan3hDO3q5jTTO3a6zDRlcTQCU8DH0zmAQRjGjYrDUJhYc+aExa30vBmi4Gj/3rde98+Rgh++tuSLm9CBQHWGnFqMHCFFZur9C0WJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 12 Dec
 2024 23:52:42 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 12 Dec 2024 23:52:42 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <tglx@linutronix.de>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
	<dmitry.baryshkov@linaro.org>, <konradybcio@kernel.org>,
	<neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <soc@lists.linux.dev>
Subject: [PATCH v3 4/6] arm64: dts: aspeed: Add initial AST27XX device tree
Date: Thu, 12 Dec 2024 23:52:35 +0800
Message-ID: <20241212155237.848336-7-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add aspeed-g7.dtsi to be AST27XX device tree.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 236 ++++++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 21cd3a87f385..6a590a66e1a9 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y += amlogic
 subdir-y += apm
 subdir-y += apple
 subdir-y += arm
+subdir-y += aspeed
 subdir-y += bitmain
 subdir-y += broadcom
 subdir-y += cavium
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
new file mode 100644
index 000000000000..3f1e801dec4c
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+
+/ {
+	compatible = "aspeed,ast2700";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			enable-method = "psci";
+			reg = <0x0 0x1>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			enable-method = "psci";
+			reg = <0x0 0x2>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			enable-method = "psci";
+			reg = <0x0 0x3>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+	};
+
+	soc0: soc@10000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x10000000 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x1000>;
+			ranges = <0x0 0x0 0 0x12c02000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		intc0: interrupt-controller@12100000 {
+			compatible = "simple-mfd";
+			reg = <0 0x12100000 0x4000>;
+			ranges = <0x0 0x0 0x0 0x12100000 0x4000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			intc0_11: interrupt-controller@1b00 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x1b00 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+					     <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+					     <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+					     <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+					     <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+					     <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+		};
+
+		gic: interrupt-controller@12200000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0x12200000 0x10000>, /* GICD */
+			      <0 0x12280000 0x80000>, /* GICR */
+			      <0 0x40440000 0x1000>;  /* GICC */
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-parent = <&gic>;
+		};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x14000000 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x0 0x14c02000 0x1000>;
+			ranges = <0x0 0x0 0x0 0x14c02000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		intc1: interrupt-controller@14c18000 {
+			compatible = "simple-mfd";
+			reg = <0 0x14c18000 0x400>;
+			ranges = <0x0 0x0 0x0 0x14c18000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			intc1_0: interrupt-controller@100 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x100 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+
+			intc1_1: interrupt-controller@110 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x110 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+
+			intc1_2: interrupt-controller@120 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x120 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+
+			intc1_3: interrupt-controller@130 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x130 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+
+			intc1_4: interrupt-controller@140 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x140 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+
+			intc1_5: interrupt-controller@150 {
+				compatible = "aspeed,ast2700-intc-ic";
+				reg = <0x0 0x150 0x10>;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupts-extended = <&intc0_11 5 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			};
+		};
+
+		uart12: serial@14c33b00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33b00 0x100>;
+			interrupts-extended = <&intc1_4 18 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+		};
+	};
+};
-- 
2.34.1


