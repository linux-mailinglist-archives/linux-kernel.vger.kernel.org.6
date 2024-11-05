Return-Path: <linux-kernel+bounces-396095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA59BC7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A1B281467
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536FD20101A;
	Tue,  5 Nov 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9ipAxq7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmfJMpZl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A424200BB2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794490; cv=none; b=Uw4Y3FvIl30M+IpdbU4Y7tePZUr0WIBpZPWTqWZd0ltH81JfLhCgo2kTyygo1NrxS8HnsaqTHKPkCkrEOW6gTbc/bsrhm/23wEbYkHZfiftK8EPN65Egk9VQ/qtXQHoi/r6VK8or7/YsTUb52AncE/O3Oum6IefqcnyoKFtDolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794490; c=relaxed/simple;
	bh=uF8HVjyRfSfPENjUQUuN0lAxWCzSjUVmwDegLBJY1Hk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HmMqvcUwF4mpBdHnvVxUij8GhpfBmPkdi7KN2OQ1DqPUeo43jURD5kiczDjfZDexb4YEHLT9XCeedHq+iXRD4E5EA4Arvpzo2dh+jJTgpx2gl2HzJvVCl4zm9H3hFFTbFJQLU8Nj8UcIAOn7ZUmaLaTs2QyZwufySURXzcC0B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9ipAxq7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmfJMpZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.786506636@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QHJKT1FsG81uCFjqfXOJNacFFtoodXXL7f6S1umCJys=;
	b=C9ipAxq7U36j4L1ueg0H3WkKXxS2Tq7Lzog6w9vxxLffcDP4iYR5rr9KOIy0aD1ZdPsuqS
	TxsUjQDyJ43StQXTSCEQCzgPoaRGzuurh/V6g449KgQUDEGEmJcH7BhZTCmSYiRaUnK8BQ
	+Fls+m6+2asuAmwQ3TKXIp4KpNWb0VkkYWCeFF9vvYZIuCbeaEBJwIgGOD7I/gR0A8+MjN
	bOpepwWOI3G1gDOaZrcpoeoiwRCROEu+yHnLuGEdMt/GMoXyZjbmicOcqvnl1IbbKeqyhu
	+jR9HyckB6xCTrBPogEMs1UqbJQwdxnMPiBJOvfkIgT/pVh2dvTcXy69flea6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QHJKT1FsG81uCFjqfXOJNacFFtoodXXL7f6S1umCJys=;
	b=nmfJMpZl9zXuRZF/FDzVrgLO6nObqRIR5lSILOPz1u4NSqsvKPtFX+cEzI1rXD5RmPbwgc
	GJxnpfGm+GLs/iCA==
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
Subject: [patch V7 13/21] signal: Cleanup unused posix-timer leftovers
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:46 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Remove the leftovers of sigqueue preallocation as it's not longer used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/signal.h |    2 --
 kernel/signal.c              |   39 ++++-----------------------------------
 2 files changed, 4 insertions(+), 37 deletions(-)
---

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -338,8 +338,6 @@ extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
-extern struct sigqueue *sigqueue_alloc(void);
-extern void sigqueue_free(struct sigqueue *);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -439,8 +439,8 @@ static void __sigqueue_init(struct sigqu
  * - this may be called without locks if and only if t == current, otherwise an
  *   appropriate lock must be held to stop the target task from exiting
  */
-static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-					 int override_rlimit, const unsigned int sigqueue_flags)
+static struct sigqueue *sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+				       int override_rlimit)
 {
 	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
 	struct sigqueue *q;
@@ -454,7 +454,7 @@ static struct sigqueue *__sigqueue_alloc
 		return NULL;
 	}
 
-	__sigqueue_init(q, ucounts, sigqueue_flags);
+	__sigqueue_init(q, ucounts, 0);
 	return q;
 }
 
@@ -1070,7 +1070,7 @@ static int __send_signal_locked(int sig,
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q = sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
@@ -1926,37 +1926,6 @@ bool posixtimer_init_sigqueue(struct sig
 	return true;
 }
 
-struct sigqueue *sigqueue_alloc(void)
-{
-	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
-}
-
-void sigqueue_free(struct sigqueue *q)
-{
-	spinlock_t *lock = &current->sighand->siglock;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return;
-	/*
-	 * We must hold ->siglock while testing q->list
-	 * to serialize with collect_signal() or with
-	 * __exit_signal()->flush_sigqueue().
-	 */
-	spin_lock_irqsave(lock, flags);
-	q->flags &= ~SIGQUEUE_PREALLOC;
-	/*
-	 * If it is queued it will be freed when dequeued,
-	 * like the "regular" sigqueue.
-	 */
-	if (!list_empty(&q->list))
-		q = NULL;
-	spin_unlock_irqrestore(lock, flags);
-
-	if (q)
-		__sigqueue_free(q);
-}
-
 static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t, enum pid_type type)
 {
 	struct sigpending *pending;


