Return-Path: <linux-kernel+bounces-329121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F1978DA8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D8E1C22628
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373D3BBEA;
	Sat, 14 Sep 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHUq/obB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94364AEF5;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291533; cv=none; b=emTENZ3oxnJWBSjOzKRn7IKIw1xUZgI7Hi0D7mJrB/K02BxXnh5Dkf1qiu94LB+E10TLy2rNtX0UIMzvnfVq+8AjDn5qWn+lFBwEd5WKUCz+uDdrOEgBod3wpcVbgPOLnY1oIK4HCbRBvcII6YptVQNTpD7LSeMPffMQaqsFNiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291533; c=relaxed/simple;
	bh=s5bKtB8PUeJW1Zs1aoJO0tNInKu9PxTfGSkPxQuxw+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6iuDpR6ncK2dUXK79DGdWQk1F2n+kuPGXkPgj4+ZrMpER9+ULsBORY5yJW1hjY0h1myqFi/Wl6QcO0JiuKN5tjnVV7ZP1NavOymi09mb4pg72SbovsMSnLbPvK/x1z1WlBDlYnHIffwNgNElLXHOTs54/qI5XYcraUU/7IUCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHUq/obB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86D80C4CED0;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726291532;
	bh=s5bKtB8PUeJW1Zs1aoJO0tNInKu9PxTfGSkPxQuxw+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PHUq/obBRe0zda2Vth6qO0LH1GqRBE/68K/r+L8hmx1Lef7YY+cR4ksDNAh0hRy6s
	 ctqbigjyAWIsi0gdBI2r1DGGnVv1I7mwDBR0vMvt8SBpTE5z7jw0zD6CRRG1S5X71q
	 zO2FxmCK+wtiUYX0/JXghOCv2QB5zxJs9PJBo3PtKq1QolFBDll4MMeM2pGvCOU25z
	 vzfadO5MONncTxqSYP/heACHaWQp1eTrqmCN2+s0d3nRQx8jhz4PwJtml1igDe5rA0
	 2YLpBPn7YZnXgpLgerWXWoAU6nazsxU0z8kg0yAzBojD/AU1JOCrueHmiprts/C25e
	 4+8b/oAIvyjaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D64FC6194;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Sat, 14 Sep 2024 13:25:25 +0800
Subject: [PATCH 3/5] dt-bindings: clock: add Amlogic A5 peripherals clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-a5-clk-v1-3-5ee2c4f1b08c@amlogic.com>
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
In-Reply-To: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726291530; l=9179;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=uBo/4Nz74pi8prQxzPPRE4M3f5ApLdEU+mDCOCPA40o=;
 b=4QUBdvlEBLROw/h9SZTuJCpsTOG0TATYpf7ThOOmtnof51aL4qSMY+/t+bPAwHgpK3JdMBpDX
 AZG9MEOabCOD38InhNQZ3mJleSu28xtwgjjlCdM90Z9HUtIn2kqKjBf
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the peripherals clock controller dt-bindings for Amlogic A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../clock/amlogic,a5-peripherals-clkc.yaml         | 126 +++++++++++++++++++
 .../clock/amlogic,a5-peripherals-clkc.h            | 139 +++++++++++++++++++++
 2 files changed, 265 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
new file mode 100644
index 000000000000..6529b7c79768
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,a5-peripherals-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A5 series Peripheral Clock Controller
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Chuan Liu <chuan.liu@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,a5-peripherals-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 18
+    items:
+      - description: input oscillator (usually at 24MHz)
+      - description: input oscillators multiplexer
+      - description: input fix pll
+      - description: input fclk div 2
+      - description: input fclk div 2p5
+      - description: input fclk div 3
+      - description: input fclk div 4
+      - description: input fclk div 5
+      - description: input fclk div 7
+      - description: input mpll2
+      - description: input mpll3
+      - description: input gp0 pll
+      - description: input gp1 pll
+      - description: input hifi pll
+      - description: input sys clk
+      - description: input axi clk
+      - description: input sys pll div 16
+      - description: input cpu clk div 16
+      - description: input pad clock for rtc clk (optional)
+
+  clock-names:
+    minItems: 18
+    items:
+      - const: xtal_24m
+      - const: oscin
+      - const: fix
+      - const: fdiv2
+      - const: fdiv2p5
+      - const: fdiv3
+      - const: fdiv4
+      - const: fdiv5
+      - const: fdiv7
+      - const: mpll2
+      - const: mpll3
+      - const: gp0
+      - const: gp1
+      - const: hifi
+      - const: sysclk
+      - const: axiclk
+      - const: sysplldiv16
+      - const: cpudiv16
+      - const: pad_osc
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@0 {
+            compatible = "amlogic,a5-peripherals-clkc";
+            reg = <0x0 0x0 0x0 0x224>;
+            #clock-cells = <1>;
+            clocks = <&xtal_24m>,
+                     <&scmi_clk 0>,
+                     <&scmi_clk 7>,
+                     <&scmi_clk 15>,
+                     <&scmi_clk 17>,
+                     <&scmi_clk 19>,
+                     <&scmi_clk 21>,
+                     <&scmi_clk 23>,
+                     <&scmi_clk 25>,
+                     <&clkc_pll 6>,
+                     <&clkc_pll 8>,
+                     <&clkc_pll 10>,
+                     <&scmi_clk 5>,
+                     <&clkc_pll 12>,
+                     <&scmi_clk 1>,
+                     <&scmi_clk 2>,
+                     <&scmi_clk 9>,
+                     <&scmi_clk 10>;
+            clock-names = "xtal_24m",
+                          "oscin",
+                          "fix",
+                          "fdiv2",
+                          "fdiv2p5",
+                          "fdiv3",
+                          "fdiv4",
+                          "fdiv5",
+                          "fdiv7",
+                          "mpll2",
+                          "mpll3",
+                          "gp0",
+                          "gp1",
+                          "hifi",
+                          "sysclk",
+                          "axiclk",
+                          "sysplldiv16",
+                          "cpudiv16";
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
new file mode 100644
index 000000000000..0ba61520e2c1
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
+
+#define CLKID_RTC_XTAL_CLKIN			0
+#define CLKID_RTC_32K_DIV			1
+#define CLKID_RTC_32K_MUX			2
+#define CLKID_RTC_32K				3
+#define CLKID_RTC_CLK				4
+#define CLKID_SYS_RESET_CTRL			5
+#define CLKID_SYS_PWR_CTRL			6
+#define CLKID_SYS_PAD_CTRL			7
+#define CLKID_SYS_CTRL				8
+#define CLKID_SYS_TS_PLL			9
+#define CLKID_SYS_DEV_ARB			10
+#define CLKID_SYS_MMC_PCLK			11
+#define CLKID_SYS_MAILBOX			12
+#define CLKID_SYS_CPU_CTRL			13
+#define CLKID_SYS_JTAG_CTRL			14
+#define CLKID_SYS_IR_CTRL			15
+#define CLKID_SYS_IRQ_CTRL			16
+#define CLKID_SYS_MSR_CLK			17
+#define CLKID_SYS_ROM				18
+#define CLKID_SYS_CPU_ARB			19
+#define CLKID_SYS_RSA				20
+#define CLKID_SYS_SAR_ADC			21
+#define CLKID_SYS_STARTUP			22
+#define CLKID_SYS_SECURE			23
+#define CLKID_SYS_SPIFC				24
+#define CLKID_SYS_DSPA				25
+#define CLKID_SYS_NNA				26
+#define CLKID_SYS_ETH_MAC			27
+#define CLKID_SYS_GIC				28
+#define CLKID_SYS_RAMA				29
+#define CLKID_SYS_BIG_NIC			30
+#define CLKID_SYS_RAMB				31
+#define CLKID_SYS_AUDIO_TOP			32
+#define CLKID_SYS_AUDIO_VAD			33
+#define CLKID_SYS_USB				34
+#define CLKID_SYS_SD_EMMC_A			35
+#define CLKID_SYS_SD_EMMC_C			36
+#define CLKID_SYS_PWM_AB			37
+#define CLKID_SYS_PWM_CD			38
+#define CLKID_SYS_PWM_EF			39
+#define CLKID_SYS_PWM_GH			40
+#define CLKID_SYS_SPICC_1			41
+#define CLKID_SYS_SPICC_0			42
+#define CLKID_SYS_UART_A			43
+#define CLKID_SYS_UART_B			44
+#define CLKID_SYS_UART_C			45
+#define CLKID_SYS_UART_D			46
+#define CLKID_SYS_UART_E			47
+#define CLKID_SYS_I2C_M_A			48
+#define CLKID_SYS_I2C_M_B			49
+#define CLKID_SYS_I2C_M_C			50
+#define CLKID_SYS_I2C_M_D			51
+#define CLKID_SYS_RTC				52
+#define CLKID_AXI_AUDIO_VAD			53
+#define CLKID_AXI_AUDIO_TOP			54
+#define CLKID_AXI_SYS_NIC			55
+#define CLKID_AXI_RAMB				56
+#define CLKID_AXI_RAMA				57
+#define CLKID_AXI_CPU_DMC			58
+#define CLKID_AXI_NNA				59
+#define CLKID_AXI_DEV1_DMC			60
+#define CLKID_AXI_DEV0_DMC			61
+#define CLKID_AXI_DSP_DMC			62
+#define CLKID_12_24M_IN				63
+#define CLKID_12M_24M				64
+#define CLKID_FCLK_25M_DIV			65
+#define CLKID_FCLK_25M				66
+#define CLKID_GEN_SEL				67
+#define CLKID_GEN_DIV				68
+#define CLKID_GEN				69
+#define CLKID_SARADC_SEL			70
+#define CLKID_SARADC_DIV			71
+#define CLKID_SARADC				72
+#define CLKID_PWM_A_SEL				73
+#define CLKID_PWM_A_DIV				74
+#define CLKID_PWM_A				75
+#define CLKID_PWM_B_SEL				76
+#define CLKID_PWM_B_DIV				77
+#define CLKID_PWM_B				78
+#define CLKID_PWM_C_SEL				79
+#define CLKID_PWM_C_DIV				80
+#define CLKID_PWM_C				81
+#define CLKID_PWM_D_SEL				82
+#define CLKID_PWM_D_DIV				83
+#define CLKID_PWM_D				84
+#define CLKID_PWM_E_SEL				85
+#define CLKID_PWM_E_DIV				86
+#define CLKID_PWM_E				87
+#define CLKID_PWM_F_SEL				88
+#define CLKID_PWM_F_DIV				89
+#define CLKID_PWM_F				90
+#define CLKID_PWM_G_SEL				91
+#define CLKID_PWM_G_DIV				92
+#define CLKID_PWM_G				93
+#define CLKID_PWM_H_SEL				94
+#define CLKID_PWM_H_DIV				95
+#define CLKID_PWM_H				96
+#define CLKID_SPICC_0_SEL			97
+#define CLKID_SPICC_0_DIV			98
+#define CLKID_SPICC_0				99
+#define CLKID_SPICC_1_SEL			100
+#define CLKID_SPICC_1_DIV			101
+#define CLKID_SPICC_1				102
+#define CLKID_SD_EMMC_A_SEL			103
+#define CLKID_SD_EMMC_A_DIV			104
+#define CLKID_SD_EMMC_A				105
+#define CLKID_SD_EMMC_C_SEL			106
+#define CLKID_SD_EMMC_C_DIV			107
+#define CLKID_SD_EMMC_C				108
+#define CLKID_TS_DIV				109
+#define CLKID_TS				110
+#define CLKID_ETH_125M_DIV			111
+#define CLKID_ETH_125M				112
+#define CLKID_ETH_RMII_DIV			113
+#define CLKID_ETH_RMII				114
+#define CLKID_DSPA_0_SEL			115
+#define CLKID_DSPA_0_DIV			116
+#define CLKID_DSPA_0				117
+#define CLKID_DSPA_1_SEL			118
+#define CLKID_DSPA_1_DIV			119
+#define CLKID_DSPA_1				120
+#define CLKID_DSPA				121
+#define CLKID_NNA_CORE_SEL			122
+#define CLKID_NNA_CORE_DIV			123
+#define CLKID_NNA_CORE				124
+#define CLKID_NNA_AXI_SEL			125
+#define CLKID_NNA_AXI_DIV			126
+#define CLKID_NNA_AXI				127
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H */

-- 
2.37.1



