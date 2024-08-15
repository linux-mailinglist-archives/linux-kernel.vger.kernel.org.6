Return-Path: <linux-kernel+bounces-288048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E60953232
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5691C2675D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845051AC44F;
	Thu, 15 Aug 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meT1IHQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7881AC454;
	Thu, 15 Aug 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730518; cv=none; b=DCtMtJ84RSRrP+owCnZxa/TdwlL01vkdSvn5+9dcURe4hcmHi57Mr8NYYkWRNNc/uvIyMZDNe1VHOYUVEZla0Q/UNHSzFpY1SOkBFQdiJpPKsT30bHFp6r0BXAVWrY+6/nbBmpzoXMLBLiwnC+UVrZgmYRhpK/Bpj1qFsjuhVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730518; c=relaxed/simple;
	bh=Ysz7QSlGk1Ks4f+xiFaqlb0KehG2/+7xlwhdMM3/2R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnjElQuDGb9XoVpyYyYW7gNZW/mEI6biWoyTZEPIFGMexxRHhuyg4uEb4a+uSM8A0/P5b9yCJPiZpkUHHDlxhxT8L5aifCD1YnOj8O68k7/QBYTLwoI/Yg7KsXJHc6KvXv7DmxQDc2u+pWgIsYBKB4Mfr49FXaF0ihtbLfKh6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meT1IHQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1914C32786;
	Thu, 15 Aug 2024 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730518;
	bh=Ysz7QSlGk1Ks4f+xiFaqlb0KehG2/+7xlwhdMM3/2R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meT1IHQcLknNu64QvU/CzZiCr+xKuzvCOc27jtRwePy7meMOeWV51fUV4D68J1oF8
	 0BRZkbLrxSKW14G2eShRMs+2y1xtso71QVRrxRvIlJvkQ+OOvwpEE+AtG5YsrCyl/O
	 clCTFeY9wgFoj6QMbZb53Pfjh5eF0zTBLhGA3fZmKbtF53c1HWInkZWi8ga5/XmVhF
	 PuaERH+PgEUnO2zAnsln67T2LvI500NAXAJ7jl+/bjahxskWlxoENeoGmfH7rho/aI
	 ehJs6es8yuYjuBIaK2biqZ1UmC8jlZjwhbmVxahY6v4wX4VF7Oqeg23PGGqCWFL4sE
	 N5duARtrMagzQ==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/11] dt-bindings: soc: microchip: document the two simple-mfd syscons on PolarFire SoC
Date: Thu, 15 Aug 2024 15:01:09 +0100
Message-ID: <20240815-pending-sacrifice-f2569ed756fe@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5505; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=oXASywIAqOYqfZopaEeUt3A6SVedBQhIyWFoYy/OS28=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHSzA9at6M28w1gx6WzhHOO58tEytmemW5xa9Vnv0 8JzT9b0dpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiG0QY/ud9kjLfoqQmU2a5 7vN2n760C4Uti9ITTv7dJ50wpSny+F6Gf4rm3OcbMyMiJnTH19UteJ73yfpIp/ncKzwnH6t8tN1 wggsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There are two syscons on PolarFire SoC that provide various functionality of
use to the OS.

The first of these is the "control-scb" region, that contains the "tvs"
temperature and voltage sensors and the control/status registers for the
system controller's mailbox. The mailbox has a dedicated node, so
there's no need for a child node describing it, looking the syscon up by
compatible is sufficient.

The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
interrupt controller and more. For this RFC, only the reset controller
child is described as that's all that is described by the existing
bindings. The clock controller already has a dedicated node, and will
retain it as there are other clock regions, so like the mailbox,
a compatible-based lookup of the syscon is sufficient to keep the clock
driver working as before so no child is needed.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
(I'll split this in two later, it's just easier when I have the same
questions about both...)

Are these things entitled to have child nodes for the reset and sensor
nodes, or should the properties be in the parent and the OS probe the
drivers for the functions? That's something that, despite supposedly
being a maintainer, I do not understand the rules (of thumb?) for.

Secondly, is it okay to make the "pragmatic" decision to not have a
child clock node and keep routing the clocks via the existing & retained
clock node (and therefore not update the various clocks nodes in the
consumers)? Doing so would require a lot more hocus pocus with the clock
driver than this series does, as the same driver would no longer be
suitable for the before/after bindings.
---
 .../microchip/microchip,mpfs-control-scb.yaml | 54 +++++++++++++++++++
 .../microchip,mpfs-mss-top-sysreg.yaml        | 53 ++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
new file mode 100644
index 000000000000..3673bf139ce8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-control-scb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC System Controller Bus (SCB) Control Register region
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description:
+  An assortment of system controller related registers, including voltage and
+  temperature sensors and the status/control registers for the system
+  controller's mailbox.
+
+properties:
+  compatible:
+    items:
+      - const: microchip,mpfs-control-scb
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  sensor:
+    type: object
+
+    properties:
+      compatible:
+        const: microchip,mpfs-tvs
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      syscon@37020000 {
+        compatible = "microchip,mpfs-control-scb", "syscon", "simple-mfd";
+        reg = <0x37020000 0x100>;
+
+        sensor {
+          compatible = "microchip,mpfs-tvs";
+        };
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
new file mode 100644
index 000000000000..d70c9c3348ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg Register region
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description:
+  An wide assortment of registers that control elements of the MSS on PolarFire
+  SoC, including pinmuxing, resets and clocks among others.
+
+properties:
+  compatible:
+    items:
+      - const: microchip,mpfs-mss-top-sysreg
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  reset-controller:
+    type: object
+
+    properties:
+      compatible:
+        const: microchip,mpfs-reset
+
+      '#reset-cells':
+        description:
+          The AHB/AXI peripherals on the PolarFire SoC have reset support, so
+          from CLK_ENVM to CLK_CFM. The reset consumer should specify the
+          desired peripheral via the clock ID in its "resets" phandle cell.
+          See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list
+          of PolarFire clock/reset IDs.
+        const: 1
+
+    additionalProperties: false
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+    };
+
-- 
2.43.0


