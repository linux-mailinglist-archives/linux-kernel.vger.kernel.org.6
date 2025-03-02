Return-Path: <linux-kernel+bounces-540739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC0A4B46F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0ED16AEED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80081EDA1C;
	Sun,  2 Mar 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RuutOy3C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieKfpvaA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE21EB1BB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944209; cv=none; b=W6JYlIOlUXCLr0cc+m0C9KELIUV8DIHmaQc7PZzIgKzO2OLaNJ2WK8c259FKfSJVxBAqthX0wh1Xa9nAwzepMLwWGVPooZ/W4ChqEEPz8OMew/ECGmG7kPIgtJZTWHV0jx/zOyG8iF7D11fdoNyCN5DuHyHq+pSUzExklR0oAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944209; c=relaxed/simple;
	bh=Q9H5c4d2GSWvO0XsE5rchm4JPqe7txtl4JIBmyINDsE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GfWutE73UhtmX7+XlmC1/yISoAjFymMjcQOPy+cg9ECQh9DVHV0DXUEnpPxY5FFbR1SL3PbM1QHVHOLTKj2hg9f683HZHtDmiiJ8tf2UuyBkQbXkBiQv4C4ZuZkzG0UVruVBLPvQWAOWY006NIoZnb0kxWAzHSOAs+T9tSOomgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RuutOy3C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieKfpvaA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193626.974094734@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aICCvsBZar4WrHQa6TttvV8MzfJyFFmhB1WgVQ9rg9c=;
	b=RuutOy3CehGQNvEeTHaCnzk6fxKDzO0CTUxGdv2Ia01IcmDdFJeyEqc3uSUteYUoMDsgPF
	xNIo/wlOH0Kvbk9I/xqjdMqz61Qn53wzNa1CMBpccfkfbHMHhtTSfXgaHMpcwxbPIauqVk
	jGNr7g78HP929mOomN8HLtaACrxJBv9tfi/IMKF3z6vOVMTBBOUus1Fsrk7g9/0Rr/fWYy
	Iwz8OU3SRFuAkC9Sc+ELAjWILIpIhX/QPRMUbkfgDB0DvnnTIYKfVUNZNl64oL8y8MOYse
	NwYI/KHhuHakkdKyL52HsLM5Rvf1DXUebXuSoemmkrrO7NSGaktxF083snCpdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aICCvsBZar4WrHQa6TttvV8MzfJyFFmhB1WgVQ9rg9c=;
	b=ieKfpvaAuO2NFlJjYaVyecWhthEqeZE2un4hjVLsEXk9Yt4nRq+r1Oyio43krTIl0LWDj4
	T4zZiy9oggaqUvDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 01/17] posix-timers: Initialise timer before adding it to
 the hash table
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:44 +0100 (CET)

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
@@ -463,7 +487,11 @@ static int do_timer_create(clockid_t whi
 		goto out;
 
 	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
+	/*
+	 * new_timer::it_signal contains the signal pointer with bit 0 set,
+	 * which makes it invalid for syscall operations. Store the
+	 * unmodified signal pointer to make it valid.
+	 */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
 	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);


