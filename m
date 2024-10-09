Return-Path: <linux-kernel+bounces-357967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D670499789B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7C1F23D16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33E1E3DDA;
	Wed,  9 Oct 2024 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YzvR4lBd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B115D5D9;
	Wed,  9 Oct 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513674; cv=none; b=o9WNWi3sqD3qZukVgQlgbc9tDQgUytlbmsWNoqy1IGJ0AbJ2wb4Lc2prJB3H9fPsXFMCoWuwNE1lTe0d0ZVt6Zz8/y6M3Ww22Ytl7oKcY4pWgR6T4dOj/WNRVTlf34M6Wz1of/93nLP5memeLvt1yARsuzYUYdc7odymd/lnmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513674; c=relaxed/simple;
	bh=PWp4kT7s/Fwc0Ox0LJ6sW4hsvPXd/Aa5dXhIqR1ulxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DklvGjfHPkSz/iciZKjN8EZjBkcnv1H9c3lYvg8HAFio2HfR1MjkK8DSSrBWK6AVAY7GrKwCA6Mr8KHT15HWaj2y+EjJIITzSq3nDwEpTsZUSPN++XX9I7gA9pKQ6AAsETVCR+/nFhLqRQ8k0z2bR3JQjXH6OZYIpHi69bExpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YzvR4lBd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728513670;
	bh=PWp4kT7s/Fwc0Ox0LJ6sW4hsvPXd/Aa5dXhIqR1ulxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YzvR4lBdxVS9ri8/nCdPLRwL2Fzf84HdXjf08I9pH+tpdQYh7mbK+NMR+YC2Psxn5
	 AuKAHoeTwcum4ErXS4UVnlKzG1xmk8ElOHQAdoUSueKKhBRNqYWspzKFH9S+2kfXZC
	 eGpGmKOqR/CFAkGpmeWm3rpduQsgR5SBakmFdCNzWsborRz/OLsHIdIBsFEtQJ0Xej
	 JZiRAj0LgRjMBQ/6xaczMFcJAu3cZQ/ZDUZaccxyn7Q0MXIsv8mMbyfbo0dz0OBVeM
	 k7bLELWAbJb04Lxu2TnI3TJHcoseQI3YeUdjTn8hDE2vbX3m5p5VGPXNVSkVhMay6h
	 tZr+emC0SKAWg==
Received: from localhost (unknown [IPv6:2001:861:8b81:d330:d4b:52bf:3fe7:c311])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4D6DC17E0EAC;
	Thu, 10 Oct 2024 00:41:10 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 10 Oct 2024 01:40:50 +0300
Subject: [PATCH v9 2/3] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-b4-rk3588-bridge-upstream-v9-2-68c47dde0410@collabora.com>
References: <20241010-b4-rk3588-bridge-upstream-v9-0-68c47dde0410@collabora.com>
In-Reply-To: <20241010-b4-rk3588-bridge-upstream-v9-0-68c47dde0410@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1

Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
Quad-Pixel (QP) TX controller IP.

Since this is a new IP block, quite different from those used in the
previous generations of Rockchip SoCs, add a dedicated binding file.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml       | 188 +++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
new file mode 100644
index 000000000000..d8e761865f27
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip DW HDMI QP TX Encoder
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+
+description: |
+  Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI QP TX controller
+  IP and a HDMI/eDP TX Combo PHY based on a Samsung IP block, providing the
+  following features, among others:
+
+  * Fixed Rate Link (FRL)
+  * Display Stream Compression (DSC)
+  * 4K@120Hz and 8K@60Hz video modes
+  * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
+  * Fast Vactive (FVA)
+  * SCDC I2C DDC access
+  * Multi-stream audio
+  * Enhanced Audio Return Channel (EARC)
+
+allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-dw-hdmi-qp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral/APB bus clock
+      - description: EARC RX biphase clock
+      - description: Reference clock
+      - description: Audio interface clock
+      - description: TMDS/FRL link clock
+      - description: Video datapath clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: earc
+      - const: ref
+      - const: aud
+      - const: hdp
+      - const: hclk_vo1
+
+  interrupts:
+    items:
+      - description: AVP Unit interrupt
+      - description: CEC interrupt
+      - description: eARC RX interrupt
+      - description: Main Unit interrupt
+      - description: HPD interrupt
+
+  interrupt-names:
+    items:
+      - const: avp
+      - const: cec
+      - const: earc
+      - const: main
+      - const: hpd
+
+  phys:
+    maxItems: 1
+    description: The HDMI/eDP PHY
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for RGB/YUV input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for HDMI/eDP output.
+
+    required:
+      - port@0
+      - port@1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
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
+      Some HDMI QP related data is accessed through SYS GRF regs.
+
+  rockchip,vo-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Additional HDMI QP related data is accessed through VO GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phys
+  - ports
+  - resets
+  - reset-names
+  - rockchip,grf
+  - rockchip,vo-grf
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
+        power-domains = <&power RK3588_PD_VO1>;
+        resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
+        reset-names = "ref", "hdp";
+        rockchip,grf = <&sys_grf>;
+        rockchip,vo-grf = <&vo1_grf>;
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
+              remote-endpoint = <&vp0_out_hdmi0>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            hdmi0_out_con0: endpoint {
+              remote-endpoint = <&hdmi_con0_in>;
+            };
+          };
+        };
+      };
+    };

-- 
2.46.1


