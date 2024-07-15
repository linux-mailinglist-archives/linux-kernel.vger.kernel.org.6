Return-Path: <linux-kernel+bounces-252340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951869311D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89FE1C2242B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF6B187343;
	Mon, 15 Jul 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UNDhs4ee"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBED1862AB;
	Mon, 15 Jul 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037510; cv=none; b=vGEJq1+xxWhfTb4WUUoBHxmD4RY6Vs5w0d6BT18+oS57mndMPiF6TzDFnc7QiHyf0vMm9xtCK9VPAgi6+KSp8CJQokyBhD42L2j44i9YyO8qZdaA8UymM19Y4lLL+myrlPNDft+KgYzxzXt/usKjMBFdXRy7AxZ8kFBiDzx/Miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037510; c=relaxed/simple;
	bh=rYf9sUvhDqpSsdpQkGFIz8xXu7hFGMrK2RcSKdTIOzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBQwGQ632gIYKS3h6ylsQQEusHRHLic/1MUycJyGpHaKmQj1pOGdw/J5tD7NMtQhhTevbxjGFLC4hGlKV2K4BAE2E7THoDogXGhzVj/pPXHB0VLNviLtSHupJ+1c9d6nKYBVX4nuSBIB+p0NF2oNUBunl5jY9kJaVXbXX4uUdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UNDhs4ee; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721037509; x=1752573509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYf9sUvhDqpSsdpQkGFIz8xXu7hFGMrK2RcSKdTIOzk=;
  b=UNDhs4eevMSL7UkaWkKMrcpQsbgkUdEjIDi4ugOIj63NkmYhnxPOZ9ex
   Ymk+QH5R5G0i1LUTqFcBPNnFLvqx6aLVKYxGEkiiZJTxav8mzq5rXfB7u
   +M8KeHcMTKcTmfkw7UkiU9xWmIAEyGkWShkcpBiVScsRebcdvs3qtYurg
   mry80GA4piY1HYYhGu0KC9cjmu5vxIe6kPLbygFSj2Fp45EWW6biqVoTK
   SKZ1xyrXUJJcJHrzaUpF9KjtklZ2R4frqyDSAZzLg0hlriamMePwSJoXc
   AmQAcvOkpC8OUbuZuDy0tQMxy0svhEklfCL2gel8BZ+XjDCA4Df7DIBn4
   w==;
X-CSE-ConnectionGUID: J1GDDvyAS1e0dCw8Izmz8Q==
X-CSE-MsgGUID: Z2OnNiNeTXGzRBanyekvWQ==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="29237608"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 02:58:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 02:58:02 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jul 2024 02:57:52 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <Jason@zx2c4.com>,
	<rdunlap@infradead.org>, <akpm@linux-foundation.org>,
	<geert+renesas@glider.be>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>, <Hari.PrasathGE@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: [PATCH v2 1/4] dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
Date: Mon, 15 Jul 2024 15:27:33 +0530
Message-ID: <20240715095736.618246-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240715095736.618246-1-manikandan.m@microchip.com>
References: <20240715095736.618246-1-manikandan.m@microchip.com>
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
---
changes in v2:
- List the clocks with description
- remove describing 'remove-endpoint' properties
- remove unused label, node and fix example DT indentation
- cosmetic fixes
---
 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
new file mode 100644
index 000000000000..ef8541d05219
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
@@ -0,0 +1,116 @@
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
+          Peripheral clock for the hardware block functionality
+      - description:
+          Generic clock to drive the D-PHY PLL block
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: refclk
+
+  microchip,sfr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to Special Function Register (SFR) node.To enable the DSI/CSI
+      selection bit in SFR's ISS Configuration Register.
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
+       microchip,sfr = <&sfr>;
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


