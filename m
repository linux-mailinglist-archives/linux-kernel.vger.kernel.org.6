Return-Path: <linux-kernel+bounces-353894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A457E993408
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A891F231D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7D1DE4FF;
	Mon,  7 Oct 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l/c5K/zS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFLObFmX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4571DE3D0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319821; cv=none; b=mELHsjjaUbGv6OrZYs3gzPcb+DIzde+uKI26W23C4oQZE88Ss8A3Fd/OmeUfuelwF4YS76fnY9lD+KBHA9RggGcuFfNfZTxRqDbG+fORTrdORyc4RHqB/LvNAD3dr8IZFiV8X2gLrLAA7cziqM21rOgxLh8aU7Aqqwm4KqrQzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319821; c=relaxed/simple;
	bh=OTNHBzJjLjVr4pJvMT7It2p7L/n3O0GjawQZblft/aE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=u1F6XfpLJiwMBKJ7j6ym2A6K/Er+lp1KP4ikRejlfO3dDVkK0vEaLQef55/6hnblDoyB13B3YQz2XWE0b0/o2HaqZRTkXMRNFNSxTCr9pAWvMQdz06W0gUhRqf8RrEJdAtJRGo4JylQtL7V2gzD0O6aKL2n9c2rrZMtPSQUEqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l/c5K/zS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HFLObFmX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.318776207@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=X6M/ZpzoVuNVXCR6ojlXr0UcScmjUOMKBbYbJO7HIQA=;
	b=l/c5K/zSdVTFrg60DwX2b/SEhl+ZaGNFOGEP1OCXDOlNqR+mWSXC0O7OWfGenhaj5e15Jk
	uWcD5So+2o5Bce1MQVBgXZRIKDoRp1CScR4U91DG2mfQmsHUmvQLY9PXHeMBe1MPD7HgiT
	4dK9QLOE8dWMYeZ89M3YSf2uwaVIaXEz8ZfSMPvlsm5Loje1fKc9zkXFGGm0KabJO3n/d2
	8MytTOC3DfLOZ9ZmFw+QJ521kdLSrUg5Py9qM7vpK8KOoKHDBH3mazjKps54L+PelewQHc
	NfkjFRjL1dnqcB3xlWjh5owyAwufikvN6f1eDCOlFXT5VcyJb+yWD9UgSsirzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=X6M/ZpzoVuNVXCR6ojlXr0UcScmjUOMKBbYbJO7HIQA=;
	b=HFLObFmX8Bg9ZAvYgM1bVNa/JC8haRSuxvVxLZytJqMgat29s0iNGRKz2m7oM+ga69KfqH
	FReEJsL2h0vjSXCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 22/25] debugobjects: Move pool statistics into global_pool
 struct
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:18 +0200 (CEST)

Keep it along with the pool as that's a hot cache line anyway and it makes
the code more comprehensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   85 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -47,11 +47,18 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
+struct pool_stats {
+	unsigned int		cur_used;
+	unsigned int		max_used;
+	unsigned int		min_fill;
+};
+
 struct obj_pool {
 	struct hlist_head	objects;
 	unsigned int		cnt;
 	unsigned int		min_cnt;
 	unsigned int		max_cnt;
+	struct pool_stats	stats;
 } ____cacheline_aligned;
 
 
@@ -66,8 +73,11 @@ static struct debug_obj		obj_static_pool
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
 static struct obj_pool pool_global = {
-	.min_cnt	= ODEBUG_POOL_MIN_LEVEL,
-	.max_cnt	= ODEBUG_POOL_SIZE,
+	.min_cnt		= ODEBUG_POOL_MIN_LEVEL,
+	.max_cnt		= ODEBUG_POOL_SIZE,
+	.stats			= {
+		.min_fill	= ODEBUG_POOL_SIZE,
+	},
 };
 
 static struct obj_pool pool_to_free = {
@@ -76,16 +86,6 @@ static struct obj_pool pool_to_free = {
 
 static HLIST_HEAD(pool_boot);
 
-/*
- * Because of the presence of percpu free pools, obj_pool_free will
- * under-count those in the percpu free pools. Similarly, obj_pool_used
- * will over-count those in the percpu free pools. Adjustments will be
- * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
- * can be off.
- */
-static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
-static int			obj_pool_used;
-static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
 
 static int __data_racy			debug_objects_maxchain __read_mostly;
@@ -231,6 +231,19 @@ static struct debug_obj *__alloc_object(
 	return obj;
 }
 
+static void pcpu_refill_stats(void)
+{
+	struct pool_stats *stats = &pool_global.stats;
+
+	WRITE_ONCE(stats->cur_used, stats->cur_used + ODEBUG_BATCH_SIZE);
+
+	if (stats->cur_used > stats->max_used)
+		stats->max_used = stats->cur_used;
+
+	if (pool_global.cnt < stats->min_fill)
+		stats->min_fill = pool_global.cnt;
+}
+
 static struct debug_obj *pcpu_alloc(void)
 {
 	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
@@ -250,13 +263,7 @@ static struct debug_obj *pcpu_alloc(void
 			if (!pool_move_batch(pcp, &pool_global))
 				return NULL;
 		}
-		obj_pool_used += ODEBUG_BATCH_SIZE;
-
-		if (obj_pool_used > obj_pool_max_used)
-			obj_pool_max_used = obj_pool_used;
-
-		if (pool_global.cnt < obj_pool_min_free)
-			obj_pool_min_free = pool_global.cnt;
+		pcpu_refill_stats();
 	}
 }
 
@@ -285,7 +292,7 @@ static void pcpu_free(struct debug_obj *
 	/* Try to fit the batch into the pool_global first */
 	if (!pool_move_batch(&pool_global, pcp))
 		pool_move_batch(&pool_to_free, pcp);
-	obj_pool_used -= ODEBUG_BATCH_SIZE;
+	WRITE_ONCE(pool_global.stats.cur_used, pool_global.stats.cur_used - ODEBUG_BATCH_SIZE);
 }
 
 static void free_object_list(struct hlist_head *head)
@@ -1074,23 +1081,33 @@ void debug_check_no_obj_freed(const void
 
 static int debug_stats_show(struct seq_file *m, void *v)
 {
-	int cpu, obj_percpu_free = 0;
+	unsigned int cpu, pool_used, pcp_free = 0;
 
+	/*
+	 * pool_global.stats.cur_used is the number of batches currently
+	 * handed out to per CPU pools. Convert it to number of objects
+	 * and subtract the number of free objects in the per CPU pools.
+	 * As this is lockless the number is an estimate.
+	 */
 	for_each_possible_cpu(cpu)
-		obj_percpu_free += per_cpu(pool_pcpu.cnt, cpu);
+		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
 
-	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
-	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
-	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
-	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", pool_count(&pool_global) + obj_percpu_free);
-	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
-	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
-	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
-	seq_printf(m, "on_free_list  :%d\n", pool_count(&pool_to_free));
-	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
-	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
+	pool_used = data_race(pool_global.stats.cur_used);
+	pcp_free = min(pool_used, pcp_free);
+	pool_used -= pcp_free;
+
+	seq_printf(m, "max_chain     : %d\n", debug_objects_maxchain);
+	seq_printf(m, "max_checked   : %d\n", debug_objects_maxchecked);
+	seq_printf(m, "warnings      : %d\n", debug_objects_warnings);
+	seq_printf(m, "fixups        : %d\n", debug_objects_fixups);
+	seq_printf(m, "pool_free     : %u\n", pool_count(&pool_global) + pcp_free);
+	seq_printf(m, "pool_pcp_free : %u\n", pcp_free);
+	seq_printf(m, "pool_min_free : %u\n", data_race(pool_global.stats.min_fill));
+	seq_printf(m, "pool_used     : %u\n", pool_used);
+	seq_printf(m, "pool_max_used : %u\n", data_race(pool_global.stats.max_used));
+	seq_printf(m, "on_free_list  : %u\n", pool_count(&pool_to_free));
+	seq_printf(m, "objs_allocated: %d\n", debug_objects_allocated);
+	seq_printf(m, "objs_freed    : %d\n", debug_objects_freed);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(debug_stats);


