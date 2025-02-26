Return-Path: <linux-kernel+bounces-533819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B7A45ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C216166782
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1299221544;
	Wed, 26 Feb 2025 12:23:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD721D3FE;
	Wed, 26 Feb 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572618; cv=none; b=WF8ZEOE0uoWu5b0zc52K7fCN+2/H0h4Jg4P/jzwE7NSREezmBe0iNUK+SONhNyZjsucFS5O+E5hgbmC5DKs339Lg7Q9n9umjIu9XiyO58jHbk8XtMPYWoKqNV+4RbqZ/1sxYOItLJtsgPqvAqEUIMghJJ/CiYQzgDbDWBGvz7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572618; c=relaxed/simple;
	bh=pdDXj/z4DfuMj1nHM1yJWhewl7CcyKy3J+3Ew9sRGH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL1mYFpmoowBpWePYsZy+NEE6EiboCJj29vo8mRx8Vdp2fRDV7oZau+oeJ7YEK9CYIU5PIu3f7OiLb3mO+kXSxYV5uwYHPcEwLEb7CDRadLZxdQtNp7nDJfBtwzgynYKB3dnXZf60GLQBYQVlobHzzTzJY1j7TJs56IZMo6IHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9CE016F3;
	Wed, 26 Feb 2025 04:23:51 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B11B3F5A1;
	Wed, 26 Feb 2025 04:23:34 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-sound@vger.kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] ASoC: dt-bindings: xlnx,spdif: Convert to json-schema
Date: Wed, 26 Feb 2025 12:23:24 +0000
Message-ID: <20250226122325.2014547-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
References: <20250226122325.2014547-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Xilinx SPDIF 2.0 device tree binding documentation to
json-schema.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 -------
 .../devicetree/bindings/sound/xlnx,spdif.yaml | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
deleted file mode 100644
index 15c2d64d247c..000000000000
--- a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-Tree bindings for Xilinx SPDIF IP
-
-The IP supports playback and capture of SPDIF audio
-
-Required properties:
- - compatible: "xlnx,spdif-2.0"
- - clock-names: List of input clocks.
-   Required elements: "s_axi_aclk", "aud_clk_i"
- - clocks: Input clock specifier. Refer to common clock bindings.
- - reg: Base address and address length of the IP core instance.
- - interrupts-parent: Phandle for interrupt controller.
- - interrupts: List of Interrupt numbers.
- - xlnx,spdif-mode: 0 :- receiver mode
-		    1 :- transmitter mode
- - xlnx,aud_clk_i: input audio clock value.
-
-Example:
-	spdif_0: spdif@80010000 {
-		clock-names = "aud_clk_i", "s_axi_aclk";
-		clocks = <&misc_clk_0>, <&clk 71>;
-		compatible = "xlnx,spdif-2.0";
-		interrupt-names = "spdif_interrupt";
-		interrupt-parent = <&gic>;
-		interrupts = <0 91 4>;
-		reg = <0x0 0x80010000 0x0 0x10000>;
-		xlnx,spdif-mode = <1>;
-		xlnx,aud_clk_i = <49152913>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
new file mode 100644
index 000000000000..a45d8a0755fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SPDIF IP
+
+description:
+  The IP supports playback and capture of SPDIF audio.
+
+maintainers:
+  - Vincenzo Frascino <vincenzo.frascino@arm.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,spdif-2.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: SPDIF audio interrupt
+
+  clock-names:
+    items:
+      - const: aud_clk_i
+      - const: s_axi_aclk
+
+  clocks:
+    minItems: 1
+    items:
+      - description: input audio clock
+      - description: clock for the AXI data stream
+
+  xlnx,spdif-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0
+      - 1
+    description: |
+      0 - receiver
+      1 - transmitter
+
+  xlnx,aud_clk_i:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Input audio clock frequency. It affects the sampling rate.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    spdif@80010000 {
+      compatible = "xlnx,spdif-2.0";
+      reg = <0x80010000 0x10000>;
+      clock-names = "aud_clk_i", "s_axi_aclk";
+      clocks = <&misc_clk_0>, <&clk 71>;
+      interrupt-parent = <&gic>;
+      interrupts = <0 91 4>;
+      xlnx,spdif-mode = <1>;
+      xlnx,aud_clk_i = <49152913>;
+    };
+
+...
-- 
2.43.0


