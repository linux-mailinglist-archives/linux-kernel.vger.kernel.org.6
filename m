Return-Path: <linux-kernel+bounces-315086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4196BDDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166E51F26AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC61DC195;
	Wed,  4 Sep 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFJXDPdV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHW4fGnl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802C1DB952
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455138; cv=none; b=TG4iBzCz+BPLNBeSo/PUp3IRO0vCcMma9An5srqhNPx3J0LffWr3O2ba0Lh15mBr/bemMuDv8aCoNjRy5b4lw3/AQfjo2lmC57k7yzaOTW7kUhTvjtV6LDfwGVqkyGo+1tDU/TLn+As0DpVsruXkAzsQ0+lEOfZ9oq3FHKSGlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455138; c=relaxed/simple;
	bh=em2N7rF7z5+u9IeG68v5zVAh6CzhV7Xw70Z17/621HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9zFA8FyZhl7odPyV34EaGkv8HhuIQ5LcZV93wYKr/WvnZRFIgc7uRIt7KW76X6A5drkefX3Rj7hkUY63zcHhuWoPZMZ+gZPIc1wdQItwizFw64H+r7Ey9zNdSDs45a+ov7p5AQoENyl6Zm3/5d9KpAus0D4AEB86V/uaFqOxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFJXDPdV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHW4fGnl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztFVARnh4fLRlAGS80PoqKvJNvpKqlSKmKZi2G9C0Cg=;
	b=zFJXDPdV4J2BI+xTO/DAJGZ+HinrWA3Q515p9G4pM2nmAmKp5pkcrtsAcxX0AgufZas98u
	ROyD6P7BO84/xbHfGKbahPfiTcPliuFBRTmvW9bUZvjXPgrUj/u/P746vXw5SfTBzAPgqq
	jCaUFCKgs6Ov85E+3Hgu5dI6P0A+Fx7Jnr/TkHZ8JYshclE+bUngPBy/r3dzesv/aukBDA
	UisHEJUzrGrGZNrQdur8NkuBur/iz2PRCEoEX6ZPy/slvhRwPo+pwrVRBvGE4YAgJ1bTCU
	n3x62UGdZbO6KrWsoRaIxO+wEid9K/yhlq/Tx5alFObu20H3eodnolqrzrdcfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztFVARnh4fLRlAGS80PoqKvJNvpKqlSKmKZi2G9C0Cg=;
	b=cHW4fGnl+xqBVRYSjePzdkC3SLeqzlIM297jgqGQp3MOD41da++odLBMTdpDLC8AKZePpf
	IwPH1NUVPtKTMkBw==
Date: Wed, 04 Sep 2024 15:04:54 +0200
Subject: [PATCH 04/15] timers: Move *sleep*() and timeout functions into a
 separate file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-4-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

All schedule_timeout() and *sleep*() related functions are interfaces on
top of timer list timers and hrtimers to add a sleep to the code. As they
are built on top of the timer list timers and hrtimers, the [hr]timer
interfaces are already used except when queuing the timer in
schedule_timeout(). But there exists the appropriate interface add_timer()
which does the same job with an extra check for an already pending timer.

Split all those functions as they are into a separate file and use
add_timer() instead of __mod_timer() in schedule_timeout().

While at it fix minor formatting issues and a multi line printk function
call in schedule_timeout(). While at it also add not listed
include/linux/delay.h to the MAINTAINTERS file.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 MAINTAINERS                 |   2 +
 kernel/time/Makefile        |   2 +-
 kernel/time/hrtimer.c       | 120 -----------------
 kernel/time/sleep_timeout.c | 320 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/time/timer.c         | 192 --------------------------
 5 files changed, 323 insertions(+), 313 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..e9cb09990e2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10010,10 +10010,12 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	Documentation/timers/
 F:	include/linux/clockchips.h
+F:	include/linux/delay.h
 F:	include/linux/hrtimer.h
 F:	include/linux/timer.h
 F:	kernel/time/clockevents.c
 F:	kernel/time/hrtimer.c
+F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 4af2a264a160..fe0ae82124fe 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += time.o timer.o hrtimer.o
+obj-y += time.o timer.o hrtimer.o sleep_timeout.o
 obj-y += timekeeping.o ntp.o clocksource.o jiffies.o timer_list.o
 obj-y += timeconv.o timecounter.o alarmtimer.o
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e834b2bd83df..2750ce6cb2e4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2242,123 +2242,3 @@ void __init hrtimers_init(void)
 	hrtimers_prepare_cpu(smp_processor_id());
 	open_softirq(HRTIMER_SOFTIRQ, hrtimer_run_softirq);
 }
-
-/**
- * schedule_hrtimeout_range_clock - sleep until timeout
- * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
- * @mode:	timer mode
- * @clock_id:	timer clock to be used
- */
-int __sched
-schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
-			       const enum hrtimer_mode mode, clockid_t clock_id)
-{
-	struct hrtimer_sleeper t;
-
-	/*
-	 * Optimize when a zero timeout value is given. It does not
-	 * matter whether this is an absolute or a relative time.
-	 */
-	if (expires && *expires == 0) {
-		__set_current_state(TASK_RUNNING);
-		return 0;
-	}
-
-	/*
-	 * A NULL parameter means "infinite"
-	 */
-	if (!expires) {
-		schedule();
-		return -EINTR;
-	}
-
-	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
-	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
-	hrtimer_sleeper_start_expires(&t, mode);
-
-	if (likely(t.task))
-		schedule();
-
-	hrtimer_cancel(&t.timer);
-	destroy_hrtimer_on_stack(&t.timer);
-
-	__set_current_state(TASK_RUNNING);
-
-	return !t.task ? 0 : -EINTR;
-}
-EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
-
-/**
- * schedule_hrtimeout_range - sleep until timeout
- * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
- * @mode:	timer mode
- *
- * Make the current task sleep until the given expiry time has
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly
- * for regular (non RT/DL) tasks.
- * The kernel give the normal best effort behavior for "@expires+@delta",
- * but may decide to fire the timer earlier, but no earlier than @expires.
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Returns 0 when the timer has expired. If the task was woken before the
- * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
- * by an explicit wakeup, it returns -EINTR.
- */
-int __sched schedule_hrtimeout_range(ktime_t *expires, u64 delta,
-				     const enum hrtimer_mode mode)
-{
-	return schedule_hrtimeout_range_clock(expires, delta, mode,
-					      CLOCK_MONOTONIC);
-}
-EXPORT_SYMBOL_GPL(schedule_hrtimeout_range);
-
-/**
- * schedule_hrtimeout - sleep until timeout
- * @expires:	timeout value (ktime_t)
- * @mode:	timer mode
- *
- * Make the current task sleep until the given expiry time has
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Returns 0 when the timer has expired. If the task was woken before the
- * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
- * by an explicit wakeup, it returns -EINTR.
- */
-int __sched schedule_hrtimeout(ktime_t *expires,
-			       const enum hrtimer_mode mode)
-{
-	return schedule_hrtimeout_range(expires, 0, mode);
-}
-EXPORT_SYMBOL_GPL(schedule_hrtimeout);
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
new file mode 100644
index 000000000000..9ecbce7da537
--- /dev/null
+++ b/kernel/time/sleep_timeout.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Kernel internal schedule timeout and sleeping functions
+ */
+
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/debug.h>
+
+#include "tick-internal.h"
+
+/*
+ * Since schedule_timeout()'s timer is defined on the stack, it must store
+ * the target task on the stack as well.
+ */
+struct process_timer {
+	struct timer_list timer;
+	struct task_struct *task;
+};
+
+static void process_timeout(struct timer_list *t)
+{
+	struct process_timer *timeout = from_timer(timeout, t, timer);
+
+	wake_up_process(timeout->task);
+}
+
+/**
+ * schedule_timeout - sleep until timeout
+ * @timeout: timeout value in jiffies
+ *
+ * Make the current task sleep until @timeout jiffies have elapsed.
+ * The function behavior depends on the current task state
+ * (see also set_current_state() description):
+ *
+ * %TASK_RUNNING - the scheduler is called, but the task does not sleep
+ * at all. That happens because sched_submit_work() does nothing for
+ * tasks in %TASK_RUNNING state.
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
+ * pass before the routine returns unless the current task is explicitly
+ * woken up, (e.g. by wake_up_process()).
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task or the current task is explicitly woken
+ * up.
+ *
+ * The current task state is guaranteed to be %TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
+ * the CPU away without a bound on the timeout. In this case the return
+ * value will be %MAX_SCHEDULE_TIMEOUT.
+ *
+ * Returns 0 when the timer has expired otherwise the remaining time in
+ * jiffies will be returned. In all cases the return value is guaranteed
+ * to be non-negative.
+ */
+signed long __sched schedule_timeout(signed long timeout)
+{
+	struct process_timer timer;
+	unsigned long expire;
+
+	switch (timeout) {
+	case MAX_SCHEDULE_TIMEOUT:
+		/*
+		 * These two special cases are useful to be comfortable
+		 * in the caller. Nothing more. We could take
+		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
+		 * but I' d like to return a valid offset (>=0) to allow
+		 * the caller to do everything it want with the retval.
+		 */
+		schedule();
+		goto out;
+	default:
+		/*
+		 * Another bit of PARANOID. Note that the retval will be
+		 * 0 since no piece of kernel is supposed to do a check
+		 * for a negative retval of schedule_timeout() (since it
+		 * should never happens anyway). You just have the printk()
+		 * that will tell you if something is gone wrong and where.
+		 */
+		if (timeout < 0) {
+			pr_err("%s: wrong timeout value %lx\n", __func__, timeout);
+			dump_stack();
+			__set_current_state(TASK_RUNNING);
+			goto out;
+		}
+	}
+
+	expire = timeout + jiffies;
+
+	timer.task = current;
+	timer_setup_on_stack(&timer.timer, process_timeout, 0);
+	timer.timer.expires = expire;
+	add_timer(&timer.timer);
+	schedule();
+	del_timer_sync(&timer.timer);
+
+	/* Remove the timer from the object tracker */
+	destroy_timer_on_stack(&timer.timer);
+
+	timeout = expire - jiffies;
+
+ out:
+	return timeout < 0 ? 0 : timeout;
+}
+EXPORT_SYMBOL(schedule_timeout);
+
+/*
+ * We can use __set_current_state() here because schedule_timeout() calls
+ * schedule() unconditionally.
+ */
+signed long __sched schedule_timeout_interruptible(signed long timeout)
+{
+	__set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_interruptible);
+
+signed long __sched schedule_timeout_killable(signed long timeout)
+{
+	__set_current_state(TASK_KILLABLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_killable);
+
+signed long __sched schedule_timeout_uninterruptible(signed long timeout)
+{
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_uninterruptible);
+
+/*
+ * Like schedule_timeout_uninterruptible(), except this task will not contribute
+ * to load average.
+ */
+signed long __sched schedule_timeout_idle(signed long timeout)
+{
+	__set_current_state(TASK_IDLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_idle);
+
+/**
+ * schedule_hrtimeout_range_clock - sleep until timeout
+ * @expires:	timeout value (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t)
+ * @mode:	timer mode
+ * @clock_id:	timer clock to be used
+ */
+int __sched
+schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
+			       const enum hrtimer_mode mode, clockid_t clock_id)
+{
+	struct hrtimer_sleeper t;
+
+	/*
+	 * Optimize when a zero timeout value is given. It does not
+	 * matter whether this is an absolute or a relative time.
+	 */
+	if (expires && *expires == 0) {
+		__set_current_state(TASK_RUNNING);
+		return 0;
+	}
+
+	/*
+	 * A NULL parameter means "infinite"
+	 */
+	if (!expires) {
+		schedule();
+		return -EINTR;
+	}
+
+	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
+	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
+	hrtimer_sleeper_start_expires(&t, mode);
+
+	if (likely(t.task))
+		schedule();
+
+	hrtimer_cancel(&t.timer);
+	destroy_hrtimer_on_stack(&t.timer);
+
+	__set_current_state(TASK_RUNNING);
+
+	return !t.task ? 0 : -EINTR;
+}
+EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
+
+/**
+ * schedule_hrtimeout_range - sleep until timeout
+ * @expires:	timeout value (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t)
+ * @mode:	timer mode
+ *
+ * Make the current task sleep until the given expiry time has
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * The @delta argument gives the kernel the freedom to schedule the
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
+ * The kernel give the normal best effort behavior for "@expires+@delta",
+ * but may decide to fire the timer earlier, but no earlier than @expires.
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
+ * pass before the routine returns unless the current task is explicitly
+ * woken up, (e.g. by wake_up_process()).
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task or the current task is explicitly woken
+ * up.
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Returns 0 when the timer has expired. If the task was woken before the
+ * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
+ * by an explicit wakeup, it returns -EINTR.
+ */
+int __sched schedule_hrtimeout_range(ktime_t *expires, u64 delta,
+				     const enum hrtimer_mode mode)
+{
+	return schedule_hrtimeout_range_clock(expires, delta, mode,
+					      CLOCK_MONOTONIC);
+}
+EXPORT_SYMBOL_GPL(schedule_hrtimeout_range);
+
+/**
+ * schedule_hrtimeout - sleep until timeout
+ * @expires:	timeout value (ktime_t)
+ * @mode:	timer mode
+ *
+ * Make the current task sleep until the given expiry time has
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout time is guaranteed to
+ * pass before the routine returns unless the current task is explicitly
+ * woken up, (e.g. by wake_up_process()).
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task or the current task is explicitly woken
+ * up.
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Returns 0 when the timer has expired. If the task was woken before the
+ * timer expired by a signal (only possible in state TASK_INTERRUPTIBLE) or
+ * by an explicit wakeup, it returns -EINTR.
+ */
+int __sched schedule_hrtimeout(ktime_t *expires,
+			       const enum hrtimer_mode mode)
+{
+	return schedule_hrtimeout_range(expires, 0, mode);
+}
+EXPORT_SYMBOL_GPL(schedule_hrtimeout);
+
+/**
+ * msleep - sleep safely even with waitqueue interruptions
+ * @msecs: Time in milliseconds to sleep for
+ */
+void msleep(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs);
+
+	while (timeout)
+		timeout = schedule_timeout_uninterruptible(timeout);
+}
+EXPORT_SYMBOL(msleep);
+
+/**
+ * msleep_interruptible - sleep waiting for signals
+ * @msecs: Time in milliseconds to sleep for
+ */
+unsigned long msleep_interruptible(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs);
+
+	while (timeout && !signal_pending(current))
+		timeout = schedule_timeout_interruptible(timeout);
+	return jiffies_to_msecs(timeout);
+}
+EXPORT_SYMBOL(msleep_interruptible);
+
+/**
+ * usleep_range_state - Sleep for an approximate time in a given state
+ * @min:	Minimum time in usecs to sleep
+ * @max:	Maximum time in usecs to sleep
+ * @state:	State of the current task that will be while sleeping
+ *
+ * In non-atomic context where the exact wakeup time is flexible, use
+ * usleep_range_state() instead of udelay().  The sleep improves responsiveness
+ * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
+ * power usage by allowing hrtimers to take advantage of an already-
+ * scheduled interrupt instead of scheduling a new one just for this sleep.
+ */
+void __sched usleep_range_state(unsigned long min, unsigned long max,
+				unsigned int state)
+{
+	ktime_t exp = ktime_add_us(ktime_get(), min);
+	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
+
+	for (;;) {
+		__set_current_state(state);
+		/* Do not return before the requested sleep time has elapsed */
+		if (!schedule_hrtimeout_range(&exp, delta, HRTIMER_MODE_ABS))
+			break;
+	}
+}
+EXPORT_SYMBOL(usleep_range_state);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2b38f3035a3e..bb53d22cc911 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -37,7 +37,6 @@
 #include <linux/tick.h>
 #include <linux/kallsyms.h>
 #include <linux/irq_work.h>
-#include <linux/sched/signal.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
@@ -2526,141 +2525,6 @@ void update_process_times(int user_tick)
 		run_posix_cpu_timers();
 }
 
-/*
- * Since schedule_timeout()'s timer is defined on the stack, it must store
- * the target task on the stack as well.
- */
-struct process_timer {
-	struct timer_list timer;
-	struct task_struct *task;
-};
-
-static void process_timeout(struct timer_list *t)
-{
-	struct process_timer *timeout = from_timer(timeout, t, timer);
-
-	wake_up_process(timeout->task);
-}
-
-/**
- * schedule_timeout - sleep until timeout
- * @timeout: timeout value in jiffies
- *
- * Make the current task sleep until @timeout jiffies have elapsed.
- * The function behavior depends on the current task state
- * (see also set_current_state() description):
- *
- * %TASK_RUNNING - the scheduler is called, but the task does not sleep
- * at all. That happens because sched_submit_work() does nothing for
- * tasks in %TASK_RUNNING state.
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
- * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process()).
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task or the current task is explicitly woken
- * up.
- *
- * The current task state is guaranteed to be %TASK_RUNNING when this
- * routine returns.
- *
- * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
- * the CPU away without a bound on the timeout. In this case the return
- * value will be %MAX_SCHEDULE_TIMEOUT.
- *
- * Returns 0 when the timer has expired otherwise the remaining time in
- * jiffies will be returned. In all cases the return value is guaranteed
- * to be non-negative.
- */
-signed long __sched schedule_timeout(signed long timeout)
-{
-	struct process_timer timer;
-	unsigned long expire;
-
-	switch (timeout)
-	{
-	case MAX_SCHEDULE_TIMEOUT:
-		/*
-		 * These two special cases are useful to be comfortable
-		 * in the caller. Nothing more. We could take
-		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
-		 * but I' d like to return a valid offset (>=0) to allow
-		 * the caller to do everything it want with the retval.
-		 */
-		schedule();
-		goto out;
-	default:
-		/*
-		 * Another bit of PARANOID. Note that the retval will be
-		 * 0 since no piece of kernel is supposed to do a check
-		 * for a negative retval of schedule_timeout() (since it
-		 * should never happens anyway). You just have the printk()
-		 * that will tell you if something is gone wrong and where.
-		 */
-		if (timeout < 0) {
-			printk(KERN_ERR "schedule_timeout: wrong timeout "
-				"value %lx\n", timeout);
-			dump_stack();
-			__set_current_state(TASK_RUNNING);
-			goto out;
-		}
-	}
-
-	expire = timeout + jiffies;
-
-	timer.task = current;
-	timer_setup_on_stack(&timer.timer, process_timeout, 0);
-	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
-	schedule();
-	del_timer_sync(&timer.timer);
-
-	/* Remove the timer from the object tracker */
-	destroy_timer_on_stack(&timer.timer);
-
-	timeout = expire - jiffies;
-
- out:
-	return timeout < 0 ? 0 : timeout;
-}
-EXPORT_SYMBOL(schedule_timeout);
-
-/*
- * We can use __set_current_state() here because schedule_timeout() calls
- * schedule() unconditionally.
- */
-signed long __sched schedule_timeout_interruptible(signed long timeout)
-{
-	__set_current_state(TASK_INTERRUPTIBLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_interruptible);
-
-signed long __sched schedule_timeout_killable(signed long timeout)
-{
-	__set_current_state(TASK_KILLABLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_killable);
-
-signed long __sched schedule_timeout_uninterruptible(signed long timeout)
-{
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_uninterruptible);
-
-/*
- * Like schedule_timeout_uninterruptible(), except this task will not contribute
- * to load average.
- */
-signed long __sched schedule_timeout_idle(signed long timeout)
-{
-	__set_current_state(TASK_IDLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_idle);
-
 #ifdef CONFIG_HOTPLUG_CPU
 static void migrate_timer_list(struct timer_base *new_base, struct hlist_head *head)
 {
@@ -2757,59 +2621,3 @@ void __init init_timers(void)
 	posix_cputimers_init_work();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
 }
-
-/**
- * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
- */
-void msleep(unsigned int msecs)
-{
-	unsigned long timeout = msecs_to_jiffies(msecs);
-
-	while (timeout)
-		timeout = schedule_timeout_uninterruptible(timeout);
-}
-
-EXPORT_SYMBOL(msleep);
-
-/**
- * msleep_interruptible - sleep waiting for signals
- * @msecs: Time in milliseconds to sleep for
- */
-unsigned long msleep_interruptible(unsigned int msecs)
-{
-	unsigned long timeout = msecs_to_jiffies(msecs);
-
-	while (timeout && !signal_pending(current))
-		timeout = schedule_timeout_interruptible(timeout);
-	return jiffies_to_msecs(timeout);
-}
-
-EXPORT_SYMBOL(msleep_interruptible);
-
-/**
- * usleep_range_state - Sleep for an approximate time in a given state
- * @min:	Minimum time in usecs to sleep
- * @max:	Maximum time in usecs to sleep
- * @state:	State of the current task that will be while sleeping
- *
- * In non-atomic context where the exact wakeup time is flexible, use
- * usleep_range_state() instead of udelay().  The sleep improves responsiveness
- * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
- * power usage by allowing hrtimers to take advantage of an already-
- * scheduled interrupt instead of scheduling a new one just for this sleep.
- */
-void __sched usleep_range_state(unsigned long min, unsigned long max,
-				unsigned int state)
-{
-	ktime_t exp = ktime_add_us(ktime_get(), min);
-	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
-
-	for (;;) {
-		__set_current_state(state);
-		/* Do not return before the requested sleep time has elapsed */
-		if (!schedule_hrtimeout_range(&exp, delta, HRTIMER_MODE_ABS))
-			break;
-	}
-}
-EXPORT_SYMBOL(usleep_range_state);

-- 
2.39.2


