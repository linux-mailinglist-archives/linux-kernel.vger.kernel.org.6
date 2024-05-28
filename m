Return-Path: <linux-kernel+bounces-192934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2168D248A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDB51C279A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6A16FF4F;
	Tue, 28 May 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TD56Zu0F"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633E482DD;
	Tue, 28 May 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923948; cv=none; b=Tp5E3CW6R+zCFf4G2SLNPt6gDSoaehUXo1N7Zohn5Wg0RUt32ref4WukIH84KD9TSbudfr4cVltTIoJRYwadshToQhhIi/Eu1dfC191ebI4CVUHyyBaqpay17JPgQKqNHK1dB3nqfyRN7URzjDzGYiVIfdjWKCZESkNvOYffh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923948; c=relaxed/simple;
	bh=jdHI0J7SDTYW4bGzdvb5uNGzETKeBQAsx3uwmPZfoxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2mGWQoIUUzzx8waf1w+Ss3EutYTb17jKzhOe3COJdktvUZsOBwOjeVdbxkMIrAaphV/DgdgV8zX49fkxi+5HGuuBNKXz7+50X6e9Pl5V+jxHFbi5y1umVpSYC5HqhvnLHchKcuXo1whqEFTT+nNqjPtHlBcmdNPT9Ki8VhAqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TD56Zu0F; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C596C0006;
	Tue, 28 May 2024 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716923938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g9Wqr9AGlIlDl+BctXsjSkjtKA+9GIH3O1SeIFRmn7k=;
	b=TD56Zu0Fm2kj+PUL1K8bxigRiYbZ+fA7NkQ/TYde4y/0u4RPBqpcNTlgeHJ7omy+r9wXGc
	XDYb7ZgDfnqy0BrGXqu6Ze2ea2u7135U2LSGl78646GAF+RWCaRQJJRTxADjxeaViqVJNS
	OYeTGn6TwA1iFI4yPdCyZOwMEuVoQMZqDiypw1xEdFFkQ/3iSqAZQwMrpGhUsJzeyFgmfs
	s5iKP44bXmcejDdnMMkam1igcHvBUx4QeJTfzHXHwWW3BaRpIUz7ML6Q0q+ShymsAvpRaf
	dhmPVOYdrQL1OAVeHBJ+RJyxx4VcFw7QJn1qTWFNk6Z2pj0+tv3SAvNjXe0WzQ==
From: alexandre.belloni@bootlin.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: fix typo in comment
Date: Tue, 28 May 2024 21:18:50 +0200
Message-ID: <20240528191850.63314-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Fix the typo in the comment for SNDRV_PCM_RATE_KNOT

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 61c6054618c8..3edd7a7346da 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -124,7 +124,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_768000		(1U<<16)	/* 768000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1U<<30)	/* continuous range */
-#define SNDRV_PCM_RATE_KNOT		(1U<<31)	/* supports more non-continuos rates */
+#define SNDRV_PCM_RATE_KNOT		(1U<<31)	/* supports more non-continuous rates */
 
 #define SNDRV_PCM_RATE_8000_44100	(SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_11025|\
 					 SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_22050|\
-- 
2.45.1


