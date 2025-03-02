Return-Path: <linux-kernel+bounces-540742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37241A4B471
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372481891838
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBED1EE7D8;
	Sun,  2 Mar 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFoW7euW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLoS4666"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60411EE019
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944213; cv=none; b=hTA/9zZc6Lfpx9H45zPDQNDNQOOAj/nL67tpVu21gJar3MiIsyrO+wToIGsDcdYp3INQUF2tBigHhfw5jQEX24N3qc7mmelyCB1rW0uAY4k9luxC0b8O8s2/pQ1FJmepn6Jr6LpUv7+/b4UrQ/KjMzss03R96vmDxdohewG3W7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944213; c=relaxed/simple;
	bh=59v/7acbCAwAzZHnQfrmUcEbnZngSTtR+DG+a0iztGA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fRCN48bxvKR/lclr6ffQgfhjT64zdSI9Ty/ZUMfdM5caRDPCPlkug7tH0IntgCKLmmm+zHjp2RA1wFEJYboLKONvvw1pIwnzyKENOO195gC0uV/cFCG61V7WApiLKQc+Zzy4X2pIrhZ+V/l3zfzJMaZdKIN1MFWKwm4m4EwCRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HFoW7euW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLoS4666; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.167378648@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=93tD0GtpcIGIW0gpAOkl8thP4K5eE8qN1mEpJfkAGDw=;
	b=HFoW7euWwQhoTZf6CFebTcMRgy3Uk/b1SQXeVyh+vr2ECFNO9RWke2aEfGLFi4d74ElvES
	f9r/T9ikU70vqGdVpwZlmBovLD1+Jr62c4/dyinVvFObmQstVQG4XDia3pK7t5LDCvqnZt
	DvHLLgR8u9vgvWocohgieEDcOIQfOZ79V0l78JXZ9b47jZ5sQh5Bb2EncF/52JnOqBgHVx
	sto4GZpE7+DsxqWkS8j7ahrv7rdvsY71HhC3rvngjDqWDkjX6F3SYzdgnrIl2vK0A+oUC+
	riNbvKq9cqnMkhzoWgfoRi9n0zj7J3INBoHabm+ZIQ0QMBcvxMFeWMsfnjiTog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=93tD0GtpcIGIW0gpAOkl8thP4K5eE8qN1mEpJfkAGDw=;
	b=sLoS4666GSV4BgRmf2FsmdT/zV0bappJMxwM//EU2Yyw48rqe1qtJBtxaSA3iLPVpe3JM5
	M5lElbgeX7T8BvAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 04/17] posix-timers: Remove a few paranoid warnings
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:49 +0100 (CET)

Warnings about a non-initialized timer or non-existing callbacks are just
useful for implementing new posix clocks, but there a NULL pointer
dereference is expected anyway. :)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/time/posix-timers.c |   37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -675,7 +675,6 @@ void common_timer_get(struct k_itimer *t
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int ret = 0;
@@ -685,11 +684,7 @@ static int do_timer_gettime(timer_t time
 		return -EINVAL;
 
 	memset(setting, 0, sizeof(*setting));
-	kc = timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_get))
-		ret = -EINVAL;
-	else
-		kc->timer_get(timr, setting);
+	timr->kclock->timer_get(timr, setting);
 
 	unlock_timer(timr, flags);
 	return ret;
@@ -817,7 +812,6 @@ static void common_timer_wait_running(st
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
-	const struct k_clock *kc = READ_ONCE(timer->kclock);
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
@@ -828,8 +822,7 @@ static struct k_itimer *timer_wait_runni
 	 * kc->timer_wait_running() might drop RCU lock. So @timer
 	 * cannot be touched anymore after the function returns!
 	 */
-	if (!WARN_ON_ONCE(!kc->timer_wait_running))
-		kc->timer_wait_running(timer);
+	timer->kclock->timer_wait_running(timer);
 
 	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
@@ -892,7 +885,6 @@ static int do_timer_settime(timer_t time
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int error;
@@ -915,11 +907,7 @@ static int do_timer_settime(timer_t time
 	/* Prevent signal delivery and rearming. */
 	timr->it_signal_seq++;
 
-	kc = timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_set))
-		error = -EINVAL;
-	else
-		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+	error = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
 	if (error == TIMER_RETRY) {
 		// We already got the old time...
@@ -1001,18 +989,6 @@ static inline void posix_timer_cleanup_i
 	}
 }
 
-static inline int timer_delete_hook(struct k_itimer *timer)
-{
-	const struct k_clock *kc = timer->kclock;
-
-	/* Prevent signal delivery and rearming. */
-	timer->it_signal_seq++;
-
-	if (WARN_ON_ONCE(!kc || !kc->timer_del))
-		return -EINVAL;
-	return kc->timer_del(timer);
-}
-
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
@@ -1025,7 +1001,10 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	if (!timer)
 		return -EINVAL;
 
-	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
+	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
 		timer = timer_wait_running(timer, &flags);
 		goto retry_delete;
@@ -1071,7 +1050,7 @@ static void itimer_delete(struct k_itime
 	 * mechanism. Worse, that timer mechanism might run the expiry
 	 * function concurrently.
 	 */
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
+	if (timer->kclock->timer_del(timer) == TIMER_RETRY) {
 		/*
 		 * Timer is expired concurrently, prevent livelocks
 		 * and pointless spinning on RT.


