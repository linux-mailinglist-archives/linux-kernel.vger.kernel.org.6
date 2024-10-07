Return-Path: <linux-kernel+bounces-353883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB39933F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF527B277D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85FE1DDA07;
	Mon,  7 Oct 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1wlWvI3H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkExd2fU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A71DD893
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319810; cv=none; b=hgvCEpdCHWFlgj9yg+4YLLGWxkyKqzJioIOujiob7SCiJ43br/dvmxBmoBGpnyZhxbtYIKsNBP3bmfvS3vUw54gqgSeG/tpMCTdIQE3wzr9t5m274Gj3Op9uefwvueawIixUywyjbcBny8/J2LeroRmsW+0RwlJzkThPhcfRi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319810; c=relaxed/simple;
	bh=p28R/DTSeAkAp/F1zxRG0aYLBOZX/REDwdHwMFyI7zc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PEUN6Q7j/qc2FZ3D1O9eTyju02F65d91TQ9i8+vg/YK6uagrm8XuD/qAMKYS+WDTllStG0j5Liw6O21rQb9k+jIsL+sO1IMai8lgWEoC4Z90WcFQPmr0XHP40KQjix2SM2+fSqS5D86MGfE3dkJO1wAVzLp9SworxifKQURsmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1wlWvI3H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkExd2fU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.770595795@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XsISTO1FmLtHeTAitVxsUtQMSisv5BnD16nh7PYhYH8=;
	b=1wlWvI3Ha1Vf1Fu/x+amzIDjzbUqZY+FCwJEqBpjv9kUfDb4gf8WXHBNmqO5VZrdXhTrMb
	HKJ3yC94uheWLwTAny2U7x89294pOsh4szSL7BWtIuj9vqban5JQPoxl9w64EhPwdLiU6K
	Aq3OVB5RbzKFqprV4LreYkN8K338InH0p3QL6Gg16zBEA6nZXWPlwkyXKlD/kqn9nPAkgT
	JFUIui6+JHH8c7fSLHxT1c4CIL8iOnY9jh7VRW9Lq/+FaDXVdZKYjt5rd8q7wVKLk6cxXG
	Ab4ttHRh3tms43kiSNKK8UJKvqt1irVH/sdq70FPBctVEfHayKedDPIsCruccg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XsISTO1FmLtHeTAitVxsUtQMSisv5BnD16nh7PYhYH8=;
	b=JkExd2fUtkkn0p3cJ7UlbIi5pA1x4YIl6M9ut0bo5Ipvn5pDCtWjIwQhWStVWLlyffJbzZ
	n2GR4LSYPLjAwiDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 13/25] debugobjects: Rename and tidy up per CPU pools
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:07 +0200 (CEST)

No point in having a separate data structure. Reuse struct obj_pool and
tidy up the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -43,21 +43,12 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
-/*
- * Debug object percpu free list
- * Access is protected by disabling irq
- */
-struct debug_percpu_free {
-	struct hlist_head	free_objs;
-	int			obj_free;
-};
-
 struct obj_pool {
 	struct hlist_head	objects;
 	unsigned int		cnt;
 } ____cacheline_aligned;
 
-static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+static DEFINE_PER_CPU(struct obj_pool, pool_pcpu);
 
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
@@ -271,13 +262,13 @@ static struct debug_obj *__alloc_object(
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
-	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	struct obj_pool *percpu_pool = this_cpu_ptr(&pool_pcpu);
 	struct debug_obj *obj;
 
 	if (likely(obj_cache)) {
-		obj = __alloc_object(&percpu_pool->free_objs);
+		obj = __alloc_object(&percpu_pool->objects);
 		if (obj) {
-			percpu_pool->obj_free--;
+			percpu_pool->cnt--;
 			goto init_obj;
 		}
 	} else {
@@ -304,8 +295,8 @@ alloc_object(void *addr, struct debug_bu
 				obj2 = __alloc_object(&pool_global.objects);
 				if (!obj2)
 					break;
-				hlist_add_head(&obj2->node, &percpu_pool->free_objs);
-				percpu_pool->obj_free++;
+				hlist_add_head(&obj2->node, &percpu_pool->objects);
+				percpu_pool->cnt++;
 				obj_pool_used++;
 				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
 			}
@@ -384,7 +375,7 @@ static void free_obj_work(struct work_st
 static void __free_object(struct debug_obj *obj)
 {
 	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
-	struct debug_percpu_free *percpu_pool;
+	struct obj_pool *percpu_pool;
 	int lookahead_count = 0;
 	bool work;
 
@@ -398,10 +389,10 @@ static void __free_object(struct debug_o
 	/*
 	 * Try to free it into the percpu pool first.
 	 */
-	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
-	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->free_objs);
-		percpu_pool->obj_free++;
+	percpu_pool = this_cpu_ptr(&pool_pcpu);
+	if (percpu_pool->cnt < ODEBUG_POOL_PERCPU_SIZE) {
+		hlist_add_head(&obj->node, &percpu_pool->objects);
+		percpu_pool->cnt++;
 		return;
 	}
 
@@ -410,10 +401,10 @@ static void __free_object(struct debug_o
 	 * of objects from the percpu pool and free them as well.
 	 */
 	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
+		objs[lookahead_count] = __alloc_object(&percpu_pool->objects);
 		if (!objs[lookahead_count])
 			break;
-		percpu_pool->obj_free--;
+		percpu_pool->cnt--;
 	}
 
 	raw_spin_lock(&pool_lock);
@@ -494,10 +485,10 @@ static void put_objects(struct hlist_hea
 static int object_cpu_offline(unsigned int cpu)
 {
 	/* Remote access is safe as the CPU is dead already */
-	struct debug_percpu_free *pcp = per_cpu_ptr(&percpu_obj_pool, cpu);
+	struct obj_pool *pcp = per_cpu_ptr(&pool_pcpu, cpu);
 
-	put_objects(&pcp->free_objs);
-	pcp->obj_free = 0;
+	put_objects(&pcp->objects);
+	pcp->cnt = 0;
 	return 0;
 }
 #endif
@@ -1076,7 +1067,7 @@ static int debug_stats_show(struct seq_f
 	int cpu, obj_percpu_free = 0;
 
 	for_each_possible_cpu(cpu)
-		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
+		obj_percpu_free += per_cpu(pool_pcpu.cnt, cpu);
 
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);


