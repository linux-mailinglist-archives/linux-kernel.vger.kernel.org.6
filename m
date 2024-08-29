Return-Path: <linux-kernel+bounces-307226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A321964A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4711C229EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105D1B3737;
	Thu, 29 Aug 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTQ2A5Fb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mro++Nnj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D41B252C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946197; cv=none; b=dq5t2STX3o2BrLzKPwXFfgcOl6nNpbZ2fovFoNV8nZ/3fhwtx6WVZnWwGVRdK+3wAkYe5g4gsrCeLEwT0be/9drDieYw6wE1RRnefFOfOW/VdH/5SPuZ+UtXUxs3kNWXilDESd6t0cbTC0ftPKNvo7CSc5wyj/S1lyg1psvNE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946197; c=relaxed/simple;
	bh=YXoIHlN/kEmBo+POiGxJwrfbkP0aJT0mAXFygAFSM7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eD3jXymY5x0gQH2a1r5ZuzvQVzhTaknmtxpAiffkWJIo+jMkEbCXsiD9WFDfKRFPEqCK7Y8oaRJD+BgEgbgyEZPJKl0LbFd6SMma/0CAZgd0HLBu+Rc2c42WLa8cTeWSxEDewwlew1lhoNyMO3ATbqd1NEMi4no2HpDUtJc1rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTQ2A5Fb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mro++Nnj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724946193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofI22lhyZgHNIrsrnZdj9CVqH5N9a3I84Qx1sB3icDY=;
	b=QTQ2A5FbKgKiAJil2BV7/Rl605+QjY6ZSfbyGaujXtPQl+zNYSluL+4pULRatxJBUuksXd
	0vd4QHN3KSTIgzAgZgZRjB6EiLPveeDFm4rmA+w4AFmCDyg4HCkmiCUvIpZHT8daF2LFst
	WQ63zAZrh0BW4BCcXFPZifrenKpxtwhxX+CiqPDgmxLnYO0g/k9YlpZ5k2ulffh4Gcg29m
	Xd5IJ7YTRW6d9HvwbCPvcBQ0qB2C0WwcqA2HfMBXRkFUMKA/c4VlKn/ms3vXvWAvFYQHRx
	pPBdzCQYc6P3X3NU8Vn7pMFlnZopYsfbRpJselznrRyjIMgOgt83due2rNkqng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724946193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofI22lhyZgHNIrsrnZdj9CVqH5N9a3I84Qx1sB3icDY=;
	b=Mro++NnjaJt2dUtMRje3Omw0rmfXpsH4luiiKsPh5E742qQ01s2pmK0TM1bu4gev9o2tBI
	DVXpKEHtcmWpE8Dw==
To: linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] timers: Annotate possible non critical data race of next_expiry
Date: Thu, 29 Aug 2024 17:43:05 +0200
Message-Id: <20240829154305.19259-1-anna-maria@linutronix.de>
In-Reply-To: <000000000000916e55061f969e14@google.com>
References: <000000000000916e55061f969e14@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global timers could be expired remotely when the target CPU is idle. After
a remote timer expiry, the remote timer_base->next_expiry value is updated
while holding the timer_base->lock. When the formerly idle CPU becomes
active at the same time and checks whether timers need to expire, this
check is done lockless as it is on the local CPU. This could lead to a data
race, which was reported by sysbot:

  https://lore.kernel.org/r/000000000000916e55061f969e14@google.com

When the value is read lockless but changed by the remote CPU, only two non
critical scenarios could happen:

1) The already update value is read -> everything is perfect

2) The old value is read -> a superfluous timer soft interrupt is raised

The same situation could happen when enqueueing a new first pinned timer by
a remote CPU also with non critical scenarios:

1) The already update value is read -> everything is perfect

2) The old value is read -> when the CPU is idle, an IPI is executed
nevertheless and when the CPU isn't idle, the updated value will be visible
on the next tick and the timer might be late one jiffie.

As this is very unlikely to happen, the overhead of doing the check under
the lock is a way more effort, than a superfluous timer soft interrupt or a
possible 1 jiffie delay of the timer.

Document and annotate this non critical behavior in the code by using
READ/WRITE_ONCE() pair when accessing timer_base->next_expiry.

Reported-by: syzbot+bf285fcc0a048e028118@syzkaller.appspotmail.com
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Closes: https://lore.kernel.org/lkml/000000000000916e55061f969e14@google.com
---
 kernel/time/timer.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 18aa759c3cae..71b96a9bf6e8 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -672,7 +672,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 * Set the next expiry time and kick the CPU so it
 		 * can reevaluate the wheel:
 		 */
-		base->next_expiry = bucket_expiry;
+		WRITE_ONCE(base->next_expiry, bucket_expiry);
 		base->timers_pending = true;
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
@@ -1964,7 +1964,7 @@ static void next_expiry_recalc(struct timer_base *base)
 		clk += adj;
 	}
 
-	base->next_expiry = next;
+	WRITE_ONCE(base->next_expiry, next);
 	base->next_expiry_recalc = false;
 	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 }
@@ -2018,7 +2018,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
-		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
+		WRITE_ONCE(base->next_expiry, basej + NEXT_TIMER_MAX_DELTA);
 
 	return base->next_expiry;
 }
@@ -2462,8 +2462,39 @@ static void run_local_timers(void)
 	hrtimer_run_queues();
 
 	for (int i = 0; i < NR_BASES; i++, base++) {
-		/* Raise the softirq only if required. */
-		if (time_after_eq(jiffies, base->next_expiry) ||
+		/*
+		 * Raise the softirq only if required.
+		 *
+		 * timer_base::next_expiry can be written by a remote CPU while
+		 * holding the lock. If this write happens at the same time than
+		 * the lockless local read, sanity checker could complain about
+		 * data corruption.
+		 *
+		 * There are two possible situations where
+		 * timer_base::next_expiry is written by a remote CPU:
+		 *
+		 * 1. Remote CPU expires global timers of this CPU and updates
+		 * timer_base::next_expiry of BASE_LOCAL afterwards in
+		 * next_timer_interrupt() or timer_recalc_next_expiry(). The
+		 * worst outcome is a superfluous raise of the timer softirq
+		 * when the not yet updated value is read.
+		 *
+		 * 2. A new first pinned timer is enqueued by a remote CPU and
+		 * therefore timer_base::next_expiry of BASE_GLOBAL is
+		 * updated. When this update is missed, this isn't a problem, as
+		 * an IPI is executed nevertheless when the CPU was idle
+		 * before. When the CPU wasn't idle but the update is missed,
+		 * then the timer would expire one jiffie late - bad luck.
+		 *
+		 * Those unlikely corner cases where the worst outcome is only a
+		 * one jiffie delay or a superfluous raise of the softirq are
+		 * not that expensive as doing the check always while holding
+		 * the lock.
+		 *
+		 * Possible remote writers are using WRITE_ONCE(). Local reader
+		 * uses therefore READ_ONCE().
+		 */
+		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i == BASE_DEF && tmigr_requires_handle_remote())) {
 			raise_softirq(TIMER_SOFTIRQ);
 			return;
-- 
2.39.2


