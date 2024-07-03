Return-Path: <linux-kernel+bounces-240274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08039926B11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68231F223CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81519306C;
	Wed,  3 Jul 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE6eSFPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C2190694;
	Wed,  3 Jul 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043960; cv=none; b=MjsoSS5YVveR/TibzbAytvx4ihFO7W6dcqECpzRcang/KFKzt6mCUtc5QYeElgje0dXdfY7AeXVc4hI9L73rdNWulSS/BpO/aehuCK8xI44wcfnRulPLwIfDZLiJv670iIRP/nOQ06+EBc+prn8pRpif0AmWPkiQqemAD0wyF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043960; c=relaxed/simple;
	bh=GtBxmZrUqjDnMgdPkSGchSU8VhCDAdASHC+jQCEfnOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oksm8zjzX2U08pl+XpFH64wWdbgJgT2jEkEntlCYcPh5Mgws6PvYsO/OfgUTBiukSsBMDfYDdPjtLJkTbG0tKoHQJzap2l9aSjqSXX6Q/ofu+FnO9y5iO8/E3rLsQgaWqsjK7O+4A5WnOmnWwBO7SFR5yS2cpazMC/KV6lXtfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE6eSFPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634AEC2BD10;
	Wed,  3 Jul 2024 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720043959;
	bh=GtBxmZrUqjDnMgdPkSGchSU8VhCDAdASHC+jQCEfnOA=;
	h=From:To:Cc:Subject:Date:From;
	b=BE6eSFPQh/s7+aGGu92RCZmqnYSPLoq72v8V2A8SdV1VjD0cvfC4uEcOiDBjcnPjh
	 nYZvAlXzpWrWrUT8ahgUrbm4RyKdmreeapJy+uahne56lX4LIe7aDATtU3Lqz3jd5R
	 g4zntsQpC/6VvUInYGSMG+gHlP3oY1+hoI93liZM2SMT7pOzEUYJO25MaqxJtxuysb
	 5e2Fy3wTOq60QvC+e2BNqqSKQ/Nw7IsnbjwKrxJxOCezkZzk7X4uh/HyfEBH7E3WWu
	 jA66faiikgJlFaymfw584jb1f6Xi94/JCqU/rnrp3haAeK7L5f60oBkQGL7IbJVnzw
	 jngJ8vyt/VD8Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jianguo Sun <sunjianguo1@huawei.com>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: hisilicon,hi3798cv200-combphy: Convert to DT schema
Date: Wed,  3 Jul 2024 15:59:04 -0600
Message-ID: <20240703215905.2031038-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the hisilicon,hi3798cv200-combphy binding to DT schema format.

Drop the example as arm/hisilicon/controller/hi3798cv200-perictrl.yaml
already contains an example of this binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../phy/hisilicon,hi3798cv200-combphy.yaml    | 57 ++++++++++++++++++
 .../bindings/phy/phy-hi3798cv200-combphy.txt  | 59 -------------------
 2 files changed, 57 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
new file mode 100644
index 000000000000..814504492f30
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/hisilicon,hi3798cv200-combphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon STB PCIE/SATA/USB3 PHY
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+  - Jianguo Sun <sunjianguo1@huawei.com>
+
+properties:
+  compatible:
+    const: hisilicon,hi3798cv200-combphy
+
+  reg:
+    maxItems: 1
+
+  '#phy-cells':
+    description: The cell contains the PHY mode
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  hisilicon,fixed-mode:
+    description: If the phy device doesn't support mode select but a fixed mode
+      setting, the property should be present to specify the particular mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4]  # SATA, PCIE, USB3
+
+  hisilicon,mode-select-bits:
+    description: If the phy device support mode select, this property should be
+      present to specify the register bits in peripheral controller.
+    items:
+      - description: register_offset
+      - description: bit shift
+      - description: bit mask
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+  - clocks
+  - resets
+
+oneOf:
+  - required: ['hisilicon,fixed-mode']
+  - required: ['hisilicon,mode-select-bits']
+
+additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt b/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
deleted file mode 100644
index 17b0c761370a..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-HiSilicon STB PCIE/SATA/USB3 PHY
-
-Required properties:
-- compatible: Should be "hisilicon,hi3798cv200-combphy"
-- reg: Should be the address space for COMBPHY configuration and state
-  registers in peripheral controller, e.g. PERI_COMBPHY0_CFG and
-  PERI_COMBPHY0_STATE for COMBPHY0 Hi3798CV200 SoC.
-- #phy-cells: Should be 1.  The cell number is used to select the phy mode
-  as defined in <dt-bindings/phy/phy.h>.
-- clocks: The phandle to clock provider and clock specifier pair.
-- resets: The phandle to reset controller and reset specifier pair.
-
-Refer to phy/phy-bindings.txt for the generic PHY binding properties.
-
-Optional properties:
-- hisilicon,fixed-mode: If the phy device doesn't support mode select
-  but a fixed mode setting, the property should be present to specify
-  the particular mode.
-- hisilicon,mode-select-bits: If the phy device support mode select,
-  this property should be present to specify the register bits in
-  peripheral controller, as a 3 integers tuple:
-  <register_offset bit_shift bit_mask>.
-
-Notes:
-- Between hisilicon,fixed-mode and hisilicon,mode-select-bits, one and only
-  one of them should be present.
-- The device node should be a child of peripheral controller that contains
-  COMBPHY configuration/state and PERI_CTRL register used to select PHY mode.
-  Refer to arm/hisilicon/hisilicon.txt for the parent peripheral controller
-  bindings.
-
-Examples:
-
-perictrl: peripheral-controller@8a20000 {
-	compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
-		     "simple-mfd";
-	reg = <0x8a20000 0x1000>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x0 0x8a20000 0x1000>;
-
-	combphy0: phy@850 {
-		compatible = "hisilicon,hi3798cv200-combphy";
-		reg = <0x850 0x8>;
-		#phy-cells = <1>;
-		clocks = <&crg HISTB_COMBPHY0_CLK>;
-		resets = <&crg 0x188 4>;
-		hisilicon,fixed-mode = <PHY_TYPE_USB3>;
-	};
-
-	combphy1: phy@858 {
-		compatible = "hisilicon,hi3798cv200-combphy";
-		reg = <0x858 0x8>;
-		#phy-cells = <1>;
-		clocks = <&crg HISTB_COMBPHY1_CLK>;
-		resets = <&crg 0x188 12>;
-		hisilicon,mode-select-bits = <0x0008 11 (0x3 << 11)>;
-	};
-};
-- 
2.43.0


