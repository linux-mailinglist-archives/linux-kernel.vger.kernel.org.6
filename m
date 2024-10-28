Return-Path: <linux-kernel+bounces-384370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719119B2957
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380022829C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767419007E;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9Glj9pV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0NT6D1i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504C202F71
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100954; cv=none; b=nkwGJdg2n1yWavFQjDZcOGktTKBb8McsWo3/N6ugiPLsi4H5Xqkdu3X41oXGn6IBM3td4R26pLTTFyK+9YVxpU79QfqKPHcDZBlWNx06fWBO+AeJyxE5ZFjCd4vscNKdDpSHzV40uf42tyWxbI4WbfwoI2ZouDM2wd8Us2/SIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100954; c=relaxed/simple;
	bh=62MlML62bulsh4zIiOicJWp/5lyl/lygrh/lR3b4Z/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgLv2iAPd0K/rURkmjBl5PnmXgG16vRNN7wRnn9sEImNb279G8FbzQ2iLl/LzPql0nbdu2Z8ZMD+zpYXNKC4qfTAcblTwboYeVY03TkgNIE8z7aFjjlWQy8kKKfo4opByyXpexK13VnbPhihQK7nyK4TbM3FXH/AN1xJ1aoM1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9Glj9pV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0NT6D1i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QyqQUbnikQg4eROcOGQiXWEgcyxMlrBn4MILmLynAI=;
	b=Z9Glj9pVhUNF2U47RH4VOTNJm0cNQL0oIgbVEma9qzBY8RjtEe1EeGu5hR9RAv3H2dFqtq
	TEwoQ7/GYbV32kUFvvb8HjZpv5bVI6lpDJXYHRyhk7Nq83H72ikrnx+E2OcD1b8NT8UXxp
	CfB6LCyg1tQ46Wtv7iyhqvBCC2TyPx1IXvv0EQ9mb9FQ7Skof4cM8YH0Of5T6+e1URtGS6
	eJ1ac16Qgrc754so3vg8QHzXaMr7GrmXCHh3HT6w2+LUyWQXB1emXDK2I6iJ+4bnQAkVb+
	PzEJdz1FfCMuFwmwxs5DZyhAqx7jpX/fW1g6khQq8JuUkaTPx0wLW+oZlX7Xlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QyqQUbnikQg4eROcOGQiXWEgcyxMlrBn4MILmLynAI=;
	b=c0NT6D1i64q/dNj5KYKnOtX7GTGCskKLhCyGbK/HCcmG9mu8f0n2+2svrCUlRB+/jBnOGE
	w5lxm/HEOIGpxGAQ==
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
Subject: [PATCH 43/44] ASoC: fsl: imx-pcm-fiq: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:19 +0100
Message-Id: <e172cab73b21122487b7a274a090f3ab641901ab.1729865485.git.namcao@linutronix.de>
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
 sound/soc/fsl/imx-pcm-fiq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 3391430e4253..83de3ae33691 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -185,8 +185,7 @@ static int snd_imx_open(struct snd_soc_component *compo=
nent,
=20
 	atomic_set(&iprtd->playing, 0);
 	atomic_set(&iprtd->capturing, 0);
-	hrtimer_init(&iprtd->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	iprtd->hrt.function =3D snd_hrtimer_callback;
+	hrtimer_setup(&iprtd->hrt, snd_hrtimer_callback, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
=20
 	ret =3D snd_pcm_hw_constraint_integer(substream->runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
--=20
2.39.5


