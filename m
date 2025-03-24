Return-Path: <linux-kernel+bounces-573818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF3A6DCD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7AC16E91C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88762620FE;
	Mon, 24 Mar 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQKUumwY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSGK7l38"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443B2620CE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826081; cv=none; b=cwzBt+Vlr5cGAH08ahp41+n7btZvMreWbErrPjLUsR69rvCz83SO0eTCqk/PSGzNYXVIjwVyxZzbqJXUJ0QHJDkhVeubqyyjwYEWhv95hgP1C7+slejcRZZ5U9VFAXOUtkIAID3p5JB26KpjcPwu7tqFXm4HAbar+eX7DvcRV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826081; c=relaxed/simple;
	bh=BKQD6k60Mnq8kNsJxtQIlNwtJHS5ZuWqFdDwFc62AC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGBXLXRJMsITh5gdL7RXabtLeMzZBx56nwkSdvz7YTHk6szAFH0HQV29vCFIuPHA56oOQMFIOfctbBdrZS5cKI1hfjQQ62kZCJjiYFtGSvlzTuz/BCWXEXlWqquG4OhHFxMbyDboGtaQIIv/ni3oK8gKITKBOSTuQ0JMse3CYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQKUumwY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSGK7l38; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1DtEHn1El6g4W3dtqLn/pJd+l9oe/iYWXMyy19sLw4=;
	b=MQKUumwY91dRbVgrqbUP+neoCVY1O3/MCVU+OqsIk0Mg8wthYhHdABuN4BcRzqegjhbQ9A
	FmdazAysV7fC+4NZmkBk592EomyKb+Y4Ovr5ZNybLjJJKgpIzjlDG5QRY81eEX/RBJZ7aa
	j8UJaNCDyEWnEDW61Jm5wtrRwr6z4ed4tVYh3NcdMNoQgaWhnpu8D9JI8sWo7EM90VEfkt
	tcQ0Tn3oaNLxTXoi8k1s7HKMxDaWd61WKPwHqlbjcys+8sT6F4oKRcrKbs2qkvuPhCbJ4l
	SmswF8UzjClDX35v+tt7nLPW6rbZJrPH9DwleWZr4AMFL7vHtU23ZJPXZw5Y7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1DtEHn1El6g4W3dtqLn/pJd+l9oe/iYWXMyy19sLw4=;
	b=sSGK7l38bMXGjba6WsaBASo++6GpF3mJLRnrCzAIZp902IfddAP1D1l+dix9zyQWq9bWhq
	dVEJjgO2nNuwF9Bw==
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
Subject: [PATCH v3 10/20] tools/x86/kcpuid: Use <cpuid.h> intrinsics
Date: Mon, 24 Mar 2025 15:20:31 +0100
Message-ID: <20250324142042.29010-11-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
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


