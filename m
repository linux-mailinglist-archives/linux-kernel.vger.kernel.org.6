Return-Path: <linux-kernel+bounces-540748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E7A4B477
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD6216D2CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627951EFFA2;
	Sun,  2 Mar 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TG6vcHbT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCnS3G1V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B441EF38A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944223; cv=none; b=QtrwkV1B5oU6+crcaYd05dggMaZFTYU8HaC8ASowreVG3qoSfuuPi/CjI64F1qRRUCNqO7wMmIu1Sp0R4zghwnjMECE6ppXCyszqCA18uys0djg5xDey0o0HkaZo9NNOJrsfoxMiQc3wKe7ETkXRHfKaqcaZVQYXAvC8s6RY0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944223; c=relaxed/simple;
	bh=ozLgWlnWW1qGcVv1VhQ91QXrKtsv7YuN2YdSlFVFPY0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pUZu8mB2vR0XAzgx53lnBaTTjHm57dY9PP7scmHQsiihJZ/IrCdhaHxIkYW44OPrR9JHl9jz7lVCXI65/gMqwSegy4oDTvYgMkOa55g8Wx3ZmsbQUdzRNc2WltAafMamHYNWmhCHQytGpv6H8Tu6oEFaros76cAY8elSAfPlENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TG6vcHbT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCnS3G1V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.543399558@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=I3coZdNMcVaNaxvXTVu5YsAG2ik/WdCO4w3UUsUch0Y=;
	b=TG6vcHbTsLVOuNPf+tkBFMC67mI6CqwR9e3g+glfJYgs7XuDp7NvmDBmvQQSt9eFiQAjei
	naVGvhZpC8ipRKF78MrEoBYppbgYRcluJn8NjN168erZGT99RMCWdNyFErxvacZXLFSAy9
	JFUEpgX3VNmE5sL+/U4sDTVb62BpK1j2EFBU69iJQtttCuSWjARfdkRHVns+mgIRYHS66d
	1eCGy7u62LeFVnqy0XszlMtLb31CTbwFoP+q3Xs8ZzX7Tw3yrloSin9BuqgoJdi7mfUJsh
	GBIIsqRIH64tbQYtBmG5sIadka4hrZ7eDcPvALj8VR5IK/5+MMmzjeEMmrF+Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=I3coZdNMcVaNaxvXTVu5YsAG2ik/WdCO4w3UUsUch0Y=;
	b=dCnS3G1V42ksHT5eyAkf73lEpkrglzlupYSNfjFf9JEYe0tJo0BNxOSVPseaJheZVhKUjn
	GY0UDBcLNlicLVBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 10/17] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:59 +0100 (CET)

From: Eric Dumazet <edumazet@google.com>

The global hash_lock protecting the posix timer hash table can be heavily
contended especially when there is an extensive linear search for a timer
ID.

Timer IDs are handed out by monotonically increasing next_posix_timer_id
and then validating that there is no timer with the same ID in the hash
table. Both operations happen with the global hash lock held.

To reduce the hash lock contention the hash will be reworked to a scaled
hash with per bucket locks, which requires to handle the ID counter
lockless.

Prepare for this by making next_posix_timer_id an atomic_t, which can be
used lockless with atomic_inc_return().

[ tglx: Adopted from Eric's series, massaged change log and simplified it ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250219125522.2535263-2-edumazet@google.com
---
V2: Use atomic_fetch_inc() - PeterZ
---
 include/linux/sched/signal.h |    2 +-
 kernel/time/posix-timers.c   |   14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,7 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	unsigned int		next_posix_timer_id;
+	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -118,21 +118,17 @@ static bool posix_timer_hashed(struct hl
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	struct hlist_head *head;
-	unsigned int cnt, id;
 
 	/*
 	 * FIXME: Replace this by a per signal struct xarray once there is
 	 * a plan to handle the resulting CRIU regression gracefully.
 	 */
-	for (cnt = 0; cnt <= INT_MAX; cnt++) {
-		spin_lock(&hash_lock);
-		id = sig->next_posix_timer_id;
-
-		/* Write the next ID back. Clamp it to the positive space */
-		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
+		/* Get the next timer ID and clamp it to positive space */
+		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
+		struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 
-		head = &posix_timers_hashtable[hash(sig, id)];
+		spin_lock(&hash_lock);
 		if (!posix_timer_hashed(head, sig, id)) {
 			/*
 			 * Set the timer ID and the signal pointer to make


