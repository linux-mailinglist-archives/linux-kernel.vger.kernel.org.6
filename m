Return-Path: <linux-kernel+bounces-540749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CFBA4B47C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C29A3B28C6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64D1EFFA7;
	Sun,  2 Mar 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buSHVS8H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m5ImAnZK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4461EFF96
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944225; cv=none; b=EaT2m4mSKKMRTDAN3ku1a7YYMq9aX6TDsw34JWKs521zUmHUtOXmeaEaBMng5K5ShBYgcUSytJQixnmL55VvEl6Hu1rhStw4AsJE2mrZ6DDdvleUQlOQhTVXLmwTT1nObo5FP+qif0Hshn1BA3/LYPPUziTTVxNXvp/XDbSdeBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944225; c=relaxed/simple;
	bh=YBQrTSxncls0OBxmM71iSE45YyZznb3x7bbDhZqGGAk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PK3zpKwFd2Z2pj6jVdL7jSuiowJhieF2rRHja6EqdCJGDufCBWBG5hTlxhbykmoVn3n3I4OA+L74fLMepuJkixgfZUTLzRNL+CBHUAn57S3ZX8b5CJSGoHtDWjeSlNKJe5VpMY0RIdcJdcLesd4Oh22oyeoguVCjCu9/viwlWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buSHVS8H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m5ImAnZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.606672916@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ko5OrhoHybTL1JZX2pFy2fb4X5fmnkg1bgBzYOv3lFY=;
	b=buSHVS8HwH8YXmF322HvWsWTs6vHWMmn/hJZONDE/U7OUwy8Mf1lU19yqAoSOWgb6vGara
	9lNOTwUQ5cJhTX4qPvG+Z7CE3PdXIUpxA/IlmYGA9bvsVdJtZEXuCEhiL6XHoRFAG/vkX7
	0KbsvuKPlVQ+HIJu3DbZ2q9QJ3TfLvVaRjenewTpebMIDEzNoVsZCR0r2fZKzGkILLdBLs
	n4q/6KDqaAWBdQ66+AxhuNk/Dj2jiFljSXwgd09YVLRlAJJXnkiJzrub5+wdYM2b37+MKb
	+910Cyyf7g7KEeRL01gH96B1iNwlKQu8d5rQimjX5k+7Hq36zzGYttlfghEp4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ko5OrhoHybTL1JZX2pFy2fb4X5fmnkg1bgBzYOv3lFY=;
	b=m5ImAnZKdv18UgVvTRUsQl90G4X9fjDJ0W7NFxL+//1EtsTqeEtykK5PxhS/46eQJHxm1J
	RFSfV88ZsHQ8nMCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 11/17] posix-timers: Improve hash table performance
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:37:01 +0100 (CET)

Eric and Ben reported a significant performance bottleneck on the global
hash, which is used to store posix timers for lookup.

Eric tried to do a lockless validation of a new timer ID before trying to
insert the timer, but that does not solve the problem.

For the non-contended case this is a pointless exercise and for the
contended case this extra lookup just creates enough interleaving that all
tasks can make progress.

There are actually two real solutions to the problem:

  1) Provide a per process (signal struct) xarray storage

  2) Implement a smarter hash like the one in the futex code

#1 works perfectly fine for most cases, but the fact that CRIU enforced a
   linear increasing timer ID to restore timers makes this problematic.

   It's easy enough to create a sparse timer ID space, which amounts very
   fast to a large junk of memory consumed for the xarray. 2048 timers with
   a ID offset of 512 consume more than one megabyte of memory for the
   xarray storage.

#2 The main advantage of the futex hash is that it uses per hash bucket
   locks instead of a global hash lock. Aside of that it is scaled
   according to the number of CPUs at boot time.

Experiments with artifical benchmarks have shown that a scaled hash with
per bucket locks comes pretty close to the xarray performance and in some
scenarios it performes better.

Test 1:

     A single process creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create         23 ms       23 ms      9 ms     8 ms
getoverrun     14 ms       14 ms      5 ms     4 ms

Test 2:

     A single process creates 50000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create         98 ms      219 ms     20 ms    18 ms
getoverrun     62 ms       62 ms     10 ms     9 ms

Test 3:

     A single process creates 100000 timers and afterwards invokes
     timer_getoverrun(2) on each of them:

            mainline        Eric   newhash   xarray
create        313 ms      750 ms     48 ms    33 ms
getoverrun    261 ms      260 ms     20 ms    14 ms

Erics changes create quite some overhead in the create() path due to the
double list walk, as the main issue according to perf is the list walk
itself. With 100k timers each hash bucket contains ~200 timers, which in
the worst case need to be all inspected. The same problem applies for
getoverrun() where the lookup has to walk through the hash buckets to find
the timer it is looking for.

The scaled hash obviously reduces hash collisions and lock contention
significantly. This becomes more prominent with concurrency.

Test 4:

     A process creates 63 threads and all threads wait on a barrier before
     each instance creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them. The threads are pinned on
     seperate CPUs to achive maximum concurrency. The numbers are the
     average times per thread:

            mainline        Eric   newhash   xarray
create     180239 ms    38599 ms    579 ms   813 ms
getoverrun   2645 ms     2642 ms     32 ms     7 ms

Test 5:

     A process forks 63 times and all forks wait on a barrier before each
     instance creates 20000 timers and afterwards invokes
     timer_getoverrun(2) on each of them. The processes are pinned on
     seperate CPUs to achive maximum concurrency. The numbers are the
     average times per process:

            mainline        eric   newhash   xarray
create     157253 ms    40008 ms     83 ms    60 ms
getoverrun   2611 ms     2614 ms     40 ms     4 ms

So clearly the reduction of lock contention with Eric's changes makes a
significant difference for the create() loop, but it does not mitigate the
problem of long list walks, which is clearly visible on the getoverrun()
side because that is purely dominated by the lookup itself. Once the timer
is found, the syscall just reads from the timer structure with no other
locks or code paths involved and returns.

The reason for the difference between the thread and the fork case for the
new hash and the xarray is that both suffer from contention on
sighand::siglock and the xarray suffers additionally from contention on the
xarray lock on insertion.

The only case where the reworked hash slighly outperforms the xarray is a
tight loop which creates and deletes timers.

Test 4:

     A process creates 63 threads and all threads wait on a barrier before
     each instance runs a loop which creates and deletes a timer 100000
     times in a row. The threads are pinned on seperate CPUs to achive
     maximum concurrency. The numbers are the average times per thread:

            mainline        Eric   newhash   xarray
loop	    5917  ms	 5897 ms   5473 ms  7846 ms

Test 5:

     A process forks 63 times and all forks wait on a barrier before each
     each instance runs a loop which creates and deletes a timer 100000
     times in a row. The processes are pinned on seperate CPUs to achive
     maximum concurrency. The numbers are the average times per process:

            mainline        Eric   newhash   xarray
loop	     5137 ms	 7828 ms    891 ms   872 ms

In both test there is not much contention on the hash, but the ucount
accounting for the signal and in the thread case the sighand::siglock
contention (plus the xarray locking) contribute dominantly to the overhead.

As the memory consumption of the xarray in the sparse ID case is
significant, the scaled hash with per bucket locks seems to be the better
overall option. While the xarray has faster lookup times for a large number
of timers, the actual syscall usage, which requires the lookup is not an
extreme hotpath. Most applications utilize signal delivery and all syscalls
except timer_getoverrun(2) are all but cheap.

So implement a scaled hash with per bucket locks, which offers the best
tradeoff between performance and memory consumption.

Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: Benjamin Segall <bsegall@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Replace hash() by hashbucket(), which returns the bucket pointer.
---
 kernel/time/posix-timers.c |   99 ++++++++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 31 deletions(-)
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -12,10 +12,10 @@
 #include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
-#include <linux/hashtable.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/memblock.h>
 #include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
@@ -40,8 +40,18 @@ static struct kmem_cache *posix_timers_c
  * This allows checkpoint/restore to reconstruct the exact timer IDs for
  * a process.
  */
-static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
-static DEFINE_SPINLOCK(hash_lock);
+struct timer_hash_bucket {
+	spinlock_t		lock;
+	struct hlist_head	head;
+};
+
+static struct {
+	struct timer_hash_bucket	*buckets;
+	unsigned long			bits;
+} __timer_data __ro_after_init __aligned(2*sizeof(long));
+
+#define timer_buckets	(__timer_data.buckets)
+#define timer_hashbits	(__timer_data.bits)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -74,18 +84,18 @@ static inline void unlock_timer(struct k
 DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(id), timer_t id);
 DEFINE_CLASS_IS_COND_GUARD(lock_timer);
 
-static int hash(struct signal_struct *sig, unsigned int nr)
+static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
 {
-	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
+	return &timer_buckets[hash_32(hash32_ptr(sig) ^ nr, timer_hashbits)];
 }
 
 static struct k_itimer *posix_timer_by_id(timer_t id)
 {
 	struct signal_struct *sig = current->signal;
-	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+	struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash) {
+	hlist_for_each_entry_rcu(timer, &bucket->head, t_hash) {
 		/* timer->it_signal can be set concurrently */
 		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
 			return timer;
@@ -104,11 +114,13 @@ static inline struct signal_struct *posi
 	return (struct signal_struct *)(val & ~1UL);
 }
 
-static bool posix_timer_hashed(struct hlist_head *head, struct signal_struct *sig, timer_t id)
+static bool posix_timer_hashed(struct timer_hash_bucket *bucket, struct signal_struct *sig,
+			       timer_t id)
 {
+	struct hlist_head *head = &bucket->head;
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&bucket->lock)) {
 		if ((posix_sig_owner(timer) == sig) && (timer->it_id == id))
 			return true;
 	}
@@ -119,34 +131,34 @@ static int posix_timer_add(struct k_itim
 {
 	struct signal_struct *sig = current->signal;
 
-	/*
-	 * FIXME: Replace this by a per signal struct xarray once there is
-	 * a plan to handle the resulting CRIU regression gracefully.
-	 */
 	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
 		/* Get the next timer ID and clamp it to positive space */
 		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
-		struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+		struct timer_hash_bucket *bucket = hash_bucket(sig, id);
 
-		spin_lock(&hash_lock);
-		if (!posix_timer_hashed(head, sig, id)) {
+		scoped_guard (spinlock, &bucket->lock) {
 			/*
-			 * Set the timer ID and the signal pointer to make
-			 * it identifiable in the hash table. The signal
-			 * pointer has bit 0 set to indicate that it is not
-			 * yet fully initialized. posix_timer_hashed()
-			 * masks this bit out, but the syscall lookup fails
-			 * to match due to it being set. This guarantees
-			 * that there can't be duplicate timer IDs handed
-			 * out.
+			 * Validate under the lock as this could have raced
+			 * against another thread ending up with the same
+			 * ID, which is highly unlikely, but possible.
 			 */
-			timer->it_id = (timer_t)id;
-			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
-			hlist_add_head_rcu(&timer->t_hash, head);
-			spin_unlock(&hash_lock);
-			return id;
+			if (!posix_timer_hashed(bucket, sig, id)) {
+				/*
+				 * Set the timer ID and the signal pointer to make
+				 * it identifiable in the hash table. The signal
+				 * pointer has bit 0 set to indicate that it is not
+				 * yet fully initialized. posix_timer_hashed()
+				 * masks this bit out, but the syscall lookup fails
+				 * to match due to it being set. This guarantees
+				 * that there can't be duplicate timer IDs handed
+				 * out.
+				 */
+				timer->it_id = (timer_t)id;
+				timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
+				hlist_add_head_rcu(&timer->t_hash, &bucket->head);
+				return id;
+			}
 		}
-		spin_unlock(&hash_lock);
 		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
@@ -404,7 +416,9 @@ void posixtimer_free_timer(struct k_itim
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
 {
-	scoped_guard (spinlock, &hash_lock)
+	struct timer_hash_bucket *bucket = hash_bucket(posix_sig_owner(tmr), tmr->it_id);
+
+	scoped_guard (spinlock, &bucket->lock)
 		hlist_del_rcu(&tmr->t_hash);
 	posixtimer_putref(tmr);
 }
@@ -1477,3 +1491,26 @@ static const struct k_clock *clockid_to_
 
 	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
+
+static int __init posixtimer_init(void)
+{
+	unsigned long i, size;
+	unsigned int shift;
+
+	if (IS_ENABLED(CONFIG_BASE_SMALL))
+		size = 512;
+	else
+		size = roundup_pow_of_two(512 * num_possible_cpus());
+
+	timer_buckets = alloc_large_system_hash("posixtimers", sizeof(*timer_buckets),
+						size, 0, 0, &shift, NULL, size, size);
+	size = 1UL << shift;
+	timer_hashbits = ilog2(size);
+
+	for (i = 0; i < size; i++) {
+		spin_lock_init(&timer_buckets[i].lock);
+		INIT_HLIST_HEAD(&timer_buckets[i].head);
+	}
+	return 0;
+}
+core_initcall(posixtimer_init);


