Return-Path: <linux-kernel+bounces-356229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A126A995E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E751C214A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4613BADF;
	Wed,  9 Oct 2024 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uQKQ8pHw"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDD10FF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445615; cv=none; b=ntWuPT60IX8UufgXTc6oxKWt8kR6Zlpv5boKGiaDPXjgQ5P9UygkzT+aPsVtymR0K0Rjwcm9TrJPCy3OEjI0Ib2i/0gI+8UqhEP338tOSDmWzBatWFL4mwm3b4SVHHoAfooHAfJ+oLqn+FWi20n0l8MP6t+aVO31yX0r3kZnOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445615; c=relaxed/simple;
	bh=cWUbYayEOXjXIfFfU8pWcE/o8kS4ldo4BvR+pBzKIYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsR9csWzyKD4G/ZqYEKVuk3sANFtHx7ZsBUBUObxNIVPt9UvAXoIORtEDt7km/ZhmG+3q6xb5RUpAxLpmHSvWfkebhV746pJj0xBh2i6usmBFrG7hEG2NnhLTC0RvYbVkAhDSWb72GFJBlWxXe3Qo41WXqlUeMpuxuNeAmPGIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uQKQ8pHw; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1c88ff5285f111ef88ecadb115cee93b-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=47Q10FQD37kvBYq5NBMe/5HrBX25A4BKbucRKWZR9Y4=;
	b=uQKQ8pHwF9MgOuODw6HILEgn9HDgNr5T4snjRuYTE1gzLCT80O5FDNpdwTIYvv5qbUe02Sx14yCNxC7We1ZUPYksjqOmcV/fHxHHsn36A4nKnByNqD/EvcwE+mp10TNCYrNARYUA13dGEPIinCsIwyO+aUB090qR10py5LoZh+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f71c7060-7ed9-41ee-acbd-a58548aee831,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:10a8f940-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1c88ff5285f111ef88ecadb115cee93b-20241009
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 897258336; Wed, 09 Oct 2024 11:46:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 11:46:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 11:46:47 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Adam Thiede <me@adamthiede.com>, Yassine Oudjana
	<yassine.oudjana@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, Alper Nebi Yasak
	<alpernebiyasak@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v11 2/5] drm/mediatek: ovl: Refine ignore_pixel_alpha comment and placement
Date: Wed, 9 Oct 2024 11:46:43 +0800
Message-ID: <20241009034646.13143-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
References: <20241009034646.13143-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Refine the comment for ignore_pixel_alpha flag and move it to
if(state->fb) statement to make it less conditional.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 047cd1796a51..0d3a9c5e8d26 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -481,16 +481,16 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 		 */
 		if (blend_mode || state->base.fb->format->has_alpha)
 			con |= OVL_CON_AEN;
-	}
 
-	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
-	 * can be ignored, or OVL will still read the value from memory.
-	 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
-	 * affect the result. Therefore we use !has_alpha as the condition.
-	 */
-	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
-	    blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
-		ignore_pixel_alpha = OVL_CONST_BLEND;
+		/*
+		 * Although the alpha channel can be ignored, CONST_BLD must be enabled
+		 * for XRGB format, otherwise OVL will still read the value from memory.
+		 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
+		 * affect the result. Therefore we use !has_alpha as the condition.
+		 */
+		if (blend_mode == DRM_MODE_BLEND_PIXEL_NONE || !state->base.fb->format->has_alpha)
+			ignore_pixel_alpha = OVL_CONST_BLEND;
+	}
 
 	if (pending->rotation & DRM_MODE_REFLECT_Y) {
 		con |= OVL_CON_VIRT_FLIP;
-- 
2.43.0


