Return-Path: <linux-kernel+bounces-529815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D062DA42B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314EC19C283B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE51144304;
	Mon, 24 Feb 2025 18:25:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE95264FA6;
	Mon, 24 Feb 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421558; cv=none; b=KSBA0+m6d4FVBkHLB0uvkvnBKc6dlLqWHhJS0nKn7w6zz60nmCStjI0Zx0gpBfSt/uLK7enJYfC9548rf6K/4TFMjn+ZzArA11t1eV19lUecD277jZAbwoGau0a8tNd7UUfpqYIafRlgmcsv/yhWFQikR3ZHVX0LOZlhQPNz2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421558; c=relaxed/simple;
	bh=92pZp+VgTgL9tfW8gunPlzB15fxXWPczkPo81sKu2Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByLAZqNY54bldZis6Cq0MUA8bcDMC4LEtzFayWzzy0LI63hmuom237jYZdyYcH9a7RTstkJOSItSBO7i/tniLtrSzM0W0ZunlBwa0v2QcerLPIgilv7wM2nqIy32kHht3I4mLzmP0Os4BFGkhhnsFwiCuFeDjUhi75dbAyTVOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD583152B;
	Mon, 24 Feb 2025 10:26:12 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A432B3F5A1;
	Mon, 24 Feb 2025 10:25:54 -0800 (PST)
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
Subject: [PATCH v4 1/4] ASoC: dt-bindings: xlnx,i2s: Convert to json-schema
Date: Mon, 24 Feb 2025 18:25:45 +0000
Message-ID: <20250224182548.2715896-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224182548.2715896-1-vincenzo.frascino@arm.com>
References: <20250224182548.2715896-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Xilinx I2S device tree binding documentation to json-schema.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 --------
 .../devicetree/bindings/sound/xlnx,i2s.yaml   | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
deleted file mode 100644
index 5e7c7d5bb60a..000000000000
--- a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-Tree bindings for Xilinx I2S PL block
-
-The IP supports I2S based playback/capture audio
-
-Required property:
- - compatible: "xlnx,i2s-transmitter-1.0" for playback and
-	       "xlnx,i2s-receiver-1.0" for capture
-
-Required property common to both I2S playback and capture:
- - reg: Base address and size of the IP core instance.
- - xlnx,dwidth: sample data width. Can be any of 16, 24.
- - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
-		      supported channels = 2 * xlnx,num-channels
-
-Example:
-
-	i2s_receiver@a0080000 {
-		compatible = "xlnx,i2s-receiver-1.0";
-		reg = <0x0 0xa0080000 0x0 0x10000>;
-		xlnx,dwidth = <0x18>;
-		xlnx,num-channels = <1>;
-	};
-	i2s_transmitter@a0090000 {
-		compatible = "xlnx,i2s-transmitter-1.0";
-		reg = <0x0 0xa0090000 0x0 0x10000>;
-		xlnx,dwidth = <0x18>;
-		xlnx,num-channels = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
new file mode 100644
index 000000000000..3c2b0be07c53
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx I2S PL block
+
+description:
+  The IP supports I2S based playback/capture audio.
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
+      - xlnx,i2s-receiver-1.0
+      - xlnx,i2s-transmitter-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,dwidth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 16
+      - 24
+    description: |
+      Sample data width.
+
+  xlnx,num-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 4
+    description: |
+      Number of I2S streams.
+
+required:
+  - compatible
+  - reg
+  - xlnx,dwidth
+  - xlnx,num-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s@a0080000 {
+      compatible = "xlnx,i2s-receiver-1.0";
+      reg = <0xa0080000 0x10000>;
+      xlnx,dwidth = <0x18>;
+      xlnx,num-channels = <1>;
+    };
+    i2s@a0090000 {
+      compatible = "xlnx,i2s-transmitter-1.0";
+      reg = <0xa0090000 0x10000>;
+      xlnx,dwidth = <0x18>;
+      xlnx,num-channels = <1>;
+    };
+
+...
-- 
2.43.0


