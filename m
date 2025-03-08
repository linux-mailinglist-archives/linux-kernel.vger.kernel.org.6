Return-Path: <linux-kernel+bounces-552637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD4A57C25
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9643B1442
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C4215041;
	Sat,  8 Mar 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwJhTZe+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpBMk6uK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3236214806
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452532; cv=none; b=tZ9fawCmOBf1q/CTtvT8raCnGV6Jt4xYP0GAMpGGJBhrkabYNHaMhPJ8Qr/SgePLRIFFS+1hij4ldkv2PBC9KODxFLuHf7mDkdowy7ks8GSrF6Qg/kq14iC4tVEkS2rLLy00eC6hGU0DXKXyatUelQ9AcQz2WUj/ar/MwJArsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452532; c=relaxed/simple;
	bh=SNmNf1pfS8U1kfuzeVGc5ionyg+36cghQdd4igDVF/Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A/Da22cjgcKkBOAAN7sVEKscK6E2gvXVm2lCIgvX1WbYdBbyIQEc/hsXrcPVhq0gwOgxVgZiEyksw9H/GdvcUJiZ1d50ebg1cSwE+pKsDnTSq5wzl8M0VfeX3IlvhbcrbIq2LHK6+6yvnk2QnBIdxdufrlDbMZTpdb4qqZTMO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwJhTZe+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpBMk6uK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.526740902@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7CfzyR+B+jADoe7CKStowkSOzNnvW4fAjEzZHTxzyYU=;
	b=nwJhTZe+A1NGxh/iOn/pKGJiq88czEJvVethYVpJcf1h2JIHHYTkIkcOc/Q8N8JzM3YKx4
	Six3dKjthBk9LnppO4lodLQgPR86cf0TGywGmPA83/QwUrmewIaJOEP0tCkQsM7i7fyNOS
	ygSnis2quH8rJpsND+j298Xgl880yBncenx2UsstgtUXn3WZ0Y1ELha+HnGkKOOeTfNg47
	7W5F5c72RPBG2eWvU3GftTVtSqMVRbtbEfB1mnTgPwXHkA137AFRtNYzxMbHPvfl4SiPkh
	bUX7o4o2yctalTJgJS8NtVOibApZNp7HSaZ1sMmO/Ti+iNRqQ34q9+rj3HFCtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7CfzyR+B+jADoe7CKStowkSOzNnvW4fAjEzZHTxzyYU=;
	b=EpBMk6uK6mMKxmSxRZnIEQlRR1CBq1HOqBmZhgfIQ9yKKEK4FlbG4usbFp8Pn0oqkyj7uq
	AbFH0pPCI/rQOZDQ==
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
Subject: [patch V3 17/18] posix-timers: Provide a mechanism to allocate a
 given timer ID
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:47 +0100 (CET)

Checkpoint/Restore in Userspace (CRIU) requires to reconstruct posix timers
with the same timer ID on restore. It uses sys_timer_create() and relies on
the monotonic increasing timer ID provided by this syscall. It creates and
deletes timers until the desired ID is reached. This is can loop for a long
time, when the checkpointed process had a very sparse timer ID range.

It has been debated to implement a new syscall to allow the creation of
timers with a given timer ID, but that's tideous due to the 32/64bit compat
issues of sigevent_t and of dubious value.

The restore mechanism of CRIU creates the timers in a state where all
threads of the restored process are held on a barrier and cannot issue
syscalls. That means the restorer task has exclusive control.

This allows to address this issue with a prctl() so that the restorer
thread can do:

   if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON))
      goto linear_mode;
   create_timers_with_explicit_ids();
   prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF);
   
This is backwards compatible because the prctl() fails on older kernels and
CRIU can fall back to the linear timer ID mechanism. CRIU versions which do
not know about the prctl() just work as before.

Implement the prctl() and modify timer_create() so that it copies the
requested timer ID from userspace by utilizing the existing timer_t
pointer, which is used to copy out the allocated timer ID on success.

If the prctl() is disabled, which it is by default, timer_create() works as
before and does not try to read from the userspace pointer.

There is no problem when a broken or rogue user space application enables
the prctl(). If the user space pointer does not contain a valid ID, then
timer_create() fails. If the data is not initialized, but constains a
random valid ID, timer_create() will create that random timer ID or fail if
the ID is already given out. 
 
As CRIU must use the raw syscall to avoid manipulating the internal state
of the restored process, this has no library dependencies and can be
adopted by CRIU right away.

Recreating two timers with IDs 1000000 and 2000000 takes 1.5 seconds with
the create/delete method. With the prctl() it takes 3 microseconds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V2: Move the ID counter ahead to avoid collisions after switching back to
    normal mode.
---
 include/linux/posix-timers.h |    2 
 include/linux/sched/signal.h |    1 
 include/uapi/linux/prctl.h   |   10 ++++
 kernel/sys.c                 |    5 ++
 kernel/time/posix-timers.c   |   97 +++++++++++++++++++++++++++++++------------
 5 files changed, 89 insertions(+), 26 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -114,6 +114,7 @@ bool posixtimer_init_sigqueue(struct sig
 void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
+long posixtimer_create_prctl(unsigned long ctrl);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -140,6 +141,7 @@ static inline void posixtimer_rearm_itim
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
 					     struct sigqueue *timer_sigq) { return false; }
 static inline void posixtimer_free_timer(struct k_itimer *timer) { }
+static inline long posixtimer_create_prctl(unsigned long ctrl) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,6 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
+	unsigned int		timer_create_restore_ids:1;
 	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -353,4 +353,14 @@ struct prctl_mm_map {
  */
 #define PR_LOCK_SHADOW_STACK_STATUS      76
 
+/*
+ * Controls the mode of timer_create() for CRIU restore operations.
+ * Enabling this allows CRIU to restore timers with explicit IDs.
+ *
+ * Don't use for normal operations as the result might be undefined.
+ */
+#define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		1
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2811,6 +2811,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 			return -EINVAL;
 		error = arch_lock_shadow_stack_status(me, arg2);
 		break;
+	case PR_TIMER_CREATE_RESTORE_IDS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = posixtimer_create_prctl(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
+#include <linux/prctl.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
@@ -57,6 +58,8 @@ static const struct k_clock * const posi
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
 static const struct k_clock clock_realtime, clock_monotonic;
 
+#define TIMER_ANY_ID		INT_MIN
+
 /* SIGEV_THREAD_ID cannot share a bit with the other SIGEV values. */
 #if SIGEV_THREAD_ID != (SIGEV_THREAD_ID & \
 			~(SIGEV_SIGNAL | SIGEV_NONE | SIGEV_THREAD))
@@ -128,38 +131,60 @@ static bool posix_timer_hashed(struct ti
 	return false;
 }
 
-static int posix_timer_add(struct k_itimer *timer)
+static bool posix_timer_add_at(struct k_itimer *timer, struct signal_struct *sig, unsigned int id)
+{
+	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
+
+	scoped_guard (spinlock, &bucket->lock) {
+		/*
+		 * Validate under the lock as this could have raced against
+		 * another thread ending up with the same ID, which is
+		 * highly unlikely, but possible.
+		 */
+		if (!posix_timer_hashed(bucket, sig, id)) {
+			/*
+			 * Set the timer ID and the signal pointer to make
+			 * it identifiable in the hash table. The signal
+			 * pointer has bit 0 set to indicate that it is not
+			 * yet fully initialized. posix_timer_hashed()
+			 * masks this bit out, but the syscall lookup fails
+			 * to match due to it being set. This guarantees
+			 * that there can't be duplicate timer IDs handed
+			 * out.
+			 */
+			timer->it_id = (timer_t)id;
+			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
+			hlist_add_head_rcu(&timer->t_hash, &bucket->head);
+			return true;
+		}
+	}
+	return false;
+}
+
+static int posix_timer_add(struct k_itimer *timer, int req_id)
 {
 	struct signal_struct *sig = current->signal;
 
+	if (unlikely(req_id != TIMER_ANY_ID)) {
+		if (!posix_timer_add_at(timer, sig, req_id))
+			return -EBUSY;
+
+		/*
+		 * Move the ID counter past the requested ID, so that after
+		 * switching back to normal mode the IDs are outside of the
+		 * exact allocated region. That avoids ID collisions on the
+		 * next regular timer_create() invocations.
+		 */
+		atomic_set(&sig->next_posix_timer_id, req_id + 1);
+		return req_id;
+	}
+
 	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
 		/* Get the next timer ID and clamp it to positive space */
 		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
-		struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 
-		scoped_guard (spinlock, &bucket->lock) {
-			/*
-			 * Validate under the lock as this could have raced
-			 * against another thread ending up with the same
-			 * ID, which is highly unlikely, but possible.
-			 */
-			if (!posix_timer_hashed(bucket, sig, id)) {
-				/*
-				 * Set the timer ID and the signal pointer to make
-				 * it identifiable in the hash table. The signal
-				 * pointer has bit 0 set to indicate that it is not
-				 * yet fully initialized. posix_timer_hashed()
-				 * masks this bit out, but the syscall lookup fails
-				 * to match due to it being set. This guarantees
-				 * that there can't be duplicate timer IDs handed
-				 * out.
-				 */
-				timer->it_id = (timer_t)id;
-				timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
-				hlist_add_head_rcu(&timer->t_hash, &bucket->head);
-				return id;
-			}
-		}
+		if (posix_timer_add_at(timer, sig, id))
+			return id;
 		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
@@ -364,6 +389,16 @@ static enum hrtimer_restart posix_timer_
 	return HRTIMER_NORESTART;
 }
 
+long posixtimer_create_prctl(unsigned long ctrl)
+{
+	if (ctrl > PR_TIMER_CREATE_RESTORE_IDS_ON)
+		return -EINVAL;
+
+	guard(spinlock_irq)(&current->sighand->siglock);
+	current->signal->timer_create_restore_ids = ctrl == PR_TIMER_CREATE_RESTORE_IDS_ON;
+	return 0;
+}
+
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct pid *pid = task_tgid(current);
@@ -435,6 +470,7 @@ static int do_timer_create(clockid_t whi
 			   timer_t __user *created_timer_id)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
+	timer_t req_id = TIMER_ANY_ID;
 	struct k_itimer *new_timer;
 	int error, new_timer_id;
 
@@ -449,11 +485,20 @@ static int do_timer_create(clockid_t whi
 
 	spin_lock_init(&new_timer->it_lock);
 
+	/* Special case for CRIU to restore timers with a given timer ID. */
+	if (unlikely(current->signal->timer_create_restore_ids)) {
+		if (copy_from_user(&req_id, created_timer_id, sizeof(req_id)))
+			return -EFAULT;
+		/* Valid IDs are 0..INT_MAX */
+		if ((unsigned int)req_id > INT_MAX)
+			return -EINVAL;
+	}
+
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
 	 * after insertion, but has a unique ID allocated.
 	 */
-	new_timer_id = posix_timer_add(new_timer);
+	new_timer_id = posix_timer_add(new_timer, req_id);
 	if (new_timer_id < 0) {
 		posixtimer_free_timer(new_timer);
 		return new_timer_id;


