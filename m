Return-Path: <linux-kernel+bounces-340307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEFE987167
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0CF2888AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FE1AD9F7;
	Thu, 26 Sep 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SK6IVWpP"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B61AD40F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346167; cv=none; b=BoUO9Sd6PO8L+ve0XZwrRftlH6eJaJfLIC09/2EFFuprDoHQBiG4WF8I/XDVfvELELMcCbkf5JHB/Uug29GxXKuwvaaQfaOyV0s2ktIw63XYgD1WlHCisWP03Tio5ZFzNi3tKpaWVtJaxAFgIrdDLXHB/yhP31Mbop36Nm3NaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346167; c=relaxed/simple;
	bh=L0FtcstOM2xYEEilhwfHnysfYNLNKWOZA8jLmbSCP7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRLdFVD6R4QKryySZ1gbS3E/bQbb4ggJlbtL45eYV8bOVdNXZHyAZyi8JHWw3FfecHoOwRtMq9qa68NLPTmd9F2+FwqkIYRjGwN53cyhvIY4obOes1/5sP/tlfhTgp2MFqaNOs0rZ63Ti7RglR/58wvbD795FN7cmXnuC4SoAq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SK6IVWpP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 42817d747bf111ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=p+LwCbvXOSjtyBMOZneoQljsVhSvCUkRKqPwTNyf7hY=;
	b=SK6IVWpPA0RMJXa4jwCijQy2xapPagbhvzLRVw0sSehD191lenpRdHd/k1ICEApivAeqTFU8ClAisSpeNkkftVCYc6lFy+doL/+1v4OSQL188O6X2UtGCm0xjDdbfug92rVltXknfRGJWL2oCNRapoaJKZDjO7xJYxSOE/FCmP0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6d8f4d28-c42d-48e8-bc63-e2d6433776c4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:19144b18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42817d747bf111ef8b96093e013ec31c-20240926
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 994344881; Thu, 26 Sep 2024 18:22:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 18:22:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 18:22:39 +0800
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
Subject: [PATCH v7 1/3] drm/mediatek: ovl: Remove the color format comment for ovl_fmt_convert()
Date: Thu, 26 Sep 2024 18:22:36 +0800
Message-ID: <20240926102238.24303-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240926102238.24303-1-jason-jh.lin@mediatek.com>
References: <20240926102238.24303-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Since we changed MACROs to be consistent with DRM input color format
naming, the comment for ovl_fmt_conver() is no longer needed.

Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 89b439dcf3a6..4a4bc27a67f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -389,11 +389,6 @@ void mtk_ovl_layer_off(struct device *dev, unsigned int idx,
 static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt,
 				    unsigned int blend_mode)
 {
-	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
-	 * is defined in mediatek HW data sheet.
-	 * The alphabet order in XXX is no relation to data
-	 * arrangement in memory.
-	 */
 	switch (fmt) {
 	default:
 	case DRM_FORMAT_RGB565:
-- 
2.43.0


