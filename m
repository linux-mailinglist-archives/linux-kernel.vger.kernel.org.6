Return-Path: <linux-kernel+bounces-540743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA7A4B473
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7241890CE0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FFF1EEA39;
	Sun,  2 Mar 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N0XMIrhm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNs6ObbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0761EE7C2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944214; cv=none; b=jZNaqWpdm9LS4wzFVTr67XocC64sO9zezQxRLlm83qIm7TTvP1Lsxkna+E9g10mk4IWZ5IFCwZ+b8z5bDjLWoHOKsYW9APwG3SK4Oy45U1t1X/CdDimLMIJgE6AQLLSfdfUuEnbYGfyeWI1d1Keer7RWffAkTI2VCFqFt5PNGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944214; c=relaxed/simple;
	bh=4W1lHUILucLe9BbR4U1iigk+d1qy1p2V8GPaddiITzI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nd+t+cvz6LXyimZege1WlKr1WbpdC/Ltl5zsTouvTqq6fVszrdb0MgJncGS4LeTFYuH3pq8QdEXHeeTroFbinaExdDZRMwHgStYb3ZWFXNeMghwPMHDZSLi0nuqysuWSh0G9HUcZqJEnGTaL34G/e4hsD9dvCbcl21oewtAAMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N0XMIrhm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNs6ObbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.229366917@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QrbOx6uAQ5Ms/hSi33seKY8Lf7RBO9KA+TOAPdKMcCM=;
	b=N0XMIrhmSjms2dQDGK+S94UC7MCt8HJ6zMEo2UYyvkQSSoFGf3ePpba3XPDh4Xpey2oA8X
	bylo9GYw+194J7M9Ac3W41TOqP4Txc9bbiPswOrHk/JA/+/saGWq7Vuxh7qobbWeQj2ueW
	QkixES3wNoLUZYI2A9GipvIOlyUoFMCQD9voUerP6YHAOgZgpT39mux8BCJ1GxgxS5tifI
	H0Bk8Ft62sWN/hvwMpqZnk4EvqsbrSiw5VgJIj8xJ6+joNwVrsZ3AVkBqewqUUGKqZpufM
	KMXTmjYby7gew50S5HbpoC2Yi/ELJ8FHVFz3PZcwKCnasLLrYYsBQ6dAoUpFVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QrbOx6uAQ5Ms/hSi33seKY8Lf7RBO9KA+TOAPdKMcCM=;
	b=cNs6ObbKUeqImfUJrtajq+i0oCbvjVKsGHM2bcq2nZy2jw1QsINpZbl+VtdDCM/U9lkkP/
	CGPdG27E98h1zqDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 05/17] posix-timers: Remove SLAB_PANIC from kmem cache
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:51 +0100 (CET)

There is no need to panic when the posix-timer kmem_cache can't be
created. timer_create() will fail with -ENOMEM and that's it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/time/posix-timers.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -243,9 +243,8 @@ static int posix_get_hrtimer_res(clockid
 
 static __init int init_posix_timers(void)
 {
-	posix_timers_cache = kmem_cache_create("posix_timers_cache",
-					sizeof(struct k_itimer), 0,
-					SLAB_PANIC | SLAB_ACCOUNT, NULL);
+	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
+					       SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);
@@ -371,8 +370,12 @@ static struct pid *good_sigevent(sigeven
 
 static struct k_itimer *alloc_posix_timer(void)
 {
-	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
+	struct k_itimer *tmr;
 
+	if (unlikely(!posix_timers_cache))
+		return NULL;
+
+	tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 	if (!tmr)
 		return tmr;
 


