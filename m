Return-Path: <linux-kernel+bounces-208583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2F9026F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E321F21504
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780115531A;
	Mon, 10 Jun 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRGjbPfD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7/PUROh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD7154BE7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037753; cv=none; b=cv5yxTyWEnOlLtyGHAVR9vCO8ogmIrRFxMan/X55LoXInBqyq7vxYB19QEQtWt8VnKQDV3dT//NmoTIa0MeTETMILaDEhnpIzY6zVFVC9JigF7VVymA0LAz/Pbroo4q63K++Yu9JEjkQGa4uPJTJenxcVH40nQ700FYteTYbsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037753; c=relaxed/simple;
	bh=YN6n6j+MA0nG5Yheb3hxrtVPCRI7lZJF9lPKtB8/yQI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Af4SduirEJ5ML4RFeOfcCtwXPXXTOF2D7mapYsqYZSJUz3QIMV1SoOCf9Yu6nGSSLLau9OjDSnINuhU9zgCyLT+9GSohniLmi7QSYsSdRxhaJPPVGa+yyIHrN09eW1rihnDCBQmlJY15KcULGjggX2oFD+x+mFtKBMSSV3twPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRGjbPfD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7/PUROh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.745025149@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ITJ/+5vbw/2+B5QmAsO44YK98eSbLVo+fKwi2ezjk6Q=;
	b=PRGjbPfDH68t0dYNiy88B06M/VtRZ2xeiYHWvof/yK2r4hkGDCUY9L+c2a1GzIPXghtKBN
	cS/+35OnwtBi6DaugfsYZxWI7T4IlcIBI9V7VmtC/ryOz8LaFyJk/1yHJ/MCtPZqjV4IM8
	jUrJEhZOSam/akm93/EHE3GVclApjv+1VZ3kVND4m2suoTeyvjGP4LaN6nS2bXvb875pJz
	TUMe60atA6g83Vh4IR89cX0iH+bhrmYNH5yKlWU+to2OlLNlrsTTObUGamHFHQTns1XgOY
	VqEIJy7hZZqz1BzJfDzWmGWQVWlgaXOJNaPqLIN9Iew9P09sAVUbaga8Mnc6xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ITJ/+5vbw/2+B5QmAsO44YK98eSbLVo+fKwi2ezjk6Q=;
	b=v7/PUROh4vTq5uSr6p3pNSo3/dOWxos8/CxW93Ux5hgLxO1vQAAVpi2VqZ7t8aoe8EsUE2
	K9nq2MsHUGJlPnBw==
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
Subject: [patch V3 20/51] posix-timers: Consolidate timer setup
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:30 +0200 (CEST)

hrtimer based and CPU timers have their own way to install the new interval
and to reset overrun and signal handling related data.

Create a helper function and do the same operation for all variants.

This also makes the handling of the interval consistent. It's only stored
when the timer is actually armed, i.e. timer->it_value != 0. Before that it
was stored unconditionally for posix CPU timers and conditionally for the
other posix timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   15 +--------------
 kernel/time/posix-timers.c     |   25 +++++++++++++++++++------
 kernel/time/posix-timers.h     |    1 +
 3 files changed, 21 insertions(+), 20 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -714,21 +714,8 @@ static int posix_cpu_timer_set(struct k_
 	}
 
 	unlock_task_sighand(p, &flags);
-	/*
-	 * Install the new reload setting, and
-	 * set up the signal and overrun bookkeeping.
-	 */
-	timer->it_interval = timespec64_to_ktime(new->it_interval);
 
-	/*
-	 * This acts as a modification timestamp for the timer,
-	 * so any automatic reload attempt will punt on seeing
-	 * that we have reset the timer manually.
-	 */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timer->it_overrun_last = 0;
-	timer->it_overrun = -1;
+	posix_timer_set_common(timer, new);
 
 	/*
 	 * If the new expiry time was already in the past the timer was not
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -856,6 +856,23 @@ static struct k_itimer *timer_wait_runni
 	return lock_timer(timer_id, flags);
 }
 
+/*
+ * Set up the new interval and reset the signal delivery data
+ */
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting)
+{
+	if (new_setting->it_value.tv_sec || new_setting->it_value.tv_nsec)
+		timer->it_interval = timespec64_to_ktime(new_setting->it_interval);
+	else
+		timer->it_interval = 0;
+
+	/* Prevent reloading in case there is a signal pending */
+	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	/* Reset overrun accounting */
+	timer->it_overrun_last = 0;
+	timer->it_overrun = -1LL;
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -878,16 +895,12 @@ int common_timer_set(struct k_itimer *ti
 		return TIMER_RETRY;
 
 	timr->it_active = 0;
-	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timr->it_overrun_last = 0;
-	timr->it_overrun = -1LL;
+	posix_timer_set_common(timr, new_setting);
 
-	/* Switch off the timer when it_value is zero */
+	/* Keep timer disarmed when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
 
-	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
 	if (flags & TIMER_ABSTIME)
 		expires = timens_ktime_to_host(timr->it_clock, expires);
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,4 +42,5 @@ void common_timer_get(struct k_itimer *t
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
 		     struct itimerspec64 *old_setting);
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting);
 int common_timer_del(struct k_itimer *timer);


