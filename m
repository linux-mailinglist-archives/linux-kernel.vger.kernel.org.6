Return-Path: <linux-kernel+bounces-554830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97113A5A01D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122C71889542
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F1233D7C;
	Mon, 10 Mar 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="C+CiSMki"
Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352452D023;
	Mon, 10 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628762; cv=none; b=YSJTEDIrqhKoBCXzUC77vpQzz9xxoOjxDwNnmedhMsAOrWoRpKIEa2RuS8VKeCciDQc2kmuox23s43d8wL9AZolkOklwT2dgVRfLvt9afwyF+motOLJ4v8xg9zuLYtx5/vwHpuP7Haca8Ps7wGqnzLvqy7tBW0kMUStmu26k+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628762; c=relaxed/simple;
	bh=81exlbrKrAHzsP57co/n0cRIIxSIC84sZVYHc6JttgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jK/c6J3e9a3RhTGj/vrU01kA0x+F5Wy6uemL1egrJjF8JsYBTp/+PNP4WQtLY1v6CmQCEJ4p/3rQDFFBtrhRvJrgopFeSnWcwRMVS6bjsyI3UesmYmbgVfaZp+cVvyDxlztHIviZCZHXwBYZ+j2wnlNkt+mvfFUAtTqZAwHXbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=C+CiSMki; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rhCDtY8LcTyMMrhCGtfIxK; Mon, 10 Mar 2025 18:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741628750;
	bh=1GNYch+jlMIagTJlEcHgDvxgubC3mGdGRHQ6RC9ibUM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=C+CiSMkiY2hewsNoHt1eNx5UF5P9KdHv7/SFlDHh14FT2/kFyG8A75NLHawel00Fg
	 NGEfWT3NZXGhcR28ePf9mkLiDn3NOEO9+MN3hPzRTY+Ymu3psSv5UF0nD/n+YIzNMf
	 xU74/pfuaoL5tImF7WZc+A5vOQMpKHQ4Q1ytxhafXU83DT0juxyFKyp814jvc2zv73
	 Rk2S9rGQc3U28YDKuBkLig5krCGJK6Q+foqpCzT5Hiiw7ipYddSyUOEiglkPSi0/Xp
	 X4sj69+76hEi/l7lBo4LP5gV/gaVtAb3C84V16SCS+MkzjQrVe6RoePNoTaHmtNzpR
	 rcZyd9ihuWSlg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 10 Mar 2025 18:45:50 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: amadeuszx.slawinski@linux.intel.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH v2] ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
Date: Mon, 10 Mar 2025 18:45:36 +0100
Message-ID: <5139ba1ab8c4c157ce04e56096a0f54a1683195c.1741549792.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Free some resources in the error handling path of the probe, as already
done in the remove function.

Fixes: e3523e01869d ("ASoC: wm0010: Add initial wm0010 DSP driver")
Fixes: fd8b96574456 ("ASoC: wm0010: Clear IRQ as wake source and include missing header")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.

Changes in v2:
   - Fix a typo in a label (s/free_irq/free_riq)   [Amadeusz Sławiński]

v1: https://lore.kernel.org/all/ee39ba19b8c4c157ce04e06096a8f54016831959.1741549792.git.christophe.jaillet@wanadoo.fr/
---
 sound/soc/codecs/wm0010.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index edd2cb185c42..28b43fe4dc32 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -920,7 +920,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(wm0010->dev, "Failed to set IRQ %d as wake source: %d\n",
 			irq, ret);
-		return ret;
+		goto free_irq;
 	}
 
 	if (spi->max_speed_hz)
@@ -932,9 +932,18 @@ static int wm0010_spi_probe(struct spi_device *spi)
 				     &soc_component_dev_wm0010, wm0010_dai,
 				     ARRAY_SIZE(wm0010_dai));
 	if (ret < 0)
-		return ret;
+		goto disable_irq_wake;
 
 	return 0;
+
+disable_irq_wake:
+	irq_set_irq_wake(wm0010->irq, 0);
+
+free_irq:
+	if (wm0010->irq)
+		free_irq(wm0010->irq, wm0010);
+
+	return ret;
 }
 
 static void wm0010_spi_remove(struct spi_device *spi)
-- 
2.48.1


