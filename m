Return-Path: <linux-kernel+bounces-556125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E16A5C150
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EA5189AFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486C258CC4;
	Tue, 11 Mar 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZLS+rfz5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0F256C84;
	Tue, 11 Mar 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696201; cv=none; b=ZmOz38uPjX3VKscvxfXvvEFQihJRZyGLgHGr4lt90fkk6er+9aLEJGi3ewBrKY/jP2wju1Oydq7MdqrJFL4jyG9li7bQSnFlyL7Dj7K2QvNaGvbHC9HFeR/ES9UjiW50RM4Vc+ppL7GHjQ+SBIoGWQrNlf9+CVayGBDBQ9vqQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696201; c=relaxed/simple;
	bh=PxGOLsn8hwCsBFB1rmI0untPlJerevuZCULEITNSle8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrirSr+yIkyJKFyoAlHFam5x6GaaBRIRt7DBtVz3FLQGAs5jZZCw6XyRW81Py15i94EE73/Y+CpWZerlgSTxd3u5RZ6++8fYVT9iApxRNaK4xNJTh8lqMs97cPMa8RNwZWbJEm60J5KDO2wqXO/cH1jydFkqf7Brfm1af/m90o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZLS+rfz5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741696200; x=1773232200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PxGOLsn8hwCsBFB1rmI0untPlJerevuZCULEITNSle8=;
  b=ZLS+rfz5OlVJGZUprn7rRF33+RLdudgV+/PipHUqMRzEyOUHF9P8c9Qa
   JTARCFKclaDGrPJdtUSFHLCA+yd19GAZxrscHbbUKExCr9jLRQwn1pAc8
   kxnrJaKNRSY0HNS1SekAXgkWJwA653TrT2S+q+J8Hy37p9xrdUKZAu+to
   R1/tbutEb+I7ejrnTz1xJlX+13ha962zTqExS2k7kQtTYhlgx9+PqbDVU
   HDjCUYL4x5/vPVy6x5fJL6VvODe3Qy4nsNM/uOiZybLWMrRFDQItlpGjQ
   yOpP6OZWIkt+RSQTONoP+4XxJQr93KuFJYMd8jlswX8Zn+fpFcgC1Xpgh
   A==;
X-CSE-ConnectionGUID: Go3mR8CHQWamanNzn54y3Q==
X-CSE-MsgGUID: ITc2+fPqSxaFiSc1wXdYiw==
X-IronPort-AV: E=Sophos;i="6.14,239,1736838000"; 
   d="scan'208";a="38788672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 05:29:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Mar 2025 05:29:22 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 05:29:15 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <krzysztof.kozlowski+dt@linaro.org>
CC: <balamanikandan.gunasundar@microchip.com>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] dt-bindings: mtd: atmel-nand: add legacy nand controllers
Date: Tue, 11 Mar 2025 17:58:47 +0530
Message-ID: <20250311122847.90081-4-balamanikandan.gunasundar@microchip.com>
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

Add support for atmel legacy nand controllers. These bindings should not be
used with the new device trees.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---

Changes in v2:

- Filename matching the compatibles
- Remove "bindings" from the subject
- Remove "deprecated" as these are the only bindings available for the devices
- Add missing constraints.
- Add default for nand-ecc-mode
- Add 32 in pmecc-cap for sama5d2
- Add default for sector-size, pmecc-lookup-table-offset, nand-bus-width

 .../devicetree/bindings/mtd/atmel-nand.txt    | 116 -------------
 .../devicetree/bindings/mtd/atmel-nand.yaml   | 163 ++++++++++++++++++
 2 files changed, 163 insertions(+), 116 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
deleted file mode 100644
index 1934614a9298..000000000000
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ /dev/null
@@ -1,116 +0,0 @@
-Deprecated bindings (should not be used in new device trees):
-
-Required properties:
-- compatible: The possible values are:
-	"atmel,at91rm9200-nand"
-	"atmel,sama5d2-nand"
-	"atmel,sama5d4-nand"
-- reg : should specify localbus address and size used for the chip,
-	and hardware ECC controller if available.
-	If the hardware ECC is PMECC, it should contain address and size for
-	PMECC and PMECC Error Location controller.
-	The PMECC lookup table address and size in ROM is optional. If not
-	specified, driver will build it in runtime.
-- atmel,nand-addr-offset : offset for the address latch.
-- atmel,nand-cmd-offset : offset for the command latch.
-- #address-cells, #size-cells : Must be present if the device has sub-nodes
-  representing partitions.
-
-- gpios : specifies the gpio pins to control the NAND device. detect is an
-  optional gpio and may be set to 0 if not present.
-
-Optional properties:
-- atmel,nand-has-dma : boolean to support dma transfer for nand read/write.
-- nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
-  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
-  "soft_bch".
-- atmel,has-pmecc : boolean to enable Programmable Multibit ECC hardware,
-  capable of BCH encoding and decoding, on devices where it is present.
-- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
-  Controller. Supported values are: 2, 4, 8, 12, 24. If the compatible string
-  is "atmel,sama5d2-nand", 32 is also valid.
-- atmel,pmecc-sector-size : sector size for ECC computation. Supported values
-  are: 512, 1024.
-- atmel,pmecc-lookup-table-offset : includes two offsets of lookup table in ROM
-  for different sector size. First one is for sector size 512, the next is for
-  sector size 1024. If not specified, driver will build the table in runtime.
-- nand-bus-width : 8 or 16 bus width if not present 8
-- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
-
-Nand Flash Controller(NFC) is an optional sub-node
-Required properties:
-- compatible : "atmel,sama5d3-nfc".
-- reg : should specify the address and size used for NFC command registers,
-        NFC registers and NFC SRAM. NFC SRAM address and size can be absent
-        if don't want to use it.
-- clocks: phandle to the peripheral clock
-Optional properties:
-- atmel,write-by-sram: boolean to enable NFC write by SRAM.
-
-Examples:
-nand0: nand@40000000,0 {
-	compatible = "atmel,at91rm9200-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg = <0x40000000 0x10000000
-	       0xffffe800 0x200
-	      >;
-	atmel,nand-addr-offset = <21>;	/* ale */
-	atmel,nand-cmd-offset = <22>;	/* cle */
-	nand-on-flash-bbt;
-	nand-ecc-mode = "soft";
-	gpios = <&pioC 13 0	/* rdy */
-		 &pioC 14 0 	/* nce */
-		 0		/* cd */
-		>;
-	partition@0 {
-		...
-	};
-};
-
-/* for PMECC supported chips */
-nand0: nand@40000000 {
-	compatible = "atmel,at91rm9200-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	reg = < 0x40000000 0x10000000	/* bus addr & size */
-		0xffffe000 0x00000600	/* PMECC addr & size */
-		0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
-		0x00100000 0x00100000	/* ROM addr & size */
-		>;
-	atmel,nand-addr-offset = <21>;	/* ale */
-	atmel,nand-cmd-offset = <22>;	/* cle */
-	nand-on-flash-bbt;
-	nand-ecc-mode = "hw";
-	atmel,has-pmecc;	/* enable PMECC */
-	atmel,pmecc-cap = <2>;
-	atmel,pmecc-sector-size = <512>;
-	atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
-	gpios = <&pioD 5 0	/* rdy */
-		 &pioD 4 0	/* nce */
-		 0		/* cd */
-		>;
-	partition@0 {
-		...
-	};
-};
-
-/* for NFC supported chips */
-nand0: nand@40000000 {
-	compatible = "atmel,at91rm9200-nand";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-        ...
-        nfc@70000000 {
-		compatible = "atmel,sama5d3-nfc";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		clocks = <&hsmc_clk>
-		reg = <
-			0x70000000 0x10000000	/* NFC Command Registers */
-			0xffffc000 0x00000070	/* NFC HSMC regs */
-			0x00200000 0x00100000	/* NFC SRAM banks */
-		>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.yaml b/Documentation/devicetree/bindings/mtd/atmel-nand.yaml
new file mode 100644
index 000000000000..8afc4a144caf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/atmel-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel NAND flash controller
+
+maintainers:
+  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
+
+description: |
+  Atmel nand flash controller. This should not be used for new device
+  trees. For the latest controllers refer microchip,nand-controller.yaml
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91rm9200-nand
+      - atmel,sama5d2-nand
+      - atmel,sama5d4-nand
+
+  reg:
+    description:
+      The localbus address and size used for the chip, and hardware ECC
+      controller if available. If the hardware ECC is PMECC, it should
+      contain address and size for PMECC and PMECC Error Location
+      controller. The PMECC lookup table address and size in ROM is
+      optional. If not specified, driver will build it in runtime.
+
+  atmel,nand-addr-offset:
+    description:
+      offset for the address latch.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+
+  atmel,nand-cmd-offset:
+    description:
+      offset for the command latch.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+
+  '#address-cells': true
+
+  '#size-cells': true
+
+  gpios:
+    description:
+      specifies the gpio pins to control the NAND device. detect is an
+      optional gpio and may be set to 0 if not present.
+    minItems: 1
+    maxItems: 3
+
+  atmel,nand-has-dma:
+    description:
+      support dma transfer for nand read/write.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  atmel,has-pmecc:
+    description:
+      enable Programmable Multibit ECC hardware, capable of BCH encoding
+      and decoding, on devices where it is present.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nand-on-flash-bbt:
+    description:
+      enable on flash bbt option if not present false
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nand-ecc-mode:
+    description:
+      operation mode of the NAND ecc
+    enum:
+      [none, soft, hw, hw_syndrome, hw_oob_first, soft_bch]
+    default: soft
+    $ref: /schemas/types.yaml#/definitions/string
+
+
+  atmel,pmecc-cap:
+    description:
+      error correct capability for Programmable Multibit ECC Controller.
+    enum:
+      [2, 4, 8, 12, 24, 32]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  atmel,pmecc-sector-size:
+    description:
+      sector size for ECC computation.
+    enum:
+      [512, 1024]
+    default: 512
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+
+  atmel,pmecc-lookup-table-offset:
+    description:
+      Two offsets of lookup table in ROM for different sector size. First
+      one is for sector size 512, the next is for sector size 1024. If not
+      specified, driver will build the table in runtime.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    default: 512
+
+  nand-bus-width:
+    description:
+      nand bus width
+    enum:
+      [8, 16]
+    default: 8
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - atmel,nand-addr-offset
+  - atmel,nand-cmd-offset
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nand@40000000,0 {
+        compatible = "atmel,at91rm9200-nand";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x40000000 0x10000000
+               0xffffe800 0x200>;
+        atmel,nand-addr-offset = <21>;	/* ale */
+        atmel,nand-cmd-offset = <22>;	/* cle */
+        nand-on-flash-bbt;
+        nand-ecc-mode = "soft";
+        gpios = <&pioC 13 0	/* rdy */
+                 &pioC 14 0 /* nce */
+                 0		/* cd */
+                >;
+    };
+  - |
+    /* for PMECC supported chips */
+    nand1@40000000 {
+        compatible = "atmel,at91rm9200-nand";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x40000000 0x10000000	/* bus addr & size */
+               0xffffe000 0x00000600	/* PMECC addr & size */
+               0xffffe600 0x00000200	/* PMECC ERRLOC addr & size */
+               0x00100000 0x00100000>;	/* ROM addr & size */
+
+        atmel,nand-addr-offset = <21>;	/* ale */
+        atmel,nand-cmd-offset = <22>;	/* cle */
+        nand-on-flash-bbt;
+        nand-ecc-mode = "hw";
+        atmel,has-pmecc;	/* enable PMECC */
+        atmel,pmecc-cap = <2>;
+        atmel,pmecc-sector-size = <512>;
+        atmel,pmecc-lookup-table-offset = <0x8000 0x10000>;
+        gpios = <&pioD 5 0	/* rdy */
+                 &pioD 4 0	/* nce */
+                 0		/* cd */
+                >;
+    };
-- 
2.34.1


