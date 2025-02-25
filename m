Return-Path: <linux-kernel+bounces-531266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05439A43E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF87A89B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D82267B1A;
	Tue, 25 Feb 2025 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQkrJ5e7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4272627FC;
	Tue, 25 Feb 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484263; cv=none; b=H8UaAcAurcNMvimlMXFd2LOLMLX7JR0ZzqbklnUF+dGJPYdJwDalcLOBTVRySGGg2cvuh2jN6JHI+RDqG2JHegR2clQAwuHoXj6VsiLYihEaqpvFpNAwZ87/OtZ58wqaZSkFCnyuEjolH1tpjpe9EvgljCB0C19puMJSDr+jNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484263; c=relaxed/simple;
	bh=ogiLCIWglDZSH/dycj8sau+uSLmEvEOeD9x4UqCzevs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HW0dL5ydfSj3RkQgEhLg49yEwH59yTdLmVEV2QCbV4cIBpUdcNYvjBLo5fAH1qYnCg0OgSaTO08Ml5yJ+vQjtzpOcUaZErr6KJPCC5I8YsiKqEazJuUjuKyBhz6dVabRDpimrD+dRl4UXU+Mj5QNmCGP17/ewIVwpU+oC6jjFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQkrJ5e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFA63C4CEDD;
	Tue, 25 Feb 2025 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484262;
	bh=ogiLCIWglDZSH/dycj8sau+uSLmEvEOeD9x4UqCzevs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tQkrJ5e7iblrc9o6AGGDf6pDP3o8ZMCtZvnqlLdWlYcpwWrtWhrL7fqJwBYTntote
	 vSezvl9stBXvAJ/e+ugPpXhK8FUcBUzzBe0j8sNBh0w361m/PYzKzBMpqKin9HO2nc
	 bMp0sI2Um2H5K4xWIO6SmZaMZ4AQXAy8iwsLjnE46US4xqnvSv4p3p8Faq9TDimxpM
	 r/wPgoWQ2fjwTvufaa4eEkYkMLZePR7LvDApAhdYV0ltDRhcamSA4zAJO+UnXSQdN1
	 NYd4qzkD5BpCe8czhpejXA9vLRYq3tNYQjddgttxCYhZKX63KSVrSQoK7J8uTJiyRy
	 oAg4S/vSxwjsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7FBC021BB;
	Tue, 25 Feb 2025 11:51:02 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 25 Feb 2025 12:50:43 +0100
Subject: [PATCH] dt-bindings: timer: Convert fsl,gtm to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-gtm-yaml-v1-1-de5da7299430@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJOuvWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0MD3fSSXN3KxNwc3SQTw0RLE3PTFIMkYyWg8oKi1LTMCrBR0bG1tQC
 3qRAMWgAAAA==
X-Change-ID: 20250210-gtm-yaml-b41a9475d0b3
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740484262; l=4248;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=IJ2Pa/73xPD+G6Z1wxNgj8rNjWlTYDU/+mVzEQ1et/Q=;
 b=yeu7WB5KhuLu0yJuJmFG0VtBoDF5CMhRLBSJuFsg0b4GNU5rG2b0VN4XgOSIR/ccG4ZpMflSF
 /erfPHQ/nGAC4ijVrHlaEthKqFxgmPA/NPBMpA0x6jWAXvZTuZe7pOV
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert fsl,gtm.txt to YAML so that device trees using a Freescale
General-purpose Timers Module can be properly validated.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 .../devicetree/bindings/timer/fsl,gtm.txt          | 30 --------
 .../devicetree/bindings/timer/fsl,gtm.yaml         | 83 ++++++++++++++++++++++
 2 files changed, 83 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,gtm.txt b/Documentation/devicetree/bindings/timer/fsl,gtm.txt
deleted file mode 100644
index fc1c571f74123d2293bf5c3af3197000d46a07ee..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/timer/fsl,gtm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Freescale General-purpose Timers Module
-
-Required properties:
-  - compatible : should be
-    "fsl,<chip>-gtm", "fsl,gtm" for SOC GTMs
-    "fsl,<chip>-qe-gtm", "fsl,qe-gtm", "fsl,gtm" for QE GTMs
-    "fsl,<chip>-cpm2-gtm", "fsl,cpm2-gtm", "fsl,gtm" for CPM2 GTMs
-  - reg : should contain gtm registers location and length (0x40).
-  - interrupts : should contain four interrupts.
-  - clock-frequency : specifies the frequency driving the timer.
-
-Example:
-
-timer@500 {
-	compatible = "fsl,mpc8360-gtm", "fsl,gtm";
-	reg = <0x500 0x40>;
-	interrupts = <90 8 78 8 84 8 72 8>;
-	interrupt-parent = <&ipic>;
-	/* filled by u-boot */
-	clock-frequency = <0>;
-};
-
-timer@440 {
-	compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
-	reg = <0x440 0x40>;
-	interrupts = <12 13 14 15>;
-	interrupt-parent = <&qeic>;
-	/* filled by u-boot */
-	clock-frequency = <0>;
-};
diff --git a/Documentation/devicetree/bindings/timer/fsl,gtm.yaml b/Documentation/devicetree/bindings/timer/fsl,gtm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1f35f1ee0be2a947ad241f4ba0be391e7e0d0882
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,gtm.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,gtm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale General-purpose Timers Module
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    oneOf:
+      # for SoC GTMs
+      - items:
+          - enum:
+              - fsl,mpc8308-gtm
+              - fsl,mpc8313-gtm
+              - fsl,mpc8315-gtm
+              - fsl,mpc8360-gtm
+          - const: fsl,gtm
+
+      # for QE GTMs
+      - items:
+          - enum:
+              - fsl,mpc8360-qe-gtm
+              - fsl,mpc8569-qe-gtm
+          - const: fsl,qe-gtm
+          - const: fsl,gtm
+
+      # for CPM2 GTMs (no known examples)
+      - items:
+          # - enum:
+          #     - fsl,<chip>-cpm2-gtm
+          - const: fsl,cpm2-gtm
+          - const: fsl,gtm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Interrupt for timer 1 (e.g. GTM1 or GTM5)
+      - description: Interrupt for timer 2 (e.g. GTM2 or GTM6)
+      - description: Interrupt for timer 3 (e.g. GTM3 or GTM7)
+      - description: Interrupt for timer 4 (e.g. GTM4 or GTM8)
+
+  clock-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@500 {
+        compatible = "fsl,mpc8360-gtm", "fsl,gtm";
+        reg = <0x500 0x40>;
+        interrupts = <90 IRQ_TYPE_LEVEL_LOW>,
+                     <78 IRQ_TYPE_LEVEL_LOW>,
+                     <84 IRQ_TYPE_LEVEL_LOW>,
+                     <72 IRQ_TYPE_LEVEL_LOW>;
+        /* filled by u-boot */
+        clock-frequency = <0>;
+    };
+
+  - |
+    timer@440 {
+        compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
+        reg = <0x440 0x40>;
+        interrupts = <12>, <13>, <14>, <15>;
+        /* filled by u-boot */
+        clock-frequency = <0>;
+    };
+
+...

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250210-gtm-yaml-b41a9475d0b3

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



