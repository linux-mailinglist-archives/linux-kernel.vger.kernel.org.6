Return-Path: <linux-kernel+bounces-562680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF673A630BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7917957F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F55202984;
	Sat, 15 Mar 2025 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDitWXFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A417995E;
	Sat, 15 Mar 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059678; cv=none; b=OV9tRhSpGsZSCAsrEpgepoB6OScyoabO5g2uIAweIvm4FXwPAx+f/VbCgrUis5vSSIqlbr5u6wDw8j+aCiGtgIbG2garsbjmnp+DslzvyB9snKqD9VCtJxESpFARBR+QynDHDj8KOg1JuHkdIkvddZPItXWN8/nICBQyCO6hToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059678; c=relaxed/simple;
	bh=GF1FhuTL5Pb94Xq+7+UmAZGhmNzvM4UZn3qZ8ohIkzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KEz45fQMKqGWTyL7bOMPw6jhMi+4tCvLngvaDjHxLBgagv3Mvy7WUBilDAa5bZdeThA66kULQF88/kbnfGAOAz+NPNFk6fWCJXKwVT1MO8oZTnB4Eb35DHuaoVqDY1tEBB71nUgsalPGD+DCyII3BlVroiTkHLLBzhXjW4ps2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDitWXFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B42C4CEE5;
	Sat, 15 Mar 2025 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742059678;
	bh=GF1FhuTL5Pb94Xq+7+UmAZGhmNzvM4UZn3qZ8ohIkzY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=PDitWXFEKCIghC1ijLCktzxKVVaZQlboMHo0cEAp3HkXRVqmvi8dkAVlU0Q1V1OYO
	 64+D7BPRDruJ9/FBxajsdPskOYLZVc5XdZoNqRDHZDv3B+uElLy2i478sIQM+AcZA9
	 nWe5hr1bGXRaB0VFHWB//QIxm+VrnEKNh9gilLb/y0Gq4mW3ve1UTrfjz8KrG8jOpF
	 VBz3lHOTMOeDRlCDXhcnlf7P4CykpSBetu82p0lyj5N1rAM01v3hPFKL+Xho5/Iu19
	 J1RQP9gWIsahKWTyBeJ5y6/eb7B1egwpD4HoWoKHZ6BpHvlrwFI6tvQGFQXi2ICbam
	 o6gitlJYtXbmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D442AC28B28;
	Sat, 15 Mar 2025 17:27:57 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 15 Mar 2025 18:27:05 +0100
Subject: [PATCH] dt-bindings: powerpc: Convert fsl/pmc.txt to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250315-fslpmc-yaml-v1-1-10ba354a85c2@posteo.net>
X-B4-Tracking: v=1; b=H4sIAGi41WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMz3bTinILcZN3KxNwcXUuDlGQzy7Qk8xSjRCWgjoKi1LTMCrBp0bG
 1tQDeCcXEXQAAAA==
X-Change-ID: 20250226-fslpmc-yaml-90dc69fb7d2a
To: Crystal Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742059676; l=9266;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=ROIgCsvPCxP9IhicDa1mF/HFY+gVpx3zheGzT7ids68=;
 b=qlQ/n8SdxdHzpS9rxj0aXvH2NXuUrSUKoiuualvgGlUdFbIS2GU4AHLLE5t7E1jFr541mwkdM
 bFI0PBQ0gG5B+Tcvr3rqnsWQrnnWHeYwsVLMSX7tYEFcox0PJxk7x9O
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

This patch rewrites pmc.txt into YAML format. Descriptive texts are
expanded or shortened in a few places to better fit today's conventions.

The list of compatible strings (and combinations of them) is based on
existing device trees in arch/powerpc as well as compatible strings
already mentioned in the plain-text version of the binding.

One thing I didn't handle are soc-clk@... nodes as seen in
Documentation/devicetree/bindings/powerpc/fsl/pmc.yaml.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 .../devicetree/bindings/powerpc/fsl/pmc.txt        |  63 --------
 .../devicetree/bindings/powerpc/fsl/pmc.yaml       | 159 +++++++++++++++++++++
 2 files changed, 159 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
deleted file mode 100644
index 07256b7ffcaab2ba57b33cf279df45d830ce33b3..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-* Power Management Controller
-
-Properties:
-- compatible: "fsl,<chip>-pmc".
-
-  "fsl,mpc8349-pmc" should be listed for any chip whose PMC is
-  compatible.  "fsl,mpc8313-pmc" should also be listed for any chip
-  whose PMC is compatible, and implies deep-sleep capability.
-
-  "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
-  compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
-  whose PMC is compatible, and implies deep-sleep capability.
-
-  "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
-  compatible; all statements below that apply to "fsl,mpc8548-pmc" also
-  apply to "fsl,mpc8641d-pmc".
-
-  Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
-  bit assignments are indicated via the sleep specifier in each device's
-  sleep property.
-
-- reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
-  is the PMC block, and the second resource is the Clock Configuration
-  block.
-
-  For devices compatible with "fsl,mpc8548-pmc", the first resource
-  is a 32-byte block beginning with DEVDISR.
-
-- interrupts: For "fsl,mpc8349-pmc"-compatible devices, the first
-  resource is the PMC block interrupt.
-
-- fsl,mpc8313-wakeup-timer: For "fsl,mpc8313-pmc"-compatible devices,
-  this is a phandle to an "fsl,gtm" node on which timer 4 can be used as
-  a wakeup source from deep sleep.
-
-Sleep specifiers:
-
-  fsl,mpc8349-pmc: Sleep specifiers consist of one cell.  For each bit
-  that is set in the cell, the corresponding bit in SCCR will be saved
-  and cleared on suspend, and restored on resume.  This sleep controller
-  supports disabling and resuming devices at any time.
-
-  fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
-  which will be ORed into PMCDR upon suspend, and cleared from PMCDR
-  upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
-  This sleep controller only supports disabling devices during system
-  sleep, or permanently.
-
-  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
-  first of which will be ORed into DEVDISR (and the second into
-  DEVDISR2, if present -- this cell should be zero or absent if the
-  hardware does not have DEVDISR2) upon a request for permanent device
-  disabling.  This sleep controller does not support configuring devices
-  to disable during system sleep (unless supported by another compatible
-  match), or dynamically.
-
-Example:
-
-	power@b00 {
-		compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
-		reg = <0xb00 0x100 0xa00 0x100>;
-		interrupts = <80 8>;
-	};
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.yaml b/Documentation/devicetree/bindings/powerpc/fsl/pmc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..bb2db8adb74c54fec5d07393573f156c63a9e886
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/fsl/pmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power Management Controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+description: |
+  The Power Management Controller in several MPC8xxx SoCs helps save power by
+  controlling chip-wide low-power states as well as peripheral clock gating.
+
+  Sleep of peripheral devices is configured by the `sleep` property, for
+  example `sleep = <&pmc 0x00000030>`. Any cells after the &pmc phandle are
+  called a sleep specifier.
+
+  For "fsl,mpc8349-pmc", sleep specifiers consist of one cell.  For each bit that
+  is set in the cell, the corresponding bit in SCCR will be saved and cleared
+  on suspend, and restored on resume.  This sleep controller supports disabling
+  and resuming devices at any time.
+
+  For "fsl,mpc8536-pmc", sleep specifiers consist of three cells, the third of
+  which will be ORed into PMCDR upon suspend, and cleared from PMCDR upon
+  resume.  The first two cells are as described for fsl,mpc8548-pmc.  This
+  sleep controller only supports disabling devices during system sleep, or
+  permanently.
+
+  For "fsl,mpc8548-pmc" or "fsl,mpc8641d-pmc", Sleep specifiers consist of one
+  or two cells, the first of which will be ORed into DEVDISR (and the second
+  into DEVDISR2, if present -- this cell should be zero or absent if the
+  hardware does not have DEVDISR2) upon a request for permanent device
+  disabling.  This sleep controller does not support configuring devices to
+  disable during system sleep (unless supported by another compatible match),
+  or dynamically.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,mpc8315-pmc
+          - const: fsl,mpc8313-pmc
+          - const: fsl,mpc8349-pmc
+
+      - items:
+          - enum:
+              - fsl,mpc8313-pmc
+              - fsl,mpc8323-pmc
+              - fsl,mpc8360-pmc
+              - fsl,mpc8377-pmc
+              - fsl,mpc8378-pmc
+              - fsl,mpc8379-pmc
+          - const: fsl,mpc8349-pmc
+
+      - items:
+          - const: fsl,p1022-pmc
+          - const: fsl,mpc8536-pmc
+          - const: fsl,mpc8548-pmc
+
+      - items:
+          - enum:
+              - fsl,mpc8536-pmc
+              - fsl,mpc8568-pmc
+              - fsl,mpc8569-pmc
+          - const: fsl,mpc8548-pmc
+
+      - const: fsl,mpc8548-pmc
+
+      - const: fsl,mpc8641d-pmc
+
+    description: |
+      "fsl,mpc8349-pmc" should be listed for any chip whose PMC is
+      compatible.  "fsl,mpc8313-pmc" should also be listed for any chip
+      whose PMC is compatible, and implies deep-sleep capability.
+
+      "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
+      compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
+      whose PMC is compatible, and implies deep-sleep capability.
+
+      "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
+      compatible; all statements below that apply to "fsl,mpc8548-pmc" also
+      apply to "fsl,mpc8641d-pmc".
+
+      Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
+      bit assignments are indicated via the sleep specifier in each device's
+      sleep property.
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  fsl,mpc8313-wakeup-timer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      For "fsl,mpc8313-pmc"-compatible devices, this is a phandle to an
+      "fsl,gtm" node on which timer 4 can be used as a wakeup source from deep
+      sleep.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,mpc8349-pmc
+    then:
+      properties:
+        reg:
+          items:
+            - description: PMC block
+            - description: Clock Configuration block
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,mpc8548-pmc
+              - fsl,mpc8641d-pmc
+    then:
+      properties:
+        reg:
+          items:
+            - description: 32-byte block beginning with DEVDISR
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmc: power@b00 {
+        compatible = "fsl,mpc8377-pmc", "fsl,mpc8349-pmc";
+        reg = <0xb00 0x100>, <0xa00 0x100>;
+        interrupts = <80 IRQ_TYPE_LEVEL_LOW>;
+    };
+
+    sata@19000 {
+        compatible = "fsl,mpc8377-sata", "fsl,pq-sata";
+        reg = <0x19000 0x1000>;
+        interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
+        sleep = <&pmc 0x00000030>;
+    };
+
+  - |
+    power@e0070 {
+        compatible = "fsl,mpc8548-pmc";
+        reg = <0xe0070 0x20>;
+    };
+
+...

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250226-fslpmc-yaml-90dc69fb7d2a

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



