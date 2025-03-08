Return-Path: <linux-kernel+bounces-552627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A076A57C1B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A79E3A9230
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA0207644;
	Sat,  8 Mar 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bibw8EBU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrJEa/Lz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F24202F9A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452513; cv=none; b=IjZDxkqzKAfanR2QA1FiN/h1z69ZsybPLDHoLDIpKqcgugPnFRt2dbUPWoDZj8nlYlVsCSgDHiZ6FqO+g0XyXyVXVVEXGCd2GDTv9+x4WYgz+HQveh0twKduT0zHRXrg3Viiv2HBccajpvmemLRZlAFXRVW3v2nz8qpLZ4MlDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452513; c=relaxed/simple;
	bh=Kikv1cOuZ52fHMF2lOdP2stNkQm++hSxwwV0PI7NR58=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CLLV3S5zqte5nrjUT3jaI3ryRbeumsYUCnVUMwWYo042vj3OoAYxx/UK77coTSS+wjqRiHHTEJx85irWK9SCBja5azMB+JADx4og80rKtAomFcMZ7A3zCzV1JsB8hFC+5/ZvsuUhqchg9CDinqEfP6odiFt9Rmrwi1m3RgrvPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bibw8EBU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrJEa/Lz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.892762130@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2fHIYPPSBTnFA9+ynp17I3Mj7eH6sqePOgXAxOrPoEc=;
	b=bibw8EBUlnBLK5BmB/v5H87skuJHn3DAu7OlSzT8Bre5TESDMGoDsiTmobXu7h3w2zVXm+
	yQuQUvgf8tz8E6sw7vCUoxs8L22jisV3cGU6X5COdism7iSCo5VKMup8MfDwgHoZGvHPTK
	wCc3Absf5jYNc0JlhYXNEvmxxXdnmtsnDxiqQKho7m3DpEoja0PdyzZnJLrGpjupQQgrIA
	uVf+XEas+2Zn+6z7YCsREUIZFH6qwTnRhIDL4xVyk+u9naO30rZeEIG2NSlwgPGGjMmeGR
	i9D+1aqXyRGPevU9xVQ+/ZKmKHXRn3c3yKgftDKFOxxoqxGNz4H1tEW+19Srjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2fHIYPPSBTnFA9+ynp17I3Mj7eH6sqePOgXAxOrPoEc=;
	b=lrJEa/LzFe5MayDiBOFX6bvxOhUQt18ZsjXwB9uYX+ojf065NkchhhJEmvQ104p+ii1cPL
	g3lMOcZaqiUO2bBA==
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
Subject: [patch V3 07/18] posix-timers: Use guards in a few places
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:28 +0100 (CET)

Switch locking and RCU to guards where applicable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
V2: New patch
---
 kernel/time/posix-timers.c |   68 +++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

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
@@ -579,7 +577,7 @@ static struct k_itimer *__lock_timer(tim
 	 * can't change, but timr::it_signal becomes NULL during
 	 * destruction.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
 	if (timr) {
 		spin_lock_irqsave(&timr->it_lock, *flags);
@@ -587,14 +585,10 @@ static struct k_itimer *__lock_timer(tim
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
 
@@ -825,16 +819,15 @@ static struct k_itimer *timer_wait_runni
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
@@ -1020,20 +1013,20 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
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
@@ -1106,9 +1099,8 @@ void exit_itimers(struct task_struct *ts
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
-	spin_lock_irq(&tsk->sighand->siglock);
-	hlist_move_list(&tsk->signal->posix_timers, &timers);
-	spin_unlock_irq(&tsk->sighand->siglock);
+	scoped_guard (spinlock_irq, &tsk->sighand->siglock)
+		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers)) {


