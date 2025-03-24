Return-Path: <linux-kernel+bounces-573755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF51A6DBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE463B325A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8537263C65;
	Mon, 24 Mar 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vrPVOy+J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5JIx07AS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8272638BF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823296; cv=none; b=ZpojN36cQaRVZzbzPjTxOFCX1YXEhjg3+6sHin+wQrjmGj61RCCzo5jtnL15EXBD8bxrgr7/UR7rk3yCrbfObJWiDzunZqQ+ZqBb09odBwhAq0c3TYwbl+72MizpUc2magmdzgKUa5kYaH5+ESKN0WKfMyH+slvlbUQ9nHtbpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823296; c=relaxed/simple;
	bh=dtUkhO8PLZy8aCCLf9saP9TM0LaUafhrLDYgee7UAWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxcWdpVhwHxMnbwdqwqtZeiz+1NyQcUC3SnBw+dqhEX13zUOmX5l7ZLUGN/UF6YVkqQOHCVrWajXIltRqN0ERFUNMxHQE87kPJqq3OcsifSxwiWwSoqje98S9TrFZgaigJLyCpM63k4Lf2A/FU3UO1stlWgQh26uD0WmY5q2Gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vrPVOy+J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5JIx07AS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUWiDF6/fj+c8JQhlkPB6lM1axYjhCyaaIXJQ8l4Ag8=;
	b=vrPVOy+JuyunicmAiQTeRO/JI9RSFtQYdpcV8KCO+56scYoLLTeA6Zmg1AwF3PgL1/I5Pk
	HQyeKIYi3+7iDVsX83aG3yJQr9lTRdB/bKHBQ5OQeZHQ26SBlJ4B7CyXRncqd5qHi+C+YV
	9EtBK004CfFF0+48lIWjF1FH7MjbjW4h72fDTPDLd5RFX3MhiCGTTnVEu5iKVgQysupp6K
	IyghcZryVUJaMeDEboe7Zdx1cliUtfgl9+/ApiHVCeaTQX0GvtzElCTvH8TnoFTT3Qq6eN
	WajAnwtoIEhTLlzFib974P3A4/WOdijyleTUfNA+9Lx8aN+L4KBUDKNmBDRxjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUWiDF6/fj+c8JQhlkPB6lM1axYjhCyaaIXJQ8l4Ag8=;
	b=5JIx07ASqEEhBnaCIuRSvlB4ppbs3io7L9YtzcLXGPWH5vEfRwvVG7XC0prM096412J/j4
	3VFpHT5z0/X4C/DQ==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v4 26/29] x86/cacheinfo: Extract out cache self-snoop checks
Date: Mon, 24 Mar 2025 14:33:21 +0100
Message-ID: <20250324133324.23458-27-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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
index 7b274da7c725..231470cdc1da 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -646,6 +646,17 @@ int populate_cache_leaves(unsigned int cpu)
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
@@ -663,14 +674,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
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
@@ -685,9 +689,7 @@ void cache_disable(void) __acquires(cache_disable_lock)
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


