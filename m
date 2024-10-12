Return-Path: <linux-kernel+bounces-362068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5673099B080
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50232848CF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C8126BFC;
	Sat, 12 Oct 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f+DeCIvd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38178A41;
	Sat, 12 Oct 2024 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705029; cv=none; b=ZC2r3NSvoKqIAN3bkhpjHgNKTd1uj/Qj91lL4z/5XytIz1wtsoJ4r9vWzsI6dHZLafzfPIEYyx6F4fur35n8T3Lng6l3yhJayUbpOevW5sFIkIIHBqfTufIODnoYzWqKvjRvVx9FTYp/WktsVBYjbld4GyDQlKwbRbShDszI/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705029; c=relaxed/simple;
	bh=2aWyOCTiycY0OHnMiy+jkUklLt62crYBJspTOZ/wcfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TfrMFQU18j4clzGb5OnsngF2VmWN6hR6o3lYLz9PZ5dX5EB7WnuTUZJeWIvCqMUOsuQEX0j97IgWh1DbAJvn70CKUAkaPXeZFisj1wMM2k6eTftH5jzZUWdr98tLjESJ3T9PAD8emNYUYZbOioDtOcrom2pSgDhdo9vnOYTMkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f+DeCIvd; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c51d082884d11ef88ecadb115cee93b-20241012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=c4LvdEEHLpX8RMbvMLOgpoWf9QYjGh9Wl1Flol3Dlpg=;
	b=f+DeCIvd6hWYZKDgMtH2QyYJSiwXdWwoKcqH2fUDZ7566oEM6EPi3zAvwKv/SUCxcsTztTazWO98jYAZA9rbmRB6pBOnDyIL9dzkLgP5BmFn8attcoSmTs9mY6K2CZFx1w99bK3x42b0tpfYBruL7OdiblKBdc/uUiL9MF65xXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:457bf41c-efe0-48e1-b103-206cfd7a29e3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:504ba906-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1c51d082884d11ef88ecadb115cee93b-20241012
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 923235726; Sat, 12 Oct 2024 11:50:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 12 Oct 2024 11:50:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 12 Oct 2024 11:50:22 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3] dt-bindings: phy: mediatek: tphy: add a property for power-domains
Date: Sat, 12 Oct 2024 11:50:16 +0800
Message-ID: <20241012035016.17667-1-macpaul.lin@mediatek.com>
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

Include the MediaTek TPHY in a power domain.  Add the 'power-domains'
property in the Device Tree (DT) Schema and set 'maxItems: 1'.

Also, include a reminder in the description of the 'power-domains'
property.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/mediatek,tphy.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

Changes for v2:
 - Add a reminder in description of 'power-domains' property.
 - Fix commit message from v1.

Changes for v3:
 - Use 'imperative mood' keyword in the prompt of chatGPT to refine the commit
   message.
 - Add 'Acked-by:' tag, thanks for the review and grammer tool sharing.

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 423b7c4e62f2..6be3aa4557e5 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -125,6 +125,16 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 28
 
+  power-domains:
+    description:
+      The TPHY of MediaTek should exist within a power domain. The
+      developer should be aware that the hardware design of MediaTek TPHY
+      does not require the addition of MTCMOS. If the power to the TPHY
+      is turned off, it will impact other functions. From the current
+      perspective of USB hardware design, even if MTCMOS is added to the
+      TPHY, it should remain always on.
+    maxItems: 1
+
 # Required child node:
 patternProperties:
   "^(usb|pcie|sata)-phy@[0-9a-f]+$":
-- 
2.45.2


