Return-Path: <linux-kernel+bounces-526380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E99A3FDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8EC3AFC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10D2512F7;
	Fri, 21 Feb 2025 17:50:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7662512E1;
	Fri, 21 Feb 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160244; cv=none; b=M5aFOzn4ZUmXxg4Fu5dgRHsiBRwUeKEvTBoCyLEVg41uHi34EgcXK6bkxfJ/1KYBjuofZAP9gOJmhZhTXPZyyanIP4KJj6MpKNGiBlU1+tGfvs4KZgOEWc08uwUy8EG4uxCiIlSbqzGE+oFr8wipZMTslu9P60Hjt43ctqndT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160244; c=relaxed/simple;
	bh=DFPtDaciuIuxF/rfQ1M3a/sVSOdMxrWKoSzuViqgtpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK4rVcekvtCzp0OegsRum2SsNBFsw2FlEPkbclHU2duMeXGTqP7nOx1HerDBNl/e4o15qkpYV7MvLiZx6+uG9uRt4tMGWdK9gK/wtDxnL0FNRvMRpwgWFAKnQkryqaDbKzm+ynljMiI4SHdXRh8L9au3kzD8fmDQmYiebtPv2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 554161516;
	Fri, 21 Feb 2025 09:50:58 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081FB3F59E;
	Fri, 21 Feb 2025 09:50:38 -0800 (PST)
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
Subject: [PATCH v2 2/4] ASoC: dt-bindings: xlnx,audio-formatter: Convert to json-schema
Date: Fri, 21 Feb 2025 17:50:28 +0000
Message-ID: <20250221175030.1395815-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221175030.1395815-1-vincenzo.frascino@arm.com>
References: <20250221175030.1395815-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Xilinx Audio Formatter 1.0  device tree binding documentation
to json-schema.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
 .../bindings/sound/xlnx,audio-formatter.yaml  | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
deleted file mode 100644
index cbc93c8f4963..000000000000
--- a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Device-Tree bindings for Xilinx PL audio formatter
-
-The IP core supports DMA, data formatting(AES<->PCM conversion)
-of audio samples.
-
-Required properties:
- - compatible: "xlnx,audio-formatter-1.0"
- - interrupt-names: Names specified to list of interrupts in same
-		    order mentioned under "interrupts".
-		    List of supported interrupt names are:
-		    "irq_mm2s" : interrupt from MM2S block
-		    "irq_s2mm" : interrupt from S2MM block
- - interrupts-parent: Phandle for interrupt controller.
- - interrupts: List of Interrupt numbers.
- - reg: Base address and size of the IP core instance.
- - clock-names: List of input clocks.
-   Required elements: "s_axi_lite_aclk", "aud_mclk"
- - clocks: Input clock specifier. Refer to common clock bindings.
-
-Example:
-	audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
-		compatible = "xlnx,audio-formatter-1.0";
-		interrupt-names = "irq_mm2s", "irq_s2mm";
-		interrupt-parent = <&gic>;
-		interrupts = <0 104 4>, <0 105 4>;
-		reg = <0x0 0x80010000 0x0 0x1000>;
-		clock-names = "s_axi_lite_aclk", "aud_mclk";
-		clocks = <&clk 71>, <&clk_wiz_1 0>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
new file mode 100644
index 000000000000..52a685519bc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx PL audio formatter
+
+description: |
+  The IP core supports DMA, data formatting(AES<->PCM conversion)
+  of audio samples.
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
+      - xlnx,audio-formatter-1.0
+
+  reg:
+    minItems: 1
+    maxItems: 4
+    description: |
+      Base address and size of the IP core instance.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+    description: |
+      Names specified to list of interrupts in same order mentioned under
+      "interrupts".
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    description: |
+      List of Interrupt numbers.
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+    description: |
+      List of input clocks.
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+    description: |
+      Input clock specifier. Refer to common clock bindings.
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: true
+
+examples:
+  - |
+    audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
+      compatible = "xlnx,audio-formatter-1.0";
+      interrupt-names = "irq_mm2s", "irq_s2mm";
+      interrupt-parent = <&gic>;
+      interrupts = <0 104 4>, <0 105 4>;
+      reg = <0x0 0x80010000 0x0 0x1000>;
+      clock-names = "s_axi_lite_aclk", "aud_mclk";
+      clocks = <&clk 71>, <&clk_wiz_1 0>;
+    };
+...
-- 
2.43.0


