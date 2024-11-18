Return-Path: <linux-kernel+bounces-412372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE89D0830
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E251F21A48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4C558A5;
	Mon, 18 Nov 2024 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T2cO3pTv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E91C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731901018; cv=none; b=NLiFRPsaE1sOIXJrV37nTJoDipG7s8GglKrzEs/rEuiFBpEkkxrZmiK584jahWsvcmT/vnS1TpY1fpRzjiDBF9DzkJp8pZZ8uI9XrzmY6GGhgM7Br18qBisUFJZqaVZmAbLcGTkKBgZfV9wxPYdAlrFf/zKlblVk83PH8IAOw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731901018; c=relaxed/simple;
	bh=iElBa6zH1XjBw5XYi6z5Uq7P3mbIt+RbB8vGbC/xtlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZedEZ5Kg9/KpWwwAGzG5Rp/YAcoHRV5Jf+3yNj+ma3FrYYdwwCnnOXz7QqeC+qJq+td3Z8XD2pPrOPi4pjbGHqsuje4DUDItXnghzXzitoi59VguluhXbmYKK+/TVqBdtYq4IuaWCcDI90xNtS+7H2/ALjXbGG2cDxJX3VfRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T2cO3pTv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58ed2766a55e11ef99858b75a2457dd9-20241118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cY3M3paXFjVnDGLWR8LPQPj0vfaZVh7x56FlJ8YtW2M=;
	b=T2cO3pTv2a0Qc1O8poWjwhgLhb2ULeXeLuUDMNeAPyrjtafIBDHAHpJKGBrL+nn1MvCQ7+PimcKI3UJswvVgHPGade8MiVhEdE3Zpab36IqI9grdn+WwAUOiv2gCa8p4GfScrYzo/AACcft26uY8Eb/H33ssvzgQ0pYR6/i3WWY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.43,REQID:e278a9e6-4638-4b23-9043-b0752622208a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ce19b8a,CLOUDID:1f4e3c07-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 58ed2766a55e11ef99858b75a2457dd9-20241118
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 655924059; Mon, 18 Nov 2024 11:36:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Nov 2024 11:36:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Nov 2024 11:36:48 +0800
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
Subject: [PATCH] drm/mediatek: Add no pending_planes flag checking for mtk_crtc_finish_page_flip()
Date: Mon, 18 Nov 2024 11:36:46 +0800
Message-ID: <20241118033646.31633-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.865100-8.000000
X-TMASE-MatchedRID: 7f0W3vGS/J7ww+sel1EBgVPjo7D4SFg4uoYFb0nRiqP82ks92f+GmsB6
	rnzzylDrRB4o3Hb/MDAMSPrY6IbTu7gFJkVTA0wMliwpJdZauwcrHkgIan9a0QLlYq1KzQi/vFf
	PytWHA2khXi7xgp14qwG2ORx9Eyap3CtEsOTZxuKO0rt0LpQGeX0tCKdnhB589yM15V5aWpj6C0
	ePs7A07YFInLyeDAoZT/btC4l4MdyAqm8NWtwXUqO4Pry+YzMezUn+SItISnpfe/9937fRFg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.865100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8A16D88748D68549294F33BBDA61DB44C457C9A4610B3EA90DFB2FE95C43F3332000:8
X-MTK: N

mtk_crtc_finish_page_flip() is used to notify the page flip that has
been completed to the userspace, so userspace can free the frame buffer
of the last frame and commit the next frame.

However, mtk_crtc_finish_page_flip() cannot guarantee the GCE has
configured all the display hardware settings of the last frame.
This may cause the display hardware to still access the last frame
buffer released by the userspace.

So add the checking condition of no pending_plens flags to make sure
GCE has executed all the pending planes configuration.

Fixes: 7f82d9c43879 ("drm/mediatek: Clear pending flag when cmdq packet is done")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index eb0e1233ad04..b03b9102ff90 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -113,7 +113,8 @@ static void mtk_drm_finish_page_flip(struct mtk_crtc *mtk_crtc)
 	drm_crtc_handle_vblank(&mtk_crtc->base);
 
 	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
-	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank) {
+	if (!mtk_crtc->config_updating && mtk_crtc->pending_needs_vblank &&
+	    !mtk_crtc->pending_planes) {
 		mtk_crtc_finish_page_flip(mtk_crtc);
 		mtk_crtc->pending_needs_vblank = false;
 	}
-- 
2.43.0


