Return-Path: <linux-kernel+bounces-208585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695259026FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AC1F21D56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA895154BE7;
	Mon, 10 Jun 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/QtOnsL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RpXGGtna"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCF15532C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037756; cv=none; b=RrB4t3MguVIvYN1CVab9c9G8rD2bbtzxzixqOUZ41oiOcQ3qCjJ3UjRHUs8zUTmh8sMa3sHSjpFTdTQuIXqTW6aq+oWCWpdL0wyhnZya7+n24R93FG47yFqjauHVQ6MlZ3bR0jwUkfzUb9FSlPoaD+uYYC1iRUFZITuU+kS+4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037756; c=relaxed/simple;
	bh=vhFqJQGzuzFxet5n8aXmRbKfqxdROxlKhbpES6yLgrw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mDQ3f+qDXEbS9ty57abXLrwYUZzOpkkU+FSH3lu4Bc/iCkLpf6slg2O8G9GMbgYpDQXLy62rRfHXiMN2xxdaSMMXClFJjLapct5RsIUGkM6o0X2Z9KL4QxTF0OhNWhGYhmBX82+w4lbU8NoQ8DaaxFS5gsQvcn9sU+Kap3mcu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/QtOnsL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RpXGGtna; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.806827615@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ftWWtT5tkPA9yVyOVqrZETMprBLvt80uYl9BSpWJ448=;
	b=d/QtOnsLXwSrRyD4OQFjbIWOO9L0WzgvJMrFQGNL6KQP87UpFEY1RFRj8PC+PhVaO4rt8L
	xNSP2IpyhWJjzpHShGWc148GPKN3Hg5mP8UdFCH63+xZ/q+GEB43POzUiVCtabVXWVRsY3
	J4Bf12YfNFyyqHpheXqAB+njkJ7bRvzzrilpXXncQHWfi6fZB3FNVwQ9pZUUkAVKZYbRyu
	Lems3DOVkFWV8+XGBH0rjJnKUmH1cwJSwd5tbJi4gW0rHCrtTzKZjCd33IAihb4qv/jbil
	tuhVOfQK2pNBJeuoiTlLuQBBEfSJP6pjbIYAjvT6RlZG1zakVPGgLBzdS9jhCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ftWWtT5tkPA9yVyOVqrZETMprBLvt80uYl9BSpWJ448=;
	b=RpXGGtnaW6cMxPb2HqkPy4S73HLLyYlLKCi+DZ7ybVHtpoEr1TBWUiZ35Yc4yjIeMtY8Ya
	xb6CJ+fGuS7fB1DA==
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
Subject: [patch V3 21/51] posix-cpu-timers: Make k_itimer::it_active
 consistent
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:31 +0200 (CEST)

Posix CPU timers are not updating k_itimer::it_active which makes it
impossible to base decisions in the common posix timer code on it.

Update it when queueing or dequeueing posix CPU timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move the clearing to cpu_timer_fire() - Frederic
---
 kernel/time/posix-cpu-timers.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,6 +453,7 @@ static void disarm_timer(struct k_itimer
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
 
+	timer->it_active = 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
@@ -559,6 +560,7 @@ static void arm_timer(struct k_itimer *t
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
 
+	timer->it_active = 1;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
@@ -584,6 +586,7 @@ static void cpu_timer_fire(struct k_itim
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
+	timer->it_active = 0;
 	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
@@ -668,6 +671,7 @@ static int posix_cpu_timer_set(struct k_
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
+		timer->it_active = 0;
 	}
 
 	/*


