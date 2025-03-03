Return-Path: <linux-kernel+bounces-541690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4FA4C02F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C216FE06
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D120F088;
	Mon,  3 Mar 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="P3d+rGz1"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66020F077;
	Mon,  3 Mar 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004505; cv=pass; b=BWGJYL2OoSaiJvyOTddKOygb8SBWeeMelY9RsHPcQg2W8traBujzUqZz4rCzG8xavnu1uHo51DvOPQTKfNc5URF3gGY9APG9lSpL3+6pThrL6/qcVqrYRoniFw1jEaymvUmPCyso5WBOV5JpyJBaH3UtRciZaj14lXvl8lPPHyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004505; c=relaxed/simple;
	bh=OMLib9ICsPv5/5Yp3Lw54QOqAua2y9OL18VzJ3z07X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5PgALUwYz2u4klibIXBaA2HszrGxhEdNAVNkSbrHUUhNJ3fABqZgtC+/ncHUuNiI5GXWxA1i1yHEGnylKUqTmLsiid+EeQA2MRDWy3/m/CZg3pjKBspcFOLU1BjoylhNj9J/AikZ7wTkkO6PK13089RO9vo/JC6S6bbdTShedE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=P3d+rGz1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1741004483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oAkZRjaZqIbgQVj1QiHT1+HKQF0yfjK2GZUTXvc2u8/YIyW1jTQGpIiMe0q4TZ8sj8FlJN9aVrNJr/ObgEaNbx1Ae0VS4+GQ0lwUsuebQ+XPd56Jdar2YFs2cH1Vq0GTIa5V2TKB9Fqu0UNmVr7g1uyOnez5QiZROjkgWoDagLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741004483; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3ydZCPGpoQBdvJRWpULIrkhPs9pNUlcKM0pGYMjjiqQ=; 
	b=JJmEM94VccWbjPtkLDXR0oRfnx7icgYGTwRFEfN7KFimiKyNNfgTcy+plYlQqu0i4k9OZnKE8EPTWlfOa6J0G13HzqDIDfrjiSSGgqauUacWhQQnnDIJXXW9EmyUNSKou/Cv8pxEniU1rrA0ojmr8BmwjagNHdbsU3gzYBf/yfc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741004483;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=3ydZCPGpoQBdvJRWpULIrkhPs9pNUlcKM0pGYMjjiqQ=;
	b=P3d+rGz1oo9cva3q0QAiGdmacQx2sHi6Ds/dPryrf7MFLzlLGhz84lVGqIaqzKcK
	/61KXUz8eY0nR//AHW9Euf33zpf+MoMpVx54uVRUPwl0VwJKAqTOrJDAmAlSuoZ5hY7
	ZMEA3m9maY1LF07FC9K6hWUFm+Dt2FKvtNzdTcj0=
Received: by mx.zohomail.com with SMTPS id 1741004478912708.8413176197934;
	Mon, 3 Mar 2025 04:21:18 -0800 (PST)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Mon, 03 Mar 2025 20:20:37 +0800
Subject: [PATCH v5 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-k230-clk-v5-1-748d121283e3@zohomail.com>
References: <20250303-b4-k230-clk-v5-0-748d121283e3@zohomail.com>
In-Reply-To: <20250303-b4-k230-clk-v5-0-748d121283e3@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
Feedback-ID: rr080112278023036a06dbdcbd3a23d44200002b81d417ab5dd55009f4b843ad4fd77b9cba8aa5bd0901fd8a:zu08011227cdd3bbd721d8b167eb2a74bd0000b8fc4f77c0164826b383e249bd15fa026a8b4d223a4f0e555f:rf0801122c3d26086ea0444cd2e5bcc1960000ce354aa1b441ef4dd0567f9ee369852d3c360944b5b7afdd6ad30731ca23:ZohoMail
X-ZohoMailClient: External

This patch adds the Device Tree binding for the clock controller
on Canaan k230. The binding defines the new clocks available and
the required properties to configure them correctly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 .../devicetree/bindings/clock/canaan,k230-clk.yaml | 43 ++++++++++++++
 include/dt-bindings/clock/canaan,k230-clk.h        | 69 ++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d7220fa30e4699a68fa5279c04abc63c1905fa4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Canaan Kendryte K230 Clock
+
+maintainers:
+  - Xukai Wang <kingxukai@zohomail.com>
+
+properties:
+  compatible:
+    const: canaan,k230-clk
+
+  reg:
+    items:
+      - description: PLL control registers.
+      - description: Sysclk control registers.
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@91102000 {
+        compatible = "canaan,k230-clk";
+        reg = <0x91102000 0x1000>,
+              <0x91100000 0x1000>;
+        clocks = <&osc24m>;
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/canaan,k230-clk.h b/include/dt-bindings/clock/canaan,k230-clk.h
new file mode 100644
index 0000000000000000000000000000000000000000..41edb13ea04bffaa1ddd1d1af87ae3406b688332
--- /dev/null
+++ b/include/dt-bindings/clock/canaan,k230-clk.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Kendryte Canaan K230 Clock Drivers
+ *
+ * Author: Xukai Wang <kingxukai@zohomail.com>
+ */
+
+#ifndef CLOCK_K230_CLK_H
+#define CLOCK_K230_CLK_H
+
+/* Kendryte K230 SoC clock identifiers (arbitrary values). */
+#define K230_CPU0_SRC			0
+#define K230_CPU0_ACLK			1
+#define K230_CPU0_PLIC			2
+#define K230_CPU0_NOC_DDRCP4		3
+#define K230_CPU0_PCLK			4
+#define K230_PMU_PCLK			5
+#define K230_HS_HCLK_HIGH_SRC		6
+#define K230_HS_HCLK_HIGH_GATE		7
+#define K230_HS_HCLK_SRC		8
+#define K230_HS_SD0_HS_AHB_GAT		9
+#define K230_HS_SD1_HS_AHB_GAT		10
+#define K230_HS_SSI1_HS_AHB_GA		11
+#define K230_HS_SSI2_HS_AHB_GA		12
+#define K230_HS_USB0_HS_AHB_GA		13
+#define K230_HS_USB1_HS_AHB_GA		14
+#define K230_HS_SSI0_AXI15		15
+#define K230_HS_SSI1			16
+#define K230_HS_SSI2			17
+#define K230_HS_QSPI_AXI_SRC		18
+#define K230_HS_SSI1_ACLK_GATE		19
+#define K230_HS_SSI2_ACLK_GATE		20
+#define K230_HS_SD_CARD_SRC		21
+#define K230_HS_SD0_CARD_TX		22
+#define K230_HS_SD1_CARD_TX		23
+#define K230_HS_SD_AXI_SRC		24
+#define K230_HS_SD0_AXI_GATE		25
+#define K230_HS_SD1_AXI_GATE		26
+#define K230_HS_SD0_BASE_GATE		27
+#define K230_HS_SD1_BASE_GATE		28
+#define K230_HS_OSPI_SRC		29
+#define K230_HS_USB_REF_50M		30
+#define K230_HS_SD_TIMER_SRC		31
+#define K230_HS_SD0_TIMER_GATE		32
+#define K230_HS_SD1_TIMER_GATE		33
+#define K230_HS_USB0_REFERENCE		34
+#define K230_HS_USB1_REFERENCE		35
+#define K230_LS_APB_SRC			36
+#define K230_LS_UART0_APB		37
+#define K230_LS_UART1_APB		38
+#define K230_LS_UART2_APB		39
+#define K230_LS_UART3_APB		40
+#define K230_LS_UART4_APB		41
+#define K230_LS_I2C0_APB		42
+#define K230_LS_I2C1_APB		43
+#define K230_LS_I2C2_APB		44
+#define K230_LS_I2C3_APB		45
+#define K230_LS_GPIO_APB		46
+#define K230_LS_PWM_APB			47
+#define K230_LS_UART0			48
+#define K230_LS_UART1			49
+#define K230_LS_UART2			50
+#define K230_LS_UART3			51
+#define K230_LS_UART4			52
+#define K230_SHRM_AXI_SRC		53
+#define K230_SHRM_SDMA_AXI_GATE		54
+#define K230_SHRM_PDMA_AXI_GATE		55
+
+#endif /* CLOCK_K230_CLK_H */

-- 
2.34.1


