Return-Path: <linux-kernel+bounces-567997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC7A68CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA447AE88D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44E25BADA;
	Wed, 19 Mar 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1eh51jMd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mD0JCSxG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D725BAD1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386987; cv=none; b=iQYgko7386i+DQAsc9LI//uqwqZv9JStAta5j/hz3N7nRMUursTKIX91RB0atCz11/+bt8C28myCCW60/8qD/zFSQJx80NghHE/xc868aTp1AKp+bBgrN/16nD3z1CXhN6urBmRrlqEhdqC2DpP/YvypuHyTVkaFqTj340/4kyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386987; c=relaxed/simple;
	bh=dtUkhO8PLZy8aCCLf9saP9TM0LaUafhrLDYgee7UAWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxAd6VvoFpsYc8wVgqeg4pIFRzeK7dK9M7ag2+U7c3HYzGny9HeubkclCbop1kZqJPm6jQjJvPRmN9W2fgOIaET4uKgj0UzYqRME21PynhrUGKiUAew61xnuEyG8eMHq9xDB+3RZ5Iq8k0cQORir8cSutx2Y3AlP3ac1hKHRvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1eh51jMd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mD0JCSxG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUWiDF6/fj+c8JQhlkPB6lM1axYjhCyaaIXJQ8l4Ag8=;
	b=1eh51jMdXabfnpbHMylnxC+28vS0hukFOe101zN33sN6Uc2Q8MNLZs2lDU5+BuZWifRtO/
	L1tTOTEcJE6qAL4AXcoANa2S5jsJjcCOXtKd98oUx/mFkn5C2AHsdyIssed6mW/8+DgNWu
	k9dAAGqVDYUkSv+p15mtTxPeuKbMzIeoZSyXTYsQ4MOc85Ia0MMj+mEk7g6bIpF5CFNyrG
	uHdbzpM07YNx7wN43oyiUtWV0pYkyRJGuABj4nofb3F08/5Lwg79ayQrKZaky992LWhU5E
	jngQ/wizQA8yFfJEmR0wjL0eRzOySAarToJCOXItzaGbFvREa7DieWCqrPbV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUWiDF6/fj+c8JQhlkPB6lM1axYjhCyaaIXJQ8l4Ag8=;
	b=mD0JCSxGWL7ycLhIAgelfuydjSQwro20Z4YKK1JH9A/QnudszZZRzPKii1Zwrg2oXMJlVO
	6HvwUipn1N8KVRCQ==
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
Subject: [PATCH v3 26/29] x86/cacheinfo: Extract out cache self-snoop checks
Date: Wed, 19 Mar 2025 13:21:34 +0100
Message-ID: <20250319122137.4004-27-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
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


