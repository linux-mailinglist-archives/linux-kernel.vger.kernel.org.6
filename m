Return-Path: <linux-kernel+bounces-381254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBD9AFC94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA60281A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5BB1D0E26;
	Fri, 25 Oct 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pBUzlrKo"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138F1B6CE4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845114; cv=none; b=JTxIvFLwt+rRftKksusRfrfOZPnnuDbcCow14eLjYmfWnmagp3oVwswIIYspN25jAOQTRYh6amftDQp0kq0Ec1cqodF8+JfA4gKxYe7ntS5uscsXsmH1OrnhZN032ub/k7+HnVgIPUGcGNBJyFMBYuPd4BIHq8kjtRMP3wKstTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845114; c=relaxed/simple;
	bh=Lqy0c5L+sF22fnFybm9hJPWiy6UqquTQHTZkRhXzEeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m11JlYUQSefVWwOhieZYufdssAD7IrF59Iz0XzViRHPYCVOguNaRbBZl+YxXUBlOwHOc+PME2WJh3cBJeeo28FkpBkJOlQt2AOiCuYbb3KzL6btxumP+NQ2Is6+JoydX48z4ZSRN3SHk9fAjj/ViapoJuWdvA1uMb9Zj1V/wYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pBUzlrKo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 932ee6e692ab11efbd192953cf12861f-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ulm1GdYn5AwzGJrnapuHvHX2NA5N+yc7mcixuW0PsW0=;
	b=pBUzlrKoUT13Vi8gE/TvGemhGlY2CmDFP9Of3OO3eaASNxI2ADP0b6MsDd+8mhLWUkW3nXNHDA1IWstFu393/Rjb+3R3B7obVrDJCTYoGF+3PmzC30Wwc1sdn28TZALZUr50c3QnzLuQ1qFwjsgq/ihvAMbazPu+NwQeOGflDW0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:034a39fa-362d-475e-8fd7-66b25daa858d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:bb9d192e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 932ee6e692ab11efbd192953cf12861f-20241025
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1012490295; Fri, 25 Oct 2024 16:31:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 16:31:45 +0800
Received: from mszsdclx1211.gcn.mediatek.inc (10.16.7.31) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 16:31:45 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
	<dmitry.osipenko@collabora.com>, <msp@baylibre.com>,
	<rex-bc.chen@mediatek.com>, <granquet@baylibre.com>, <peng.liu@mediatek.com>,
	<jitao.shi@mediatek.com>, <mac.shen@mediatek.com>,
	<liankun.yang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/3] drm/mediatek: Adjust bandwidth limit for DP
Date: Fri, 25 Oct 2024 16:28:29 +0800
Message-ID: <20241025083036.8829-4-liankun.yang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025083036.8829-1-liankun.yang@mediatek.com>
References: <20241025083036.8829-1-liankun.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.892200-8.000000
X-TMASE-MatchedRID: eEvvxGbtKJXqDJGloYB7/lu4M/xm4KZeB3WB/vm5tBhvOxpHnc6c8tAO
	OSAF0cTNjhjs4bjZeL6wUbC8TG29xsME2BsoiKJMQ4srjeRbxTZMkOX0UoduuQqiCYa6w8tvg7c
	fJQw9FseiXymrvf+Yd78x/CIirHX9UBXVAm5W8RB7k1ZHmKLF7dn+voDzU8zxVz8J52OVy+RtgT
	FkLUu6pv7wSJO97U5mdL6uYg+Eh8xlZ48frA+isodlc1JaOB1TfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTttrrTuahHzlFM7SgCXiCKPg0pokrqu76d3ChfGQlxUCGwlr1AK4SIq6umutRJso5Pd7HY
	8VpdQiO3FkU3l1TlG6F3Knlxd+sAvV1+6k7Vw+XyNp7g4PXe0BXsxz6ujBxUq1f8XSkHBUmNJXm
	EMVvLtpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.892200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FC8D13FAC6F2D1F2D2B6E2E03F161BD2D3BD61356F27743ED310C6690EE78ECF2000:8
X-MTK: N

By adjusting the order of link training and relocating it to HPD,
link training can identify the usability of each lane in the current link.

It also supports handling signal instability and weakness due to
environmental issues, enabling the acquisition of a stable bandwidth
for the current link. Subsequently, DP work can proceed based on
the actual maximum bandwidth.

It should training in the hpd event thread.
Check the mode with lane count and link rate of training.

Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
---
- Adjust DP training timing.
- Adjust parse capabilities timing.
- Add power on/off for connect/disconnect
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 37 +++++++++++++++++--------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index ae4807823a5c..e87f6f52bcce 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1873,6 +1873,7 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	struct mtk_dp *mtk_dp = dev;
 	unsigned long flags;
 	u32 status;
+	int ret;
 
 	if (mtk_dp->need_debounce && mtk_dp->train_info.cable_plugged_in)
 		msleep(100);
@@ -1891,9 +1892,28 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 			memset(&mtk_dp->info.audio_cur_cfg, 0,
 			       sizeof(mtk_dp->info.audio_cur_cfg));
 
+			mtk_dp->enabled = false;
+			/* power off aux */
+			mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+			       DP_PWR_STATE_BANDGAP_TPLL,
+			       DP_PWR_STATE_MASK);
+
 			mtk_dp->need_debounce = false;
 			mod_timer(&mtk_dp->debounce_timer,
 				  jiffies + msecs_to_jiffies(100) - 1);
+		} else {
+			mtk_dp_aux_panel_poweron(mtk_dp, true);
+
+			ret = mtk_dp_parse_capabilities(mtk_dp);
+			if (ret)
+				drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
+
+			/* Training */
+			ret = mtk_dp_training(mtk_dp);
+			if (ret)
+				drm_err(mtk_dp->drm_dev, "Training failed, %d\n", ret);
+
+			mtk_dp->enabled = true;
 		}
 	}
 
@@ -2060,16 +2080,6 @@ static const struct drm_edid *mtk_dp_edid_read(struct drm_bridge *bridge,
 
 	drm_edid = drm_edid_read_ddc(connector, &mtk_dp->aux.ddc);
 
-	/*
-	 * Parse capability here to let atomic_get_input_bus_fmts and
-	 * mode_valid use the capability to calculate sink bitrates.
-	 */
-	if (mtk_dp_parse_capabilities(mtk_dp)) {
-		drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
-		drm_edid_free(drm_edid);
-		drm_edid = NULL;
-	}
-
 	if (drm_edid) {
 		/*
 		 * FIXME: get rid of drm_edid_raw()
@@ -2263,13 +2273,6 @@ static void mtk_dp_bridge_atomic_enable(struct drm_bridge *bridge,
 
 	mtk_dp_aux_panel_poweron(mtk_dp, true);
 
-	/* Training */
-	ret = mtk_dp_training(mtk_dp);
-	if (ret) {
-		drm_err(mtk_dp->drm_dev, "Training failed, %d\n", ret);
-		goto power_off_aux;
-	}
-
 	ret = mtk_dp_video_config(mtk_dp);
 	if (ret)
 		goto power_off_aux;
-- 
2.45.2


