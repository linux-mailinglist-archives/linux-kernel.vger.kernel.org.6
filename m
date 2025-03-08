Return-Path: <linux-kernel+bounces-552633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA4A57C21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0EE16E0A5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C117A2E3;
	Sat,  8 Mar 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Yb8b9gA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLfVAiI6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD0212FAF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452524; cv=none; b=a5H7Jp+c60N03SgaTHDGMgx6dsfx8nlDLINZwoc9BgTq98wHLv4yTfS3PvtRnEYBaDLdhCFGx3YyPHxB2Jjjf7ZbZ4cFbZq5r72nw8Ql5zj0h17iP2mpiovY6rGdAzw2zSqkaEF4QV0PMSWPU0pf+uRK8GPAsXpzNJFhugpAt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452524; c=relaxed/simple;
	bh=8UmxBRmF5nXHswTC8BicM5u5C0y9sC394+CC1Pxv8T0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=p5Rb1RfUdgSEBBb25O7btvr2r1OgxAErjc8c1Vg93DXV+a2ieLUvlCr0KZZeHiW+ILpPpTAhbqgx8Voi1PGnz/8RN6rvavPREBknXpaUSn/frYYc6/nFIC8TaKEQ6rXSV6hEJR0kVJMdVJGa1l+0kRLn1D1K0qr/rl4V7TDnP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Yb8b9gA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lLfVAiI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.279080328@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qoabwlj1EGQBFXc6piAS9tlQQLf9azO7VG5Y2rcwn2E=;
	b=1Yb8b9gACJSVZytKQQAOpuF2ugs+XmbODu8KaRKmBjTMfOqNIcEB5EesHPeV0wr/RXeJqi
	pj43yoQLUmW+sywI0u+PHdKb/xC8JfP/HKtA+6gpKlVG/19mg44ynyyYW4edZZWXYh2rHr
	1G5T513ETKtm+jpH9sE8vJ/B8nS7sd4mlelUePmw6XEImnUFZnSsW2O2A1zRCx/8zbpKWa
	xql/Tkb6iUF1UFGleZjSt8RCxOLyGxYTPx5xK6yijPGM+L6MisXnyfZQ+H75CUIlzp//oF
	/+8OvdYcpqAfXfFm2HLasprmhmhpYK8eDxEP1ZHyZ5bDUDD2/mr1M2x4ATCAHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qoabwlj1EGQBFXc6piAS9tlQQLf9azO7VG5Y2rcwn2E=;
	b=lLfVAiI6sTj6n8l5qWxvhVHz61+Vcr96tVrbyQL7/nHSOwXVxmTYiJvbdJ0FAt35lrkQgk
	PPYzcc9HpWFTEABg==
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
Subject: [patch V3 13/18] posix-timers: Switch to jhash32()
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:40 +0100 (CET)

The hash distribution of hash_32() is suboptimal. jhash32() provides a way
better distribution, which evens out the length of the hash bucket lists,
which in turn avoids large outliers in list walk times.

Due to the sparse ID space (thanks CRIU) there is no guarantee that the
timers will be fully evenly distributed over the hash buckets, but the
behaviour is way better than with hash_32() even for randomly sparse ID
spaces.

For a pathological test case with 64 processes creating and accessing
20000 timers each, this results in a runtime reduction of ~10% and a
significantly reduced runtime variation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V2: New patch
---
 kernel/time/posix-timers.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -11,8 +11,8 @@
  */
 #include <linux/compat.h>
 #include <linux/compiler.h>
-#include <linux/hash.h>
 #include <linux/init.h>
+#include <linux/jhash.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/memblock.h>
@@ -47,11 +47,11 @@ struct timer_hash_bucket {
 
 static struct {
 	struct timer_hash_bucket	*buckets;
-	unsigned long			bits;
+	unsigned long			mask;
 } __timer_data __ro_after_init __aligned(2*sizeof(long));
 
 #define timer_buckets	(__timer_data.buckets)
-#define timer_hashbits	(__timer_data.bits)
+#define timer_hashmask	(__timer_data.mask)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -87,7 +87,7 @@ DEFINE_CLASS_IS_COND_GUARD(lock_timer);
 
 static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
 {
-	return &timer_buckets[hash_32(hash32_ptr(sig) ^ nr, timer_hashbits)];
+	return &timer_buckets[jhash2((u32 *)&sig, sizeof(sig) / sizeof(u32), nr) & timer_hashmask];
 }
 
 static struct k_itimer *posix_timer_by_id(timer_t id)
@@ -1514,7 +1514,7 @@ static int __init posixtimer_init(void)
 	timer_buckets = alloc_large_system_hash("posixtimers", sizeof(*timer_buckets),
 						size, 0, 0, &shift, NULL, size, size);
 	size = 1UL << shift;
-	timer_hashbits = ilog2(size);
+	timer_hashmask = size - 1;
 
 	for (i = 0; i < size; i++) {
 		spin_lock_init(&timer_buckets[i].lock);


