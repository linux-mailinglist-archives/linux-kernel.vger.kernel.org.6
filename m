Return-Path: <linux-kernel+bounces-244298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621392A25B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04951F22C22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554C13F45F;
	Mon,  8 Jul 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FaVrGCUP"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09006811E6;
	Mon,  8 Jul 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440615; cv=none; b=m3shYEbze+MjGWP3BSWqEeOhOxA8wQ5W1q0Wjd4pxjPMqv4fTHEErNWfjnKgphQQUiYN4FZAEg6zBI54tUaYvUztteB4qw544SmHxu6/Xjc8rERCpQWErRMoe6EAQXoPx76lusOndVrXcSmMbdeI/tL/SVpkiKwuOmmC0306AtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440615; c=relaxed/simple;
	bh=W88ii+VfQhuEdGWbttUWogaLqMfwR4mJCLxGUb+XKZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4di8JxkhZGaeBI3NJtgI9xK+loWy9Dr63yqFu4K12iiBQkAnrwOVAtBIgq2PeVXVHDKsuQcLLsVs/oDSFz4A3wKRk4sHGsyR/Z+O/SzEoXysMW0e8x7EgoQr3pvUjF5XH+jhyo3wS/SJk4NTni4K8g6ZwbARf5fUkn39aAef50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FaVrGCUP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B9501412FF;
	Mon,  8 Jul 2024 14:10:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VukL3U4tSXAs; Mon,  8 Jul 2024 14:10:11 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720440578; bh=W88ii+VfQhuEdGWbttUWogaLqMfwR4mJCLxGUb+XKZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaVrGCUPGQKHQMZ+rI+7D5essaiCHjtjUJKnR19ECuJdP8cSUDVcf6jLBXQLkPVPC
	 /g19/dYim2gSTHwW5cWXCaNJy6Yl2uSxAB26cfwEY95YiZSaglbgaK2FvtCwfnamro
	 APHVPDhua17q7A51wzGg0CPn6j3lPCHHDybuONtvRiInCeRKNfwmOjnKNHF6F6TU0v
	 zWLMaaeL9KW4BTWVgPYES4kmRY0MsAn6OyYNfo0Cx+aD5j7/XsacPhJZ1L0Fs9Mfj+
	 U46Evwial+surXNRiHSVSMJS00zTx7eTlhrnmz9ZAeo1eLIpM6BrbUpYFbUrrxRraj
	 +D8yhRBrXxa9Q==
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/3] dt-bindings: phy: add YAML schema for cv1800-usb-phy driver bindings
Date: Mon,  8 Jul 2024 12:08:28 +0000
Message-ID: <20240708120830.5785-2-ziyao@disroot.org>
In-Reply-To: <20240708120830.5785-1-ziyao@disroot.org>
References: <20240708120830.5785-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cv1800-usb-phy driver supports USB 2.0 phys integrated in Sophgo
Cv1800/SG200x SoCs. Add YAML schema for its binding.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
new file mode 100644
index 000000000000..0403d899e23b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/sophgo,cv1800-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 USB PHY
+
+maintainers:
+  - Yao Zi <ziyao@disroot.org>
+
+properties:
+  compatible:
+    enum:
+      - sophgo,cv1800-usb-phy
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: phy
+      - const: pin
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: apb
+      - const: 125m
+      - const: 33k
+      - const: 12m
+
+  "#phy-cells":
+    const: 0
+
+  dr_role:
+    enum:
+      - host
+      - device
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    usb_phy: usb-phy@3006000 {
+        compatible = "sophgo,cv1800-usb-phy";
+        reg = <0x300600 0x60>, <0x3000048 0x4>;
+        reg-names = "phy", "pin";
+        clocks = <&clk CLK_APB_USB>,
+                 <&clk CLK_USB_125M>,
+                 <&clk CLK_USB_33K>,
+                 <&clk CLK_USB_12M>;
+        clock-names = "apb", "125m", "33k", "12m";
+        #phy-cells = <0>;
+    };
-- 
2.45.2


