Return-Path: <linux-kernel+bounces-536057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5734A47B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC48166031
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C322A801;
	Thu, 27 Feb 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="W0COZQ0r"
Received: from mail-m15592.qiye.163.com (mail-m15592.qiye.163.com [101.71.155.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2622A7E7;
	Thu, 27 Feb 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653982; cv=none; b=rDLPAVHzVTB8D+83ffD8xYMRCg7B8kPz2JzGhPSNt0bteariohpGWkhwkE/cXkyN1D4+AaTHwNOvKVO2KQyyGdAfp1BSzlbGO7axCbfgNQM9tIQMRy9gkmgY7kRWIAVG8q3UmgH9nWXHRjA86CFjgDHbWfmRpQYDlmdzRuatHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653982; c=relaxed/simple;
	bh=mhP9nqXNqa8vRbAjLlT8FHp7/Db7pP6/yLHy88pkQkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0DT/OpPhK/qYzW8ky1CqVQAL/fGqHqNoG3SVDUPt4be4ebb6qhjf9r3c0wdfEEreO/6kQYgLC7F1vUYbXpx6YoXpbLxiNabT8uItZ7kiH5PMHfprm6uy5cCTrM4lbugEt2JLucxQiEvWpOd12x5qm4CP657qAzvqbbibifzeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=W0COZQ0r; arc=none smtp.client-ip=101.71.155.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id c6596a40;
	Thu, 27 Feb 2025 18:59:26 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: clock: Add RK3562 cru
Date: Thu, 27 Feb 2025 18:59:14 +0800
Message-Id: <20250227105916.2340856-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227105916.2340856-1-kever.yang@rock-chips.com>
References: <20250227105916.2340856-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSU4fVkIaTEhPHx9OH01OGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a95470fb37803afkunmc6596a40
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006NAw5ATIXHQ0QAiIoOhAh
	Sx8KCkNVSlVKTE9LTU5IQk1DTE1MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlOTk9LNwY+
DKIM-Signature:a=rsa-sha256;
	b=W0COZQ0rc/DTla/Wf9Xw4MNKABytbKqpocT9yifSHKUJTGu3PkbrPpGvLZVyc9NhsdltaqCoCPpOWFVztHcrPkAhN6nhEvLpxdfZGZg5Xd8i8l4k8F0iLTiPLpdxzAJkjY91APdkJZo4p3yKfwCvAOkX1ey8cRPKOiMVFDiNoVs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/V4IFbeREKEwvNdBd5TYqLsAVxVPfUBIm4PrJyF4iLU=;
	h=date:mime-version:subject:message-id:from;

Document the device tree bindings of the rockchip rk3562 SoC
clock and reset unit.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3: None
Changes in v2:
- remove rockchip,grf info
- Update file license

 .../bindings/clock/rockchip,rk3562-cru.yaml   |  55 +++
 .../dt-bindings/clock/rockchip,rk3562-cru.h   | 379 ++++++++++++++++++
 .../dt-bindings/reset/rockchip,rk3562-cru.h   | 358 +++++++++++++++++
 3 files changed, 792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3562-cru.yaml
 create mode 100644 include/dt-bindings/clock/rockchip,rk3562-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3562-cru.h

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3562-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3562-cru.yaml
new file mode 100644
index 000000000000..36a353f5c42a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3562-cru.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3562-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip rk3562 Clock and Reset Control Module
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description:
+  The RK3562 clock controller generates the clock and also implements a reset
+  controller for SoC peripherals. For example it provides SCLK_UART2 and
+  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2 for the second UART
+  module.
+
+properties:
+  compatible:
+    const: rockchip,rk3562-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: xin24m
+      - const: xin32k
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ff100000 {
+      compatible = "rockchip,rk3562-cru";
+      reg = <0xff100000 0x40000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/rockchip,rk3562-cru.h b/include/dt-bindings/clock/rockchip,rk3562-cru.h
new file mode 100644
index 000000000000..a5b0b153209c
--- /dev/null
+++ b/include/dt-bindings/clock/rockchip,rk3562-cru.h
@@ -0,0 +1,379 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022-2025 Rockchip Electronics Co., Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3562_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3562_H
+
+/* cru-clocks indices */
+
+/* cru plls */
+#define PLL_DMPLL0			0
+#define PLL_APLL			1
+#define PLL_GPLL			2
+#define PLL_VPLL			3
+#define PLL_HPLL			4
+#define PLL_CPLL			5
+#define PLL_DPLL			6
+#define PLL_DMPLL1			7
+
+/* cru clocks */
+#define ARMCLK				8
+#define CLK_GPU				9
+#define ACLK_RKNN			10
+#define CLK_DDR				11
+#define CLK_MATRIX_50M_SRC		12
+#define CLK_MATRIX_100M_SRC		13
+#define CLK_MATRIX_125M_SRC		14
+#define CLK_MATRIX_200M_SRC		15
+#define CLK_MATRIX_300M_SRC		16
+#define ACLK_TOP			17
+#define ACLK_TOP_VIO			18
+#define CLK_CAM0_OUT2IO			19
+#define CLK_CAM1_OUT2IO			20
+#define CLK_CAM2_OUT2IO			21
+#define CLK_CAM3_OUT2IO			22
+#define ACLK_BUS			23
+#define HCLK_BUS			24
+#define PCLK_BUS			25
+#define PCLK_I2C1			26
+#define PCLK_I2C2			27
+#define PCLK_I2C3			28
+#define PCLK_I2C4			29
+#define PCLK_I2C5			30
+#define CLK_I2C				31
+#define CLK_I2C1			32
+#define CLK_I2C2			33
+#define CLK_I2C3			34
+#define CLK_I2C4			35
+#define CLK_I2C5			36
+#define DCLK_BUS_GPIO			37
+#define DCLK_BUS_GPIO3			38
+#define DCLK_BUS_GPIO4			39
+#define PCLK_TIMER			40
+#define CLK_TIMER0			41
+#define CLK_TIMER1			42
+#define CLK_TIMER2			43
+#define CLK_TIMER3			44
+#define CLK_TIMER4			45
+#define CLK_TIMER5			46
+#define PCLK_STIMER			47
+#define CLK_STIMER0			48
+#define CLK_STIMER1			49
+#define PCLK_WDTNS			50
+#define CLK_WDTNS			51
+#define PCLK_GRF			52
+#define PCLK_SGRF			53
+#define PCLK_MAILBOX			54
+#define PCLK_INTC			55
+#define ACLK_BUS_GIC400			56
+#define ACLK_BUS_SPINLOCK		57
+#define ACLK_DCF			58
+#define PCLK_DCF			59
+#define FCLK_BUS_CM0_CORE		60
+#define CLK_BUS_CM0_RTC			61
+#define HCLK_ICACHE			62
+#define HCLK_DCACHE			63
+#define PCLK_TSADC			64
+#define CLK_TSADC			65
+#define CLK_TSADC_TSEN			66
+#define PCLK_DFT2APB			67
+#define CLK_SARADC_VCCIO156		68
+#define PCLK_GMAC			69
+#define ACLK_GMAC			70
+#define CLK_GMAC_125M_CRU_I		71
+#define CLK_GMAC_50M_CRU_I		72
+#define CLK_GMAC_50M_O			73
+#define CLK_GMAC_ETH_OUT2IO		74
+#define PCLK_APB2ASB_VCCIO156		75
+#define PCLK_TO_VCCIO156		76
+#define PCLK_DSIPHY			77
+#define PCLK_DSITX			78
+#define PCLK_CPU_EMA_DET		79
+#define PCLK_HASH			80
+#define PCLK_TOPCRU			81
+#define PCLK_ASB2APB_VCCIO156		82
+#define PCLK_IOC_VCCIO156		83
+#define PCLK_GPIO3_VCCIO156		84
+#define PCLK_GPIO4_VCCIO156		85
+#define PCLK_SARADC_VCCIO156		86
+#define PCLK_MAC100			87
+#define ACLK_MAC100			89
+#define CLK_MAC100_50M_MATRIX		90
+#define HCLK_CORE			91
+#define PCLK_DDR			92
+#define CLK_MSCH_BRG_BIU		93
+#define PCLK_DDR_HWLP			94
+#define PCLK_DDR_UPCTL			95
+#define PCLK_DDR_PHY			96
+#define PCLK_DDR_DFICTL			97
+#define PCLK_DDR_DMA2DDR		98
+#define PCLK_DDR_MON			99
+#define TMCLK_DDR_MON			100
+#define PCLK_DDR_GRF			101
+#define PCLK_DDR_CRU			102
+#define PCLK_SUBDDR_CRU			103
+#define CLK_GPU_PRE			104
+#define ACLK_GPU_PRE			105
+#define CLK_GPU_BRG			107
+#define CLK_NPU_PRE			108
+#define HCLK_NPU_PRE			109
+#define HCLK_RKNN			111
+#define ACLK_PERI			112
+#define HCLK_PERI			113
+#define PCLK_PERI			114
+#define PCLK_PERICRU			115
+#define HCLK_SAI0			116
+#define CLK_SAI0_SRC			117
+#define CLK_SAI0_FRAC			118
+#define CLK_SAI0			119
+#define MCLK_SAI0			120
+#define MCLK_SAI0_OUT2IO		121
+#define HCLK_SAI1			122
+#define CLK_SAI1_SRC			123
+#define CLK_SAI1_FRAC			124
+#define CLK_SAI1			125
+#define MCLK_SAI1			126
+#define MCLK_SAI1_OUT2IO		127
+#define HCLK_SAI2			128
+#define CLK_SAI2_SRC			129
+#define CLK_SAI2_FRAC			130
+#define CLK_SAI2			131
+#define MCLK_SAI2			132
+#define MCLK_SAI2_OUT2IO		133
+#define HCLK_DSM			134
+#define CLK_DSM				135
+#define HCLK_PDM			136
+#define MCLK_PDM			137
+#define HCLK_SPDIF			138
+#define CLK_SPDIF_SRC			139
+#define CLK_SPDIF_FRAC			140
+#define CLK_SPDIF			141
+#define MCLK_SPDIF			142
+#define HCLK_SDMMC0			143
+#define CCLK_SDMMC0			144
+#define HCLK_SDMMC1			145
+#define CCLK_SDMMC1			146
+#define SCLK_SDMMC0_DRV			147
+#define SCLK_SDMMC0_SAMPLE		148
+#define SCLK_SDMMC1_DRV			149
+#define SCLK_SDMMC1_SAMPLE		150
+#define HCLK_EMMC			151
+#define ACLK_EMMC			152
+#define CCLK_EMMC			153
+#define BCLK_EMMC			154
+#define TMCLK_EMMC			155
+#define SCLK_SFC			156
+#define HCLK_SFC			157
+#define HCLK_USB2HOST			158
+#define HCLK_USB2HOST_ARB		159
+#define PCLK_SPI1			160
+#define CLK_SPI1			161
+#define SCLK_IN_SPI1			162
+#define PCLK_SPI2			163
+#define CLK_SPI2			164
+#define SCLK_IN_SPI2			165
+#define PCLK_UART1			166
+#define PCLK_UART2			167
+#define PCLK_UART3			168
+#define PCLK_UART4			169
+#define PCLK_UART5			170
+#define PCLK_UART6			171
+#define PCLK_UART7			172
+#define PCLK_UART8			173
+#define PCLK_UART9			174
+#define CLK_UART1_SRC			175
+#define CLK_UART1_FRAC			176
+#define CLK_UART1			177
+#define SCLK_UART1			178
+#define CLK_UART2_SRC			179
+#define CLK_UART2_FRAC			180
+#define CLK_UART2			181
+#define SCLK_UART2			182
+#define CLK_UART3_SRC			183
+#define CLK_UART3_FRAC			184
+#define CLK_UART3			185
+#define SCLK_UART3			186
+#define CLK_UART4_SRC			187
+#define CLK_UART4_FRAC			188
+#define CLK_UART4			189
+#define SCLK_UART4			190
+#define CLK_UART5_SRC			191
+#define CLK_UART5_FRAC			192
+#define CLK_UART5			193
+#define SCLK_UART5			194
+#define CLK_UART6_SRC			195
+#define CLK_UART6_FRAC			196
+#define CLK_UART6			197
+#define SCLK_UART6			198
+#define CLK_UART7_SRC			199
+#define CLK_UART7_FRAC			200
+#define CLK_UART7			201
+#define SCLK_UART7			202
+#define CLK_UART8_SRC			203
+#define CLK_UART8_FRAC			204
+#define CLK_UART8			205
+#define SCLK_UART8			206
+#define CLK_UART9_SRC			207
+#define CLK_UART9_FRAC			208
+#define CLK_UART9			209
+#define SCLK_UART9			210
+#define PCLK_PWM1_PERI			211
+#define CLK_PWM1_PERI			212
+#define CLK_CAPTURE_PWM1_PERI		213
+#define PCLK_PWM2_PERI			214
+#define CLK_PWM2_PERI			215
+#define CLK_CAPTURE_PWM2_PERI		216
+#define PCLK_PWM3_PERI			217
+#define CLK_PWM3_PERI			218
+#define CLK_CAPTURE_PWM3_PERI		219
+#define PCLK_CAN0			220
+#define CLK_CAN0			221
+#define PCLK_CAN1			222
+#define CLK_CAN1			223
+#define ACLK_CRYPTO			224
+#define HCLK_CRYPTO			225
+#define PCLK_CRYPTO			226
+#define CLK_CORE_CRYPTO			227
+#define CLK_PKA_CRYPTO			228
+#define HCLK_KLAD			229
+#define PCLK_KEY_READER			230
+#define HCLK_RK_RNG_NS			231
+#define HCLK_RK_RNG_S			232
+#define HCLK_TRNG_NS			233
+#define HCLK_TRNG_S			234
+#define HCLK_CRYPTO_S			235
+#define PCLK_PERI_WDT			236
+#define TCLK_PERI_WDT			237
+#define ACLK_SYSMEM			238
+#define HCLK_BOOTROM			239
+#define PCLK_PERI_GRF			240
+#define ACLK_DMAC			241
+#define ACLK_RKDMAC			242
+#define PCLK_OTPC_NS			243
+#define CLK_SBPI_OTPC_NS		244
+#define CLK_USER_OTPC_NS		245
+#define PCLK_OTPC_S			246
+#define CLK_SBPI_OTPC_S			247
+#define CLK_USER_OTPC_S			248
+#define CLK_OTPC_ARB			249
+#define PCLK_OTPPHY			250
+#define PCLK_USB2PHY			251
+#define PCLK_PIPEPHY			252
+#define PCLK_SARADC			253
+#define CLK_SARADC			254
+#define PCLK_IOC_VCCIO234		255
+#define PCLK_PERI_GPIO1			256
+#define PCLK_PERI_GPIO2			257
+#define DCLK_PERI_GPIO			258
+#define DCLK_PERI_GPIO1			259
+#define DCLK_PERI_GPIO2			260
+#define ACLK_PHP			261
+#define PCLK_PHP			262
+#define ACLK_PCIE20_MST			263
+#define ACLK_PCIE20_SLV			264
+#define ACLK_PCIE20_DBI			265
+#define PCLK_PCIE20			266
+#define CLK_PCIE20_AUX			267
+#define ACLK_USB3OTG			268
+#define CLK_USB3OTG_SUSPEND		269
+#define CLK_USB3OTG_REF			270
+#define CLK_PIPEPHY_REF_FUNC		271
+#define CLK_200M_PMU			272
+#define CLK_RTC_32K			273
+#define CLK_RTC32K_FRAC			274
+#define BUSCLK_PDPMU0			275
+#define PCLK_PMU0_CRU			276
+#define PCLK_PMU0_PMU			277
+#define CLK_PMU0_PMU			278
+#define PCLK_PMU0_HP_TIMER		279
+#define CLK_PMU0_HP_TIMER		280
+#define CLK_PMU0_32K_HP_TIMER		281
+#define PCLK_PMU0_PVTM			282
+#define CLK_PMU0_PVTM			283
+#define PCLK_IOC_PMUIO			284
+#define PCLK_PMU0_GPIO0			285
+#define DBCLK_PMU0_GPIO0		286
+#define PCLK_PMU0_GRF			287
+#define PCLK_PMU0_SGRF			288
+#define CLK_DDR_FAIL_SAFE		289
+#define PCLK_PMU0_SCRKEYGEN		290
+#define PCLK_PMU1_CRU			291
+#define HCLK_PMU1_MEM			292
+#define PCLK_PMU0_I2C0			293
+#define CLK_PMU0_I2C0			294
+#define PCLK_PMU1_UART0			295
+#define CLK_PMU1_UART0_SRC		296
+#define CLK_PMU1_UART0_FRAC		297
+#define CLK_PMU1_UART0			298
+#define SCLK_PMU1_UART0			299
+#define PCLK_PMU1_SPI0			300
+#define CLK_PMU1_SPI0			301
+#define SCLK_IN_PMU1_SPI0		302
+#define PCLK_PMU1_PWM0			303
+#define CLK_PMU1_PWM0			304
+#define CLK_CAPTURE_PMU1_PWM0		305
+#define CLK_PMU1_WIFI			306
+#define FCLK_PMU1_CM0_CORE		307
+#define CLK_PMU1_CM0_RTC		308
+#define PCLK_PMU1_WDTNS			309
+#define CLK_PMU1_WDTNS			310
+#define PCLK_PMU1_MAILBOX		311
+#define CLK_PIPEPHY_DIV			312
+#define CLK_PIPEPHY_XIN24M		313
+#define CLK_PIPEPHY_REF			314
+#define CLK_24M_SSCSRC			315
+#define CLK_USB2PHY_XIN24M		316
+#define CLK_USB2PHY_REF			317
+#define CLK_MIPIDSIPHY_XIN24M		318
+#define CLK_MIPIDSIPHY_REF		319
+#define ACLK_RGA_PRE			320
+#define HCLK_RGA_PRE			321
+#define ACLK_RGA			322
+#define HCLK_RGA			323
+#define CLK_RGA_CORE			324
+#define ACLK_JDEC			325
+#define HCLK_JDEC			326
+#define ACLK_VDPU_PRE			327
+#define CLK_RKVDEC_HEVC_CA		328
+#define HCLK_VDPU_PRE			329
+#define ACLK_RKVDEC			330
+#define HCLK_RKVDEC			331
+#define CLK_RKVENC_CORE			332
+#define ACLK_VEPU_PRE			333
+#define HCLK_VEPU_PRE			334
+#define ACLK_RKVENC			335
+#define HCLK_RKVENC			336
+#define ACLK_VI				337
+#define HCLK_VI				338
+#define PCLK_VI				339
+#define ACLK_ISP			340
+#define HCLK_ISP			341
+#define CLK_ISP				342
+#define ACLK_VICAP			343
+#define HCLK_VICAP			344
+#define DCLK_VICAP			345
+#define CSIRX0_CLK_DATA			346
+#define CSIRX1_CLK_DATA			347
+#define CSIRX2_CLK_DATA			348
+#define CSIRX3_CLK_DATA			349
+#define PCLK_CSIHOST0			350
+#define PCLK_CSIHOST1			351
+#define PCLK_CSIHOST2			352
+#define PCLK_CSIHOST3			353
+#define PCLK_CSIPHY0			354
+#define PCLK_CSIPHY1			355
+#define ACLK_VO_PRE			356
+#define HCLK_VO_PRE			357
+#define ACLK_VOP			358
+#define HCLK_VOP			359
+#define DCLK_VOP			360
+#define DCLK_VOP1			361
+#define ACLK_CRYPTO_S			362
+#define PCLK_CRYPTO_S			363
+#define CLK_CORE_CRYPTO_S		364
+#define CLK_PKA_CRYPTO_S		365
+
+#endif
diff --git a/include/dt-bindings/reset/rockchip,rk3562-cru.h b/include/dt-bindings/reset/rockchip,rk3562-cru.h
new file mode 100644
index 000000000000..a74471d7d2a9
--- /dev/null
+++ b/include/dt-bindings/reset/rockchip,rk3562-cru.h
@@ -0,0 +1,358 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024-2025 Rockchip Electronics Co. Ltd.
+ *
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3562_H
+#define _DT_BINDINGS_RESET_ROCKCHIP_RK3562_H
+
+/********Name=SOFTRST_CON01,Offset=0x404********/
+#define SRST_A_TOP_BIU			0
+#define SRST_A_TOP_VIO_BIU		1
+#define SRST_REF_PVTPLL_LOGIC		2
+/********Name=SOFTRST_CON03,Offset=0x40C********/
+#define SRST_NCOREPORESET0		3
+#define SRST_NCOREPORESET1		4
+#define SRST_NCOREPORESET2		5
+#define SRST_NCOREPORESET3		6
+#define SRST_NCORESET0			7
+#define SRST_NCORESET1			8
+#define SRST_NCORESET2			9
+#define SRST_NCORESET3			10
+#define SRST_NL2RESET			11
+/********Name=SOFTRST_CON04,Offset=0x410********/
+#define SRST_DAP			12
+#define SRST_P_DBG_DAPLITE		13
+#define SRST_REF_PVTPLL_CORE		14
+/********Name=SOFTRST_CON05,Offset=0x414********/
+#define SRST_A_CORE_BIU			15
+#define SRST_P_CORE_BIU			16
+#define SRST_H_CORE_BIU			17
+/********Name=SOFTRST_CON06,Offset=0x418********/
+#define SRST_A_NPU_BIU			18
+#define SRST_H_NPU_BIU			19
+#define SRST_A_RKNN			20
+#define SRST_H_RKNN			21
+#define SRST_REF_PVTPLL_NPU		22
+/********Name=SOFTRST_CON08,Offset=0x420********/
+#define SRST_A_GPU_BIU			23
+#define SRST_GPU			24
+#define SRST_REF_PVTPLL_GPU		25
+#define SRST_GPU_BRG_BIU		26
+/********Name=SOFTRST_CON09,Offset=0x424********/
+#define SRST_RKVENC_CORE		27
+#define SRST_A_VEPU_BIU			28
+#define SRST_H_VEPU_BIU			29
+#define SRST_A_RKVENC			30
+#define SRST_H_RKVENC			31
+/********Name=SOFTRST_CON10,Offset=0x428********/
+#define SRST_RKVDEC_HEVC_CA		32
+#define SRST_A_VDPU_BIU			33
+#define SRST_H_VDPU_BIU			34
+#define SRST_A_RKVDEC			35
+#define SRST_H_RKVDEC			36
+/********Name=SOFTRST_CON11,Offset=0x42C********/
+#define SRST_A_VI_BIU			37
+#define SRST_H_VI_BIU			38
+#define SRST_P_VI_BIU			39
+#define SRST_ISP			40
+#define SRST_A_VICAP			41
+#define SRST_H_VICAP			42
+#define SRST_D_VICAP			43
+#define SRST_I0_VICAP			44
+#define SRST_I1_VICAP			45
+#define SRST_I2_VICAP			46
+#define SRST_I3_VICAP			47
+/********Name=SOFTRST_CON12,Offset=0x430********/
+#define SRST_P_CSIHOST0			48
+#define SRST_P_CSIHOST1			49
+#define SRST_P_CSIHOST2			50
+#define SRST_P_CSIHOST3			51
+#define SRST_P_CSIPHY0			52
+#define SRST_P_CSIPHY1			53
+/********Name=SOFTRST_CON13,Offset=0x434********/
+#define SRST_A_VO_BIU			54
+#define SRST_H_VO_BIU			55
+#define SRST_A_VOP			56
+#define SRST_H_VOP			57
+#define SRST_D_VOP			58
+#define SRST_D_VOP1			59
+/********Name=SOFTRST_CON14,Offset=0x438********/
+#define SRST_A_RGA_BIU			60
+#define SRST_H_RGA_BIU			61
+#define SRST_A_RGA			62
+#define SRST_H_RGA			63
+#define SRST_RGA_CORE			64
+#define SRST_A_JDEC			65
+#define SRST_H_JDEC			66
+/********Name=SOFTRST_CON15,Offset=0x43C********/
+#define SRST_B_EBK_BIU			67
+#define SRST_P_EBK_BIU			68
+#define SRST_AHB2AXI_EBC		69
+#define SRST_H_EBC			70
+#define SRST_D_EBC			71
+#define SRST_H_EINK			72
+#define SRST_P_EINK			73
+/********Name=SOFTRST_CON16,Offset=0x440********/
+#define SRST_P_PHP_BIU			74
+#define SRST_A_PHP_BIU			75
+#define SRST_P_PCIE20			76
+#define SRST_PCIE20_POWERUP		77
+#define SRST_USB3OTG			78
+/********Name=SOFTRST_CON17,Offset=0x444********/
+#define SRST_PIPEPHY			79
+/********Name=SOFTRST_CON18,Offset=0x448********/
+#define SRST_A_BUS_BIU			80
+#define SRST_H_BUS_BIU			81
+#define SRST_P_BUS_BIU			82
+/********Name=SOFTRST_CON19,Offset=0x44C********/
+#define SRST_P_I2C1			83
+#define SRST_P_I2C2			84
+#define SRST_P_I2C3			85
+#define SRST_P_I2C4			86
+#define SRST_P_I2C5			87
+#define SRST_I2C1			88
+#define SRST_I2C2			89
+#define SRST_I2C3			90
+#define SRST_I2C4			91
+#define SRST_I2C5			92
+/********Name=SOFTRST_CON20,Offset=0x450********/
+#define SRST_BUS_GPIO3			93
+#define SRST_BUS_GPIO4			94
+/********Name=SOFTRST_CON21,Offset=0x454********/
+#define SRST_P_TIMER			95
+#define SRST_TIMER0			96
+#define SRST_TIMER1			97
+#define SRST_TIMER2			98
+#define SRST_TIMER3			99
+#define SRST_TIMER4			100
+#define SRST_TIMER5			101
+#define SRST_P_STIMER			102
+#define SRST_STIMER0			103
+#define SRST_STIMER1			104
+/********Name=SOFTRST_CON22,Offset=0x458********/
+#define SRST_P_WDTNS			105
+#define SRST_WDTNS			106
+#define SRST_P_GRF			107
+#define SRST_P_SGRF			108
+#define SRST_P_MAILBOX			109
+#define SRST_P_INTC			110
+#define SRST_A_BUS_GIC400		111
+#define SRST_A_BUS_GIC400_DEBUG		112
+/********Name=SOFTRST_CON23,Offset=0x45C********/
+#define SRST_A_BUS_SPINLOCK		113
+#define SRST_A_DCF			114
+#define SRST_P_DCF			115
+#define SRST_F_BUS_CM0_CORE		116
+#define SRST_T_BUS_CM0_JTAG		117
+#define SRST_H_ICACHE			118
+#define SRST_H_DCACHE			119
+/********Name=SOFTRST_CON24,Offset=0x460********/
+#define SRST_P_TSADC			120
+#define SRST_TSADC			121
+#define SRST_TSADCPHY			122
+#define SRST_P_DFT2APB			123
+/********Name=SOFTRST_CON25,Offset=0x464********/
+#define SRST_A_GMAC			124
+#define SRST_P_APB2ASB_VCCIO156		125
+#define SRST_P_DSIPHY			126
+#define SRST_P_DSITX			127
+#define SRST_P_CPU_EMA_DET		128
+#define SRST_P_HASH			129
+#define SRST_P_TOPCRU			130
+/********Name=SOFTRST_CON26,Offset=0x468********/
+#define SRST_P_ASB2APB_VCCIO156		131
+#define SRST_P_IOC_VCCIO156		132
+#define SRST_P_GPIO3_VCCIO156		133
+#define SRST_P_GPIO4_VCCIO156		134
+#define SRST_P_SARADC_VCCIO156		135
+#define SRST_SARADC_VCCIO156		136
+#define SRST_SARADC_VCCIO156_PHY	137
+/********Name=SOFTRST_CON27,Offset=0x46c********/
+#define SRST_A_MAC100			138
+
+/********Name=PMU0SOFTRST_CON00,Offset=0x10200********/
+#define SRST_P_PMU0_CRU			139
+#define SRST_P_PMU0_PMU			140
+#define SRST_PMU0_PMU			141
+#define SRST_P_PMU0_HP_TIMER		142
+#define SRST_PMU0_HP_TIMER		143
+#define SRST_PMU0_32K_HP_TIMER		144
+#define SRST_P_PMU0_PVTM		145
+#define SRST_PMU0_PVTM			146
+#define SRST_P_IOC_PMUIO		147
+#define SRST_P_PMU0_GPIO0		148
+#define SRST_PMU0_GPIO0			149
+#define SRST_P_PMU0_GRF			150
+#define SRST_P_PMU0_SGRF		151
+/********Name=PMU0SOFTRST_CON01,Offset=0x10204********/
+#define SRST_DDR_FAIL_SAFE		152
+#define SRST_P_PMU0_SCRKEYGEN		153
+/********Name=PMU0SOFTRST_CON02,Offset=0x10208********/
+#define SRST_P_PMU0_I2C0		154
+#define SRST_PMU0_I2C0			155
+
+/********Name=PMU1SOFTRST_CON00,Offset=0x18200********/
+#define SRST_P_PMU1_CRU			156
+#define SRST_H_PMU1_MEM			157
+#define SRST_H_PMU1_BIU			158
+#define SRST_P_PMU1_BIU			159
+#define SRST_P_PMU1_UART0		160
+#define SRST_S_PMU1_UART0		161
+/********Name=PMU1SOFTRST_CON01,Offset=0x18204********/
+#define SRST_P_PMU1_SPI0		162
+#define SRST_PMU1_SPI0			163
+#define SRST_P_PMU1_PWM0		164
+#define SRST_PMU1_PWM0			165
+/********Name=PMU1SOFTRST_CON02,Offset=0x18208********/
+#define SRST_F_PMU1_CM0_CORE		166
+#define SRST_T_PMU1_CM0_JTAG		167
+#define SRST_P_PMU1_WDTNS		168
+#define SRST_PMU1_WDTNS			169
+#define SRST_PMU1_MAILBOX		170
+
+/********Name=DDRSOFTRST_CON00,Offset=0x20200********/
+#define SRST_MSCH_BRG_BIU		171
+#define SRST_P_MSCH_BIU			172
+#define SRST_P_DDR_HWLP			173
+#define SRST_P_DDR_PHY			173
+#define SRST_P_DDR_DFICTL		174
+#define SRST_P_DDR_DMA2DDR		175
+/********Name=DDRSOFTRST_CON01,Offset=0x20204********/
+#define SRST_P_DDR_MON			176
+#define SRST_TM_DDR_MON			177
+#define SRST_P_DDR_GRF			178
+#define SRST_P_DDR_CRU			179
+#define SRST_P_SUBDDR_CRU		180
+
+/********Name=SUBDDRSOFTRST_CON00,Offset=0x28200********/
+#define SRST_MSCH_BIU			181
+#define SRST_DDR_PHY			182
+#define SRST_DDR_DFICTL			183
+#define SRST_DDR_SCRAMBLE		184
+#define SRST_DDR_MON			185
+#define SRST_A_DDR_SPLIT		186
+#define SRST_DDR_DMA2DDR		187
+
+/********Name=PERISOFTRST_CON01,Offset=0x30404********/
+#define SRST_A_PERI_BIU			188
+#define SRST_H_PERI_BIU			189
+#define SRST_P_PERI_BIU			190
+#define SRST_P_PERICRU			191
+/********Name=PERISOFTRST_CON02,Offset=0x30408********/
+#define SRST_H_SAI0_8CH			192
+#define SRST_M_SAI0_8CH			193
+#define SRST_H_SAI1_8CH			194
+#define SRST_M_SAI1_8CH			195
+#define SRST_H_SAI2_2CH			196
+#define SRST_M_SAI2_2CH			197
+/********Name=PERISOFTRST_CON03,Offset=0x3040C********/
+#define SRST_H_DSM			198
+#define SRST_DSM			199
+#define SRST_H_PDM			200
+#define SRST_M_PDM			201
+#define SRST_H_SPDIF			202
+#define SRST_M_SPDIF			203
+/********Name=PERISOFTRST_CON04,Offset=0x30410********/
+#define SRST_H_SDMMC0			204
+#define SRST_H_SDMMC1			205
+#define SRST_H_EMMC			206
+#define SRST_A_EMMC			207
+#define SRST_C_EMMC			208
+#define SRST_B_EMMC			209
+#define SRST_T_EMMC			210
+#define SRST_S_SFC			211
+#define SRST_H_SFC			212
+/********Name=PERISOFTRST_CON05,Offset=0x30414********/
+#define SRST_H_USB2HOST			213
+#define SRST_H_USB2HOST_ARB		214
+#define SRST_USB2HOST_UTMI		215
+/********Name=PERISOFTRST_CON06,Offset=0x30418********/
+#define SRST_P_SPI1			216
+#define SRST_SPI1			217
+#define SRST_P_SPI2			218
+#define SRST_SPI2			219
+/********Name=PERISOFTRST_CON07,Offset=0x3041C********/
+#define SRST_P_UART1			220
+#define SRST_P_UART2			221
+#define SRST_P_UART3			222
+#define SRST_P_UART4			223
+#define SRST_P_UART5			224
+#define SRST_P_UART6			225
+#define SRST_P_UART7			226
+#define SRST_P_UART8			227
+#define SRST_P_UART9			228
+#define SRST_S_UART1			229
+#define SRST_S_UART2			230
+/********Name=PERISOFTRST_CON08,Offset=0x30420********/
+#define SRST_S_UART3			231
+#define SRST_S_UART4			232
+#define SRST_S_UART5			233
+#define SRST_S_UART6			234
+#define SRST_S_UART7			235
+/********Name=PERISOFTRST_CON09,Offset=0x30424********/
+#define SRST_S_UART8			236
+#define SRST_S_UART9			237
+/********Name=PERISOFTRST_CON10,Offset=0x30428********/
+#define SRST_P_PWM1_PERI		238
+#define SRST_PWM1_PERI			239
+#define SRST_P_PWM2_PERI		240
+#define SRST_PWM2_PERI			241
+#define SRST_P_PWM3_PERI		242
+#define SRST_PWM3_PERI			243
+/********Name=PERISOFTRST_CON11,Offset=0x3042C********/
+#define SRST_P_CAN0			244
+#define SRST_CAN0			245
+#define SRST_P_CAN1			246
+#define SRST_CAN1			247
+/********Name=PERISOFTRST_CON12,Offset=0x30430********/
+#define SRST_A_CRYPTO			248
+#define SRST_H_CRYPTO			249
+#define SRST_P_CRYPTO			250
+#define SRST_CORE_CRYPTO		251
+#define SRST_PKA_CRYPTO			252
+#define SRST_H_KLAD			253
+#define SRST_P_KEY_READER		254
+#define SRST_H_RK_RNG_NS		255
+#define SRST_H_RK_RNG_S			256
+#define SRST_H_TRNG_NS			257
+#define SRST_H_TRNG_S			258
+#define SRST_H_CRYPTO_S			259
+/********Name=PERISOFTRST_CON13,Offset=0x30434********/
+#define SRST_P_PERI_WDT			260
+#define SRST_T_PERI_WDT			261
+#define SRST_A_SYSMEM			262
+#define SRST_H_BOOTROM			263
+#define SRST_P_PERI_GRF			264
+#define SRST_A_DMAC			265
+#define SRST_A_RKDMAC			267
+/********Name=PERISOFTRST_CON14,Offset=0x30438********/
+#define SRST_P_OTPC_NS			268
+#define SRST_SBPI_OTPC_NS		269
+#define SRST_USER_OTPC_NS		270
+#define SRST_P_OTPC_S			271
+#define SRST_SBPI_OTPC_S		272
+#define SRST_USER_OTPC_S		273
+#define SRST_OTPC_ARB			274
+#define SRST_P_OTPPHY			275
+#define SRST_OTP_NPOR			276
+/********Name=PERISOFTRST_CON15,Offset=0x3043C********/
+#define SRST_P_USB2PHY			277
+#define SRST_USB2PHY_POR		278
+#define SRST_USB2PHY_OTG		279
+#define SRST_USB2PHY_HOST		280
+#define SRST_P_PIPEPHY			281
+/********Name=PERISOFTRST_CON16,Offset=0x30440********/
+#define SRST_P_SARADC			282
+#define SRST_SARADC			283
+#define SRST_SARADC_PHY			284
+#define SRST_P_IOC_VCCIO234		285
+/********Name=PERISOFTRST_CON17,Offset=0x30444********/
+#define SRST_P_PERI_GPIO1		286
+#define SRST_P_PERI_GPIO2		287
+#define SRST_PERI_GPIO1			288
+#define SRST_PERI_GPIO2			289
+
+#endif
-- 
2.25.1


