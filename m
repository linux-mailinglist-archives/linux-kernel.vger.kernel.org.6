Return-Path: <linux-kernel+bounces-517872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F5A386D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B602188DD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E4223302;
	Mon, 17 Feb 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="aLgInfvH"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634E634EC;
	Mon, 17 Feb 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803599; cv=pass; b=cXnqeaPEFwnqrV4CVZpLQzXM64tzPFBmC3zg8H5CJYmzHqKU37FP0+E5xFHme/5W3i5daJMFoD+E1Qcu5/GQODXlfyLgzVFWmLAACgDLxPi7vw7mTM6kg7Jyt+NKd5ZEN4g97fb9//YMF3YiF1teLLG0BfdsmQMCkjuQB51LUG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803599; c=relaxed/simple;
	bh=9BGGTOY6yT36nVbt7kfshSB1MUAlKHK8K+9HhFzfsww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5taBG3YRNsloQ/BabjwGPhg6AUKrhJIxKsNwgI0KT5K6pV9tl+bL2lcSEj/FX533f6oQ2Wq8fQsKGb2laXamCDBADOwDsUuzrAPxEnBUkRqihunpnA/8Mi6yOpx+W3UPN+YbHyMiAc0ZRGyiDi+HiMSonGOQzFYyR9CKLgXtoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=aLgInfvH; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1739803567; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZBdbu/cfkjJiHv2e9Sv9SB3rXe3Lg5evwPBhMuBdsP2rc3cTjTDPd8oTuxdIKcjHnVgAlIi6IygR7IUA2oP6978MDzmsMDwkwPY7OlIFPq24AEejJ2Pet8RrN8ww8dz53+61iC4mZUsHT6rC7iVYzQ1YU2gAA7WmU4Q9Uj1ca8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803567; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8lJSvQ11CH9dzk5I855KdjRvtef7HBh0f04dbmt0uHM=; 
	b=nzF0j+1dfpgl+JZH9mU+QGu1uy2gGXPK/B+BPLifzER5mrNFMgjGb//erbChgvn9yhMy0UUUUMz8aYgKPeeCDomSYg0umsy+4H2xzQ1WCCHi9tUvMJQcux1d1q8sF0b652XcFoG8nHfN/8t+gw1nq3k8pblhRbT12gf5M9HLo2Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803567;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=8lJSvQ11CH9dzk5I855KdjRvtef7HBh0f04dbmt0uHM=;
	b=aLgInfvH+/rZwWOkMFwLDyF2QQKdFaPcwY9pYfCrShBe1VRsqhDCVlW8lFhQaVtl
	xwyjM7m5cPBhzXK666i8oQ263hHdvxUjRp0Mv8vHYRVNVlc3PUDdM7zjSA+ebj8NgSy
	8Eqf2AAeDmaqW5Wm6oH+WpXx/UKcf7q1nvw8lPtU=
Received: by mx.zohomail.com with SMTPS id 1739803564101339.8673497906382;
	Mon, 17 Feb 2025 06:46:04 -0800 (PST)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Mon, 17 Feb 2025 22:45:16 +0800
Subject: [PATCH v4 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-k230-clk-v4-1-5a95a3458691@zohomail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
In-Reply-To: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
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
Feedback-ID: rr08011227e01257d8e81156547c108c650000f70c7a1ff5a9628048057c420bc2a64c2423decf8a0e39d1f5:zu08011227ce2f0729a3ff13a083baf07300009c248f7505fe6bded762c6c30af7820183fe3dd77da4d1654c:rf0801122cad405da341d86a14b85757b40000a7bed495ef7b59dd754987074cc1b7fbeaa6e031dcff0f60172d0f31aef2:ZohoMail
X-ZohoMailClient: External

This patch adds the Device Tree binding for the clock controller
on Canaan k230. The binding defines the new clocks available and
the required properties to configure them correctly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 .../devicetree/bindings/clock/canaan,k230-clk.yaml | 43 +++++++++++++++++++
 include/dt-bindings/clock/canaan,k230-clk.h        | 49 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)

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
index 0000000000000000000000000000000000000000..47d966fda5771615dad8ade64eeec42a9b27696e
--- /dev/null
+++ b/include/dt-bindings/clock/canaan,k230-clk.h
@@ -0,0 +1,49 @@
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
+
+#endif /* CLOCK_K230_CLK_H */

-- 
2.34.1


