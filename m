Return-Path: <linux-kernel+bounces-346939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884998CB3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F91C21B56
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AF1C2BF;
	Wed,  2 Oct 2024 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z1YxjTVO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE37C13D;
	Wed,  2 Oct 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835719; cv=none; b=iywkRHrl5Y5jNrn1R6HHbAsj+TqAe3PZf67uzbF62mOYBiDBlaJB3pTDwPvI7P9TOOY+HHrdPMjqshPY7Rd/tpR6hWhDsmWyeHOFaoON0WpA9hzLWTOjlvRaqQBB0ChCdgd0Nxlm1muidFn+TiZ0GRnH87MtTH1dJ0lrf2Wajic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835719; c=relaxed/simple;
	bh=fhz0xHuZEyTbL8Vj//X6AtNxs5H2LavLKwSUD0tf9SM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzjjAIPC2QvElqrhoqxgqMPMhSd0PvotZFe4Pv8FIaj6orRTVLaE+Ud4+0I6gmk7X832AZl7Z2QEUiNQ8GN5yrecABGlx4sSOF9ZhP5Mhdiy3KSvxEzu9Gd6lsrUPrYGwQ4S0Yhsco4ayJiOd9MtB+87yr/qgnKyNbbw0nq2ojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z1YxjTVO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 164d5f16806511efb66947d174671e26-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fPGZar9sjhXZt1snnZn3u5dXojBi5Z4anWFQOljWfHg=;
	b=Z1YxjTVObFjr3WYOOEeSWxEZSAXN1iTEMmWyC9gkpFsuz7/EMJzknhRbDeWFMAC6PMe4gY/ftBG5yvX+3B51Dy5REMvNOcCrCY2CXHTm4I0n+HKNmEQx721A7OALO1DTGZbskKM7H6IGujAUMD2o2MYptdl2BwzbXzH0Yt/pycc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0c4fb326-9c15-4e26-a19e-7bfd7f1a80f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2ebf2988-3a5d-4d9e-b012-e875acfb157d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 164d5f16806511efb66947d174671e26-20241002
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1675401133; Wed, 02 Oct 2024 10:21:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 19:21:51 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:21:51 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse mt8186-efuse in mt8188
Date: Wed, 2 Oct 2024 10:21:35 +0800
Message-ID: <20241002022138.29241-4-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241002022138.29241-1-pablo.sun@mediatek.com>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

mt8188 has the same GPU speed binning efuse field just
like mt8186, which requires post-processing to convert to the
bit field format specified by OPP table.

Add the binding for the compatible list:
  "mediatek,mt8188-efuse", "mediatek,mt8186-efuse"
so mt8188 uses the same conversion.

Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 32b8c1eb4e80..70815a3329bf 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -39,6 +39,10 @@ properties:
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
           - const: mediatek,efuse
+      - items:
+          - enum:
+              - mediatek,mt8188-efuse
+          - const: mediatek,mt8186-efuse
       - const: mediatek,mt8173-efuse
         deprecated: true
 
-- 
2.45.2


