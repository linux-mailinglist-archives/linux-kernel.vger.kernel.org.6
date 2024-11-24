Return-Path: <linux-kernel+bounces-420303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FDD9D7894
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47842B23759
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C1185955;
	Sun, 24 Nov 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W82RVZGx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959555103F;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487381; cv=none; b=e/KEglreenLo/i0YEtR/Eo0ya0Gfmrsd9hACJ2HK9zFBbwHM/7NoO2d7FFGKzuZ4DXlrVwgts813EbPI5F0BZY7FhiDNJs8eF6LY9lofQuvAov6is4qRYYZKbGPF4/2DB4P71/DLZJgnV6to9tCTnyFMFJQbgQVdDxTBwhqh5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487381; c=relaxed/simple;
	bh=oBmgB4n3U2evvqYhhVMBbKaiZhJ4zZa97cdV6i9zRZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLemnXqW8fosHT+KqgG0x9DyIQFTej7/jimlmdMX3PvqXcFqPvI5ZZDDRjqnyYHLm8JmDijo/RLERL+AA6VNB9MPPdgn4uCyXrMac4R15FIQJz4nTwVTRRcVSvqwIWGMvGOwzFdW5i5jBFGyg5351+qrma74ETr7rEy/bPS8Mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W82RVZGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2517AC4CECC;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732487381;
	bh=oBmgB4n3U2evvqYhhVMBbKaiZhJ4zZa97cdV6i9zRZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W82RVZGxUOQ2s5evCxvlfUgWaPD6qSBLpUPavraAh4v3Wc+XirzXceBjfYGWqhbg3
	 6mEq35MdUKyd7qwAqYIyJtEomcEZgMlTSz7B3YteKCGA1sdfj+8QbjgTBotx2FACn8
	 V5WyAswZQ9IjMS3858mZLc1OfKX9lW9rXWHWI4Ec5sWXV5/l/JterB+pgWtL3v8Bx9
	 Wjx0cfRDw79yqT49hmKAr/Eycqtp89ViNHdQ1eq7Vd8+IGTKpL8vOs1c8VwKfujqmc
	 +PmmoO2APravNjmNIWPQVZFn5JnCZfmK94XRJRBH3jO/sOsgSWsgMuRoJL9v41nD5s
	 o2LHOifdvKRkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17881E69187;
	Sun, 24 Nov 2024 22:29:41 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Sun, 24 Nov 2024 23:29:24 +0100
Subject: [PATCH 1/5] dt-bindgins: display: Add Apple pre-DCP display
 controller bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
In-Reply-To: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732487379; l=2711;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=NTNIkjPdOTlJZEDvMknaGPG5ha7ey/9KeGDX3Cvd+fo=;
 b=aEiRFrdmA0I2NmORiFQ0n25DBwKAtSgEjQA1vtAY9JgY15BTKorcuza/Kpb5hFtDSET8waSkN
 UXv3sdP+1LFD5i79mgtG+qRN2dKShhJRlzP0wvWtLVqDSSNrku1HWx5
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add bindings for a secondary display controller present on certain
Apple laptops.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../bindings/display/apple,display-pipe.yaml       | 59 ++++++++++++++++++++++
 .../bindings/display/panel/apple,summit.yaml       | 24 +++++++++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/apple,display-pipe.yaml b/Documentation/devicetree/bindings/display/apple,display-pipe.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..bd25ddc6e09dd636c0221c854e594113f6011866
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/apple,display-pipe.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/apple,display-pipe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple pre-DCP display controller.
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: |
+  A secondary display controller used to drive the "touchbar" on certain
+  Apple laptops.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - "apple,t8112-display-pipe"
+        - "apple,t8103-display-pipe"
+      - const: "apple,h7-display-pipe"
+
+  reg:
+    minItems: 3
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: be
+      - const: fe
+      - const: mipi
+
+  power-domains: true
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: be
+      - const: fe
+
+  iommus: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
diff --git a/Documentation/devicetree/bindings/display/panel/apple,summit.yaml b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..dc281c1f52c1ed07cc2f7f804dcfd2f3b4239d89
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/apple,summit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple "Summit" display panel.
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+properties:
+  compatible:
+    const: apple,summit
+
+  reg:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg

-- 
2.47.0



