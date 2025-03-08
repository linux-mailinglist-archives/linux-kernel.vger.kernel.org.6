Return-Path: <linux-kernel+bounces-552620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15FBA57C13
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF263A8705
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9C1E833B;
	Sat,  8 Mar 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtbwUOtM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SVLGgAl8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64F1DDA2F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452494; cv=none; b=i4tHqgHodV3owGQ1OqvdJnLH+QMHwb8TIjdOOjJQoUc8GLaO/b75iTwiWfvmAvDVmjJ+uveM7ss/GQETzd6M/XLXqHxviS0PJfzZRbCPRPWDt5aDlEc4q7GcghIgPMshgeQMPdh8b9wC0AEc6kWD9IPtGO6Cx2SaMXjeigdxIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452494; c=relaxed/simple;
	bh=gdUh6CAXH3yzXLba7xsiAqD/Eh4CmHcPuqJYcfDoLMs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YdAipQNVqMzOk8jtCmEaym3fAi9WWi96xxXwcxICKCF8ut74jqlZSjLnNbvCtph+JWpyqNDM/o0QIfLztNh2p/si63qKHo7Pf24dEZ9DgreC9brcAcBN6yElDzwTkvLndtMmm6ZlRi8AXaL7undzQE+T+k1pwVJdcP5AM78PjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtbwUOtM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SVLGgAl8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.507944489@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5Os3CrMG/mRgyD9Z6cJdOv4unBixPmwKfFPCjJq+QzE=;
	b=ZtbwUOtMvGYQrLDBvDd0Q5hgZwm/Y6kBhsLJqgGFRU4lCYNpskPY1QC4b7L3Cq9miD8V0c
	xuBo0E+8M3hgvPFDHnj6H7KZU/GLnuQaMONBDHU0QhWiSLu3YjQ2JlscIi1YGbOHc5ytvk
	qMN3Rqhx2+uk323eFRgfwtqhy6+z+l9Pb8k4pUH6jXr1Js4fqm07FjFhj88+8q1a9UnKKJ
	+3HKvTyx01H3K5xGRChVSUSV83nTeBI5nSPh6qSwMYUEMKOg82hPduhlLoiRhSTzOFKpB6
	zKt2vr9D66JsG5vAAF6MYMaBduJXpmyfkPZMNU1fpjk4QML7h/bXBiZV6eKFgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5Os3CrMG/mRgyD9Z6cJdOv4unBixPmwKfFPCjJq+QzE=;
	b=SVLGgAl8EnGt8ohl70qITlw6mt6kZmbk4U+z3Ux/EMsVO+18rB9n5EBTcENEv9SbOHv1qm
	nuIs6Ocmy/wn42BQ==
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
Subject: [patch V3 01/18] posix-timers: Ensure that timer initialization is
 fully visible
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:10 +0100 (CET)

Frederic pointed out that the memory operations to initialize the timer are
not guaranteed to be visible, when __lock_timer() observes timer::it_signal
valid under timer::it_lock:

  T0                                      T1
  ---------                               -----------
  do_timer_create()
      // A
      new_timer->.... = ....
      spin_lock(current->sighand)
      // B
      WRITE_ONCE(new_timer->it_signal, current->signal)
      spin_unlock(current->sighand)
					sys_timer_*()
					   t =  __lock_timer()
						  spin_lock(&timr->it_lock)
						  // observes B
						  if (timr->it_signal == current->signal)
						    return timr;
			                   if (!t)
					       return;
					// Is not guaranteed to observe A

Protect the write of timer::it_signal, which makes the timer valid, with
timer::it_lock as well. This guarantees that T1 must observe the
initialization A completely, when it observes the valid signal pointer
under timer::it_lock. sighand::siglock must still be taken to protect the
signal::posix_timers list.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -462,14 +462,21 @@ static int do_timer_create(clockid_t whi
 	if (error)
 		goto out;
 
-	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
-	WRITE_ONCE(new_timer->it_signal, current->signal);
-	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
-	spin_unlock_irq(&current->sighand->siglock);
 	/*
-	 * After unlocking sighand::siglock @new_timer is subject to
-	 * concurrent removal and cannot be touched anymore
+	 * timer::it_lock ensures that __lock_timer() observes a fully
+	 * initialized timer when it observes a valid timer::it_signal.
+	 *
+	 * sighand::siglock is required to protect signal::posix_timers.
+	 */
+	scoped_guard (spinlock_irq, &new_timer->it_lock) {
+		guard(spinlock)(&current->sighand->siglock);
+		/* This makes the timer valid in the hash table */
+		WRITE_ONCE(new_timer->it_signal, current->signal);
+		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+	}
+	/*
+	 * After unlocking @new_timer is subject to concurrent removal and
+	 * cannot be touched anymore
 	 */
 	return 0;
 out:


