Return-Path: <linux-kernel+bounces-403656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8A9C38B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04B8280EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769A1547F5;
	Mon, 11 Nov 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eIi3jyQV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA553C3C;
	Mon, 11 Nov 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308143; cv=none; b=q06lJBwTIwDLl1FZ9w7Vl9gZCFIAhofKZq8zmkA4Z3zOlOJArJWWpD3b26JsdSitYetRVSefECJrMz/NoAm6Dc36t2il1X333IjtKQlefvxBSWynUPrU9MVSsWd4+4FhOZ+5bEns/2/KvvWAdSsnGjkWobZxuvOVC0ZZVq2WN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308143; c=relaxed/simple;
	bh=ZJZ/DGAiZ8EFB89FUOY0RrQq5fJ8wgWrZftdSh9uqkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq83OvJxRLmeZr07S+ZfD6qUcP4VEviuKyRGzwrEJwA1MRFTa143DD8Tl8U4Kv723+adan/4divyenKhhOAaq2UmPFeOAL9LVJpIakSf401Gdci5ehlHfkg6kcNtyWWgW2fF1e8+YhDxN5YeFlkWffqJsj9X5q1/mC/nv56OE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eIi3jyQV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731308142; x=1762844142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJZ/DGAiZ8EFB89FUOY0RrQq5fJ8wgWrZftdSh9uqkc=;
  b=eIi3jyQVPuADCPV8E9i3gwkUZCKNyesCwHft/TMyDlkebIKVHwp6L3eS
   KwXG2ZKBau1Nm2cRQF6tv8VWjIGJxvFB8WXntRbAzFXKeAMdEYpYXc+js
   8of7rGeuGBm808RqF4OXSvc5TQGR28GOXw5wW0fjmO2DH5ToSUUNCNdcR
   MXyMLNMFgKr16Z0s1+9DXU0JklD7bpmHsD92Jr59xhs44tuf6v6gMSYYY
   vdp6D2kehxHi1ER4vgvQZl6D64ycBkfIL8SHSn0OXuzPcgB3At8BRDvek
   8pkzrEblo/8QC/AKMvGHy3ASfP1VTFE9z9d1JAsxLddHn+e83JSwtV9c+
   g==;
X-CSE-ConnectionGUID: DAK6k29NRRWKSUSjI8wF4Q==
X-CSE-MsgGUID: JTJ3m9kNTVODDOpux5hWbQ==
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="265270109"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 23:55:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Nov 2024 23:55:25 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 10 Nov 2024 23:55:16 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<hari.prasathge@microchip.com>, <varshini.rajendran@microchip.com>,
	<arnd@arndb.de>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/4] dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
Date: Mon, 11 Nov 2024 12:24:59 +0530
Message-ID: <20241111065502.411710-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111065502.411710-1-manikandan.m@microchip.com>
References: <20241111065502.411710-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the 'sam9x75-mipi-dsi' compatible binding, which describes the
Microchip's specific wrapper for the Synopsys DesignWare MIPI DSI HOST
Controller for the sam9x75 series System-on-Chip (SoC) devices.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
changes in v5:
- Add reviewed-by tag

changes in v4:
- Removed 'microchip,sfr' phandle property since
regmap to SFR node can be obtained using its compatible
string

changes in v3:
- Describe the clocks used

changes in v2:
- List the clocks with description
- remove describing 'remove-endpoint' properties
- remove unused label, node and fix example DT indentation
- cosmetic fixes
---
 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
new file mode 100644
index 000000000000..d2ae6250e1f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/microchip,sam9x75-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAM9X75 MIPI DSI Controller
+
+maintainers:
+  - Manikandan Muralidharan <manikandan.m@microchip.com>
+
+description:
+  Microchip specific extensions or wrapper to the Synopsys Designware MIPI DSI.
+  The MIPI Display Serial Interface (DSI) Host Controller implements all
+  protocol functions defined in the MIPI DSI Specification.The DSI Host
+  provides an interface between the LCD Controller (LCDC) and the MIPI D-PHY,
+  allowing communication with a DSI-compliant display.
+
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,sam9x75-mipi-dsi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description:
+          Peripheral Bus Clock between LCDC and MIPI DPHY
+      - description:
+          MIPI DPHY Interface reference clock for PLL block
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: refclk
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          DSI Input port node, connected to the LCDC RGB output port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          DSI Output port node, connected to a panel or a bridge input port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+     #include <dt-bindings/clock/at91.h>
+     #include <dt-bindings/gpio/gpio.h>
+
+     dsi@f8054000 {
+       compatible = "microchip,sam9x75-mipi-dsi";
+       reg = <0xf8054000 0x200>;
+       clocks = <&pmc PMC_TYPE_PERIPHERAL 54>, <&pmc PMC_TYPE_GCK 55>;
+       clock-names = "pclk", "refclk";
+
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       ports {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         port@0 {
+           reg = <0>;
+           dsi_in: endpoint {
+             remote-endpoint = <&hlcdc_panel_output>;
+           };
+         };
+
+         port@1 {
+           reg = <1>;
+           dsi_out: endpoint {
+             remote-endpoint = <&mipi_in_panel>;
+           };
+         };
+       };
+     };
+...
-- 
2.25.1


