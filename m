Return-Path: <linux-kernel+bounces-272134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CDA9457A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C21C23B93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0514D481CE;
	Fri,  2 Aug 2024 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ILzoFj4J"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE6219E0;
	Fri,  2 Aug 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577013; cv=none; b=iGMADv+zflZnDCumQByQoho0hOV98PEcRahjculeresdi4/OA3767b9/2mNI8Nvo8fh86bCG+Tt3Wy7jOguUxbFsNdj/13zDgdiYkh1AF7qfd4pMcVJQY6+DfsrX4JldLfgYxqUMPJvdHuTX9TvtIuyYaopaKgv1rxjmAtiur1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577013; c=relaxed/simple;
	bh=ooTfAKgcliNh+7LAC4AvpkSHUHdM6+X7wEVC5oeAho4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rODgk0/42F2VvQgCdozvuZTX73gO6aZY9aLxvoD3OWiqzMS4w2QLoeT+JYw69XthjxttvEU1U7KBBGWxDzYjoOfGD3qfa5B+VhAW8M+0LdWgAEaGyP+3IPeXNq6DiJxuiwqHCbpY8BllGfqcbnPslH6mybWy/kd2MYK0lryo3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ILzoFj4J; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722577009;
	bh=xlZ4/Kw11xpyrMXD0cAsdFdsF3dDK1F5MYgwiSI6304=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ILzoFj4JHHtHcpMCOKJ6MMAerPlbAY5PRWfKzguT3wZFVbawVINU/c8u8K+tKi9LD
	 abfvrYUJKiZZdj/V4Qb6HljDj5VhanCYBR38ngzyefmHQJuHpQYa5nLmDPsC1nMeJ0
	 +b3chIs0EJleJtkJOiHXqjHGWfn/AmskmYg8joBeaNMSgCC+Gp53s6WH5lua+P4Rvq
	 t4HSP7mbvlvWzfdnrlz1jpGtot81TM8JZZ7rgZHlawSbNTjRXICA/rdapC55aH1diD
	 fVWcMQv0wG8bT/+e1jd3oRb8G4uJ6AYI0KFmbLmxOpd5X4Yp6faA1ROFLOWW1dMuB6
	 BbfZaFWMtVigA==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0888C66E06;
	Fri,  2 Aug 2024 13:36:48 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 15:06:31 +0930
Subject: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
X-Mailer: b4 0.14.1

Address warnings such as:

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: interrupt-controller@1e6c0080: 'valid-sources' does not match any of the regexes: 'pinctrl-[0-9]+'

and

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/copro-interrupt-controller@1e6c2000: failed to match any schema with compatible: ['aspeed,ast2400-cvic', 'aspeed-cvic']

Note that the conversion to DT schema causes some further warnings to
be emitted, because the Aspeed devicetrees are not in great shape. These
new warnings are resolved in a separate series:

https://lore.kernel.org/lkml/20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au/

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 ++++++++++++++++++++++
 .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 -------------
 2 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
new file mode 100644
index 000000000000..3c85b4924c05
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/aspeed,ast2400-cvic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Coprocessor Vectored Interrupt Controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+description:
+  The Aspeed AST2400 and AST2500 SoCs have a controller that provides interrupts
+  to the ColdFire coprocessor. It's not a normal interrupt controller and it
+  would be rather inconvenient to create an interrupt tree for it, as it
+  somewhat shares some of the same sources as the main ARM interrupt controller
+  but with different numbers.
+
+  The AST2500 also supports a software generated interrupt.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2400-cvic
+          - aspeed,ast2500-cvic
+      - const: aspeed,cvic
+
+  reg:
+    maxItems: 1
+
+  valid-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      One cell, bitmap of support sources for the implementation.
+
+  copro-sw-interrupts:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      A list of interrupt numbers that can be used as software interrupts from
+      the ARM to the coprocessor.
+
+required:
+  - compatible
+  - reg
+  - valid-sources
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@1e6c2000 {
+        compatible = "aspeed,ast2500-cvic", "aspeed,cvic";
+        reg = <0x1e6c2000 0x80>;
+        valid-sources = <0xffffffff>;
+        copro-sw-interrupts = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
deleted file mode 100644
index d62c783d1d5e..000000000000
--- a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* ASPEED AST2400 and AST2500 coprocessor interrupt controller
-
-This file describes the bindings for the interrupt controller present
-in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
-ColdFire coprocessor.
-
-It is not a normal interrupt controller and it would be rather
-inconvenient to create an interrupt tree for it as it somewhat shares
-some of the same sources as the main ARM interrupt controller but with
-different numbers.
-
-The AST2500 supports a SW generated interrupt
-
-Required properties:
-- reg: address and length of the register for the device.
-- compatible: "aspeed,cvic" and one of:
-		"aspeed,ast2400-cvic"
-	      or
-		"aspeed,ast2500-cvic"
-
-- valid-sources: One cell, bitmap of supported sources for the implementation
-
-Optional properties;
-- copro-sw-interrupts: List of interrupt numbers that can be used as
-		       SW interrupts from the ARM to the coprocessor.
-		       (AST2500 only)
-
-Example:
-
-	cvic: copro-interrupt-controller@1e6c2000 {
-		compatible = "aspeed,ast2500-cvic";
-		valid-sources = <0xffffffff>;
-		copro-sw-interrupts = <1>;
-		reg = <0x1e6c2000 0x80>;
-	};

-- 
2.39.2


