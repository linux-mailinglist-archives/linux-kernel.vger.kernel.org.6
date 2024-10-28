Return-Path: <linux-kernel+bounces-384366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFCC9B2952
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B881B207BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46B204F68;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqszeuMK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2hCEve9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E12022D0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100952; cv=none; b=hSyd7b7m1E3fyYekn4dONVfRc3aNc9VfoHtLmr11O4p/oWUm2l6SUC47aof72bJmcWkfu/8dtDmAiLX4xFXp2E3Pbp6jHS9d1jeR4U9GbSBGAwvqZvdXsZuT4Hye7r0NkTH6H9E5TjGDVw1dDr/H22aeh+Bo7+oBNKsx3b/LKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100952; c=relaxed/simple;
	bh=7iC6RRwCdYvoSDxFq+nQQAXmQ+GO0wLJI95huJvUd1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pv3lEd6Lb/NGlg0W/lnedbTsskc1U13liO2WT3YnYox5EWzKsMlgcafupWGXHlZPBgPIwx2LshSZ4TQHRDN66Ux8X/0pz0RXotRu/uUltR/G0XgiRXuYQnw0STMYxEgdx37s8fQGHjAKDSJKSElg9ytwMhRq/n3OlydTCfUgkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqszeuMK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2hCEve9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0m/zDMXphPDUZpg9M7CeUXorU39VZMKmmy3e7t0Ov7Q=;
	b=oqszeuMKBYsdoHNxzDX9Av8s0OUKO1yY5zRXtJVPaiJQzyxlE/61Sx0q0ielkd3drxvEMg
	W5Dt7q4tOeUQUreHD8qTuDEAjDzkEYkXkysLP39PdnDVxQ/b0ecgZdH4KZU3AjS0m9/USs
	nagz4oWvaEk5rB4wPaZs6bgv6ShYp9qna3QZG92bqP/7c7rlqVcp6Q5QTWz11dXNfQIXWT
	TVdnahu8pC8xwaKXcxHyKgqpayo6aAsl4KytFE0Pm1TBTKgFCohWft5TWbMNpMhCHT96LV
	4I3Kc2UGCs6E/mlHw2jR/oyq0qO1Z+qct0PjLqpX1ncP4b2Px13PYBaL1Bwk8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0m/zDMXphPDUZpg9M7CeUXorU39VZMKmmy3e7t0Ov7Q=;
	b=2hCEve9HvhsTnsDp/dww051IDuUdJsi3tKhn5NhrySUWx7TZ1+lVLmA4dvQCRYV8tegniS
	OG2yZonJ2fmhOwDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 39/44] drm/vmwgfx: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:15 +0100
Message-Id: <318d94dc21f04ba85a29031a8973a4a3b76f3cf2.1729865485.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_vkms.c
index 8651b788e98b..aec774fa4d7b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -290,8 +290,8 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
=20
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
=20
-	hrtimer_init(&du->vkms.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	du->vkms.timer.function =3D &vmw_vkms_vblank_simulate;
+	hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	du->vkms.period_ns =3D ktime_set(0, vblank->framedur_ns);
 	hrtimer_start(&du->vkms.timer, du->vkms.period_ns, HRTIMER_MODE_REL);
=20
--=20
2.39.5


