Return-Path: <linux-kernel+bounces-175383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374108C1EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4FF1C2233B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823E15FA83;
	Fri, 10 May 2024 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2Te8tO0"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F6153BE2;
	Fri, 10 May 2024 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325102; cv=none; b=Lzlqf66PCQ3UujFWTS8efbgW3W8Ww3gxFMna3aQ+5j/BwCKQpVDUc8Q5Mg+Don/fOKvGjfb1WlAAzS7qDc0ugsNVz/esSWFr5u7zbdRGigHVLEoOLaZ83pESEljDVLEgLrp/9oL0oJN2FdbMLNOr0psUQgCQ2abO4Ujq/mqNizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325102; c=relaxed/simple;
	bh=23XnRa/IiuyZv/ZU8PNuuQHPPtXVdEyql8RnKn+BobU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/jCJQYq4XmvOK8wOt0yX25X698HJT4vwOXiQSIK1qR3QTa52v19hrkZE0yqAkaElKOWBt1F+WmMiXs+9dS2HDoOPHoFWmgvsfMqEe9hb9V3uGtuZ2jZMkQM/8nXzRLutDyh9TriPE1uTxbFmOIzF26qSbnSs3zmxB7EL3s5hHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2Te8tO0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 314391C0005;
	Fri, 10 May 2024 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715325093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZpOXHh7CnEM4D1u1tGQ38W2j3r5rDs/UQI+e6C0fvw=;
	b=F2Te8tO0aZtJiDUApinRMHGDhYOxwKArMEbr2aEa5S35/Na/t8AhS/UgBtgw6cbCiZftch
	yBZBjRAUqL1YvP8ilnJyR0DalepTGI7XjR0D+Xhfi523BOl8yfHg9apsp9R53tDcA5nwB9
	9RSXDNU9F22TUhLj40ug0LgqLzTcWvFk7Q/ULfTI72Y15IJ9v0e7pcBru9bJ+Ix/R/dg71
	8tu2g9lV8I/J7etZVFITONBeEZMJEjODI6ujK8qrSO8Y52cTBm0n7cBVREU88Xk32btfBQ
	oJXqC7wTHWnF9zMsRiIoeZ/l2pXdwH52de+Z+hnGDH+8Ghi6G+SAp/Ao3KP+7g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 10 May 2024 09:10:37 +0200
Subject: [PATCH v2 1/5] dt-bindings: connector: add GE SUNH hotplug addon
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-hotplug-drm-bridge-v2-1-ec32f2c66d56@bootlin.com>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
In-Reply-To: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Paul Kocialkowski <contact@paulk.fr>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Add bindings for the GE SUNH add-on connector. This is a physical,
hot-pluggable connector that allows to attach and detach at runtime an
add-on adding peripherals on non-discoverable busses.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

NOTE: the second and third examples fail 'make dt_binding_check' because
      they are example of DT overlay code -- I'm not aware of a way to
      validate overlay examples as of now

This patch is new in v2.
---
 .../connector/ge,sunh-addon-connector.yaml         | 197 +++++++++++++++++++++
 MAINTAINERS                                        |   5 +
 2 files changed, 202 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/ge,sunh-addon-connector.yaml b/Documentation/devicetree/bindings/connector/ge,sunh-addon-connector.yaml
new file mode 100644
index 000000000000..c7ac62e5f2c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/ge,sunh-addon-connector.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/ge,sunh-addon-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GE SUNH hotplug add-on connector
+
+maintainers:
+  - Luca Ceresoli <luca.ceresoli@bootlin.com>
+
+description:
+  Represent the physical connector present on GE SUNH devices that allows
+  to attach and detach at runtime an add-on adding peripherals on
+  non-discoverable busses.
+
+  This connector has status GPIOs to notify the connection status to the
+  CPU and a reset GPIO to allow the CPU to reset all the peripherals on the
+  add-on. It also has a 4-lane MIPI DSI bus.
+
+  Add-on removal can happen at any moment under user control and without
+  prior notice to the CPU, making all of its components not usable
+  anymore. Later on, the same or a different add-on model can be connected.
+
+properties:
+  compatible:
+    const: ge,sunh-addon-connector
+
+  reset-gpios:
+    description: An output GPIO to reset the peripherals on the add-on.
+    maxItems: 1
+
+  plugged-gpios:
+    description: An input GPIO that is asserted if and only if an add-on is
+      physically connected.
+    maxItems: 1
+
+  powergood-gpios:
+    description: An input GPIO that is asserted if and only if power rails
+      on the add-on are stable.
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    description: OF graph bindings modeling the MIPI DSI bus across the
+      connector. The connector splits the video pipeline in a fixed part
+      and a removable part.
+
+      The fixed part of the video pipeline includes all components up to
+      the display controller and 0 or more bridges. The removable part
+      includes any bridges and any other components up to the panel.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: The MIPI DSI bus line from the CPU to the connector.
+          The remote-endpoint sub-node must point to the last non-removable
+          component of the video pipeline.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+
+        description: The MIPI DSI bus line from the connector to the
+          add-on. The remote-endpoint sub-node must point to the first
+          add-on component of the video pipeline. As it describes the
+          hot-pluggable hardware, the endpoint node cannot be filled until
+          an add-on is detected, so this needs to be done by a device tree
+          overlay at runtime.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  # Main DTS describing the "main" board up to the connector
+  - |
+    / {
+        #include <dt-bindings/gpio/gpio.h>
+
+        addon_connector: addon-connector {
+            compatible = "ge,sunh-addon-connector";
+            reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+            plugged-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+            powergood-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    hotplug_conn_dsi_in: endpoint {
+                        remote-endpoint = <&previous_bridge_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    hotplug_conn_dsi_out: endpoint {
+                        // remote-endpoint to be added by overlay
+                    };
+                };
+            };
+        };
+    };
+
+  # "base" overlay describing the common components on every add-on that
+  # are required to read the model ID
+  - |
+    &i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eeprom@50 {
+            compatible = "atmel,24c64";
+            reg = <0x50>;
+
+            nvmem-layout {
+                compatible = "fixed-layout";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                addon_model_id: addon-model-id@400 {
+                    reg = <0x400 0x1>;
+                };
+            };
+        };
+    };
+
+    &addon_connector {
+        nvmem-cells = <&addon_model_id>;
+        nvmem-cell-names = "id";
+    };
+
+  # Add-on-specific overlay describing all add-on components not in the
+  # "base" overlay
+  - |
+    &hotplug_conn_dsi_out {
+        remote-endpoint = <&addon_bridge_in>;
+    };
+
+    &i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dsi-lvds-bridge@42 {
+            compatible = "some-video-bridge";
+            reg = <0x42>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    addon_bridge_in: endpoint {
+                        remote-endpoint = <&hotplug_conn_dsi_out>;
+                        data-lanes = <1 2 3 4>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    addon_bridge_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };
+
+    &{/}
+    {
+    panel {
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0{
+                reg = <0>;
+
+                panel_in: endpoint {
+                    remote-endpoint = <&addon_bridge_out>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ec0284125e8f..4955501217eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9897,6 +9897,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 F:	drivers/iio/pressure/mprls0025pa*
 
+HOTPLUG CONNECTOR FOR GE SUNH ADDONS
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/connector/ge,sunh-addon-connector.yaml
+
 HP BIOSCFG DRIVER
 M:	Jorge Lopez <jorge.lopez2@hp.com>
 L:	platform-driver-x86@vger.kernel.org

-- 
2.34.1


