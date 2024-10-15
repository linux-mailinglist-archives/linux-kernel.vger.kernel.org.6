Return-Path: <linux-kernel+bounces-366333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BEE99F3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B3D1F23F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071131FAEF4;
	Tue, 15 Oct 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ej+nY04I"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4B1D514C;
	Tue, 15 Oct 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012880; cv=none; b=KWVUXGNe0G1C3Br6w4+1qdefyk797CuhIkiYod0JqW6cZnzEds1qzQZ1VuTh44rYT6OuHdplGrqENivU+NPY+BztEIg+kVQxSS/twWmkIUsXbPqD46ASNyb2sTybA4IwlorFPAL+dS9NsZpyLP7JTs7EtnKj+JThjGnPvV4nd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012880; c=relaxed/simple;
	bh=uKJzvqj7/K5tLqiIgSmzqrN6PNrCa383y+f40hKyARE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GagxQHaOBINf/wRL/SByYEc6uNhQfXD3ncRAY9lcmAsqXvLelAi0H9mzQm9uQPsQf7PQvnnIj7D9SV16k6TA9XDoFvdaY5AY+wUbO+ImVR5q63baEX+naPp8BAlPvNcAZZ06ad93C46DJ0zO5KV2WVyMV6gz3teb+cAjX7Il07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ej+nY04I; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dceedc6c8b1911ef88ecadb115cee93b-20241016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UgTpErnoeVYsYbEDorkXZU0hq3Q/BVcz0mstioX+jM4=;
	b=Ej+nY04IFS+TRicSyAf/YSCnb20JGr/n3FdWOmij/o1+4M0WVuN5zO7HB89fRhsLTYBCSob3UJOOVq/MB7dPVtkKAEYGHYigs+AolsZfbaX6YtMvXSPPeXOGgeJPee601F+V5WCFJzZwwkHO5oYvkgKL4+Jn51mZiR14J47jx0E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2172f444-70e0-4919-8068-9a2a274b83a0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e2e9d406-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dceedc6c8b1911ef88ecadb115cee93b-20241016
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 944089615; Wed, 16 Oct 2024 01:21:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 16 Oct 2024 01:21:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 16 Oct 2024 01:21:03 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, ChiYuan Huang
	<cy_huang@richtek.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>
Subject: [PATCH] dt-bindings: usb: mtu3: add mediatek,usb3-drd property
Date: Wed, 16 Oct 2024 01:21:00 +0800
Message-ID: <20241015172100.15150-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.054700-8.000000
X-TMASE-MatchedRID: GIpmbigRs3axuuum/MWy74sKNaNh88CQtMSM1a+1JW9+YesuCgkiXBVZ
	MOF9O5JogqVqNSWEmVr78dnxIA7Z1wzyMxeMEX6wFEUknJ/kEl7dB/CxWTRRuwihQpoXbuXF8nO
	jarwxetI07sAoSbfGL3O7+vMntQJx2pS1dNcT8ZTzc1eWqu+S9uyQAm3LvZdIuiYLxCZ6sl6ocU
	Ze0b27L2lQnEYqaE9qaaeeX2Q5bK9+HGPweyal2mGdUezV59DHQZpgl3CshRSeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.054700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: DA6EAF070114F080FC4D484CB9330DF6C2414915C8C698786916A40959916CCC2000:8
X-MTK: N

Add optional 'mediatek,usb3-drd' property to MediaTek MTU3 DT Schema.
This flag specify whether it is a USB3 Dual-role device hardware.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index d4e187c78a0b..1e70af0dac82 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -155,6 +155,12 @@ properties:
       property is used. See graph.txt
     $ref: /schemas/graph.yaml#/properties/port
 
+  mediatek,usb3-drd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Specify whether it is a USB3 Dual-role device hardware.
+    type: boolean
+
   enable-manual-drd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.45.2


