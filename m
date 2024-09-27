Return-Path: <linux-kernel+bounces-341489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE199880C9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FEF1F22B22
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB091B1D7E;
	Fri, 27 Sep 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EacqyRwx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z2hN6d6R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4C1B1518
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426939; cv=none; b=KHDPJb23sIAwaT9baisSu7Nf/nnm0Za0osuxIrzGszJCSSsAiTUfNdSuHm57GuSldi3IExO0Td6toV3QSbcGc1pGrC1MxYXnpnfhcOD4cDSFC3CcPMHu55123xH8anGxfSL4FbaFi/IlJ68NbJucLwjYRoDo2gsGeyqwTf3q1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426939; c=relaxed/simple;
	bh=Lv8sWAH1reiYtjOeVwcDxBTN4hpZA4BEb9kDGDSeenY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rxwW+IOIGnep1ONQM3NC2L0KfbAxhH3m4r3+ZvMA8QYL+tbUmhvi/HnfC83cKbVfztTczrPsdWpMlNm9Mo3FtDfhNyAK26H3sOAT1wTCIgK/T8a9+IuMRiWKy45NBAgoiXJmWQzl7y2LiE34J2vuvqSQbuvRukswF7bY37E3e04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EacqyRwx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z2hN6d6R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.757075875@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CGcYe5MF339xP0ZdHat0PZB/Z0z3pouUAaoRRU1aupE=;
	b=EacqyRwx9nAeM31BglomV+QxI+23tza1QsfPg4rUwTLi7Fp1qUmJb70L7KHc4cqoF3iweO
	FVuu58qtlsDhjrGltKTKdG7NNd7vWjAoy1fesvck5Rv71H1d0G43Ds9mPRHYnlTJZqONeS
	/GDQNRr4WElRJojyeKYDziAejecSO5mGFkth4nWaxVNCb/Mj8lfesbeA1b0pSWeSjvu0uG
	hmkq2Y/4U34gyze4VsBpRY3KYZcDGEAVp36wrBa3d8eW9Y5KNASVDhIUN1qWxkZhLWu3Yt
	0ZkGVLKv42sSFpToiIHq2/2wfeWQlhl0NwD3sbXlt4bBWrk9NnJ12L2/oRSXwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CGcYe5MF339xP0ZdHat0PZB/Z0z3pouUAaoRRU1aupE=;
	b=Z2hN6d6R+Y/YtPYp5sfHiZN+UMbkOiNcyzY2A3+W08JrjK0o85xye/986OFoRIcAS/E4YO
	vHd+dE0BgVsYAiCA==
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
Subject: [patch v4 14/27] signal: Provide posixtimer_sigqueue_init()
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:56 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Provide a new function to initialize the embedded sigqueue to prepare for
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h |  2 ++
 kernel/signal.c              | 11 +++++++++++
 2 files changed, 13 insertions(+)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 9740fd0c2933..200098d27cc0 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -12,6 +12,7 @@
 
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
 struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
@@ -106,6 +107,7 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 }
 
 void posixtimer_rearm_itimer(struct task_struct *p);
+bool posixtimer_init_sigqueue(struct sigqueue *q);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 87c349a2ddf7..a857f6628e77 100644
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


