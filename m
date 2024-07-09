Return-Path: <linux-kernel+bounces-245110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C600B92AE79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25491C2122B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3038F4501A;
	Tue,  9 Jul 2024 03:12:51 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EB4A15;
	Tue,  9 Jul 2024 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494770; cv=none; b=Q4svF/l0JZ8O/d4Ph4DVIlplQNbAD75bP43ZOyjWg2zjU9/E8+w9KgtatNK3A+omwXGxwafI4q5JaLDT+yNIoQgpj9GxFp4Yf6tGxZkwe04nCu5E2v6TKxnBgFtj6D3on6DdOrZ4iA2GQcILPeVEudyfRLycoy86PHBCKpFtwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494770; c=relaxed/simple;
	bh=gG7VPVdC1NgmfJ9wBm/I1DUwm9R5dW8xyB+Gsar80dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pmX4Ae/ruCJjDZuZts0kQ9E5JgzX9FitYv6eavHWUkGP2FArhcleCxAzDT23wnA/RQuZT6VEqNtbuFeLhehJAACByEw00w4DHFXv5Hbr7DR1B8nSqa650J8p421nDoh66dib8qiEnHnwipD4b8IeDdrkCgHJWTOI/Kcg0qAd8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADnx0ydqoxmqBVcAg--.237S2;
	Tue, 09 Jul 2024 11:12:29 +0800 (CST)
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
	ckeepax@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: Intel: sof_sdw: Convert comma to semicolon
Date: Tue,  9 Jul 2024 11:09:21 +0800
Message-Id: <20240709030921.585740-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnx0ydqoxmqBVcAg--.237S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr4rKw4DKF4UArb_yoW3KrbEy3
	Z3Ga4kuryUXr4Ivr15J3yavF4qgFZ2vF1UW3Z0gr4qyr9rJrWfX3Z3Jrs3urn5XrW8uFy2
	yFykZw4qv3y0qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYdgADUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/intel/boards/sof_sdw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index e94849b84a6b..e5feaef669d1 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -2136,9 +2136,9 @@ static int mc_probe(struct platform_device *pdev)
 
 	card = &ctx->card;
 	card->dev = &pdev->dev;
-	card->name = "soundwire",
-	card->owner = THIS_MODULE,
-	card->late_probe = sof_sdw_card_late_probe,
+	card->name = "soundwire";
+	card->owner = THIS_MODULE;
+	card->late_probe = sof_sdw_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, ctx);
 
-- 
2.25.1


