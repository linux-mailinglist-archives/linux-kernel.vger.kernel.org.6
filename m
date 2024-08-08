Return-Path: <linux-kernel+bounces-278869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A294B5D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC231C21BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28969142E6F;
	Thu,  8 Aug 2024 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ew2a9bdp"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5083A18;
	Thu,  8 Aug 2024 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090491; cv=none; b=ODCE2exQObLdf9ObBpdQWxUg4gkUOEPrj1Eb0Te+gse1M2VBeKkk6ab3mvtMvmldkiVLrIK/krauqm56RYnyE4hvCWJAMohIXEOeApNlrAOBEhRW4PWeSEHoc91PgnF3xv/opGknr9Crm8wZVIo/qmJk/LzBtc5QecVJ/hVNGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090491; c=relaxed/simple;
	bh=x3KYHMcmxxGHTVG9a9xtFf27MrMH8W+Dmosr0UY6m0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YImPNdnlDNlLHqoD09oMlncIusF4gxAHJbRdbkNqdlXkwfYI+Cdw7CPvIj9DCGrKyG6kWVkNlAN8gUWA6CiiHa6DprSjQJrfoNgWwiQpKQAmG70crg3yOI1feM2ZaYczqmGzkqbg4/NWKdHgA7veclmcA1IRnXoLH8MKaf/aANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ew2a9bdp; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723090487;
	bh=zIjev60vJCRiNsPPi+LvlB3D8Ln+9QLJSlUZ5NQKHQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ew2a9bdpziluTiV6kHB2atR+og2mPO0pHxrTP1ctbg3pgwE/hmJm1+w47oQQz1hBp
	 mskBNAjhkczrTfhJkZ/o5YJEr7dNHWzPqk6045hmHMQ48W4gh1KJvytSrPE3Tg3WM6
	 VX09XihxIfsHw7yX8YthTWsScEMoqME79V9EZwk5kXrgv1G7nYybYnHWFTaGZnfqwp
	 NP2b+/fZ83xPtnUi2PgPkVdAtBILI21zubJaRsOTq+sQmQS/k/PhRSRrowtNOdciWn
	 cC2vAwvLwu/LwJ9boPxtjpzRqJ3PM+4+YCYmeRb+4fUhvGKRYOpJe2nVZj/OdM/T79
	 sdYd/ElAkkUtQ==
Received: from [127.0.1.1] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D2EEF66FA3;
	Thu,  8 Aug 2024 12:14:46 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 Aug 2024 13:44:25 +0930
Subject: [PATCH v2 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-2-c2531e02633d@codeconstruct.com.au>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
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
index 000000000000..accf1a7ecf12
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
+    maxItems: 1
+    description:
+      A bitmap of supported sources for the implementation.
+
+  copro-sw-interrupts:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 32
+    description:
+      A list of interrupt numbers that can be used as software interrupts from
+      the ARM to the coprocessor.
+
+required:
+  - compatible
+  - reg
+  - valid-sources
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


