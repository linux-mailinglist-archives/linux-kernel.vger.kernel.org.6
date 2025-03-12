Return-Path: <linux-kernel+bounces-557896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17451A5DF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690213BAD26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A4256C87;
	Wed, 12 Mar 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q+J2aYyN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2c23a/P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA5256C62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790300; cv=none; b=FF3c0DzDE3aL360cCpOok4ROwQIJtuJWc3Ks3RbMGMeTricV7C5QemQ3V/P9YqUbZmMO793pDiNcIj6U1c4OtjlTxwGGq2orR3vgAr1LtyCZYVH5aP1SowA4BNlktC12dy6CCFmXvJm4oBsJdmH5F5jYdAhN0duRR6wLFkd2VeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790300; c=relaxed/simple;
	bh=BKQD6k60Mnq8kNsJxtQIlNwtJHS5ZuWqFdDwFc62AC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKajSjyB2fGQQxJJznvJT1A1E84D+BxWOdT3rrnlBff6b+yAcZBv1mL70zD6iv5f+n1L1CPchYqsiA/BwE24bSjG9nrEhmlFIM3Y4TXq5iLGA0gc2PQOd/T0JLbxfjxmTLHJEmdHhcZNKrE7o1xmgHlD4/8zRwCpvqgj5yB0ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q+J2aYyN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2c23a/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1DtEHn1El6g4W3dtqLn/pJd+l9oe/iYWXMyy19sLw4=;
	b=Q+J2aYyN7NMNco3qY/pAcrAl/JecapdipVZeNG8yQUxRXe5Lia7SiprTW4fi0S6PnwVFPZ
	2H32+r3fVvVdtBSMBUFEDU28sRlLR/YKEa6kbyg1vjWR894tHlWUUg5RMS6H36h3gAHddf
	50YbP6dGUW3Or8OdQqHoqagAAeVeB1bSyz9GyvIh3WCgVjnT87bAGJRPgB62W2AHaQK7Tw
	z5H9h8XLgLVN9VfJnbT6sQHoSGl9am/+BG0FDoOlIGJH6TjDYR/MiiO/7YNPSt0c0Wiofi
	dx0grNliMN8HjziHxRWPCWp8bd0+17b6bIpq9r8sQMS8gNCnI257XkhEEIRajg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1DtEHn1El6g4W3dtqLn/pJd+l9oe/iYWXMyy19sLw4=;
	b=P2c23a/Ps80uPaW4pUcALjnbUdz0jeGqv0KOg3yrgPOkYfg0qCQQPZ05BkPaR/tl6SKN+n
	T7pLrN1uen3B0cBg==
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
Subject: [PATCH v2 10/20] tools/x86/kcpuid: Use <cpuid.h> intrinsics
Date: Wed, 12 Mar 2025 15:37:27 +0100
Message-ID: <20250312143738.458507-11-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the __cpuid_count() intrinsic, provided by GCC and LLVM, instead of
rolling a manual version.  Both of the kernel's minimum required GCC
version (5.1) and LLVM version (13.0.1) supports it, and it is heavily
used across standard Linux user-space tooling.

This also makes the CPUID call sites more readable.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 ++++++++++++++--------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 79deb506b349..0dbd93ab652a 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
+#include <cpuid.h>
 #include <err.h>
 #include <getopt.h>
 #include <stdbool.h>
@@ -86,16 +87,16 @@ static u32 user_index = 0xFFFFFFFF;
 static u32 user_sub = 0xFFFFFFFF;
 static int flines;
 
-static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=a" (*eax),
-	      "=b" (*ebx),
-	      "=c" (*ecx),
-	      "=d" (*edx)
-	    : "0" (*eax), "2" (*ecx));
-}
+/*
+ * Force using <cpuid.h> __cpuid_count() instead of __cpuid(). The
+ * latter leaves ECX uninitialized, which can break CPUID queries.
+ */
+
+#define cpuid(leaf, a, b, c, d)				\
+	__cpuid_count(leaf, 0, a, b, c, d)
+
+#define cpuid_count(leaf, subleaf, a, b, c, d)		\
+	__cpuid_count(leaf, subleaf, a, b, c, d)
 
 static inline bool has_subleafs(u32 f)
 {
@@ -195,12 +196,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	u32 max_func, idx_func;
 	u32 eax, ebx, ecx, edx;
 
-	eax = input_eax;
-	ebx = ecx = edx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
-
-	max_func = eax;
-	idx_func = (max_func & 0xffff) + 1;
+	cpuid(input_eax, max_func, ebx, ecx, edx);
 
 	range = malloc(sizeof(struct cpuid_range));
 	if (!range)
@@ -211,6 +207,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	else
 		range->is_ext = false;
 
+	idx_func = (max_func & 0xffff) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
@@ -222,9 +219,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		u32 max_subleaf = MAX_SUBLEAF_NUM;
 		bool allzero;
 
-		eax = f;
-		ecx = 0;
-		cpuid(&eax, &ebx, &ecx, &edx);
+		cpuid(f, eax, ebx, ecx, edx);
 
 		allzero = cpuid_store(range, f, 0, eax, ebx, ecx, edx);
 		if (allzero)
@@ -251,9 +246,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 			max_subleaf = 5;
 
 		for (u32 subleaf = 1; subleaf < max_subleaf; subleaf++) {
-			eax = f;
-			ecx = subleaf;
-			cpuid(&eax, &ebx, &ecx, &edx);
+			cpuid_count(f, subleaf, eax, ebx, ecx, edx);
 
 			allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
 			if (allzero)
-- 
2.48.1


