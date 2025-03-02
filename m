Return-Path: <linux-kernel+bounces-540745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954AFA4B474
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E50216B5E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549C81EEA28;
	Sun,  2 Mar 2025 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLuzbFiK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nngAjIX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC171EF092
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944219; cv=none; b=t6xadA+MV46m9YbhExLEGCJKTL5omY6Eh7hNLs1MY2iI7KqUcXVErQQirpx0kIV18s65TUqqy35S7ybCINVjwu2A6qggJzDK9WuxFPnXamDpjTjW8C9RpraGfgAIBeAL/GQg/3hfYyJGB19f/ulDltZCiprD1PXk6zsRjpDjsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944219; c=relaxed/simple;
	bh=wuLQYqjk+6m09X5A+jf73uzZuGnLJwPNPzfnYqP66rA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DnAK4iniTZrK5SCDa3KkLr75wWLQ2n9XirtiA5wORCL2gOoAOsA7IOgjORm/zC44SJZQMmZFQoAAnFZZtXGw6VQMzvx3tC6Oh/Lc/LrNLE/4/W+BkmF234wV52wFeDvqgzKVK8NDwLujQ1LsplJD638GnWq+SsgBPrBoZIla8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLuzbFiK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nngAjIX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.354754536@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FBa8Z5ux6kpNt1T/1dV+QnJKzr121MSpKu0kjmBjvdk=;
	b=FLuzbFiKVAIX4xHfqJgckAtr4/nLzmC/hIcVQ06whkiVWkq+SYnNmNTpDpXn3CaGZ11iX6
	5UlNs2VJIp23YgaNuDX9y7gbjGamGeil4FzlIg/Yusm6pMEU4k9TE7bo0jTTejIq8OTmbs
	kDnmRqhNHtJpYiRa6lzUraGIh9fQ3qogouG5eX7lsI2DEg68/1llSmpAOHIkDiyNpvKLI+
	cpp3YbVUyea8gwQgOUAHV9wrATI949sXY7BrGjV6a9iHotmkpGwQyo9/fgbBt5oWVgWhBV
	b4RyDv0+RRX6jdX9OsSrwAMHNut0E5d0cJhG1tN3H6fWktXbHSFaQ/Z2LlmAcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FBa8Z5ux6kpNt1T/1dV+QnJKzr121MSpKu0kjmBjvdk=;
	b=0nngAjIXaY6Jf6Ms63XDCaXGRbZWUPTZkED1PQ8gaNpHzZxMHpM0neoouBNgraSP8He06u
	rtaNXHIfhgZ/xICw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 07/17] posix-timers: Simplify lock/unlock_timer()
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:54 +0100 (CET)

Since the integration of sigqueue into the timer struct, lock_timer() is
only used in task context. So taking the lock with irqsave() is not longer
required.

Convert it to use spin_[un]lock_irq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -531,7 +531,7 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clo
 }
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
+static struct k_itimer *__lock_timer(timer_t timer_id)
 {
 	struct k_itimer *timr;
 
@@ -573,14 +573,14 @@ static struct k_itimer *__lock_timer(tim
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
@@ -673,17 +673,16 @@ void common_timer_get(struct k_itimer *t
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
 
@@ -739,15 +738,14 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
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
@@ -806,14 +804,13 @@ static void common_timer_wait_running(st
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
@@ -822,7 +819,7 @@ static struct k_itimer *timer_wait_runni
 	}
 
 	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id, flags);
+	return lock_timer(timer_id);
 }
 
 /*
@@ -882,7 +879,6 @@ static int do_timer_settime(timer_t time
 			    struct itimerspec64 *old_spec64)
 {
 	struct k_itimer *timr;
-	unsigned long flags;
 	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -892,7 +888,7 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	timr = lock_timer(timer_id, &flags);
+	timr = lock_timer(timer_id);
 retry:
 	if (!timr)
 		return -EINVAL;
@@ -909,10 +905,10 @@ static int do_timer_settime(timer_t time
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
@@ -988,10 +984,7 @@ static inline void posix_timer_cleanup_i
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
@@ -1002,7 +995,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
-		timer = timer_wait_running(timer, &flags);
+		timer = timer_wait_running(timer);
 		goto retry_delete;
 	}
 
@@ -1021,7 +1014,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 		WRITE_ONCE(timer->it_signal, NULL);
 	}
 
-	unlock_timer(timer, flags);
+	unlock_timer(timer);
 	posix_timer_unhash_and_free(timer);
 	return 0;
 }
@@ -1032,12 +1025,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
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
@@ -1058,7 +1046,7 @@ static void itimer_delete(struct k_itime
 		 * do_exit() only for the last thread of the thread group.
 		 * So no other task can access and delete that timer.
 		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+		if (WARN_ON_ONCE(timer_wait_running(timer) != timer))
 			return;
 
 		goto retry_delete;
@@ -1075,7 +1063,7 @@ static void itimer_delete(struct k_itime
 	 */
 	WRITE_ONCE(timer->it_signal, NULL);
 
-	spin_unlock_irqrestore(&timer->it_lock, flags);
+	spin_unlock_irq(&timer->it_lock);
 	posix_timer_unhash_and_free(timer);
 }
 


