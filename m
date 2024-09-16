Return-Path: <linux-kernel+bounces-330693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023997A2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BA9B211E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4315574C;
	Mon, 16 Sep 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mFYv1Au9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B9153BEE;
	Mon, 16 Sep 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492785; cv=none; b=i4lcQLEBR1BVajc294b3212Xu52KPUkXoLzZiQT5VryovfjCXODVCowi929C312wSPjXcEi+IQN9ypq5vUgDeoeV5yDeN87UTeRvUBdFTM8yG9LOMU9enfWWdK7wUOm1UKbHbSVXBbq4ReKJ6/vz1Xo4TSmqoSgnFLdQeNJ1tY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492785; c=relaxed/simple;
	bh=u4Do+N2Ea5j3qFHQaToclHAxoELiSMZ8zNaCm7eJIwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fThLsdXc1fmOHiijt7NnU5gTEFrgYNIiHk13h/bSijnrDNcb+I3VkOoGzf1oEKqqjieu3Hd/qqlSIQwM28gvAFdj+ChzySzlGIpHoRIcB9ylcvVCL/v10hZNWJQwMurG52RIjbfyBPM/xMNGm12DCgfp0rV8nWfYF1fjJnaW4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mFYv1Au9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726492783; x=1758028783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4Do+N2Ea5j3qFHQaToclHAxoELiSMZ8zNaCm7eJIwY=;
  b=mFYv1Au9Ht5z34jnyNiYqKEW4WSGLytzaOHT28T0vk8/hzgKUcFbew+W
   uX11GdKC7g+d3XMfyFw98BWnj83lS20PAYp86NiAI75w7zkFGs9wmoobz
   w5NLvnmO6RkYRM5iu/t+Dzo3XBu9ctO/S856yH1rSFGJYgHd20gVPH3gh
   4aUrWYMl3tsza8DZLhn1uLryBY1rO8Sxf1GjcvLGwaYqcdBdjwMvH0Abz
   E6oviSffuKWiJCOB7Vz/kS1kfbHljyqevJCW6jcFDyWKWsktJCW+dKBgg
   fa5FGVSQhtSWqIpx7uusie5F3uQbj+Ut+P9C8kuw0aJaGc1cg9mW4u1L4
   A==;
X-CSE-ConnectionGUID: eEp7On7+SIiSQUXcJYfpmQ==
X-CSE-MsgGUID: G1Q9K5xbT6qTVD8dcFEO6w==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="32452553"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 06:19:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 06:19:32 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 06:19:29 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH v2 1/2] ASoC: atmel: atmel_ssc_dai: Add stream names
Date: Mon, 16 Sep 2024 16:19:09 +0300
Message-ID: <20240916131910.22680-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916131910.22680-1-andrei.simion@microchip.com>
References: <20240916131910.22680-1-andrei.simion@microchip.com>
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

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- add Reviewed-by tag
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


