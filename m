Return-Path: <linux-kernel+bounces-557989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CBA5E013
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126697A881C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB81253B53;
	Wed, 12 Mar 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z+jLjjVl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPpLYSOZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9F2571C0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792612; cv=none; b=gtRDe2kgzYOThvFUduoPbfrfzXSM9fKQOCxoTZL7rs82o4FeFEV1EcrCgoCcI/UK9Vxb4anLUYyfwRip8Ns38GW1GGFMbfpTWur3l7n2m+mv4dIlocJCLUEI01D/6C1MYJMv3ESk7SCI4uVnZAMASYw0EpDIljmlC+/Jy8mXW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792612; c=relaxed/simple;
	bh=6aV5iO7haHMb03GvwAYBnZtSAmTB4bYnvF5YVRf6vlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knQKJTsOf9uJjIvPcmnIB6g2XXzWp4MmBMpdLYHzxX5h6x5bGc3KgqMN/LfXOUty0KsPtxS8rpgOJF3wuEy4yqcTavuTNmHVrhmt4tgihVOrYWMNGCgYXVAy+M2KiZoFUzd9rr0vIX28TDlro/iDbwpiygdL1L8B78jyl5WUy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z+jLjjVl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPpLYSOZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XasgQ1bTHVhj0irlCaoC3urxdFVb2K0PsjlA/vCBkJM=;
	b=z+jLjjVl9Jgh3tkR4Jps7UJWIWTF1pvZakyP/6JPAhtpWRJHigugblJwgy73yPlJwJYCIv
	QwE59UcZtPpQP8huG8J8hLQIH4IaM9nIspk5+UPlDlcMdsAOLuagxVVPpGaXPZmaeqcaHi
	WUNfy5aOrwU3iR1Q4OtMrN11b6cm+17+zlIu+szkTrR+CuNuCyupHZdKLkWWq4jTJuw93/
	b1PwukJc8VVobLetTSeFRZMELVzXydNqYoEBsnwk6aLG5vNKXpVtZ1+eUkILLBKOfZ8oJU
	D8FFg61NY7i6PJh7zwHFu3LkR+iVVNQ3vNph22usb2QT4QanyKPLMyh9R5J2BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XasgQ1bTHVhj0irlCaoC3urxdFVb2K0PsjlA/vCBkJM=;
	b=dPpLYSOZoXxUwAtHfP+0AW+CT1f95IGcZj4gw5/LZ6n2NlB1/LbPoAwFGdE9/mtpC1yvhz
	f4HSj8sE+iHgtsCg==
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
Subject: [PATCH v10 18/21] futex: Rework SET_SLOTS
Date: Wed, 12 Mar 2025 16:16:31 +0100
Message-ID: <20250312151634.2183278-19-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

Let SET_SLOTS have precedence over default scaling; once user sets a
size, stick with it.

Notably, doing SET_SLOTS 0 will cause fph->hash_mask to be 0, which
will cause __futex_hash() to return global hash buckets. Once in this
state, it is impossible to recover, so disable SET_SLOTS.

Also, let prctl() users wait-retry the rehash, such that return of
prctl() means new size is in effect.

[bigeasy: make private hash depend on MMU]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 init/Kconfig        |   2 +-
 kernel/futex/core.c | 183 +++++++++++++++++++++++++++++---------------
 2 files changed, 123 insertions(+), 62 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index bb209c12a2bda..b0a448608446d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1685,7 +1685,7 @@ config FUTEX_PI
=20
 config FUTEX_PRIVATE_HASH
 	bool
-	depends on FUTEX && !BASE_SMALL
+	depends on FUTEX && !BASE_SMALL && MMU
 	default y
=20
 config EPOLL
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1c00890cc4fb5..bc7451287b2ce 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -61,6 +61,8 @@ struct futex_private_hash {
 	rcuref_t	users;
 	unsigned int	hash_mask;
 	struct rcu_head	rcu;
+	void		*mm;
+	bool		custom;
 	struct futex_hash_bucket queues[];
 };
=20
@@ -192,12 +194,6 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 	fph =3D rcu_dereference_protected(mm->futex_phash,
 					lockdep_is_held(&mm->futex_hash_lock));
 	if (fph) {
-		if (fph->hash_mask >=3D new->hash_mask) {
-			/* It was increased again while we were waiting */
-			kvfree(new);
-			return true;
-		}
-
 		if (!rcuref_is_dead(&fph->users)) {
 			mm->futex_phash_new =3D new;
 			return false;
@@ -207,6 +203,7 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 	}
 	rcu_assign_pointer(mm->futex_phash, new);
 	kvfree_rcu(fph, rcu);
+	wake_up_var(mm);
 	return true;
 }
=20
@@ -262,7 +259,8 @@ void futex_private_hash_put(struct futex_private_hash *=
fph)
 	 * Ignore the result; the DEAD state is picked up
 	 * when rcuref_get() starts failing via rcuref_is_dead().
 	 */
-	bool __maybe_unused ignore =3D rcuref_put(&fph->users);
+	if (rcuref_put(&fph->users))
+		wake_up_var(fph->mm);
 }
=20
 struct futex_hash_bucket *futex_hash(union futex_key *key)
@@ -1392,72 +1390,128 @@ void futex_hash_free(struct mm_struct *mm)
 	}
 }
=20
-static int futex_hash_allocate(unsigned int hash_slots)
+static bool futex_pivot_pending(struct mm_struct *mm)
+{
+	struct futex_private_hash *fph;
+
+	guard(rcu)();
+
+	if (!mm->futex_phash_new)
+		return false;
+
+	fph =3D rcu_dereference(mm->futex_phash);
+	return !rcuref_read(&fph->users);
+}
+
+static bool futex_hash_less(struct futex_private_hash *a,
+			    struct futex_private_hash *b)
+{
+	/* user provided always wins */
+	if (!a->custom && b->custom)
+		return true;
+	if (a->custom && !b->custom)
+		return false;
+
+	/* zero-sized hash wins */
+	if (!b->hash_mask)
+		return true;
+	if (!a->hash_mask)
+		return false;
+
+	/* keep the biggest */
+	if (a->hash_mask < b->hash_mask)
+		return true;
+	if (a->hash_mask > b->hash_mask)
+		return false;
+
+	return false; /* equal */
+}
+
+static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 {
-	struct futex_private_hash *fph, *hb_tofree =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	size_t alloc_size;
+	struct futex_private_hash *fph;
 	int i;
=20
-	if (hash_slots =3D=3D 0)
-		hash_slots =3D 16;
-	hash_slots =3D clamp(hash_slots, 2, futex_hashmask + 1);
-	if (!is_power_of_2(hash_slots))
-		hash_slots =3D rounddown_pow_of_two(hash_slots);
+	if (hash_slots && (hash_slots =3D=3D 1 || !is_power_of_2(hash_slots)))
+		return -EINVAL;
=20
-	if (unlikely(check_mul_overflow(hash_slots, sizeof(struct futex_hash_buck=
et),
-					&alloc_size)))
-		return -ENOMEM;
+	/*
+	 * Once we've disabled the global hash there is no way back.
+	 */
+	scoped_guard (rcu) {
+		fph =3D rcu_dereference(mm->futex_phash);
+		if (fph && !fph->hash_mask) {
+			if (custom)
+				return -EBUSY;
+			return 0;
+		}
+	}
=20
-	if (unlikely(check_add_overflow(alloc_size, sizeof(struct futex_private_h=
ash),
-					&alloc_size)))
-		return -ENOMEM;
-
-	fph =3D kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
+	fph =3D kvzalloc(struct_size(fph, queues, hash_slots), GFP_KERNEL_ACCOUNT=
);
 	if (!fph)
 		return -ENOMEM;
=20
 	rcuref_init(&fph->users, 1);
-	fph->hash_mask =3D hash_slots - 1;
+	fph->hash_mask =3D hash_slots ? hash_slots - 1 : 0;
+	fph->custom =3D custom;
+	fph->mm =3D mm;
=20
 	for (i =3D 0; i < hash_slots; i++)
 		futex_hash_bucket_init(&fph->queues[i], fph);
=20
-	scoped_guard(mutex, &mm->futex_hash_lock) {
-		if (mm->futex_phash && !mm->futex_phash_new) {
-			/*
-			 * If we have an existing hash, but do not yet have
-			 * allocated a replacement hash, drop the initial
-			 * reference on the existing hash.
-			 *
-			 * Ignore the return value; removal is serialized by
-			 * mm->futex_hash_lock which we currently hold and last
-			 * put is verified via rcuref_is_dead().
-			 */
-			futex_private_hash_put(mm->futex_phash);
-		}
-
-		if (mm->futex_phash_new) {
-			/*
-			 * If we already have a replacement hash pending;
-			 * keep the larger hash.
-			 */
-			if (mm->futex_phash_new->hash_mask <=3D fph->hash_mask) {
-				hb_tofree =3D mm->futex_phash_new;
-			} else {
-				hb_tofree =3D fph;
-				fph =3D mm->futex_phash_new;
-			}
-			mm->futex_phash_new =3D NULL;
-		}
-
+	if (custom) {
 		/*
-		 * Will set mm->futex_phash_new on failure;
-		 * futex_get_private_hash() will try again.
+		 * Only let prctl() wait / retry; don't unduly delay clone().
 		 */
-		__futex_pivot_hash(mm, fph);
+again:
+		wait_var_event(mm, futex_pivot_pending(mm));
+	}
+
+	scoped_guard(mutex, &mm->futex_hash_lock) {
+		struct futex_private_hash *free __free(kvfree) =3D NULL;
+		struct futex_private_hash *cur, *new;
+
+		cur =3D rcu_dereference_protected(mm->futex_phash,
+						lockdep_is_held(&mm->futex_hash_lock));
+		new =3D mm->futex_phash_new;
+		mm->futex_phash_new =3D NULL;
+
+		if (fph) {
+			if (cur && !new) {
+				/*
+				 * If we have an existing hash, but do not yet have
+				 * allocated a replacement hash, drop the initial
+				 * reference on the existing hash.
+				 */
+				futex_private_hash_put(cur);
+			}
+
+			if (new) {
+				/*
+				 * Two updates raced; throw out the lesser one.
+				 */
+				if (futex_hash_less(new, fph)) {
+					free =3D new;
+					new =3D fph;
+				} else {
+					free =3D fph;
+				}
+			} else {
+				new =3D fph;
+			}
+			fph =3D NULL;
+		}
+
+		if (new) {
+			/*
+			 * Will set mm->futex_phash_new on failure;
+			 * futex_get_private_hash() will try again.
+			 */
+			if (!__futex_pivot_hash(mm, new) && custom)
+				goto again;
+		}
 	}
-	kvfree(hb_tofree);
 	return 0;
 }
=20
@@ -1470,10 +1524,17 @@ int futex_hash_allocate_default(void)
 		return 0;
=20
 	scoped_guard(rcu) {
-		threads =3D min_t(unsigned int, get_nr_threads(current), num_online_cpus=
());
+		threads =3D min_t(unsigned int,
+				get_nr_threads(current),
+				num_online_cpus());
+
 		fph =3D rcu_dereference(current->mm->futex_phash);
-		if (fph)
+		if (fph) {
+			if (fph->custom)
+				return 0;
+
 			current_buckets =3D fph->hash_mask + 1;
+		}
 	}
=20
 	/*
@@ -1486,7 +1547,7 @@ int futex_hash_allocate_default(void)
 	if (current_buckets >=3D buckets)
 		return 0;
=20
-	return futex_hash_allocate(buckets);
+	return futex_hash_allocate(buckets, false);
 }
=20
 static int futex_hash_get_slots(void)
@@ -1502,7 +1563,7 @@ static int futex_hash_get_slots(void)
=20
 #else
=20
-static int futex_hash_allocate(unsigned int hash_slots)
+static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 {
 	return -EINVAL;
 }
@@ -1519,7 +1580,7 @@ int futex_hash_prctl(unsigned long arg2, unsigned lon=
g arg3)
=20
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		ret =3D futex_hash_allocate(arg3);
+		ret =3D futex_hash_allocate(arg3, true);
 		break;
=20
 	case PR_FUTEX_HASH_GET_SLOTS:
--=20
2.47.2


