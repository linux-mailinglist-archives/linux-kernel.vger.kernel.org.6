Return-Path: <linux-kernel+bounces-552625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20860A57C19
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CD1884B5F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E81EB5E0;
	Sat,  8 Mar 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dy7zQdc5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GtJO5ZLJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAD1FCF47
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452509; cv=none; b=PNZv+sGwzSN9pehxKtw5T90RQqr8gthW2OLtTPTzga71Z5KE2I8iInCYgDjRfvmbCJYULqdS/z3yn6D61KLB2voSdDNrqWX9OS7/XzrXR7NrM+Wxy9sbFaAeh2DPENO9hrWRU7TRvBktSmzmZ6oaWTJ6yy3es/ZfOSPAHKeIq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452509; c=relaxed/simple;
	bh=mAIcgcV9wg8FHtqmfIumUc7LsU6GTAJDQl4M1SlYKn8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CyiXoi0gbuhjECc3ezMHtntwVvoh7BUD6vxDgxEE5JsLyz/vSAxMFTD7XMKvPn590ugov+kWndNQVu93apwl6dpTWWsBACCd9qKe7x/9FBOw3GueKq4IktBPVWgV45Vm6RKj2BV9ZJNOziY9ThBf17wwQXqy86RZ12ERlMs6zrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dy7zQdc5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GtJO5ZLJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.765462334@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SowdON3hohqcwgSzLKdo7RLzk5nlyhfHXImf0zgHVVs=;
	b=dy7zQdc5QVKR0TN+yrpq7xmW33s/8RqM3Hck6Ue/E8RqEPMdkH5L9raDcQqVaUnPHLl05y
	Sd5kWe6I33vA6JSqHTnfctFt9wEB84DzFUQuFp27v6vwy3N0Sh/CG+nGnuOqTLT5/TL5zV
	oyv7R/RXaKkvk5K9QluhU1P0RbtIQwRI5sthHqRRHDKPnRNUVLX6VPNKXMzjuhDRw3anjm
	iyM3CvgnZYzlYShpAYZ3yQa4DhzFaxK4CRqsmHSI5/IUhgeEBkuwbRkNHhr+7LTsJtc3Bq
	K88b7rJjkrbl1IpqiI1FmzUwPsaSyYIbgH52Q7DglfW7ErZPLxTKIJaB7nywiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SowdON3hohqcwgSzLKdo7RLzk5nlyhfHXImf0zgHVVs=;
	b=GtJO5ZLJjSvlL2aQtQhTtKWxtW8ZjRGRMsd0Rgpb2y00sCA/JdiLQt0ROI/YLM8b+/yXIl
	CHRBw03P13zJUtDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 05/18] posix-timers: Remove a few paranoid warnings
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:24 +0100 (CET)

Warnings about a non-initialized timer or non-existing callbacks are just
useful for implementing new posix clocks, but there a NULL pointer
dereference is expected anyway. :)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

---
V2: New patch
---
 kernel/time/posix-timers.c |   37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -682,7 +682,6 @@ void common_timer_get(struct k_itimer *t
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int ret = 0;
@@ -692,11 +691,7 @@ static int do_timer_gettime(timer_t time
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
@@ -824,7 +819,6 @@ static void common_timer_wait_running(st
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
-	const struct k_clock *kc = READ_ONCE(timer->kclock);
 	timer_t timer_id = READ_ONCE(timer->it_id);
 
 	/* Prevent kfree(timer) after dropping the lock */
@@ -835,8 +829,7 @@ static struct k_itimer *timer_wait_runni
 	 * kc->timer_wait_running() might drop RCU lock. So @timer
 	 * cannot be touched anymore after the function returns!
 	 */
-	if (!WARN_ON_ONCE(!kc->timer_wait_running))
-		kc->timer_wait_running(timer);
+	timer->kclock->timer_wait_running(timer);
 
 	rcu_read_unlock();
 	/* Relock the timer. It might be not longer hashed. */
@@ -899,7 +892,6 @@ static int do_timer_settime(timer_t time
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
 	int error;
@@ -922,11 +914,7 @@ static int do_timer_settime(timer_t time
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
@@ -1008,18 +996,6 @@ static inline void posix_timer_cleanup_i
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
@@ -1032,7 +1008,10 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
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
@@ -1078,7 +1057,7 @@ static void itimer_delete(struct k_itime
 	 * mechanism. Worse, that timer mechanism might run the expiry
 	 * function concurrently.
 	 */
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
+	if (timer->kclock->timer_del(timer) == TIMER_RETRY) {
 		/*
 		 * Timer is expired concurrently, prevent livelocks
 		 * and pointless spinning on RT.


