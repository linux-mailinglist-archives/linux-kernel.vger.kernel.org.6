Return-Path: <linux-kernel+bounces-345540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0598B757
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF328184D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B081A01CF;
	Tue,  1 Oct 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDFY94Nq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvHB1kbB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3731A00F3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772139; cv=none; b=ZBp7mxpq88gXE4J3if6vbBeiyrtCLqu1EIxUdIz1xQ2wFHLpHFFrUCcYikwDMEd1JJTDlB2D0eiwdB79zVjpZl11OVg2kmV9a2M3l/M6Ncu4H9PJFw+VM5ejLJXYX2yuxd8004rmfNV1KizJFzGS3eqHWFu2XxPQxxyKnaa1dO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772139; c=relaxed/simple;
	bh=Zh/YIxm87UGGG23ecLig7pP6cwITl+LA711478LPV3c=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OsCQ19azbXEoB/JuelyJ7lq8zLQeJWqsg2aDXPrvtzf5oBxQa5rnTjn6PN53Ih1PKTzAGltV/m3dhS1lgPbfbCeko4e/UIJF0+b8kXMDm9MbkcCANMgXSlkDAAsGLyDLpFcJ8ClqPzLXjVhw9LGSqohd1+8JzixcFnQXNeeyEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDFY94Nq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvHB1kbB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.971100589@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9pYCvucO0XJm5P4L8+u+NQUdYnVt14RcjMaKh5/8YAo=;
	b=UDFY94Nq/jAy5AoGmsB6XRwlzexz5yjKcxeS0PMdZI26xHgstNUeIwvAgcPzfFOT7VQlDH
	eOtRfSUkV4VUvgn8alM5TPctMdEwUOJcSkLOaukb6jAE3rMOS4BDzv6ewM2FFN0jSz7uke
	NsVgR/d+mpZ+DHUT/7ZfhM4KSCWYendYbXBH/8xSLKkYQqlOwO4g0sXTAcHK5fZ0JJ+9uI
	Gj/FupQuG1w6zapeWv2XeJ91FX+yMWXbbs/44JdlrG0+YR+V7FfX0v9Dn1KA8Ql0/asO7o
	HNUme9Oe2ua9f4zlvsV4zlgOPsKX/OTyrlDcHMgUkWgqJKVabJ2Dl95BApntLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9pYCvucO0XJm5P4L8+u+NQUdYnVt14RcjMaKh5/8YAo=;
	b=HvHB1kbB2wwlgL6qaoXVzpQl1sSZV4whsb/LIABV+8ka7X5hMHSHVTYfz6OBVCVSrz/3sl
	NfoRNoHLm1mW71Aw==
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
Subject: [patch V5 12/26] signal: Split up __sigqueue_alloc()
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:16 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Reorganize __sigqueue_alloc() so the ucounts retrieval and the
initialization can be used independently.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 


