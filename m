Return-Path: <linux-kernel+bounces-390752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25849B7E22
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827401F2152B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB41C9ED7;
	Thu, 31 Oct 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pW+zf7nx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAUdZbzr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DB1C2333
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387713; cv=none; b=rRyiC1821uxdQBMDm76WDCqSMzgMI/0Gf++cAeXWWIN4bU1Ows3Mz/s3YngtSPF41MD6mMDq+VfT1pr4oG8sFOk/uckDRZhO2f4G9alx3pEZUAmrZaoGrnGI0IpzQPD1fk8NpKObrx0nGGFVQDUtyW2sBYqyBSIrhx6CALo4Z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387713; c=relaxed/simple;
	bh=eFjdlLDNzRXPRueQ0E62K52as5cxcIHoD+4zSwI6m9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzYVXcQ0/76gkhYupiWktgwY8psxkwtMMUROmdI193Bpm8n+14GjQpz9mk5fb2UeDhAGHgnaKT2Rr+Znks3HZHknH9/aJVDLsMN774FVYFnzDrn7H6787PqD3NUkPAABLefskXvsrDo4MtAlIPa+azAN7WqBdCC1OqbDhy2SyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pW+zf7nx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAUdZbzr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730387709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSeQQ+/UoF5zygXiJ8vWE36+Ix/J13zBcX6GURu7TTA=;
	b=pW+zf7nxpvKL293ERZvvkwqWdm8sTJU22dfYTvgmDpLaTBAjpODBvgHjspRQUpOxT2Xkk3
	wN7cUjgQB7Wzx+BfHqJpqfqnl3whMltT1B4R6JpdkAklNuv5fISyon0ClgYH1Mm8Datz0t
	OGuLRyqIKoCRXDm1GeLJ1z7j0HvEwG03s3jx320laE9UbmLIQUWvNk73I/RP22Wi8OO9BM
	bT+pgEONX7owIuipx8vPYVfYKLzOgbmi++QBfxZF208RvJjPlmzU05qTcvIbur1HpxU2Z4
	mzaQYDrdNV64NzCpPI4sMWDeEl8tCiO7YirWqaL8DeR60Rrz4hRbQa/pJzrAZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730387709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSeQQ+/UoF5zygXiJ8vWE36+Ix/J13zBcX6GURu7TTA=;
	b=OAUdZbzrqi7ivU7nui/YFiCV2Rtbq2Djbjl4fqTRc+FfLabBbIJupRYnsEzp3+vUNCOW58
	ubtuPIlXxGOv9PAw==
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
Subject: [RESEND PATCH v2 13/19] timers: Switch to use hrtimer_setup_sleeper_on_stack()
Date: Thu, 31 Oct 2024 16:14:27 +0100
Message-Id: <299c07f0f96af8ab3a7631b47b6ca22b06b20577.1730386209.git.namcao@linutronix.de>
In-Reply-To: <cover.1730386209.git.namcao@linutronix.de>
References: <cover.1730386209.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage sites over to it. The conversion was done with
Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c       | 5 ++---
 kernel/time/sleep_timeout.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 1d1f5c03673c..69430467a17d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2138,8 +2138,7 @@ static long __sched hrtimer_nanosleep_restart(struct =
restart_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
=20
-	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, restart->nanosleep.clockid, HRTIMER_MO=
DE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
 	ret =3D do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
@@ -2153,7 +2152,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtim=
er_mode mode,
 	struct hrtimer_sleeper t;
 	int ret =3D 0;
=20
-	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret =3D do_nanosleep(&t, mode);
 	if (ret !=3D -ERESTART_RESTARTBLOCK)
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 3054e5232d20..dfe939f6e4ec 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -208,7 +208,7 @@ int __sched schedule_hrtimeout_range_clock(ktime_t *exp=
ires, u64 delta,
 		return -EINTR;
 	}
=20
-	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
=20
--=20
2.39.5


