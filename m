Return-Path: <linux-kernel+bounces-564705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3F6A65980
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF63A2B91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C32066C8;
	Mon, 17 Mar 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6ekbFZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D03HKOQ8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB472066C2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230432; cv=none; b=RRtUotiCeRzmVYgrtLVz6P7w2YFjWOsY10ifruurjX/Z+9XbxPwPrdFkYSn9qdw88YWaaHK1+Ds6FM7TEQQjA34gflgFlF58UHhu7mIou/qXib3WyIEbpsCIasELKpVO+GHTGWyWgWRqQgaRslWtMwMzIa0JU/5SnXy79tvpdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230432; c=relaxed/simple;
	bh=hBzvChoOQvGE6FMVCZutaEN/LKGNtagsgTg014PxpMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrsHt6Q91fIZj3dW6E0ChL2TmpYVqPcf3qIfwTxWmEtyDqpBVvIGgl1m95jEte7cJ1MnqI40iZQRM9+kJcVImFgR/M5yX9uWPPlhH/FdRwTLcHEysbKYQ1eOasTkrWZqLZldiVkhPxFNC8A0oOUAHAijnlJQFShLH01MlCpzYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6ekbFZk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D03HKOQ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRMjvKE4MQLmNjaR1PWF6XhNgESnZDgm2C7udi4Htfw=;
	b=w6ekbFZk30aIDPzzFwJGHZWt+P1M9iUQgVUb4/hcTZ7zJS255ap1zUsdz76uZ6XqgkIlcU
	m7mswSaxISlv3dy1Y7CR9r2JLt3sh1csv/FXSkm6y+I4XArzn5bxW/wPBG8GxkFs8TXxG8
	Jm2InGsgLbcaKRlYNs4Tf2WZvOs8Asber3zofCeQkLiYIR+at+hWe7R3pI8Vh+7kwYgpyw
	vRF8jaKfqBw9LeWLZHJsKeF8qW1ESqTDi+cONiFC9NM9vjrQ6DEHUP11XprYhKMSbK94/F
	74v3SC502qlW3dltqBmWUKZ9WuNWUjf98UXtEOlnQeiRCiYFks17of0PdL6FEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRMjvKE4MQLmNjaR1PWF6XhNgESnZDgm2C7udi4Htfw=;
	b=D03HKOQ8BlrOFaGRDvrgtWdmBWOlsbCeAZ/p0c0uLrZZQmhBgnLPndTGZJv/H2T+3VnfS+
	EuuosbHtRoplfCDg==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 26/29] x86/cacheinfo: Extract out cache self-snoop checks
Date: Mon, 17 Mar 2025 17:47:42 +0100
Message-ID: <20250317164745.4754-27-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
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
index 78636de752ba..d659cc29d4a2 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -641,6 +641,17 @@ int populate_cache_leaves(unsigned int cpu)
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
@@ -658,14 +669,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
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
@@ -680,9 +684,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
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


