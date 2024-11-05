Return-Path: <linux-kernel+bounces-396091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2C9BC7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE662B22B51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA962003D4;
	Tue,  5 Nov 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YnKll0YT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JKyXRUSI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F302003B6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794485; cv=none; b=KlcemzuF9ra1T28tyIL4SXQotnqX+MkxKuygCQ5ziRAc+gskLlAI8eMevnwTj4HIgaZsh7S0HJDNpqjoaXZ2zcGBaB4sjNR5R72GuohiYCEWE+e1k2Sm/gMVciczSBLjHTS+brParkworKc++dpCkCPiV93m4MNG9LOwxlY1fS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794485; c=relaxed/simple;
	bh=kiTXtVgw+U1qnp5FhuoXzBaBFn74/QO2mlup5NmMvn0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=piRfMj5jqFbgDs6yrEHxjGuOizM70z6cXyqY6Tc3l9qm+3gJBx8hZ2r/bn1tBdlrLfMj6D28t8Tt1yl2jyiDuV65Ga0riZBBySSUC+mdBf9ttn0E9hkjg10yMaLacQO0sDhLUr5a2Zvu4EJrJ2ZhAVKX33fLJVdDx1DIDGD5nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YnKll0YT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JKyXRUSI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.519086500@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gXCAblQOBPavs913jzKws+IyhhY6pcRYmrxp+julPVw=;
	b=YnKll0YTnDQ23LLLBjf0jUKNE8e+Pl6V/BPM3Jmz2yWb3ZfMa/B4QnwAh5T+fj0BV7+W2G
	a7XK0Ku8cLcdvgVMPB2Ll9DsfUxFxEY7QOEfH4K/aOI1PBDIvooogY6k5Vhtcornkpi0rM
	JpWc2w6YlFKX+1rszLh9rf2GZCxSozTbEFGw5v/stsqgzIqkdhVTfcbWyeoFXEmN4/jO7m
	UP++KQ0fcW9bLhU6E2hFteH2clqOiPOrW3Qft/11Mx/dOMqvI8rfJM2VFHHJav+deGYKpK
	3XYLYeVToGNSOZdcVEwnJNit0iILvO/ffRmcPrAbXGErN22R8zME5gv9Io5Y0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gXCAblQOBPavs913jzKws+IyhhY6pcRYmrxp+julPVw=;
	b=JKyXRUSImoE+YuH/QfobX7j/xJUFJiJIs1ZN+ftZ0dHPysqy+0vPNafqLdRzFgEwjyQIgn
	7ben3vLAuh6MjQBg==
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
Subject: [patch V7 09/21] posix-timers: Store PID type in the timer
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:41 +0100 (CET)

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
 


