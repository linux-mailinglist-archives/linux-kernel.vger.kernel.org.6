Return-Path: <linux-kernel+bounces-324897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B115975247
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9018A1C22263
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD719F482;
	Wed, 11 Sep 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DXsvZCPq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422EE19E963;
	Wed, 11 Sep 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057803; cv=none; b=FyyXHwI2Yk4vg9ezvVosHcKWc7hor7pVj2AEBnLyC6UvW8xV/VYhW/47yigxLTEDzwoI06AybAb+1xjz5D9kLELXBM8Tv1/gFyh4xTlIC3f6Y0Z1RtmCVbIhCUbNMBGtETZSd94OoZQnELHdvfNnkdLd/K6gyzajFYYhU/nVRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057803; c=relaxed/simple;
	bh=PiygWBMWWgmiBJlhMmEQ0JypGcuuZJZ1K9IpKWur6s8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcm1tJZYkV0ajhfPg8IlrNr4rZtp76cepkvbGia7e5qKLMjue6QO4lGRWBA1SJHeKa9vRJOMG61sgxCuDcQVTeld8wxgJvaQnmFK4QqvC8ulqbfBzqCts1J7cn+vyWhB//SbeY95pRdpz6Y72+oM1Qw3W9woOyZPgvh9jkAYyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DXsvZCPq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726057801; x=1757593801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiygWBMWWgmiBJlhMmEQ0JypGcuuZJZ1K9IpKWur6s8=;
  b=DXsvZCPqJxaqvezyGvUIy7EaiDeQMuIVPoLaD+48VYGpvMY73H3kaj8p
   0wPx7CXpk29LGdxvADoJfjw20wLzqxlZRL5LAVC2DCXc510O1j0TwSXIj
   Ql2VlbOnA8d+WMsGkwpoGcQulneyl/Qvqy/c2+QezezxkamyHnyOgVUbE
   x3qzy56DxvnIoykw34oMImCVcpXBuN7UjDh9GUjFESEQrpBE449aAbL+l
   atApXjQsESvQq4+0TIR6drYElZPdVWvH/OxpL2l+DHqLmsAKJJpFC9OZA
   a3kJn0LCAAl8NExcZgpFn/970+XI1ontZBvjpv1J0pqF2vX8msMUYlwQD
   Q==;
X-CSE-ConnectionGUID: 9vUpuscIQ26YBlU3BRadaQ==
X-CSE-MsgGUID: rcOEGGVATUaFBm20lYIsUg==
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="32269432"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 05:29:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 05:29:23 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 05:29:20 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 3/3] ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls
Date: Wed, 11 Sep 2024 15:29:09 +0300
Message-ID: <20240911122909.133399-4-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122909.133399-1-andrei.simion@microchip.com>
References: <20240911122909.133399-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Avoid removing these controls, as doing so can cause issues if the stream
is initiated from another control. Ensure these controls remain intact when
the stream is started or finished. Instead of removing them, return an
-EBUSY error code to indicate that the controller is busy, especially when
the audio filter and the SINC filter are in use.

[andrei.simion@microchip.com: Reword the commit title and the commit
message. Adapt the code from kernel v6.1 -> v6.6 -> latest kernel version.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 78 ++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index d97d153ee375..758b3c550b97 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/spinlock.h>
 
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
@@ -113,6 +114,7 @@ struct mchp_pdmc_chmap {
 
 struct mchp_pdmc {
 	struct mic_map channel_mic_map[MCHP_PDMC_MAX_CHANNELS];
+	spinlock_t busy_lock;		/* lock protecting busy */
 	struct device *dev;
 	struct snd_dmaengine_dai_dma_data addr;
 	struct regmap *regmap;
@@ -124,6 +126,7 @@ struct mchp_pdmc {
 	int mic_no;
 	int sinc_order;
 	bool audio_filter_en;
+	u8 busy:1;
 };
 
 static const char *const mchp_pdmc_sinc_filter_order_text[] = {
@@ -167,10 +170,19 @@ static int mchp_pdmc_sinc_order_put(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 
 	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
-	if (val == dd->sinc_order)
+
+	spin_lock(&dd->busy_lock);
+	if (dd->busy) {
+		spin_unlock((&dd->busy_lock));
+		return -EBUSY;
+	}
+	if (val == dd->sinc_order) {
+		spin_unlock((&dd->busy_lock));
 		return 0;
+	}
 
 	dd->sinc_order = val;
+	spin_unlock((&dd->busy_lock));
 
 	return 1;
 }
@@ -193,10 +205,18 @@ static int mchp_pdmc_af_put(struct snd_kcontrol *kcontrol,
 	struct mchp_pdmc *dd = snd_soc_component_get_drvdata(component);
 	bool af = uvalue->value.integer.value[0] ? true : false;
 
-	if (dd->audio_filter_en == af)
+	spin_lock(&dd->busy_lock);
+	if (dd->busy) {
+		spin_unlock((&dd->busy_lock));
+		return -EBUSY;
+	}
+	if (dd->audio_filter_en == af) {
+		spin_unlock((&dd->busy_lock));
 		return 0;
+	}
 
 	dd->audio_filter_en = af;
+	spin_unlock((&dd->busy_lock));
 
 	return 1;
 }
@@ -379,52 +399,10 @@ static const struct snd_kcontrol_new mchp_pdmc_snd_controls[] = {
 	},
 };
 
-static int mchp_pdmc_close(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
-{
-	return snd_soc_add_component_controls(component, mchp_pdmc_snd_controls,
-					      ARRAY_SIZE(mchp_pdmc_snd_controls));
-}
-
-static int mchp_pdmc_open(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream)
-{
-	int i;
-
-	/* remove controls that can't be changed at runtime */
-	for (i = 0; i < ARRAY_SIZE(mchp_pdmc_snd_controls); i++) {
-		const struct snd_kcontrol_new *control = &mchp_pdmc_snd_controls[i];
-		struct snd_ctl_elem_id id;
-		int err;
-
-		if (component->name_prefix)
-			snprintf(id.name, sizeof(id.name), "%s %s", component->name_prefix,
-				 control->name);
-		else
-			strscpy(id.name, control->name, sizeof(id.name));
-
-		id.numid = 0;
-		id.iface = control->iface;
-		id.device = control->device;
-		id.subdevice = control->subdevice;
-		id.index = control->index;
-		err = snd_ctl_remove_id(component->card->snd_card, &id);
-		if (err < 0)
-			dev_err(component->dev, "%d: Failed to remove %s\n", err,
-				control->name);
-	}
-
-	return 0;
-}
-
 static const struct snd_soc_component_driver mchp_pdmc_dai_component = {
 	.name = "mchp-pdmc",
 	.controls = mchp_pdmc_snd_controls,
 	.num_controls = ARRAY_SIZE(mchp_pdmc_snd_controls),
-	.open = &mchp_pdmc_open,
-	.close = &mchp_pdmc_close,
-	.legacy_dai_naming = 1,
-	.trigger_start = SND_SOC_TRIGGER_ORDER_LDC,
 };
 
 static const unsigned int mchp_pdmc_1mic[] = {1};
@@ -587,6 +565,13 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
 			cfgr_val |= MCHP_PDMC_CFGR_BSSEL(i);
 	}
 
+	/*
+	 * from these point forward, we consider the controller busy, so the
+	 * audio filter and SINC order can't be changed
+	 */
+	spin_lock(&dd->busy_lock);
+	dd->busy = 1;
+	spin_unlock((&dd->busy_lock));
 	for (osr_start = dd->audio_filter_en ? 64 : 8;
 	     osr_start <= 256 && best_diff_rate; osr_start *= 2) {
 		long round_rate;
@@ -1099,6 +1084,7 @@ static int mchp_pdmc_probe(struct platform_device *pdev)
 	 */
 	dd->audio_filter_en = true;
 	dd->sinc_order = 3;
+	spin_lock_init(&dd->busy_lock);
 
 	dd->addr.addr = (dma_addr_t)res->start + MCHP_PDMC_RHR;
 	platform_set_drvdata(pdev, dd);
@@ -1143,6 +1129,10 @@ static void mchp_pdmc_remove(struct platform_device *pdev)
 {
 	struct mchp_pdmc *dd = platform_get_drvdata(pdev);
 
+	spin_lock(&dd->busy_lock);
+	dd->busy = 0;
+	spin_unlock((&dd->busy_lock));
+
 	if (!pm_runtime_status_suspended(dd->dev))
 		mchp_pdmc_runtime_suspend(dd->dev);
 
-- 
2.34.1


