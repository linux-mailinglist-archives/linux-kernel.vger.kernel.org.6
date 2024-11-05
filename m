Return-Path: <linux-kernel+bounces-396097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AF9BC7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF411F22413
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607FD2022EC;
	Tue,  5 Nov 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7duRUy2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ImNe2VCH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280720102C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794493; cv=none; b=miTYyCxK/9DYytYrXfC3VtPnU35H20PrT8gLTxX2Aw75IPKW4JEfQJRtt3Q8aznkxbsI7W06qOOF9z8hI+5IMCHkk2dNzgXrOAtmXT1GvDf4b1gKsRoFrwngfK7VzpI7vpuCiknl+mweYxdlfopcKjleJOUiPHSqX1wYPj2uuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794493; c=relaxed/simple;
	bh=+lUP6TsMuqE3IqXpPLjwkfLL0Lw7iNcYZDOIOAM353A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nZ8a+J/llUl0cwstZkS01C1t3bqGuw5tPVJirhDDMaykBQ9CIb3T+R6Ctn4cbGYoJQicwlz+AcesVqk1CTlzXmA201y6kP5e2LUnZLxH2LrqNoamu6tbn6iSERX6Q/nbbmsaejuSKVlyN7O8qcRkZ0zcbsMLPcsOpsPSoFq60e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7duRUy2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ImNe2VCH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.920101900@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P5v7WakqlAk2QTAVxuUtUxQppzdrdxi6ddqN05QxfAw=;
	b=e7duRUy2ja5n3OFkqqyrEfWry41eyTVX9V06iaU8Xc35RcN3yvQHJfJ0JXBkasD7z07l6i
	wFc4uOr3Tr29DjLo6BOgciF6sHzdljhkq6Pe2QA+w/DrC6FdhRYLD9EbYJk672ZyUJMAvr
	/l/Mcg2BiHVbcsRUKg4di6zRmjBh4ob2J/oERLBnEbywkYF1LeAqj986AKmJRE4c6dSb8R
	n3AOUyMioC/yXunJUcDTviAeGAiOaMxY/KsCdLDfoCdMlKfjaOnajiysO8Zmd08CEfJ+PD
	0fRoYanmtQGwsI92g6GIRtxpwkaPaOXLTcTefEFx2FvpIy+m6TcxGCDDeb8Pgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P5v7WakqlAk2QTAVxuUtUxQppzdrdxi6ddqN05QxfAw=;
	b=ImNe2VCHZ6/cJfoZGYj2okHMNNNzSFoh+vXeEk6r6iYpU+hxC7Iq2Q3q9+2d6LkkLmaj5G
	msTU9Fj0LXflZpDw==
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
Subject: [patch V7 15/21] signal: Provide ignored_posix_timers list
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:49 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a list to task::signal.

This list will be used to queue posix timers so their signal can be
requeued when SIG_IGN is lifted later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/sched/signal.h |    1 +
 init/init_task.c             |    5 +++--
 kernel/fork.c                |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
---

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -138,6 +138,7 @@ struct signal_struct {
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
 	struct hlist_head	posix_timers;
+	struct hlist_head	ignored_posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,9 @@ static struct signal_struct init_signals
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers	= HLIST_HEAD_INIT,
-	.cputimer	= {
+	.posix_timers		= HLIST_HEAD_INIT,
+	.ignored_posix_timers	= HLIST_HEAD_INIT,
+	.cputimer		= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1864,6 +1864,7 @@ static int copy_signal(unsigned long clo
 
 #ifdef CONFIG_POSIX_TIMERS
 	INIT_HLIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->ignored_posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif


