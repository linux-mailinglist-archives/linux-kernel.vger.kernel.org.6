Return-Path: <linux-kernel+bounces-540750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B37A4B478
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A903188E75D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434D1F03D9;
	Sun,  2 Mar 2025 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g30fDJVl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMY7cQ8S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A11F03C8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944227; cv=none; b=I5Z+usthaeW0SLKQf4JKEPUJxIN4CnWdvM7lPKEGyDxe8DSa935vQTzqTb4KvxllyM9WiGIvMkcPPIaHxhEFFT3ZFYB1Db3n1GKVss/ibPFBWPnbc7QD8FtLHPQpkQFZVU6vscQnxWUtdI6gu151OiiJ2mYEdgDnqonxRnFrBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944227; c=relaxed/simple;
	bh=etY3ts9K3o7g29edq8/d7QUsN8eckbmfkidmCmhVHa0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UvzPuoBgEyiu9aZhWRw+1YVjDlHPbudlHhylq+zMJwhgu/6ovHUSZKI6tE1tTIJjsF+jenlA10mVu8UTXXAzE2x3mfzWF/UkvHDV4q/gn1GQMP3fJWSY93F80p3WJ+hzfX+z/AnMwB7KIZI7i84cOJ2sd+nPI046fCGC+E3taBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g30fDJVl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMY7cQ8S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.669047127@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JZzdR41mOA7M2Y9QSCZRrpukrbjjYu8nSktij2l6yxA=;
	b=g30fDJVlqyT2GqiEiki7hmlDMqvIyBJ93xesOrcmwOLTD9B6UmPKsUbdv6LLRtMuWaxz5w
	kubAlOamTfJI6mWwhNrJ1lJUak2+QMbNFwr3z/FOJlNXxP7FsB43fIhR482H+Is5gs4bY3
	ufiWb1AOFd8WkJOZuIah5tSvV9bjIHVZ3FcFwJ2NQqSpXS10P9tjlM474H0RZixoRKKlVB
	2O2ku7y0pdhdp5dklqsviTim+D4FsscUUXymWhnB7rgvGXBCM9HOTfIebI3duinDhOXLmx
	Vug/t/vCEdDstxwwCW5UGlG0+/KrZlmqTaR6ZLTpLS+EOglH0dGWTpLOzq2VXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JZzdR41mOA7M2Y9QSCZRrpukrbjjYu8nSktij2l6yxA=;
	b=dMY7cQ8SWggpfxCE3YKYzDtU8rz7A2qrpcqwM7TpNd9XFqCznsEjHCYrEtMoN5POlj4JjP
	1z3lQEGWIGPJonCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 12/17] posix-timers: Switch to jhash32()
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:37:03 +0100 (CET)

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
@@ -86,7 +86,7 @@ DEFINE_CLASS_IS_COND_GUARD(lock_timer);
 
 static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
 {
-	return &timer_buckets[hash_32(hash32_ptr(sig) ^ nr, timer_hashbits)];
+	return &timer_buckets[jhash2((u32 *)&sig, sizeof(sig) / sizeof(u32), nr) & timer_hashmask];
 }
 
 static struct k_itimer *posix_timer_by_id(timer_t id)
@@ -1505,7 +1505,7 @@ static int __init posixtimer_init(void)
 	timer_buckets = alloc_large_system_hash("posixtimers", sizeof(*timer_buckets),
 						size, 0, 0, &shift, NULL, size, size);
 	size = 1UL << shift;
-	timer_hashbits = ilog2(size);
+	timer_hashmask = size - 1;
 
 	for (i = 0; i < size; i++) {
 		spin_lock_init(&timer_buckets[i].lock);


