Return-Path: <linux-kernel+bounces-390826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C429B7EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579BD1C20AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD01BE87E;
	Thu, 31 Oct 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODTkCO9l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iRxjzT77"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C241BCA0F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389597; cv=none; b=hLW0eGHgdZYJ7kwMJyzXWtICqEJ7RiBmWbyITuirn1HIwJVV06IzmPRInj8t+N1WKQb67B4RPInQva/zGDW3k+NhjoFOUPN67Eet78AwwxfQORx/YDuQjtyZGGLaQbT62quboLt550hfOs+BfujDk0DqbzJWLc4VBolmfv0LYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389597; c=relaxed/simple;
	bh=kiTXtVgw+U1qnp5FhuoXzBaBFn74/QO2mlup5NmMvn0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GqVhjhZnRzySTWQgpQnsP0wimBmy6Kw6709LgzWljTIdCfDxtkQLyU729OZz2dMieG4U7SRyU2ioscxWZJKCqVFotyJxy8f+i98Qv6ah6K/1dMaPy6P7vlrQmHNXQc3C57MuWPYVREwXwwiWvUjEee0DTDtws277bjYwbFJkM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODTkCO9l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iRxjzT77; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.055076296@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gXCAblQOBPavs913jzKws+IyhhY6pcRYmrxp+julPVw=;
	b=ODTkCO9lbiF7YyXL4WclDog76nRQbAr8BC2mFv0rOWH3m86P3iSEzH4qOrav4j40pEy+Lu
	IJIMUscEczIA2uCZzzwhiC+BFbpcgKOK7HEBL3hra2l7dVxfdiDs0s0G51e6IxjufAWGtJ
	XOOy8IxXUWNhLPYWpB5ajstTD89MA9iU0by3S17VD+I03h8aFhJKgHSue4e7jXNJWnfU4Y
	PHtOZwXN2sU5qdjjcGJIFAFZ1900EuGlyuAdwtu7QFfWvFBJLbiOMH1uABAGpFJDi9PXF3
	E5HmpF6UVJ0c6if7q+ryeGwwyZc2lIDI8ZMYEKa9We102QEOOPl4aMolgL4Kiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gXCAblQOBPavs913jzKws+IyhhY6pcRYmrxp+julPVw=;
	b=iRxjzT778+AmaiL1UV3Z5ssMfRyuclXzmGLoixS4WpmarFBzC/yhpmBkBZfY59xp/X8Y6L
	BH+Yj9KS1BV4adAg==
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
Subject: [patch v6 08/20] posix-timers: Store PID type in the timer
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:32 +0100 (CET)

instead of re-evaluating the signal delivery mode everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |    2 ++
 kernel/time/posix-timers.c   |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,6 +5,7 @@
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/pid.h>
 #include <linux/posix-timers_types.h>
 #include <linux/rcuref.h>
 #include <linux/spinlock.h>
@@ -180,6 +181,7 @@ struct k_itimer {
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
 	union {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,7 +298,6 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -308,8 +307,7 @@ int posix_timer_queue_signal(struct k_it
 
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -496,6 +494,11 @@ static int do_timer_create(clockid_t whi
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type = PIDTYPE_PID;
+	else
+		new_timer->it_pid_type = PIDTYPE_TGID;
+
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 


