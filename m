Return-Path: <linux-kernel+bounces-270526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 387359440F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F2B283D90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3314264C;
	Thu,  1 Aug 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XqT19Ow7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A261142633;
	Thu,  1 Aug 2024 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477979; cv=none; b=kaTdvnE3a6cV2gVa+6fKmwJN/Iz84prrBtmwKl8zOUXaX011UJhIFAy6HNfcO+6UmdLpM7Y+EN3uFitPdKmqPk69pOFbXVUjJfRRzFg/N9u3yVBENgGU4GQh/aOwVlIzNeugPLD3+G41pD4RdaaJSJRZElqzGZusjlaPRYTOQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477979; c=relaxed/simple;
	bh=vyJH9Gt086fk0KcuMrHPYIdfehtCb20GAQk7L4KspyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLSOltSO7w9xHoCIyeklDy3JasEQDpLBODV5rqCFof133Ywugin6Ueg6393+9Cjhh3pR6HKonelDK3gWRZYo2A5pxE+E8/fXT4rIbOEZnsRvkNpNxG5pCCkRF0/N2GrVTK70DGnCO9gJrQpkPvF0r78ev5HM+4uPD5IYYLPR744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XqT19Ow7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722477974;
	bh=vyJH9Gt086fk0KcuMrHPYIdfehtCb20GAQk7L4KspyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XqT19Ow7sEw45TyrqSRHNbmVDX2DDmkhA9ycVG3JgnJ9tB4bj2yXWARPa04XGSbIi
	 dbF+Il1Xri4hjMuQjpjY260lgOypTU4TdAEuchHXK5zd+tRlYE7XDA1d37lFc1N6DI
	 //x3hmHE4OCwVmQHfIaJNBNbmuY7XdjijfwWrRnc16LLE/fPr+KLebjsp3Gg0JHf2c
	 N+C89TdDCG0XQd3KEYDPXOyvdLA3rXJXbqRPR/BtZJMEaErNOsU2aMHEwv7pa4vqQo
	 ZLozlBwQK2a1h/5lt1ub2Ad7LvKJfbuX7/wNaAPlzshnz2UXBW8qi727dZSqSRY5dS
	 aQTZ0G2R9W2Pg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 285D63782191;
	Thu,  1 Aug 2024 02:06:14 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 01 Aug 2024 05:05:14 +0300
Subject: [PATCH 1/2] dt-bindings: display: bridge: Add schema for Synopsys
 DW HDMI QP TX IP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-dw-hdmi-qp-tx-v1-1-148f542de5fd@collabora.com>
References: <20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com>
In-Reply-To: <20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alexandre ARNOUD <aarnoud@me.com>, 
 Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14.1

Add dt-binding schema containing the common properties for the Synopsys
DesignWare HDMI QP TX controller.

Note this is not a full dt-binding specification, but is meant to be
referenced by platform-specific bindings for this IP core.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../display/bridge/synopsys,dw-hdmi-qp.yaml        | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml
new file mode 100644
index 000000000000..d8aee12b121d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Synopsys DesignWare HDMI QP TX Controller IP
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+
+description: |
+  This document defines device tree properties for the Synopsys DesignWare
+  HDMI 2.1 Quad-Pixel (QP) TX controller IP core.
+  It doesn't constitute a device tree binding specification by itself, but
+  is meant to be referenced by platform-specific device tree bindings.
+
+  When referenced from platform device tree bindings, the properties defined
+  in this document are defined as follows. The platform device tree bindings
+  are responsible for defining whether each property is required or optional.
+
+properties:
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+    maxItems: 6
+    items:
+      - description: Peripheral/APB bus clock
+      - description: EARC RX biphase clock
+      - description: Reference clock
+      - description: Audio interface clock
+    additionalItems: true
+
+  clock-names:
+    minItems: 4
+    maxItems: 6
+    items:
+      - const: pclk
+      - const: earc
+      - const: ref
+      - const: aud
+    additionalItems: true
+
+  interrupts:
+    minItems: 4
+    maxItems: 5
+    items:
+      - description: AVP Unit interrupt
+      - description: CEC interrupt
+      - description: eARC RX interrupt
+      - description: Main Unit interrupt
+    additionalItems: true
+
+  interrupt-names:
+    minItems: 4
+    maxItems: 5
+    items:
+      - const: avp
+      - const: cec
+      - const: earc
+      - const: main
+    additionalItems: true
+
+additionalProperties: true

-- 
2.45.2


