Return-Path: <linux-kernel+bounces-329591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25BC97934F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A389283B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 20:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE012D744;
	Sat, 14 Sep 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oXj/Rwd4"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52E34CDD
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726345114; cv=none; b=bOAWX/O448CI3Cf1RS8eBtnnk8e6IscYZYsP33YxnhCvfKv87LGbCyzxab3CaXPM39ttynH4qvhYM5ufEaixRd1XEAqKX3ZBehIGziPbOZ1sG73uuFS5b3tkMqbu7LmZ3GBHw2qKjSWcVxi8Hvhw/gH/C3oX/TMmUWJJCneihdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726345114; c=relaxed/simple;
	bh=ZExCQHKIi7J6n0bdDKpGDjVFqGq2FSEwpOYmBhkdlDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+dUJSI/xd376x6cldvm/sSxSmMYCn06sviuyzPXf3jUw1JjuuOFOtb2c4RIOjNVZji1e/bPC+w1Zi92dtA+TQQCtdRDMFSORDjaUV29IDpOxkpb09z6QZWuToB/lXpWovkbrgxtruQKrqjf47RuhHjiZrwD2lgBiuWJNeCZND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oXj/Rwd4; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7cdbbbd472d611ef8b96093e013ec31c-20240915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KzEvm60ursdehxva7VL1w/guECU2w+ClPXr73nuhGlM=;
	b=oXj/Rwd4KrxNPAFdYgOhJTPGOy+yk0VmHdzQq+YpapcFLqdlqwOzVnx/cm/lobD6ZFSIFWzNxc+fuzyfew7lpwWj9941BpAayorsYgGHC3gOuupmFNXDzhCI6V5J+8tkA1NuVyLcVTv20aTFBOSpLgFJ77zwUTCLzmNAkI4EdWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:868cfbc3-3385-4275-9267-62afd586378d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:cea637d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7cdbbbd472d611ef8b96093e013ec31c-20240915
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 564874747; Sun, 15 Sep 2024 04:18:21 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 15 Sep 2024 04:18:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 15 Sep 2024 04:18:20 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] drm/mediatek: ovl: Add fmt_support_man for MT8192 and MT8195
Date: Sun, 15 Sep 2024 04:18:19 +0800
Message-ID: <20240914201819.3357-1-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

OVL_CON_CLRFMT_MAN is an configuration for extending color format
settings of DISP_REG_OVL_CON(n).
It will change some of the original color format settings.

Take the settings of (3 << 12) for example.
- If OVL_CON_CLRFMT_MAN = 0 means OVL_CON_CLRFMT_RGBA8888.
- If OVL_CON_CLRFMT_MAN = 1 means OVL_CON_CLRFMT_PARGB8888.

Since OVL_CON_CLRFMT_MAN is not supported on previous SoCs,
It breaks the OVL color format setting of MT8173.
So add fmt_support_man to the driver data of MT8192 and MT8195
to solve the downgrade problem.

Fixes: a3f7f7ef4bfe ("drm/mediatek: Support "Pre-multiplied" blending in OVL")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 28 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 89b439dcf3a6..aa575569f996 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -70,10 +70,18 @@
 #define OVL_CON_CLRFMT_UYVY	(4 << 12)
 #define OVL_CON_CLRFMT_YUYV	(5 << 12)
 #define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
-#define OVL_CON_CLRFMT_PARGB8888 ((3 << 12) | OVL_CON_CLRFMT_MAN)
-#define OVL_CON_CLRFMT_PABGR8888 (OVL_CON_CLRFMT_PARGB8888 | OVL_CON_RGB_SWAP)
-#define OVL_CON_CLRFMT_PBGRA8888 (OVL_CON_CLRFMT_PARGB8888 | OVL_CON_BYTE_SWAP)
-#define OVL_CON_CLRFMT_PRGBA8888 (OVL_CON_CLRFMT_PABGR8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_PARGB8888(ovl)	((ovl)->data->fmt_support_man ? \
+					((3 << 12) | OVL_CON_CLRFMT_MAN) : \
+					OVL_CON_CLRFMT_ABGR8888)
+#define OVL_CON_CLRFMT_PABGR8888(ovl)	((ovl)->data->fmt_support_man ? \
+					(OVL_CON_CLRFMT_PARGB8888 | OVL_CON_RGB_SWAP) : \
+					OVL_CON_CLRFMT_ABGR8888)
+#define OVL_CON_CLRFMT_PBGRA8888(ovl)	((ovl)->data->fmt_support_man ? \
+					(OVL_CON_CLRFMT_PARGB8888 | OVL_CON_BYTE_SWAP) : \
+					OVL_CON_CLRFMT_BGRA8888)
+#define OVL_CON_CLRFMT_PRGBA8888(ovl)	((ovl)->data->fmt_support_man ? \
+					(OVL_CON_CLRFMT_PABGR8888 | OVL_CON_BYTE_SWAP) : \
+					OVL_CON_CLRFMT_RGBA8888)
 #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
 					0 : OVL_CON_CLRFMT_RGB)
 #define OVL_CON_CLRFMT_RGB888(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
@@ -144,6 +152,7 @@ struct mtk_disp_ovl_data {
 	unsigned int gmc_bits;
 	unsigned int layer_nr;
 	bool fmt_rgb565_is_0;
+	bool fmt_support_man;
 	bool smi_id_en;
 	bool supports_afbc;
 	const u32 *formats;
@@ -410,28 +419,28 @@ static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt,
 	case DRM_FORMAT_RGBA1010102:
 		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
 		       OVL_CON_CLRFMT_RGBA8888 :
-		       OVL_CON_CLRFMT_PRGBA8888;
+		       OVL_CON_CLRFMT_PRGBA8888(ovl);
 	case DRM_FORMAT_BGRX8888:
 	case DRM_FORMAT_BGRA8888:
 	case DRM_FORMAT_BGRX1010102:
 	case DRM_FORMAT_BGRA1010102:
 		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
 		       OVL_CON_CLRFMT_BGRA8888 :
-		       OVL_CON_CLRFMT_PBGRA8888;
+		       OVL_CON_CLRFMT_PBGRA8888(ovl);
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
 	case DRM_FORMAT_XRGB2101010:
 	case DRM_FORMAT_ARGB2101010:
 		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
 		       OVL_CON_CLRFMT_ARGB8888 :
-		       OVL_CON_CLRFMT_PARGB8888;
+		       OVL_CON_CLRFMT_PARGB8888(ovl);
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 	case DRM_FORMAT_XBGR2101010:
 	case DRM_FORMAT_ABGR2101010:
 		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
 		       OVL_CON_CLRFMT_ABGR8888 :
-		       OVL_CON_CLRFMT_PABGR8888;
+		       OVL_CON_CLRFMT_PABGR8888(ovl);
 	case DRM_FORMAT_UYVY:
 		return OVL_CON_CLRFMT_UYVY | OVL_CON_MTX_YUV_TO_RGB;
 	case DRM_FORMAT_YUYV:
@@ -662,6 +671,7 @@ static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
+	.fmt_support_man = true,
 	.smi_id_en = true,
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
@@ -672,6 +682,7 @@ static const struct mtk_disp_ovl_data mt8192_ovl_2l_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 2,
 	.fmt_rgb565_is_0 = true,
+	.fmt_support_man = true,
 	.smi_id_en = true,
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
@@ -682,6 +693,7 @@ static const struct mtk_disp_ovl_data mt8195_ovl_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
+	.fmt_support_man = true,
 	.smi_id_en = true,
 	.supports_afbc = true,
 	.formats = mt8195_formats,
-- 
2.43.0


