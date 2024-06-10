Return-Path: <linux-kernel+bounces-208615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D2902734
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D0B1F21EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272415AAD3;
	Mon, 10 Jun 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mph6g5lK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OjeaMhg5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB313158DD4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037790; cv=none; b=MDTAlq8XCiwpny5mVS6M27Di0d6llWZQDvk/T06dCOP1gehTSAcMxSwEZH/zCWSDQEbIe3JDLBxG8vtx4RqDbs+l5EzexLQ1qJRy2Perffy+DTTe24iHNCZ++i+qcDbbkFhSZRopp7PgduGHp17srC8oFktx5Bga43/F2wGgZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037790; c=relaxed/simple;
	bh=6+oMP4yhaB9snN9L9lq4a4BLEyD2V/UbAwBhcb8bH04=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A/rlbEWw/zmpV+LiDxcmm0bMyettPRrKDet26j64ZPWc0LKF7CUTzKwRwo26zP9gNJ2eBej+BOJ+fvqt9hUpH8+mfwr0Zy32s/VhTBCI4bWJkwoFQPbuysv4++kSySNQKv5SYaEIBOb48QoUa/TizBG9ocEN09OfVzaUlBivwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mph6g5lK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OjeaMhg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164028.533290072@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kAkqE4xY1tktojAkL7ohXROJF3Nq4zDNsVY2SgjGpGc=;
	b=mph6g5lK9iKlCq9uEOIHnartDn/+Ye+W47A5lD5lL56fciSSnrpf8jQEw/7agH0TgXl1nB
	/ZcERDb5bj4cPuGp0JCFLSLRMvYljLTbRZZCY9w9eQPER/tYDbyEHkFZyUlCFNY+b+YdDC
	+VjQgpHHYvUYUQGoaU8EF3dLWl1S/lNVdzyy384e6Eqam3ohgI/+mKXgC+X7oOcO0QxTsB
	2lppqaij4MmlI7LwCkDFABJajAzhluxMGF5yTpjsWXJ/qoDWmUAMXUHUZgEMU9Q70FXUn2
	XIif6THgoIzdf00gDO3/Nn4NKDjGtoDWsR0vka2K0F9gQglZjsOe9ZmAEi3CTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kAkqE4xY1tktojAkL7ohXROJF3Nq4zDNsVY2SgjGpGc=;
	b=OjeaMhg53YgGjG0whpTs1A2jK3suEajNrY5nnx4/ujXxrwJSeL4cvzdakeBfA8z2hyuI2Q
	JMHm7hXaI8sDetDg==
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
Subject: [patch V3 49/51] posix-timers: Cleanup SIG_IGN workaround leftovers
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:43:05 +0200 (CEST)

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the relevant hacks and the not longer required return values from
the related functions. The alarm timer workarounds will be cleaned up in a
separate step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    2 -
 kernel/signal.c                |    3 -
 kernel/time/alarmtimer.c       |   37 +++---------------------
 kernel/time/posix-cpu-timers.c |   18 ++---------
 kernel/time/posix-timers.c     |   63 +++--------------------------------------
 kernel/time/posix-timers.h     |    2 -
 6 files changed, 18 insertions(+), 107 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -111,7 +111,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
-int posixtimer_send_sigqueue(struct k_itimer *tmr);
+void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1968,7 +1968,7 @@ static inline struct task_struct *posixt
 	return t;
 }
 
-int posixtimer_send_sigqueue(struct k_itimer *tmr)
+void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
@@ -2053,7 +2053,6 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
-	return 0;
 }
 
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -198,27 +198,16 @@ static enum hrtimer_restart alarmtimer_f
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
 	unsigned long flags;
-	int ret = HRTIMER_NORESTART;
-	int restart = ALARMTIMER_NORESTART;
 
 	spin_lock_irqsave(&base->lock, flags);
 	alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->get_ktime());
-
-	spin_lock_irqsave(&base->lock, flags);
-	if (restart != ALARMTIMER_NORESTART) {
-		hrtimer_set_expires(&alarm->timer, alarm->node.expires);
-		alarmtimer_enqueue(base, alarm);
-		ret = HRTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&base->lock, flags);
+		alarm->function(alarm, base->get_ktime());
 
 	trace_alarmtimer_fired(alarm, base->get_ktime());
-	return ret;
-
+	return HRTIMER_NORESTART;
 }
 
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
@@ -567,30 +556,16 @@ static enum alarmtimer_type clock2alarm(
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
-							ktime_t now)
+static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
-	struct k_itimer *ptr = container_of(alarm, struct k_itimer,
-					    it.alarm.alarmtimer);
-	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
+	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ptr->it_lock, flags);
-
-	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
-		/*
-		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper. Ensure that
-		 * small intervals cannot starve the system.
-		 */
-		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_signal_seq;
-		ptr->it_status = POSIX_TIMER_ARMED;
-		result = ALARMTIMER_RESTART;
-	}
+	posix_timer_queue_signal(ptr);
 	spin_unlock_irqrestore(&ptr->it_lock, flags);
 
-	return result;
+	return ALARMTIMER_NORESTART;
 }
 
 /**
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -595,21 +595,11 @@ static void cpu_timer_fire(struct k_itim
 		 */
 		wake_up_process(timer->it_process);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (!timer->it_interval) {
-		/*
-		 * One-shot timer.  Clear it as soon as it's fired.
-		 */
+	} else {
 		posix_timer_queue_signal(timer);
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_queue_signal(timer)) {
-		/*
-		 * The signal did not get queued because the signal
-		 * was ignored, so we won't get any callback to
-		 * reload the timer.  But we need to keep it
-		 * ticking in case the signal is deliverable next time.
-		 */
-		posix_cpu_timer_rearm(timer);
-		++timer->it_signal_seq;
+		/* Disable oneshot timers */
+		if (!timer->it_interval)
+			cpu_timer_setexpires(ctmr, 0);
 	}
 }
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -300,10 +300,9 @@ bool posixtimer_deliver_signal(struct ke
 	return ret;
 }
 
-int posix_timer_queue_signal(struct k_itimer *timr)
+void posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
@@ -313,9 +312,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	ret = posixtimer_send_sigqueue(timr);
-	/* If we failed to send the signal the timer stops. */
-	return ret > 0;
+	posixtimer_send_sigqueue(timr);
 }
 
 /*
@@ -328,62 +325,12 @@ int posix_timer_queue_signal(struct k_it
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
-	enum hrtimer_restart ret = HRTIMER_NORESTART;
 	unsigned long flags;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
-
-	if (posix_timer_queue_signal(timr)) {
-		/*
-		 * The signal was not queued due to SIG_IGN. As a
-		 * consequence the timer is not going to be rearmed from
-		 * the signal delivery path. But as a real signal handler
-		 * can be installed later the timer must be rearmed here.
-		 */
-		if (timr->it_interval != 0) {
-			ktime_t now = hrtimer_cb_get_time(timer);
-
-			/*
-			 * FIXME: What we really want, is to stop this
-			 * timer completely and restart it in case the
-			 * SIG_IGN is removed. This is a non trivial
-			 * change to the signal handling code.
-			 *
-			 * For now let timers with an interval less than a
-			 * jiffie expire every jiffie and recheck for a
-			 * valid signal handler.
-			 *
-			 * This avoids interrupt starvation in case of a
-			 * very small interval, which would expire the
-			 * timer immediately again.
-			 *
-			 * Moving now ahead of time by one jiffie tricks
-			 * hrtimer_forward() to expire the timer later,
-			 * while it still maintains the overrun accuracy
-			 * for the price of a slight inconsistency in the
-			 * timer_gettime() case. This is at least better
-			 * than a timer storm.
-			 *
-			 * Only required when high resolution timers are
-			 * enabled as the periodic tick based timers are
-			 * automatically aligned to the next tick.
-			 */
-			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
-				ktime_t kj = TICK_NSEC;
-
-				if (timr->it_interval < kj)
-					now = ktime_add(now, kj);
-			}
-
-			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
-			ret = HRTIMER_RESTART;
-			++timr->it_signal_seq;
-			timr->it_status = POSIX_TIMER_ARMED;
-		}
-	}
-
-	unlock_timer(timr, flags);
-	return ret;
+	posix_timer_queue_signal(timr);
+	spin_unlock_irqrestore(&timr->it_lock, flags);
+	return HRTIMER_NORESTART;
 }
 
 static struct pid *good_sigevent(sigevent_t * event)
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,7 +42,7 @@ extern const struct k_clock clock_proces
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_queue_signal(struct k_itimer *timr);
+void posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,


