Return-Path: <linux-kernel+bounces-353880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0D9933F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D005283898
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED21DD9A2;
	Mon,  7 Oct 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HAN1yodO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CU+HAOE9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579521DD86A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319807; cv=none; b=D7azhi+V7eTb0N3ay8MGvRaaOYfsTOg12X6C7hrS2a16XE256pn0pmc2iY4y8DdhXnZ2DG0703C1F1cqLv+ziUpPiEW3ebR4vwMlH59CFfRe7g+cIyLeo9uFSYyi/xNyxELrJ7IdG4eUAI5BL4C99twB2R4ZaiNzl3nXrLgLl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319807; c=relaxed/simple;
	bh=w5Qo7dTzecPxFEos9vuCxqFrLH3Wjssljj2B81D2lOQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=elC6W8zQqyDCFZJzsmV+2le56u5GFYz2BXGUNEZ1L+m57iEhdzmsOAI274MyDDyvjxlLf1FL33LZFKOQH7TlcXEkiz8EgbU2E7QZFBuvRhecPUBxXHKLQ4Y8hddTJ9hcoZtvJOqLdhiUjIMIqDtvJjOp4zbgyxbq9+eLaQ2CKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HAN1yodO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CU+HAOE9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.582118421@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MV84TMCcv1W+qbGMeugJJXIH6Qz86ucpwvsGCV7iSjc=;
	b=HAN1yodOQzfeRGKA2JOdhV1r2+zsUK8DGiFBCJDXdqbeXlb1UJXvrb0QJrwLAw5NUncnpg
	Tv3eUJr8GDxmpkWGtMVv2URRbcxK72s9V8PRWWMWB4/KrnflsOjFqE3QhJWptdRDuNXhVu
	5fMUTLUmpHur1ZK3zW/ASWacBXSgMA7f6BQT7bNTYMtdUdck1/1R0qwiipz4rTaUOxEafq
	y8PxHscwvlI71uJTPPQAYDxFGrPAhN9RIOSrLj7cWtCXJPKPeCvkncmhwuwsQhoG8Pu0sV
	l3QWZa8yH+zBgaLjKig0uRouyuCcgGdQOu1gycVGH+Vf4M9MWAfuj1gzSgHwfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MV84TMCcv1W+qbGMeugJJXIH6Qz86ucpwvsGCV7iSjc=;
	b=CU+HAOE9/r0XuV5Tu46pgjZwXMsdTALHeqnhbu3ytc9D/OfM1vb6OjetIrNQCuR0pN3ZMg
	IIGjVl0F8ItIIgBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 10/25] debugobjects: Reduce parallel pool fill attempts
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:03 +0200 (CEST)

From: Zhen Lei <thunder.leizhen@huawei.com>

The contention on the global pool_lock can be massive when the global pool
needs to be refilled and many CPUs try to handle this.

Address this by:

  - splitting the refill from free list and allocation.

    Refill from free list has no constraints vs. the context on RT, so
    it can be tried outside of the RT specific preemptible() guard

  - Let only one CPU handle the free list

  - Let only one CPU do allocations unless the pool level is below
    half of the minimum fill level.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240911083521.2257-4-thunder.leizhen@huawei.com-
--
 lib/debugobjects.c |   84 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 25 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -138,14 +138,10 @@ static void free_object_list(struct hlis
 	debug_objects_freed += cnt;
 }
 
-static void fill_pool(void)
+static void fill_pool_from_freelist(void)
 {
-	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
+	static unsigned long state;
 	struct debug_obj *obj;
-	unsigned long flags;
-
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
-		return;
 
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
@@ -154,32 +150,58 @@ static void fill_pool(void)
 	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
 	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	if (READ_ONCE(obj_nr_tofree)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		/*
-		 * Recheck with the lock held as the worker thread might have
-		 * won the race and freed the global free list already.
-		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+	if (!READ_ONCE(obj_nr_tofree))
+		return;
+
+	/*
+	 * Prevent the context from being scheduled or interrupted after
+	 * setting the state flag;
+	 */
+	guard(irqsave)();
+
+	/*
+	 * Avoid lock contention on &pool_lock and avoid making the cache
+	 * line exclusive by testing the bit before attempting to set it.
+	 */
+	if (test_bit(0, &state) || test_and_set_bit(0, &state))
+		return;
+
+	guard(raw_spinlock)(&pool_lock);
+	/*
+	 * Recheck with the lock held as the worker thread might have
+	 * won the race and freed the global free list already.
+	 */
+	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
+		hlist_add_head(&obj->node, &obj_pool);
+		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 	}
+	clear_bit(0, &state);
+}
 
-	if (unlikely(!obj_cache))
+static void fill_pool(void)
+{
+	static atomic_t cpus_allocating;
+
+	/*
+	 * Avoid allocation and lock contention when:
+	 *   - One other CPU is already allocating
+	 *   - the global pool has not reached the critical level yet
+	 */
+	if (READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2) &&
+	    atomic_read(&cpus_allocating))
 		return;
 
+	atomic_inc(&cpus_allocating);
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new = kmem_cache_zalloc(obj_cache, gfp);
+			new = kmem_cache_zalloc(obj_cache, __GFP_HIGH | __GFP_NOWARN);
 			if (!new)
 				break;
 			hlist_add_head(&new->node, &head);
@@ -187,14 +209,14 @@ static void fill_pool(void)
 				last = new;
 		}
 		if (!cnt)
-			return;
+			break;
 
-		raw_spin_lock_irqsave(&pool_lock, flags);
+		guard(raw_spinlock_irqsave)(&pool_lock);
 		hlist_splice_init(&head, &last->node, &obj_pool);
 		debug_objects_allocated += cnt;
 		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
+	atomic_dec(&cpus_allocating);
 }
 
 /*
@@ -597,6 +619,18 @@ static struct debug_obj *lookup_object_o
 
 static void debug_objects_fill_pool(void)
 {
+	if (unlikely(!obj_cache))
+		return;
+
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
+	/* Try reusing objects from obj_to_free_list */
+	fill_pool_from_freelist();
+
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context -- for !RT kernels we rely on the fact that spinlock_t and


