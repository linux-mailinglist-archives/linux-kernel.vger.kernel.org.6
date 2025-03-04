Return-Path: <linux-kernel+bounces-543583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D249AA4D733
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D51888C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD12046B6;
	Tue,  4 Mar 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApQ9UaMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1qEHzOaB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBC2046AD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078448; cv=none; b=WvXYaoiodF0pzjiXxaL2sGzlTtzltmg0n7+ec48onUtrC9NrtSjCwag3/ZDrnTKvfLDSxsa1CU8YSRIbStvUop0C9/W8KB9MEt7+o17b+aHxCjP1goNL1jmgSXUE7+yFhE1joEyVbAMZfofjH+0RudCJau0P5kaOCHZawL4OeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078448; c=relaxed/simple;
	bh=MFQ9K4KEFPnp5Sq8h4bQJXmn/D4w8oxrBMIEnaUKA6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUZP7zm4a79PrOTeNQm3ldOeP0uO6+uXsBJfQM1CkFynwC5rwxHD3ExfQaXwgY2cCdcclQ9iRFHjhSV7BguFxlJXtc+/cuHWS/yF0rAw0O7KAmFQwLoHPHdFCxhxZYpmzx2NDO5iIoXpjzGBO5PmKNm+bsdvsZSPY4giuim8Vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ApQ9UaMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1qEHzOaB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETFNrcv3Bk/jQxN/QgQApnOhSop3xoTmaHXe1N70U8A=;
	b=ApQ9UaMQpKSXI7MLCPVN69MhuzzQjdTXDuI7asL/IEiRx5yFDZEGy/bG2+jWnkQmMUK7Kv
	tT5yLHAr1hY1QHrp84WnbsxQt2U+e7Gp21e+CeyKmOjX3R+LiWiOadYgVYrBFn16tP65JY
	A2hRoEmcaqIKFhQezfJaM/8RsxuGhTcmGC23CvFoycIKuzuQH4Or+sQwqrr4nk54MzH0Oz
	BN4jd6Ss3SoqmPb7hIBJwULiwIsS64sZovygRhIiSPNngwjds5aaBko2rdvmjhnJiW1B84
	f0gcS0hle2QrCnqYoBTaqSlzyzdUrtGiP9kGfozmueMgKwqaVIiiu2Ow/t9+CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETFNrcv3Bk/jQxN/QgQApnOhSop3xoTmaHXe1N70U8A=;
	b=1qEHzOaBjYxwFegbJ/Xjp/fpDFex3KgSKgG8JJyXSVLLB0g0v8+qNi95Fm+FG86Ca9bbc+
	dxcDtg0l+DOM9uCg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 37/40] x86/cacheinfo: Extract out cache self-snoop checks
Date: Tue,  4 Mar 2025 09:51:48 +0100
Message-ID: <20250304085152.51092-38-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic of not doing a cache flush if the CPU declares cache self
snooping support is repeated across the x86/cacheinfo code.  Extract it
into its own function.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 254c0b2e1d72..ac47d1b4f775 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -640,6 +640,17 @@ int populate_cache_leaves(unsigned int cpu)
 static unsigned long saved_cr4;
 static DEFINE_RAW_SPINLOCK(cache_disable_lock);
 
+/*
+ * Cache flushing is the most time-consuming step when programming the
+ * MTRRs.  On many Intel CPUs without known erratas, it can be skipped
+ * if the CPU declares cache self-snooping support.
+ */
+static void maybe_flush_caches(void)
+{
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
+}
+
 void cache_disable(void) __acquires(cache_disable_lock)
 {
 	unsigned long cr0;
@@ -657,14 +668,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	cr0 = read_cr0() | X86_CR0_CD;
 	write_cr0(cr0);
 
-	/*
-	 * Cache flushing is the most time-consuming step when programming
-	 * the MTRRs. Fortunately, as per the Intel Software Development
-	 * Manual, we can skip it if the processor supports cache self-
-	 * snooping.
-	 */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
+	maybe_flush_caches();
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
@@ -679,9 +683,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	if (cpu_feature_enabled(X86_FEATURE_MTRR))
 		mtrr_disable();
 
-	/* Again, only flush caches if we have to. */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
+	maybe_flush_caches();
 }
 
 void cache_enable(void) __releases(cache_disable_lock)
-- 
2.48.1


