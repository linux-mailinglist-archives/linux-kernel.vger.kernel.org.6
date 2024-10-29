Return-Path: <linux-kernel+bounces-387170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB739B4CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7EC1F20FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA5419258A;
	Tue, 29 Oct 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6QIQZHR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKwhhdWc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9E18DF60
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214411; cv=none; b=h/thlrf0wQCjtpEcDEli/pMX1moDUmLz1kC9AGLoJGseTYUDbzyA4AnVZrNHNvP6zWucqh6tYHthEn9I2hZ3Gmp+kzbSatJLiVqbt9Cka/E2ojRNOorrmUioRrPDeAQwzS0uehmCFq4EQSMOm/9zMorA0Jmux9LLGoHy9fQV4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214411; c=relaxed/simple;
	bh=aQ3mDoIRlD7DG8fx/qByPToW5p2/LKR8ViLXL/km9ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ21RSd6bt0KFD12RbPx6KnUxMiMRFKOpgYn2JdtJsupeCu3UA/ROWnlZ7AtbS4paWOgvzsWiR2gWJKwr3hRd8s/aRv7V61q2sFz8KIOo9qVGJk4SFjTFZw2hjVVhV40fvvUMNq1w79vvvfhew2m8MHp3vv+PnzMOuvXoBl1mDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6QIQZHR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKwhhdWc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 29 Oct 2024 16:06:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730214405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNqWLPAtm2P/NbJTNLtKhvDVpUc8hWWTZNmUDo+LIiE=;
	b=k6QIQZHRDVsS83M57FVucCGWgQlWjhe2WwE5E+712i0tYBY/x0xU5hrqnh8ICC1spNDVOf
	aLegPrQQzpyxzdvGRMmw8/Ec5LVAQ1V6UUkYU/7SrQRVYlryCAUfBSagyussDklAQ1RiZq
	hcwQwWW3haCaUSmcUaYfD8dG0oWVD3I9fscbczymCdvN94FExlffPvYyk0mPG5Gp/SBrDU
	OhilzNgkjXOHYte0xYv0w0Bwe4WDp6bGEe/HdcXETHwWiybgQEEO3HREDRmZTa1J4IiH0F
	FGP2SzFRGAeTMuhYLQNAgH7u4ru/eSGbVkCxNjwy5+XiCLzVVbrPaEWltBf7/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730214405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yNqWLPAtm2P/NbJTNLtKhvDVpUc8hWWTZNmUDo+LIiE=;
	b=YKwhhdWcmUqTN8ae/oNFSKy5O8aMtO0aBcKbvYQW8SPmYQXNib1GN6easy/KZ8stZ4J8BU
	zQl2QkFbgjrUF2Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC v2 PATCH 0/4] futex: Add support task local hash maps.
Message-ID: <20241029150642.2tDTBvuF@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
 <ZyDCoduIh3yryRVB@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyDCoduIh3yryRVB@jlelli-thinkpadt14gen4.remote.csb>

On 2024-10-29 12:10:25 [+0100], Juri Lelli wrote:
> Hi Sebastian,
Hi Juri,

> > I've been how this auto-create behaves and so far dpkg creates threads
> > and uses the local-hashmap. systemd-journal on the hand forks a thread
> > from time to time and I haven't seen it using the hashmap. Need to do
> > more testing.
> 
> I ported it to one of our kernels with the intent of asking perf folks
> to have a go at it (after some manual smoke testing maybe). It will
> take a couple of weeks or so to get numbers back.

Thanks.

> Do you need specific additional info to possibly be collected while
> running? I saw your reply about usage. If you want to agree on what to
> collect feel free to send out the debug patch I guess you used for that.

If you run a specific locking test cases, you could try set the number of
slots upfront (instead of relying on the default 4) and see how this
affects the performance. Also there is a cap at 16, you might want to
raise this to 1024 and try some higher numbers and see how this effects
performance. The prctl() interface should be easy to set/ get the values.
The default 4 might be too conservative.
That would give an idea what a sane default value and upper limit might be.

The hunk attached (against the to be posted v3) adds counters to see how
many auto-allocated slots were used vs not used. In my tests the number
of unused hash buckets was very small, so I don't think it matters.

> Best,
> Juri

Sebastian

---------------------->8---------------------

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3b8c8975cd493..aa2a0d059b1a8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -248,6 +248,7 @@ struct signal_struct {
 						 * and may have inconsistent
 						 * permissions.
 						 */
+	unsigned int			futex_hash_used;
 	unsigned int			futex_hash_mask;
 	struct futex_hash_bucket	*futex_hash_bucket;
 } __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index e792a43934363..341331778032a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -945,10 +945,19 @@ static void mmdrop_async(struct mm_struct *mm)
 	}
 }
 
+extern atomic64_t futex_hash_stats_used;
+extern atomic64_t futex_hash_stats_unused;
+
 static inline void free_signal_struct(struct signal_struct *sig)
 {
 	taskstats_tgid_free(sig);
 	sched_autogroup_exit(sig);
+	if (sig->futex_hash_bucket) {
+		if (sig->futex_hash_used)
+			atomic64_inc(&futex_hash_stats_used);
+		else
+			atomic64_inc(&futex_hash_stats_unused);
+	}
 	kfree(sig->futex_hash_bucket);
 	/*
 	 * __mmdrop is not safe to call from softirq context on x86 due to
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b48abf2e97c25..04a597736cb00 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -40,6 +40,7 @@
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 #include <linux/prctl.h>
+#include <linux/proc_fs.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -132,8 +133,10 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 			  key->both.offset);
 
 	fhb = current->signal->futex_hash_bucket;
-	if (fhb && futex_key_is_private(key))
+	if (fhb && futex_key_is_private(key)) {
+		current->signal->futex_hash_used = 1;
 		return &fhb[hash & current->signal->futex_hash_mask];
+	}
 
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
@@ -1202,8 +1205,13 @@ static int futex_hash_allocate(unsigned int hash_slots)
 	return 0;
 }
 
+atomic64_t futex_hash_stats_used;
+atomic64_t futex_hash_stats_unused;
+atomic64_t futex_hash_stats_auto_create;
+
 int futex_hash_allocate_default(void)
 {
+	atomic64_inc(&futex_hash_stats_auto_create);
 	return futex_hash_allocate(0);
 }
 
@@ -1235,6 +1243,19 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
 	return ret;
 }
 
+static int proc_show_futex_stats(struct seq_file *seq, void *offset)
+{
+	long fh_used, fh_unused, fh_auto_create;
+
+	fh_used = atomic64_read(&futex_hash_stats_used);
+	fh_unused = atomic64_read(&futex_hash_stats_unused);
+	fh_auto_create = atomic64_read(&futex_hash_stats_auto_create);
+
+	seq_printf(seq, "used: %ld unsued: %ld auto: %ld\n",
+		   fh_used, fh_unused, fh_auto_create);
+	return 0;
+}
+
 static int __init futex_init(void)
 {
 	unsigned int futex_shift;
@@ -1255,6 +1276,7 @@ static int __init futex_init(void)
 	for (i = 0; i < futex_hashsize; i++)
 		futex_hash_bucket_init(&futex_queues[i]);
 
+	proc_create_single("futex_stats", 0, NULL, proc_show_futex_stats);
 	return 0;
 }
 core_initcall(futex_init);

