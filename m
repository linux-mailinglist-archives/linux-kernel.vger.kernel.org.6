Return-Path: <linux-kernel+bounces-396100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E39BC7D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD42BB22BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64B204094;
	Tue,  5 Nov 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tKiV83us";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbtxLkr3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B812036E9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794498; cv=none; b=c0K+loZjRoF+J71pHmuolC605KDMP3Hbiig2Oct2jBAZRAzTE9sMpzSVNbGOTHbjW/pdtl0gE5DhqYZ/ycwb41yI0bnIt+9c41E57spy6xwAl9Okr2J81UExBvzv/Go0XkjXEFg0Ecnm8ECOmWzfx251lhXrfmWCGuAeZMNwXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794498; c=relaxed/simple;
	bh=rm5NFIc+xGWyInO+gSoLVDrNsJNfGuvBoE5mrSkx4a0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=S3VUnMLtG9VG0N/pPBnjDSJyMmdtmaBW6VbGshQrNBeYsVRpayLlQ6qU95dedX90TQ7UhtlkSbejIe7jxtqMG9oDfQEvIsuLGAlWr5e2Ttv/ksfkZx8shO1zHGMLXtbrvMQYbuo65QFxm+0ro2r/CdyTsrbLyXSXY3pIxOID5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tKiV83us; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbtxLkr3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064214.120756416@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8/ZVJ5XXu0FmBw+GggoVGJl6tHUBTPCh3rAvy2iBCao=;
	b=tKiV83usdIb1dUG95CaLcHrS1kgVDBRaG7SjAGE3Z/eqiDl4TTAykcWV1PYDu78H36maXr
	lp98vtpIkAaXd5JX5WoIcxQICLFTgkMe3wYtyR0XeP3QWq9p6RZxDu0mAFcz6yGRdyA9Ss
	jNew5sEDiHGykuzcCIjdBALHD6fRJqTbKKJCtB/NK2WSi5EOiv/o4XMJCkvTnTQ6/tM1Xe
	oBvCHx+MfcAkSn6dTa+jxlAgT16jYblncjNhVmudRjytdQwCTbQ725WLIPvKTsanhUrife
	ZDoJb6TCYnypNV3A/F2sGwcUH1as7v1vY0yDm0P5FOGStAYUuahBw35MFPQa0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8/ZVJ5XXu0FmBw+GggoVGJl6tHUBTPCh3rAvy2iBCao=;
	b=UbtxLkr3Bfn0kTHt6iM//hvQe4aEYpptsAmPb0VG/NZnlIt2l3BCKgpF+SI3a2fiiYyYnJ
	J0PcW+VWILSu0dCA==
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
Subject: [patch V7 18/21] signal: Queue ignored posixtimers on ignore list
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:54 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is already queued

This only happens when the signal is for a valid timer, which delivered the
signal in periodic mode. One-shot timer signals are correctly dropped.

Due to the lock order constraints (sighand::siglock nests inside
timer::lock) the signal code cannot access any of the timer fields which
are relevant to make this decision, e.g. timer::it_status.

This is addressed by establishing a protection scheme which requires to
lock both locks on the timer side for modifying decision fields in the
timer struct and therefore makes it possible for the signal delivery to
evaluate with only sighand:siglock being held:

  1) Move the NULLification of timer->it_signal into the sighand::siglock
     protected section of timer_delete() and check timer::it_signal in the
     code path which determines whether the signal is dropped or queued on
     the ignore list.

     This ensures that a deleted timer cannot be moved onto the ignore
     list, which would prevent it from being freed on exit() as it is not
     longer in the process' posix timer list.

     If the timer got moved to the ignored list before deletion then it is
     removed from the ignored list under sighand lock in timer_delete().

  2) Provide a new timer::it_sig_periodic flag, which gets set in the
     signal queue path with both timer and sighand locks held if the timer
     is actually in periodic mode at expiry time.

     The ignore list code checks this flag under sighand::siglock and drops
     the signal when it is not set.

     If it is set, then the signal is moved to the ignored list independent
     of the actual state of the timer.

     When the signal is un-ignored later then the signal is moved back to
     the signal queue. On signal delivery the posix timer side decides
     about dropping the signal if the timer was re-armed, dis-armed or
     deleted based on the signal sequence counter check.

     If the thread/process exits then not yet delivered signals are
     discarded which means the reference of the timer containing the
     sigqueue is dropped and frees the timer.

     This is way cheaper than requiring all code paths to lock
     sighand::siglock of the target thread/process on any modification of
     timer::it_status or going all the way and removing pending signals
     from the signal queues on every rearm, disarm or delete operation.

So the protection scheme here is that on the timer side both timer::lock
and sighand::siglock have to be held for modifying

   timer::it_signal
   timer::it_sig_periodic

which means that on the signal side holding sighand::siglock is enough to
evaluate these fields.
                                                                                                                                                                                                                                                                                                                             
In posixtimer_deliver_signal() holding timer::lock is sufficient to do the
sequence validation against timer::it_signal_seq because a concurrent
expiry is waiting on timer::lock to be released.

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V7: Fix exit/delete race conditions and use a protected field for the
    periodic detection - Frederic
   
---
 include/linux/posix-timers.h |    2 +
 kernel/signal.c              |   80 ++++++++++++++++++++++++++++++++++++++++---
 kernel/time/posix-timers.c   |    7 +++
 3 files changed, 83 insertions(+), 6 deletions(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -160,6 +160,7 @@ static inline void posix_cputimers_init_
  * @it_clock:		The posix timer clock id
  * @it_id:		The posix timer id for identifying the timer
  * @it_status:		The status of the timer
+ * @it_sig_periodic:	The periodic status at signal delivery
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
  * @it_signal_seq:	Sequence count to control signal delivery
@@ -184,6 +185,7 @@ struct k_itimer {
 	clockid_t		it_clock;
 	timer_t			it_id;
 	int			it_status;
+	bool			it_sig_periodic;
 	s64			it_overrun;
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -59,6 +59,8 @@
 #include <asm/cacheflush.h>
 #include <asm/syscall.h>	/* for syscall_get_* */
 
+#include "time/posix-timers.h"
+
 /*
  * SLAB caches for signal bits.
  */
@@ -731,6 +733,16 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
 
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
+
+static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)
+{
+	if (likely(!(q->flags & SIGQUEUE_PREALLOC) || q->info.si_code != SI_TIMER))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(tsk, q);
+}
+
 /* Remove signals in mask from the pending set and queue. */
 static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
 {
@@ -747,7 +759,7 @@ static void flush_sigqueue_mask(struct t
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(p, q);
 		}
 	}
 }
@@ -1964,7 +1976,7 @@ int posixtimer_send_sigqueue(struct k_it
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
 	guard(rcu)();
 
@@ -1981,13 +1993,55 @@ int posixtimer_send_sigqueue(struct k_it
 	 */
 	tmr->it_sigqueue_seq = tmr->it_signal_seq;
 
-	ret = 1; /* the signal is ignored */
+	/*
+	 * Set the signal delivery status under sighand lock, so that the
+	 * ignored signal handling can distinguish between a periodic and a
+	 * non-periodic timer.
+	 */
+	tmr->it_sig_periodic = tmr->it_status == POSIX_TIMER_REQUEUE_PENDING;
+
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
+
+		/* Paranoia check. Try to survive. */
+		if (WARN_ON_ONCE(!list_empty(&q->list)))
+			goto out;
+
+		/* Periodic timers with SIG_IGN are queued on the ignored list */
+		if (tmr->it_sig_periodic) {
+			/*
+			 * Already queued means the timer was rearmed after
+			 * the previous expiry got it on the ignore list.
+			 * Nothing to do for that case.
+			 */
+			if (hlist_unhashed(&tmr->ignored_list)) {
+				/*
+				 * Take a signal reference and queue it on
+				 * the ignored list.
+				 */
+				posixtimer_sigqueue_getref(q);
+				posixtimer_sig_ignore(t, q);
+			}
+		} else if (!hlist_unhashed(&tmr->ignored_list)) {
+			/*
+			 * Covers the case where a timer was periodic and
+			 * then the signal was ignored. Later it was rearmed
+			 * as oneshot timer. The previous signal is invalid
+			 * now, and this oneshot signal has to be dropped.
+			 * Remove it from the ignored list and drop the
+			 * reference count as the signal is not longer
+			 * queued.
+			 */
+			hlist_del_init(&tmr->ignored_list);
+			posixtimer_putref(tmr);
+		}
 		goto out;
 	}
 
-	ret = 0;
+	/* This should never happen and leaks a reference count */
+	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
+		hlist_del_init(&tmr->ignored_list);
+
 	if (unlikely(!list_empty(&q->list))) {
 		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
@@ -2000,7 +2054,22 @@ int posixtimer_send_sigqueue(struct k_it
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
-	return ret;
+	return 0;
+}
+
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	/*
+	 * If the timer is marked deleted already or the signal originates
+	 * from a non-periodic timer, then just drop the reference
+	 * count. Otherwise queue it on the ignored list.
+	 */
+	if (tmr->it_signal && tmr->it_sig_periodic)
+		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
+	else
+		posixtimer_putref(tmr);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2048,6 +2117,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1072,12 +1072,17 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
 	posix_timer_cleanup_ignored(timer);
-	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
 	 * will reevaluate with timer::it_lock held and observe the NULL.
+	 *
+	 * It must be written with siglock held so that the signal code
+	 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
+	 * which prevents it from moving a pending signal of a deleted
+	 * timer to the ignore list.
 	 */
 	WRITE_ONCE(timer->it_signal, NULL);
+	spin_unlock(&current->sighand->siglock);
 
 	unlock_timer(timer, flags);
 	posix_timer_unhash_and_free(timer);


