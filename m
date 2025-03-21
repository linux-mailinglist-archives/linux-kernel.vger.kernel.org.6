Return-Path: <linux-kernel+bounces-570992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C76A6B7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E14D486A16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC971F3FD2;
	Fri, 21 Mar 2025 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qjKu+9ZW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABC1F12F4;
	Fri, 21 Mar 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549726; cv=none; b=FJD1oLuo8z2VtK6r+D0OT5ezaYQBPQWTLYEofARvKcc8LfQE3h2yjNYzogyR+6AL36NWRPwnp+X1/UFbFl7ErLIQLvNVuK0vbVVQM/Bp5X8cMcBZAHsGnZPxSxIXwPvOOC4xY0mtbFfk+ymtTEFoF4FQkS4Ay04HCIdjssX/XXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549726; c=relaxed/simple;
	bh=b1hnziLLwC1ziiXDMX3YT+Ifx/yoFPiPUjCaOgLdNf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EButMnd36FB8yr0VkxXYkdh6Qg1OM+8nvWXS/tTOlkfz8vRfsXeQyiMkMEbGIYXrmZoGj3QNnQpF4VUZFep5shbHzk9dRDxaBDaTjJbacx1V/aGA1JO29f2l5JPrxhlCVLNr3e84deqR7FDbito7EXG/jB3agsPxC9vG2diZ9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qjKu+9ZW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cc7c1266063711f08eb9c36241bbb6fb-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dzn3KPVkY5CKPqLCw9mwkZHdcDl3t5MeFf7uK4V+q/U=;
	b=qjKu+9ZW6QPp+ek9B0L2WhP5XK/U11VkB2uBW2qpaiRxCFY4NX08Kj1+5r0GH6Ski/WIJNoAv3KinUNUuiSzNrj5KmGqmPA1WbeCUFhyBG9sSIZC/fl+Pxqlrr33gnPDXYr+VwV78sizgIAVvfUCuI9G8D04rPBliMndBT8fg2Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:8ebf1759-e52a-4bd5-920b-61271363162d,IP:0,UR
	L:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:307aa1c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cc7c1266063711f08eb9c36241bbb6fb-20250321
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1144991328; Fri, 21 Mar 2025 17:35:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 17:35:15 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 17:35:15 +0800
From: paul-pl.chen <paul-pl.chen@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<chunkuang.hu@kernel.org>, <angelogioacchino.delregno@collabora.com>
CC: <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
	<jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
	<singo.chang@mediatek.com>, <xiandong.wang@mediatek.com>,
	<sirius.wang@mediatek.com>, <paul-pl.chen@mediatek.com>,
	<sunny.shen@mediatek.com>, <fshao@chromium.org>, <treapking@chromium.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 03/15] dt-bindings: display: mediatek: add EXDMA yaml for MT8196
Date: Fri, 21 Mar 2025 17:33:32 +0800
Message-ID: <20250321093435.94835-4-paul-pl.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Paul-pl Chen <paul-pl.chen@mediatek.com>

Add mediatek,exdma.yaml to support EXDMA for MT8196.
The MediaTek display overlap extended DMA engine, namely
OVL_EXDMA or EXDMA, primarily functions as a DMA engine
for reading data from DRAM with various DRAM footprints
and data formats.

Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
---
 .../bindings/dma/mediatek,exdma.yaml          | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mediatek,exdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/mediatek,exdma.yaml b/Documentation/devicetree/bindings/dma/mediatek,exdma.yaml
new file mode 100644
index 000000000000..de7f8283bb48
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mediatek,exdma.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/mediatek,exdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek display overlap extended DMA engine
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description:
+  The MediaTek display overlap extended DMA engine, namely OVL_EXDMA or EXDMA,
+  primarily functions as a DMA engine for reading data from DRAM with various
+  DRAM footprints and data formats. For input sources in certain color formats
+  and color domains, OVL_EXDMA also includes a color transfer function
+  to process pixels into a consistent color domain.
+
+properties:
+  compatible:
+    const: mediatek,mt8196-exdma
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  mediatek,larb:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      A phandle to the local arbiters node in the current SoCs.
+      Refer to bindings/memory-controllers/mediatek,smi-larb.yaml.
+
+  iommus:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - mediatek,larb
+
+additionalProperties: false
+
+examples:
+  - |
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        disp_ovl0_exdma2: dma-controller@32850000 {
+            compatible = "mediatek,mt8196-exdma";
+            reg = <0 0x32850000 0 0x1000>;
+            clocks = <&ovlsys_config_clk 13>;
+            power-domains = <&hfrpsys 12>;
+            mediatek,larb = <&smi_larb0>;
+            iommus = <&mm_smmu 144>;
+            #dma-cells = <1>;
+        };
+    };
-- 
2.45.2


