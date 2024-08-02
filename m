Return-Path: <linux-kernel+bounces-272133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D29457A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F91C23B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8842AAB;
	Fri,  2 Aug 2024 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BrsLvjTS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08B3D6A;
	Fri,  2 Aug 2024 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577012; cv=none; b=puk2Nng1wvQY9+KJGLGEZ1b/LIxpDVhRxypbDgKOtlwOkI/uqeMrRgwO1Pbe6YwkFgF2ofQ0IzY9i0VNTkLJlc6QDGfPR02GJeBBvucre4se4bq+GziwCa9LhXjA+KTm4LAb3ylEKfgSe/eiqsT5NxG0eWFNTpoaq61UHSwZ2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577012; c=relaxed/simple;
	bh=97xfLsN24yrB7LbFmj8vr21mXm5z58vAjfQSjMZZSPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4qrYmfdEBq/T8HgZyGtXcwbCoeza715WyW9P5iEN/wY/VNsceYzl60ZokXDjvIsVFe78pbIv3gRo4A849/1w09CNyjaYi0ouqyAUzL5QGcUnJhyVLKJQe3ydbV4QGXaEpkyD1cyu5uUvmtf3YT6XreTeqfEJ2aJCi2NVey6x8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BrsLvjTS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722577008;
	bh=21uSmggtGjSSVl6e7jX24nwcCPrx0PnGnisi64/bATE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BrsLvjTSbq/dLJDxRJrGY8ZONIDIrNmWysoYOSZXq0D6gRbk9noL/m8qF3SV9Pxu3
	 rTZH0nTLNKlc6foMcgjLwdahCjWNv7LHRY+2OpIfULzBu4p6nfD0MQYgOGUjyZlSpr
	 QG6gJpvH5EfR7ok0Mx6Wkv8PQpKYl/FrYYhnGjshNP1HJN9TyvqRNMo368KIqPaAP5
	 AlovjGXWRvUrRhzhv2jlsNKkiR8dmXiEubwhAE6i8RyEG4B3uSD4sxkHlPaOW/6c2N
	 O3VYItOJAzfTD8Czv+ZAEUKvomQLL+HF1zgL/7YLeSvFJUJpwolV9azWSGoTc5QcuU
	 IfbhG54tYwkxw==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4776E66CBD;
	Fri,  2 Aug 2024 13:36:48 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 15:06:30 +0930
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: aspeed,ast2400-vic:
 Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-1-8cd4266d2094@codeconstruct.com.au>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
X-Mailer: b4 0.14.1

Squash warnings such as:

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/interrupt-controller@1e6c0080: failed to match any schema with compatible: ['aspeed,ast2400-vic']

The YAML DT schema defines an optional property, valid-sources, which
was not previously described in the prose binding. It is added to
document existing practice in the Aspeed devicetrees. Unfortunately
the property seems to predate the requirement that vendor-specific
properties be prefixed.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
 .../interrupt-controller/aspeed,ast2400-vic.yaml   | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
deleted file mode 100644
index e3fea0758d25..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Aspeed Vectored Interrupt Controller
-
-These bindings are for the Aspeed interrupt controller. The AST2400 and
-AST2500 SoC families include a legacy register layout before a re-designed
-layout, but the bindings do not prescribe the use of one or the other.
-
-Required properties:
-
-- compatible : "aspeed,ast2400-vic"
-               "aspeed,ast2500-vic"
-
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 1.
-
-Example:
-
- vic: interrupt-controller@1e6c0080 {
-      compatible = "aspeed,ast2400-vic";
-      interrupt-controller;
-      #interrupt-cells = <1>;
-      reg = <0x1e6c0080 0x80>;
- };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
new file mode 100644
index 000000000000..1ecbc55571e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2400-vic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Vectored Interrupt Controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+description:
+  The AST2400 and AST2500 SoC families include a legacy register layout before
+  a redesigned layout, but the bindings do not prescribe the use of one or the
+  other.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-vic
+      - aspeed,ast2500-vic
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      Specifies the number of cells needed to encode an interrupt source. It
+      must be 1 as the VIC has no configuration options for interrupt sources.
+      The single cell defines the interrupt number.
+
+  valid-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      One cell, bitmap of support sources for the implementation.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@1e6c0080 {
+         compatible = "aspeed,ast2400-vic";
+         reg = <0x1e6c0080 0x80>;
+         interrupt-controller;
+         #interrupt-cells = <1>;
+    };
+
+...

-- 
2.39.2


