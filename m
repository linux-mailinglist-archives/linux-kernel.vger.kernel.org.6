Return-Path: <linux-kernel+bounces-540752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C265CA4B47A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5447116D221
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202101F0E2F;
	Sun,  2 Mar 2025 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+VJcNjO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5RuDy35z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB781F03F1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944230; cv=none; b=WOPG3jwQA11ii0q7eJw43zCKYk3imPmnQgJ8GvMyHeNWPARbwZSUOpW07O++xN/nOJ+uWNuOdQ+aEAhkTHe6He32KjIGzftBBmZMmYy0ipxwtZVYWN3rCDNq4MdjfcWsi+JS9bakGqnA8WyQYBmG83ylXec5CFQlfHGj8+6DQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944230; c=relaxed/simple;
	bh=qXpFVgf2+2JUiKQvdmuu5fwT++cRBSrieXNRvQPzQzY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=EyK2dwZEim+jTqJmtyu/5cwMzu3ini+vIDXigH6nzvFBH/lSHA+GOEixhBO/Yw3mxGkmkaRASk2j3GM/SelYwDoI1eZ9cbF9KFb3VmM0TZv0hNl+tF6JcgKJmV2lxOQr2LMYd46CP8q9JfLI9bY33JRGDbXhf49TDn+VI02vLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+VJcNjO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5RuDy35z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.792792199@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0n0+ojMJFh6Wn1lejikAH+TEQYW3S7ZwZSQhOekwXGE=;
	b=W+VJcNjOl96kL1LOMW29kgMDXo+XSY/5uqaskBojo3AdeAYXw4zyADdfQZ0VubCl1s+lxO
	rjqagKrdCT2gVmPx57+70sm1MUkTlIJy5F1/dNr7529obxiMtI+lF78jvuqNuPIse7RZou
	/F2KSRq29IH9WATs7lB1QfZykCd/XhlgpnTLwNPyNDv/Ne3t2kxJaQdMwd4KICYqNlKuDg
	MKZLnhR9q64uNnpRKJ4qBBzL4HKWYuMhe+FFLmSYnMDdp0rB9q3ckeFW/+GqOjE1YbjSE/
	qNov+TG0duFFsXLOJ17hXwcHiS3gjpH0CdztVBn1vB4zP8Ww4wYoaBWGo06x1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0n0+ojMJFh6Wn1lejikAH+TEQYW3S7ZwZSQhOekwXGE=;
	b=5RuDy35zjS3mb33wZ+tNxQnuhHXQ9IK0/USfvBLcNkb9bUHaf6NBQGM35AlGFuWPx5HoCf
	08FrJHcslLjqEsCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 14/17] posix-timers: Make per process list RCU safe
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:37:07 +0100 (CET)

Preparatory change to remove the sighand locking from the /proc/$PID/timers
iterator.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -510,7 +510,7 @@ static int do_timer_create(clockid_t whi
 		 * unmodified signal pointer to make it valid.
 		 */
 		WRITE_ONCE(new_timer->it_signal, current->signal);
-		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+		hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
 	}
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
@@ -996,7 +996,7 @@ static void posix_timer_delete(struct k_
 		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
 
 		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
-		hlist_del(&timer->list);
+		hlist_del_rcu(&timer->list);
 		posix_timer_cleanup_ignored(timer);
 	}
 


