Return-Path: <linux-kernel+bounces-319577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6796FECF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFF02842C0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC904210EE;
	Sat,  7 Sep 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddpbxwGO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B7208D1;
	Sat,  7 Sep 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670549; cv=none; b=TVWgh7GJNqEJCPKtmGJvbH7TSK/4Y1LfY3IWJj1F9xyFXYfxOXxTAVeS7hs4u60FkecNLAIOR5xe6tXROuuk45Q6ie0ed4pfc7rum/GT0kIGcheu/uYjqRnFlyEzq+9VnBosHrPOUprkWoIz9LM69W8vztFFuo476wePamB+WIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670549; c=relaxed/simple;
	bh=d29PX8Kf8MYAinMn4C2D5w94LU1+8WoEKeXakOrts3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDWWU0vx+M0pnog05kCW7GKbvz+EjlVKUE0rfclgKKQWd+lOasJPSB1UTxsRu6lmUOuuZfBK7l88mhQfD6EbzsERmaLV8nRwRNVLr6AOslf9N96Z+INmG6MS7ykGraTaTTKzsOpCBRwVvhkjvmHjN5YTdOaLWdIXgIkaGPz6cXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddpbxwGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DFCC4CEC4;
	Sat,  7 Sep 2024 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670549;
	bh=d29PX8Kf8MYAinMn4C2D5w94LU1+8WoEKeXakOrts3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ddpbxwGOhlKDdTfrH0Jus/qOrB0R0C797M07biC8FYniSbThI2Y5ASgFyNrsF62wo
	 Nu1F4fVJlOS6r3CYaaXaRfFTyEfhcqdwea8i9XIoqhnw6Vlkjc6bOqKH8A0ia+Oujz
	 16ypB34ISJUCTu4HWTCRxyu/uUQsI+Pe/1TLbRUvPc5sHFx/9fVZo2Yjg2/yT6Z2oV
	 03XcFMFmUrKqMTG9mWU30qm11QwR+ydtmVyNLtLH6urWjC1jXk8rWsKP0HFKm1xeMh
	 qqsbGnz2kOtuvaw/0E9WatpHsu/rZCFsLcaIvFx0HQJ8Xqn3wG+/38RCmbCg/HTRnw
	 7Bc1bnTB92xZA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Sep 2024 01:53:30 +0100
Subject: [PATCH 5/7] ASoC: mt8365: Remove unused variables
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-asoc-fix-mt8365-build-v1-5-7ad0bac20161@kernel.org>
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d29PX8Kf8MYAinMn4C2D5w94LU1+8WoEKeXakOrts3Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26SANRt5NQ04hFOb/RfJc6j4vAH/dTnmrrFv/
 C9Wsx043JyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukgAAKCRAk1otyXVSH
 0Ei4B/95b3HQREtmOua5M38o740mYRlt2CFq/K/fN/fQmep4JdPSKRqIOKYYQoRcBBmT7gVTJHK
 ni/dl8zFiHNcH2r8ufA7CBh60Fx+NgqLUt5OPhdt1PVeq56O+jZ2yS1O669CGe54sbQSEX/LD+4
 r91ro5TKC3Vk19vyqi5FT6qfaDQvLdfC0js13eqE1lNvnGMITM7/xMdPBDJfK1QRnkYMHnpnyu5
 UAx5zyL2rxLH+Hj3L/u73wJ0yuJNmVq1ZGfKKeuGgZNnmGiR36LjiZHthXHP85Bv1a6C8JInEln
 c0iXwdR+JqtY8OSlzOi5D7IoMnkVaxvg10i/gC+SEpWoX2RS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Silence compiler warnings by removing unused variables.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c | 1 -
 sound/soc/mediatek/mt8365/mt8365-mt6357.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
index 54d2112d2e92..21b1319a6c28 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
@@ -651,7 +651,6 @@ static int mt8365_afe_fe_hw_free(struct snd_pcm_substream *substream,
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8365_afe_private *afe_priv = afe->platform_priv;
 	int dai_id = snd_soc_rtd_to_cpu(rtd, 0)->id;
-	struct mtk_base_afe_memif *memif = &afe->memif[dai_id];
 	struct mt8365_fe_dai_data *fe_data = &afe_priv->fe_data[dai_id];
 	int ret = 0;
 
diff --git a/sound/soc/mediatek/mt8365/mt8365-mt6357.c b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
index fef76118f801..1b8d1656101b 100644
--- a/sound/soc/mediatek/mt8365/mt8365-mt6357.c
+++ b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
@@ -290,9 +290,8 @@ static int mt8365_mt6357_dev_probe(struct mtk_soc_card_data *soc_card_data, bool
 	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
 	struct snd_soc_card *card = card_data->card;
 	struct device *dev = card->dev;
-	struct device_node *platform_node;
 	struct mt8365_mt6357_priv *mach_priv;
-	int i, ret;
+	int ret;
 
 	card->dev = dev;
 	ret = parse_dai_link_info(card);

-- 
2.39.2


