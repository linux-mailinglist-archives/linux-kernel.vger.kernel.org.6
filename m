Return-Path: <linux-kernel+bounces-345553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C37D98B768
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79257B275C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268E19D889;
	Tue,  1 Oct 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7TTJhzy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCM63nuB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E21BF7F7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772157; cv=none; b=RItY+FX5ptYi7IYAy5cPqu5OFrts8eK7ZWaIOCmGWAClRqZGgoIQHtwU9bCGZy63lDFI9GhYP7h2gp+soTP7TsXV+MTUhEZWMWxDzZypdZv6C3gB9L117f2dNHWV1dwymCHwbE0Slg3tGw2dbuy9jTEpnM3rv1WIih8lYdgpdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772157; c=relaxed/simple;
	bh=duwzop1iEbg9uPOprlWbl3ogB4LJHXnaXlE9RCZU/EE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=R/ELk+9byGyw0QuwHW/QSVAUG7eiIftUU/z5CL44YHcnDKZHuzqfQeUHh3MqHK/nd+mnD++cgbxJklCNGrOOcphp54xopbmXpaVDPJYtIMUmO6tws40Onz/yBBf1IIpoVWHX/BTogX2H27w1IiHqZWt4bGuqADJbX9LsZHVZd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7TTJhzy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCM63nuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.690455381@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S7FOT/j0yjGCehM4hefRLoKmGu2M8mx1wfWixJm8yqg=;
	b=M7TTJhzyhXAS05Su167mV7bEm4pAnMpbZXT5B5hcVSJJuIxuZxzHUnkh5knYMpgy6rVNMz
	RKqdjuVSz0i3kFbuS2NLOuOOH1HXaUfbFRyBctzbVF3hOMUrutlAPGaUle9b47uabsJVAg
	2GaHvBxyA9Q1s2OaanAq8lFAxZBWlfG4P6uEKSjiTWSDNQrz3d9rbxw9j0wmZyEdm7MOMP
	zWcOKXmEboxTVvrnWj76VMfhWy7l2LumrTUv4sprsSO9B1xJpB29WnVi9x2O0q+MRnqYJr
	NZryFM4py+PWX+UK5Zu3FHueDGErcPv0Tba8w0edo6FQWkIWj0XjY7XjYi8/WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S7FOT/j0yjGCehM4hefRLoKmGu2M8mx1wfWixJm8yqg=;
	b=GCM63nuBmzcl4Hc4eH5Ojm71ZjB5F5oKmsobiLODy63WbBoO/JgUAoXDsqDc0HO8KboA7a
	qlqUx4NS9znzKWCw==
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
Subject: [patch V5 24/26] posix-timers: Cleanup SIG_IGN workaround leftovers
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:33 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the relevant hacks and the not longer required return values from
the related functions. The alarm timer workarounds will be cleaned up in a
separate step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h   |    2 -
 kernel/signal.c                |    7 +---
 kernel/time/alarmtimer.c       |   47 +++++------------------------
 kernel/time/posix-cpu-timers.c |   18 ++---------
 kernel/time/posix-timers.c     |   65 +++--------------------------------------
 kernel/time/posix-timers.h     |    2 -
 6 files changed, 23 insertions(+), 118 deletions(-)
---
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -111,7 +111,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
-int posixtimer_send_sigqueue(struct k_itimer *tmr);
+void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1960,7 +1960,7 @@ static inline struct task_struct *posixt
 	return t;
 }
 
-int posixtimer_send_sigqueue(struct k_itimer *tmr)
+void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
@@ -1972,10 +1972,10 @@ int posixtimer_send_sigqueue(struct k_it
 
 	t = posixtimer_get_target(tmr);
 	if (!t)
-		return -1;
+		return;
 
 	if (!likely(lock_task_sighand(t, &flags)))
-		return -1;
+		return;
 
 	/*
 	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
@@ -2041,7 +2041,6 @@ int posixtimer_send_sigqueue(struct k_it
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
-	return 0;
 }
 
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -197,28 +197,15 @@ static enum hrtimer_restart alarmtimer_f
 {
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
-	int ret = HRTIMER_NORESTART;
-	int restart = ALARMTIMER_NORESTART;
 
-	spin_lock_irqsave(&base->lock, flags);
-	alarmtimer_dequeue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard (spinlock_irqsave, &base->lock)
+		alarmtimer_dequeue(base, alarm);
 
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
@@ -567,30 +554,14 @@ static enum alarmtimer_type clock2alarm(
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
-	unsigned long flags;
-
-	spin_lock_irqsave(&ptr->it_lock, flags);
+	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 
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
-	spin_unlock_irqrestore(&ptr->it_lock, flags);
+	guard(spinlock_irqsave)(&ptr->it_lock);
+	posix_timer_queue_signal(ptr);
 
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
@@ -296,10 +296,9 @@ bool posixtimer_deliver_signal(struct ke
 	return ret;
 }
 
-int posix_timer_queue_signal(struct k_itimer *timr)
+void posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
@@ -309,9 +308,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	ret = posixtimer_send_sigqueue(timr);
-	/* If we failed to send the signal the timer stops. */
-	return ret > 0;
+	posixtimer_send_sigqueue(timr);
 }
 
 /*
@@ -324,62 +321,10 @@ int posix_timer_queue_signal(struct k_it
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
-	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	unsigned long flags;
 
-	spin_lock_irqsave(&timr->it_lock, flags);
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
-			 * jiffy expire every jiffy and recheck for a
-			 * valid signal handler.
-			 *
-			 * This avoids interrupt starvation in case of a
-			 * very small interval, which would expire the
-			 * timer immediately again.
-			 *
-			 * Moving now ahead of time by one jiffy tricks
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
+	guard(spinlock_irqsave)(&timr->it_lock);
+	posix_timer_queue_signal(timr);
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


