Return-Path: <linux-kernel+bounces-353892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50252993407
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA6CB287BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899261DE4CD;
	Mon,  7 Oct 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YU4OGWjp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ef+kZiF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB51DE3AC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319819; cv=none; b=uky4Tu+IcuwCbvKd6Fqj7O6BB9r0uu89I9RmO2ziaF8oKbPqYe8R6tKGxQadOmoAdxo93hp3EzE+wLxfv0QRA88OFjm7/3lm2pjJc7fDF2vUAN8bAkIVTQz85VglC4FuJNMLin017f8Sibn1PVQP8XN7BUISKhsKEvgEXyHxbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319819; c=relaxed/simple;
	bh=ChB9QCtPxHuyVuVC/mOtOnn3hRZjwhD+HY88NV1O/bI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JJMRPun2E8FdvGqeP9fgLtzhu8CIx/Zs8IueTITrxGz5/Ii3Id+d2kV2qdJSREY+G4iwMdctMogmCGLlMpKZXJ6Y+h0HybkatqCMZzSBY8TiwqFxx3DG21hIZEX42gvJW/SDLTQgVOszYuO+nuXskKbaglvK6qra4sdS/BHRc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YU4OGWjp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Ef+kZiF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.198647184@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aM/x+wJOhqKJ3/ssLuuYF0bn8qxcMJkxeyzQCufMmNY=;
	b=YU4OGWjpRiH9po725drvUrAzhB2Wx+rhH3+RSCIU5TrmBCR5hsqUW7oYLSVgNCUBMBMT41
	LS9I3t4/G0hsX0juKeoXTuA62qz9C3Qr0Sq7PjuWixX+657ZEkixpXXSG5tmZZqGuyjmet
	vdmMKKIBBcoJBcvHS6nPBEJhjcIGOO72NpRp4GLJp+j/Cbi5sMWCP/d1JM5Nj+22yNnUqw
	ojftnWQ6Ciop76VZaHFlJJ5DFUFUsJLwoVAg8khOT+0FBYTiZPCvN90AIBpxPUbCqGTaob
	lFz70kv/A4yqVdcl3qre8ObFB7PSoIzM9m034w/4ItBG5fgPhwFqs6oMUlHdGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aM/x+wJOhqKJ3/ssLuuYF0bn8qxcMJkxeyzQCufMmNY=;
	b=2Ef+kZiFgMlYebt/9b20l+94FRQlsL3DG50QmIUIiU/no00oNdPvc1q2vK2Nlk0uamcQgk
	dDZhKEvamAUIm8BQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 20/25] debugobjects: Prepare kmem_cache allocations for
 batching
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:15 +0200 (CEST)

Allocate a batch and then push it into the pool. Utilize the
debug_obj::last_node pointer for keeping track of the batch boundary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   80 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -164,6 +164,22 @@ static bool pool_move_batch(struct obj_p
 	return true;
 }
 
+static bool pool_push_batch(struct obj_pool *dst, struct hlist_head *head)
+{
+	struct hlist_node *last;
+	struct debug_obj *obj;
+
+	if (dst->cnt >= dst->max_cnt)
+		return false;
+
+	obj = hlist_entry(head->first, typeof(*obj), node);
+	last = obj->batch_last;
+
+	hlist_splice_init(head, last, &dst->objects);
+	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
+	return true;
+}
+
 static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
 {
 	if (!src->cnt)
@@ -288,6 +304,28 @@ static void fill_pool_from_freelist(void
 	clear_bit(0, &state);
 }
 
+static bool kmem_alloc_batch(struct hlist_head *head, struct kmem_cache *cache, gfp_t gfp)
+{
+	struct hlist_node *last = NULL;
+	struct debug_obj *obj;
+
+	for (int cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+		obj = kmem_cache_zalloc(cache, gfp);
+		if (!obj) {
+			free_object_list(head);
+			return false;
+		}
+		debug_objects_allocated++;
+
+		if (!last)
+			last = &obj->node;
+		obj->batch_last = last;
+
+		hlist_add_head(&obj->node, head);
+	}
+	return true;
+}
+
 static void fill_pool(void)
 {
 	static atomic_t cpus_allocating;
@@ -302,25 +340,14 @@ static void fill_pool(void)
 
 	atomic_inc(&cpus_allocating);
 	while (pool_should_refill(&pool_global)) {
-		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
-		int cnt;
 
-		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new = kmem_cache_zalloc(obj_cache, __GFP_HIGH | __GFP_NOWARN);
-			if (!new)
-				break;
-			hlist_add_head(&new->node, &head);
-			if (!last)
-				last = new;
-		}
-		if (!cnt)
+		if (!kmem_alloc_batch(&head, obj_cache, __GFP_HIGH | __GFP_NOWARN))
 			break;
 
 		guard(raw_spinlock_irqsave)(&pool_lock);
-		hlist_splice_init(&head, &last->node, &pool_global.objects);
-		debug_objects_allocated += cnt;
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + cnt);
+		if (!pool_push_batch(&pool_global, &head))
+			pool_push_batch(&pool_to_free, &head);
 	}
 	atomic_dec(&cpus_allocating);
 }
@@ -1302,26 +1329,18 @@ void __init debug_objects_early_init(voi
 static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache)
 {
 	struct debug_bucket *db = obj_hash;
-	struct debug_obj *obj, *new;
 	struct hlist_node *tmp;
+	struct debug_obj *obj;
 	HLIST_HEAD(objects);
 	int i;
 
-	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
-		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
-		if (!obj)
+	for (i = 0; i < ODEBUG_POOL_SIZE; i += ODEBUG_BATCH_SIZE) {
+		if (!kmem_alloc_batch(&objects, cache, GFP_KERNEL))
 			goto free;
-		hlist_add_head(&obj->node, &objects);
+		pool_push_batch(&pool_global, &objects);
 	}
 
-	debug_objects_allocated = ODEBUG_POOL_SIZE;
-	pool_global.cnt = ODEBUG_POOL_SIZE;
-
-	/*
-	 * Move the allocated objects to the global pool and disconnect the
-	 * boot pool.
-	 */
-	hlist_move_list(&objects, &pool_global.objects);
+	/* Disconnect the boot pool. */
 	pool_boot.first = NULL;
 
 	/* Replace the active object references */
@@ -1329,9 +1348,8 @@ static bool __init debug_objects_replace
 		hlist_move_list(&db->list, &objects);
 
 		hlist_for_each_entry(obj, &objects, node) {
-			new = hlist_entry(pool_global.objects.first, typeof(*obj), node);
-			hlist_del(&new->node);
-			pool_global.cnt--;
+			struct debug_obj *new = pcpu_alloc();
+
 			/* copy object data */
 			*new = *obj;
 			hlist_add_head(&new->node, &db->list);
@@ -1340,7 +1358,7 @@ static bool __init debug_objects_replace
 	return true;
 free:
 	/* Can't use free_object_list() as the cache is not populated yet */
-	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
+	hlist_for_each_entry_safe(obj, tmp, &pool_global.objects, node) {
 		hlist_del(&obj->node);
 		kmem_cache_free(cache, obj);
 	}


