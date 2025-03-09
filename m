Return-Path: <linux-kernel+bounces-553356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA77A587FA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9D3AD4CA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAB219316;
	Sun,  9 Mar 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JeZlAY/J"
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A40217F42;
	Sun,  9 Mar 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549911; cv=none; b=E3wd57bCpsgq3cMhTkX6Y5R3dBrAIfsH0RktlfsR+BARkU0caDY7mpr0MJqEU4WhbL0qVWgKsw8ww+n4ybU0Sf+xBeQ8Jk/jB4vm0ktdQTKnhGQ7vFDuSOk8toiKlrqeiWYXaL0jDfwGtODBjcGbBRn0UlNmwrdDdVo3+c57Tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549911; c=relaxed/simple;
	bh=+jO5twca9jEdjcoV5X5VejjUeqqOSwqkonGG/PX4nTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6D8tR2PI26PIX1AMrD+EokbeF62eCR/7S8EomBiBQcYW2vvt7+oVK3bMD+vPQqSPtLwu+cCoE55innNQweVgvAuzCKpzxA4uPkmYVHHKK442TNHnyycVJXdkFc/wnOa3XmvexQ3xu9IJDUtauBXjYWf3qoW6FC9pHaU1kpCX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JeZlAY/J; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rMfStEMN9MM9VrMfVtoTfu; Sun, 09 Mar 2025 20:50:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741549839;
	bh=lYvhddHrYeYAvSLWvys+NZYI+RN2FTr1+xT08fZxfBc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JeZlAY/J4k6udFDppGa5Wumb1g7E6MiGmYEdmUHwJEWbAvbqTYWm25LEUWb9Zz82u
	 HjdAOyJYdawf2B5Jog+XR82kpQYuirA8EE1gnaoQ0ch39OAqXsZ2/MHN4Hldcg6JgL
	 LamWGcfteZtZrPtRlgZ6OvNSOCQ6gfDVPBc3+aMmFDAiKHl4J38oYU1AReitxudLaR
	 hA8dfMeOZyVvSN2nv9zX0xA+FMeCSZdqgKh899jh1wyDJt9f4LuBRDF2xFvrHTHY/6
	 ySSD8WTxhgFNi+U6IFCShjV4Kgf2LoDlcfsAJkF71pgw33sZZhTGEN0MptRKBrxXrB
	 +4hzvtB0KN7ew==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Mar 2025 20:50:39 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: [PATCH] ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
Date: Sun,  9 Mar 2025 20:50:28 +0100
Message-ID: <ee39ba19b8c4c157ce04e06096a8f54016831959.1741549792.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free some resources in the error handling path of the probe, as already
done in the remove function.

Fixes: e3523e01869d ("ASoC: wm0010: Add initial wm0010 DSP driver")
Fixes: fd8b96574456 ("ASoC: wm0010: Clear IRQ as wake source and include missing header")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
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
+		goto free_riq;
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
+free_riq:
+	if (wm0010->irq)
+		free_irq(wm0010->irq, wm0010);
+
+	return ret;
 }
 
 static void wm0010_spi_remove(struct spi_device *spi)
-- 
2.48.1


