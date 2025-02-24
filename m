Return-Path: <linux-kernel+bounces-528184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD785A4149E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC17A5039
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9561A705C;
	Mon, 24 Feb 2025 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ejF4qh/6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFFEEA8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373988; cv=none; b=aw3UyhcdqsOIJj8kScSJMWj/g8HLDFvZ7oGWQ27q+u3KGiPSVIQ+0je8OeZaEHW8lkWznnwxnLBeQVdzdosxzq2eq6lmw4IXvsfxDWGACXWSanqzo78dNNtpcr4+QuccUHjTIyt0csdhb3G6zPMT6DrAEgH/TKCjlIxyAneA3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373988; c=relaxed/simple;
	bh=41vU5dkvy12qCzhdsgdHfY8GQ1ok9vAv2tmZe94hMDM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jti8DXvxe80mDUvp01659sfCPsQ2DT3t0BKOOpfu1N7VF4AQf5xougIk30XrAa4kQXyMhFGetiN7X21wROFv8dnC1cUc1WgHU8Pox58AM4TCUsy8zsfnpGcHeyPWx1O2qTfzPOFNPVfQ4HE6b7WPx3Dns286gjQqW7D11srzg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ejF4qh/6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 060c2a58f26e11ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0Xf3zNMSr+yu5a58iIvJf4uTceCQidvq4R1Svcp2yks=;
	b=ejF4qh/68ugQBmFvcgRXHLQbCmqqvdLcaRpl1lDwa85n4hQqyccfeUxHLUMm3zxeUPzSnC4KiNI6v6NcpCTtWvyrbCOVyd0lj9of+QOsTfe1teD8YJPXBqSUdCdGGT+pKJj08Y7tmt+upGFdCIYilxS+eqpJQaS8rVFPhL9nphA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:686a94d8-87d3-402d-8a1a-034c65dfa4ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:b3e978a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 060c2a58f26e11ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1748444666; Mon, 24 Feb 2025 13:13:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 13:13:02 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 13:13:02 +0800
From: Jason-JH Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Nancy Lin
	<nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Yongqiang
 Niu <yongqiang.niu@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>,
	Xavier Chang <xavier.chang@mediatek.com>, Fei Shao <fshao@chromium.org>,
	Chen-yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] drm/mediatek: Fix config_updating flag never false when no mbox channel
Date: Mon, 24 Feb 2025 13:12:21 +0800
Message-ID: <20250224051301.3538484-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

When CONFIG_MTK_CMDQ is enabled, if the display is controlled by the CPU
while other hardware is controlled by the GCE, the display will encounter
a mbox request channel failure.
However, it will still enter the CONFIG_MTK_CMDQ statement, causing the
config_updating flag to never be set to false. As a result, no page flip
event is sent back to user space, and the screen does not update.

Fixes: da03801ad08f ("drm/mediatek: Move mtk_crtc_finish_page_flip() to ddp_cmdq_cb()")
Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 5674f5707cca..cfc4867296b8 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -620,13 +620,14 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 
 		mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle);
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
+		goto update_config_out;
 	}
-#else
+#endif
 	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = false;
 	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
-#endif
 
+update_config_out:
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
-- 
2.43.0


