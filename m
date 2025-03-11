Return-Path: <linux-kernel+bounces-556122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAECA5C138
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33DD3B3ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D62571BE;
	Tue, 11 Mar 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="13BhIx9g"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F39256C97;
	Tue, 11 Mar 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696164; cv=none; b=erIZ70eOY4yjz1y0+5ZcclUTnudQcZbncI3bXMMNhMd9hD15oNMwNXUibsaaYu9YaVC1dM6CySLf3ShBa1TbjyF5BEOPd1UxHQQs/BV+GTr22xt1F1gF1WHIDK89NJ9ugn6+tOYidB1B2oC6ep7LYOh7PTwUZyLUr00EJadnV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696164; c=relaxed/simple;
	bh=wsbYRx34YWCglXy0p0R4CnqDsNR0QSvNibV/OSOSWTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DATzmQhDg3HUCoDf4NTndo/34tZZJUu5E/GB14d1LEZ3v7d7UKZsley/eQVynxF+ruF46DLfWc3Ab66i7AONfrqX7eclj2GNbYGV2RCpqxTNgiazNrKeUpu8PbNX5iKgZlixyrZs6O5JSF0vrIXW2uM7FzI3noDWJMPuRv0u4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=13BhIx9g; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741696162; x=1773232162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsbYRx34YWCglXy0p0R4CnqDsNR0QSvNibV/OSOSWTc=;
  b=13BhIx9gbhfHFc+BUjUdIef9dockQIr34QsIsp+uucuQ86Wlbvd4YQvg
   /2fxTedx+AQkYlCmkSSiTpmjKi7Ef4nysiabikeKC5SoTAQLvXLJylktQ
   eMfpRGYYVsh4RT7uLkBf55rbpgJPnCXjo8h+D6cXdwJ7L2nSOngZRQstL
   nhauAMCf8Ru92j33RLp+VKdKuUKV4IiEC11WAyr/f17XeVYD0yVUkETTA
   HZ9pAm/zisG3N9eJj5xVJozjkXrxRLLZlvhCOP8z2lig5tsnBffVxMoMF
   exTvJH/ZkEK2Z2ylLAs/xFp9jLRFnD9ZzBsgZbjFktYkz3mBscJRCxS4y
   Q==;
X-CSE-ConnectionGUID: d0aXCjEFQVuCEk822uv6wQ==
X-CSE-MsgGUID: 9YqJFWjCSDuq4gNMLOkb/Q==
X-IronPort-AV: E=Sophos;i="6.14,239,1736838000"; 
   d="scan'208";a="39234197"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 05:29:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Mar 2025 05:29:15 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 05:29:09 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <krzysztof.kozlowski+dt@linaro.org>
CC: <balamanikandan.gunasundar@microchip.com>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: mtd: microchip-nand: add atmel pmecc
Date: Tue, 11 Mar 2025 17:58:46 +0530
Message-ID: <20250311122847.90081-3-balamanikandan.gunasundar@microchip.com>
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

Add bindings for programmable multibit error correction code controller
(PMECC).

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---

Changes in v2:
- Rename filename to match compatible string
- Add constraints for sam9x7
- Droped unused dt labels 

.../devicetree/bindings/mtd/atmel-nand.txt    | 61 -----------------
 .../bindings/mtd/microchip,pmecc.yaml         | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index dbbc17a866f2..1934614a9298 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -1,64 +1,3 @@
-* ECC engine (PMECC) bindings:
-
-Required properties:
-- compatible: should be one of the following
-	"atmel,at91sam9g45-pmecc"
-	"atmel,sama5d4-pmecc"
-	"atmel,sama5d2-pmecc"
-	"microchip,sam9x60-pmecc"
-	"microchip,sam9x7-pmecc", "atmel,at91sam9g45-pmecc"
-- reg: should contain 2 register ranges. The first one is pointing to the PMECC
-       block, and the second one to the PMECC_ERRLOC block.
-
-Example:
-
-	nfc_io: nfc-io@70000000 {
-		compatible = "atmel,sama5d3-nfc-io", "syscon";
-		reg = <0x70000000 0x8000000>;
-	};
-
-	pmecc: ecc-engine@ffffc070 {
-		compatible = "atmel,at91sam9g45-pmecc";
-                reg = <0xffffc070 0x490>,
-                      <0xffffc500 0x100>;
-	};
-
-	ebi: ebi@10000000 {
-		compatible = "atmel,sama5d3-ebi";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		atmel,smc = <&hsmc>;
-		reg = <0x10000000 0x10000000
-		       0x40000000 0x30000000>;
-		ranges = <0x0 0x0 0x10000000 0x10000000
-			  0x1 0x0 0x40000000 0x10000000
-			  0x2 0x0 0x50000000 0x10000000
-			  0x3 0x0 0x60000000 0x10000000>;
-		clocks = <&mck>;
-
-                nand_controller: nand-controller {
-			compatible = "atmel,sama5d3-nand-controller";
-			atmel,nfc-sram = <&nfc_sram>;
-			atmel,nfc-io = <&nfc_io>;
-			ecc-engine = <&pmecc>;
-			#address-cells = <2>;
-			#size-cells = <1>;
-			ranges;
-
-			nand@3 {
-				reg = <0x3 0x0 0x800000>;
-				atmel,rb = <0>;
-
-				/*
-				 * Put generic NAND/MTD properties and
-				 * subnodes here.
-				 */
-			};
-		};
-	};
-
------------------------------------------------------------------------
-
 Deprecated bindings (should not be used in new device trees):
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml b/Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml
new file mode 100644
index 000000000000..98260a691a2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/microchip,pmecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip pmecc controller
+
+maintainers:
+  - Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
+
+description: |
+  Bindings for microchip Programmable Multibit Error Correction Code
+  Controller (PMECC). pmecc is a programmable BCH encoder/decoder. This
+  block is passed as the value to the "ecc-engine" property of microchip
+  nand flash controller node.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9g45-pmecc
+          - atmel,sama5d2-pmecc
+          - atmel,sama5d4-pmecc
+          - microchip,sam9x60-pmecc
+          - microchip,sam9x7-pmecc
+      - items:
+          - const: microchip,sam9x7-pmecc
+          - const: atmel,at91sam9g45-pmecc
+      - items:
+          - const: microchip,sam9x60-pmecc
+          - const: atmel,at91sam9g45-pmecc
+
+  reg:
+    items:
+      - description: Base address and size of PMECC controller registers
+      - description: Base address and size of PMECC_ERRLOC controller
+
+  clocks:
+    description: The clock source for pmecc controller
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,sam9x7-pmecc
+    then:
+      properties:
+        clocks:
+          description: The clock source for pmecc controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ecc-engine@ffffc070 {
+        compatible = "microchip,sam9x7-pmecc";
+        reg = <0xffffe000 0x300>,
+              <0xffffe600 0x100>;
+        clocks = <&pmc 2 48>;
+    };
-- 
2.34.1


