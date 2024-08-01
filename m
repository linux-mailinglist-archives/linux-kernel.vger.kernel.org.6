Return-Path: <linux-kernel+bounces-270537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59000944147
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F271B2DC71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A71EB48A;
	Thu,  1 Aug 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jA9Q5bx7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331742F5E;
	Thu,  1 Aug 2024 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479187; cv=none; b=eGlsriBfPSble5zGhSUVzgQLazeyzfgCEe4ct3gEJqDKZaGFnjQmPZO/bNMZ6HkZNoE2Dcthyu8ZzCzJ4NGrCEMzSzpXaPeNRdWWVQAbyg3hWyED6+c/z2tfYhB0GPWjA1MV5TT+wwLf2ughzuhvM9sMXu0MwaBbsJIgtl39bUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479187; c=relaxed/simple;
	bh=PJnERirt5cRL63lnv/HsDpSZEpu4TQvzEFViwuEEtH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxugW6AXKrXUSz10rZyMGNcsUGB6smIZ3J6hJXg8J04XuL95M5MQmXdF91RFLe+2pzqrIkJ/lUmw8G/KuJFJaPbUcclhgD/VRz5QY08QMCufQJ635AwtQv/bLsG8x6yGE/C3IUhZVc6iAy7ZLoQri1B7dPhKOtzQ5kraambDRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jA9Q5bx7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722479183;
	bh=PJnERirt5cRL63lnv/HsDpSZEpu4TQvzEFViwuEEtH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jA9Q5bx7fdxgy4Ry+zbMjDIN56ilUJsPiFh4uxAdP1SlLg29XT6/uzGuJ1afCmD3k
	 k/d56utLzAYT1l4dHccA4Wx5itftXa8qI8+vz2x+xBdSlDOWqlJrF6KQf4pNyPfjRl
	 J+vHL8m3aJEkazfrI/7U0MTNhEoRs9zQ116P3VAp7OYTft1NV/26FLeHbaVaMzoq7a
	 mbVc2rG/4wnlzHwl82wmIQbyGzp2/leYh0Qjo9Bbr1ELjnDrMUqKiU8DaYf8gCEXOz
	 4qfmyzy50QBRZq8Ctb7jJb3JaSNeawos3JkrJPUe+PJohOkLyTmH33DjIY73rADp/a
	 O+Sz7j+aYh15g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31FC03782204;
	Thu,  1 Aug 2024 02:26:23 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 01 Aug 2024 05:25:52 +0300
Subject: [PATCH v2 1/3] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-b4-rk3588-bridge-upstream-v2-1-9fa657a4e15b@collabora.com>
References: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
In-Reply-To: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14.1

Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
Quad-Pixel (QP) TX controller IP.

Since this is a new IP block, quite different from those used in the
previous generations of Rockchip SoCs, add a dedicated binding file.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 +++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml
new file mode 100644
index 000000000000..33572c88a589
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi-qp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip DW HDMI QP TX Encoder
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+
+description:
+  Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI QP TX controller
+  IP and a HDMI/eDP TX Combo PHY based on a Samsung IP block.
+
+allOf:
+  - $ref: ../bridge/synopsys,dw-hdmi-qp.yaml#
+  - $ref: /schemas/sound/dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-dw-hdmi-qp
+
+  clocks:
+    minItems: 4
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      # The next clocks are optional, but shall be specified in this
+      # order when present.
+      - description: TMDS/FRL link clock
+      - description: Video datapath clock
+
+  clock-names:
+    minItems: 4
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      - enum: [hdp, hclk_vo1]
+      - const: hclk_vo1
+
+  interrupts:
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      - description: HPD interrupt
+
+  interrupt-names:
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      - const: hpd
+
+  phys:
+    maxItems: 1
+    description: The HDMI/eDP PHY.
+
+  phy-names:
+    const: hdmi
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port node with one endpoint connected to a vop node.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Port node with one endpoint connected to a hdmi-connector node.
+
+    required:
+      - port@0
+      - port@1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: ref
+      - const: hdp
+
+  "#sound-dai-cells":
+    const: 0
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Most HDMI QP related data is accessed through SYS GRF regs.
+
+  rockchip,vo1_grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Additional HDMI QP related data is accessed through VO1 GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phys
+  - phy-names
+  - ports
+  - resets
+  - reset-names
+  - rockchip,grf
+  - rockchip,vo1_grf
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      hdmi@fde80000 {
+        compatible = "rockchip,rk3588-dw-hdmi-qp";
+        reg = <0x0 0xfde80000 0x0 0x20000>;
+        clocks = <&cru PCLK_HDMITX0>,
+                 <&cru CLK_HDMITX0_EARC>,
+                 <&cru CLK_HDMITX0_REF>,
+                 <&cru MCLK_I2S5_8CH_TX>,
+                 <&cru CLK_HDMIHDP0>,
+                 <&cru HCLK_VO1>;
+        clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "avp", "cec", "earc", "main", "hpd";
+        phys = <&hdptxphy_hdmi0>;
+        phy-names = "hdmi";
+        power-domains = <&power RK3588_PD_VO1>;
+        resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
+        reset-names = "ref", "hdp";
+        rockchip,grf = <&sys_grf>;
+        rockchip,vo1_grf = <&vo1_grf>;
+        #sound-dai-cells = <0>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            hdmi0_in_vp0: endpoint {
+                remote-endpoint = <&vp0_out_hdmi0>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            hdmi0_out_con0: endpoint {
+                remote-endpoint = <&hdmi_con0_in>;
+            };
+          };
+        };
+      };
+    };

-- 
2.45.2


