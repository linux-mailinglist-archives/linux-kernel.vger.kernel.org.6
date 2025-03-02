Return-Path: <linux-kernel+bounces-540744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B2A4B476
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BB23B2158
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076661EF084;
	Sun,  2 Mar 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hmpnw/IG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UDnbDy4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0E1EEA28
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944216; cv=none; b=LiYshKSXBQMz6XpCrAx18VNO1nTQ/9GmlwZiT0GW1D4jJfSCd42+YmOFy3XreVu2HHBoVl5pH35kvmQKltl5QASOss47YF7LtFnB2CItRjEwvpyr3h/lAxPreR8NGYSTMlHeOiIQME8r5zmm8rsylR1N1McllynduHij+cN2rcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944216; c=relaxed/simple;
	bh=AkSUA35ExS6aBl8//QJiv+TiB475ODpJiF2ceG+f/74=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VBHd5WUBStRkdtZEzBmz8eDoStmfpc/ZTlAMxNu77QAPAx0ywMkMe/74djMCCALKVPhE3j07w3C07y+yq1OrEShF0xHOLxxYiLPgJf/aN90soNPVXdUWOgoFPGU/ZYxK8CNkZjOOKx8I5189ndFWLMsZMGla0HBXwPeaN3B2Go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hmpnw/IG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UDnbDy4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.291265233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QCGoT9giFJLS+pv+a5LZeLjPMBj3VUG3X4dhDTU9960=;
	b=Hmpnw/IGghblgBcDAMxRa7nP2Dg5j7AlcDXn3gapPqbPKwmvemKkSsn2mZOSu/blkHXO4L
	QutgtgfWRdXQf84rATpG5iy46FgSUZYGYCMtdmWz88GoMgNkaJ8tf+vYV3cFb50m2+WTmr
	8sIZFyFfjewNZvWP85fT1LdkBShpWi8qat6a/l09zcJ01DRKV9ySahxLhVNYwydgO5Y/GX
	dXeCmb22VOJ9hPSQ5OACvCaSXPic5+SCCMM3p5j0k7SDzqIzWsDsvavC25jehBisoaWeit
	pL8hdBv9K+HawrAVzGhk7oRVM/9QcaRfUB5FnWhG9T4SAzVT9M6W1fSfMquPxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QCGoT9giFJLS+pv+a5LZeLjPMBj3VUG3X4dhDTU9960=;
	b=2UDnbDy4+U+fZX5H8s/mV4yIFBYaJpw0ltwviVkISk4WTV7XFz6bxMtux5cPMfK/7kIN3w
	8qB4LrJNe+D8z0CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 06/17] posix-timers: Use guards in a few places
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:52 +0100 (CET)

Switch locking and RCU to guards where applicable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/time/posix-timers.c |   86 ++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -397,9 +397,8 @@ void posixtimer_free_timer(struct k_itim
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 {
-	spin_lock(&hash_lock);
-	hlist_del_rcu(&tmr->t_hash);
-	spin_unlock(&hash_lock);
+	scoped_guard (spinlock, &hash_lock)
+		hlist_del_rcu(&tmr->t_hash);
 	posixtimer_putref(tmr);
 }
 
@@ -443,9 +442,8 @@ static int do_timer_create(clockid_t whi
 	new_timer->it_overrun = -1LL;
 
 	if (event) {
-		rcu_read_lock();
-		new_timer->it_pid = get_pid(good_sigevent(event));
-		rcu_read_unlock();
+		scoped_guard (rcu)
+			new_timer->it_pid = get_pid(good_sigevent(event));
 		if (!new_timer->it_pid) {
 			error = -EINVAL;
 			goto out;
@@ -484,15 +482,15 @@ static int do_timer_create(clockid_t whi
 	if (error)
 		goto out;
 
-	spin_lock_irq(&current->sighand->siglock);
-	/*
-	 * new_timer::it_signal contains the signal pointer with bit 0 set,
-	 * which makes it invalid for syscall operations. Store the
-	 * unmodified signal pointer to make it valid.
-	 */
-	WRITE_ONCE(new_timer->it_signal, current->signal);
-	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
-	spin_unlock_irq(&current->sighand->siglock);
+	scoped_guard (spinlock_irq, &current->sighand->siglock) {
+		/*
+		 * new_timer::it_signal contains the signal pointer with bit 0 set,
+		 * which makes it invalid for syscall operations. Store the
+		 * unmodified signal pointer to make it valid.
+		 */
+		WRITE_ONCE(new_timer->it_signal, current->signal);
+		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+	}
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
 	 * concurrent removal and cannot be touched anymore
@@ -572,7 +570,7 @@ static struct k_itimer *__lock_timer(tim
 	 * can't change, but timr::it_signal becomes NULL during
 	 * destruction.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
@@ -580,14 +578,10 @@ static struct k_itimer *__lock_timer(tim
 		 * Validate under timr::it_lock that timr::it_signal is
 		 * still valid. Pairs with #1 above.
 		 */
-		if (timr->it_signal == current->signal) {
-			rcu_read_unlock();
+		if (timr->it_signal == current->signal)
 			return timr;
-		}
 		spin_unlock_irqrestore(&timr->it_lock, *flags);
 	}
-	rcu_read_unlock();
-
 	return NULL;
 }
 
@@ -818,16 +812,15 @@ static struct k_itimer *timer_wait_runni
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
-	rcu_read_lock();
-	unlock_timer(timer, *flags);
-
-	/*
-	 * kc->timer_wait_running() might drop RCU lock. So @timer
-	 * cannot be touched anymore after the function returns!
-	 */
-	timer->kclock->timer_wait_running(timer);
+	scoped_guard (rcu) {
+		unlock_timer(timer, *flags);
+		/*
+		 * kc->timer_wait_running() might drop RCU lock. So @timer
+		 * cannot be touched anymore after the function returns!
+		 */
+		timer->kclock->timer_wait_running(timer);
+	}
 
-	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
 	return lock_timer(timer_id, flags);
 }
@@ -1013,20 +1006,20 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 		goto retry_delete;
 	}
 
-	spin_lock(&current->sighand->siglock);
-	hlist_del(&timer->list);
-	posix_timer_cleanup_ignored(timer);
-	/*
-	 * A concurrent lookup could check timer::it_signal lockless. It
-	 * will reevaluate with timer::it_lock held and observe the NULL.
-	 *
-	 * It must be written with siglock held so that the signal code
-	 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
-	 * which prevents it from moving a pending signal of a deleted
-	 * timer to the ignore list.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
-	spin_unlock(&current->sighand->siglock);
+	scoped_guard (spinlock, &current->sighand->siglock) {
+		hlist_del(&timer->list);
+		posix_timer_cleanup_ignored(timer);
+		/*
+		 * A concurrent lookup could check timer::it_signal lockless. It
+		 * will reevaluate with timer::it_lock held and observe the NULL.
+		 *
+		 * It must be written with siglock held so that the signal code
+		 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
+		 * which prevents it from moving a pending signal of a deleted
+		 * timer to the ignore list.
+		 */
+		WRITE_ONCE(timer->it_signal, NULL);
+	}
 
 	unlock_timer(timer, flags);
 	posix_timer_unhash_and_free(timer);
@@ -1099,9 +1092,8 @@ void exit_itimers(struct task_struct *ts
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
-	spin_lock_irq(&tsk->sighand->siglock);
-	hlist_move_list(&tsk->signal->posix_timers, &timers);
-	spin_unlock_irq(&tsk->sighand->siglock);
+	scoped_guard (spinlock_irq, &tsk->sighand->siglock)
+		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers)) {


