Return-Path: <linux-kernel+bounces-552621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44382A57C14
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB4F3A8705
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257AB1EB5C7;
	Sat,  8 Mar 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qe0aicus";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOI72XZL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E21EB5C5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452499; cv=none; b=Ax+zCWiVFL5FC+KAXZyZ6Lq862snbaA3RDSwzPBLDMVnsdLgAjamGOw4XjsZ54R+ntNeB6v8by/CrHaD4nky/ydhNXeWkORlylMrhhyk8LqJ7k7yIMGP8oIgDO7eWF0t++9E515MbkzJIEKl/LVV86nqMYeBtOsbTn5dFACt+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452499; c=relaxed/simple;
	bh=HqSqBEwtX/+GWHY7PrWFXMp7Llf0ugNpRU0fug7ihbU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UOcAMZusA/fFASPTADFSyyq6/w6eRjjxlsxkv/EGWpA4LBnDa3ITfJEJBcN+t7Xtnyfm8aEpqktTojYAJ8qbMQn3NVIh1mPUSnFexE0aq8XJWoV8joyCddJ/EGRWSbfzLS4vlfE9FnW+ryiy7nH61XfC4bf46VhvTf+uZ+pb24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qe0aicus; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOI72XZL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.572035178@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OokW0q+El9MTH0hZbNAk7tISB10kppb/zIF4/BcMm5s=;
	b=qe0aicusjWnDD3X37OG5cfeAG/AbNmEkWdaLcpQqqeB9herIwIyA7O3pcce+WaTs1RCE+g
	i1pgeuXb/oPexhGkHGqGGzSkbTEdCzwSsv0pWlcJuyuIa8VZPRkfyQ9m3hZ/r0e4K1K8HC
	1nCwaJzuI6FERJYDDB9nR5OvStm2Rl8zugHFSDIImkfHPHMsmL7BsDF5Azj1N5VgB67ltZ
	HkjANk+hQ7+XadnBAWcVM+zS4K9jP4ZiW/peI2KlYx8GT2mZdn1Hu8gSeL3IrI1/XWAvRt
	JpWnG7I/l2Qhsv1MjgDx54+/rM7QBPNKdo/s5/+CiX1gWsmoi7PaCagYCH+X2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OokW0q+El9MTH0hZbNAk7tISB10kppb/zIF4/BcMm5s=;
	b=UOI72XZLDb5F3nu+DHHUpbc8ggu6mlRFprpP0zx1lRiZiq3/NdoTUPMy+D5jic/KCmS0EW
	gKO6c2sVH58REGCg==
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
Subject: [patch V3 02/18] posix-timers: Initialise timer before adding it to
 the hash table
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:14 +0100 (CET)

From: Eric Dumazet <edumazet@google.com>

A timer is only valid in the hashtable when both timer::it_signal and
timer::it_id are set to their final values, but timers are added without
those values being set.

The timer ID is allocated when the timer is added to the hash in invalid
state. The ID is taken from a monotonically increasing per process counter
which wraps around after reaching INT_MAX. The hash insertion validates
that there is no timer with the allocated ID in the hash table which
belongs to the same process. That opens a mostly theoretical race condition:

If other threads of the same process manage to create/delete timers in
rapid succession before the newly created timer is fully initialized and
wrap around to the timer ID which was handed out, then a duplicate timer ID
will be inserted into the hash table.

Prevent this by:

  1) Setting timer::it_id before inserting the timer into the hashtable.
 
  2) Storing the signal pointer in timer::it_signal with bit 0 set before
     inserting it into the hashtable.

     Bit 0 acts as a invalid bit, which means that the regular lookup for
     sys_timer_*() will fail the comparison with the signal pointer.

     But the lookup on insertion masks out bit 0 and can therefore detect a
     timer which is not yet valid, but allocated in the hash table.  Bit 0
     in the pointer is cleared once the initialization of the timer
     completed.

[ tglx: Fold ID and signal iniitializaion into one patch and massage change
  	log and comments. ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250219125522.2535263-3-edumazet@google.com
---
 kernel/time/posix-timers.c |   56 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -72,13 +72,13 @@ static int hash(struct signal_struct *si
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
 }
 
-static struct k_itimer *__posix_timers_find(struct hlist_head *head,
-					    struct signal_struct *sig,
-					    timer_t id)
+static struct k_itimer *posix_timer_by_id(timer_t id)
 {
+	struct signal_struct *sig = current->signal;
+	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+	hlist_for_each_entry_rcu(timer, head, t_hash) {
 		/* timer->it_signal can be set concurrently */
 		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
 			return timer;
@@ -86,12 +86,26 @@ static struct k_itimer *__posix_timers_f
 	return NULL;
 }
 
-static struct k_itimer *posix_timer_by_id(timer_t id)
+static inline struct signal_struct *posix_sig_owner(const struct k_itimer *timer)
 {
-	struct signal_struct *sig = current->signal;
-	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+	unsigned long val = (unsigned long)timer->it_signal;
+
+	/*
+	 * Mask out bit 0, which acts as invalid marker to prevent
+	 * posix_timer_by_id() detecting it as valid.
+	 */
+	return (struct signal_struct *)(val & ~1UL);
+}
+
+static bool posix_timer_hashed(struct hlist_head *head, struct signal_struct *sig, timer_t id)
+{
+	struct k_itimer *timer;
 
-	return __posix_timers_find(head, sig, id);
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+		if ((posix_sig_owner(timer) == sig) && (timer->it_id == id))
+			return true;
+	}
+	return false;
 }
 
 static int posix_timer_add(struct k_itimer *timer)
@@ -112,7 +126,19 @@ static int posix_timer_add(struct k_itim
 		sig->next_posix_timer_id = (id + 1) & INT_MAX;
 
 		head = &posix_timers_hashtable[hash(sig, id)];
-		if (!__posix_timers_find(head, sig, id)) {
+		if (!posix_timer_hashed(head, sig, id)) {
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
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
 			return id;
@@ -406,8 +432,7 @@ static int do_timer_create(clockid_t whi
 
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
-	 * because new_timer::it_signal is still NULL. The timer id is also
-	 * not yet visible to user space.
+	 * after insertion, but has a unique ID allocated.
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
@@ -415,7 +440,6 @@ static int do_timer_create(clockid_t whi
 		return new_timer_id;
 	}
 
-	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
 	new_timer->kclock = kc;
 	new_timer->it_overrun = -1LL;
@@ -453,7 +477,7 @@ static int do_timer_create(clockid_t whi
 	}
 	/*
 	 * After succesful copy out, the timer ID is visible to user space
-	 * now but not yet valid because new_timer::signal is still NULL.
+	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create
 	 * callback.
@@ -470,7 +494,11 @@ static int do_timer_create(clockid_t whi
 	 */
 	scoped_guard (spinlock_irq, &new_timer->it_lock) {
 		guard(spinlock)(&current->sighand->siglock);
-		/* This makes the timer valid in the hash table */
+		/*
+		 * new_timer::it_signal contains the signal pointer with
+		 * bit 0 set, which makes it invalid for syscall operations.
+		 * Store the unmodified signal pointer to make it valid.
+		 */
 		WRITE_ONCE(new_timer->it_signal, current->signal);
 		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	}


