Return-Path: <linux-kernel+bounces-521222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B6A3B984
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4459317E0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5661E0DCE;
	Wed, 19 Feb 2025 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZRihoo8M"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB941E0487;
	Wed, 19 Feb 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956871; cv=none; b=sJlmNVGl79vZAO0cCoi9fQJYnD30I7IXmtpPXf2T+GMVFbXQq7exbh2mSvKVUIstkI9nKtE2NwA1X2xnUNe33KkxJDhxXwSy5f1lmU5eH6yGCIgYQr7/Jq6FHxgWJVGUA6UXlqvNDknSKRFpY6KymrtycpgZr4+X9kHp4rb2Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956871; c=relaxed/simple;
	bh=uYQTQVTtAHMj4vcQv8TJ9wcsJ2IAiBFZPrxpQ9tmJDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAR+9EttGZe4E3kWy1b/NdnApT8YLQIlicJUTa8l3BhvAHrUObheS/JQVdRwY2zCd8AbLfYklOeLNmbK1gXWE854Y6OOAU/9iraFnirZjY19sA7BCrerITO3dtgbzQzrHOJGoJxxXQJTYu4jbHgJB0/kqRg+BIu/YVNr4DwduKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZRihoo8M; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6fd37f8eea211efaae1fd9735fae912-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uRjryn1Z9973YvyrRwHv9/fVTyITLe6PZEvLBbf4Eeo=;
	b=ZRihoo8M4GiETNNqkMr4cGp3TdhNZLq38mZ1LaOFXpIIo84guH4URjPaR0ONi3pLXs9tLbEpPTGWneaKc65TF1tA1fl4mEKhq0M3SygkfVYh6D5PTAKN3ZB6f+9bTzuxE4fYUORjDecirXt09VgDcBUN2qD28MZYodxeRrbviuM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:11b34bde-b4b7-47dd-95d2-386ce7b53def,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:caf8fe28-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6fd37f8eea211efaae1fd9735fae912-20250219
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 554630443; Wed, 19 Feb 2025 17:21:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 17:21:01 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 17:21:00 +0800
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
Subject: [PATCH 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n function issue
Date: Wed, 19 Feb 2025 17:20:35 +0800
Message-ID: <20250219092040.11227-3-jay.liu@mediatek.com>
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

if matrixbit is 11,
The range of color matrix is from 0 to (BIT(11) - 1).
Values from 0 to (BIT(11) - 1) represent positive numbers,
values from BIT(11) to (BIT(12) - 1) represent negative numbers.
For example, -1 need converted to 8191.

Fixes: 738ed4156fba ("drm/mediatek: Add matrix_bits private data for ccorr")

Signed-off-by: Jay Liu <jay.liu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 94e82b3fa2d8..a9f91b71534b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -100,6 +100,15 @@ static u16 mtk_ctm_s31_32_to_s1_n(u64 in, u32 n)
 		r |= (in >> (32 - n)) & GENMASK(n, 0);
 	}
 
+	/*
+	 *The range of r is from 0 to (BIT(n + 1) - 1),
+	 *where values from 0 to (BIT(n) - 1) represent positive numbers,
+	 *and values from BIT(n) to (BIT(n + 1) - 1) represent negative numbers.
+	 *For example, if n is 11, -1 will be converted to 8191.
+	 */
+	if (r & BIT(n + 1))
+		r = (~(r & GENMASK(n, 0)) + 1) & GENMASK(n + 1, 0);
+
 	return r;
 }
 
-- 
2.18.0


