Return-Path: <linux-kernel+bounces-396090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E09BC7C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809671F23074
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED02003B3;
	Tue,  5 Nov 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K+CQHcAP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VM1D7NMK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896220011E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794483; cv=none; b=Sccbv3kUje6gJFbNp8U3939igcZhEC9D08oQr4I6E2ktPQX3IrTpkqUB+nChYlaxEop2/ifXgr2ang2QWDjNn+4mhezs4zuRrL/yfOY1Zf/n8LUzWFq5WTiUk3SyfwQBlDVsK8/xvUm8F32QcuCnvNqP6XS82Uag2Y+cqrOs9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794483; c=relaxed/simple;
	bh=ZVAaQanLkDGCsroH9vcnsYuRVzlKEvfr6cRqTv9u2nQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RQue92EFw14rVbXpksSxzTLTK4wulFfD3U9Jn+ikHec76dt0fg/0z/wiH7Je37ZnG4qyaPaOwFbVx+Bk+twTQ6jW1hiBCF7CZDcqAU7/19o2be6BwZ4mcNE4mh/ppKIaO30qD/mVwtgXcWnRp8MXhkre2r9dZU845I+PKLq05kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K+CQHcAP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VM1D7NMK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.450427515@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9/sheOM3O505WEl90eWHF3ugDs9kjENsFCU+PPXorJo=;
	b=K+CQHcAPlQG+xKqK6lDGIGfqAsaKBaLMkvd+HIg4lJKTmoaO504kVWqZoR8ZfFuCdDrGVK
	FpvEJOEJSwA0qIhZSNhkJCJz1Tb2JmUB9GxvhDrVeSS1CYrz3bUxkfe72Dcyu4z/iNbCdp
	33U7sn+sjMmjelNtZGpgcPFpPfMpQgJGKM5FK42e/0axOo++iBtyP2i2K9nBNSEWkoctsM
	12aFoPT1GmD+MgZwVH3cX+UesKYFLX7wtqEkzx1b40IOY+X2TixC/8k5X2jYIKziML/PwC
	hz4H3d3uSEzsx6E6Lys2//hg16VOVZ3ZiikYBEf7weSSt+ax1G1scIJWQ/ZA/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=9/sheOM3O505WEl90eWHF3ugDs9kjENsFCU+PPXorJo=;
	b=VM1D7NMKVVGSxtSE3uxDgAwReMsozudliCPdHmtkr3nvWFQ7gGWkge8iK4frhFVgapk2ER
	Kd77kx7Kn246sXCg==
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
Subject: [patch V7 08/21] signal: Provide posixtimer_sigqueue_init()
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:39 +0100 (CET)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |    2 ++
 kernel/signal.c              |   11 +++++++++++
 2 files changed, 13 insertions(+)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -12,6 +12,7 @@
 
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
 struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
@@ -106,6 +107,7 @@ static inline void posix_cputimers_rt_wa
 }
 
 void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1905,6 +1905,17 @@ void flush_itimer_signals(void)
 	__flush_itimer_signals(&tsk->signal->shared_pending);
 }
 
+bool posixtimer_init_sigqueue(struct sigqueue *q)
+{
+	struct ucounts *ucounts = sig_get_ucounts(current, -1, 0);
+
+	if (!ucounts)
+		return false;
+	clear_siginfo(&q->info);
+	__sigqueue_init(q, ucounts, SIGQUEUE_PREALLOC);
+	return true;
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);


