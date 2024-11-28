Return-Path: <linux-kernel+bounces-425118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCE9DBD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF14B2818F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837E1CBE8E;
	Thu, 28 Nov 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jx87NKgh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cA2ImbZE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF51CB9F2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833051; cv=none; b=O/x3jFdYlUQbcKUhuczHqQfiuQcCTYIMXQGbHQa04LbjNvBpUS+UQTye3y6K01JuaoTjkxg/vXd+bICs2AMwY11M33xnigcNHlawFtU9jrU/mvExtBnV9U3FJya61qavQV0r7tTz15Lh8BkHXPl4gjl47vWHo99t5pM9rnts9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833051; c=relaxed/simple;
	bh=2PInAe0s2nXQvmCvznhiKMoMdy+J1+CUdqPCCSLw2m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPHghDERnqVQaGImmIikx455URy4bluApnGaZxBoZRti5lgqN3NXMeh2AWCLQ1GHhPnxNSCsq/26gza0PSShdZ92PXUh5OCXAcSMJTH5Lp6JN7+C8kcfnCgL918TtWdOapzBIhWPl1e4loJjeI59jYdqlbAMT5zkFO9K+GATcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jx87NKgh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cA2ImbZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvpZknr9BPOwYD8XZjsn0WZm5TwM0F8t2Y6GRW2245A=;
	b=jx87NKghxQBAXBiLc/Nfq+JvCKr9QHs/MPH5SWhhswunPve6afuD6S7CYsACfwRdp9Ce4s
	gwDb7D2Fv5hB1IOA87y8VufaEU0s802iiXChnZ4wn250cFuo0faNYFTNroHJyG+hiFLK5D
	NffN8EUgqOrWlnOUBgOkFG+X7XsKQZK/2ffHCcphRvocABjwLrUazyEiEOvq+OgefxYhed
	O6491F0yEJnAy51B52awLr2eDJuGi0a/WOOWGgezqj9kCVPrVmLXekMcoOT8ar+6HIuB7q
	n1KfBOM0ZfCzO8YhIzEYBnWbRNCU92lB8kxDktYeRazAsUdiLzAD8jXOp8N89Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvpZknr9BPOwYD8XZjsn0WZm5TwM0F8t2Y6GRW2245A=;
	b=cA2ImbZEx1KxOKV0FwjhgmWxOutHCI9pRn5LXwL23Gg08jvQcmMRgBePpagp0Tq7DhIBUv
	MB4/lHoTfeT6MXAQ==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 07/13] tools/x86/kcpuid: Prepare for more index ranges
Date: Thu, 28 Nov 2024 23:29:42 +0100
Message-ID: <20241128222948.579920-8-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kcpuid code assumes only two CPUID index ranges: standard functions
(0x0...), and extended ones (0x80000000...).

Since more cpuid index ranges will be added in the future, promote
ranges selection from an "is_ext" boolean to enum-based classification.

Collect all cpuid ranges in an array, now only two ranges, and introduce
helpers to traverse that array or find a specific range withint it.  Use
such helpers throughout the kcpuid code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 103 ++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 41 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index c0f2eae0d694..245f55aa3170 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -66,19 +66,52 @@ struct cpuid_func {
 	int nr;
 };
 
+enum range_index {
+	RANGE_STD = 0,			/* Standard */
+	RANGE_EXT = 0x80000000,		/* Extended */
+};
+
+#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
+
 struct cpuid_range {
 	/* array of main leafs */
 	struct cpuid_func *funcs;
 	/* number of valid leafs */
 	int nr;
-	bool is_ext;
+	enum range_index index;
 };
 
-/*
- * basic:  basic functions range: [0... ]
- * ext:    extended functions range: [0x80000000... ]
- */
-struct cpuid_range *leafs_basic, *leafs_ext;
+static struct cpuid_range ranges[] = {
+	{	.index		= RANGE_STD,	},
+	{	.index		= RANGE_EXT,	},
+};
+
+static char *range_to_str(struct cpuid_range *range)
+{
+	switch (range->index) {
+	case RANGE_STD:		return "Standard";
+	case RANGE_EXT:		return "Extended";
+	default:		return NULL;
+	}
+}
+
+#define for_each_cpuid_range(range)				\
+	for (unsigned int i = 0;				\
+	     i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]);	\
+	     i++)
+
+struct cpuid_range *index_to_cpuid_range(u32 index)
+{
+	struct cpuid_range *range;
+
+	for_each_cpuid_range(range) {
+		if (range->index == (index & CPUID_INDEX_MASK))
+			return range;
+	}
+
+	return NULL;
+}
 
 static bool show_details;
 static bool show_raw;
@@ -206,7 +239,7 @@ static void raw_dump_range(struct cpuid_range *range)
 	u32 f;
 	int i;
 
-	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
+	printf("%s Leafs :\n", range_to_str(range));
 	printf("================\n");
 
 	for (f = 0; (int)f < range->nr; f++) {
@@ -223,29 +256,19 @@ static void raw_dump_range(struct cpuid_range *range)
 }
 
 #define MAX_SUBLEAF_NUM		64
-struct cpuid_range *setup_cpuid_range(u32 input_eax)
+void setup_cpuid_range(struct cpuid_range *range)
 {
 	u32 max_func, idx_func, subleaf, max_subleaf;
-	u32 eax, ebx, ecx, edx, f = input_eax;
-	struct cpuid_range *range;
+	u32 eax, ebx, ecx, edx, f;
 	bool allzero;
 
-	eax = input_eax;
+	eax = f = range->index;
 	ebx = ecx = edx = 0;
 
 	cpuid(&eax, &ebx, &ecx, &edx);
 	max_func = eax;
 	idx_func = (max_func & 0xffff) + 1;
 
-	range = malloc(sizeof(struct cpuid_range));
-	if (!range)
-		pr_err_exit(errno, "malloc range");
-
-	if (input_eax & 0x80000000)
-		range->is_ext = true;
-	else
-		range->is_ext = false;
-
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		pr_err_exit(errno, "malloc range->funcs");
@@ -296,8 +319,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		}
 
 	}
-
-	return range;
 }
 
 /*
@@ -356,13 +377,13 @@ static int parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	if (index & 0x80000000)
-		range = leafs_ext;
-	else
-		range = leafs_basic;
+	/* Skip line parsing if it's not covered by known ranges */
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return -1;
 
-	index &= 0x7FFFFFFF;
 	/* Skip line parsing for non-existing indexes */
+	index &= CPUID_FUNCTION_MASK;
 	if ((int)index >= range->nr)
 		return -1;
 
@@ -554,24 +575,28 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	struct cpuid_range *range;
 	u32 func_idx;
 
-	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
-	func_idx = index & 0xffff;
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return NULL;
 
+	func_idx = index & 0xffff;
 	if ((func_idx + 1) > (u32)range->nr) {
 		pr_err("ERR: invalid input index (0x%x)\n", index);
 		return NULL;
 	}
+
 	return &range->funcs[func_idx];
 }
 
 static void show_info(void)
 {
+	struct cpuid_range *range;
 	struct cpuid_func *func;
 
 	if (show_raw) {
 		/* Show all of the raw output of 'cpuid' instr */
-		raw_dump_range(leafs_basic);
-		raw_dump_range(leafs_ext);
+		for_each_cpuid_range(range)
+			raw_dump_range(range);
 		return;
 	}
 
@@ -598,15 +623,8 @@ static void show_info(void)
 	}
 
 	printf("CPU features:\n=============\n\n");
-	show_range(leafs_basic);
-	show_range(leafs_ext);
-}
-
-static void setup_platform_cpuid(void)
-{
-	/* Setup leafs for the basic and extended range */
-	leafs_basic = setup_cpuid_range(0x0);
-	leafs_ext = setup_cpuid_range(0x80000000);
+	for_each_cpuid_range(range)
+		show_range(range);
 }
 
 static void __noreturn usage(int exit_code)
@@ -682,10 +700,13 @@ static void parse_options(int argc, char *argv[])
  */
 int main(int argc, char *argv[])
 {
+	struct cpuid_range *range;
+
 	parse_options(argc, argv);
 
 	/* Setup the cpuid leafs of current platform */
-	setup_platform_cpuid();
+	for_each_cpuid_range(range)
+		setup_cpuid_range(range);
 
 	/* Read and parse the 'cpuid.csv' */
 	parse_text();
-- 
2.46.2


