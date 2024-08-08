Return-Path: <linux-kernel+bounces-279319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70294BBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C501F2206B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371918B479;
	Thu,  8 Aug 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L5dgVSUW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACE18A952;
	Thu,  8 Aug 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114680; cv=none; b=m/p1p9EPppaVSUy3aRJ3ich603Ke3UtfhBqNA3YFLPz6mJZC39AldbKFTuKJYtv6IZ9yLu0uvYgZJLc+ns5IH1nZhKxy5hGhZwRZMhPSIbXmpvrw0rjaUefR1Ydb3B5TNU1hkwj62MB57yN5g1OztcG3zNIJWzah454aE6J/kRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114680; c=relaxed/simple;
	bh=55kfGyOz+WEaJo/W86H3TTAnsKSPU+R1arN+qH2jaAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovLSBZ4N3u/oCQOam4Cie3Mg8b/CrbOG6wzh7+0UU28bcuo1bHSC8tL3t9EKoRjcFowE3rM0TH5QVJxKDdKNsijv2MswsHUPGCDK31ZDNVjpkoWuYah3bltc6rrjnrmTatVQv41lGbQQ3TAosSMFXpDBdLye3rAi9K40rM7cGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L5dgVSUW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0c7a91f4557511ef87684b57767b52b1-20240808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=25aCUhW16bAELL0sJZvG8xG/qjYiHb1//nKMHBCUUF4=;
	b=L5dgVSUWHOSBLFs/Qtar2wxsKsGB8ZtepI1O7hRPNpJjNlqfQCpKmRf0OBMjCFae3z8+xtL0AKYP+5M+/CRn959cZTRIxnlB3Yljs302C4sGYCWshJzb9BxP6CJTtpQzRZsxSLiODQTAkQcrmLuCBecMK8rvm7PB2+GJ+BjUnIY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:44992d60-3425-4e84-9a8d-5137599c1d33,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:d074e33e-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0c7a91f4557511ef87684b57767b52b1-20240808
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1035804885; Thu, 08 Aug 2024 18:57:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Aug 2024 03:57:48 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Aug 2024 18:57:48 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, Alexandre
 Mergnat <amergnat@baylibre.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH] dt-bindings: mfd: mediatek: mt6397: Convert to DT schema format
Date: Thu, 8 Aug 2024 18:57:22 +0800
Message-ID: <20240808105722.7222-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Convert the mfd: mediatek: mt6397 binding to DT schema format.

New updates in this conversion:
 - Align generic names of DT schema "audio-codec" and "regulators".
 - mt6397-regulators: Replace the "txt" reference with newly added DT
   schema.

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../bindings/mfd/mediatek,mt6397.yaml         | 202 ++++++++++++++++++
 .../devicetree/bindings/mfd/mt6397.txt        | 110 ----------
 2 files changed, 202 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt

Changes for v1:
 - This patch depends on conversion of mediatek,mt6397-regulator.yaml
   [1] https://lore.kernel.org/lkml/20240807091738.18387-1-macpaul.lin@mediatek.com/T/

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
new file mode 100644
index 0000000..cfbf2215
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -0,0 +1,202 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6397/MT6323 Multifunction Device
+
+maintainers:
+  - Sen Chu <sen.chu@mediatek.com>
+  - Macpaul Lin <macpaul.lin@mediatek.com>
+
+description: |
+  MT6397/MT6323 is a multifunction device with the following sub modules:
+  - Regulator
+  - RTC
+  - Audio codec
+  - GPIO
+  - Clock
+  - LED
+  - Keys
+  - Power controller
+
+  It is interfaced to host controller using SPI interface by a proprietary hardware
+  called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
+  See the following for pwarp node definitions:
+  ../soc/mediatek/mediatek,pwrap.yaml
+
+  This document describes the binding for MFD device and its sub module.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt6323
+          - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
+          - mediatek,mt6357
+          - mediatek,mt6358
+          - mediatek,mt6359
+          - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6366 # "mediatek,mt6366", "mediatek,mt6358" for PMIC MT6366
+          - const: mediatek,mt6358
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  rtc:
+    type: object
+    unevaluatedProperties: false
+    description:
+      Real Time Clock (RTC)
+      See ../rtc/rtc-mt6397.txt
+    properties:
+      compatible:
+        oneOf:
+          - enum:
+              - mediatek,mt6323-rtc
+              - mediatek,mt6331-rtc
+              - mediatek,mt6358-rtc
+              - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6366-rtc # RTC MT6366
+              - const: mediatek,mt6358-rtc
+
+  regulators:
+    type: object
+    oneOf:
+      - $ref: /schemas/regulator/mediatek,mt6358-regulator.yaml
+      - $ref: /schemas/regulator/mediatek,mt6397-regulator.yaml
+    unevaluatedProperties: false
+    description:
+      Regulators
+      For mt6323, see ../regulator/mt6323-regulator.txt
+    properties:
+      compatible:
+        oneOf:
+          - enum:
+              - mediatek,mt6323-regulator
+              - mediatek,mt6358-regulator
+              - mediatek,mt6397-regulator
+          - items:
+              - enum:
+                  - mediatek,mt6366-regulator # Regulator MT6366
+              - const: mediatek,mt6358-regulator
+
+  audio-codec:
+    type: object
+    unevaluatedProperties: false
+    description:
+      Audio codec
+    properties:
+      compatible:
+        oneOf:
+          - enum:
+              - mediatek,mt6397-codec
+              - mediatek,mt6358-sound
+          - items:
+              - enum:
+                  - mediatek,mt6366-sound # Codec MT6366
+              - const: mediatek,mt6358-sound
+
+  clk:
+    type: object
+    unevaluatedProperties: false
+    description:
+      Clock
+    properties:
+      compatible:
+        const: mediatek,mt6397-clk
+
+  led:
+    type: object
+    unevaluatedProperties: false
+    description:
+      LED
+      See ../leds/leds-mt6323.txt for more information
+    properties:
+      compatible:
+        const: mediatek,mt6323-led
+
+  keys:
+    type: object
+    $ref: /schemas/input/mediatek,pmic-keys.yaml
+    unevaluatedProperties: false
+    description: Keys
+    properties:
+      compatible:
+        oneOf:
+          - enum:
+              - mediatek,mt6323-keys
+              - mediatek,mt6331-keys
+              - mediatek,mt6397-keys
+
+  power-controller:
+    type: object
+    unevaluatedProperties: false
+    description:
+      Power controller
+      See ../power/reset/mt6323-poweroff.txt
+    properties:
+      compatible:
+        const: mediatek,mt6323-pwrc
+
+  pin-controller:
+    type: object
+    $ref: /schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml
+    unevaluatedProperties: false
+    description:
+      Pin controller
+    properties:
+      compatible:
+        const: mediatek,mt6397-pinctrl
+
+required:
+  - compatible
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwrap {
+        pmic {
+            compatible = "mediatek,mt6397";
+            interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            mt6397_codec: audio-codec {
+                compatible = "mediatek,mt6397-codec";
+            };
+
+            mt6397_regulators: regulators {
+                compatible = "mediatek,mt6397-regulator";
+
+                mt6397_vpca15_reg: buck_vpca15 {
+                    regulator-name = "vpca15";
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <1400000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-always-on;
+                };
+
+                mt6397_vgp4_reg: ldo_vgp4 {
+                    regulator-name = "vgp4";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-enable-ramp-delay = <218>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
deleted file mode 100644
index 10540aa..0000000
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ /dev/null
@@ -1,110 +0,0 @@
-MediaTek MT6397/MT6323 Multifunction Device Driver
-
-MT6397/MT6323 is a multifunction device with the following sub modules:
-- Regulator
-- RTC
-- Audio codec
-- GPIO
-- Clock
-- LED
-- Keys
-- Power controller
-
-It is interfaced to host controller using SPI interface by a proprietary hardware
-called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
-See the following for pwarp node definitions:
-../soc/mediatek/mediatek,pwrap.yaml
-
-This document describes the binding for MFD device and its sub module.
-
-Required properties:
-compatible:
-	"mediatek,mt6323" for PMIC MT6323
-	"mediatek,mt6331" for PMIC MT6331 and MT6332
-	"mediatek,mt6357" for PMIC MT6357
-	"mediatek,mt6358" for PMIC MT6358
-	"mediatek,mt6359" for PMIC MT6359
-	"mediatek,mt6366", "mediatek,mt6358" for PMIC MT6366
-	"mediatek,mt6397" for PMIC MT6397
-
-Optional subnodes:
-
-- rtc
-	Required properties: Should be one of follows
-		- compatible: "mediatek,mt6323-rtc"
-		- compatible: "mediatek,mt6331-rtc"
-		- compatible: "mediatek,mt6358-rtc"
-		- compatible: "mediatek,mt6397-rtc"
-	For details, see ../rtc/rtc-mt6397.txt
-- regulators
-	Required properties:
-		- compatible: "mediatek,mt6323-regulator"
-	see ../regulator/mt6323-regulator.txt
-		- compatible: "mediatek,mt6358-regulator"
-		- compatible: "mediatek,mt6366-regulator", "mediatek-mt6358-regulator"
-	see ../regulator/mt6358-regulator.txt
-		- compatible: "mediatek,mt6397-regulator"
-	see ../regulator/mt6397-regulator.txt
-- codec
-	Required properties:
-		- compatible: "mediatek,mt6397-codec" or "mediatek,mt6358-sound"
-- clk
-	Required properties:
-		- compatible: "mediatek,mt6397-clk"
-- led
-	Required properties:
-		- compatible: "mediatek,mt6323-led"
-	see ../leds/leds-mt6323.txt
-
-- keys
-	Required properties: Should be one of the following
-		- compatible: "mediatek,mt6323-keys"
-		- compatible: "mediatek,mt6331-keys"
-		- compatible: "mediatek,mt6397-keys"
-	see ../input/mtk-pmic-keys.txt
-
-- power-controller
-	Required properties:
-		- compatible: "mediatek,mt6323-pwrc"
-	For details, see ../power/reset/mt6323-poweroff.txt
-
-- pin-controller
-	Required properties:
-		- compatible: "mediatek,mt6397-pinctrl"
-	For details, see ../pinctrl/pinctrl-mt65xx.txt
-
-Example:
-	pwrap: pwrap@1000f000 {
-		compatible = "mediatek,mt8135-pwrap";
-
-		...
-
-		pmic {
-			compatible = "mediatek,mt6397";
-
-			codec: mt6397codec {
-				compatible = "mediatek,mt6397-codec";
-			};
-
-			regulators {
-				compatible = "mediatek,mt6397-regulator";
-
-				mt6397_vpca15_reg: buck_vpca15 {
-					regulator-compatible = "buck_vpca15";
-					regulator-name = "vpca15";
-					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1400000>;
-					regulator-ramp-delay = <12500>;
-					regulator-always-on;
-				};
-
-				mt6397_vgp4_reg: ldo_vgp4 {
-					regulator-compatible = "ldo_vgp4";
-					regulator-name = "vgp4";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-enable-ramp-delay = <218>;
-				};
-			};
-		};
-	};
-- 
2.18.0


