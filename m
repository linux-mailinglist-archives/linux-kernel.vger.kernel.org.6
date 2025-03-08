Return-Path: <linux-kernel+bounces-552626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFBBA57C1A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851551891531
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53340200111;
	Sat,  8 Mar 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nT5dcYVa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D463rrhM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DA1E833B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452510; cv=none; b=g0w9hHATBLYYAUugDb3e2Y6uI5nebwbMnqELNBk/ok7jnle65RucgOGOxdRujQt4RNpOT8LLsCHIlKWKlxAQnNFkGTYfwHc1bE4w2LZVeHvsKVsQX6Zt+3qXqdZIW9jHIFfvraYD2XQZ8Lfq1JvDpGb6sYpLTfxQM3HX1kPGJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452510; c=relaxed/simple;
	bh=1CNbS8V5GNdwE2MUYNRQZQZrnyIdBIXF1/Rqlwc4JP8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Wsd95EKgbNsUQPwnhE2fBf8Hqgdqb5BGcKXUkC93RGjHd+gKqh/9GweiT5XXDYi7IjiuZfSEW935VlbvP81bJ6hkI1qj6LZGPnBloL0NX8qDHEW9sS/OE3qi4qVHq2lRPzMkADmP5mKgjKbR3lg9DRP3ZGuC75SQyH0l6dtU4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nT5dcYVa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D463rrhM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.829215801@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=27HQMLTjuNSBvpM2M4GFmvhtGJQR57PqTAcp8ARZKmw=;
	b=nT5dcYVaQDkbMwfCDdBqE2/RZroJ2vFBnBB7aM3hi8EeXYyzZEFaxtUtN8Rl8OAoRflWlZ
	WCeJwGD4hcUBCXgWuZBfSg5Gn4b78qb1zj+ta8kxB4eWBnhAYudi+4rMk5FiaKDj2MVbI+
	pqutsPn2QHo5hOp+ItR4d5EwW/pXi7PrU03T3BdDYHJQCGU2AK2U5jk6P8CZkRHssh03Dw
	Shz7Qt1bqTiGk2mnVUBaUnDfVBAPYwcvspaDRQpkJ5TdHkolxT9I6vpYQCsV/baPOlQ4Rg
	gRaFL/Mjs4+QdwwmMPoYkIow/tAHWv0s5ylh5TDPLG214vocQJMW+/uaF5hUbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=27HQMLTjuNSBvpM2M4GFmvhtGJQR57PqTAcp8ARZKmw=;
	b=D463rrhMp/m32S+2lppElbQJ/KUgBknsUkczkjREpci+3hu+cZPAE4V1ga3pCGhuLvPDKm
	UKPoe19G0Fb/6yDw==
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
Subject: [patch V3 06/18] posix-timers: Remove SLAB_PANIC from kmem cache
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:26 +0100 (CET)

There is no need to panic when the posix-timer kmem_cache can't be
created. timer_create() will fail with -ENOMEM and that's it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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
 


