Return-Path: <linux-kernel+bounces-324895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648B975240
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2730E1F239ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2593188A14;
	Wed, 11 Sep 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kefj+On9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0519E981;
	Wed, 11 Sep 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057801; cv=none; b=LXSs/AQGlFdNnMSfRnjfxVzylAH+6ueSE/9gM6euoVKqLXg/pQYOkBMi5LrO+7ldD/2WNa6uOeNexefWF6MEdvilViDujYd2ox9zqNVOI7/PCdUAvMihUiPEwAfat2w5tkOtnFOeDoFoyzJ9zXYHCMQwLSRp0pNw3PxNjVvDUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057801; c=relaxed/simple;
	bh=otB2gyp0DjafuKuP6eN9+hCMx0oFkm3tLV8V7z0L5wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZCGQ5Gr2zEX4r0fQ/soRqnaQwC2NJ6PDEtE+hRiXT+ORtGp17SpUBNdS1Cz3bdjcVFEtnHBZFLPq3owawLlSO2su234XSux5F3nwKAOInE5OoE/S/3JqtW2DDJD6ty5LziXbbGCReA+y4QrtDaHheS9VqXcqyWHn0jPwH9jZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kefj+On9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726057799; x=1757593799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=otB2gyp0DjafuKuP6eN9+hCMx0oFkm3tLV8V7z0L5wk=;
  b=Kefj+On9wIgYy5WLKoquKHOgKhMFz9cDDqv4VqyeDYL/xotdtcJEGdJu
   6VoRalIHkDWqt7tJ+JCH9xcfgPx8Nge5Mzn91QEhGZFmvmDSuPoyV25vi
   X8KpwbaoCeqB9Bg8ixRC091wuH1CrZvlMEkllWNB4oUbnD0KuYXqGBO9s
   /A4Zf2nYpql0h27tXOUE0ipdqWYHwGs3mQk0J9WTuyKdM5AqdWaPb93Df
   5RDrBN8b9nuQaKXLEIi7l2Zz4QE5XRvb3GnDswcJp/zref08yz/qEtAz/
   hbR9Si0w0lOIjDa7X1ph/QwHNMuzC00mwUP1QYOMkMVunyc7wTEitbyod
   A==;
X-CSE-ConnectionGUID: 9vUpuscIQ26YBlU3BRadaQ==
X-CSE-MsgGUID: icmd1AtdT1CZxL1xIvnPOg==
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="32269431"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 05:29:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 05:29:17 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 05:29:14 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 1/3] ASoC: atmel: mchp-pdmc: Improve maxburst calculation for better performance
Date: Wed, 11 Sep 2024 15:29:07 +0300
Message-ID: <20240911122909.133399-2-andrei.simion@microchip.com>
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

Improve the DMA descriptor calculation by dividing the period size by the
product of sample size and DMA chunk size, rather than just DMA chunk size.
Ensure that all DMA descriptors start from a well-aligned address to
improve the reliability and efficiency of DMA operations and avoid
potential issues related to misaligned descriptors.

[andrei.simion@microchip.com: Adjust the commit title. Reword the commit
message. Add MACROS for each DMA size chunk supported by mchp-pdmc.
Add DMA_BURST_ALIGNED preprocesor function to check the alignment of the
DMA burst.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 39 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index 260074018da9..7a5585839c1d 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -90,6 +90,15 @@
 #define MCHP_PDMC_DS_NO			2
 #define MCHP_PDMC_EDGE_NO		2
 
+/*
+ * ---- DMA chunk size allowed ----
+ */
+#define MCHP_PDMC_DMA_8_WORD_CHUNK			8
+#define MCHP_PDMC_DMA_4_WORD_CHUNK			4
+#define MCHP_PDMC_DMA_2_WORD_CHUNK			2
+#define MCHP_PDMC_DMA_1_WORD_CHUNK			1
+#define DMA_BURST_ALIGNED(_p, _s, _w)		!(_p % (_s * _w))
+
 struct mic_map {
 	int ds_pos;
 	int clk_edge;
@@ -511,15 +520,18 @@ static u32 mchp_pdmc_mr_set_osr(int audio_filter_en, unsigned int osr)
 	return 0;
 }
 
-static inline int mchp_pdmc_period_to_maxburst(int period_size)
+static inline int mchp_pdmc_period_to_maxburst(int period_size, int sample_size)
 {
-	if (!(period_size % 8))
-		return 8;
-	if (!(period_size % 4))
-		return 4;
-	if (!(period_size % 2))
-		return 2;
-	return 1;
+	int p_size = period_size;
+	int s_size = sample_size;
+
+	if (DMA_BURST_ALIGNED(p_size, s_size, MCHP_PDMC_DMA_8_WORD_CHUNK))
+		return MCHP_PDMC_DMA_8_WORD_CHUNK;
+	if (DMA_BURST_ALIGNED(p_size, s_size, MCHP_PDMC_DMA_4_WORD_CHUNK))
+		return MCHP_PDMC_DMA_4_WORD_CHUNK;
+	if (DMA_BURST_ALIGNED(p_size, s_size, MCHP_PDMC_DMA_2_WORD_CHUNK))
+		return MCHP_PDMC_DMA_2_WORD_CHUNK;
+	return MCHP_PDMC_DMA_1_WORD_CHUNK;
 }
 
 static struct snd_pcm_chmap_elem mchp_pdmc_std_chmaps[] = {
@@ -547,14 +559,18 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int osr = 0, osr_start;
 	unsigned int fs = params_rate(params);
+	int sample_bytes = params_physical_width(params) / 8;
+	int period_bytes = params_period_size(params) *
+		params_channels(params) * sample_bytes;
+	int maxburst;
 	u32 mr_val = 0;
 	u32 cfgr_val = 0;
 	int i;
 	int ret;
 
-	dev_dbg(comp->dev, "%s() rate=%u format=%#x width=%u channels=%u\n",
+	dev_dbg(comp->dev, "%s() rate=%u format=%#x width=%u channels=%u period_bytes=%d\n",
 		__func__, params_rate(params), params_format(params),
-		params_width(params), params_channels(params));
+		params_width(params), params_channels(params), period_bytes);
 
 	if (channels > dd->mic_no) {
 		dev_err(comp->dev, "more channels %u than microphones %d\n",
@@ -608,7 +624,8 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
 
 	mr_val |= FIELD_PREP(MCHP_PDMC_MR_SINCORDER_MASK, dd->sinc_order);
 
-	dd->addr.maxburst = mchp_pdmc_period_to_maxburst(snd_pcm_lib_period_bytes(substream));
+	maxburst = mchp_pdmc_period_to_maxburst(period_bytes, sample_bytes);
+	dd->addr.maxburst = maxburst;
 	mr_val |= FIELD_PREP(MCHP_PDMC_MR_CHUNK_MASK, dd->addr.maxburst);
 	dev_dbg(comp->dev, "maxburst set to %d\n", dd->addr.maxburst);
 
-- 
2.34.1


