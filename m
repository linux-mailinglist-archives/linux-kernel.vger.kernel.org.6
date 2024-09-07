Return-Path: <linux-kernel+bounces-319578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ED796FED0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C905D1F23C92
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622194C9A;
	Sat,  7 Sep 2024 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDKgyPbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990B2BD19;
	Sat,  7 Sep 2024 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670552; cv=none; b=Kxdj/skx/VsOA8wDzCIcj20/NTwNoYRkDamGgU7VVPB54pp5ideqympeQlSwQ2veN5gERLPw/TbxPYUIEW+n8rNec7v2bY5VUgHT1v4TzkinzOkh7Ljjr7ntM/RiAQygTWK4kt5EZ4plHY7ysywjtX3JBibqte1vbiRmFUmy6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670552; c=relaxed/simple;
	bh=4xdE0tNYCJIEybe1Mo1jGwO98BsqMRPOQv2h7DEiJUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YhLvLtDnJ22jhbT83nHD6tZLOzFGO1b2sUXLM9AAm8TWTVMpnENvAe2yxiaD9gzM8PWD0B7zxfmm/4zy7BnoBwnzHF5QpZ//XO9sMASHCI1t25sIiNZF6bMaaDXbDgPTsShHE4WNl8h1RhlL2zbSS/vZ+F3ZJlx9jnL2Lhey9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDKgyPbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A67FC4CEC6;
	Sat,  7 Sep 2024 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670552;
	bh=4xdE0tNYCJIEybe1Mo1jGwO98BsqMRPOQv2h7DEiJUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sDKgyPbC7LX8yRCxRsI5mRD8vahl51omQUm8zKAJvAZWUYNmzsDeTfp9DkgpBUGli
	 2WVjgCZqAMpTGPPY15EcKVCzCm8WPbJtlqj+Ro29gfm0u6jDJHpz35D5zaWHyE22UK
	 mcBl22Xi2PGmC8PHwpM5kTgh3zgglfxwGmZqw6VENMop95H2FfZRKuPID8/fsM+i18
	 iQNJZi5Pxxpo4HXa1yUsXDzbIuks3hynTAlFfGrZZtq76hwSwnFRzc1u2ORmpTJhPh
	 ipB1nNsjlsOZNnxJGCP69jDZz2R5/ArGDfc2cDyqryLE1jeWmdUFwWZolvO2x42uJQ
	 Tv9NDkslHUI8A==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Sep 2024 01:53:31 +0100
Subject: [PATCH 6/7] ASoC: mt8365: Remove unused DMIC IIR coefficient
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-asoc-fix-mt8365-build-v1-6-7ad0bac20161@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4xdE0tNYCJIEybe1Mo1jGwO98BsqMRPOQv2h7DEiJUs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26SB9w0r3cXods2Io4Bj+kQAm5IN9AfzhuhON
 GW5vPba3h+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukgQAKCRAk1otyXVSH
 0CDDB/4tmZwad18Si8ZMlu0wXc5OhYlza1BQK8bqC3/6Fz3l793mBZ1inOovTbKWLbSWyAyY33g
 I8GG65AjwsZjcNnwC8DRggjPg1XaURSQCx6qD3Hl9vmsdLMX+D4OiCk0qSYPmiI2ZfSrLVymZyd
 ba01/b8Nuobubt4nRdH3IdrUt9Yl51ry3sGCCWs+lbBYS0uD8n2hF0SIH2z4RHKHKDrZp8oO/XH
 pmCzDVsZBT43oB23aoGsZkdE1XmuDyu0wW2+4t3wpsJUF4ey0xjAKRaGKHvnWukcn7T7lGb9SNe
 81FUCKbZeZKslLzSSwsgGRW05VuGJc6m+8IfqCsB8Qkve5g2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Nothing ever calls mt8365_dai_load_dmic_iirc_coeff_table() so the compiler
warns about an unused static function. While it seems likely that something
should be calling the function I don't know what and this is breaking
-Werror builds like allmodconfig so let's just remove it. It can be added
again along with the user.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8365/mt8365-dai-dmic.c | 30 -----------------------------
 1 file changed, 30 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-dmic.c b/sound/soc/mediatek/mt8365/mt8365-dai-dmic.c
index a3bf54751420..f9945c2a2cd1 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-dmic.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-dmic.c
@@ -108,36 +108,6 @@ static void mt8365_dai_disable_dmic(struct mtk_base_afe *afe,
 	regmap_update_bits(afe->regmap, reg, mask, 0);
 }
 
-static const struct reg_sequence mt8365_dmic_iir_coeff[] = {
-	{ AFE_DMIC0_IIR_COEF_02_01, 0x00000000 },
-	{ AFE_DMIC0_IIR_COEF_04_03, 0x00003FB8 },
-	{ AFE_DMIC0_IIR_COEF_06_05, 0x3FB80000 },
-	{ AFE_DMIC0_IIR_COEF_08_07, 0x3FB80000 },
-	{ AFE_DMIC0_IIR_COEF_10_09, 0x0000C048 },
-	{ AFE_DMIC1_IIR_COEF_02_01, 0x00000000 },
-	{ AFE_DMIC1_IIR_COEF_04_03, 0x00003FB8 },
-	{ AFE_DMIC1_IIR_COEF_06_05, 0x3FB80000 },
-	{ AFE_DMIC1_IIR_COEF_08_07, 0x3FB80000 },
-	{ AFE_DMIC1_IIR_COEF_10_09, 0x0000C048 },
-	{ AFE_DMIC2_IIR_COEF_02_01, 0x00000000 },
-	{ AFE_DMIC2_IIR_COEF_04_03, 0x00003FB8 },
-	{ AFE_DMIC2_IIR_COEF_06_05, 0x3FB80000 },
-	{ AFE_DMIC2_IIR_COEF_08_07, 0x3FB80000 },
-	{ AFE_DMIC2_IIR_COEF_10_09, 0x0000C048 },
-	{ AFE_DMIC3_IIR_COEF_02_01, 0x00000000 },
-	{ AFE_DMIC3_IIR_COEF_04_03, 0x00003FB8 },
-	{ AFE_DMIC3_IIR_COEF_06_05, 0x3FB80000 },
-	{ AFE_DMIC3_IIR_COEF_08_07, 0x3FB80000 },
-	{ AFE_DMIC3_IIR_COEF_10_09, 0x0000C048 },
-};
-
-static int mt8365_dai_load_dmic_iir_coeff_table(struct mtk_base_afe *afe)
-{
-	return regmap_multi_reg_write(afe->regmap,
-				      mt8365_dmic_iir_coeff,
-				      ARRAY_SIZE(mt8365_dmic_iir_coeff));
-}
-
 static int mt8365_dai_configure_dmic(struct mtk_base_afe *afe,
 				     struct snd_pcm_substream *substream,
 				     struct snd_soc_dai *dai)

-- 
2.39.2


