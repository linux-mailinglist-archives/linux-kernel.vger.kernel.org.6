Return-Path: <linux-kernel+bounces-384371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F39B2958
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4FC1F22527
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5E20126D;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RoJCq8Y9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t/jKjCfI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55DA202F9E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100954; cv=none; b=lIWp6B4eftgZQv0y545YSurQ3KOEF0wQ1Q43q1X7rP2T1NMsQpu+UB48r/iXN4NlkhV1gASH76xb2XituuGeCLaj+fzlMLZ0mkGp9dHda8Vm/wfdPbuhscXgSnL7y4qd+TyeOwAA3qwS0/HVRqH2qFtDDf8fWRLpFATCUx95CyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100954; c=relaxed/simple;
	bh=cntlSwMjndeYGfNblFynIUDsp5kX3z4EV7tsbwvRhQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dh5vOd9VzC0M/3cZng/cjzM8r7VMWvR6sSp1C61iUxtv75aYU623/ZSLiepzZuFT4H2Bq620gWOMq4qFnZpnHItmf2nXjxwMs2e+7Q8XtmdshgeaYNmoFbnabEcX15MB9ohOquK2L09kDzMh++BDzSSbJbU6RAoeyjMxSYPgkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RoJCq8Y9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t/jKjCfI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BIy9+AZJOkVMok8NrBSJhjeT8JcmYVXmj+uS2bpLPU=;
	b=RoJCq8Y9dCoUG3Kq547zP1KRVf5BK91krNHJx2hN6CF5WzbGbSwiT8UYxs3bDxZ0vwNcCd
	E8VlQQb1oYUQzSG6o5iS+jlPQ2DpwMA+xef0H1IDrdY04T8Zw4lA5dYWZwVYD6ZfHly7Xe
	Ml51nuY4qYqt6LfJZHjBvfF0ntY0wAdupoUS23UB3paHpfGYYOXkfSErOHReljc8sLVTIM
	tBU2p93WWqHJomlXgjJsdX2vaz/kryiSWdSNyWKHJ0JvXV4dVZDl7TVvmlJkky/vkeELt8
	ALsBcwRE9swuEG2vPchPmAzDwL7tRZuqtFGCw8b97NiHcnwoX4xZqEHld+8q0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BIy9+AZJOkVMok8NrBSJhjeT8JcmYVXmj+uS2bpLPU=;
	b=t/jKjCfIqPmUEupagOIlKonVEW8DH8kbpdZdVyLqXxALftHxggimhwxfQwM3hEJiAyaIou
	n/PgtmBk1+/YclBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 44/44] ALSA: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:20 +0100
Message-Id: <a4c103403802ba8e7656462bdcdf8de922c604cf.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Takashi Iwai <tiwai@suse.com>
---
 sound/core/hrtimer.c      | 3 +--
 sound/drivers/dummy.c     | 3 +--
 sound/drivers/pcsp/pcsp.c | 3 +--
 sound/sh/sh_dac_audio.c   | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index 147c1fea4708..e9c60dce59fb 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -66,9 +66,8 @@ static int snd_hrtimer_open(struct snd_timer *t)
 	stime =3D kzalloc(sizeof(*stime), GFP_KERNEL);
 	if (!stime)
 		return -ENOMEM;
-	hrtimer_init(&stime->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	stime->timer =3D t;
-	stime->hrt.function =3D snd_hrtimer_callback;
+	hrtimer_setup(&stime->hrt, snd_hrtimer_callback, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
 	t->private_data =3D stime;
 	return 0;
 }
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 8f5df9b3aaaa..c1a3efb633c5 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -457,8 +457,7 @@ static int dummy_hrtimer_create(struct snd_pcm_substrea=
m *substream)
 	if (!dpcm)
 		return -ENOMEM;
 	substream->runtime->private_data =3D dpcm;
-	hrtimer_init(&dpcm->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dpcm->timer.function =3D dummy_hrtimer_callback;
+	hrtimer_setup(&dpcm->timer, dummy_hrtimer_callback, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL_SOFT);
 	dpcm->substream =3D substream;
 	atomic_set(&dpcm->running, 0);
 	return 0;
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 78c9b1c7590f..e8482c2290c3 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -103,8 +103,7 @@ static int snd_card_pcsp_probe(int devnum, struct devic=
e *dev)
 	if (devnum !=3D 0)
 		return -EINVAL;
=20
-	hrtimer_init(&pcsp_chip.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pcsp_chip.timer.function =3D pcsp_do_timer;
+	hrtimer_setup(&pcsp_chip.timer, pcsp_do_timer, CLOCK_MONOTONIC, HRTIMER_M=
ODE_REL);
=20
 	err =3D snd_devm_card_new(dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index e7b6ce7bd086..4fb88c3a4902 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -313,8 +313,7 @@ static int snd_sh_dac_create(struct snd_card *card,
=20
 	chip->card =3D card;
=20
-	hrtimer_init(&chip->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	chip->hrtimer.function =3D sh_dac_audio_timer;
+	hrtimer_setup(&chip->hrtimer, sh_dac_audio_timer, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
=20
 	dac_audio_reset(chip);
 	chip->rate =3D 8000;
--=20
2.39.5


