Return-Path: <linux-kernel+bounces-531827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FCFA44584
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913B7167039
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E00718BC20;
	Tue, 25 Feb 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yh785hMB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F221ABD8;
	Tue, 25 Feb 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499704; cv=none; b=KpXJFuXpfs/R+igwLdB+TQud4Ljb1KwU4ceAIym1nlVAZHLk1FeVUf4DyZTesRmTdtO9giGnehYqbFS7w1Zd6o6c+3tSkg7cVy+GxtucwNBkgeg0nILg2AqMiq10j+V/TWfgUOPAMhIOrMHZh2G75uBTmYSKwVXQeuUNBAlwANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499704; c=relaxed/simple;
	bh=WsW4sJ9uxm43lHLyN92viVq/iZ4gai0sRD6kALPbI0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qc4JXGb0JsDxhKxmoweLaV+eH1aKPfWky1PnvoCwC19t5Ojyul+quLrAqLuB2Ymppg6ksQEjRybDGSyyeeSD/uu2YPO72R/wpkuAPOhDK92t1glwHqI6EJKVEDJbkyd8Efaupehjr8nc2mz1llE/uwtgWeXT/v7nd5T8GqMp+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yh785hMB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740499700;
	bh=WsW4sJ9uxm43lHLyN92viVq/iZ4gai0sRD6kALPbI0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yh785hMBVWmCAIp2fhXzzdcEBabNhdBwxrjQbwrsCQbwOKUPzH0OCNPnIJOppSKve
	 bqqd4T5l8fnGjPKHyxBi31VRqBc9Zkd+FdRpez1Lfq+Q5oQ3+jTHwWUW6PtdOE89AL
	 HaTf/UzR/r066m2xeqDmfkdiS7FMti80u7Nfj8SofiFiTTwrzLwL8tVw0rrUuOUgOd
	 v0pocbUrPiNOZotuYLCsVcfL4WXhtOILMhYY5qHTZcf8uFjALmkKQ/c/0RWLo7jLQ5
	 LWYMahf02my5t0dyk1KSMe2+/4XDO8u0dCwJo2/an72E5QkT/wEFoWh4z+jzePIYwD
	 YYG4bhUS2fijQ==
Received: from jupiter.universe (dyndsl-091-248-213-055.ewe-ip-backbone.de [91.248.213.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB35817E09B8;
	Tue, 25 Feb 2025 17:08:20 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 850A6480037; Tue, 25 Feb 2025 17:08:20 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 25 Feb 2025 17:07:59 +0100
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Raydium RM67200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-raydium-rm67200-v3-1-d9e1010dd8ab@kernel.org>
References: <20250225-raydium-rm67200-v3-0-d9e1010dd8ab@kernel.org>
In-Reply-To: <20250225-raydium-rm67200-v3-0-d9e1010dd8ab@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=sre@kernel.org;
 h=from:subject:message-id; bh=WsW4sJ9uxm43lHLyN92viVq/iZ4gai0sRD6kALPbI0c=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe96vSWT6nNH0xaepL9MStCfAqXvMxKy47M2
 ZyuLJNwu/ExpIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnver0AAoJENju1/PI
 O/qazngP/jevRZ8b1xOfaKeVAdSMJRokkZAkX2JmyRTaIB+auN08BSq7GQVGeuOr5wKuCHip3qI
 xzTjHRGaKJlWdHbJI8dTiQ3XD8gVQ4Mcd+GrQ+SiQkayzSKzmFQnB56k/K6Itvfeb8gnH6IhLtT
 v5amySFcxZ3953GWQ7YFnT4Ukcg7KKiXprg708BsTsnyzp5PFNpsJDIQ3ZnYh3o5THIMwcdt9RY
 bKU/huB+swMTpr0Mev+6pHeyLh2qjwmNzPV3tMv14cypbnHJE4U6lmoH7gcLNyoqk10dSzLxr59
 KoQyGuPtOG1oLbhfHWjlHvq1fgVn7EAwzjetzvEaXRUMR/75+QlFIhpnWr0H0AtKCM8I2J+i4Cp
 e+nkfwzzYkk4d4V8WMGLWLOwkCbL+v7WWRwgnDg3222YtcXJGDTrfoccjDmHlIz0gd3Q6kTFIW/
 BY/BJeec/ceouSR8Mj7f3CpeXr2+eOJ5YTRTc7U0aHROEXV6kb1z2DBZRvjmFhK1eqDiFuefDAU
 7fHjISPSC0ykhfd+SgHwk5++FZoe99uSc7oOVfhf5DYeug7BxumiNWtN5TJO0YVRwhf44cdKqRa
 1/2ItWrYKb2Lysu64QfF5+A+/6qIU6veQewPHUYscOo+b6jZJ9vRZ2+r5hm99vAczOCyPJbbYuT
 CjamL7MczhORJS6wHwdoy9g==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The Rockchip W552793DBA-V10 display/touchscreen board contains a
Wanchanglong W552793BAA panel, which in turn is using a Raydium
RM67200 MIPI-DSI controller. Add a DT binding for the DSI panel.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/display/panel/raydium,rm67200.yaml    | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..54c9c0ef45ecc730c722fb152390db4e6c45aab9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm67200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM67200 based MIPI-DSI panels
+
+maintainers:
+  - Sebastian Reichel <sebastian.reichel@collabora.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - wanchanglong,w552793baa
+      - const: raydium,rm67200
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: 2.8V Logic voltage
+
+  iovcc-supply:
+    description: 1.8V IO voltage
+
+  vsp-supply:
+    description: positive 5.5V voltage
+
+  vsn-supply:
+    description: negative 5.5V voltage
+
+  backlight: true
+  port: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - port
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "wanchanglong,w552793baa", "raydium,rm67200";
+            reg = <0>;
+
+            vdd-supply = <&regulator1>;
+            iovcc-supply = <&regulator2>;
+            vsp-supply = <&regulator3>;
+            vsn-supply = <&regulator4>;
+            reset-gpios = <&gpiobank 42 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel0_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...

-- 
2.47.2


