Return-Path: <linux-kernel+bounces-203995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F028FE2B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88700285748
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C87153582;
	Thu,  6 Jun 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KAQdtsr7"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320BD13EFF3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666007; cv=none; b=r5Fo1hFXI2fO/oU6ojLjO7eGHahQN8BHWaIelprghGi9HBd7pSWDa5buxuIWq6KCBGQz9bzW1Y4V4lcto/Ww0fOeV/VJEOIch/iPzJrFYwba5pi5NRXKg89wU7RD8rDB2BsdZl1sXXvHeBXlGbId4Z98PuvsBw32f9RxMcRyMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666007; c=relaxed/simple;
	bh=eKpWxfAxY/NqzBb/rOMFmezlP8QEKNmXCxQikdX5yxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fd7ta1WYnFyPVOIwXg9XMOTYYXlfr+zDHyxAC7Bu53M2RwHJ9LYYd/5FX83MXsVCfst9keisLY2HckDc3rxVzAks3OERLNs56+FsnStsJiv4t7Mqo6D9fHnSQj79aoddguiKqSP/BgCOse7j/H/FbebiylJkAK0DQUqPVlAbids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KAQdtsr7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e0c956b823e611efa22eafcdcd04c131-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xoLRYaU7yoSuJFIB2Klrt50DpYA8HCIs8Oq+MvdPFfs=;
	b=KAQdtsr7sNvZMWo1Pn64s1en3q1WTeuEKceRJHp+zUaRTtJPIaTLLW2QcElAJ0XYmy+XsuKF1lTsjRhlAOkWCYAUyhJ8ttnHgKWj4MaaiZywnO9Q41/wozlpRdZ/1yAQWPBKDRGNpdDgrAkZtlq6GRn8jI9cI6+iX3Xgl/b2IzQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:5523b91d-6580-44af-ad8d-bbf40de34466,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:613b4744-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e0c956b823e611efa22eafcdcd04c131-20240606
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1676228695; Thu, 06 Jun 2024 17:26:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 17:26:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 17:26:36 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Bibby
 Hsieh" <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>, "Nancy . Lin"
	<nancy.lin@mediatek.com>, Sean Paul <sean@poorly.run>, Jason Chen
	<jason-ch.chen@mediatek.corp-partner.google.com>, Fei Shao
	<fshao@chromium.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>
Subject: [PATCH v8 01/16] soc: mediatek: Disable 9-bit alpha in ETHDR
Date: Thu, 6 Jun 2024 17:26:20 +0800
Message-ID: <20240606092635.27981-2-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606092635.27981-1-shawn.sung@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.682500-8.000000
X-TMASE-MatchedRID: k8Xm6x9M5Ep8XbDftE7Is98tWTI1R8epwZLXS0hN8p1Zps+y1VXzqdnv
	4KmarbUQ2tWL4y7HsTWfKyXIRVJFjAgpNt5EgFbMY1bQMCMvmn744jpewrcFYd9RlPzeVuQQHz5
	ccRN5kLPRGkFt/fG/yCjzbr1UlDnYGAdnzrnkM48URSScn+QSXt0H8LFZNFG7doMssNsUwYXRsV
	AudlazscZEM68jstKz/J0+Gslj0VzkMCYT2R0qXKIl8iTbYhMhktJrxuof2amhvEPQS1e2QJ9C7
	4QyK/10JJlSv7hgV4qAhOcaQrQ0U1GyRcoeF18qmKP0zzpTAeGwod8xOMKmvA1Aka/KIp/p
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.682500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	729B3508F30CB7C12E0921B6D46869951CC58D4DAEBC39425134DCD5BA83767E2000:8
X-MTK: N

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

When 9-bit alpha is enabled, its value will be converted from 0-255 to
0-256 (255 = not defined). This is designed for special HDR related
calculation, which should be disabled by default, otherwise, alpha
blending will not work correctly.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index f370f4ec4b88..938240714e54 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -236,6 +236,7 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
 
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_ALPHA + (idx - 1) * 4, ~0,
 			      alpha << 16 | alpha, cmdq_pkt);
+	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_HDR_TOP_CFG, BIT(15 + idx), 0, cmdq_pkt);
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_HDR_TOP_CFG, BIT(19 + idx),
 			      alpha_sel << (19 + idx), cmdq_pkt);
 	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_PAD + (idx - 1) * 4,
-- 
2.18.0


