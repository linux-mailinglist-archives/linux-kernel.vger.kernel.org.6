Return-Path: <linux-kernel+bounces-390833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1669B7EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FA91C2192E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E51C9EC6;
	Thu, 31 Oct 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvjsj344";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZRZznzC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5F1C7B62
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389605; cv=none; b=RcyCt0AqCELCx1UmP+K7b1RqI+a77LNFRyoWHZhtuxnYLbALshih3xfCl/zuLbGx3mHJgFvw+iLIZlFRhJRb7TN3+Nowme9dQTCfOLcPgmlxMTuyjIXR2mO673RdH1R05Xis4NGLIEkXqz0L36ETCG9PrBoLQoHLATgSCcH8s3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389605; c=relaxed/simple;
	bh=a7KcfJ0H5yG9o+hAQ68pX3T59R0HehkYopkBoSQyZYE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BNLDjTVVTYuSNgvqgKjW63JDaiYsWe+V0qFmJJyIqqr/tp6BWac+T+bBVmFk3giAIc4Hjl8xaBvfkVMD9Dv4wJB+7VRK1jOLns2qnhpy9/Akv6Owai7lOukTZGlQCJ+oHUE8WJN+dCzS3+nFiYFYYJrF+T7hRmurNVroBNCNxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvjsj344; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZRZznzC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.498474639@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RrNJyRQje7EybxKIECKyVfE3lGKZ40kOBzWpZXbTjgk=;
	b=kvjsj344D0SMtaztvIFUP9tSaiq2UKdQobo6n9JWHKIeVi+fR/F9iHeCF4DgZXPG4c/LKP
	lrV4KWafXAiRWllX1btSbCBxXc2Whzb8aP1rI4uKb2smBRU33xNihFMhnOBQ21Gz4/9cOQ
	2GVX4j1gKEpXcizqZXCjscdHbwWqE6lyITM9iDGqAkpMD2pLMosy6k/Sb6gxu+zzAJDcUn
	Z+rSfwVE81IRfrizgdd8mCz03rns2RJ5ygZDkQNDwxFNxrE9AZxV6Vr8/QKmV7kXXCh99a
	oTLpxAo2lzJZcyKESAmPxR8pRmNS0lnuhwO+cK0FQyMKH/raDvC3iKHqY5C+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RrNJyRQje7EybxKIECKyVfE3lGKZ40kOBzWpZXbTjgk=;
	b=oZRZznzCLA38TqeNegvLYHRYeMDO552GTQFKUokJhhuMHNLt6NG3yJDSANRvn/ytHyUDDM
	wEVSB+OpZuHcPuBw==
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
Subject: [patch v6 15/20] posix-timers: Handle ignored list on delete and exit
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:41 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V6: Warn when the ignored list is not empty after deleting all timers in
    exit_itimers()
---
 include/linux/posix-timers.h |    4 +++-
 kernel/time/posix-timers.c   |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -152,7 +152,8 @@ static inline void posix_cputimers_init_
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -176,6 +177,7 @@ static inline void posix_cputimers_init_
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1027,6 +1027,18 @@ int common_timer_del(struct k_itimer *ti
 	return 0;
 }
 
+/*
+ * If the deleted timer is on the ignored list, remove it and
+ * drop the associated reference.
+ */
+static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
+{
+	if (!hlist_unhashed(&tmr->ignored_list)) {
+		hlist_del_init(&tmr->ignored_list);
+		posixtimer_putref(tmr);
+	}
+}
+
 static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
@@ -1059,6 +1071,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1110,6 +1123,8 @@ static void itimer_delete(struct k_itime
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1142,6 +1157,17 @@ void exit_itimers(struct task_struct *ts
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers))
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+
+	/*
+	 * There should be no timers on the ignored list. itimer_delete() has
+	 * mopped them up.
+	 */
+	if (!WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers)))
+		return;
+
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers))
+		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,


