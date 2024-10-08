Return-Path: <linux-kernel+bounces-354573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA72993FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0B61F220EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6A1E0DCB;
	Tue,  8 Oct 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BxSZ7oCg"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0871318EFE4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370047; cv=none; b=YEAX9vha0GlOxCCaX0qS+4LfpIo8qAtb3pMSbzqhm6HQ0XWBZ00EaFBCtA8sGMEDGDdc0KlXAel4sDzTQMDz7H5wlm+D5HuLxMzZjC9D06+V/5DKL3RsxhrSHkPFNRg5P/atMgAD9r8MlnUKwtie3WvYib76fvarEksOyYl7Oyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370047; c=relaxed/simple;
	bh=dO6uiYEzYS+yDl9q8RwwtPJSGPYKikjMgkNRWYDYsKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8Nq3nH59ojwiwd+anahQ0HMn+jqAjNRLEJoqa0E16nFZ/255UKDdp/+gvFmnkqWB6Ig6LNEd9V280ikzkAiJ5eYK6OLN2jBvk6B37CZP2kwhW1TvioG1lkW7YL+QvvsON48bUpIWRxzh9IjuDdO7lq4TIccZ8sGosfFLOp8qgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BxSZ7oCg; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a5d6e48854111ef8b96093e013ec31c-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+FbA+Ab/4KXXj/A8FnFBy/xvag8XOJD9avoyDGbvWwU=;
	b=BxSZ7oCg+5k0wC4e4t4RRV0OlTpg9riXec827mwDhKRzC5tA8yGL8xQWSRJY7lfZfzxK38U+Ev9c1Eo07yJ5mAF6fY4Vb4KmyrmfUZ5kpdPeG2uMxpMEmI3lWmbdco3pLg6McObk6YW+fq9LWIO+b95tG3ft3rhPDyVmyF+Hm3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f720a766-847b-475f-8aad-d9722ed273fb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:b127ec40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2a5d6e48854111ef8b96093e013ec31c-20241008
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1250098570; Tue, 08 Oct 2024 14:47:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 14:47:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Oct 2024 14:47:17 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Adam Thiede <me@adamthiede.com>, Yassine Oudjana
	<yassine.oudjana@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, Alper Nebi Yasak
	<alpernebiyasak@gmail.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v10 1/5] drm/mediatek: ovl: Fix XRGB format breakage for blend_modes unsupported SoCs
Date: Tue, 8 Oct 2024 14:47:12 +0800
Message-ID: <20241008064716.14670-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241008064716.14670-1-jason-jh.lin@mediatek.com>
References: <20241008064716.14670-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.252500-8.000000
X-TMASE-MatchedRID: 61l6kdP/ldn2fv0LTPfvM4dlc1JaOB1TUAjrAJWsTe/KP6Yywb5aNnv7
	Io91rBfwD2EF2wJcjhdx0DfvHApiHUIjaJSsaV6qQ4srjeRbxTZCX8V1FiRRkt9RlPzeVuQQVSd
	AA6mVeIb2Xf9YmQBFcj48erx7ecjeHxPMjOKY7A8LbigRnpKlKWxlRJiH4397MXK0ttZlczajEi
	cMpiI5KLc6YnNjZja3DYIajShd9uDehs/W0SS5gw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.252500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8F0398ED3399A163E5816C34E8A7E4B6F70EBBCC414779A726DE9824CEA240452000:8
X-MTK: N

OVL_CON_AEN is for alpha blending enable.
For the SoC that is supported the blend_modes, OVL_CON_AEN will always
enabled to use constant alpha and then use the ignore_pixel_alpha bit
to do the alpha blending for XRGB8888 format.
Note that ignore pixel alpha bit is not supported if the SoC is not
supported the blend_modes.
So it will break the original setting of XRGB8888 foramt for the
blend_modes unsupported SoCs, such as MT8173.

To fix the downgrade issue, enable alpha blending only when a valid
blend_mode or has_alpha is set.

Fixes: bc46eb5d5d77 ("drm/mediatek: Support DRM plane alpha in OVL")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 89b439dcf3a6..047cd1796a51 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -473,8 +473,14 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 
 	con = ovl_fmt_convert(ovl, fmt, blend_mode);
 	if (state->base.fb) {
-		con |= OVL_CON_AEN;
 		con |= state->base.alpha & OVL_CON_ALPHA;
+
+		/*
+		 * For blend_modes supported SoCs, always enable alpha blending.
+		 * For blend_modes unsupported SoCs, enable alpha blending when has_alpha is set.
+		 */
+		if (blend_mode || state->base.fb->format->has_alpha)
+			con |= OVL_CON_AEN;
 	}
 
 	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
-- 
2.43.0


