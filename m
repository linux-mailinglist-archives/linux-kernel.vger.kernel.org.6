Return-Path: <linux-kernel+bounces-271835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FF9453B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A81285872
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765C14AD30;
	Thu,  1 Aug 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Qqgqn1Oa"
Received: from msa.smtpout.orange.fr (smtp-68.smtpout.orange.fr [80.12.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D94087C;
	Thu,  1 Aug 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544296; cv=none; b=sdSTZ8soI5EDMtNQpLqqU7kAAtyv25s0XGgr1l4FRc4O/E8rxhYxcJKLCy7MKbuLl4P6Y/m1P9PTJJBcBJeQEPQNjm1y2Oq48GGPxR2jHYIFr7pnek3p27IZByEKggluKVuz9nPLx5P3uDbvMijn5Eh/Bn2RYKByREb7gNhfhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544296; c=relaxed/simple;
	bh=EGtTdG06q54tUVLk9dy19W8h/8U7Ex/ivN9IcO4WnFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1axKcH2fn80PkJWu88RIU+mImtmEaepy5S1L0yNQGPBy/wrHgO5U4njC105J4HodbzDxdRzhAeHlodE3/cNVAwSQNZl16k+vO1bxqa2AtGARe97dnybr+W9ASCvacdlc/f4y8YWS/ow/0ND78wCFd7pwB59jzP1NY/jbGqoT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Qqgqn1Oa; arc=none smtp.client-ip=80.12.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ZcRAsb45oHTrpZcRBswjVX; Thu, 01 Aug 2024 22:30:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722544214;
	bh=lJvbL/RKiz+fXVASXN3xHzswUs3ZsRGDBhGGSp81aoM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Qqgqn1OayxIR9wS3XZ680BoIHbEpnZEc+D8mls8heR15HNAIt91pUfzBYdHeZkpnN
	 cSZ6Uiq+fQg45df927szraFm0taKVVCyzE3u0V9IqaXGS33DKMZjoDX/QKwfWcVmRU
	 L4ZdG/DmYo0x86mH7HsrELz7GbcKLbWn7jHYhk1NYtxZ7Y54vWBErhTnLtnWphFwx3
	 5oUFYvdcD2RqLdBKEhGk92YBBW7xqGX3MAw3reBn68i3fBcC5rHo4seUyJaB1ApNaD
	 vBTSVQNMEM7xlXOMldZSdit4JEQqQ+6/Lt2TKBQU1Zn6frCXDu7tisGl/nwrxIJ2N1
	 r1cIgLeXTXMQA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2024 22:30:14 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ckeepax@opensource.cirrus.com,
	javier.carrasco.cruz@gmail.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: sti-sas: Constify snd_soc_component_driver struct
Date: Thu,  1 Aug 2024 22:30:05 +0200
Message-ID: <2c08558813e3bbfae0a5302199cf6ca226e7cde1.1722544073.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to constify `snd_soc_component_driver` struct, simplify the logic
and the `sti_sas_dev_data` struct.

Since commit 165a57a3df02 ("ASoC: sti-sas: clean legacy in sti-sas") only
only chip is supported and `sti_sas_driver` can be fully defined at
compilation time.

Before:
======
   text	   data	    bss	    dec	    hex	filename
   8033	   1547	     16	   9596	   257c	sound/soc/codecs/sti-sas.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   8257	   1163	     16	   9436	   24dc	sound/soc/codecs/sti-sas.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.

See discussion at [1].

[1]: https://lore.kernel.org/all/ZqNawRmAqBRLIoQq@opensource.cirrus.com/
---
 sound/soc/codecs/sti-sas.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index c421906a0694..4ab15be69f3a 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -63,10 +63,6 @@ struct sti_spdif_audio {
 struct sti_sas_dev_data {
 	const struct regmap_config *regmap;
 	const struct snd_soc_dai_ops *dac_ops;  /* DAC function callbacks */
-	const struct snd_soc_dapm_widget *dapm_widgets; /* dapms declaration */
-	const int num_dapm_widgets; /* dapms declaration */
-	const struct snd_soc_dapm_route *dapm_routes; /* route declaration */
-	const int num_dapm_routes; /* route declaration */
 };
 
 /* driver data structure */
@@ -324,10 +320,6 @@ static const struct regmap_config stih407_sas_regmap = {
 static const struct sti_sas_dev_data stih407_data = {
 	.regmap = &stih407_sas_regmap,
 	.dac_ops = &stih407_dac_ops,
-	.dapm_widgets = stih407_sas_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(stih407_sas_dapm_widgets),
-	.dapm_routes =	stih407_sas_route,
-	.num_dapm_routes = ARRAY_SIZE(stih407_sas_route),
 };
 
 static struct snd_soc_dai_driver sti_sas_dai[] = {
@@ -386,12 +378,16 @@ static int sti_sas_component_probe(struct snd_soc_component *component)
 	return sti_sas_init_sas_registers(component, drvdata);
 }
 
-static struct snd_soc_component_driver sti_sas_driver = {
+static const struct snd_soc_component_driver sti_sas_driver = {
 	.probe			= sti_sas_component_probe,
 	.resume			= sti_sas_resume,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
+	.dapm_widgets		= stih407_sas_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(stih407_sas_dapm_widgets),
+	.dapm_routes		= stih407_sas_route,
+	.num_dapm_routes	= ARRAY_SIZE(stih407_sas_route),
 };
 
 static const struct of_device_id sti_sas_dev_match[] = {
@@ -446,13 +442,6 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 
 	sti_sas_dai[STI_SAS_DAI_ANALOG_OUT].ops = drvdata->dev_data->dac_ops;
 
-	/* Set dapms*/
-	sti_sas_driver.dapm_widgets = drvdata->dev_data->dapm_widgets;
-	sti_sas_driver.num_dapm_widgets = drvdata->dev_data->num_dapm_widgets;
-
-	sti_sas_driver.dapm_routes = drvdata->dev_data->dapm_routes;
-	sti_sas_driver.num_dapm_routes = drvdata->dev_data->num_dapm_routes;
-
 	/* Store context */
 	dev_set_drvdata(&pdev->dev, drvdata);
 
-- 
2.45.2


