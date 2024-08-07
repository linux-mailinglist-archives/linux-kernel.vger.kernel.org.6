Return-Path: <linux-kernel+bounces-277638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741AC94A414
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2EB283FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48F1D1727;
	Wed,  7 Aug 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bOv9wSod"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9101D0DEB;
	Wed,  7 Aug 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022288; cv=none; b=sHEe9hy2v0/mZOIhXsdgCudMqXUOQig9LIeV1BwcFbYTpxBH+qf9Voz0K7b+j+tcjlnkqoNu6CivcV/NTxckoi3XLIm6cn+g6kK4P0DKgXF6sI+123NuviliGpSZVAO+ADB0eCTP7Kk9LMOtduh/oiKXm6Xxxws4Zb8L6jOaj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022288; c=relaxed/simple;
	bh=xpuXkfC99cseuPtMLKPA7hWreyFF2FJaTjPbUqEtNow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5c1FEHRGSs5Di/VTsNWsuNr+5LL+FdpA6GEJFL35MWZs6nCHZuRcnaD4Mw9Q3TAoX1klhS3GEPZtA4u1xslYPCcbvkC36YSK26QWtmWJvNKI9IaDw8ziXKlt6ZDWE2CZ5x4+V1C5qwAONukAOSzozpnaYzoCGgjyalV2aqr5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bOv9wSod; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ef3be980549d11ef87684b57767b52b1-20240807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4adnKWsx8j+xY9XsC5ULWsr2arXgZtlYtnwhVJWPCIA=;
	b=bOv9wSodG3YYF2vR5w9T9N7sqAGUswVch66rAt/Jp6MbzfG0aWISS1alZIxWIfPhrc+brqigOXYhutFTat3hequ2nFtqyOPEnMynAdlLfBIxo1lSqifq8cW6mD7TIj3Wzoh4gAo1yyIRWm9JJYADF4JLUwl79sulAQsmf4+T1IU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a0aec6e8-1ca9-4bd1-90dc-0540a62e981c,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:5a92d63e-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ef3be980549d11ef87684b57767b52b1-20240807
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1953208826; Wed, 07 Aug 2024 17:17:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Aug 2024 17:17:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Aug 2024 17:17:57 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>, Chen-Yu
 Tsai <wenst@chromium.org>
Subject: [PATCH v2] dt-bindings: regulator: mediatek,mt6397-regulator: convert to YAML
Date: Wed, 7 Aug 2024 17:17:38 +0800
Message-ID: <20240807091738.18387-1-macpaul.lin@mediatek.com>
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

Convert the MediaTek MT6397 regulator bindings to DT schema.

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../regulator/mediatek,mt6397-regulator.yaml  | 238 ++++++++++++++++++
 .../bindings/regulator/mt6397-regulator.txt   | 220 ----------------
 2 files changed, 238 insertions(+), 220 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt

Changes for v2:
 - Remove unnecessary regulator-compatibles.
 - Drop the top node of the parent device.
   Since the parent device is still in txt format,
   we are not moving this example to the parent device schema.
 - Use 4 spaces for indentation in the example.
 - Replace the old name in the example with the generic name "mt6397_regulators: regulators".

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
new file mode 100644
index 0000000..50db678
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
@@ -0,0 +1,238 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6397 Regulator
+
+maintainers:
+  - Sen Chu <sen.chu@mediatek.com>
+  - Macpaul Lin <macpaul.lin@mediatek.com>
+
+description:
+  Regulator node of the PMIC. This node should under the PMIC's device node.
+  All voltage regulators provided by the PMIC are described as sub-nodes of
+  this node.
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt6397-regulator
+
+patternProperties:
+  "^(buck_)?v(core|drm|gpu|io18|pca(7|15)|sramca(7|15))$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        description: |
+          BUCK regulators can set regulator-initial-mode and regulator-allowed-modes to
+          values specified in dt-bindings/regulator/mediatek,mt6397-regulator.h
+        items:
+          enum: [0, 1]
+    unevaluatedProperties: false
+
+  "^(ldo_)?v(tcxo|(a|io)28)$":
+    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?vusb$":
+    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+  "^(ldo_)?v(cama|emc3v3|gp[123456]|ibr|mc|mch)$":
+    description: LDOs with variable output and 0~100/10mV tuning
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mt6397_regulators: regulators {
+        compatible = "mediatek,mt6397-regulator";
+
+        mt6397_vpca15_reg: buck_vpca15 {
+            regulator-name = "vpca15";
+            regulator-min-microvolt = < 850000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <200>;
+        };
+
+        mt6397_vpca7_reg: buck_vpca7 {
+            regulator-name = "vpca7";
+            regulator-min-microvolt = < 850000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <115>;
+        };
+
+        mt6397_vsramca15_reg: buck_vsramca15 {
+            regulator-name = "vsramca15";
+            regulator-min-microvolt = < 850000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <115>;
+        };
+
+        mt6397_vsramca7_reg: buck_vsramca7 {
+            regulator-name = "vsramca7";
+            regulator-min-microvolt = < 850000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <115>;
+        };
+
+        mt6397_vcore_reg: buck_vcore {
+            regulator-name = "vcore";
+            regulator-min-microvolt = < 850000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <115>;
+        };
+
+        mt6397_vgpu_reg: buck_vgpu {
+            regulator-name = "vgpu";
+            regulator-min-microvolt = < 700000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <115>;
+        };
+
+        mt6397_vdrm_reg: buck_vdrm {
+            regulator-name = "vdrm";
+            regulator-min-microvolt = < 800000>;
+            regulator-max-microvolt = <1400000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <500>;
+        };
+
+        mt6397_vio18_reg: buck_vio18 {
+            regulator-name = "vio18";
+            regulator-min-microvolt = <1500000>;
+            regulator-max-microvolt = <2120000>;
+            regulator-ramp-delay = <12500>;
+            regulator-enable-ramp-delay = <500>;
+        };
+
+        mt6397_vtcxo_reg: ldo_vtcxo {
+            regulator-name = "vtcxo";
+            regulator-min-microvolt = <2800000>;
+            regulator-max-microvolt = <2800000>;
+            regulator-enable-ramp-delay = <90>;
+        };
+
+        mt6397_va28_reg: ldo_va28 {
+            regulator-name = "va28";
+            /* fixed output 2.8 V */
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vcama_reg: ldo_vcama {
+            regulator-name = "vcama";
+            regulator-min-microvolt = <1500000>;
+            regulator-max-microvolt = <2800000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vio28_reg: ldo_vio28 {
+            regulator-name = "vio28";
+            /* fixed output 2.8 V */
+            regulator-enable-ramp-delay = <240>;
+        };
+
+        mt6397_usb_reg: ldo_vusb {
+            regulator-name = "vusb";
+            /* fixed output 3.3 V */
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vmc_reg: ldo_vmc {
+            regulator-name = "vmc";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vmch_reg: ldo_vmch {
+            regulator-name = "vmch";
+            regulator-min-microvolt = <3000000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vemc_3v3_reg: ldo_vemc3v3 {
+            regulator-name = "vemc_3v3";
+            regulator-min-microvolt = <3000000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vgp1_reg: ldo_vgp1 {
+            regulator-name = "vcamd";
+            regulator-min-microvolt = <1220000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <240>;
+        };
+
+        mt6397_vgp2_reg: ldo_vgp2 {
+            regulator-name = "vcamio";
+            regulator-min-microvolt = <1000000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vgp3_reg: ldo_vgp3 {
+            regulator-name = "vcamaf";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vgp4_reg: ldo_vgp4 {
+            regulator-name = "vgp4";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vgp5_reg: ldo_vgp5 {
+            regulator-name = "vgp5";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3000000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vgp6_reg: ldo_vgp6 {
+            regulator-name = "vgp6";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+
+        mt6397_vibr_reg: ldo_vibr {
+            regulator-name = "vibr";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-enable-ramp-delay = <218>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
deleted file mode 100644
index c080086..0000000
--- a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+++ /dev/null
@@ -1,220 +0,0 @@
-Mediatek MT6397 Regulator
-
-Required properties:
-- compatible: "mediatek,mt6397-regulator"
-- mt6397regulator: List of regulators provided by this controller. It is named
-  according to its regulator type, buck_<name> and ldo_<name>.
-  The definition for each of these nodes is defined using the standard binding
-  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
-
-The valid names for regulators are::
-BUCK:
-  buck_vpca15, buck_vpca7, buck_vsramca15, buck_vsramca7, buck_vcore, buck_vgpu,
-  buck_vdrm, buck_vio18
-LDO:
-  ldo_vtcxo, ldo_va28, ldo_vcama, ldo_vio28, ldo_vusb, ldo_vmc, ldo_vmch,
-  ldo_vemc3v3, ldo_vgp1, ldo_vgp2, ldo_vgp3, ldo_vgp4, ldo_vgp5, ldo_vgp6,
-  ldo_vibr
-
-BUCK regulators can set regulator-initial-mode and regulator-allowed-modes to
-values specified in dt-bindings/regulator/mediatek,mt6397-regulator.h
-
-Example:
-	pmic {
-		compatible = "mediatek,mt6397";
-
-		mt6397regulator: mt6397regulator {
-			compatible = "mediatek,mt6397-regulator";
-
-			mt6397_vpca15_reg: buck_vpca15 {
-				regulator-compatible = "buck_vpca15";
-				regulator-name = "vpca15";
-				regulator-min-microvolt = < 850000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <200>;
-			};
-
-			mt6397_vpca7_reg: buck_vpca7 {
-				regulator-compatible = "buck_vpca7";
-				regulator-name = "vpca7";
-				regulator-min-microvolt = < 850000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <115>;
-			};
-
-			mt6397_vsramca15_reg: buck_vsramca15 {
-				regulator-compatible = "buck_vsramca15";
-				regulator-name = "vsramca15";
-				regulator-min-microvolt = < 850000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <115>;
-
-			};
-
-			mt6397_vsramca7_reg: buck_vsramca7 {
-				regulator-compatible = "buck_vsramca7";
-				regulator-name = "vsramca7";
-				regulator-min-microvolt = < 850000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <115>;
-
-			};
-
-			mt6397_vcore_reg: buck_vcore {
-				regulator-compatible = "buck_vcore";
-				regulator-name = "vcore";
-				regulator-min-microvolt = < 850000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <115>;
-			};
-
-			mt6397_vgpu_reg: buck_vgpu {
-				regulator-compatible = "buck_vgpu";
-				regulator-name = "vgpu";
-				regulator-min-microvolt = < 700000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <115>;
-			};
-
-			mt6397_vdrm_reg: buck_vdrm {
-				regulator-compatible = "buck_vdrm";
-				regulator-name = "vdrm";
-				regulator-min-microvolt = < 800000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <500>;
-			};
-
-			mt6397_vio18_reg: buck_vio18 {
-				regulator-compatible = "buck_vio18";
-				regulator-name = "vio18";
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <2120000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <500>;
-			};
-
-			mt6397_vtcxo_reg: ldo_vtcxo {
-				regulator-compatible = "ldo_vtcxo";
-				regulator-name = "vtcxo";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <90>;
-			};
-
-			mt6397_va28_reg: ldo_va28 {
-				regulator-compatible = "ldo_va28";
-				regulator-name = "va28";
-				/* fixed output 2.8 V */
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vcama_reg: ldo_vcama {
-				regulator-compatible = "ldo_vcama";
-				regulator-name = "vcama";
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vio28_reg: ldo_vio28 {
-				regulator-compatible = "ldo_vio28";
-				regulator-name = "vio28";
-				/* fixed output 2.8 V */
-				regulator-enable-ramp-delay = <240>;
-			};
-
-			mt6397_usb_reg: ldo_vusb {
-				regulator-compatible = "ldo_vusb";
-				regulator-name = "vusb";
-				/* fixed output 3.3 V */
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vmc_reg: ldo_vmc {
-				regulator-compatible = "ldo_vmc";
-				regulator-name = "vmc";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vmch_reg: ldo_vmch {
-				regulator-compatible = "ldo_vmch";
-				regulator-name = "vmch";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-				regulator-compatible = "ldo_vemc3v3";
-				regulator-name = "vemc_3v3";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vgp1_reg: ldo_vgp1 {
-				regulator-compatible = "ldo_vgp1";
-				regulator-name = "vcamd";
-				regulator-min-microvolt = <1220000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <240>;
-			};
-
-			mt6397_vgp2_reg: ldo_vgp2 {
-				egulator-compatible = "ldo_vgp2";
-				regulator-name = "vcamio";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vgp3_reg: ldo_vgp3 {
-				regulator-compatible = "ldo_vgp3";
-				regulator-name = "vcamaf";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vgp4_reg: ldo_vgp4 {
-				regulator-compatible = "ldo_vgp4";
-				regulator-name = "vgp4";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vgp5_reg: ldo_vgp5 {
-				regulator-compatible = "ldo_vgp5";
-				regulator-name = "vgp5";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vgp6_reg: ldo_vgp6 {
-				regulator-compatible = "ldo_vgp6";
-				regulator-name = "vgp6";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-
-			mt6397_vibr_reg: ldo_vibr {
-				regulator-compatible = "ldo_vibr";
-				regulator-name = "vibr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <218>;
-			};
-		};
-	};
-- 
2.18.0


