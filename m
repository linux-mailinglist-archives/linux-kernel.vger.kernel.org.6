Return-Path: <linux-kernel+bounces-381845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0A99B053A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FE51C21216
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80F1632F8;
	Fri, 25 Oct 2024 14:11:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E471FB895
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865503; cv=none; b=qq+UaKrEkvem4pObiCgDyZDMhO/a6pHQgZQhXXt9FoTwEgjRU2vrCvar3+FIANo6xxrIRP4tFDVdKBQTPi139wRtnULIMNHJ0NV2UsagCupn8FdjmfRM2++cJOhc9IOYLEdWp4ezhBSlVDV8aNgCxKcLTYg6e8khTb/tRGFRQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865503; c=relaxed/simple;
	bh=/J7MNHO54SnVxOLdZu0gY+b83+gptiiVf7Inco+pJGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjw7KU687v+OjvJ7VAmRl4ArVj5x9o5felygY3jXfqUbTPUx1WpShPU5e8pp+ar3QI56iLZ6Ev/zzrQlkBccSxmCKOWi6cttxxIIc/WLrBCdKD96qgszzXcdgb3xIkNzy8AhoEjpp/IBvK7VEYhzzyXkL94nA4hDQbKbYLBTAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2O-0005Mi-32; Fri, 25 Oct 2024 16:11:36 +0200
Received: from dude06.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::5c])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2M-000NRI-1g;
	Fri, 25 Oct 2024 16:11:34 +0200
Received: from rcz by dude06.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2M-00DL3d-1S;
	Fri, 25 Oct 2024 16:11:34 +0200
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: add YAML schema for LXD M9189A
Date: Fri, 25 Oct 2024 16:11:28 +0200
Message-Id: <20241025141130.3179166-2-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
References: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rcz@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The LXD M9189A is a 1024x600 MIPI-DSI panel.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
v2:
- add missing port property
- fix example to use vdd supply
found by running make dt_binding_check as suggested by the bot
- fix missing A in M9189A title
- fix compatible
found after v1 submission

 .../bindings/display/panel/lxd,m9189a.yaml    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml b/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
new file mode 100644
index 0000000000000..2f14213801a48
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lxd,m9189a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LXD M9189A DSI Display Panel
+
+maintainers:
+  - Rouven Czerwinski <r.czerwinski@pengutronix.de>
+
+properties:
+  compatible:
+    const: lxd,m9189a
+
+  reg:
+    maxItems: 1
+
+  standby-gpios:
+    description: GPIO used for the standby pin
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO used for the reset pin
+    maxItems: 1
+
+  vdd-supply:
+    description: Power regulator
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - standby-gpios
+  - reset-gpios
+  - vdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      panel@0 {
+        compatible = "lxd,m9189a";
+        reg = <0>;
+        backlight = <&backlight>;
+        reset-gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
+        standby-gpios = <&gpio5 22 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&reg_display_3v3>;
+
+        port {
+          mipi_panel_in: endpoint {
+            remote-endpoint = <&mipi_dsi_out>;
+          };
+        };
+      };
+    };
-- 
2.39.5


