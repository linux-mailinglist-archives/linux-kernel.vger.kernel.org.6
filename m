Return-Path: <linux-kernel+bounces-441217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574239ECB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D99C1888D45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F011F191E;
	Wed, 11 Dec 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cTqxYv6A"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975821C5CD3;
	Wed, 11 Dec 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916643; cv=none; b=caVBBNtb4UC6yBy4Fl8HffOKphj4F9wWRUrOrjvN1Rp6PhiSC9/ZlTAtZbuXbyBRR9PIIornkjSpggFwVt+a/ECg8OdYUrCcj9Z6LWYBkgFBRSNLWMV7BCL5qCKUeRSe/6fpyND5ZaLILibfJziOwKbAG+o5nebCGRYnxE6+ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916643; c=relaxed/simple;
	bh=iPOrmQo40/Y6+1KGTiFI9GGLEnsZAFtFPdeZ4AoSdPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AnNGA5RLV9MN1BOlrpP2d3I7jrEa+/26GNliaKjqji76Aine22YY4OzPw2VWaRvAH4aXnTKEwV2lt2jWtmLbn8PO7dTC3rOr6h355gYKZZMR6Mt0l1iFAumhmNMR+6IlML9uaGUD0+baDn2QgPvtpoRV3qJsCwx0pZtVpFYlkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cTqxYv6A; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733916641; x=1765452641;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=iPOrmQo40/Y6+1KGTiFI9GGLEnsZAFtFPdeZ4AoSdPk=;
  b=cTqxYv6AIZSqi6PEa3ARg1lV2Z5pL0nel9hwRWdjosOFuhmOv7BmI+7J
   xDQvmCXi0irRUqsVwMcB4t5wumaNTIdtALWnOotYK+vO6DZeWdyqIQOHX
   uvvvctE8MDbSUgUmmkAKKL+96rOBtgztlxiavFeyo98XH1Olu+sYbsvIV
   zb/2xFhxPrJo2S+83Zu959P8QDg+hmrKOx9yqqlW2ZPTC8A7U+ZdfPGNo
   jOM6Shc9U7OlY7caJyhzIYsspkVetZgz/f/IirOlgIPQZrgu7NCcUgzMI
   ssVLdakuVGofFSJHQlVGC/mWZav92o4wPceChD+O9vdCyUNhVjTxwX5/V
   w==;
X-CSE-ConnectionGUID: z6mtNcPgQSWb4wbULwIckA==
X-CSE-MsgGUID: PZhcstPRSaC5msD+A2iNsg==
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="35084913"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2024 04:30:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Dec 2024 04:30:03 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Dec 2024 04:29:59 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Wed, 11 Dec 2024 16:59:22 +0530
Subject: [PATCH] dt-bindings: mfd: atmel,at91sam9260: Convert to json
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241211-matrix-v1-1-5ef0104a3af4@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJF3WWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0MD3dzEkqLMCl1jAwMjQzNzs7QkszQloOKCotS0zAqwQdGxtbUAbCM
 x6VgAAAA=
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charan Pedumuru
	<charan.pedumuru@microchip.com>
X-Mailer: b4 0.14.1

Convert old text based binding to json schema.
Changes during conversion:
Add a fallback for all compatibles as the IP core is compatible
with `syscon`.

Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
---
 .../bindings/mfd/atmel,at91sam9260-matrix.yaml     | 54 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-matrix.txt       | 26 -----------
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-matrix.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-matrix.yaml
new file mode 100644
index 000000000000..0e827882823f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-matrix.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/atmel,at91sam9260-matrix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 Bus Matrix
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+description:
+  The Bus Matrix (MATRIX) implements a multi-layer AHB, based on the
+  AHB-Lite protocol, that enables parallel access paths between multiple
+  masters and slaves in a system, thus increasing the overall bandwidth.
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+          - enum:
+              - atmel,at91sam9260-matrix
+              - atmel,at91sam9261-matrix
+              - atmel,at91sam9263-matrix
+              - atmel,at91sam9rl-matrix
+              - atmel,at91sam9g45-matrix
+              - atmel,at91sam9n12-matrix
+              - atmel,at91sam9x5-matrix
+              - atmel,sama5d3-matrix
+          - const: syscon
+      - items:
+          - const: microchip,sam9x60-matrix
+          - const: atmel,at91sam9x5-matrix
+          - const: syscon
+      - items:
+          - const: microchip,sam9x7-matrix
+          - const: atmel,at91sam9x5-matrix
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    matrix@ffffec00 {
+        compatible = "atmel,sama5d3-matrix", "syscon";
+        reg = <0xffffec00 0x200>;
+    };
diff --git a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
deleted file mode 100644
index 6e5f83614e83..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Device tree bindings for Atmel Bus Matrix
-
-The Bus Matrix registers are used to configure Atmel SoCs internal bus
-behavior (master/slave priorities, undefined burst length type, ...)
-
-Required properties:
-- compatible:		Should be one of the following
-			"atmel,at91sam9260-matrix", "syscon"
-			"atmel,at91sam9261-matrix", "syscon"
-			"atmel,at91sam9263-matrix", "syscon"
-			"atmel,at91sam9rl-matrix", "syscon"
-			"atmel,at91sam9g45-matrix", "syscon"
-			"atmel,at91sam9n12-matrix", "syscon"
-			"atmel,at91sam9x5-matrix", "syscon"
-			"atmel,sama5d3-matrix", "syscon"
-			"microchip,sam9x60-matrix", "syscon"
-			"microchip,sam9x7-matrix", "atmel,at91sam9x5-matrix", "syscon"
-- reg:			Contains offset/length value of the Bus Matrix
-			memory region.
-
-Example:
-
-matrix: matrix@ffffec00 {
-	compatible = "atmel,sama5d3-matrix", "syscon";
-	reg = <0xffffec00 0x200>;
-};

---
base-commit: 1b2ab8149928c1cea2d7eca30cd35bb7fe014053
change-id: 20241210-matrix-30021676fb6f

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


