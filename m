Return-Path: <linux-kernel+bounces-316206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928F96CC92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCAF1F26700
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAFC131182;
	Thu,  5 Sep 2024 02:21:38 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E5C2C6;
	Thu,  5 Sep 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502898; cv=none; b=kEMBiwXOgP59FRVw+zkDNPGC3Ai41XbSk96vhBsytaXu4byh2vtrioGMLMQc8ftKP1fVOOGBgYVf4REGJlRlWsgvf2pFbTxvqyfOldkDQjFyr0Yr5EiXyiva3wdz1EI52XpljrIVoDEeuuUdNZ51G5V0AOT5Bf5So8mi9WPqd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502898; c=relaxed/simple;
	bh=sIIPZUk/McFrEGOpzaiTsFXpvninZCb+Pc2SfB0iyAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a4PES9wJN6eXDi5/AvVrpt+s0LIvxKapvLmg3jAfyQQmesHgmOrCIKjWcD58JNnj+1Pz6Y3A7NcQ4/+sOSLoJWy9N5oLKkAdjRMdoSZP/HjutRJR8gofRxALUHNRPtp6b2GXMehgz/zhMjPS7+yHKkl85Hdx1QBKc5ywiyc3mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADnyuqeFdlmBX9ZAQ--.17465S2;
	Thu, 05 Sep 2024 10:21:18 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	brent.lu@intel.com,
	kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: Intel: skl_hda_dsp_generic: convert comma to semicolon
Date: Thu,  5 Sep 2024 10:20:17 +0800
Message-Id: <20240905022017.1642550-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnyuqeFdlmBX9ZAQ--.17465S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4kCw1kGrg_yoW8XFWfpF
	1v9wn8KF98Xa4vvay7XF17CasxXan7Ja47Ww45J34qqF1rXw1rurWqgFn7ZFWUKF93Gr1j
	vrsrKrykKFyfAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY
	1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_Gr1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUUXdbUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 225867bb3310..8e104874d58c 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -217,14 +217,14 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card = &ctx->card;
-	card->name = "hda-dsp",
-	card->owner = THIS_MODULE,
-	card->dai_link = skl_hda_be_dai_links,
-	card->dapm_widgets = skl_hda_widgets,
-	card->dapm_routes = skl_hda_map,
-	card->add_dai_link = skl_hda_add_dai_link,
-	card->fully_routed = true,
-	card->late_probe = skl_hda_card_late_probe,
+	card->name = "hda-dsp";
+	card->owner = THIS_MODULE;
+	card->dai_link = skl_hda_be_dai_links;
+	card->dapm_widgets = skl_hda_widgets;
+	card->dapm_routes = skl_hda_map;
+	card->add_dai_link = skl_hda_add_dai_link;
+	card->fully_routed = true;
+	card->late_probe = skl_hda_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, ctx);
 
-- 
2.25.1


