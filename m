Return-Path: <linux-kernel+bounces-564260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B244A65158
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E983E1685AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A758023F381;
	Mon, 17 Mar 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yQzBbGQ+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E523E25A;
	Mon, 17 Mar 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218615; cv=none; b=dUtri2ZOqiEzRD3EjO9Rges5/Cu6wUYWxaFvGEZ6ux9RlTWyyr+NAdybdliKe7uiYdXX/rgauwsN4ptQZA5WfHw5CJ5rLYLxODhuMRDbLhTPFGMgee+2/bmc3FsMBAhTauA29lyK8GYITzDpj5y4eT3S9JpaFHdzjJ10bZXgu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218615; c=relaxed/simple;
	bh=uUzD2tKx/yOkzia97EwCKxdMZuH21Iwtc+D4U9gO9Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IzhST1xjxLF/U1i9WVyeSsYhz6Q8/Goj0dE9hMnVXI/J4qD66wtnSa8ZJYp0m7svEbUq9MmpBmgClnKU/KyX5blX0jKsFkBjFIXVlz++5bwbW6uSWgeOhDtRk2yYEbe/LXBSwku871CNBmT2wYOHT9IrGwVI24iYbq12qKdEXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yQzBbGQ+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742218613; x=1773754613;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=uUzD2tKx/yOkzia97EwCKxdMZuH21Iwtc+D4U9gO9Ys=;
  b=yQzBbGQ+SiuAYs30SoNM1FkrhSkBKigJHTD5cKKta3mas+9KUQrrkiIx
   UxRMgz6qn/Kn5FxD9lG6WYwo5AB1PTGvO4CM47/Bcw7cfh8ISPsfy3Xnm
   sp5djWfHo8y2vXCUdrjjz8LI02MMGqQANgrF4/mmC3KiSuebaufOa6avh
   LGzbDESEblBf9FVgcL2eLhMNEAClrTryLr3BB4CbW6Qk+2b/uQDG7kagt
   cemoIC/oQkYVS7RDqv7weLoHA+A3cEIXHU7EZ4PFEy5InWRx9Qu2vCg9y
   CDnQEyr5BCQFV2zZ4uSthhdWwd2S78P3uyFtxdNYXZsCMhYw591jqFCRX
   A==;
X-CSE-ConnectionGUID: wbEqb9OZQ2CrxMjUvyeqZg==
X-CSE-MsgGUID: vfBAesImS76EIy4wVtfOmw==
X-IronPort-AV: E=Sophos;i="6.14,254,1736838000"; 
   d="scan'208";a="39256375"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2025 06:36:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 06:36:24 -0700
Received: from [10.40.56.22] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 17 Mar 2025 06:36:19 -0700
From: Nayab Sayed <nayabbasha.sayed@microchip.com>
Date: Mon, 17 Mar 2025 19:01:08 +0530
Subject: [PATCH RESEND] dt-bindings: mtd: atmel,dataflash: convert txt to
 yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250317-atmel-dataflash-v1-1-1a3247f40299@microchip.com>
X-B4-Tracking: v=1; b=H4sIABsk2GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3cSS3NQc3ZTEksS0nMTiDF1LE8Pk1KRkSxOjxFQloK6CotS0zAq
 widFKQa7Brn4uSrG1tQByJOstaQAAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Nayab Sayed" <nayabbasha.sayed@microchip.com>
X-Mailer: b4 0.14.1

Convert atmel-dataflash.txt into atmel,dataflash.yaml

Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
---
 .../devicetree/bindings/mtd/atmel,dataflash.yaml   | 55 ++++++++++++++++++++++
 .../devicetree/bindings/mtd/atmel-dataflash.txt    | 17 -------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/atmel,dataflash.yaml b/Documentation/devicetree/bindings/mtd/atmel,dataflash.yaml
new file mode 100644
index 000000000000..8c72fa346e36
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/atmel,dataflash.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/atmel,dataflash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel DataFlash
+
+maintainers:
+  - Nayab Sayed <nayabbasha.sayed@microchip.com>
+
+description:
+  The Atmel DataFlash is a low pin-count serial interface sequential access
+  Flash memory, compatible with SPI standard. The device tree may optionally
+  contain sub-nodes describing partitions of the address space.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at45db321d
+              - atmel,at45db041e
+              - atmel,at45db642d
+              - atmel,at45db021d
+          - const: atmel,at45
+          - const: atmel,dataflash
+      - items:
+          - const: atmel,at45
+          - const: atmel,dataflash
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: mtd.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@1 {
+            compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+            reg = <1>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
deleted file mode 100644
index 1889a4db5b7c..000000000000
--- a/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Atmel Data Flash
-
-Required properties:
-- compatible : "atmel,<model>", "atmel,<series>", "atmel,dataflash".
-
-The device tree may optionally contain sub-nodes describing partitions of the
-address space. See partition.txt for more detail.
-
-Example:
-
-flash@1 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
-	spi-max-frequency = <25000000>;
-	reg = <1>;
-};

---
base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
change-id: 20250317-atmel-dataflash-941cebc942ae

Best regards,
-- 
Nayab Sayed <nayabbasha.sayed@microchip.com>


