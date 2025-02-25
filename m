Return-Path: <linux-kernel+bounces-532014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F95A4479A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40909170CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2420764C;
	Tue, 25 Feb 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/OgES9X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jEqTkPGN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171B1A23A9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503374; cv=none; b=tiAdDzTapQ7TyUIA/kJ/jyqtCo5zJ7NP7VC29obugTqrHp0HA3JOtW92jdFTb0HXuUgXV89sUmg8KZcXEMhu1CHWhunfZc5PvyP9JFDjzddiXTVTFQ9+IDR9VPlaEMSdMF04g7wVe4MHxK0bKfBzedhswJ8E8PmmwY6b8JZHCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503374; c=relaxed/simple;
	bh=8FFO6bFPGwyY0+Xl6fvMWNJIoLX7x/wmhWfnnYAgvQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lleUR8JtQPAzy8g5/yUUf8eZ2cuowNQLDBu6JfLyLeW5pEDoXzcvfeCczitqsbam+5qdoQUyj07tkb/dYuSnBV+ZwdF7A/aAeBMibZEiT8h8ugDCvYMQtJ0n75MzoDQO9LwNjwy6gwUnOcGDJbudtzF29mH0tkz7t0P3sjj1a2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/OgES9X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jEqTkPGN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YX0O8wuELXX5Vdc+92JPzZgR8pAmCG7s5ghLTgE+/8A=;
	b=0/OgES9XvkRg6FQDFk0MG+GCGCqmZFXTZZdvEOKFE4u+tzOj6mfcfWObDLnD3+a6YbEHDt
	LU0KXDV8Ii/Wjg+77yxS7bhRYwfxE9YRAGIffFWDyUAb1PDdT9IIIXGOoWbIDGJDFlzhmk
	RhQUBjaPlBXIsJ5ZO/JQXPHgq7KZ3kfg74kWc3PSg+DexgxyhjN9TzF8it9mA0DYG/tBsG
	9whV4M29iwqc1u9U9OMRPUPOKg15InOVjdr97iT/y/S4fJzIFLBlMz0Z5vFsmMij53UY6R
	hRYvjsHjBUt5DTEH8lhNNltbrNhy+GPOja+UlIoDCfJKWARLtJi1+Qd6V6gR8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YX0O8wuELXX5Vdc+92JPzZgR8pAmCG7s5ghLTgE+/8A=;
	b=jEqTkPGNeZxldgoz/YkjeCmWgaTCJy4WBMSUNyYVbjh42D7whPa6Obd9Pc/Ig3LU1KaPkZ
	iIB5SD9vDjS0/aCQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v9 10/11] futex: Resize local futex hash table based on number of threads.
Date: Tue, 25 Feb 2025 18:09:13 +0100
Message-ID: <20250225170914.289358-11-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Automatically size the local hash based on the number of threads but
don't exceed the number of online CPUs. The logic tries to allocate
between 16 and futex_hashsize (the default for the system wide hash
bucket) and uses 4 * number-of-threads.

On CONFIG_BASE_SMALL configs, the additional members for private hash
resize have been removed in order to save memory on mm_struct and avoid
any additional memory consumption. If we really do this, then I would
re-arrange the code structure in the previous patches to limit the
ifdefs.
The alternatives would be to limit the buckets allocated in
futex_hash_allocate_default() to 2. Avoiding
futex_hash_allocate_default() but allowing PR_FUTEX_HASH_SET_SLOTS to
work would require to hold mm_struct::futex_hash_lock in
exit_pi_state_list() and futex_wait_multiple_setup() that private does
not appear during these operations (which is currently ensured by
holding a reference).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h    | 21 +++++++--------
 include/linux/mm_types.h |  2 +-
 kernel/fork.c            |  4 +--
 kernel/futex/core.c      | 57 +++++++++++++++++++++++++++++++++++++---
 kernel/futex/futex.h     |  8 ++++++
 5 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index bfb38764bac7a..77821a78059f2 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -78,6 +78,13 @@ void futex_exec_release(struct task_struct *tsk);
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3);
+
+#ifdef CONFIG_BASE_SMALL
+static inline int futex_hash_allocate_default(void) { return 0; }
+static inline void futex_hash_free(struct mm_struct *mm) { }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+#else /* !CONFIG_BASE_SMALL */
+
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
=20
@@ -87,14 +94,9 @@ static inline void futex_mm_init(struct mm_struct *mm)
 	mutex_init(&mm->futex_hash_lock);
 }
=20
-static inline bool futex_hash_requires_allocation(void)
-{
-	if (current->mm->futex_phash)
-		return false;
-	return true;
-}
+#endif /* CONFIG_BASE_SMALL */
=20
-#else
+#else /* !CONFIG_FUTEX */
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
@@ -116,11 +118,6 @@ static inline int futex_hash_allocate_default(void)
 static inline void futex_hash_free(struct mm_struct *mm) { }
 static inline void futex_mm_init(struct mm_struct *mm) { }
=20
-static inline bool futex_hash_requires_allocation(void)
-{
-	return false;
-}
-
 #endif
=20
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 19abbc870e0a9..72e68de850745 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -937,7 +937,7 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
-#ifdef CONFIG_FUTEX
+#if defined(CONFIG_FUTEX) && !defined(CONFIG_BASE_SMALL)
 		struct mutex			futex_hash_lock;
 		struct futex_private_hash	__rcu *futex_phash;
 		struct futex_private_hash	*futex_phash_new;
diff --git a/kernel/fork.c b/kernel/fork.c
index 824cc55d32ece..5e15e5b24f289 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2142,9 +2142,7 @@ static bool need_futex_hash_allocate_default(u64 clon=
e_flags)
 {
 	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) !=3D (CLONE_THREAD | CLONE_=
VM))
 		return false;
-	if (!thread_group_empty(current))
-		return false;
-	return futex_hash_requires_allocation();
+	return true;
 }
=20
 /*
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 4d9ee3bcaa6d0..6d375b9407c85 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -138,6 +138,7 @@ static struct futex_hash_bucket *futex_hash_private(uni=
on futex_key *key,
 	return &fhb[hash & hash_mask];
 }
=20
+#ifndef CONFIG_BASE_SMALL
 static void futex_rehash_current_users(struct futex_private_hash *old,
 				       struct futex_private_hash *new)
 {
@@ -256,6 +257,14 @@ static struct futex_private_hash *futex_get_private_hb=
(union futex_key *key)
 	return futex_get_private_hash();
 }
=20
+#else
+
+static struct futex_private_hash *futex_get_private_hb(union futex_key *ke=
y)
+{
+	return NULL;
+}
+#endif
+
 /**
  * futex_hash - Return the hash bucket in the global or local hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -279,6 +288,7 @@ struct futex_hash_bucket *__futex_hash(union futex_key =
*key)
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
=20
+#ifndef CONFIG_BASE_SMALL
 bool futex_put_private_hash(struct futex_private_hash *hb_p)
 {
 	bool released;
@@ -315,6 +325,7 @@ void futex_hash_put(struct futex_hash_bucket *hb)
 		return;
 	futex_put_private_hash(hb_p);
 }
+#endif
=20
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -1366,12 +1377,15 @@ void futex_exit_release(struct task_struct *tsk)
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 				   struct futex_private_hash *hb_p)
 {
+#ifndef CONFIG_BASE_SMALL
 	fhb->hb_p =3D hb_p;
+#endif
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
 	spin_lock_init(&fhb->lock);
 }
=20
+#ifndef CONFIG_BASE_SMALL
 void futex_hash_free(struct mm_struct *mm)
 {
 	struct futex_private_hash *hb_p;
@@ -1406,8 +1420,8 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
 		hash_slots =3D 16;
 	if (hash_slots < 2)
 		hash_slots =3D 2;
-	if (hash_slots > 131072)
-		hash_slots =3D 131072;
+	if (hash_slots > futex_hashsize)
+		hash_slots =3D futex_hashsize;
 	if (!is_power_of_2(hash_slots))
 		hash_slots =3D rounddown_pow_of_two(hash_slots);
=20
@@ -1449,7 +1463,31 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
=20
 int futex_hash_allocate_default(void)
 {
-	return futex_hash_allocate(0);
+	unsigned int threads, buckets, current_buckets =3D 0;
+	struct futex_private_hash *hb_p;
+
+	if (!current->mm)
+		return 0;
+
+	scoped_guard(rcu) {
+		threads =3D min_t(unsigned int, get_nr_threads(current), num_online_cpus=
());
+		hb_p =3D rcu_dereference(current->mm->futex_phash);
+		if (hb_p)
+			current_buckets =3D hb_p->hash_mask + 1;
+	}
+
+	/*
+	 * The default allocation will remain within
+	 *   16 <=3D threads * 4 <=3D global hash size
+	 */
+	buckets =3D roundup_pow_of_two(4 * threads);
+	buckets =3D max(buckets, 16);
+	buckets =3D min(buckets, futex_hashsize);
+
+	if (current_buckets >=3D buckets)
+		return 0;
+
+	return futex_hash_allocate(buckets);
 }
=20
 static int futex_hash_get_slots(void)
@@ -1463,6 +1501,19 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
+#else
+
+static int futex_hash_allocate(unsigned int hash_slots)
+{
+	return -EINVAL;
+}
+
+static int futex_hash_get_slots(void)
+{
+	return 0;
+}
+#endif
+
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
 {
 	int ret;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 973efcca2e01b..d1149739f3110 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -205,10 +205,18 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleep=
er *timeout,
 		  int flags, u64 range_ns);
=20
 extern struct futex_hash_bucket *__futex_hash(union futex_key *key);
+#ifdef CONFIG_BASE_SMALL
+static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
+static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
+static inline struct futex_private_hash *futex_get_private_hash(void) { re=
turn NULL; }
+static inline bool futex_put_private_hash(struct futex_private_hash *hb_p)=
 { return false; }
+
+#else /* !CONFIG_BASE_SMALL */
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 extern struct futex_private_hash *futex_get_private_hash(void);
 extern bool futex_put_private_hash(struct futex_private_hash *hb_p);
+#endif
=20
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
--=20
2.47.2


