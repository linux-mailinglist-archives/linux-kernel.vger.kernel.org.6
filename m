Return-Path: <linux-kernel+bounces-555194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A266A5A6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDABB1884047
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F51E8339;
	Mon, 10 Mar 2025 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/4/OCB0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5936B;
	Mon, 10 Mar 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644481; cv=none; b=tUM73972zIKL80UC6XkV8y2iDLTNUWoi3y00bKcuDPEh7OdkNplUGvMm9pgs9OgI7c9kQ3jCbAY2/NivtEuZGtPMrorFwZb9mb9bzTKop5jtE1Z6hXSE/eyTGYJ7vtm4MdGhFsLyNWxLZJmYyi/JblCqXdFtkoTeFZBdsaNCjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644481; c=relaxed/simple;
	bh=oaQhe+dmVE4Ni7Ifv3uW7vdmevvK7rvXJMBO9gKwwxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4s2BCmIvhnPn1TIpVZrLFJ2QLnnJLwVEmMaLis9hepw71dzjyi52GvAN27pNaxtwsNRYABZkznTSINDgAt0VpooOyANzAUiwdlZrI+IbSn1QHueY1pue0mzCFQ94UF8XiZp0jQw1kQ5u4IjC/6AlCuJ7zvJ/57R5uuxNdOVwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/4/OCB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92966C4CEED;
	Mon, 10 Mar 2025 22:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741644480;
	bh=oaQhe+dmVE4Ni7Ifv3uW7vdmevvK7rvXJMBO9gKwwxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p/4/OCB0VE3+QIL1WWn1tDiMGzJXlTnFKiA0DxONW9lE3KJy3hnMC3/btqphjFq5g
	 SN9Ycy1STuZBGKAdtj46p3WjnDYgtSFtoAXEO9U7ojxIDFeYlXfi8WsXrf2XJi5OxV
	 r/PM6EgeAHhvTGw46nylPXFasXz1WTGmFY59AkPvq8GYc6lrYURLKR6ttOTaboZaue
	 h80QsxyTAWb9GU78vZzG96TXMY/9poy65Eqj6Ni4UFxLO6s/d8mWahWlEiH0TntYXn
	 kc8EowT6xTzGMRCbTmsvvinVFkLuRnxlwrF9nHP4CNOAuZclUB1vY2HdKxRkM4B4VV
	 gve+atDtFUXyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D70C28B30;
	Mon, 10 Mar 2025 22:08:00 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Mon, 10 Mar 2025 23:07:58 +0100
Subject: [PATCH v3 1/3] dt-bindings: spmi: Add Apple SPMI controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-spmi-v3-1-92a82e7d9f0d@gmail.com>
References: <20250310-spmi-v3-0-92a82e7d9f0d@gmail.com>
In-Reply-To: <20250310-spmi-v3-0-92a82e7d9f0d@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741644479; l=2426;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=pDg6BHX8yhXPsIWO6kJBvdxVHd8GSLyf4Z1JkcNwg+U=;
 b=KiRktVb0Tmmq+7Xhyq0yRNnEROe9ZZyi+ImNWMBOjbCeAmMaUpU005jmU+n3nQ1fYBavPgpa2
 +okBPspZAOyAsCW5lCzO9nyn6DyALt4HgZONMs6/rnNn/kz69oYue3l
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add bindings for the SPMI controller present on most Apple SoCs

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../devicetree/bindings/spmi/apple,spmi.yaml       | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..16bd7eb2b7af2c0b176f0e5b1970f4670af691da
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/apple,spmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SPMI controller
+
+maintainers:
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: A SPMI controller present on most Apple SoCs
+
+allOf:
+  - $ref: spmi.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-spmi
+          - apple,t6000-spmi
+          - apple,t8112-spmi
+      - const: apple,spmi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/spmi/spmi.h>
+
+    spmi@920a1300 {
+        compatible = "apple,t6000-spmi", "apple,spmi";
+        reg = <0x920a1300 0x100>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        pmic@f {
+            reg = <0xf SPMI_USID>;
+            /* PMIC-specific properties */
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0e33544fa373a4978b7dae18c040c..271ff8110df83c2d4fe7fbbfffc0a72259460bc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2236,6 +2236,7 @@ F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c

-- 
2.48.1



