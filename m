Return-Path: <linux-kernel+bounces-270573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D894418E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86E8281983
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D113D2BE;
	Thu,  1 Aug 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="piyTGWGq"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1713D24D;
	Thu,  1 Aug 2024 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481877; cv=none; b=lwZ+WcuDWs5cqZM1cSrRokY+okUPwPF6RKooeLTBo4XdtygGfkdjZLzfpNPshJ15L6CJb5HtJomLeOJUnCdmtZ6/5L90qWqRCIpBTcfXjxBtz7TTvPRBwTPPNrxT4fYbgWxfKHWT/NJGBxQSDLjRF9xa0d8Wdlu6WYRCXEY5cmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481877; c=relaxed/simple;
	bh=03Q/BMZ1/DUeZIMFE3RjLQaNlXs/KLu9/a8TbwH+ZZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rncey6Plk36FzaH6VWLlCxSsxVjAoka729XwrE8k1L0zN078ipl7mOQumxfOqrfwoCPIIOA7SlRObqzviT0tFWJzsB84KuJne12RnPOMalqT54dDvIxxv146DTQlXZUqqKjb+DR/sE/QqceAUe+9eMMzehWmt+9yxDbXfKDML6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=piyTGWGq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b0c363e84fb311ef9a4e6796c666300c-20240801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4GpAIRZdMhZSTsJPSVOYqCnYUdwUP7d/1luMYhvJfaI=;
	b=piyTGWGqAqtDF6xg6X7BFIfGnwJqE/4YJru5cHQINeQkCeZlE9c45D/GbkK6L4uLCTOTNO/W4BCTa9sy120NjoTLPLGDk5t4USv3Lrg9ZeVqfK6+hs3iLeuaUS8ZGLtY/zc1sULtqS0duCI166uqjERe8QFaNQWf22t7mjdDFHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:26aaa21a-6fbf-4206-ae2e-302d8afb0ba8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:1ab102d6-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b0c363e84fb311ef9a4e6796c666300c-20240801
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <yr.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 299177876; Thu, 01 Aug 2024 11:11:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Aug 2024 11:11:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Aug 2024 11:11:02 +0800
From: yr.yang <yr.yang@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, YR Yang
	<yr.yang@mediatek.com>
Subject: [PATCH 1/1] ASoC: mediatek: mt8188: add register to volatile_register
Date: Thu, 1 Aug 2024 11:10:30 +0800
Message-ID: <20240801031030.31114-1-yr.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.381700-8.000000
X-TMASE-MatchedRID: rHai9PqIGYaLwgJA7qJvFMnUT+eskUQPuLwbhNl9B5UeaAmZIX542Jah
	y9R3rl2Rpg88JvjuALCKmwyUcf+f3LL5lB/vTWKDA9lly13c/gHt/okBLaEo+H5h6y4KCSJcpMB
	UwgqWxUfwHUSrzAMoARAISLmT6dDEHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgW/KZGkrHlNGg3u5
	jQHadGg6dqnoOcTqwEj6l9Lqw9rFdR8lOQtOtaFme5sbOn0w4k1/nMyHDPr2V8yzUl7m/92666w
	hc7npsj4sOrsb4iT/K/bbEolHIgZUOc7GjOamnWv5a9cmIodEszD8HZ4XvJ2ZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.381700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F12722AC61B8F341386EF201A7D976671705BBB306208B188874C6169E7692B12000:8

From: YR Yang <yr.yang@mediatek.com>

Add AFE Control Register 0 to volatile_register.
AFE_DAC_CON0 can be modified by both SOF and ALSA driver.
If this register read & write by cache mode, 
the cached value may be not the real value
when the register modified by other side.
It will cause playback or capture fail.
Need add AFE_DAC_CON0 to volatile register.

Signed-off-by: YR Yang <yr.yang@mediatek.com>

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


