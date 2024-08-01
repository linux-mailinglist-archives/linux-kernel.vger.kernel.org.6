Return-Path: <linux-kernel+bounces-270905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF39446DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B861C2443B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE916EB7A;
	Thu,  1 Aug 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TEehCUii"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADD16EB41;
	Thu,  1 Aug 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501827; cv=none; b=bxV32cylYTjY3pf+feYW40RskV+FS3EzsAErjBLE1ZOhk0z97pcpJvaFY1Ne7gLeubESWQxjiZZumsS18plqhvmAaic+F8ysf8T8f7hI2vIoQnEphHGGv3jUQzCLzRxFK747NxZSwtpGf6Is/7S9QQ38odO8eLW6u7+457req/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501827; c=relaxed/simple;
	bh=pFLB9riUbK2ceAAAvdyEErAppLLtQQ7KvwBuO4hN9V4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNRLi5kBVe8sxM9xDxigGX+QbKjLZ1Nssx2GQbIi4NXkLg7aPhKCXJ9ksPg50DA/Yp+qS8WES8bmyvWGNZCiwFRVc09i+JWQvoZTGKztzPEbNeHoXS0vdulfC6JazK6Qi1CEXY2PCCa9K2a8qtC3GtfQxTd+ywzrsRg/rDTcumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TEehCUii; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 25ea61344fe211ef9a4e6796c666300c-20240801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wxNcnqQo5NU+fObOUqkwuDhDALZigjO5uaz8LMLm0ok=;
	b=TEehCUiiQoZMz79Roef6y92CyPotL/HQ8a0V9nVZNupRlUiqckHdgaziYVV7txugMQxJ0lqdBJbL8pO9Z/1c3/ePk2PVBhIcHqxAI5ZqVHvnsonyD/0+eBxqCDqohWApTDBwc9kblpg3QNauC7o/KM0oxolOxAzwshbzxa58Qs4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:88296e2b-c4ec-4c3c-a623-4ce45e3d2861,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c40c2ad2-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 25ea61344fe211ef9a4e6796c666300c-20240801
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yr.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 961891854; Thu, 01 Aug 2024 16:43:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Aug 2024 16:43:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Aug 2024 16:43:37 +0800
From: yr.yang <yr.yang@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, YR Yang
	<yr.yang@mediatek.com>
Subject: [PATCH v2] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile
Date: Thu, 1 Aug 2024 16:43:26 +0800
Message-ID: <20240801084326.1472-1-yr.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: YR Yang <yr.yang@mediatek.com>

Add AFE Control Register 0 to the volatile_register.
AFE_DAC_CON0 can be modified by both the SOF and ALSA drivers.
If this register is read and written in cache mode, the cached value
might not reflect the actual value when the register is modified by
another driver. It can cause playback or capture failures. Therefore,
it is necessary to add AFE_DAC_CON0 to the list of volatile registers.

Signed-off-by: YR Yang <yr.yang@mediatek.com>
---
Changes in v2:
- Modify commit message.
- Link to v1: https://patchwork.kernel.org/project/linux-mediatek/patch/20240801031030.31114-1-yr.yang@mediatek.com/
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index ccb6c1f3adc7..73e5c63aeec8 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -2748,6 +2748,7 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AFE_ASRC12_NEW_CON9:
 	case AFE_LRCK_CNT:
 	case AFE_DAC_MON0:
+	case AFE_DAC_CON0:
 	case AFE_DL2_CUR:
 	case AFE_DL3_CUR:
 	case AFE_DL6_CUR:
-- 
2.34.1


