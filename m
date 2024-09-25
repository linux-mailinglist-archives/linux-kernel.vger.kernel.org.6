Return-Path: <linux-kernel+bounces-338272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E998B9855B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBEA2842B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193D415B118;
	Wed, 25 Sep 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r0iPZGwZ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B2139579
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253695; cv=none; b=UHBwAFRSa0X7wnraDu1xYexVk5d9OWyDmsJHXLw+p97y8rrZVfOZ5P3uVNUKJOa6Vm+7Na7G50f2CghhPL27SLmIp8oGap+GZM4++97Bh0vE3yadsf49DP6qK/uZu256FgEOXoIawIVSGilBk1bxlp2YY0svP2luENnVLFfiqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253695; c=relaxed/simple;
	bh=V2jnRDCH9o63aNm+SoxQBY2Sf3d0HgZbebkRjdGr9lY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOPysts+jOFWlBCsO+Ph9W5cytTgrTuMrEisyDoTUcUcrFMqf8BYLF4/UhkpRl4TpErHY48pQwoCvo6yNUDR9rIeDuAeWZKTbunOQ2TEC4snOXICOlBwJMHaZCzFmXQejkVYSGgIa1O/fOjgcOQT4E8C3njnJ4uq9rowo61qV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r0iPZGwZ; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f02495a27b1911ef8b96093e013ec31c-20240925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=r7DM1OmTlAwvtjukMDEk3ahsIfChXG9XjEPCHP7QFb8=;
	b=r0iPZGwZFUbGpu8UKobqoePl7TIAvPreNeKEbZ1K+Xs24qHrWm3YvIeTKb5DtrowUsIrRSN2lkBt5yAPjK5zKNVVN4lzcDmn5hHZl7Yrz8/svdsGfp9eQ/j2YuMtk+QctE16SjX+IJdE0tRcWPcJk8BYx/NCpNgorKgI5fMT1HQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0d84a92a-5af0-442e-98bd-1e54c5d8d2d7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:fc343a18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f02495a27b1911ef8b96093e013ec31c-20240925
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1374822066; Wed, 25 Sep 2024 16:41:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Sep 2024 16:41:17 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Sep 2024 16:41:17 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <rex-bc.chen@mediatek.com>,
	<msp@baylibre.com>, <granquet@baylibre.com>, <dmitry.osipenko@collabora.com>,
	<jitao.shi@mediatek.com>, <mac.shen@mediatek.com>, <peng.liu@mediatek.com>,
	<liankun.yang@mediatek.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 1/1] drm/mediatek: Fix wrong check of nvmem_cell_read
Date: Wed, 25 Sep 2024 16:40:24 +0800
Message-ID: <20240925084116.28848-1-liankun.yang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.492400-8.000000
X-TMASE-MatchedRID: SuWkWSV/ibcryFHbNnBLG0KcYi5Qw/RVsEf8CpnIYtnfc2Xd6VJ+ynOQ
	FTxg7zBiief1bXK4Giqi5055Kxg7KbBAQLqGlKiv4pdq9sdj8LUFHCcDXik5Rpsoi2XrUn/Js98
	n9dYnJNNQSFbL1bvQASAHAopEd76vrTCa7ZKhhkhBggx/bFjh7r0Dqq+NSXuwaGjbsK/Gvmg8gV
	7uQwboPw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.492400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 13CCA0BB40EB3E96C6F46EEAE16D8E08228DAD574439DD1B6B754A5BEAC8938E2000:8
X-MTK: N

If the len is 0, kernel crash will occur when performing operations.
Add the len check conditions to prevent kernel crash.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")

Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d8796a904eca..0cc75ba96b98 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1082,7 +1082,7 @@ static void mtk_dp_get_calibration_data(struct mtk_dp *mtk_dp)
 	buf = (u32 *)nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(buf) || ((len / sizeof(u32)) != 4)) {
+	if (IS_ERR(buf) || (len == 0) || ((len / sizeof(u32)) != 4)) {
 		dev_warn(dev, "Failed to read nvmem_cell_read\n");
 
 		if (!IS_ERR(buf))
-- 
2.45.2


