Return-Path: <linux-kernel+bounces-316782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440496D4DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E021B26CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E0194AC7;
	Thu,  5 Sep 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RRY+0NJz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252F192D73;
	Thu,  5 Sep 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530227; cv=none; b=PymOaRKd4TB96RRsyOmLnDy/sjl1kEejru0basqJ6raOfwW1jHWnRibboYDUu7c8Rykxrncj3lQrBO5B3hUYYtl724aOMPpCwQqA19n9f614XkuwVbr4pIDDCUuaZkYkMmHipdnr69sktyTiZej7vOvx0V4jYmhIUT3ULrIGVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530227; c=relaxed/simple;
	bh=8qoKR4OXZ7Wgy4H3AAmtUwklGSIL4J9Jd0IV6fK4sOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T0cv1mbN5PuSjGF3Pu5U0z5zT+4OnoKRkTzPOsOL620lCnj8tD5PNtfpuCgSv0t+eSu99F/Z2jOPEQIc4Pm5j7S5HDZgZexy/oFxBbTbsnIqzT7co6Bvp+c1aRyzxn7o4xVtmPMPhvjgWxI1eQ+w1xGVWWVajql3MLA3WdLNhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RRY+0NJz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725530225; x=1757066225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8qoKR4OXZ7Wgy4H3AAmtUwklGSIL4J9Jd0IV6fK4sOc=;
  b=RRY+0NJzF0I9L3ligRbLCQW4TCjhXBk4BW3A8xTS/oIqgzk63pg6qikG
   f7aAyEH2SBsbV6s6WQYJlFcmVeleIWfKTPZISIbmvoBniLJP/TmfzH9oj
   bCZBKftRZ7gFJHNrMMcAFRnT5i7Y+611vrPrhtkk4sqqEzcbAxJDEjq3L
   iHwMOvQHbI01ZJYNjHoh1jmXZ6hmV3HXtILRMNQuQ/FI7BLsLZirKpfg6
   IGc/cbp9JlyIhw0NC7CnQhSrBG4GLXeVTT9iBAuShH0vewOPszjsN4puA
   8lJmQSI0G8FVv2z9r9Mx3NPHSMgb9yyMObVp5Gwoe3ohPTwIBksWd+SaC
   Q==;
X-CSE-ConnectionGUID: 8AyyTrCqQSGMj104kSMPQw==
X-CSE-MsgGUID: jpWvbnd4T1yvQ3SdJQSknQ==
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34458244"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2024 02:57:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Sep 2024 02:56:40 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Sep 2024 02:56:37 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH] ASoC: atmel: mchp-i2s-mcc: Improve maxburst calculation for better performance
Date: Thu, 5 Sep 2024 12:56:33 +0300
Message-ID: <20240905095633.113784-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

The period size represents the size of the DMA descriptor. To ensure all
DMA descriptors start from a well-aligned address, the period size must
be divided by (sample size * maxburst), not just by maxburst.
This adjustment allows for computing a higher maxburst value, thereby
increasing the performance of the DMA transfer.
Previously, snd_pcm_lib_period_bytes() returned 0 because the runtime HW
parameters are computed after the hw_params() callbacks are used.
To address this, we now use params_*() functions to compute the period
size accurately. This change optimizes the DMA transfer performance by
ensuring proper alignment and efficient use of maxburst values.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
[andrei.simion@microchip.com: Reword commit message and commit title.
Add macros with values for maximum DMA chunk size allowed.
Add DMA_BURST_ALIGNED preprocessor function to check the alignment of the
DMA burst]
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 38 +++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 193dd7acceb0..35a56b266b8d 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -221,6 +221,15 @@
 #define MCHP_I2SMCC_MAX_CHANNELS		8
 #define MCHP_I2MCC_TDM_SLOT_WIDTH		32
 
+/*
+ * ---- DMA chunk size allowed ----
+ */
+#define MCHP_I2SMCC_DMA_8_WORD_CHUNK			8
+#define MCHP_I2SMCC_DMA_4_WORD_CHUNK			4
+#define MCHP_I2SMCC_DMA_2_WORD_CHUNK			2
+#define MCHP_I2SMCC_DMA_1_WORD_CHUNK			1
+#define DMA_BURST_ALIGNED(_p, _s, _w)		!(_p % (_s * _w))
+
 static const struct regmap_config mchp_i2s_mcc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -504,12 +513,30 @@ static int mchp_i2s_mcc_is_running(struct mchp_i2s_mcc_dev *dev)
 	return !!(sr & (MCHP_I2SMCC_SR_TXEN | MCHP_I2SMCC_SR_RXEN));
 }
 
+static inline int mchp_i2s_mcc_period_to_maxburst(int period_size, int sample_size)
+{
+	int p_size = period_size;
+	int s_size = sample_size;
+
+	if (DMA_BURST_ALIGNED(p_size, s_size, MCHP_I2SMCC_DMA_8_WORD_CHUNK))
+		return MCHP_I2SMCC_DMA_8_WORD_CHUNK;
+	if (DMA_BURST_ALIGNED(p_size, s_size, MCHP_I2SMCC_DMA_4_WORD_CHUNK))
+		return MCHP_I2SMCC_DMA_4_WORD_CHUNK;
+	if (DMA_BURST_ALIGNED(p_size, s_size, MCHP_I2SMCC_DMA_2_WORD_CHUNK))
+		return MCHP_I2SMCC_DMA_2_WORD_CHUNK;
+	return MCHP_I2SMCC_DMA_1_WORD_CHUNK;
+}
+
 static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
 	unsigned long rate = 0;
 	struct mchp_i2s_mcc_dev *dev = snd_soc_dai_get_drvdata(dai);
+	int sample_bytes = params_physical_width(params) / 8;
+	int period_bytes = params_period_size(params) *
+		params_channels(params) * sample_bytes;
+	int maxburst;
 	u32 mra = 0;
 	u32 mrb = 0;
 	unsigned int channels = params_channels(params);
@@ -519,9 +546,9 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
-	dev_dbg(dev->dev, "%s() rate=%u format=%#x width=%u channels=%u\n",
+	dev_dbg(dev->dev, "%s() rate=%u format=%#x width=%u channels=%u period_bytes=%d\n",
 		__func__, params_rate(params), params_format(params),
-		params_width(params), params_channels(params));
+		params_width(params), params_channels(params), period_bytes);
 
 	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -630,11 +657,12 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	 * We must have the same burst size configured
 	 * in the DMA transfer and in out IP
 	 */
-	mrb |= MCHP_I2SMCC_MRB_DMACHUNK(channels);
+	maxburst = mchp_i2s_mcc_period_to_maxburst(period_bytes, sample_bytes);
+	mrb |= MCHP_I2SMCC_MRB_DMACHUNK(maxburst);
 	if (is_playback)
-		dev->playback.maxburst = 1 << (fls(channels) - 1);
+		dev->playback.maxburst = maxburst;
 	else
-		dev->capture.maxburst = 1 << (fls(channels) - 1);
+		dev->capture.maxburst = maxburst;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:

base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba
-- 
2.34.1


