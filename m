Return-Path: <linux-kernel+bounces-384359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C69B294C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3DA1C21830
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3862038AD;
	Mon, 28 Oct 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KDybhfYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="COKvd61i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9C1FCF55
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100949; cv=none; b=I+RDnGDIJIoC43OZl2Fh+QFwj8QGpUQp/FhcsDzzd8vkHlsWGXE3s4m6z8wLEQuqUvsETlAsY/hQIghSUcyqzAm+rl/r4z7h+CeuvyT/I8ya+L8trqnQ+QfzA1iF19gYH5Z+Zj1S2U2iMoi41Q+bkv0wU9Q1lYAC/fbwwys/LjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100949; c=relaxed/simple;
	bh=AWSVZQgoP9kXrcbFkBzuEvgcEPi19n6xXY+bsGa07ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdeInhTIRLkoKT8gw2JpFBEcQjtGKfEo+2ycg/upxeTuiRj32OpxOY9NYihNl0vlgohAYLxQRMeBU02s2OJmpycUzn1Vow8Wl+X9SeoaNkx4oh2v83F5mB/y+cFTE+Kfx/4NCjKnHSPGj7pFGomv/pu6rp7pJHYQ2V7NGW6aoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KDybhfYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=COKvd61i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4TIKGEqD8IhbwKVaKp0wp1yEQXuyYuEtg9Rh1iAhiY=;
	b=KDybhfYWFKzyoKS4XKrRCwwZyqU1m1ORvHB8Yi+PUD5aOTxGDhppMfqdFeD6N9Y1a6cIwh
	ULj5hPj6GGzzzGCokBoMBt6dHZqJ+ZgY7HGO4RflVuxXI8s5qIfA8zxNbC8pr86WepJViz
	w8Jnlr8E5yozq+wUPJn22Awwe+KHubwP67aS2cptSdCa6Shz+RgnABWZLVCK0UVCANrxjW
	zFT4/imkZ6w5YxHSgtqCJBfHAFggsjmOH5ncc+3s8aGgBJCcjH88BPdJxiNLvhdNbufcPR
	RVBcCf8WjTqRrKjJ0sCMT0z2QpVfRpU6nnK/oBGEeSjjnFcwyYi4AaDPiH9LGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4TIKGEqD8IhbwKVaKp0wp1yEQXuyYuEtg9Rh1iAhiY=;
	b=COKvd61iF9L7Jqv6ZyiLW1GPXwCXRGwQrdzuXxGNUNhv1kNmvXZF+W/KIHucqPyXjf6JGl
	CO9k1Q6X9FQojRAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 33/44] drm/i915/pmu: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:09 +0100
Message-Id: <b32d24d419bb6de3c6c2f60a7f475ccb69208cb3.1729865485.git.namcao@linutronix.de>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pm=
u.c
index 21eb0c5b320d..5f5210a8f58b 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1261,8 +1261,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	}
=20
 	spin_lock_init(&pmu->lock);
-	hrtimer_init(&pmu->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	pmu->timer.function =3D i915_sample;
+	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL=
);
 	pmu->cpuhp.cpu =3D -1;
 	init_rc6(pmu);
=20
--=20
2.39.5


