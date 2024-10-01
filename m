Return-Path: <linux-kernel+bounces-345542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7676498B759
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220551F234FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61801A08AB;
	Tue,  1 Oct 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LwUJbF3x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KxnKYeXg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFB1A0700
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772142; cv=none; b=ODqPuka4m51zDFlKt+5lgloZZIpNfdfdakLSlWIR8oQNK9Hnh4nPAjpKXbRO6Iv6OPr03tAucbEElLbh37vyQcRmcpLBPMIiLTjmm0FxcIzlHTy7oe+lEl/spyCdqGgh3Ua3rXEtzIdLISm9Kv6ISoeITENLbCA9mJet3MQj4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772142; c=relaxed/simple;
	bh=ZOV4sBmQvu5WnM1Ox4USoRdNSskissu0mQH2/ZcAE2E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GusL2AEdZdXFIjLIM42UGjdN5/rFAkJjp43SLSaBlclhANUolqUGdJLbVvXCg16szAfyncY0n300UyI6kz9m/Fe1jarlfkG3Nbl3zTDtKdKfxdGc9xaorOwk8/IC+TGboLRxWkpnQ1VS0jOvCPxbUo3GxAnrOkFlwcJGZHNmK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LwUJbF3x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KxnKYeXg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.102492808@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dGpTGihaHQGMy4+Fr4d/sm3whGWzpjpkdI/lg0ei2aI=;
	b=LwUJbF3xtlQQzb1PhsyBNTR+J2CoFyfxmPgMtrJd/ct8xYP5c0N8b+2J54b8W9XauvPyXk
	u5maMfZvbC54cDOgSCj5tRgaKTLmO6ZFpZlYzGJh20p7BS7SPWWSgtyH7s/DtLjCT6+eqp
	yKJgZYteqinZlbrMPS4JFuzeGpIpWChyK7OHc/MulY9sKTnKmyVbMsDiLUdCzYhiHmQQjR
	/T9lSFcuQPJq8fV1ldLfgE16J3YHlyDaK22ExB4ODqtF3bFb2WivM4+ZR7mpBJ1k88exs1
	8DyLzRZL7agjZspP+OZYcNlNbM+sz9uIheUq7mfcIVFlPFv4Umm4GSq+sFgJ4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dGpTGihaHQGMy4+Fr4d/sm3whGWzpjpkdI/lg0ei2aI=;
	b=KxnKYeXglxAAaf1ipPB/tzVRdwI6N5+o+H/WJyRqtmp/cDcFFVEHiH/rECYnJ2f6Bl7G5n
	MExewqUvnidwhiAw==
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
Subject: [patch V5 14/26] posix-timers: Store PID type in the timer
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:19 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

instead of re-evaluating the signal delivery mode everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -297,7 +297,6 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -308,8 +307,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, timr->it_pid_type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -503,6 +501,11 @@ static int do_timer_create(clockid_t whi
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type = PIDTYPE_PID;
+	else
+		new_timer->it_pid_type = PIDTYPE_TGID;
+
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 


