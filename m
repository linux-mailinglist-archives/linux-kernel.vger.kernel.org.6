Return-Path: <linux-kernel+bounces-341479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB29880AF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6219283068
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02918F2F7;
	Fri, 27 Sep 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qIO9m7jt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GueneQV6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE218A6B5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426931; cv=none; b=roFUp1p/z5aeXR16Ueu7uSWDqk6Kv49iSUMAUullRxSYbX17rJw5ov0iybQ6TXJVc4nHjZe9elUTbu52Pxjgg3aSYCXbIJk8fCugz9Hvi+C654ET/3GrQWWQhj5yFkrAl8v9UoG4e/gK7Wf772KsJSiTECX02gSR9DWsIX3Y7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426931; c=relaxed/simple;
	bh=MLbvTApDwcn4rh7emeTMGx1Q505+q6MoicWj4Jh2Yfg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gUHrxWg1eXurPCZNm+3ulVHLt499JeWcJRgk0h9XNzlv2+fdYMtC2m1QS/EuJBImEk1T4G8IgsSN2pMtF26/ocWx1kbMxKL+W/YfZvKgzK4+k6HlVVTINpg8e6SlKHtJiPu5tnTCbBWrBe0l54WBgtr3lb1oV0lB4RpYD3h8fbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qIO9m7jt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GueneQV6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.261702549@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RKLyvk4kjAmxUrZnWrBzTvZjowh6Tz3OdWzxp5LVw2k=;
	b=qIO9m7jt5/Rz4bIHOp4HoOrRUPdYRn1H/rflE/7ySnjJBJ2GFeyDVUeQE83pkNGT/NgBr7
	28+dgzjEU3WR6hIm4OKx5JmmMp4jd8YE5CFYXnH3g3OuputP7i2rPGMm1bjIk/mGLHsM7J
	q8f3UkTh5moqRjB11UAk69Rq5Q7z+N5us4brmT2zO6b5EEf3DeVp3uJRGich3Puf7v9Eq9
	nN+bonrPZBfiEv3kjPYKY5OOe9wapnC/o3O5pD7dw6LqVAQg5a4br1umR0IPHK1k2vcX9L
	F1VtKRN2oD66W5tzPtCu5ChFJ3UbGKMP+h6D1RMfuh197gI2ojJSZ6uA+DR+2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RKLyvk4kjAmxUrZnWrBzTvZjowh6Tz3OdWzxp5LVw2k=;
	b=GueneQV6KCVq0cibTzXfN0LryZGhUik5kBmLoDGkTMjPHXccxJ+pjcHFyz5AzDDhKP1t4m
	/PajCjFQhSQnYCCQ==
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
Subject: [patch v4 06/27] posix-timers: Drop signal if timer has been deleted
 or reprogrammed
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:46 +0200 (CEST)

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


