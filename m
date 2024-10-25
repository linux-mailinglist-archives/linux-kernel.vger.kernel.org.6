Return-Path: <linux-kernel+bounces-381257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035659AFC97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D3F1C20F22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD71D2B3B;
	Fri, 25 Oct 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z4CPxdB6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A641C9EDC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845122; cv=none; b=MtftZJbWvdYJQNq9zPjhidg/d34ltzWHFzcp2wNoLr0dsL0Tfxgx44hYcrvoYPniPYJjHqtWOJ9UAHFjYReFwXl17vMEKvPRzYCYVCJGphkwxtepx+6POTpR2sp8A+L6KOp5aZb0u5iVk4/KyNQGtOY8uvOhlgcxP28T4NbHTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845122; c=relaxed/simple;
	bh=IinrIYb3AaQ6QaOFLZVDE90aCYUfecmzPpdelo4b0TE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgWQ3OT61Iz+YxT32AYshEuN0w6pbEyyllOkjyLf1IivijWUitQtCFM24J3F1lcW0io24uEVTQuUQNJZYS8hkbjCSavKGmi5HVGAkYXF4jIsQh2ae4MfwohRHdpl8TlIi1Z82zVw7fvMooKH0qkFnO7PQGBbsHwrebd7Yi7gUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z4CPxdB6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 921bddcc92ab11efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jHk7k0mLNr2tL+X1mT3LjPHy3SzInMKuWg8T+fWq1Bs=;
	b=Z4CPxdB6x9O2woEeRVDZeQlG06ZZl9nQlyV3vTo5Y4nVAdCk1E0rmr8Y/fR3cVTil/l5KCfjhH/ZvV0HSq+vPRA+zS1atyqGw43nIde/Wi7snaqMr7bwrrn+mdzmRzrzmq3h8eCa80hg8NMZPyRAS8Q/JqHBywC24tqL/gdYGuk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:181564af-7d9d-4357-a404-6f0b10386860,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0fcdc3,CLOUDID:ca9d192e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 921bddcc92ab11efb88477ffae1fc7a5-20241025
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1432290000; Fri, 25 Oct 2024 16:31:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 16:31:44 +0800
Received: from mszsdclx1211.gcn.mediatek.inc (10.16.7.31) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 16:31:44 +0800
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
Subject: [PATCH v2 1/3] drm/mediatek: Fix YCbCr422 color format issue for DP
Date: Fri, 25 Oct 2024 16:28:27 +0800
Message-ID: <20241025083036.8829-2-liankun.yang@mediatek.com>
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
X-MTK: N

Setting up misc0 for Pixel Encoding Format.

According to the definition of YCbCr in spec 1.2a Table 2-96,
0x1 << 1 should be written to the register.

Use switch case to distinguish RGB, YCbCr422,
and unsupported color formats.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
---
Change in V2
- Modify the value written to the register
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240510021810.19302-1-liankun.yang@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index f0f6f402994a..613e1c842478 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -460,18 +460,16 @@ static int mtk_dp_set_color_format(struct mtk_dp *mtk_dp,
 				   enum dp_pixelformat color_format)
 {
 	u32 val;
-
-	/* update MISC0 */
-	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3034,
-			   color_format << DP_TEST_COLOR_FORMAT_SHIFT,
-			   DP_TEST_COLOR_FORMAT_MASK);
+	u32 misc0_color;
 
 	switch (color_format) {
 	case DP_PIXELFORMAT_YUV422:
 		val = PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422;
+		misc0_color = DP_COLOR_FORMAT_YCbCr422;
 		break;
 	case DP_PIXELFORMAT_RGB:
 		val = PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RGB;
+		misc0_color = DP_COLOR_FORMAT_RGB;
 		break;
 	default:
 		drm_warn(mtk_dp->drm_dev, "Unsupported color format: %d\n",
@@ -479,6 +477,11 @@ static int mtk_dp_set_color_format(struct mtk_dp *mtk_dp,
 		return -EINVAL;
 	}
 
+	/* update MISC0 */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3034,
+			   misc0_color,
+			   DP_TEST_COLOR_FORMAT_MASK);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_303C,
 			   val, PIXEL_ENCODE_FORMAT_DP_ENC0_P0_MASK);
 	return 0;
-- 
2.45.2


