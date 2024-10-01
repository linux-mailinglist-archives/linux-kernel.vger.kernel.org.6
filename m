Return-Path: <linux-kernel+bounces-345530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F098B74B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708AB280D90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4319D070;
	Tue,  1 Oct 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGq7vSxE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tWvzEeVi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773C19C565
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772125; cv=none; b=oxP/s8/YBgRNutmZOWANoSD+nti4LKrRcBqLKMZ1DZHHaM1S5KooSnCr1w4LK7t3V8nkFPxnqSHzQ5735er44xZrvd99meIJ+TrbTFCRSyZauye3ACTBM5AaJN7JJzu3JwPq65KzjTVNJ2vesZmtsUlVw8E+qY1lXESSvkf99Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772125; c=relaxed/simple;
	bh=M3fXAdRWxuZ07Q0D267FKx6zLSR7I6ET0k9tQy3SdSk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BbD7ZVpqq9Gn+NN84oBVyPZfiYPZEzHBQQVzvjElHgKNOhe12j4uhfN6yV+7k0C1edVTNEfNUIT/aewBYX5zU2ZGw4kxrzakE48yEujLePvdUyJ3C44NipsOfZWGf2Bn+RIDlKBlzhXKxQl7/yRmkGRapjTviy5oUqSTdZrHwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGq7vSxE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tWvzEeVi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.374933959@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6LPrqCS5pkWr7LC6gMgNz6vB8PRM7Rz4RG9MQ7Cuv3Q=;
	b=aGq7vSxEHV2S6x0lsh8cOa4eDefHjxTgjC96myAyVJlzlNkEWMv3YqgXQnVjIkrO4+07Rh
	QmI8DSYmya+0DIYrmrtkJeHFrPDuEzxvSgqeVgKNn5DB3X04l3r99t+iBRRiuLeVNertZ3
	Z4EWJZMhsuTnMHqSGgXcpqgPms0fYCUitwoF/3+MGU/aWLGRRsJmPWjdJvehfDo/G4QXIE
	QjgjR/BBeGnQiU/eblWf6J6KlJ8uDQs/50uBcp40cZhqfzlQOAxDS58Hc9s+ArwNxU9Tx3
	wtqzPdCftd4+BMv4RD/EA1rKRJ9O5vg5ctnSDZDZcj57XJ9gJscQFnKQQ6kmog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6LPrqCS5pkWr7LC6gMgNz6vB8PRM7Rz4RG9MQ7Cuv3Q=;
	b=tWvzEeVixAPN+ZPsX67fieON/DPhkCqJn6UKvWaBte1KsPkHqDZcnDoXvOvp9QE4PK3RlS
	+B3901mm+NyPToCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V5 02/26] signal: Cleanup flush_sigqueue_mask()
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:02 +0200 (CEST)

Mop up the stale return value comment and add a lockdep check instead of
commenting on the locking requirement.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -704,17 +704,14 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
 
-/*
- * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
- *
- * All callers must be holding the siglock.
- */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+/* Remove signals in mask from the pending set and queue. */
+static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
 
+	lockdep_assert_held(&p->sighand->siglock);
+
 	sigandsets(&m, mask, &s->signal);
 	if (sigisemptyset(&m))
 		return;
@@ -848,18 +845,18 @@ static bool prepare_signal(int sig, stru
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(p, &flush, &signal->shared_pending);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(p, &flush, &t->pending);
 	} else if (sig == SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(p, &flush, &signal->shared_pending);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(p, &flush, &t->pending);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &= ~JOBCTL_STOPPED;
@@ -4114,8 +4111,8 @@ void kernel_sigaction(int sig, __sighand
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
 
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(current, &mask, &current->signal->shared_pending);
+		flush_sigqueue_mask(current, &mask, &current->pending);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4182,9 +4179,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(p, &mask, &p->signal->shared_pending);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(p, &mask, &t->pending);
 		}
 	}
 


