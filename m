Return-Path: <linux-kernel+bounces-264154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E693DF8E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7883D1C20E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC216E895;
	Sat, 27 Jul 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ia3UWRJJ"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8C6F2E2;
	Sat, 27 Jul 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087651; cv=none; b=UauRSvx1jQUsJ6xYt2sGFsTsczM98jyY5HmTt57uMB6jfuAzfBmogkccWy4eF8BRVaxKZZ/9lkTgtb4liWbXS+YIybCtJx1drJUnxhD2GqtFvv30Kb32jufjRzcAg58oMZ6psBKTPcj8ahs3Auk40OKG2wTBIEjl7u8VGOWp+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087651; c=relaxed/simple;
	bh=r+dhww+Qqi4Jwf+59kLJSk6bzmgwKaWwB6UQ6V8q3kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ghUSLQF8h1uvxdoLzsu7UH6WPY3+4+hmGJ0hNpWcF6ESKE69vW7QKL4rMTL/Z/FLlFx+u1Jlojnq01jAlNLXDpxkMU+6OvXyC/NhDcmPZmteciGljOwTiQdvoCtoouNPBzgJV5x+9Dsv6fkV29Bmzhg/NpRbnmeiRE+b5X0s5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ia3UWRJJ; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from fedora.local (unknown [IPv6:2a01:cb16:6:5884:9994:cab6:56f0:715d])
	(Authenticated sender: jau@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 3428E60141;
	Sat, 27 Jul 2024 15:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1722087641;
	bh=r+dhww+Qqi4Jwf+59kLJSk6bzmgwKaWwB6UQ6V8q3kA=;
	h=From:Date:Subject:To:Cc:From;
	b=ia3UWRJJBLrX5fupW1sc2Logaeogl/KXPBIEQTy3jlU1mU94QeYML95YCIOXhA9Ar
	 KVu6FE52Q/ofxzNK4jBEqX1cU0VVJm/Cq1lVoYPCVJG2qczRVn5IA6A5s2xrmSBzRB
	 gweuAIEEd/X8Q3Sp6rKvF5uphq1F/dA9zhRkc9HSDNFEqvMoHvMH7vaeoWny9Xv09K
	 QaMV1jBCA4GmLzW6AE+oIKo7kcOeeu75mtwyD6J5fkLCQJKfRm1xJeaQRsBxxDh+Q3
	 UL9mZ9BWUxg5a3ewibQC9Wp3yp47nTHO7Oh60SGnO2Wz/290jmmepZ6AUBNniQtJzm
	 DaiYkFPykB/Qg==
From: Jerome Audu <jau@free.fr>
Date: Sat, 27 Jul 2024 15:40:15 +0200
Subject: [PATCH v2] ASoC: sti: add missing probe entry for player and
 reader
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-sti-audio-fix-v2-1-208bde546c3f@free.fr>
X-B4-Tracking: v=1; b=H4sIAL74pGYC/3WMMQ7CMAwAv1J5xqgOEUFM/AN1SFqbemlQUiJQl
 b8TujPeSXcbZE7KGa7dBomLZo1LA3PoYJz98mDUqTGY3tjeGcK8KvrXpBFF30gnZ0UkGMsOWvN
 M3PT+uw+NZ81rTJ99X+hn/50KIaG/BOJRzjQGe5PEfJQEQ631Czs1wimoAAAA
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Audu <jau@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722087631; l=3355;
 i=jau@free.fr; s=20240721; h=from:subject:message-id;
 bh=r+dhww+Qqi4Jwf+59kLJSk6bzmgwKaWwB6UQ6V8q3kA=;
 b=ZarBGTSz1xjIEXXH1wTTuH4cum1rX6cKT6MnHivk7q26E5+h/LQ4p2/N1N5qVXTwLA+524zh9
 v+e4RMecMqOBPXENoUt16xiuHwbopAK7I7kCwcAhn5aYPI7qNHhtUVC
X-Developer-Key: i=jau@free.fr; a=ed25519;
 pk=CfXLqyNBjY9A4RDoxPChE7qFvTjVyy0rJNTfI4JQ0dI=

This patch addresses a regression in the ASoC STI drivers that was
introduced in Linux version 6.6.y. The issue originated from a series of
patches (see https://lore.kernel.org/all/87wmy5b0wt.wl-kuninori.morimoto.gx@renesas.com/)
that unintentionally omitted necessary probe functions for the player
and reader components.

Probe function in `sound/soc/sti/sti_uniperif.c:415` is being replaced
by another probe function located at `sound/soc/sti/sti_uniperif.c:453`,
which should instead be derived from the player and reader components.
This patch correctly reinserts the missing probe entries,
restoring the intended functionality.

Fixes: 9f625f5e6cf9 ("ASoC: sti: merge DAI call back functions into ops")
Signed-off-by: Jerome Audu <jau@free.fr>
---
Changes in v2:
- Update changelog
- Link to v1: https://lore.kernel.org/r/20240721-sti-audio-fix-v1-1-a8b1ecf61cb4@free.fr
---
 sound/soc/sti/sti_uniperif.c    | 2 +-
 sound/soc/sti/uniperif.h        | 1 +
 sound/soc/sti/uniperif_player.c | 1 +
 sound/soc/sti/uniperif_reader.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index ba824f14a39c..a7956e5a4ee5 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -352,7 +352,7 @@ static int sti_uniperiph_resume(struct snd_soc_component *component)
 	return ret;
 }
 
-static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
+int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct sti_uniperiph_dai *dai_data = &priv->dai_data;
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 2a5de328501c..74e51f0ff85c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1380,6 +1380,7 @@ int uni_reader_init(struct platform_device *pdev,
 		    struct uniperif *reader);
 
 /* common */
+int sti_uniperiph_dai_probe(struct snd_soc_dai *dai);
 int sti_uniperiph_dai_set_fmt(struct snd_soc_dai *dai,
 			      unsigned int fmt);
 
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index dd9013c47664..6d1ce030963c 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1038,6 +1038,7 @@ static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.startup = uni_player_startup,
 		.shutdown = uni_player_shutdown,
 		.prepare = uni_player_prepare,
+		.probe = sti_uniperiph_dai_probe,
 		.trigger = uni_player_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 065c5f0d1f5f..05ea2b794eb9 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -401,6 +401,7 @@ static const struct snd_soc_dai_ops uni_reader_dai_ops = {
 		.startup = uni_reader_startup,
 		.shutdown = uni_reader_shutdown,
 		.prepare = uni_reader_prepare,
+		.probe = sti_uniperiph_dai_probe,
 		.trigger = uni_reader_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240721-sti-audio-fix-1374fffb24e7

Best regards,
-- 
Jerome Audu <jau@free.fr>


