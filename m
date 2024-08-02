Return-Path: <linux-kernel+bounces-272343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD98945A7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98411B23FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE1B1D6193;
	Fri,  2 Aug 2024 09:06:20 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB81D54EB;
	Fri,  2 Aug 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589579; cv=none; b=nVHSRihhJE6tHhePF7HoslmbxBpGKFKliAFB932cpzmBmKvXBg2aSAAb86US3L2SR50u7mE9hJnOIOw6fXJPttjWrRmEfnzLsRkNYUYQL0z9K/gQ0IDS7gSxt9fFkzZxm+v8t8JcYaLTjGny8+spwXfivQHtn/hvwSEZoQkkRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589579; c=relaxed/simple;
	bh=v8UC+BcyUjcKe1V7WwSHfVEphUcMN/i9HlnF04ekApU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNvTHUu/7v0VE2gpokLSMZP1C51o+thaC3+rQ+DUw4cZVMzUg7aBjRy8xZUkxPayCggn6t4Wu5HWX9wU+D3q2UUjYS+3Hd4ef7JpVLsnViWQrQkHxwQXpNNsm1tZ3W2qAi292PDQjGnSHgIfNcAmFk+zstzyrvY50gMdlrJXROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 2 Aug
 2024 17:05:52 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 2 Aug 2024 17:05:52 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <lee@kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
	<olof@lixom.net>, <soc@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>, <quic_bjorande@quicinc.com>,
	<geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
	<shawnguo@kernel.org>, <neil.armstrong@linaro.org>,
	<m.szyprowski@samsung.com>, <nfraprado@collabora.com>, <u-kumar1@ti.com>,
	<kevin_chen@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 8/9] arm64: dts: aspeed: Add initial AST27XX device tree
Date: Fri, 2 Aug 2024 17:05:43 +0800
Message-ID: <20240802090544.2741206-10-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
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
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 185 ++++++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 21cd3a87f385..c909c19dc5dd 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -34,3 +34,4 @@ subdir-y += tesla
 subdir-y += ti
 subdir-y += toshiba
 subdir-y += xilinx
+subdir-y += aspeed
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
new file mode 100644
index 000000000000..85f7977a753a
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <dt-bindings/clock/aspeed,ast2700-clk.h>
+#include <dt-bindings/reset/aspeed,ast2700-reset.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+
+/ {
+	compatible = "aspeed,ast2700";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@2 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@3 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-unified;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupt-parent = <&gic>;
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
+		interrupt-parent = <&gic>;
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
+		reg = <0x0 0x10000000 0x0 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@12200000 {
+			compatible = "arm,gic-v3";
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			reg = <0 0x12200000 0 0x10000>, /* GICD */
+				  <0 0x12280000 0 0x80000>, /* GICR */
+				  <0 0x40440000 0 0x1000>;  /* GICC */
+			#address-cells = <2>;
+			#size-cells = <2>;
+		};
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			silicon-id@0 {
+				compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+				reg = <0 0x0 0 0x4>;
+			};
+
+			soc0_rst: reset-controller@200 {
+				reg = <0 0x200 0 0x40>;
+			};
+
+			soc0_clk: clock-controller@240 {
+				reg = <0 0x240 0 0x1c0>;
+			};
+		};
+
+		uart4: serial@12c1a000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x12c1a000 0x0 0x1000>;
+			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+		};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x14000000 0x0 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x0 0x14c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x0 0x14c02000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			soc1_rst: reset-controller@200 {
+				reg = <0 0x200 0 0x40>;
+				#reset-cells = <1>;
+			};
+
+			soc1_clk: clock-controller@240 {
+				reg = <0 0x240 0 0x1c0>;
+			};
+		};
+	};
+};
-- 
2.34.1


