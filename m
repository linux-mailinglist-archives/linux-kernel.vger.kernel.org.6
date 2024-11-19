Return-Path: <linux-kernel+bounces-414624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5B9D2B12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5601F22AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595391CDFD7;
	Tue, 19 Nov 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eOqDrsvo"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48613C83D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034230; cv=none; b=LTkHy7tV2y9VTTxyJUyOcf5Mp9O1xWxBxj0RA14OM4e6insie212O9Wx8LxLrI2fWkblzUtTiWfaDslPmzhkHcewBxb1wb07LXzQDe3O4ADMS4Ow79L6RnNrh744liwV77nDw6Ss85bf1JZqIJ0flFilJFeCQ0D13jreZk1xN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034230; c=relaxed/simple;
	bh=wrtO4MxmuJS7NBwVJWx6IbYj7VGhAZZY5mTxlymOzaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kc5ComnWy1BLjIWgDTn6WU9BSW+PQK380USgNMmEXSqXR1xlocObB4ciKKnu5ApefEZc0nVgd1DPYmz0bk40fjCCI0cl99+S237+MjQlmCC189DJlmEcIjCw7evpH+KrzkKJWWjHjNR1RgP9TRWrRXkmdtB35mm6+GyVpNszkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eOqDrsvo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 815fd0cca69411efbd192953cf12861f-20241120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hZTh8rx5jaZIu1JmpI1tEkcFD/loPvXAusXPhPMmzCQ=;
	b=eOqDrsvoXTr/gXyZ80o8bgCtG8w4FM0cs9z1zaoIrIy3nuY62RhH454pShgpz4qH7kXP55HiXfBHeSz6/w4+rhtHBLzUPoXYuDpc47Yjne5KdalE5a85NCWCnxe2YWzjsxcmenJZ+gS4l2OYXU0+E8NUnn2rw3Ju8bTJPP+XRpU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:442a7a26-9038-4f9f-946d-c46e7cd4bd48,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:432ee55c-f18b-4d56-b49c-93279ee09144,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 815fd0cca69411efbd192953cf12861f-20241120
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 106410271; Wed, 20 Nov 2024 00:37:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Nov 2024 00:37:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Nov 2024 00:37:00 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Sung <shawn.sung@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>
Subject: [PATCH v2] drm/mediatek: Move mtk_crtc_finish_page_flip() to ddp_cmdq_cb()
Date: Wed, 20 Nov 2024 00:36:58 +0800
Message-ID: <20241119163658.31405-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.676900-8.000000
X-TMASE-MatchedRID: 8X2PBhRYyqJSa+wzDj9ksangbqTYC4GHt07/cudGAnu6pZ/o2Hu2YQTm
	MKJk1G078AKeCfcnVWUQ3Uikp7+aiv+rTYoF7KeeL3ulviDkcK0kMBkEieOjZqpEew2E+iO0CV5
	GGxwE9Vw/rxdBgA9yKjyPpWYsRYoZAM0/G7XUdePil2r2x2PwtWKaLwu81+avv8D7QPW2jo9SXT
	dIhjp97ZbQdE1tv0FOgDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/sdkdKgE1mb6Vc4GDdqUVFL4VfS
	4blFaAN8O+qXv6oinTxvX8/wgJcbw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.676900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	422B217728EE5DF2CA476245A65AC1711B409E304104063999E2915D8500F1402000:8
X-MTK: N

mtk_crtc_finish_page_flip() is used to notify userspace that a
page flip has been completed, allowing userspace to free the frame
buffer of the last frame and commit the next frame.

In MediaTek's hardware design for configuring display hardware by using
GCE, `DRM_EVENT_FLIP_COMPLETE` should be notified to userspace after
GCE has finished configuring all display hardware settings for each
atomic_commit().

Currently, mtk_crtc_finish_page_flip() cannot guarantee that GCE has
configured all the display hardware settings of the last frame.
Therefore, to increase the accuracy of the timing for notifying
`DRM_EVENT_FLIP_COMPLETE` to userspace, mtk_crtc_finish_page_flip()
should be moved to ddp_cmdq_cb().

Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index eb0e1233ad04..0d57863c075a 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -109,15 +109,19 @@ static void mtk_crtc_finish_page_flip(struct mtk_crtc *mtk_crtc)
 static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 {
 	unsigned long flags;
+	struct drm_crtc *crtc = &mtk_crtc->base;
+	struct mtk_drm_private *priv = crtc->dev->dev_private;
 
 	drm_crtc_handle_vblank(&mtk_crtc->base);
 
-	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
-	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
-		mtk_crtc_finish_page_flip(mtk_crtc);
-		mtk_crtc->pending_needs_vblank = false;
+	if (priv->data->shadow_register) {
+		spin_lock_irqsave(&mtk_crtc->config_lock, flags);
+		if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
+			mtk_crtc_finish_page_flip(mtk_crtc);
+			mtk_crtc->pending_needs_vblank = false;
+		}
+		spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 	}
-	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
 }
 
 static void mtk_crtc_destroy(struct drm_crtc *crtc)
@@ -284,10 +288,8 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 	state = to_mtk_crtc_state(mtk_crtc->base.state);
 
 	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
-	if (mtk_crtc->config_updating) {
-		spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+	if (mtk_crtc->config_updating)
 		goto ddp_cmdq_cb_out;
-	}
 
 	state->pending_config = false;
 
@@ -315,10 +317,15 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 		mtk_crtc->pending_async_planes = false;
 	}
 
-	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
-
 ddp_cmdq_cb_out:
 
+	if (mtk_crtc->pending_needs_vblank) {
+		mtk_crtc_finish_page_flip(mtk_crtc);
+		mtk_crtc->pending_needs_vblank = false;
+	}
+
+	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
+
 	mtk_crtc->cmdq_vblank_cnt = 0;
 	wake_up(&mtk_crtc->cb_blocking_queue);
 }
-- 
2.43.0


