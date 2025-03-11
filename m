Return-Path: <linux-kernel+bounces-556121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DAA5C145
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B2189D064
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF7235374;
	Tue, 11 Mar 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zJItyru5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B4232368;
	Tue, 11 Mar 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696162; cv=none; b=HuRDYFcV7JCdZF7dunK/jqwxY01BAGQgyGenes4zM9iELXcQdh7An5vu7bBA7Kvth7ZpzD+5krLLE5/2nk0/ep/xxwbKUTr9pJnZgM5PpujDfJBGqAHjOaaNHhTIFsIRaWKNolMvnHvWoB7LaTcuR8KmWKeJF1W/TO44iZRGywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696162; c=relaxed/simple;
	bh=e/hZ0vi7ZolpvUO0eVwjRgjeJClTy/KTdz/vQ+UYy1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9ihD/t0YQdYjjJs1X/sBVBTRVvNUE693Oykbw8148BD04w4GSUFf83hz63ZtOxelpYKrU8yvGWDbKxT0vY7LUosDr0kxbhm45WrsOHLxiWDrWEHlsa2XkKXigUPI1fEiLJM+LtSNqu9yGWBkwPVZOMb6xRNO8QNUK5psILPDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zJItyru5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741696160; x=1773232160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/hZ0vi7ZolpvUO0eVwjRgjeJClTy/KTdz/vQ+UYy1w=;
  b=zJItyru5XEWMFwfXqlv/t5a/QUvlOWRIWu1C7bDPw8gE50SrDwocKduL
   Geh0ojW+YNHVShW7ztHAdW4Dck6cZV2Kg3p3MD+ItLExbHoVXUr3Oti0W
   y/m2tQs9w/FLKXJohQWxQG8tqCIrjKMKbarD2zzAcjQimzMgLqc6JWKlM
   dNKNix0HZWfFfydrhC+hYbL1StZpCJH3+ejHrbGrM0DDBgtxa7Uie24J+
   lVBMJYSC7toXhD/X7MkTJ0r+a1m4MZtyknvU9oIi753TgCRqb53aFRBt3
   6ivybTrd0wzStdqqY4g15wmEdtfvUuQ0/jigmbbHr9pIGWjhHDfwKs1jO
   A==;
X-CSE-ConnectionGUID: d0aXCjEFQVuCEk822uv6wQ==
X-CSE-MsgGUID: sDIGSaGDQI2izc1UiQfZiQ==
X-IronPort-AV: E=Sophos;i="6.14,239,1736838000"; 
   d="scan'208";a="39234194"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 05:29:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Mar 2025 05:29:08 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 05:29:02 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <krzysztof.kozlowski+dt@linaro.org>
CC: <balamanikandan.gunasundar@microchip.com>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: mtd: microchip-nand: convert txt to yaml
Date: Tue, 11 Mar 2025 17:58:45 +0530
Message-ID: <20250311122847.90081-2-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
References: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert text to yaml for microchip nand controller

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---

Changes in v2:

- Change the filename to match the compatible string
- Drop items and oneOf in the compatible property as it is just an enum
- Remove the if in the #address-cells and #size-cells
- Remove the unwanted comments that refers to .txt files
- Fix reg property description
- Define the properties in a list and add constraints
- Fix DT coding style and droped unused labels

 .../devicetree/bindings/mtd/atmel-nand.txt    |  50 -----
 .../mtd/microchip,nand-controller.yaml        | 175 ++++++++++++++++++
 2 files changed, 175 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,nand-controller.yaml

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index e36c35b17873..dbbc17a866f2 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -1,53 +1,3 @@
-Atmel NAND flash controller bindings
-
-The NAND flash controller node should be defined under the EBI bus (see
-Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt).
-One or several NAND devices can be defined under this NAND controller.
-The NAND controller might be connected to an ECC engine.
-
-* NAND controller bindings:
-
-Required properties:
-- compatible: should be one of the following
-	"atmel,at91rm9200-nand-controller"
-	"atmel,at91sam9260-nand-controller"
-	"atmel,at91sam9261-nand-controller"
-	"atmel,at91sam9g45-nand-controller"
-	"atmel,sama5d3-nand-controller"
-	"microchip,sam9x60-nand-controller"
-- ranges: empty ranges property to forward EBI ranges definitions.
-- #address-cells: should be set to 2.
-- #size-cells: should be set to 1.
-- atmel,nfc-io: phandle to the NFC IO block. Only required for sama5d3
-		controllers.
-- atmel,nfc-sram: phandle to the NFC SRAM block. Only required for sama5d3
-		  controllers.
-
-Optional properties:
-- ecc-engine: phandle to the PMECC block. Only meaningful if the SoC embeds
-	      a PMECC engine.
-
-* NAND device/chip bindings:
-
-Required properties:
-- reg: describes the CS lines assigned to the NAND device. If the NAND device
-       exposes multiple CS lines (multi-dies chips), your reg property will
-       contain X tuples of 3 entries.
-       1st entry: the CS line this NAND chip is connected to
-       2nd entry: the base offset of the memory region assigned to this
-		  device (always 0)
-       3rd entry: the memory region size (always 0x800000)
-
-Optional properties:
-- rb-gpios: the GPIO(s) used to check the Ready/Busy status of the NAND.
-- cs-gpios: the GPIO(s) used to control the CS line.
-- det-gpios: the GPIO used to detect if a Smartmedia Card is present.
-- atmel,rb: an integer identifying the native Ready/Busy pin. Only meaningful
-	    on sama5 SoCs.
-
-All generic properties are described in the generic yaml files under
-Documentation/devicetree/bindings/mtd/.
-
 * ECC engine (PMECC) bindings:
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/mtd/microchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/microchip,nand-controller.yaml
new file mode 100644
index 000000000000..bf644ab0cf27
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/microchip,nand-controller.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/microchip,nand-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip NAND flash controller
+
+maintainers:
+  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
+
+description: |
+  The NAND flash controller node should be defined under the EBI bus (see
+  Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt).
+  One or several NAND devices can be defined under this NAND controller.
+  The NAND controller might be connected to an ECC engine.
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91rm9200-nand-controller
+      - atmel,at91sam9260-nand-controller
+      - atmel,at91sam9261-nand-controller
+      - atmel,at91sam9g45-nand-controller
+      - atmel,sama5d3-nand-controller
+      - microchip,sam9x60-nand-controller
+
+  ranges:
+    description: empty ranges property to forward EBI ranges definitions.
+
+  ecc-engine:
+    description:
+      phandle to the PMECC block. Only meaningful if the SoC embeds a PMECC
+      engine.
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 1
+
+  atmel,nfc-io:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the NFC IO block. Only applicable for atmel,sama5d3-nand-controller
+
+  atmel,nfc-sram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the NFC SRAM block. Only applicable for atmel,sama5d3-nand-controller
+
+required:
+  - compatible
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^nand@[a-f0-9]$":
+    type: object
+    $ref: raw-nand-chip.yaml#
+    description:
+      NAND chip bindings.
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        items:
+          - items:
+              - description: describes the CS lines assigned to the NAND device.
+              - description: the base offset of the memory region assigned to this device (always 0)
+              - description: the memory region size (always 0x800000)
+      rb-gpios:
+        description:
+          the GPIO(s) used to check the Ready/Busy status of the NAND.
+
+      cs-gpios:
+        description:
+          the GPIO(s) used to control the CS line.
+
+      det-gpios:
+        description:
+          the GPIO used to detect if a Smartmedia Card is present.
+
+      atmel,rb:
+        description: |
+          an integer identifying the native Ready/Busy pin.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      nand-ecc-step-size:
+        const: 512
+
+      nand-ecc-strength:
+        enum: [2, 4, 8]
+
+      nand-ecc-mode:
+        enum: [soft, hw]
+
+      nand-bus-width:
+        const: 8
+
+      nand-on-flash-bbt: true
+
+      partitions:
+        $ref: /schemas/mtd/partitions/partitions.yaml
+
+      label:
+        description: Name or Label of the device
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: atmel,sama5d3-nand-controller
+        then:
+          properties:
+            "atmel,rb":
+              description: an integer identifying the native Ready/Busy pin.
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nfc_io: nfc-io@70000000 {
+        compatible = "atmel,sama5d3-nfc-io", "syscon";
+        reg = <0x70000000 0x8000000>;
+    };
+
+    nfc_sram: sram@200000 {
+        compatible = "mmio-sram";
+        no-memory-wc;
+        reg = <0x200000 0x2400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x200000 0x2400>;
+    };
+
+    pmecc: ecc-engine@ffffc070 {
+        compatible = "atmel,at91sam9g45-pmecc";
+        reg = <0xffffc070 0x490>,
+              <0xffffc500 0x100>;
+    };
+
+    ebi@10000000 {
+        compatible = "atmel,sama5d3-ebi";
+        #address-cells = <2>;
+        #size-cells = <1>;
+        atmel,smc = <&hsmc>;
+        reg = <0x10000000 0x10000000
+               0x40000000 0x30000000>;
+        ranges = <0x0 0x0 0x10000000 0x10000000
+                  0x1 0x0 0x40000000 0x10000000
+                  0x2 0x0 0x50000000 0x10000000
+                  0x3 0x0 0x60000000 0x10000000>;
+        clocks = <&mck>;
+
+        nand_controller: nand-controller {
+            compatible = "atmel,sama5d3-nand-controller";
+            atmel,nfc-sram = <&nfc_sram>;
+            atmel,nfc-io = <&nfc_io>;
+            ecc-engine = <&pmecc>;
+            #address-cells = <2>;
+            #size-cells = <1>;
+            ranges;
+
+            nand@3 {
+                reg = <0x3 0x0 0x800000>;
+                atmel,rb = <0>;
+                /*
+                 * Put generic NAND/MTD properties and
+                 * subnodes here.
+                 */
+            };
+        };
+    };
-- 
2.34.1


