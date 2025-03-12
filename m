Return-Path: <linux-kernel+bounces-557988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23265A5E01A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA4C3B31C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E5253B4B;
	Wed, 12 Mar 2025 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZvS3G7D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HK/EBYER"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817825742C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792611; cv=none; b=NZonxzSlBtLEvkiUqjXPrTb4ZEbf1mQInnnaNyE9zF54fkLNKXDZx+hlOp5Ej/GT+INITqsbp0BsCAzsX1v176FI4qywik/U0bFQk4q/9geDwts8ekzb5R8GgHTyHcOKKiM3k5EvVBYyHKo11vcVVOhXczSGTZn/+eyn2W/oE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792611; c=relaxed/simple;
	bh=L41lfVycNegLBDt/mqxZXDMwv/TFyY5hHQG/8Ke5Z/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTlzyFmMq/m/5uj8Kol5IRjFQB92T/3SlPBimYd1E/kWxaD3djNuOVSi0jvfiIOO0Gsjx8YrjHm6MiAYTSSZ2lYLUUW/pTTgkMm8d0JTE1vgv+b/A1i6fiEQIPMwvZKC1+oneOpJ2v9e6x5r0TqS4iyCDwNyIpBMKwu64xC4+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZvS3G7D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HK/EBYER; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNeUiHh2MMnAD2CP7mWP/8SxhtTZSX7q+aRCE1+zZrI=;
	b=qZvS3G7DkbOVTnvcCbS5KnEp7f+n4USELIhiG0H2pC3+zalTrD5zzxJLpq7l9q2WwJomPu
	mZrFBm5WAdWYynKVp8wmH+negahC1MMZcrvi5Skn3hjaYY19pcbwlJs3Aqlx9C/VHrs2VR
	TuFCD07I+EAZY/mzrt+fNRVN74bMXhxYgSP0swG36K831ib9oW62KK3zFZsmILVQDYPE5x
	XfUo8FZukn4fepZuUK6k8RG/2tigx4azftJ4s3iB8U7WyY3KkRGGCRxkYifHYOeotsg76C
	9bFSGnjncRMbK6oM2545Mbj4UovgZLjBW90n2RGnLl0Gduz+FI4BAY54tr42gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNeUiHh2MMnAD2CP7mWP/8SxhtTZSX7q+aRCE1+zZrI=;
	b=HK/EBYERdr0H8x3yJ6y3wJgTOuiyfbCXl/7fZLkTx9Lhu++fwMBgorap42qntvIsSruWyz
	SFUIaePHDwvfIzAg==
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
Subject: [PATCH v10 21/21] futex: Implement FUTEX2_MPOL
Date: Wed, 12 Mar 2025 16:16:34 +0100
Message-ID: <20250312151634.2183278-22-bigeasy@linutronix.de>
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

Extend the futex2 interface to be aware of mempolicy.

When FUTEX2_MPOL is specified and there is a MPOL_PREFERRED or
home_node specified covering the futex address, use that hash-map.

Notably, in this case the futex will go to the global node hashtable,
even if it is a PRIVATE futex.

When FUTEX2_NUMA|FUTEX2_MPOL is specified and the user specified node
value is FUTEX_NO_NODE, the MPOL lookup (as described above) will be
tried first before reverting to setting node to the local node.

[bigeasy: add CONFIG_FUTEX_MPOL ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/mmap_lock.h  |   4 ++
 include/uapi/linux/futex.h |   2 +-
 init/Kconfig               |   5 ++
 kernel/futex/core.c        | 112 +++++++++++++++++++++++++++++++------
 kernel/futex/futex.h       |   4 ++
 5 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 45a21faa3ff62..89fb032545e0d 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -7,6 +7,7 @@
 #include <linux/rwsem.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
+#include <linux/cleanup.h>
=20
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
@@ -217,6 +218,9 @@ static inline void mmap_read_unlock(struct mm_struct *m=
m)
 	up_read(&mm->mmap_lock);
 }
=20
+DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
+	     mmap_read_lock(_T), mmap_read_unlock(_T))
+
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, false);
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 0435025beaae8..247c425e175ef 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -63,7 +63,7 @@
 #define FUTEX2_SIZE_U32		0x02
 #define FUTEX2_SIZE_U64		0x03
 #define FUTEX2_NUMA		0x04
-			/*	0x08 */
+#define FUTEX2_MPOL		0x08
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
diff --git a/init/Kconfig b/init/Kconfig
index b0a448608446d..a4502a9077e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1688,6 +1688,11 @@ config FUTEX_PRIVATE_HASH
 	depends on FUTEX && !BASE_SMALL && MMU
 	default y
=20
+config FUTEX_MPOL
+	bool
+	depends on FUTEX && NUMA
+	default y
+
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b9da7dc6a900a..65523f3cfe32e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -43,6 +43,8 @@
 #include <linux/slab.h>
 #include <linux/prctl.h>
 #include <linux/rcuref.h>
+#include <linux/mempolicy.h>
+#include <linux/mmap_lock.h>
=20
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -318,6 +320,73 @@ struct futex_hash_bucket *futex_hash(union futex_key *=
key)
=20
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
+#ifdef CONFIG_FUTEX_MPOL
+static int __futex_key_to_node(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma =3D vma_lookup(mm, addr);
+	struct mempolicy *mpol;
+	int node =3D FUTEX_NO_NODE;
+
+	if (!vma)
+		return FUTEX_NO_NODE;
+
+	mpol =3D vma_policy(vma);
+	if (!mpol)
+		return FUTEX_NO_NODE;
+
+	switch (mpol->mode) {
+	case MPOL_PREFERRED:
+		node =3D first_node(mpol->nodes);
+		break;
+	case MPOL_PREFERRED_MANY:
+	case MPOL_BIND:
+		if (mpol->home_node !=3D NUMA_NO_NODE)
+			node =3D mpol->home_node;
+		break;
+	default:
+		break;
+	}
+
+	return node;
+}
+
+static int futex_key_to_node_opt(struct mm_struct *mm, unsigned long addr)
+{
+	int seq, node;
+
+	guard(rcu)();
+
+	if (!mmap_lock_speculate_try_begin(mm, &seq))
+		return -EBUSY;
+
+	node =3D __futex_key_to_node(mm, addr);
+
+	if (mmap_lock_speculate_retry(mm, seq))
+		return -EAGAIN;
+
+	return node;
+}
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	int node;
+
+	node =3D futex_key_to_node_opt(mm, addr);
+	if (node >=3D FUTEX_NO_NODE)
+		return node;
+
+	guard(mmap_read_lock)(mm);
+	return __futex_key_to_node(mm, addr);
+}
+#else /* !CONFIG_FUTEX_MPOL */
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	return FUTEX_NO_NODE;
+}
+
+#endif /* CONFIG_FUTEX_MPOL */
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -329,18 +398,20 @@ struct futex_hash_bucket *futex_hash(union futex_key =
*key)
 static struct futex_hash_bucket *
 __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 {
-	struct futex_hash_bucket *hb;
+	int node =3D key->both.node;
 	u32 hash;
-	int node;
=20
-	hb =3D __futex_hash_private(key, fph);
-	if (hb)
-		return hb;
+	if (node =3D=3D FUTEX_NO_NODE) {
+		struct futex_hash_bucket *hb;
+
+		hb =3D __futex_hash_private(key, fph);
+		if (hb)
+			return hb;
+	}
=20
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / sizeof(u32),
 		      key->both.offset);
-	node =3D key->both.node;
=20
 	if (node =3D=3D FUTEX_NO_NODE) {
 		/*
@@ -488,27 +559,32 @@ int get_futex_key(u32 __user *uaddr, unsigned int fla=
gs, union futex_key *key,
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
=20
+	node =3D FUTEX_NO_NODE;
+
 	if (flags & FLAGS_NUMA) {
 		u32 __user *naddr =3D uaddr + size / 2;
=20
 		if (futex_get_value(&node, naddr))
 			return -EFAULT;
=20
-		if (node =3D=3D FUTEX_NO_NODE) {
-			node =3D numa_node_id();
-			if (futex_put_value(node, naddr))
-				return -EFAULT;
-
-		} else if (node >=3D MAX_NUMNODES || !node_possible(node)) {
+		if (node >=3D MAX_NUMNODES || !node_possible(node))
 			return -EINVAL;
-		}
-
-		key->both.node =3D node;
-
-	} else {
-		key->both.node =3D FUTEX_NO_NODE;
 	}
=20
+	if (node =3D=3D FUTEX_NO_NODE && (flags & FLAGS_MPOL))
+		node =3D futex_mpol(mm, address);
+
+	if (flags & FLAGS_NUMA) {
+		u32 __user *naddr =3D uaddr + size / 2;
+
+		if (node =3D=3D FUTEX_NO_NODE)
+			node =3D numa_node_id();
+		if (futex_put_value(node, naddr))
+			return -EFAULT;
+	}
+
+	key->both.node =3D node;
+
 	/*
 	 * PROCESS_PRIVATE futexes are fast.
 	 * As the mm cannot disappear under us and the 'key' only needs
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 11c870a92b5d0..52e9c0c4b6c87 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -39,6 +39,7 @@
 #define FLAGS_HAS_TIMEOUT	0x0040
 #define FLAGS_NUMA		0x0080
 #define FLAGS_STRICT		0x0100
+#define FLAGS_MPOL		0x0200
=20
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
@@ -67,6 +68,9 @@ static inline unsigned int futex2_to_flags(unsigned int f=
lags2)
 	if (flags2 & FUTEX2_NUMA)
 		flags |=3D FLAGS_NUMA;
=20
+	if (flags2 & FUTEX2_MPOL)
+		flags |=3D FLAGS_MPOL;
+
 	return flags;
 }
=20
--=20
2.47.2


