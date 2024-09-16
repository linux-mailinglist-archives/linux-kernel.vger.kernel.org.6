Return-Path: <linux-kernel+bounces-330375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F19979D45
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53261F236C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B96146D65;
	Mon, 16 Sep 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YamsPc1t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49313C8E8;
	Mon, 16 Sep 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476815; cv=none; b=jdfg3+WUZmMKPSFqhLGvgmW+ObC+VwhAMoZOoUyv0u/v334wDuasGqn7gDiZIwYh2LTk3v5Nb2SAEbdb0Hj+fwqyPsc91WkD7XKiHP8qF60YGzJPmfHEUHzR8VZ+UYLi+Kjd4neA7MFtPREbQfsB6yLUJh6LB5uEbhIFVjQyUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476815; c=relaxed/simple;
	bh=xWtunqZUwm+Iv5DfIc9zQa49fXxa5eCLE0PCO9l16Y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgQP8+vD2UV4D+v6TcKNq73aBG0ZkEm912+7eHjFhvZR20kC7+YdXsPDU9h5rC1IM4CuRlc57RtDo/8ulqNOLujJkyvWJAZFnzv7b4JgRHVZ5s4J0b7SQXArr+fnOcx7VA+dtHfgNsWkC/KsTpH9A9FQ2QbPTxXNIiUmU3EEK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YamsPc1t; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726476813; x=1758012813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xWtunqZUwm+Iv5DfIc9zQa49fXxa5eCLE0PCO9l16Y4=;
  b=YamsPc1tZfPXzjYYBMZvRBnU/oDEoG8z2AmG21SlT2aqpjYDIShAi6j7
   JcY3rNI8sEeiI5bIg7dynEZblOYeWEnlV1ZxPyo3D9rHCFBFVq1NAyPVv
   ejUTxKsZ4Ca6+Ssk8Y3gcsGcVkkHaA6HCV0toDIL2B1vZJvzJXFwxQbBL
   51B2tgrReoWlKlCcH3rG9mRcP4x4Zzgt2z6bYtMlZGUGbe4rzcrORX+db
   ZLNBvdfokInJfL+AjBnQ/l0aElkV0ItgSRDSqSESc4nGMxDU53oYfyd/F
   3G4M/7O5aOHzGxsrA9wIh5Zilm3YAxkawxF4MCMwXAy/WXhbn+ez5oa5q
   Q==;
X-CSE-ConnectionGUID: PamDwLmaS1u4auhQg+WCVA==
X-CSE-MsgGUID: Xl7j1+o3Se2UIgOppZ5/Qg==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="32443040"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 01:53:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 01:53:12 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 01:53:09 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 1/2] ASoC: atmel: atmel_ssc_dai: Add stream names
Date: Mon, 16 Sep 2024 11:52:14 +0300
Message-ID: <20240916085214.11083-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916085214.11083-1-andrei.simion@microchip.com>
References: <20240916085214.11083-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Add required stream names for DPCM and future use-cases.

[andrei.simion@microchip.com: Adjust commit title. Reword commit message.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 3763454436c1..7047f17fe7a8 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -836,6 +836,7 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 
 static struct snd_soc_dai_driver atmel_ssc_dai = {
 		.playback = {
+			.stream_name = "Playback",
 			.channels_min = 1,
 			.channels_max = 2,
 			.rates = SNDRV_PCM_RATE_CONTINUOUS,
@@ -843,6 +844,7 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
 			.rate_max = 384000,
 			.formats = ATMEL_SSC_FORMATS,},
 		.capture = {
+			.stream_name = "Capture",
 			.channels_min = 1,
 			.channels_max = 2,
 			.rates = SNDRV_PCM_RATE_CONTINUOUS,
-- 
2.34.1


