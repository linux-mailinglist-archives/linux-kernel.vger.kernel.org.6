Return-Path: <linux-kernel+bounces-239279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C29258F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D89E286EDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E81741D2;
	Wed,  3 Jul 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jlRa9r4L"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221A16F8FA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002797; cv=none; b=JF3+9lSE3hPS9hiB1PyVKm2C0aBZCJrxVyPQfLvWS4u0dk5pNhNmeb/pfh0VOX3zmWYFwYQg2FTOZcZCzZM+r2cWPb1XD6m2sLELD9iPgHwFv9ck7705cAMqLmmC68CzBfK/0PvIt6Q3rPkUxWoybdHDwrcTP5ykFWvFNyM3p/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002797; c=relaxed/simple;
	bh=S7OczQykOEVFXRxXRFk38EQDCKYFTVsN3+PhRpDjOvo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EPQ+UYnZzXSZnqnYpuYBnmdxYPHKfXYt7hH1RdS39kgj0TnU0ka8uMEEV1P3edeYWeEb4P83z15fGVcWl6Bb7XHsnwbcoB5AMoRXOEzKIGSrgqWO5qO3O5qyFmfnEuDKQDnzg84BQVrx88gZBslr8wuotrmSM4dx4oUgxBIAzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jlRa9r4L; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a55aca48392711ef99dc3f8fac2c3230-20240703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iQeVTtzgmCg1R84emw3yEtPy2VOguvtZOSyCu6KYw3k=;
	b=jlRa9r4LK6NO99wen73Bb47Bc6UmIr3rg1havqcFyP+22nVlO3nxtRpef9jHSllAQZe7kriAKJMnAoZVn5TlwQoCzimXBQoyH20SRS6F/oktefvq6ofxYYObcShJheMCFk2thJf4tdgxV7wlsF/VaNH/qTRexMHlBtP1ohEppgI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:6a03a49b-30af-4dbc-9c5c-f9c2726f5bd1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:0f64dc44-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a55aca48392711ef99dc3f8fac2c3230-20240703
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1780038264; Wed, 03 Jul 2024 18:33:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jul 2024 18:33:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jul 2024 18:33:09 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jeffrey Kardatzke
	<jkardatzke@google.com>
Subject: [PATCH] drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()
Date: Wed, 3 Jul 2024 18:33:08 +0800
Message-ID: <20240703103308.10198-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

In mtk_crtc_ddp_config(), mtk_crtc will use some configuration flags to
generate instructions to cmdq_handle, such as:
  state->pending_config
  mtk_crtc->pending_planes
  plane_state->pending.config
  mtk_crtc->pending_async_planes
  plane_state->pending.async_config

These configuration flags may be set to false when a GCE IRQ comes calling
ddp_cmdq_cb(). This may result in missing prepare instructions,
especially if mtk_crtc_update_config() with the flase need_vblank (no need
to wait for vblank) cases.

Therefore, use the mtk_crtc->config_updating flag set at the beginning of
mtk_crtc_update_config() to ensure that these configuration flags won't be
changed when the mtk_crtc_ddp_config() is preparing instructions.

Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 34 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 6f34f573e127..bc3bf0c3edd9 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -314,30 +314,32 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 
 	state = to_mtk_crtc_state(mtk_crtc->base.state);
 
-	state->pending_config = false;
+	if (!mtk_crtc->config_updating) {
+		state->pending_config = false;
 
-	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < mtk_crtc->layer_nr; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
-			struct mtk_plane_state *plane_state;
+		if (mtk_crtc->pending_planes) {
+			for (i = 0; i < mtk_crtc->layer_nr; i++) {
+				struct drm_plane *plane = &mtk_crtc->planes[i];
+				struct mtk_plane_state *plane_state;
 
-			plane_state = to_mtk_plane_state(plane->state);
+				plane_state = to_mtk_plane_state(plane->state);
 
-			plane_state->pending.config = false;
+				plane_state->pending.config = false;
+			}
+			mtk_crtc->pending_planes = false;
 		}
-		mtk_crtc->pending_planes = false;
-	}
 
-	if (mtk_crtc->pending_async_planes) {
-		for (i = 0; i < mtk_crtc->layer_nr; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
-			struct mtk_plane_state *plane_state;
+		if (mtk_crtc->pending_async_planes) {
+			for (i = 0; i < mtk_crtc->layer_nr; i++) {
+				struct drm_plane *plane = &mtk_crtc->planes[i];
+				struct mtk_plane_state *plane_state;
 
-			plane_state = to_mtk_plane_state(plane->state);
+				plane_state = to_mtk_plane_state(plane->state);
 
-			plane_state->pending.async_config = false;
+				plane_state->pending.async_config = false;
+			}
+			mtk_crtc->pending_async_planes = false;
 		}
-		mtk_crtc->pending_async_planes = false;
 	}
 
 	mtk_crtc->cmdq_vblank_cnt = 0;
-- 
2.18.0


