Return-Path: <linux-kernel+bounces-415256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E69D3390
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1666B22A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26A1581F8;
	Wed, 20 Nov 2024 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WlyzBSxl"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89E74040;
	Wed, 20 Nov 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084407; cv=none; b=Y8vWsqDHYZGM40tEfqmTH1vTDSBD6Tm/dwjTLQu4Qrsm6AkgFaTsgxvEw6E9bJXNY3kF2rAeEfIEeX4F6D8mL3zOEsTw3EBUzus14DR3V4Hy9OAx4P6e5zGXBv4htoKqgLwXTXhOnkEi2n0Mr8/PMV0OshlwghWj5yxFeSGl9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084407; c=relaxed/simple;
	bh=BhHGLO870V4FOrg0troGhSBfmZamkn54W4JPw63mrJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTkqEUAh9FdOh2K9Qaxx5mvEZzLdaI11Fm4jTA7rvqqfQQv2SDixjFlkjkwPzDkC9+MkcMrPRVNESX3BPT7Okf+6GkKsweSTIUTDGIGB7FNZq8X7sO7Z3YHN+KR7sTxGGoGOxCYoK57DhnMctklS9BpnsUo7jJu3TppuqEkBw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WlyzBSxl; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55c9b23ca70911efbd192953cf12861f-20241120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BgO5kZ0hbiXdUosl1gElWwRFfjYDoWRPAJtVB+IOdxo=;
	b=WlyzBSxl+iHgySIy2NlNphsl14YMh3PO62uwgmnTOWIZ5q7Xa2U46mMnaZwN01JtxcWqRIpg+g+lRdNQl5FnWIbAZE0UiTG4DpOJqT255bsGwVYNiPzd+nPd5qlbwan1V3WAVie9alAoaaVdT7S0QBjcv6YOxfCp/Ga23UPK3KE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:6edcc1d4-8c24-44f5-8327-989d65358866,IP:0,U
	RL:25,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-META: VersionHash:464815b,CLOUDID:1aea47ce-1d09-4671-8b9c-efcc0e30e122,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:1,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 55c9b23ca70911efbd192953cf12861f-20241120
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1208417204; Wed, 20 Nov 2024 14:33:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Nov 2024 14:33:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Nov 2024 14:33:18 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Friday Yang
	<friday.yang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: reset: mediatek: Add mt8188 SMI reset control binding
Date: Wed, 20 Nov 2024 14:32:55 +0800
Message-ID: <20241120063305.8135-2-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241120063305.8135-1-friday.yang@mediatek.com>
References: <20241120063305.8135-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: "Friday Yang" <friday.yang@mediatek.com>

To support SMI clamp and reset operation in genpd callback, add
SMI LARB reset controller in the bindings. Add index in
mt8188-resets.h to query the reset signal in the SMI reset
control driver.

Signed-off-by: Friday Yang <friday.yang@mediatek.com>
---
 .../bindings/reset/mediatek,smi-reset.yaml    | 53 +++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h     | 11 ++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
new file mode 100644
index 000000000000..77a6197a9846
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/mediatek,smi-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SMI Reset Controller
+
+maintainers:
+  - Friday Yang <friday.yang@mediatek.com>
+
+description: |
+  This reset controller node is used to perform reset management
+  of SMI larbs on MediaTek platform. It is used to implement various
+  reset functions required when SMI larbs apply clamp operation.
+
+  For list of all valid reset indices see
+    <dt-bindings/reset/mt8188-resets.h> for MT8188.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8188-smi-reset
+
+  "#reset-cells":
+    const: 1
+    description:
+      The cell should be the device ID. SMI reset controller driver could
+      query the reset signal of each SMI larb by device ID.
+
+  mediatek,larb-rst:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of each subsys clock controller. SMI larbs are located in
+      these subsys. SMI needs to parse the node of each subsys clock
+      controller to get the register address, and then apply the reset
+      operation.
+
+required:
+  - compatible
+  - "#reset-cells"
+  - mediatek,larb-rst
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller {
+        compatible = "mediatek,mt8188-smi-reset";
+        #reset-cells = <1>;
+        mediatek,larb-rst = <&imgsys1_dip_top>;
+    };
diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
index 5a58c54e7d20..387a4beac688 100644
--- a/include/dt-bindings/reset/mt8188-resets.h
+++ b/include/dt-bindings/reset/mt8188-resets.h
@@ -113,4 +113,15 @@
 #define MT8188_VDO1_RST_HDR_GFX_FE1_DL_ASYNC	52
 #define MT8188_VDO1_RST_HDR_VDO_BE_DL_ASYNC	53

+#define MT8188_SMI_RST_LARB10			0
+#define MT8188_SMI_RST_LARB11A			1
+#define MT8188_SMI_RST_LARB11C			2
+#define MT8188_SMI_RST_LARB12			3
+#define MT8188_SMI_RST_LARB11B			4
+#define MT8188_SMI_RST_LARB15			5
+#define MT8188_SMI_RST_LARB16B			6
+#define MT8188_SMI_RST_LARB17B			7
+#define MT8188_SMI_RST_LARB16A			8
+#define MT8188_SMI_RST_LARB17A			9
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8188 */
--
2.46.0


