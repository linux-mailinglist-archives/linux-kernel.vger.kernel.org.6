Return-Path: <linux-kernel+bounces-570993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA0A6B7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC5B189AED4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DB322424D;
	Fri, 21 Mar 2025 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bJjPuu1K"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2141F4179;
	Fri, 21 Mar 2025 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549729; cv=none; b=imw8Mljwfgib0jFZmJ9+cpId92YUdL4jFflMbBxkpFOQ85ilkvjzrS95Zwz2kch8ntgKSGApuxAxLfs2vBFiGAUwPsgqHcxrb4JbuQlGkfllLRd3PqHLyUcezYODTBNIH4qX2WsglbRZhAaqREE5/OdiKyjFLup9uW2E7kEa/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549729; c=relaxed/simple;
	bh=73GXGFxaeBPPo8+fEqVk8a9nOISb/9EwFpRBvatG3SM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUzWfAtrTIlHcx6Cgx3sKFqnwsxEmJDsCuQstHyS2NLIYfCw6sdcouwKdZWpeqTZi7ttcxRvfWqRERNtu7p6M4qlMvAHciJely5unJaUujKcsu8WD6xWKW66WDvmbTnbjK8dGXbBxv6AF1MPryohUnECU+sunkANDsViLzPkyBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bJjPuu1K; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cef676d0063711f08eb9c36241bbb6fb-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5syZdBd1owRAm5PFPeWjVnHtHFq5EbDnkkIfl2ZC53M=;
	b=bJjPuu1KfEdlVyoQeRx6xI3xIl2VwcSsB4EIEIUgBQCCVDPKLS2kERGY29xW30HFlCrLjbPm0R6s1UFp2PKkWGgxc0lCgsBkhFj+VYsO1nGkVZG67OV5i9XvL5MzguMEaIGJ9yUjAxMJ9wvlGD3WFD+ozGbGX1UGI7ErPPc5zJI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b4a0a520-41db-458c-a18f-6072a9bd8836,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:0ef645f,CLOUDID:27f3e8fd-c03c-4d2b-a585-04cfa9287728,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cef676d0063711f08eb9c36241bbb6fb-20250321
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1734558228; Fri, 21 Mar 2025 17:35:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 17:35:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 17:35:19 +0800
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
Subject: [PATCH v2 04/15] dt-bindings: display: mediatek: add BLENDER yaml for MT8196
Date: Fri, 21 Mar 2025 17:33:33 +0800
Message-ID: <20250321093435.94835-5-paul-pl.chen@mediatek.com>
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

Add mediatek,blender.yaml to support BLENDER for MT8196.
MediaTek display overlap blender, namely OVL_BLENDER or BLENDER,
executes the alpha blending function for overlapping layers
from different sources.

Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>
---
 .../display/mediatek/mediatek,blender.yaml    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml
new file mode 100644
index 000000000000..23e274a49228
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,blender.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Display Overlap Blender
+
+maintainers:
+  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
+  - Philipp Zabel <p.zabel@pengutronix.de>
+
+description:
+  MediaTek display overlap blender, namely OVL_BLENDER or BLENDER,
+  executes the alpha blending function for overlapping layers
+  from different sources. This is the primary function of the
+  overlapping system.
+
+properties:
+  compatible:
+    const: mediatek,mt8196-blender
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
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
+        disp_ovl0_blender0: blender@328d0000 {
+            compatible = "mediatek,mt8196-blender";
+            reg = <0 0x328d0000 0 0x1000>;
+            clocks = <&ovlsys_config_clk 29>;
+        };
+    };
-- 
2.45.2


