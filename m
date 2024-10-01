Return-Path: <linux-kernel+bounces-345533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46598B750
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BE1C20CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9D19E7E0;
	Tue,  1 Oct 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DPQjWPZl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Fzl19jD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FB19D896
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772129; cv=none; b=h8ez9+UkVsHfxq9dXoqre3puN/c5fecHgz4uv6OepnGs3Lc5J5o5FSdDO89cqWIzYpq3VqHPFRxr4KI6ZtfTwmq9DkK79uGjlYBM7almoh2GvhIWwa2RK22yyLa7moPQp2oo1m9azJynZC1gFDzBHquOAIEc4NjmLgVA+UTf1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772129; c=relaxed/simple;
	bh=lbAJsxEIBuEi5j1fxs6XlVgx5F/bE/5BIwwAUQBVOy8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HzMNtPMVPMo8zroJd92Capt8h3xD26f/fEihbkmn2JXNELSmuzMDbjOM4fJEBEkV00P3gJfCv1RJKUbL315HgP8CofdSFSfe51mUD/np3myaqS3Z7ve5o7BeMWPt33G0B7a/nbFetzAY9OChzfvCQrT6zYy7g1NmRj94MkFgyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DPQjWPZl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Fzl19jD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.553646280@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5PUBsJTvJ1KFQG92jonGbwEiSpgHpeT/5KITtDrmIx4=;
	b=DPQjWPZlLfZ1hi4UA+/Q0yu35uFVsLCUcvqKvlebPnATvGhm+6M6P7ejGlPfmFkT7lTyGR
	DcVj0jGfPxyVp4jVxQw6bII6cTawGbXEKH2VoYgD6g2daNDGe5aQ9NWKBhHs6+NUtBPSpg
	YoC+AeeHquPJSZleHFyjQ7+YO36wD0k2u80xu139TDarhXzIAQEbjHK1i0MFLVcsGBOVpI
	DK2XVYglM/8tly+xdwpiryMh2f5efKuO2WAyspZmJgu8Tb0YSMnRrK0vCIBP7FZ4cR193W
	jooTeUQQjM7mJIDAZUFQ6i553mus2ZP0dWzgtEtH6+G1wSshxQFP83vKWM/M2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5PUBsJTvJ1KFQG92jonGbwEiSpgHpeT/5KITtDrmIx4=;
	b=6Fzl19jDE8EcZl/Lgh9d6HVkLI8SNke7RvmP4BXJ3asN2+L2wyCOmynufUFiNf6TKLb6M2
	Ci8J8hUGSRcUqMDA==
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
Subject: [patch V5 05/26] posix-timers: Drop signal if timer has been deleted
 or reprogrammed
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:06 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

No point in delivering a signal from the past. POSIX does not specify the
behaviour here:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed.

Drop the signal as that is conistent and understandable behaviour.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/posix-timers.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
---
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d7ed7542f803..b5d7e71c10f2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -250,14 +250,14 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
 }
 
 /*
- * This function is called from the signal delivery code if
- * info::si_sys_private is not zero, which indicates that the timer has to
- * be rearmed. Restart the timer and update info::si_overrun.
+ * This function is called from the signal delivery code. It decides
+ * whether the signal should be dropped and rearms interval timers.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
+	bool ret = false;
 
 	/*
 	 * Release siglock to ensure proper locking order versus
@@ -279,6 +279,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
+	ret = true;
 
 	unlock_timer(timr, flags);
 out:
@@ -286,7 +287,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
-	return true;
+	return ret;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


