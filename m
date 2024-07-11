Return-Path: <linux-kernel+bounces-249430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E9992EB91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841651F22793
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792116B753;
	Thu, 11 Jul 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdSe85mD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFD148FE8;
	Thu, 11 Jul 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711405; cv=none; b=aqliLP+5ODmNCANpD9WEWkikzKPK1sPgFieBbUeD97rE9QZSHS+E1kXCH6+ONDQ8Xdtv2x/czHeyP5FrF8m4Kga+1Q5Ty4Tr2c3TSMFabhm0dvL6Ju4951o7Mofsj4TBLnOhMp2LLq5otYYvkRXEYfoYimxZI5vJHXAxxWwOECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711405; c=relaxed/simple;
	bh=JfLcu56UysTRyIkfxtd8Hbx1zuGOH16FdmhwjmvWqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puzJwtc4sQrXfIJJKhX/jojqgqNvVvd2+/2VuVvXSZC9h/iHqn6B04+yigEQs1MfPkK3r8UZUSyKVwAuCWNdWr71vpM/fWnVBiQckdB/AhnXM0wrQ3BRKF24dimpYuS3HdoWq+W5JN/mXz9JiRtZCzzUn+5CeJCT+LQLxK+xgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdSe85mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1CBC116B1;
	Thu, 11 Jul 2024 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720711405;
	bh=JfLcu56UysTRyIkfxtd8Hbx1zuGOH16FdmhwjmvWqNI=;
	h=From:To:Cc:Subject:Date:From;
	b=OdSe85mDKLOnqGqdnHiOrsO4qfD0OknKA1o7q+MAfjYfLtD9eUnzdKECtxvozY62K
	 BGhRNq36NDsSJvtRzqyX86jPLxsJrP6Le7erblUpOyEMSeGaEgWpV0tBrFG0zYxvd4
	 TeNENjgI/YnjGvBy3zHJhzV+x8fbQXZ01Hy1GsjPg9QSWrNjpJxGUeyCNr4CSxVIxP
	 00m+CNcOQdQi49ubGDoZw4RH8K9rzCa/UYAfF6XPwpq8cGXMOgLxdtlA+y40MBdCJG
	 skFBcrUkuWJVob71byvZYMVcsv3Ut9HHTLPj5uGweVPnz6nDxh+3hxnEpKmUISjWxU
	 Y30uXLV4Wc0DQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: phy: hisilicon,hi3798cv200-combphy: Convert to DT schema
Date: Thu, 11 Jul 2024 09:23:13 -0600
Message-ID: <20240711152313.2364383-1-robh@kernel.org>
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

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Drop Jianguo Sun's bouncing email
---
 .../phy/hisilicon,hi3798cv200-combphy.yaml    | 56 ++++++++++++++++++
 .../bindings/phy/phy-hi3798cv200-combphy.txt  | 59 -------------------
 2 files changed, 56 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
new file mode 100644
index 000000000000..81001966f657
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3798cv200-combphy.yaml
@@ -0,0 +1,56 @@
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


