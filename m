Return-Path: <linux-kernel+bounces-367053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C491299FE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C20C1F260E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189997405A;
	Wed, 16 Oct 2024 01:19:27 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E0101C4;
	Wed, 16 Oct 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041566; cv=none; b=QElct0IWl8D30VUHJviSUmqitxF7jywWPj1OTjzbB0dztxMj+gdvANC1ac1lhjQwuxsuryIpsOt9zEJSVD9YT06/V5tMrc6F2fFBK0w50gXYHx78QaXTUsuaJZnCu3J3HsladWnuGfDucVPwOQuNUrqFLUtkZvWO6bYvtCJNSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041566; c=relaxed/simple;
	bh=dLO7lKKHgbBw34pHIJXuD176jrqiJ3VQTFJRLgEwup0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJscH6fNZK6Z0fufEHDYsgl0/7NtuC72bFDcUn0PwzihbaAdUYj1ob6NpqOIXFy5R1Fhq4fLSeXZxVBlDfbbTqcZuwPuW5FQZUfket7p3RAIBXpil2z3xcvOK0aFlD0VJxub3MoTDy4AKHhGbKzeClEJZH302Dpiq8uQv7wdklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3670f14925cf-f5dea;
	Wed, 16 Oct 2024 09:19:15 +0800 (CST)
X-RM-TRANSID:2ee3670f14925cf-f5dea
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from leadsec.example.com.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4670f14888e0-200ed;
	Wed, 16 Oct 2024 09:19:15 +0800 (CST)
X-RM-TRANSID:2ee4670f14888e0-200ed
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
Subject: [PATCH] ASoC: mediatek: mt8188: remove unnecessary variable assignment
Date: Wed, 16 Oct 2024 09:18:51 +0800
Message-Id: <20241016011851.2023-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function mt8188_adda_mtkaif_init, 'val' to 0 is repeated,
thus delete one.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
index 8a17d1935..436703166 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-adda.c
@@ -63,7 +63,6 @@ static int mt8188_adda_mtkaif_init(struct mtk_base_afe *afe)
 			param->mtkaif_phase_cycle[MT8188_MTKAIF_MISO_0];
 	}
 
-	val = 0;
 	mask = (MTKAIF_RXIF_DELAY_DATA | MTKAIF_RXIF_DELAY_CYCLE_MASK);
 	val |= FIELD_PREP(MTKAIF_RXIF_DELAY_CYCLE_MASK, delay_cycle);
 	val |= FIELD_PREP(MTKAIF_RXIF_DELAY_DATA, delay_data);
-- 
2.33.0




