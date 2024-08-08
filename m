Return-Path: <linux-kernel+bounces-278868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDF94B5D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48874B20F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B013AD13;
	Thu,  8 Aug 2024 04:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OQgBPHo/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3D9479;
	Thu,  8 Aug 2024 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090490; cv=none; b=pGar3Uc+SX9uFIm3FhaMk20wSg10FqP3/o7dHiyxVMmH780cz/H2p3PwAoOcg6p67IzFrrSYreELsIaUs8tjMIu93Rl2HhArZQqDHr5JOlCThjm/HHnJa8x+MgzYIiQIk0knsErgacWtYiC02Wy+wj3a5KieGE5WjO2eI6IwgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090490; c=relaxed/simple;
	bh=CqnZOTH+umhn8OVccPsARByDkCZQTZkoHkal8t0kf/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfrE9vSTpfAElGttt+QX47TR++PEMrJV4Q8yLlLW2tI6Drr2qp428NEEjb+NbOh7cr7WJ1HBc7+4VD/MfIpRAdzcB4kGpOd7wdBgxUSGl8gWsDCeR6kT5+hHjVsIWGXllNd7f/lO0pTUHNCNE+u4KA+e5tB9qu11nCbcsfIYVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OQgBPHo/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723090486;
	bh=23GaKS6//FPaeCfJCFK5J8Hh9VT+4RbnnIKhMh21S2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OQgBPHo/0PAsTi4H8cunz4fH0ZbDXf6x6L9eQzhNL83JeMc4cdwHDeh8/H9j8YeJq
	 UgEEayrSidrpxlEMgkkaPBwqeQoeNZVS+xAmagloYiPtCXEc44SKBGodA/s46us5mY
	 b4yJw8lYOnc2jSYEKuGPcxISpws2qzP2bJHGh2RIAmkqRER/gFPZOK+FM8r0fWbvR8
	 2omK/1ixK9pkEtTPHMOn6HoNtVhxqhMSuDsC2svpG1jfZoO9nyy7/JXJ5IxQX8KUc1
	 qTeQK+HtKphrlqgsLaFC8iFDIlNVYkJiUCNdXTrqmZztZ7x0GrVEopOPGmQu7kVbCF
	 l2K8IuPvO+/7Q==
Received: from [127.0.1.1] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2A20466F95;
	Thu,  8 Aug 2024 12:14:46 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 Aug 2024 13:44:24 +0930
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
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
 .../interrupt-controller/aspeed,ast2400-vic.yaml   | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 23 deletions(-)

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
index 000000000000..73e8b9a39bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
@@ -0,0 +1,62 @@
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
+  reg:
+    maxItems: 1
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
+    maxItems: 2
+    description:
+      A bitmap of supported sources for the implementation.
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
+         valid-sources = <0xffffffff 0x0007ffff>;
+    };
+
+...

-- 
2.39.2


