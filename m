Return-Path: <linux-kernel+bounces-390824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280F29B7EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EC3B228D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E497E1BC9F9;
	Thu, 31 Oct 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TD86oS8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oyppJDHK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291131BB6BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389594; cv=none; b=uRiXJfTjOLq7+dfDYoCvagog3ll1JqVeQXjkdcnEgHD2wTDpzEkKqZ2sV4X/Kg/Ay1rOtTVhVCLapaKZHnDq4h0BqjNANedoME29Slescjeir0NZix4EdlRibn6bYb50493kYcnfS2DuDgtgvy3UKDQ3g/L92NpkV31i5YQts1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389594; c=relaxed/simple;
	bh=RpPe8akei2X3DFyo/GviuhYgA/IaiJ9f1ZzIceIbO44=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dqx5NN/MbXex8l3Hc7CwJr4QOm9T6d9LGNRDDpu9a3QK8ChSxvgc5/j+ELE9osFTU1nmtJ3w1PH18mY/ibGbgmeUGt0gtESWxwq4znnNaIZeDlpI59vWTA3sWsmZp7xUtsOTRu7flYvyWnbahy+lpr38o12ckW0My7oG+hCoiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TD86oS8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oyppJDHK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154424.928822095@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lWQ3QAq9jnqUt7hBgMDxaHm03/0EIaipDycR2Op2VkE=;
	b=TD86oS8R1SKv29u0CWICDsPzzN7y4U3iRNCmhTxNjHgI1c7OM4wtY4tCFBkPFIuxM3T6T0
	QgqMhv+gjDRNfq8ZZhocTYaxl0Rhq/HO35qhbwp0aVbo++FVL1q/qQB6eNdFdbTlWi2EMa
	7M0PNLILNUFZ46uLluvmERBvV7U8za0P8qcIJSsuyMZxxQA/wBEaJgbACYfVf1mhOxfXz6
	YzcsNhEdDHbTw2GqTai9NQfvo9zvSLO6xUKevqa65bj23Q6GPa9UXltiZ5ygFRSNcGlKXW
	OpBFQ3JfLX2DBm9X142xOrQEXze23ktefY0QtHpfSgsFKjMPqI83R9IGpyBR6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lWQ3QAq9jnqUt7hBgMDxaHm03/0EIaipDycR2Op2VkE=;
	b=oyppJDHKozieTZTJwt2/H36jT+L+5Nyn823Imi6gXRgeuY+vjXhCRwHZulVjn7LZyxKkd9
	OAb0m6pslfp/wIAQ==
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
Subject: [patch v6 06/20] signal: Split up __sigqueue_alloc()
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:30 +0100 (CET)

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
 kernel/signal.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)
---

diff --git a/kernel/signal.c b/kernel/signal.c
index a99274287902..87c349a2ddf7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -396,16 +396,9 @@ void task_join_group_stop(struct task_struct *task)
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
 
@@ -424,19 +417,44 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
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
 




