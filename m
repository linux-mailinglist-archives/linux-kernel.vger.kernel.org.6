Return-Path: <linux-kernel+bounces-521221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF1A3B8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2826C189D18E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F01E0489;
	Wed, 19 Feb 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tmsH5njP"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279111DFE0B;
	Wed, 19 Feb 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956868; cv=none; b=OiP6UdMGquSbSVWbUmQnNLKB+LxUKRWi+VaIxC+DMUbMUne9tEmuaQ5avHBdWZPlkk+5fqQMq28l8oLQMIBJd252FrC5GyWU9NBh94IFnoJ6cpGSjWLV/ueRLNVelgcJtSNco8STMlazi0jEPOqO6lxIZQSiVylGAqLt2elZnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956868; c=relaxed/simple;
	bh=bG5zCfj+CGUvK1dTpoNZAZ23G+6Sku8PqiULTTyuOGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuwPv0dv/XeTpqMBqvHEYe1Xaa026hal1oaLykiyTLYms/X8RIbXWRN/pVwnmijBmKuMcb93gdxGFGgv1t798GsYhaAN42F3T18SXHevpx+PKdxxwGkrBMi4fgYdecs6pAFKsopvxEPUQI0bj2FjF65zT6fPgEyTJDayq1qgyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tmsH5njP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d58151f2eea211efaae1fd9735fae912-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ojz46lwYrvC+/B96oirWUt9+aNCFGHjtvSOr+aVZyPo=;
	b=tmsH5njPU/sbbKgGbGgDtd6N6jcoMJI/K3LQB3sSNiBbikEpAaC2kS6VjWH001pgnHLHainlMQX8d6Eagdw52sR3qoc15UjGGOVlMf8cbI7DqDLm42Jjt7HuMOSn4D8SOjj6T0/jgkmFfAVmMX/zenUlbYXZ0cT5C/p9AmBubKM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:68169584-d22d-47b8-9084-39b50c05f11e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:9df8fe28-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d58151f2eea211efaae1fd9735fae912-20250219
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 844446571; Wed, 19 Feb 2025 17:21:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 17:20:59 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 17:20:58 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>, CK Hu <ck.hu@mediatek.com>, Hsin-Yi Wang
	<hsinyi@chromium.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jay Liu
	<jay.liu@mediatek.com>
Subject: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Date: Wed, 19 Feb 2025 17:20:34 +0800
Message-ID: <20250219092040.11227-2-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20250219092040.11227-1-jay.liu@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add CCORR component support for MT8196.

CCORR is a hardware module that optimizes the visual effects of
images by adjusting the color matrix, enabling features such as
night light.

The 8196 hardware platform includes two CCORR (Color Correction) units.
However, the `mtk_ccorr_ctm_set` API only utilizes one of these units.
To prevent the unused CCORR unit from inadvertently taking effect,
we need to block it by adding mandatory_ccorr flag in the driver_data.

Signed-off-by: Jay Liu <jay.liu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c   |  3 ++-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index edc6417639e6..d7e230bac53e 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -457,7 +457,8 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_DRM_ID_MAX]
 	[DDP_COMPONENT_AAL0]		= { MTK_DISP_AAL,		0, &ddp_aal },
 	[DDP_COMPONENT_AAL1]		= { MTK_DISP_AAL,		1, &ddp_aal },
 	[DDP_COMPONENT_BLS]		= { MTK_DISP_BLS,		0, NULL },
-	[DDP_COMPONENT_CCORR]		= { MTK_DISP_CCORR,		0, &ddp_ccorr },
+	[DDP_COMPONENT_CCORR0]		= { MTK_DISP_CCORR,		0, &ddp_ccorr },
+	[DDP_COMPONENT_CCORR1]		= { MTK_DISP_CCORR,		1, &ddp_ccorr },
 	[DDP_COMPONENT_COLOR0]		= { MTK_DISP_COLOR,		0, &ddp_color },
 	[DDP_COMPONENT_COLOR1]		= { MTK_DISP_COLOR,		1, &ddp_color },
 	[DDP_COMPONENT_DITHER0]		= { MTK_DISP_DITHER,		0, &ddp_dither },
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 10d60d2c2a56..94e82b3fa2d8 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -31,11 +31,13 @@
 
 struct mtk_disp_ccorr_data {
 	u32 matrix_bits;
+	enum mtk_ddp_comp_id mandatory_ccorr;
 };
 
 struct mtk_disp_ccorr {
 	struct clk *clk;
 	void __iomem *regs;
+	enum mtk_ddp_comp_id comp_id;
 	struct cmdq_client_reg cmdq_reg;
 	const struct mtk_disp_ccorr_data	*data;
 };
@@ -115,6 +117,9 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	if (!blob)
 		return;
 
+	if (ccorr->comp_id != ccorr->data->mandatory_ccorr)
+		return;
+
 	ctm = (struct drm_color_ctm *)blob->data;
 	input = ctm->matrix;
 
@@ -154,6 +159,7 @@ static int mtk_disp_ccorr_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_disp_ccorr *priv;
 	int ret;
+	enum mtk_ddp_comp_id comp_id;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -169,6 +175,14 @@ static int mtk_disp_ccorr_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->regs),
 				     "failed to ioremap ccorr\n");
 
+	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_CCORR);
+	if (comp_id < 0) {
+		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
+		return comp_id;
+	}
+
+	priv->comp_id = comp_id;
+
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
 	if (ret)
@@ -192,10 +206,12 @@ static void mtk_disp_ccorr_remove(struct platform_device *pdev)
 
 static const struct mtk_disp_ccorr_data mt8183_ccorr_driver_data = {
 	.matrix_bits = 10,
+	.mandatory_ccorr = DDP_COMPONENT_CCORR0,
 };
 
 static const struct mtk_disp_ccorr_data mt8192_ccorr_driver_data = {
 	.matrix_bits = 11,
+	.mandatory_ccorr = DDP_COMPONENT_CCORR0,
 };
 
 static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] = {
-- 
2.18.0


