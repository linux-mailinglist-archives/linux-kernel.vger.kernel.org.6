Return-Path: <linux-kernel+bounces-537825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADFA4918D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5718932BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0323DE;
	Fri, 28 Feb 2025 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol+CDSdK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BE1C3F04;
	Fri, 28 Feb 2025 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724110; cv=none; b=daViLffosBECh80UxfIRGbsg8TwUapN+0U+e05K1yJ3U4M9VNoW0803qrYX2AU4RvUiCFojkGjlwpCcd2I9gJGHmvm7J7HGhrDonoyXx0x57I06rBALks4ppKzBlqHVnDFDBmWrbwvoq9i6vXAOjWZGAmRVYqv63t9GIGS7Pr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724110; c=relaxed/simple;
	bh=/m+iPWmk6kJV3QtWKryVvX1MLMg/lAVfhh9LHnQYHeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByTD3xNDth1Sx/mqwMmo77XQCAyw79WvFQ1GRPsTnmFBh1drwcQl08JN/tHixV3YAABmxfX96VYfp8EKutTsxbCIrJgDN5QqljreXRc6ZWE/6WyNvXKh2l66tFJ0DjbdiLn3gdVlTuzC4mZjiFiXCJYGwLAqlkB/DnLk0LIrKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol+CDSdK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724108; x=1772260108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/m+iPWmk6kJV3QtWKryVvX1MLMg/lAVfhh9LHnQYHeM=;
  b=Ol+CDSdKJX2hg9IRdDf+JEWKxSdvM0BudrhDFr42hH9OC5TZ7x6Z5jyA
   eSSIUqLG0IcA7U3qQPqmz9SMjQEVZcZY26TrBc370IQLIxRUsmmbqXHFe
   LDYOHN7pJov4jRCQKZCLeg/8sLCHebN1V+J7c592LtZlgiGq7nc1iR1pX
   XH4Pwq4HVMkTQrH63ZdLAcLcwr5Lpg9CimMkphKf1ZrChVf6GFfVt7iYS
   JiVKxfDATd2Wuz01hNYTZSsBq2YPwav5J/7feBKPoObYX8eT2JZXZ68lj
   ZNZzEgA0jumNYiuW412q9xnyZicRshDA23lZDUGKcMlzVRv+0den+EMoN
   Q==;
X-CSE-ConnectionGUID: qMf+xPuOSHKfXzD8Hv95ZA==
X-CSE-MsgGUID: WtTjMFCzStCZ3qJODaIMxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560574"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:28 -0800
X-CSE-ConnectionGUID: V8HVlAwJTKy2pOmvOgzNFg==
X-CSE-MsgGUID: PyVto1ESQPWeZ2+SFMaQPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265233"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:22 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	andriy.shevchenko@linux.intel.com,
	cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	jbrunet@baylibre.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/6] ASoC: Intel: avs: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:07 +0530
Message-Id: <20250228062812.150004-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228062812.150004-1-raag.jadav@intel.com>
References: <20250228062812.150004-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, use source size
instead of destination.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/intel/avs/boards/da7219.c  | 3 ++-
 sound/soc/intel/avs/boards/es8336.c  | 3 ++-
 sound/soc/intel/avs/boards/nau8825.c | 3 ++-
 sound/soc/intel/avs/boards/rt274.c   | 3 ++-
 sound/soc/intel/avs/boards/rt286.c   | 3 ++-
 sound/soc/intel/avs/boards/rt298.c   | 3 ++-
 sound/soc/intel/avs/boards/rt5663.c  | 3 ++-
 sound/soc/intel/avs/boards/rt5682.c  | 3 ++-
 8 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 76078a7005b0..9507a96f26ac 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -113,7 +113,8 @@ static int avs_da7219_codec_init(struct snd_soc_pcm_runtime *runtime)
 	}
 
 	num_pins = ARRAY_SIZE(card_headset_pins);
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 426ce37105ae..6f3c4f6c9302 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -109,7 +109,8 @@ static int avs_es8336_codec_init(struct snd_soc_pcm_runtime *runtime)
 	data = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/nau8825.c b/sound/soc/intel/avs/boards/nau8825.c
index bf902540744c..6833eebd82d6 100644
--- a/sound/soc/intel/avs/boards/nau8825.c
+++ b/sound/soc/intel/avs/boards/nau8825.c
@@ -88,7 +88,8 @@ static int avs_nau8825_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
index 4b6c02a40204..f5caafc21861 100644
--- a/sound/soc/intel/avs/boards/rt274.c
+++ b/sound/soc/intel/avs/boards/rt274.c
@@ -98,7 +98,8 @@ static int avs_rt274_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt286.c b/sound/soc/intel/avs/boards/rt286.c
index e40563ca99fd..1eb0399c0fae 100644
--- a/sound/soc/intel/avs/boards/rt286.c
+++ b/sound/soc/intel/avs/boards/rt286.c
@@ -59,7 +59,8 @@ static int avs_rt286_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt298.c b/sound/soc/intel/avs/boards/rt298.c
index 94fce07c83f9..85269a3be981 100644
--- a/sound/soc/intel/avs/boards/rt298.c
+++ b/sound/soc/intel/avs/boards/rt298.c
@@ -70,7 +70,8 @@ static int avs_rt298_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt5663.c b/sound/soc/intel/avs/boards/rt5663.c
index b456b9d14665..e3310b3268ba 100644
--- a/sound/soc/intel/avs/boards/rt5663.c
+++ b/sound/soc/intel/avs/boards/rt5663.c
@@ -65,7 +65,8 @@ static int avs_rt5663_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = &priv->jack;
 	num_pins = ARRAY_SIZE(card_headset_pins);
 
-	pins = devm_kmemdup(card->dev, card_headset_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_headset_pins, num_pins,
+				  sizeof(card_headset_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/avs/boards/rt5682.c b/sound/soc/intel/avs/boards/rt5682.c
index 335960cfd7ba..339df0b944c1 100644
--- a/sound/soc/intel/avs/boards/rt5682.c
+++ b/sound/soc/intel/avs/boards/rt5682.c
@@ -102,7 +102,8 @@ static int avs_rt5682_codec_init(struct snd_soc_pcm_runtime *runtime)
 	jack = snd_soc_card_get_drvdata(card);
 	num_pins = ARRAY_SIZE(card_jack_pins);
 
-	pins = devm_kmemdup(card->dev, card_jack_pins, sizeof(*pins) * num_pins, GFP_KERNEL);
+	pins = devm_kmemdup_array(card->dev, card_jack_pins, num_pins,
+				  sizeof(card_jack_pins[0]), GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
-- 
2.34.1


