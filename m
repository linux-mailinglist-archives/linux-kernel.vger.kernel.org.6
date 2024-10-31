Return-Path: <linux-kernel+bounces-390755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B509B7E25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DAE1F22833
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC11CBE80;
	Thu, 31 Oct 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g8u0ndCi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A9/e7j66"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022C1C8317
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387714; cv=none; b=bVX5Qdda33IAYZ/NIIRpLbbjv3uVYOR8zgaIedMQZ2Va2WEhws5lPsJWTyWai/M0p5fQ71EjfjbxSLz+oBNj4pr+fMDkqN/PV3j52LyZukW38NN+auE3qVIA0mzL2G1x0Q52Jz3K8v04cAPsPhUGMUS8f9dw0tgaLOGKQJDHZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387714; c=relaxed/simple;
	bh=25TeNuAsXPUFgvoNR4VhqmvPSq3ba2Pkp66s/J9P69s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqvL/g1h0EMKfoatp5gDK1cWzzcymCnOdjdFAknU+Tcho465rLTEscX9frCJR/a0oZXu+8oWuDKOPPJcIV9s+5VlfjHjd51vLXs4G+GxeAZjSg65GPNxFMIqSxJL1C4nf5nHOMCGOHaZg/3JqD0xMLcoRVHUQ1VMCNBPjzkooYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g8u0ndCi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A9/e7j66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4mSJVNkOJadieQpH/ARr3Pt6XdvliVSvqT1hoZVaV8=;
	b=g8u0ndCiTr3NS8ibsXO+fgCaxmKmXfdKpLn7cGH70fR0ulPkAnX5uz+SJ/eRJTIAGGKGXG
	gVquDGd0XkGLh2ExQppw8flgrKGeaoOvFJNeA8WMrF+y+2w17/cYK1bI+H8iI2rRl4B+or
	Mel1GhvFlT0+HzYapwOZUwCvmeUYj3x4/l9CwdVtB479n1veR4ItHSumcuEKyT06tryDIN
	GyAkczCv5/RQkwp9hezJPsO//rW7Mtd4Ej1gDNFcm94m5PY89liEo1wYcZMF6rXE0kS/sV
	fJ/PaFhM4vogluNq4no3g2z96E+WBIV9tcQ/8Hg35dSU2hTF8BfvcGmh2iZDHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4mSJVNkOJadieQpH/ARr3Pt6XdvliVSvqT1hoZVaV8=;
	b=A9/e7j66uU9LW08O+hdNrkr1AcQGQHKf4ec4M/6OUYdzN06aa0+Q3bDxwFes1yVAYlen2/
	YKtXm7RpqjUwPDAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RESEND PATCH v2 16/19] sched/idle: Switch to use hrtimer_setup_on_stack()
Date: Thu, 31 Oct 2024 16:14:30 +0100
Message-Id: <17f9421fed6061df4ad26a4cc91873d2c078cb0f.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup_on_stack() takes the callback function pointer as argument
and initializes the timer completely.

Replace hrtimer_init_on_stack() and the open coded initialization of
hrtimer::function with the new setup mechanism.

The conversion was done with Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096bb274c..631e42802925 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
=20
 	it.done =3D 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	it.timer.function =3D idle_inject_timer_fn;
+	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
+			       HRTIMER_MODE_REL_HARD);
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED_HARD);
=20
--=20
2.39.5


