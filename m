Return-Path: <linux-kernel+bounces-353885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7A9933FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B661C22F25
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B91DDC03;
	Mon,  7 Oct 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YoVCqQIz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J/bis10t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E881DC193
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319811; cv=none; b=m0Z6n6EUFxyGxd5xtPmijEhMCUMox0UutibVe9W8u0nbQxapDlOS4ODYcXLDpjMJ0aBgPEdgnaM7Q2qg2YDH/MHwZW8AmpbrQJk1QafPs8yGhzWjxpzYVkQQ0VkgdfUFwj3ZCocW1bIBdmNUAkJgK1m+vNKWFeEXuTE1t57UIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319811; c=relaxed/simple;
	bh=MJTHpZF1pjqou6oxpAbuBTFXweqN1Swg6SPfZvdrumk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YMUA21C6692dPscioQVJw+kQOeL61OJwa9Og5CvB0voeii9Q0z2i7QUfy7J06Qg5MLn4dtQoqlkCJRdFo+lkJK3+0CIM7zNpvchLumLB0UxJlOoDvQLLYhLcZiUxCqAqTH6EkNMNZdb0+8RkY/dwMfqBXfQ+QyIpUhivj7gw3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YoVCqQIz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J/bis10t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.831908427@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=EcwY8nQO7dHZBlYc/nlcYihBCfrOTqL4tvXELl0Nu6I=;
	b=YoVCqQIz+PNiFE7Ntbj9kJe39LK+F83CCUtp3rvIQotIGibv6NQVIxEhz4B/135c6YCj6h
	x9UCI3wOiAy/NNdQhHz5GwTPjePwRIboRXFOISyAmSG0iSiwDo6XNRHws+j1R84N5AmKJ+
	we9Cz7LwYn1s/tNRykzCpfdmgPYhBq1OSdRuyq78ZFGMaEeAdyENVrj0aCBmBpoFioyS6J
	38bdml9KYKOJJuZmWh8uVT/Q0O6IxJqZcKyJNlQvYsCLdh+J6etSgjeM6YwLvoRquE1B1i
	T9IqmtViwvfCV0rjVmLva2Y1GG4OpdeKbO0RfV1fzrhoHPMj+8L4JQpzN6QJGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=EcwY8nQO7dHZBlYc/nlcYihBCfrOTqL4tvXELl0Nu6I=;
	b=J/bis10tbnJF5m3xErQsidvk4g5HSoJbC1X5h0bf8/wl67/MTukn0IHCGVWVyuyq+yyZlJ
	eHsuiJbX/Q67lNAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 14/25] debugobjects: Move min/max count into pool struct
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:08 +0200 (CEST)

Having the accounting in the datastructure is better in terms of cache
lines and allows more optimizations later on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   55 +++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -46,9 +46,14 @@ struct debug_bucket {
 struct obj_pool {
 	struct hlist_head	objects;
 	unsigned int		cnt;
+	unsigned int		min_cnt;
+	unsigned int		max_cnt;
 } ____cacheline_aligned;
 
-static DEFINE_PER_CPU(struct obj_pool, pool_pcpu);
+
+static DEFINE_PER_CPU_ALIGNED(struct obj_pool, pool_pcpu)  = {
+	.max_cnt	= ODEBUG_POOL_PERCPU_SIZE,
+};
 
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
@@ -56,8 +61,14 @@ static struct debug_obj		obj_static_pool
 
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
-static struct obj_pool		pool_global;
-static struct obj_pool		pool_to_free;
+static struct obj_pool pool_global = {
+	.min_cnt	= ODEBUG_POOL_MIN_LEVEL,
+	.max_cnt	= ODEBUG_POOL_SIZE,
+};
+
+static struct obj_pool pool_to_free = {
+	.max_cnt	= UINT_MAX,
+};
 
 static HLIST_HEAD(pool_boot);
 
@@ -79,13 +90,9 @@ static int __data_racy			debug_objects_f
 static int __data_racy			debug_objects_warnings __read_mostly;
 static bool __data_racy			debug_objects_enabled __read_mostly
 					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int				debug_objects_pool_size __ro_after_init
-					= ODEBUG_POOL_SIZE;
-static int				debug_objects_pool_min_level __ro_after_init
-					= ODEBUG_POOL_MIN_LEVEL;
 
-static const struct debug_obj_descr *descr_test  __read_mostly;
-static struct kmem_cache	*obj_cache __ro_after_init;
+static const struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache		*obj_cache __ro_after_init;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -124,14 +131,14 @@ static __always_inline unsigned int pool
 	return READ_ONCE(pool->cnt);
 }
 
-static inline bool pool_global_should_refill(void)
+static __always_inline bool pool_should_refill(struct obj_pool *pool)
 {
-	return READ_ONCE(pool_global.cnt) < debug_objects_pool_min_level;
+	return pool_count(pool) < pool->min_cnt;
 }
 
-static inline bool pool_global_must_refill(void)
+static __always_inline bool pool_must_refill(struct obj_pool *pool)
 {
-	return READ_ONCE(pool_global.cnt) < (debug_objects_pool_min_level / 2);
+	return pool_count(pool) < pool->min_cnt / 2;
 }
 
 static void free_object_list(struct hlist_head *head)
@@ -178,7 +185,7 @@ static void fill_pool_from_freelist(void
 	 * Recheck with the lock held as the worker thread might have
 	 * won the race and freed the global free list already.
 	 */
-	while (pool_to_free.cnt && (pool_global.cnt < debug_objects_pool_min_level)) {
+	while (pool_to_free.cnt && (pool_global.cnt < pool_global.min_cnt)) {
 		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
 		hlist_del(&obj->node);
 		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
@@ -197,11 +204,11 @@ static void fill_pool(void)
 	 *   - One other CPU is already allocating
 	 *   - the global pool has not reached the critical level yet
 	 */
-	if (!pool_global_must_refill() && atomic_read(&cpus_allocating))
+	if (!pool_must_refill(&pool_global) && atomic_read(&cpus_allocating))
 		return;
 
 	atomic_inc(&cpus_allocating);
-	while (pool_global_should_refill()) {
+	while (pool_should_refill(&pool_global)) {
 		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
 		int cnt;
@@ -337,7 +344,7 @@ static void free_obj_work(struct work_st
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
 		return;
 
-	if (pool_global.cnt >= debug_objects_pool_size)
+	if (pool_global.cnt >= pool_global.max_cnt)
 		goto free_objs;
 
 	/*
@@ -347,7 +354,7 @@ static void free_obj_work(struct work_st
 	 * may be gearing up to use more and more objects, don't free any
 	 * of them until the next round.
 	 */
-	while (pool_to_free.cnt && pool_global.cnt < debug_objects_pool_size) {
+	while (pool_to_free.cnt && pool_global.cnt < pool_global.max_cnt) {
 		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
 		hlist_del(&obj->node);
 		hlist_add_head(&obj->node, &pool_global.objects);
@@ -408,7 +415,7 @@ static void __free_object(struct debug_o
 	}
 
 	raw_spin_lock(&pool_lock);
-	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
+	work = (pool_global.cnt > pool_global.max_cnt) && obj_cache &&
 	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
 	obj_pool_used--;
 
@@ -424,7 +431,7 @@ static void __free_object(struct debug_o
 			}
 		}
 
-		if ((pool_global.cnt > debug_objects_pool_size) &&
+		if ((pool_global.cnt > pool_global.max_cnt) &&
 		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
 			int i;
 
@@ -629,13 +636,13 @@ static void debug_objects_fill_pool(void
 	if (unlikely(!obj_cache))
 		return;
 
-	if (likely(!pool_global_should_refill()))
+	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
 	/* Try reusing objects from obj_to_free_list */
 	fill_pool_from_freelist();
 
-	if (likely(!pool_global_should_refill()))
+	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
 	/*
@@ -1427,8 +1434,8 @@ void __init debug_objects_mem_init(void)
 	 * system.
 	 */
 	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
-	debug_objects_pool_size += extras;
-	debug_objects_pool_min_level += extras;
+	pool_global.max_cnt += extras;
+	pool_global.min_cnt += extras;
 
 	/* Everything worked. Expose the cache */
 	obj_cache = cache;


