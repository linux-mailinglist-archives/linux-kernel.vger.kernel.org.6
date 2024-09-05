Return-Path: <linux-kernel+bounces-316259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4396CD26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5F11C22305
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2714659A;
	Thu,  5 Sep 2024 03:22:24 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7A13DDDF;
	Thu,  5 Sep 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506544; cv=none; b=c7J14dEVlqou703jVQe0urKMDE4NxWa/u+/gPPHVeBGf60Gq7UbSykSck1b+LVMz8OWroVljzw5YP9kXpQUaYN8XD6auosLsONlV5s/d5uI4VNZoQpuuf8SxpsB4d+Aa6VaemI5MudlzgEzN+inHB2OHu0Aq6oPuxMDQHdIdzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506544; c=relaxed/simple;
	bh=u1xJdmO89Fdc1y5TyQpgCfPJJGT772u6ZMIA3pKy4MY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lYbXqh5u6ZL0LX7Hd7Utkt1XDcCxkvX2KjqnWG0E4b1va/bzM6ak0aUiiwusveU8EQCaEcaJ3tdwLV2cj5trBorpOKBLrdxPMKuzqALmqB3qJDphbB9P3EBSfTDJ1YoXIhnP8YL5pknYw43B63TfZH/VS1RtVc7GNDoyvfZ653M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3f+vkI9lm0SlcAQ--.17143S2;
	Thu, 05 Sep 2024 11:22:13 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: topology-test: Convert comma to semicolon
Date: Thu,  5 Sep 2024 11:21:48 +0800
Message-Id: <20240905032148.1929393-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3f+vkI9lm0SlcAQ--.17143S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy8Zw4ruw4fXr18Zw45GFg_yoWDJr1DpF
	1DAFy7WFs7XF1DJ3WkXryDJa4agF1xta1xAr47twn2qFWvkrn3ur1qq34xAFWYyanxXF1r
	JF15K347Ja9rt3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjD73PUUUUU==
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
 sound/soc/soc-topology-test.c | 132 +++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
index d62a02ec5896..a2b08568f4e8 100644
--- a/sound/soc/soc-topology-test.c
+++ b/sound/soc/soc-topology-test.c
@@ -244,12 +244,12 @@ static void snd_soc_tplg_test_load_with_null_comp(struct kunit *test)
 	kunit_comp->kunit = test;
 	kunit_comp->expect = -EINVAL; /* expect failure */
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -286,12 +286,12 @@ static void snd_soc_tplg_test_load_with_null_ops(struct kunit *test)
 	kunit_comp->kunit = test;
 	kunit_comp->expect = 0; /* expect success */
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -348,12 +348,12 @@ static void snd_soc_tplg_test_load_with_null_fw(struct kunit *test)
 	kunit_comp->kunit = test;
 	kunit_comp->expect = -EINVAL; /* expect failure */
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -396,12 +396,12 @@ static void snd_soc_tplg_test_load_empty_tplg(struct kunit *test)
 	kunit_comp->fw.data = (u8 *)data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -451,12 +451,12 @@ static void snd_soc_tplg_test_load_empty_tplg_bad_magic(struct kunit *test)
 	kunit_comp->fw.data = (u8 *)data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -506,12 +506,12 @@ static void snd_soc_tplg_test_load_empty_tplg_bad_abi(struct kunit *test)
 	kunit_comp->fw.data = (u8 *)data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -561,12 +561,12 @@ static void snd_soc_tplg_test_load_empty_tplg_bad_size(struct kunit *test)
 	kunit_comp->fw.data = (u8 *)data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -617,12 +617,12 @@ static void snd_soc_tplg_test_load_empty_tplg_bad_payload_size(struct kunit *tes
 	kunit_comp->fw.data = (u8 *)data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -665,12 +665,12 @@ static void snd_soc_tplg_test_load_pcm_tplg(struct kunit *test)
 	kunit_comp->fw.data = data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -715,12 +715,12 @@ static void snd_soc_tplg_test_load_pcm_tplg_reload_comp(struct kunit *test)
 	kunit_comp->fw.data = data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_register_card(&kunit_comp->card);
@@ -767,12 +767,12 @@ static void snd_soc_tplg_test_load_pcm_tplg_reload_card(struct kunit *test)
 	kunit_comp->fw.data = data;
 	kunit_comp->fw.size = size;
 
-	kunit_comp->card.dev = test_dev,
-	kunit_comp->card.name = "kunit-card",
-	kunit_comp->card.owner = THIS_MODULE,
-	kunit_comp->card.dai_link = kunit_dai_links,
-	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links),
-	kunit_comp->card.fully_routed = true,
+	kunit_comp->card.dev = test_dev;
+	kunit_comp->card.name = "kunit-card";
+	kunit_comp->card.owner = THIS_MODULE;
+	kunit_comp->card.dai_link = kunit_dai_links;
+	kunit_comp->card.num_links = ARRAY_SIZE(kunit_dai_links);
+	kunit_comp->card.fully_routed = true;
 
 	/* run test */
 	ret = snd_soc_component_initialize(&kunit_comp->comp, &test_component, test_dev);
-- 
2.25.1


