Return-Path: <linux-kernel+bounces-528671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D8BA41A90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA73F170DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554AB24C692;
	Mon, 24 Feb 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q0MKpOAi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3mPCPBJx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEF1F4289
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392127; cv=none; b=hC4eMLf/apyGPxYnkRXewxInlGE3VOHsSWalVOv5V8A8H6mMb9hdS00wE0OvD/5ElTjr86QuOg9JnqtgFJDJs4D/7Es0cc65R6PdE/EvomAqk70ADACg5j0OfuaGSXF5gdSSLO/V7gfGHrA4UhQQ2ha7qive8idELRiAkY+pY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392127; c=relaxed/simple;
	bh=Q9H5c4d2GSWvO0XsE5rchm4JPqe7txtl4JIBmyINDsE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lGSwF/FTAVzvYhQt4Sa+Roat5LRzjfrkyRSPSUx3a4/QkzQZ06Fso+5ZJF+/dce+T8q0HwPHroZK1u0+0IZu2NSUyp3MqG7C7xVFHgWT/famtQEl7T9KRMSNja70rVWgEIxy4p9VP3PvB6m9XftP3GjebhhfEc5WINqGF6jznzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q0MKpOAi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3mPCPBJx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.011835342@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aICCvsBZar4WrHQa6TttvV8MzfJyFFmhB1WgVQ9rg9c=;
	b=q0MKpOAiU9VivPW08RKoYc3H5lGU5jCdcdsQ+DG3RsNE7nDCQhbT+SF5hczjR0Txtd/6iK
	0t55bcfwPTVEJ+APZ+5FssqjsS7o4SfcSzJ+q9rv+tfiuYhgP6olFXKiOJUF39myGxJI61
	swF3f5+jfIxfVeJW4Sl4QR+7qLhqENAvu0B6MeUoJs1lckWumLcEJdlOt2fDQ2r/izD7vV
	IPxsOfDeb2zhmPMFHxERrpBwV0o70iTMh0hK3V/1Eb3e1igze5hhlp5bjl8G7rzmfKw5pb
	DhSOkX3uQNVDs1aX5HMiUa0dJdmxXpeRYBRbeb4rzP3spUZmk0V8umV6FAAZHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aICCvsBZar4WrHQa6TttvV8MzfJyFFmhB1WgVQ9rg9c=;
	b=3mPCPBJxxVDcrfHjFSbKtoF3+sfj+jKC0vrHUFh6Q/rY44mk2c3nnPHp1T0Xjh+F71XX0I
	jQMSQw6IdlwFZwCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 01/11] posix-timers: Initialise timer before adding it to the
 hash table
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:23 +0100 (CET)

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


