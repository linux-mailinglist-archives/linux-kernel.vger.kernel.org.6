Return-Path: <linux-kernel+bounces-330377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F61979D47
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192E01F23706
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB071494A5;
	Mon, 16 Sep 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QCmkrWov"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823A146586;
	Mon, 16 Sep 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476817; cv=none; b=C925ldfxewSJEGHx6KN/EQp7foPEyLNsVp748bFJPI9hwW0x6K9QENVWmsFmCWRCqWVlgmG6VdAbvj4Ybl1udKjDlqut9ADF0lz46Ic2m/2okhBCQ/rT+9yHtJwLTN0MtIpGsTyDbgACL9i3IGs89pFbAcubNmg9LsBnm55OX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476817; c=relaxed/simple;
	bh=wLNyCCa3uGukd/YUJXnpdJORp6fFs7Bh0HkU+aXmQck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4WyObsI1zPDFXJO4mf1Oc0xsAA8yZ0Frm/JoXA7g1Pv13pC+9ev2yrva48YeWR/QR+lixGMrAe6qENnAbrDrVNDwENBU5Phs/0I9vV21yhFe/5I84Wes2ALe56hdehTfHZ05qpK5t3NngGAj5aQksEu8CSpQGfTY8Mf7fqEMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QCmkrWov; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726476816; x=1758012816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLNyCCa3uGukd/YUJXnpdJORp6fFs7Bh0HkU+aXmQck=;
  b=QCmkrWovvqI6ZWimZhOmWs+4b7/HLomZy+Qp1OLnK8ft7b/735BcpeiX
   W6u7eWRuvjIdhw5uW/iJZFLIqThq04d1Uh1peh3GKORj/MQzrNMPn8kLA
   WPG3gKWIT1qjPXbMYVbzRoUlJpa+4apE6rH9U/tYT0sSRDsDHDVNLyea8
   z2gtp291MBcOe1E3Y8Pgr0M64oHMYEOLzW1tST/efcwDihoNaNR0F+iLP
   EeYKzJWum9EhHc9NH598feWxh+51+FOW0ONwgpYI1raXIfRBy/+oWkrYL
   gdsT1bNpAgX4MCR9eSj3vNlaawuUdyChFsMrowosOvbjD8p4lXaqiJSNf
   g==;
X-CSE-ConnectionGUID: PamDwLmaS1u4auhQg+WCVA==
X-CSE-MsgGUID: PUDmAxjDRdG9WOIsrMHnQA==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="32443041"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 01:53:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 01:53:15 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 01:53:12 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH 2/2] ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel limitation
Date: Mon, 16 Sep 2024 11:52:15 +0300
Message-ID: <20240916085214.11083-3-andrei.simion@microchip.com>
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

Drop S24_LE format because it is not supported if more than 2 channels
(of TDM slots) are used. This limitation makes it impractical for use cases
requiring more than 2 TDM slots, leading to potential issues in
multi-channel configurations.

[andrei.simion@microchip.com: Reword the commit title and the commit
message.]

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 7047f17fe7a8..475e7579c64c 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -822,7 +822,7 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
 }
 
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
-			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+			   SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 	.startup	= atmel_ssc_startup,
-- 
2.34.1


