Return-Path: <linux-kernel+bounces-358447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0682C997F85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B206F1F25009
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F8D1EF928;
	Thu, 10 Oct 2024 07:36:10 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDE1C3F24;
	Thu, 10 Oct 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545769; cv=none; b=V6k5caiS90uvqXHIeUHTR7Lr3HlTkBEWakG9Zyun+TPUu9F95OLvN32pGH6xC/BgtccDaGfbWOZDZMG2jcDdg2EZ7S1PxfmkiagD7HaOfZDFY+jfPGYQPJ8J8RchCdhiPnSrsdvCEH0hmxXVE2ogOeH/q4J1nemLpLVSsiM9QUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545769; c=relaxed/simple;
	bh=rXzDHmmLjzqa0/NFh+UsiE9QaIvcVFS534eYqU4kNnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+fBDgLb63shdimUCyAX+/bGBXJuaSL0WPRlP1DGc+2NCo5e7fsNVS0dIHwUMY94NP3rRa+bADZYH2G+W98WUiSH7xINbKvItYUpZsmbea1yfG0N8aNQ/S9JCIrhpE5aQIn4+dGfsqeKUEFo5MgXx8JUYkqrqbPOgIWTPFi5QSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3670783e228e-c4aa8;
	Thu, 10 Oct 2024 15:36:02 +0800 (CST)
X-RM-TRANSID:2ee3670783e228e-c4aa8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from leadsec.example.com.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1670783df7fd-3f86b;
	Thu, 10 Oct 2024 15:36:02 +0800 (CST)
X-RM-TRANSID:2ee1670783df7fd-3f86b
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 1/2] ASoC: mediatek: mt8188: Remove unnecessary variable assignments
Date: Thu, 10 Oct 2024 15:35:47 +0800
Message-Id: <20241010073547.3720-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function mtk_dai_hdmitx_dptx_hw_params, the variable
'ret' is redundant, thus remove it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
index 2a48f5fd6..69a091dad 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
@@ -2422,7 +2422,6 @@ static int mtk_dai_hdmitx_dptx_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	snd_pcm_format_t format = params_format(params);
 	int width = snd_pcm_format_physical_width(format);
-	int ret;
 
 	if (!is_valid_etdm_dai(dai->id))
 		return -EINVAL;
@@ -2450,9 +2449,7 @@ static int mtk_dai_hdmitx_dptx_hw_params(struct snd_pcm_substream *substream,
 		etdm_data->data_mode = MTK_DAI_ETDM_DATA_MULTI_PIN;
 	}
 
-	ret = mtk_dai_etdm_configure(afe, rate, channels, width, dai->id);
-
-	return ret;
+	return mtk_dai_etdm_configure(afe, rate, channels, width, dai->id);
 }
 
 static int mtk_dai_hdmitx_dptx_set_sysclk(struct snd_soc_dai *dai,
-- 
2.27.0




