Return-Path: <linux-kernel+bounces-295134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8D959771
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D26B1F220C4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0061C4EDB;
	Wed, 21 Aug 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WnKNyyQL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EB1B2ECB;
	Wed, 21 Aug 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228957; cv=none; b=QvFA2N9DHTZ7e9CtRfCXqUG2D+kZjgl1sKqAFs3B9GXIjcg3zRa8DfwmKtmvTQBgusULS/XTYfTNYyz1YILO/BvT8U2/beRZbCkznAyXhIRFWcPz60hoZ8kCiSIN36lAyNm6lAhJODay+TiKup3vgy2Kzuf4t2MoTj9815FmkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228957; c=relaxed/simple;
	bh=BOrZjB3NWtk5olsqYQWSxhH02OD0VizTDsE+Q3HMMJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0k+h74PzOGX1TEFZ1sIRQtJzl1maHK20qwZTDDhHExhQWw2aKpbnXnCkkRz6Vq25dx5/8YzVmYF3M8ReoAoEJhZDOFdzAsYaGZTpOwe7B+DDhyi2VRf7FVrrGUtOvsSGuqLSvypXlLkS52zT8B/E9bHRVqsk2PhkjUVpkQJB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WnKNyyQL; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6a710b5e5f9711ef8b96093e013ec31c-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jRroNHsS4kq/bMO8WRnvcohyyXmbFWhG9LUftxAm+Co=;
	b=WnKNyyQL5bEzDIVBV1CCGSwCdZnYj/+jk/sGMHwvN+6PODF/kDxmO0cCGyUK8PzYxRC+K21tGyjiXbHKX0L378L9mKZ4en/l8WDXZoKr2Fl+/eIFD5+FNO5PscF84ndDVTOC26v96enXo0dtUeVc45TgH/JrWKAg4XY8KuIQWz4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:dda8fb56-5eaf-46fe-b3d5-1325c8d65266,IP:0,U
	RL:25,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-META: VersionHash:6dc6a47,CLOUDID:a98ef1ce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6a710b5e5f9711ef8b96093e013ec31c-20240821
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1002471367; Wed, 21 Aug 2024 16:29:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 16:28:55 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 16:28:54 +0800
From: friday.yang <friday.yang@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Friday Yang <friday.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 1/4] dt-bindings: memory: mediatek: Add mt8188 SMI reset control binding
Date: Wed, 21 Aug 2024 16:26:49 +0800
Message-ID: <20240821082845.11792-2-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821082845.11792-1-friday.yang@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.829500-8.000000
X-TMASE-MatchedRID: R3B6Edw+gpAxFdXyW/P+XcnUT+eskUQPLEOkDuO6MI8km/L/MIL+8pM5
	rPAxB6p1lTJXKqh1ne1M8qdoCvOVvms/tFw6ZTQWuIwLnB3Aqp2WHGENdT+VP5uc2X2zst+xDrG
	3Q1PIT6iJh4lfRksIUHAdyhB0oDzs9mia1kFQhdCQ+GmkZu94cv+UEb65dgmQ+5+93dPb6/eAzY
	IjHF+VJeLzNWBegCW2U9w4XVXDWCYLbigRnpKlKTpcQTtiHDgWQxitkXat1SEypeIkTB5qDJNG+
	ExD2vU/Pay9KaxQKp7x9BkkBFqz7g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.829500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BBD090C5ECD942BC4A586DC9F9181C138D2C8BE75586C512F0FFFF14353E0B132000:8

To support SMI clamp and reset operation in genpd callback, add
SMI LARB reset register offset and mask related information in
the bindings. Add index in mt8188-resets.h to query the register
offset and mask in the SMI reset control driver.

Signed-off-by: friday.yang <friday.yang@mediatek.com>
---
 .../bindings/reset/mediatek,smi-reset.yaml    | 46 +++++++++++++++++++
 include/dt-bindings/reset/mt8188-resets.h     | 11 +++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
new file mode 100644
index 000000000000..66ac121d2396
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
@@ -0,0 +1,46 @@
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
+      - mediatek,smi-reset-mt8188
+
+  "#reset-cells":
+    const: 1
+
+  mediatek,larb-rst-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the SMI larb's reset controller syscon.
+
+required:
+  - compatible
+  - "#reset-cells"
+  - mediatek,larb-rst-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    imgsys1_dip_top_rst: reset-controller {
+          compatible = "mediatek,smi-reset-mt8188";
+          #reset-cells = <1>;
+          mediatek,larb-rst-syscon = <&imgsys1_dip_top>;
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


