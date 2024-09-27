Return-Path: <linux-kernel+bounces-341486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE439880C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEA5B22DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED51B14EF;
	Fri, 27 Sep 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOB0QE2m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5MX4JU0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02418A6C6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426936; cv=none; b=KRsyv7sJypKp7pXWW7gnMC15hmIo8rAMuylgWLXhAvmiqKDu1U46UEQclJnUbA/9B/XUcx7ulC4yCgSVmFBySTthFVNTN8BvxzQBtwxF+nKf2M1Ly/k43QI4xBjmuLP2v8h1GXRMwx2ixoPzqC0gfRYf9yNwS3yuZ0K1TPAe0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426936; c=relaxed/simple;
	bh=qdJDQEzOOu3OZFRx5A7UAJYAHMf5/XE2Ts3qnk+RTFg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dluEIs+tG8+zJ5xWPHb5sA70SS7A3P2wEQAxcUFm/t33hmbjJFNH6l3GuJ/Olb/nDI05qC7m5drwHKbZPIOM5iSvB7FXaFKlK40SQD4NWD8KHX8oQakaOCGXLLYJX0y1LDLgpRlLylga8zdTpeEY4A4+A+/q+CJyOCrAZx4ZjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOB0QE2m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5MX4JU0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.512919719@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4HNgn73tHuuvjYhUziBtvcDe9dnmdw0DM+iGVaf6dzo=;
	b=qOB0QE2my4mnax7hznpSbrCrxGgatXit6BG/XYKTMSNnVA4kvdlEuBTQwLLuDnUPG/EOle
	5CFXDH/ENj91Wp1wzcJtvgE8ljkKLY637t6Wo2C+nG7UDcnet3x8y8NMJb3DN4Kiw629sm
	8w+9pUNZEAmO2fywragL7UuRJ7QEUfXMkainf/k8xUx0l+lYY1c+dUoA0LTcEy7PVecz4j
	T1IeRz6bPX/CplCpqjUYmpOXYxjPmhDmJrVjmg7pApD2icTWRSOlHRa6EGz0JmvoemQNI8
	RwibIu7BNnViq3d+9bF1XUS0DeZeft5Wb2nyBBoDZXTlmg6tmy/e9TmWmeyt4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4HNgn73tHuuvjYhUziBtvcDe9dnmdw0DM+iGVaf6dzo=;
	b=d5MX4JU0BogCF0yG4x9PY7vVUyH4NoFUAqKAnVr3HnWiGkMCnzRYfdzqpb0N1A2a5IIrRz
	pnUzRiVb3vUUcFCw==
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
Subject: [patch v4 10/27] posix-timers: Make signal overrun accounting
 sensible
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:51 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

The handling of the timer overrun in the signal code is inconsistent as it
takes previous overruns into account. This is just wrong as after the
reprogramming of a timer the overrun count starts over from a clean state,
i.e. 0.

Make the accounting in send_sigqueue() consistent with that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/signal.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)
---
diff --git a/kernel/signal.c b/kernel/signal.c
index a407724f1267..a99274287902 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1961,6 +1961,34 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int s
 	 */
 	q->info.si_sys_private = si_private;
 
+	/*
+	 * Set the overrun count to zero unconditionally. The posix timer
+	 * code does not self rearm periodic timers. They are rearmed from
+	 * dequeue_signal().
+	 *
+	 * But there is a situation where @q is already enqueued:
+	 *
+	 * 1) timer_settime()
+	 *      arm_timer()
+	 * 2) timer_expires()
+	 *      send_sigqueue(@q)
+	 *        enqueue(@q)
+	 * 3) timer_settime()
+	 *      arm_timer()
+	 * 4) timer_expires()
+	 *      send_sigqueue(@q) <- Observes @q already queued
+	 *
+	 * In this case incrementing si_overrun does not make sense because
+	 * there is no relationship between timer_settime() #1 and #2.
+	 *
+	 * The POSIX specification is useful as always: "The effect of
+	 * disarming or resetting a timer with pending expiration
+	 * notifications is unspecified."
+	 *
+	 * Just do the sensible thing and reset the overrun.
+	 */
+	q->info.si_overrun = 0;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
@@ -1968,15 +1996,9 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int s
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
-		/*
-		 * If an SI_TIMER entry is already queue just increment
-		 * the overrun count.
-		 */
-		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-	q->info.si_overrun = 0;
 
 	signalfd_notify(t, sig);
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;


