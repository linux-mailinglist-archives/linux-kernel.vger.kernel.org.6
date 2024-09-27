Return-Path: <linux-kernel+bounces-341482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 307ED9880B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467F7B21FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E81B07A7;
	Fri, 27 Sep 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ViRHYvxL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+cZSPqUx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3518B460
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426933; cv=none; b=amg2jsoUaawRN2EqOHmtXeyVo395LxulODov2JEaVsSf3EJOqzwh177bvRPsA8HkEXOYjxs49tg/XixrRmGVFeooK4QkZz5CbR1W4njOxkCYJnzaFIktB4jNX2w49wvfO4J2UxmwI8I2dG52MntF1Eum5PNxHQeRX4pG+ON21i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426933; c=relaxed/simple;
	bh=B+2TAbL5ECEgs7nw6T2RilAjCrqncNh+NmQwTs14m2k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=icnn7mU9D14H1MTAJMOoam66KM7l/EjYx8AgEak9kveUhoZkLbmni2Gflg0xiyPZ/64KarDg69u3XBXKJKRyX99wEoRKayTY5Vx3HC3AG/zRwc4AebrIY3ul4myWz+GZvTzCrdu7MB6Xh1R3jkX76vFgx9/MvVGO6QH/3KcdldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ViRHYvxL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+cZSPqUx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.386508461@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LOXnOtS2SoQNq0MXiARkvZd94aAhAmUpnLizG+MsF2Q=;
	b=ViRHYvxLblAfdkg9erWqraMh/MfufJUosT7zdIxBnUte4x49NWU9RPzOal/WP+2KViqQxo
	NbChShiH+YRO0i0nq0qWMGSBXJPZWgdmdVwWkI9xM2dXq03pJ9G0PLp9HZC0rznBJdnp5Q
	74bYoRmKASdTvfxk+0ma0YaedGa3oEQLxLINLSeFrspR+VkxkSsnK2JGpqlCa4HeeJNysF
	C2F6CMlt9nAW38VPWXcCVTG+eL5M8TahytLD6txBOtdsYyl21wX8sYtoCdvrzLbQdk2UBE
	jzbwQCn+YF45prZyIObBAK4hhm+XakpxVkmuJPkh/J5z3vSD7Esh6hDP+RrHaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LOXnOtS2SoQNq0MXiARkvZd94aAhAmUpnLizG+MsF2Q=;
	b=+cZSPqUxTtgoOIxVGnWQfWYgfpbHG/DzXo8nta2nGo383AlAixJblVsrk0wXYhYmEzGMNf
	sFlIGHWN5iBIdVCg==
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
Subject: [patch v4 08/27] posix-timers: Add proper state tracking
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:48 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Right now the state tracking is done by two struct members:

 - it_active:
     A boolean which tracks armed/disarmed state

 - it_signal_seq:
     A sequence counter which is used to invalidate settings
     and prevent rearming

Replace it_active with it_status and keep properly track about the states
in one place.

This allows to reuse it_signal_seq to track reprogramming, disarm and
delete operations in order to drop signals which are related to the state
previous of those operations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h   |  4 ++--
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/posix-cpu-timers.c | 15 ++++++++-------
 kernel/time/posix-timers.c     | 22 +++++++++++++---------
 kernel/time/posix-timers.h     |  6 ++++++
 5 files changed, 30 insertions(+), 19 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 253d106fac2c..02afbb4da7f7 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -147,7 +147,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @kclock:		Pointer to the k_clock struct handling this timer
  * @it_clock:		The posix timer clock id
  * @it_id:		The posix timer id for identifying the timer
- * @it_active:		Marker that timer is active
+ * @it_status:		The status of the timer
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
  * @it_signal_seq:	Sequence count to control signal delivery
@@ -168,7 +168,7 @@ struct k_itimer {
 	const struct k_clock	*kclock;
 	clockid_t		it_clock;
 	timer_t			it_id;
-	int			it_active;
+	int			it_status;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 22d5145dd9a7..71360f8072d4 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -585,7 +585,7 @@ static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 		 */
 		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
 		++ptr->it_signal_seq;
-		ptr->it_active = 1;
+		ptr->it_status = POSIX_TIMER_ARMED;
 		result = ALARMTIMER_RESTART;
 	}
 	spin_unlock_irqrestore(&ptr->it_lock, flags);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 993243b5be98..12f828d704b1 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,7 +453,6 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
 
-	timer->it_active = 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
@@ -494,11 +493,12 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing)
+		if (timer->it.cpu.firing) {
 			ret = TIMER_RETRY;
-		else
+		} else {
 			disarm_timer(timer, p);
-
+			timer->it_status = POSIX_TIMER_DISARMED;
+		}
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -560,7 +560,7 @@ static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
 
-	timer->it_active = 1;
+	timer->it_status = POSIX_TIMER_ARMED;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
@@ -586,7 +586,8 @@ static void cpu_timer_fire(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
-	timer->it_active = 0;
+	timer->it_status = POSIX_TIMER_DISARMED;
+
 	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
@@ -671,7 +672,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
-		timer->it_active = 0;
+		timer->it_status = POSIX_TIMER_DISARMED;
 	}
 
 	/*
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 26243d38d27d..6f0dacec25e0 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -272,7 +272,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
-		timr->it_active = 1;
+		timr->it_status = POSIX_TIMER_ARMED;
 		timr->it_overrun_last = timr->it_overrun;
 		timr->it_overrun = -1LL;
 		++timr->it_signal_seq;
@@ -292,14 +292,17 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	enum posix_timer_state state = POSIX_TIMER_DISARMED;
 	int ret, si_private = 0;
 	enum pid_type type;
 
 	lockdep_assert_held(&timr->it_lock);
 
-	timr->it_active = 0;
-	if (timr->it_interval)
+	if (timr->it_interval) {
+		state = POSIX_TIMER_REQUEUE_PENDING;
 		si_private = ++timr->it_signal_seq;
+	}
+	timr->it_status = state;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
 	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
@@ -367,7 +370,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_signal_seq;
-			timr->it_active = 1;
+			timr->it_status = POSIX_TIMER_ARMED;
 		}
 	}
 
@@ -647,10 +650,10 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	/* interval timer ? */
 	if (iv) {
 		cur_setting->it_interval = ktime_to_timespec64(iv);
-	} else if (!timr->it_active) {
+	} else if (timr->it_status == POSIX_TIMER_DISARMED) {
 		/*
 		 * SIGEV_NONE oneshot timers are never queued and therefore
-		 * timr->it_active is always false. The check below
+		 * timr->it_status is always DISARMED. The check below
 		 * vs. remaining time will handle this case.
 		 *
 		 * For all other timers there is nothing to update here, so
@@ -895,7 +898,7 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	if (kc->timer_try_to_cancel(timr) < 0)
 		return TIMER_RETRY;
 
-	timr->it_active = 0;
+	timr->it_status = POSIX_TIMER_DISARMED;
 	posix_timer_set_common(timr, new_setting);
 
 	/* Keep timer disarmed when it_value is zero */
@@ -908,7 +911,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-	timr->it_active = !sigev_none;
+	if (!sigev_none)
+		timr->it_status = POSIX_TIMER_ARMED;
 	return 0;
 }
 
@@ -1007,7 +1011,7 @@ int common_timer_del(struct k_itimer *timer)
 	timer->it_interval = 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
-	timer->it_active = 0;
+	timer->it_status = POSIX_TIMER_DISARMED;
 	return 0;
 }
 
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 4784ea65f685..4d09677e584e 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -1,6 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define TIMER_RETRY 1
 
+enum posix_timer_state {
+	POSIX_TIMER_DISARMED,
+	POSIX_TIMER_ARMED,
+	POSIX_TIMER_REQUEUE_PENDING,
+};
+
 struct k_clock {
 	int	(*clock_getres)(const clockid_t which_clock,
 				struct timespec64 *tp);


