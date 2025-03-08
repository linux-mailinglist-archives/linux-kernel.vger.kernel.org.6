Return-Path: <linux-kernel+bounces-552628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E3A57C1C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED56E188AAAF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A020B1E1;
	Sat,  8 Mar 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQ11qUS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKajzwxV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43D1E8355
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452515; cv=none; b=SsalU6ouGwP+MCdRIduambopoFlwD9Eq8Nutte8QBOKFm3burJw0gBn8k7KI0ojK99t+fSnNHF8lQgMwbNMP2xTHUX2nE7adbchYDMiXaK+ucSRFYwbaAbuFfJ+dggjBdabS2X9MbvSlnrB4w+/kMzxdq808Vd5nfJXf0CFzxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452515; c=relaxed/simple;
	bh=ACRkWixJAqVfDOk1Q5wb1S5hQJR2mKiJgZ3G/R2/Ri8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PbvyMpEbNCc6UUchy+FVnGvdG7AG/9BH9YFa75vj9Fzi7i7BgmKtZW8uVkTvmdOM5BwhXF+2gaiN1qV7xFdJd7txfWHGF0ywo+VUorWCl0w1eoCXQKnqTuuPowD9hJ5rmfe6A3L2h2FHdsJ13mOUtdGVOhY5mLj/Gnwdz/lB/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQ11qUS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKajzwxV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.959825668@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6WOc3cDj6iOjUExLGGT8i0JmqAEDLdLDjsu3HEyVLCo=;
	b=vQ11qUS/X8aMNPNqrUeHEu4u2g6OCTdhgsu7kQGMIg4KWCO4cjnkzy4pz9GJQyWy7Cywfp
	1vYKrFjGI7UUi4zemBa419Ew6YUlfSjxhAHqEIDshQSOeVU1kgggSrhgn+4OlKdRneRq1I
	t0yXQHrz7OtmgGnS1LmqD1TfHZqjxQsvC6wmLxHAyKp+oMxpNxBBQ0OhZR0M7jyGF+huwN
	qdFKtCrQ65YWi99dd/DLsnMKUWQA7voNZA96Uas/XkFrLFd6KLsrjmt0uT8lkBWizgLKBM
	zFF3KfdKhAUVCW2AYNBTOZ+snH/K1BqenpHMRwcisuOvm7b0b9Hml8ODU20Dhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6WOc3cDj6iOjUExLGGT8i0JmqAEDLdLDjsu3HEyVLCo=;
	b=fKajzwxVFpD6SPi89J89JmkDD9jR4OmTJ8rIijD99GXe4kJhrTNXMNkZKvKXthcimekkws
	0MA2IIBIGWNlmtDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 08/18] posix-timers: Simplify lock/unlock_timer()
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:30 +0100 (CET)

Since the integration of sigqueue into the timer struct, lock_timer() is
only used in task context. So taking the lock with irqsave() is not longer
required.

Convert it to use spin_[un]lock_irq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
V2: New patch
---
 kernel/time/posix-timers.c |   70 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -53,14 +53,19 @@ static const struct k_clock clock_realti
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags);
+static struct k_itimer *__lock_timer(timer_t timer_id);
 
-#define lock_timer(tid, flags)						   \
-({	struct k_itimer *__timr;					   \
-	__cond_lock(&__timr->it_lock, __timr = __lock_timer(tid, flags));  \
-	__timr;								   \
+#define lock_timer(tid)							\
+({	struct k_itimer *__timr;					\
+	__cond_lock(&__timr->it_lock, __timr = __lock_timer(tid));	\
+	__timr;								\
 })
 
+static inline void unlock_timer(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+}
+
 static int hash(struct signal_struct *sig, unsigned int nr)
 {
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
@@ -144,11 +149,6 @@ static int posix_timer_add(struct k_itim
 	return -EAGAIN;
 }
 
-static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
-{
-	spin_unlock_irqrestore(&timr->it_lock, flags);
-}
-
 static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
@@ -538,7 +538,7 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clo
 }
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
+static struct k_itimer *__lock_timer(timer_t timer_id)
 {
 	struct k_itimer *timr;
 
@@ -580,14 +580,14 @@ static struct k_itimer *__lock_timer(tim
 	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
-		spin_lock_irqsave(&timr->it_lock, *flags);
+		spin_lock_irq(&timr->it_lock);
 		/*
 		 * Validate under timr::it_lock that timr::it_signal is
 		 * still valid. Pairs with #1 above.
 		 */
 		if (timr->it_signal == current->signal)
 			return timr;
-		spin_unlock_irqrestore(&timr->it_lock, *flags);
+		spin_unlock_irq(&timr->it_lock);
 	}
 	return NULL;
 }
@@ -680,17 +680,16 @@ void common_timer_get(struct k_itimer *t
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int ret = 0;
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 	if (!timr)
 		return -EINVAL;
 
 	memset(setting, 0, sizeof(*setting));
 	timr->kclock->timer_get(timr, setting);
 
-	unlock_timer(timr, flags);
+	unlock_timer(timr);
 	return ret;
 }
 
@@ -746,15 +745,14 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int overrun;
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 	if (!timr)
 		return -EINVAL;
 
 	overrun = timer_overrun_to_int(timr);
-	unlock_timer(timr, flags);
+	unlock_timer(timr);
 
 	return overrun;
 }
@@ -813,14 +811,13 @@ static void common_timer_wait_running(st
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer,
-					   unsigned long *flags)
+static struct k_itimer *timer_wait_running(struct k_itimer *timer)
 {
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
 	scoped_guard (rcu) {
-		unlock_timer(timer, *flags);
+		unlock_timer(timer);
 		/*
 		 * kc->timer_wait_running() might drop RCU lock. So @timer
 		 * cannot be touched anymore after the function returns!
@@ -829,7 +826,7 @@ static struct k_itimer *timer_wait_runni
 	}
 
 	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id, flags);
+	return lock_timer(timer_id);
 }
 
 /*
@@ -889,7 +886,6 @@ static int do_timer_settime(timer_t time
 			    struct itimerspec64 *old_spec64)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -899,7 +895,7 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 retry:
 	if (!timr)
 		return -EINVAL;
@@ -916,10 +912,10 @@ static int do_timer_settime(timer_t time
 		// We already got the old time...
 		old_spec64 = NULL;
 		/* Unlocks and relocks the timer if it still exists */
-		timr = timer_wait_running(timr, &flags);
+		timr = timer_wait_running(timr);
 		goto retry;
 	}
-	unlock_timer(timr, flags);
+	unlock_timer(timr);
 
 	return error;
 }
@@ -995,10 +991,7 @@ static inline void posix_timer_cleanup_i
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	struct k_itimer *timer;
-	unsigned long flags;
-
-	timer = lock_timer(timer_id, &flags);
+	struct k_itimer *timer = lock_timer(timer_id);
 
 retry_delete:
 	if (!timer)
@@ -1009,7 +1002,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
-		timer = timer_wait_running(timer, &flags);
+		timer = timer_wait_running(timer);
 		goto retry_delete;
 	}
 
@@ -1028,7 +1021,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 		WRITE_ONCE(timer->it_signal, NULL);
 	}
 
-	unlock_timer(timer, flags);
+	unlock_timer(timer);
 	posix_timer_unhash_and_free(timer);
 	return 0;
 }
@@ -1039,12 +1032,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-	unsigned long flags;
-
-	/*
-	 * irqsave is required to make timer_wait_running() work.
-	 */
-	spin_lock_irqsave(&timer->it_lock, flags);
+	spin_lock_irq(&timer->it_lock);
 
 retry_delete:
 	/*
@@ -1065,7 +1053,7 @@ static void itimer_delete(struct k_itime
 		 * do_exit() only for the last thread of the thread group.
 		 * So no other task can access and delete that timer.
 		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+		if (WARN_ON_ONCE(timer_wait_running(timer) != timer))
 			return;
 
 		goto retry_delete;
@@ -1082,7 +1070,7 @@ static void itimer_delete(struct k_itime
 	 */
 	WRITE_ONCE(timer->it_signal, NULL);
 
-	spin_unlock_irqrestore(&timer->it_lock, flags);
+	spin_unlock_irq(&timer->it_lock);
 	posix_timer_unhash_and_free(timer);
 }
 


