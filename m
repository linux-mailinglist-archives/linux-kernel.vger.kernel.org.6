Return-Path: <linux-kernel+bounces-384363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D69B2950
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD95B20BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27830204F61;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7BcJlR/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5M2dejIY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6892003BC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100951; cv=none; b=TuxN4u65XyxOcqoH2hH10IReNw4aLjJMOFEigNAegLS/2g6mwA742/SYbCJBnxAxI0O3U/ZM+f+0TvNy8o49RUJ5/pmyOb7jh83pIn+iEXd70vYWrR3/GsZcz4nlWgRx8U6gPwHokzz8FuBJCld1UKv3BhxfE89x0+el68u2Mm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100951; c=relaxed/simple;
	bh=2L87yKzfKyMKw8+5UaRKGSrkTGRbqUeV2f3PF5rM1dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3PpSZHorhwixUUUJrxOxodNN8ipgsGJ0dxySjLWdKJAI6vKQXXQ6uLV/qq+8PYzaG4A6JHqAAEsxdTpPSJlx3MegyF0U4Bc1Redvy69F7O9158choYyEXcWxOxnV9whl6Itkn0IFP4k43itj8ZpuyYR6zw4cOHjbpEHQc9KBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7BcJlR/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5M2dejIY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8d3OfLdkqv8+1iS6fWrwba52dBXcVxfzWfwjSPUgLM=;
	b=F7BcJlR/YFBJZySNfCdHTBNyzaY1Ihn0dzWCHiJ8L0kOYxtGiCwycR+pfoZEcCEGRrZYRW
	uC2/0q4Lr2PkwmrUz0DD3fTbo3vND+Cx9R8hExQIt5FpZzGV69OdzOHOxSfvNJuFqYjiOy
	lS9BD0Akr4/3PRPbJvwp1rK78CGXqtTzPERoqLi+z0S3/hRdb920kj9j58oBtg9FKEifXj
	BS/hlfPIhsVfkvZu5ipG3lQol6rBCFncSht1Dl5boRun21aGOUbPutsK9a82QDRqsoQy2P
	d8JjyrUebh1SJGYYUEFk4SLkTTaGJIFxFvEUhkrEqxj29t2gPoC+1fuIE/nXeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8d3OfLdkqv8+1iS6fWrwba52dBXcVxfzWfwjSPUgLM=;
	b=5M2dejIYOhYwSPfK7A9gX3V918id0aTv1hPOnHhhymcguY3f/H7QKG75ORzHm0GN8Mc4us
	MQT/eyGahn4KkkDA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: [PATCH 37/44] drm/vkms: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:13 +0100
Message-Id: <64f5441d590902cf1c897bf336d1d3e3fb5ac567.1729865485.git.namcao@linutronix.de>
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
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_c=
rtc.c
index 40b4d084e3ce..5fb597bfdcaf 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -66,8 +66,8 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
=20
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
=20
-	hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	out->vblank_hrtimer.function =3D &vkms_vblank_simulate;
+	hrtimer_setup(&out->vblank_hrtimer, &vkms_vblank_simulate, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
 	out->period_ns =3D ktime_set(0, vblank->framedur_ns);
 	hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_REL);
=20
--=20
2.39.5


