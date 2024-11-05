Return-Path: <linux-kernel+bounces-396089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913009BC7C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BBD281637
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDD20012B;
	Tue,  5 Nov 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAaT5Cmm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6/YOKMMb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F081FF7D0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794481; cv=none; b=FMq4tZX9hNlhJOqVKwdo4F3p+Ifri747vDOQUW48/yNx7yhQkusFW0CPHTe4nGV5/ysbtn7fI4hbfOX3KiZbg1497Q7LNq3T4EUb59fhGKQig75dabmzXtVG2C8fYRBnHtIJSDgR3xWbxgelUGFOLe4n1u7IXOPAdOfHe1pxvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794481; c=relaxed/simple;
	bh=DJJdtdB7yx6npccgWUxboIsPKdsXHrZ0ZO98PCgvVgA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kJ6sNIg+/6gtqwJDb0H7bDwueabCR+FUmw0EiknLXeZW2EMmmZOyDVr4GjvjOeqgfKF9iQzs/XLoNh9I0jWwTlDY4MDs+osbX95SCjixQohSPpWqdDPSO4/9W8pNVToagQrT1fDdtyCN4Gkyuf+jGCE+0lSCvh5OY7vFlBW8A9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAaT5Cmm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6/YOKMMb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.371410037@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nO1+De1BhqmLhfu0q/o6dCJa04TGyfv46M1zqMkaqy0=;
	b=sAaT5CmmvFERowMaUszbgoRFwgQbmxhzVHaylJJG6NYnUrYyz4zVDOWicfk6F7t4d41dzc
	QfyzvDutp069Qyew13+SkTOGNkaYU51yR9qhWRQxzk+612JqpWYGyxc1BI25j2K6axD5/r
	FqWjmCVT0C2En3w5kJCMo1NLd4uUMqCa/Y0YGX2rvtrcJlLeNQmnID91Bpen4vWIf6Qswn
	dib+HZW5Do547T97QjLACQVv0zS9LKF0DahbxZmDS1og3aZElIEdyLQENAL5l5knp8Pz5c
	kZFV0VxanxAat0plKqT/LquoLSSOJhYa1MVyvjQhJo0ZG46O5InQUI3gPFReTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nO1+De1BhqmLhfu0q/o6dCJa04TGyfv46M1zqMkaqy0=;
	b=6/YOKMMbavOEziBv6K79rfSIBNAdVZXNH2EDk2ma10d0A0aT5U0dfiXhhS5CrezRuqwRiz
	loUpdBu0eNb12oDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V7 07/21] signal: Split up __sigqueue_alloc()
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:38 +0100 (CET)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Reorganize __sigqueue_alloc() so the ucounts retrieval and the
initialization can be used independently.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/signal.c |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)
---

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -396,16 +396,9 @@ void task_join_group_stop(struct task_st
 	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
 }
 
-/*
- * allocate a new signal queue record
- * - this may be called without locks if and only if t == current, otherwise an
- *   appropriate lock must be held to stop the target task from exiting
- */
-static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-		 int override_rlimit, const unsigned int sigqueue_flags)
+static struct ucounts *sig_get_ucounts(struct task_struct *t, int sig,
+				       int override_rlimit)
 {
-	struct sigqueue *q = NULL;
 	struct ucounts *ucounts;
 	long sigpending;
 
@@ -424,19 +417,44 @@ static struct sigqueue *
 	if (!sigpending)
 		return NULL;
 
-	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
-	} else {
+	if (unlikely(!override_rlimit && sigpending > task_rlimit(t, RLIMIT_SIGPENDING))) {
+		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		print_dropped_signal(sig);
+		return NULL;
 	}
 
-	if (unlikely(q == NULL)) {
+	return ucounts;
+}
+
+static void __sigqueue_init(struct sigqueue *q, struct ucounts *ucounts,
+			    const unsigned int sigqueue_flags)
+{
+	INIT_LIST_HEAD(&q->list);
+	q->flags = sigqueue_flags;
+	q->ucounts = ucounts;
+}
+
+/*
+ * allocate a new signal queue record
+ * - this may be called without locks if and only if t == current, otherwise an
+ *   appropriate lock must be held to stop the target task from exiting
+ */
+static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+					 int override_rlimit, const unsigned int sigqueue_flags)
+{
+	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
+	struct sigqueue *q;
+
+	if (!ucounts)
+		return NULL;
+
+	q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+	if (!q) {
 		dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
-	} else {
-		INIT_LIST_HEAD(&q->list);
-		q->flags = sigqueue_flags;
-		q->ucounts = ucounts;
+		return NULL;
 	}
+
+	__sigqueue_init(q, ucounts, sigqueue_flags);
 	return q;
 }
 


