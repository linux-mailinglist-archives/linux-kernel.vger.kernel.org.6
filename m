Return-Path: <linux-kernel+bounces-349506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76EA98F70F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF4B20CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67E1AC448;
	Thu,  3 Oct 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nU6efexJ"
Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C11A76CF;
	Thu,  3 Oct 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984059; cv=none; b=o4rqntPRGKWSqwobIIO/EkKsRCWOzGv70qsMLkySCS25nkCcYLlE9p2ct4soxMqD8+j0hjW0/wZWtMrdEUBStb9VzHDAqkpa9qTp4onJilhVqe7k76MQPI3PvxICx52hcv2EDDGUXtJhU5ru44Aw5DTe1RmZoUGx7SbfDsWvGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984059; c=relaxed/simple;
	bh=WyZWEWlhds0xrBVDq7MOYOUjniUReyXJlQLd/zaY5tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugoZ7BoOl2NpuLmkazhiK0X6HEsXxuM2S8OLtkhkyt6zXgz3K5uIHPIo1ztLEqmNe0PFZmKiXcnvdwsJxmCwGeYRJnHCBHImdn48hQnizvRAqdlVodJZzDE7E+tniRIlqJwu6oO71eUXjP+kHr69dgJNYwPyjADGlrlbuTjmeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nU6efexJ; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wRaPsP5U3vjJewRaQsN4s2; Thu, 03 Oct 2024 21:34:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727984047;
	bh=2SDPvfeI4Lzg8Uj2ZPpyRvlMXWAOYBlC3P/o4uoQmrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nU6efexJ2AzkRnAdtD4BvewOlLJBUkfpSsJpWrc+misqdWwPWs8ZEOMrxMZ6/jwqr
	 E/wuAgK2Tu985JV2ummHBR+zWsXPnz84ADc9O/ZEngzDnwkDuSm9tWsGaTxoFtAeO8
	 7O4pW6NB2VHzxUdNHeWDeJHFVPAi321xpNXQexkg0J9PZMiVXQa5eyPr1pOEGC0/Rd
	 SkkJFtsq0RLTKjdzMHlMz2Vv1IJq8Qa67W7r/dLilY23+VwqtE4B3cpNhb43d3IgXR
	 s0HoI/eZi6HlyeU7RKgifP8ZiQ0lKdPYBzcYAuS24s1UhtWx4cV7ELjyd/c+6TzN7v
	 kODvm3gRFZJGg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Oct 2024 21:34:07 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: [PATCH] ALSA: gus: Fix some error handling paths related to get_bpos() usage
Date: Thu,  3 Oct 2024 21:34:01 +0200
Message-ID: <d9ca841edad697154afa97c73a5d7a14919330d9.1727984008.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If get_bpos() fails, it is likely that the corresponding error code should
be returned.

Fixes: a6970bb1dd99 ("ALSA: gus: Convert to the new PCM ops")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. Review with care.
---
 sound/isa/gus/gus_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index bcbcaa924c12..16f9bbb43a54 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -364,7 +364,7 @@ static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
 
 	bpos = get_bpos(pcmp, voice, pos, len);
 	if (bpos < 0)
-		return pos;
+		return bpos;
 	if (copy_from_iter(runtime->dma_area + bpos, len, src) != len)
 		return -EFAULT;
 	return playback_copy_ack(substream, bpos, len);
@@ -381,7 +381,7 @@ static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
 	
 	bpos = get_bpos(pcmp, voice, pos, len);
 	if (bpos < 0)
-		return pos;
+		return bpos;
 	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + bpos,
 				   bytes_to_samples(runtime, count));
 	return playback_copy_ack(substream, bpos, len);
-- 
2.46.2


