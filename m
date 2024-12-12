Return-Path: <linux-kernel+bounces-443308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5E9EEC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CD9283245
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32C21764F;
	Thu, 12 Dec 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XpWhxW54"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD36F2FE;
	Thu, 12 Dec 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017639; cv=none; b=cHTD08vqOv2BZZITg9JXCwPMmzcef39Sr97Y4gpuSBCEdG56C9a6PDr41RyVGZWW6oXTFee+grhL5bKS1AuS4pKH1CdiarDgurBKYJ/YpiM9mTXBopTxkKWOTYeJx0nM6q7aESHfy1cvL9qA0eixtoW/P4XdPkiScFPrBNZUk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017639; c=relaxed/simple;
	bh=WQUhiJl+EHir6YtY0sMt1LUzPhAoyXASWeml4Li9qY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB4T51kISsR/lVFMB76QZAOXCiORI8TPhcJxbS3BIT8vV7PRfoiYkj2XwKcCXToRQgq/cd1OyWjWYPRQd15bm8+8ME4qzLE8O4Z30sqm2HywxvaUiL8sZIMKo3qZ0uv4wmOUPu7JzDNZswFr51iO0q/DjYwyTtMSKSgEs+fcixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XpWhxW54; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7bfa123eb89e11efbd192953cf12861f-20241212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lbb+BF8rXOcsled1oWe4stPtecQkoM6M2iGQzUBZ20E=;
	b=XpWhxW54klnIXCjAyLGAe5Ui/9zTDPHR3/MkyDq7+owMNhZ8PCDnDvaeZhWNYU9ksJw5UOEW51Ep7E10AZk821wffgNVhFlvXTcUaWPnz42AerdV1l95w8T24gpxCDbc6d64xsUAjDKnG8k0grbo1kUQ9iMe9dj9f8o0rGO8zac=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e770d899-018c-4903-9d8d-01d3db3409f0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:6e01df3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7bfa123eb89e11efbd192953cf12861f-20241212
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1224595392; Thu, 12 Dec 2024 23:33:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Dec 2024 23:33:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Dec 2024 23:33:46 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>
Subject: [PATCH 1/2] dt-bindings: display: mediatek: ovl: Modify rules for MT8195/MT8188
Date: Thu, 12 Dec 2024 23:33:43 +0800
Message-ID: <20241212153344.27408-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241212153344.27408-1-jason-jh.lin@mediatek.com>
References: <20241212153344.27408-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.136400-8.000000
X-TMASE-MatchedRID: zCCEK6DgsdBTeZCGZ2HhGPSZ/2axrnPBkos2tunL8DRh2fnHe1cil0fp
	kQx2u0Ks+sZ43y9or/yQgj4GwqRgEJH0YXYnbGozFEUknJ/kEl7dB/CxWTRRu+rAZ8KTspSzhP2
	jHO9YjNgLjliWD7ttutbT5Scckb0uakZ7kncXBFBwiBREWkL9ZuSf0rVZxcGVbekdSZ/VG9prda
	hWPN1vM5s/h019t4TeF0aD5ljt43pMcHZD6gqu7wxMjfifIXfowkvVoA11Twp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.136400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FFC1D25952B8A49252E5022CAE31CDDED0172731751D266829B17250F15102BC2000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Modify rules for both MT8195 and MT8188.
Hardware capabilities include color formats and AFBC are
changed since MT8195, stop using the settings of MT8183.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 .../bindings/display/mediatek/mediatek,ovl.yaml           | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 9ea796a033b2..0ace12bbb623 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -36,16 +36,14 @@ properties:
           - enum:
               - mediatek,mt6795-disp-ovl
           - const: mediatek,mt8173-disp-ovl
-      - items:
-          - enum:
-              - mediatek,mt8188-disp-ovl
-              - mediatek,mt8195-disp-ovl
-          - const: mediatek,mt8183-disp-ovl
       - items:
           - enum:
               - mediatek,mt8186-disp-ovl
               - mediatek,mt8365-disp-ovl
           - const: mediatek,mt8192-disp-ovl
+      - items:
+          - const: mediatek,mt8188-disp-ovl
+          - const: mediatek,mt8195-disp-ovl
 
   reg:
     maxItems: 1
-- 
2.43.0


