Return-Path: <linux-kernel+bounces-573823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA8A6DCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C78B188E629
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE10261382;
	Mon, 24 Mar 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOXgEH0t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LaHIWoDe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA19262D3C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826090; cv=none; b=XvCYxl88H20ltMR3md1NwJY3fjgxTrPOuZIGlK+jdZUluwcc3YupLdR/i0GhRxcu9Lo9XBQ5RD8rDGtV1qF6Eg333ahfUAfLgH9lakv/aW5+f4EX3XyEN6S7dScxoXOidF2EWW4WJFx4nppzj3tXo8n9/1uxTAIevbr4PEYpJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826090; c=relaxed/simple;
	bh=DBNnWt5ZBCsy6iXd4xI6XrwCHAVSIqlBsg6Nj1O30w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkfQ66wQw+8Ebq2TGq9UFFKl6H0S17/rgTkO9JW8bTXuIoIATqWNSZjPX+WcwmegfZS/bXGU4/1RPf257D1RWL0yRLdpVSrbmuOHMwaxQgwkpmWBJhQGrYV2nGP5SaoEzQzI9WO61kWMRUyGARsgxg35tzfOPc3+I1urOjhTGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOXgEH0t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LaHIWoDe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZCBQk2E2rJeHtWKOU3CDZgRtbkVQ30CM8TCMONhm5o=;
	b=sOXgEH0t4RSC5fJ+Wu4ogMn0o4/2VW33RQmc14c07UZ9MA8BsH+EUV+GjXBckN66pdava4
	JuJ1Fxt/h1d11ozXda/Z4CoyeBzDDPLdqc7uE34S9O5GnC8ilPQ+m2ySelBnkEbVx8nq/b
	kgTZqAHBRBwdEIRT4tJZbQg31bM+b8LkZ3YkY1sxyjz6sH3FKE65q3TxhnvxWnO2vcsQ3X
	OSJsGNnkKSRK5YordO+0+DrBF32oC8eSHDubf8CGgNi23cc7Gl5Fq7tyteJD8ujSCx40gX
	B3KT8KLe3psaL+kvkERJrFJeIkjuGHlnw+W4Mq9kM+155DFy13YpLhbtkakgWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZCBQk2E2rJeHtWKOU3CDZgRtbkVQ30CM8TCMONhm5o=;
	b=LaHIWoDe0hF4z3hNpRYC8Ox3yJMApmt4RcE+O24YT51ffkfZq/M9LCNWZz/EgtaerxkJSV
	/ObOvnNsF4xy3cBA==
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
Subject: [PATCH v3 13/20] tools/x86/kcpuid: Consolidate index validity checks
Date: Mon, 24 Mar 2025 15:20:34 +0100
Message-ID: <20250324142042.29010-14-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let index_to_cpuid_range() return a CPUID range only if the passed index
is within a CPUID range's maximum supported function on the CPU.
Returning a CPUID range that is invalid on the CPU for the passed index
does not make sense.

This also avoids repeating the "function index is within CPUID range"
checks, both at setup_cpuid_range() and index_to_func().

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 0ba0d440482c..8f81fd66e8dd 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -101,10 +101,12 @@ static char *range_to_str(struct cpuid_range *range)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
 {
+	u32 func_idx = index & CPUID_FUNCTION_MASK;
+	u32 range_idx = index & CPUID_INDEX_MASK;
 	struct cpuid_range *range;
 
 	for_each_cpuid_range(range) {
-		if (range->index == (index & CPUID_INDEX_MASK))
+		if (range->index == range_idx && (u32)range->nr > func_idx)
 			return range;
 	}
 
@@ -331,17 +333,16 @@ static void parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	/* Skip line parsing if it's not covered by known ranges */
+	/*
+	 * Skip line parsing if the index is not covered by known-valid
+	 * CPUID ranges on this CPU.
+	 */
 	range = index_to_cpuid_range(index);
 	if (!range)
 		return;
 
-	/* Skip line parsing for non-existing indexes */
-	index &= CPUID_FUNCTION_MASK;
-	if ((int)index >= range->nr)
-		return;
-
 	/* Skip line parsing if the index CPUID output is all zero */
+	index &= CPUID_FUNCTION_MASK;
 	func = &range->funcs[index];
 	if (!func->nr)
 		return;
@@ -505,17 +506,13 @@ static void show_range(struct cpuid_range *range)
 
 static inline struct cpuid_func *index_to_func(u32 index)
 {
+	u32 func_idx = index & CPUID_FUNCTION_MASK;
 	struct cpuid_range *range;
-	u32 func_idx;
 
 	range = index_to_cpuid_range(index);
 	if (!range)
 		return NULL;
 
-	func_idx = index & CPUID_FUNCTION_MASK;
-	if ((func_idx + 1) > (u32)range->nr)
-		return NULL;
-
 	return &range->funcs[func_idx];
 }
 
-- 
2.48.1


