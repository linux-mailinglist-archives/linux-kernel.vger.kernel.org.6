Return-Path: <linux-kernel+bounces-533410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B8A459AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423CA3AC89F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4E224231;
	Wed, 26 Feb 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOpliuar";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BblTrB/D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC855268FD6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561062; cv=none; b=lBDCnImHiplAkdxND3P+9dHzRBDVJVSlET8fRGqpC4dGzkysxIatkseiZbfnfa3dJGXEEL/ojeAwRGtV27ReOqPQjeyzqziTzLaWFt22A1XKVTZ8a5bG8anpwC49alQkqiYi9laCCkWi+V5Cb1qzolxeQe/02wqdN8Xj09q3Qhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561062; c=relaxed/simple;
	bh=U+QnHxX4vzgqtC6n2hwO4522lfiF1hD9mmLj4efxQyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tl5UtxhdbDYWekhLbZnbnFGs8o1gs2d9NH4jUs0AMYqGpPXhiqPVkErLGl9L6E2mffzSO0jqEHfiJLNqhAlJXJffjzv6KMPVl+PYdJByPv2+4jVBnmV5HolF16L9Z5RVQ4Y6lw72OtuHiYxCEKrI8Gsrwj2EUtVXb9ebZgooLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOpliuar; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BblTrB/D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:10:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740561058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bps11zQMT+OijRLBYrX7wUkpmXm/LStD3G5HKzYcvl4=;
	b=gOpliuarchXSjxcdOvJWA9cJd3/7+UGyKV9/m2TtVVH0B12KdWSR98rLCZlhwbdP7NbHbb
	KY4b2lPNRGiGuZMtBI20ILnXQMjEqLzFGoR9UdZKVhU+kBK/qkEZDtrQjTpJv23pM3sKAB
	HBt3NiH3sM1wxbnIQ/cKTbCyXbfqWeqb+zaDbIf71TbvplfzybJKbhPjE5f8if5uAbyUsO
	LV8nKThjHEyP0k6ayD+lW1t8jtAewRkYvFGUzXxVqQcIrrTFBviWf/2Urn/hUpcksEEXA+
	Wg2TxUDA9NNJ5rFOk59BlMKf+7qs0FGTJ6P6EYkAKivorpRqcQ2fl6161c7sWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740561058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bps11zQMT+OijRLBYrX7wUkpmXm/LStD3G5HKzYcvl4=;
	b=BblTrB/DTYhPOjHeaQsKfWlRJxp7pZZIaAi/Z7nGifVBmMt5rKnFXeGofiCB6nCfi2EB4a
	LycVA3lU1Ray8FCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] futex: Use a hashmask instead of hashsize.
Message-ID: <20250226091057.bX8vObR4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The global hash uses futex_hashsize to save the amount of the hash
buckets that have been allocated during system boot. On each
futex_hash() invocation this number is substracted by one to get the
mask. This can be optimized by saving directly the mask avoiding the
substraction on each futex_hash() invocation.

Rename futex_hashsize to futex_hashmask and save the mask of the
allocated hash map.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Split from the "local hash" series.

 kernel/futex/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3db8567f5a44e..cca15859a50be 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -50,10 +50,10 @@
  */
 static struct {
 	struct futex_hash_bucket *queues;
-	unsigned long            hashsize;
+	unsigned long            hashmask;
 } __futex_data __read_mostly __aligned(2*sizeof(long));
 #define futex_queues   (__futex_data.queues)
-#define futex_hashsize (__futex_data.hashsize)
+#define futex_hashmask (__futex_data.hashmask)
 
 
 /*
@@ -119,7 +119,7 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
 
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	return &futex_queues[hash & futex_hashmask];
 }
 
 
@@ -1127,27 +1127,28 @@ void futex_exit_release(struct task_struct *tsk)
 
 static int __init futex_init(void)
 {
+	unsigned long hashsize, i;
 	unsigned int futex_shift;
-	unsigned long i;
 
 #ifdef CONFIG_BASE_SMALL
-	futex_hashsize = 16;
+	hashsize = 16;
 #else
-	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
+	hashsize = roundup_pow_of_two(256 * num_possible_cpus());
 #endif
 
 	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       futex_hashsize, 0, 0,
+					       hashsize, 0, 0,
 					       &futex_shift, NULL,
-					       futex_hashsize, futex_hashsize);
-	futex_hashsize = 1UL << futex_shift;
+					       hashsize, hashsize);
+	hashsize = 1UL << futex_shift;
 
-	for (i = 0; i < futex_hashsize; i++) {
+	for (i = 0; i < hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
 		spin_lock_init(&futex_queues[i].lock);
 	}
 
+	futex_hashmask = hashsize - 1;
 	return 0;
 }
 core_initcall(futex_init);
-- 
2.47.2


