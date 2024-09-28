Return-Path: <linux-kernel+bounces-342559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A020F98904D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FA41F21C76
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5214A4C3;
	Sat, 28 Sep 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ox1FgKCF"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171804204B
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540159; cv=none; b=lG43iFvDpL9dTTt7P6zCgK77i3BNnzJbB+l3wBVcBOfoIjo/nv2dmwhnWsI/gvOnHIjAkazifm4dxcPk4k/BiFhQnDu80rBn0wg/kw7kxZIQhaGSyGCUJCqfoEOgHXq8eGCGkU3EcXw/cMsefRFeEFGgyamIIOVRXDxmkDiqooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540159; c=relaxed/simple;
	bh=np129mPOuxMf9RCAx8h8NDsluQ4SQKqyhuxGwEfneD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHZU397IVVk94J/EQXdj+MdAk3U/z+w3+1Y0PwLwuFxOWNyALD2rhRzLdkVNls0svZ5Hrn7STv69/lepsOByS1HfgtwItAe8QDwIAkTfMmZNpjLCAWv4VfzmyKRGuBOjuagtXfofARpAmdstYtgOLzUAklP0Yxyjd5wSDzftE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ox1FgKCF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eda3a5a07db411ef8b96093e013ec31c-20240929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1fg4x4oOTvxB7AG/qX4oBWGGAUKE9CklCiDdGYy60Hs=;
	b=ox1FgKCFRkElVHImgEwHzvSxTQUCwrnwVHBmHeAb0Ui0XuDDQMJd3gw/foQxb2pCL6jTg31iOxa7bCZvgfmVb3/Wx9RKhokjyW85sChz/egGB98ieFT3UAaX2+oWmZPK+NJiU35gic8/onXUuommeCNOY+WUKKtHw0brevs56W0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:95cb7213-cdfa-4793-b90a-3617a13bb089,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:6d31e9d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: eda3a5a07db411ef8b96093e013ec31c-20240929
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1449213069; Sun, 29 Sep 2024 00:15:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 29 Sep 2024 00:15:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 29 Sep 2024 00:15:48 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v8 3/3] drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs
Date: Sun, 29 Sep 2024 00:15:46 +0800
Message-ID: <20240928161546.9285-4-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
References: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.160200-8.000000
X-TMASE-MatchedRID: 6n1zk+md1nVe0FYiuVD/cPSZ/2axrnPBqQzUsXJNLuEGW3hFnC9N1dpn
	hpe4D1hOFzjo+TNgpJdApkCDZ8Q62p4dOTBCL+zXY1bQMCMvmn5ai3lnXr67vo5RXzY0MfgCcHj
	giTON9jJOFu8ssjxG8/FjRYaB9JwD8Jz+t9Z3vumQOktEo73GFLBH/AqZyGLZVI7KaIl9NhepxN
	4rruuBUzbBFkyI1h9EASo1XNPhrPpUaz8ayo4K5t8tWTI1R8epfS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtw1tMVU7ONTxZdXVSzJ2FUTDV2YxaJ/uB9SLGo0PDTfvZ2NYIRBdBWQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.160200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 309877D22123CB7B9B012E604611C53D6D931B53C855C1D65A75F72A528A62982000:8
X-MTK: N

Since some SoCs support premultiplied pixel formats but some do not,
the blend_modes parameter is added to mtk_plane_init(), which is
obtained from the mtk_ddp_comp_get_blend_modes function implemented
in different blending supported components.

The blending supported components can use driver data to set the
blend mode capabilities for different SoCs.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c             |  1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c         |  2 ++
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h         | 10 ++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h         |  2 ++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         |  7 +++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  7 +++++++
 drivers/gpu/drm/mediatek/mtk_ethdr.c            |  7 +++++++
 drivers/gpu/drm/mediatek/mtk_ethdr.h            |  1 +
 drivers/gpu/drm/mediatek/mtk_plane.c            | 15 +++++++--------
 drivers/gpu/drm/mediatek/mtk_plane.h            |  4 ++--
 10 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 175b00e5a253..b65f196f2015 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -913,6 +913,7 @@ static int mtk_crtc_init_comp_planes(struct drm_device *drm_dev,
 				BIT(pipe),
 				mtk_crtc_plane_type(mtk_crtc->layer_nr, num_planes),
 				mtk_ddp_comp_supported_rotations(comp),
+				mtk_ddp_comp_get_blend_modes(comp),
 				mtk_ddp_comp_get_formats(comp),
 				mtk_ddp_comp_get_num_formats(comp), i);
 		if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index be66d94be361..edc6417639e6 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -363,6 +363,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl = {
 	.layer_config = mtk_ovl_layer_config,
 	.bgclr_in_on = mtk_ovl_bgclr_in_on,
 	.bgclr_in_off = mtk_ovl_bgclr_in_off,
+	.get_blend_modes = mtk_ovl_get_blend_modes,
 	.get_formats = mtk_ovl_get_formats,
 	.get_num_formats = mtk_ovl_get_num_formats,
 };
@@ -416,6 +417,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor = {
 	.disconnect = mtk_ovl_adaptor_disconnect,
 	.add = mtk_ovl_adaptor_add_comp,
 	.remove = mtk_ovl_adaptor_remove_comp,
+	.get_blend_modes = mtk_ovl_adaptor_get_blend_modes,
 	.get_formats = mtk_ovl_adaptor_get_formats,
 	.get_num_formats = mtk_ovl_adaptor_get_num_formats,
 	.mode_valid = mtk_ovl_adaptor_mode_valid,
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index ecf6dc283cd7..39720b27f4e9 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -80,6 +80,7 @@ struct mtk_ddp_comp_funcs {
 	void (*ctm_set)(struct device *dev,
 			struct drm_crtc_state *state);
 	struct device * (*dma_dev_get)(struct device *dev);
+	u32 (*get_blend_modes)(struct device *dev);
 	const u32 *(*get_formats)(struct device *dev);
 	size_t (*get_num_formats)(struct device *dev);
 	void (*connect)(struct device *dev, struct device *mmsys_dev, unsigned int next);
@@ -266,6 +267,15 @@ static inline struct device *mtk_ddp_comp_dma_dev_get(struct mtk_ddp_comp *comp)
 	return comp->dev;
 }
 
+static inline
+u32 mtk_ddp_comp_get_blend_modes(struct mtk_ddp_comp *comp)
+{
+	if (comp->funcs && comp->funcs->get_blend_modes)
+		return comp->funcs->get_blend_modes(comp->dev);
+
+	return 0;
+}
+
 static inline
 const u32 *mtk_ddp_comp_get_formats(struct mtk_ddp_comp *comp)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 082ac18fe04a..04154db9085c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -103,6 +103,7 @@ void mtk_ovl_register_vblank_cb(struct device *dev,
 void mtk_ovl_unregister_vblank_cb(struct device *dev);
 void mtk_ovl_enable_vblank(struct device *dev);
 void mtk_ovl_disable_vblank(struct device *dev);
+u32 mtk_ovl_get_blend_modes(struct device *dev);
 const u32 *mtk_ovl_get_formats(struct device *dev);
 size_t mtk_ovl_get_num_formats(struct device *dev);
 
@@ -131,6 +132,7 @@ void mtk_ovl_adaptor_start(struct device *dev);
 void mtk_ovl_adaptor_stop(struct device *dev);
 unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev);
 struct device *mtk_ovl_adaptor_dma_dev_get(struct device *dev);
+u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
 const u32 *mtk_ovl_adaptor_get_formats(struct device *dev);
 size_t mtk_ovl_adaptor_get_num_formats(struct device *dev);
 enum drm_mode_status mtk_ovl_adaptor_mode_valid(struct device *dev,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 4bfed8a4c14f..703cd3f6c6d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -215,6 +215,13 @@ void mtk_ovl_disable_vblank(struct device *dev)
 	writel_relaxed(0x0, ovl->regs + DISP_REG_OVL_INTEN);
 }
 
+u32 mtk_ovl_get_blend_modes(struct device *dev)
+{
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+
+	return ovl->data->blend_modes;
+}
+
 const u32 *mtk_ovl_get_formats(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index c6768210b08b..bf2546c4681a 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -400,6 +400,13 @@ void mtk_ovl_adaptor_disable_vblank(struct device *dev)
 	mtk_ethdr_disable_vblank(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0]);
 }
 
+u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev)
+{
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
+
+	return mtk_ethdr_get_blend_modes(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0]);
+}
+
 const u32 *mtk_ovl_adaptor_get_formats(struct device *dev)
 {
 	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index d1d9cf8b10e1..0f22e7d337cb 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -145,6 +145,13 @@ static irqreturn_t mtk_ethdr_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+u32 mtk_ethdr_get_blend_modes(struct device *dev)
+{
+	return BIT(DRM_MODE_BLEND_PREMULTI) |
+	       BIT(DRM_MODE_BLEND_COVERAGE) |
+	       BIT(DRM_MODE_BLEND_PIXEL_NONE);
+}
+
 void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 			    struct mtk_plane_state *state,
 			    struct cmdq_pkt *cmdq_pkt)
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.h b/drivers/gpu/drm/mediatek/mtk_ethdr.h
index 81af9edea3f7..a72aeee46829 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.h
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.h
@@ -13,6 +13,7 @@ void mtk_ethdr_clk_disable(struct device *dev);
 void mtk_ethdr_config(struct device *dev, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+u32 mtk_ethdr_get_blend_modes(struct device *dev);
 void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 			    struct mtk_plane_state *state,
 			    struct cmdq_pkt *cmdq_pkt);
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 7d2cb4e0fafa..8a48b3b0a956 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -320,8 +320,8 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
-		   unsigned int supported_rotations, const u32 *formats,
-		   size_t num_formats, unsigned int plane_idx)
+		   unsigned int supported_rotations, const u32 blend_modes,
+		   const u32 *formats, size_t num_formats, unsigned int plane_idx)
 {
 	int err;
 
@@ -366,12 +366,11 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 	if (err)
 		DRM_ERROR("failed to create property: alpha\n");
 
-	err = drm_plane_create_blend_mode_property(plane,
-						   BIT(DRM_MODE_BLEND_PREMULTI) |
-						   BIT(DRM_MODE_BLEND_COVERAGE) |
-						   BIT(DRM_MODE_BLEND_PIXEL_NONE));
-	if (err)
-		DRM_ERROR("failed to create property: blend_mode\n");
+	if (blend_modes) {
+		err = drm_plane_create_blend_mode_property(plane, blend_modes);
+		if (err)
+			DRM_ERROR("failed to create property: blend_mode\n");
+	}
 
 	drm_plane_helper_add(plane, &mtk_plane_helper_funcs);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.h b/drivers/gpu/drm/mediatek/mtk_plane.h
index 5b177eac67b7..3b13b89989c7 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_plane.h
@@ -48,6 +48,6 @@ to_mtk_plane_state(struct drm_plane_state *state)
 
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
-		   unsigned int supported_rotations, const u32 *formats,
-		   size_t num_formats, unsigned int plane_idx);
+		   unsigned int supported_rotations, const u32 blend_modes,
+		   const u32 *formats, size_t num_formats, unsigned int plane_idx);
 #endif
-- 
2.43.0


