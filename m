Return-Path: <linux-kernel+bounces-549841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B9FA557CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B263E7A2E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DC2777FD;
	Thu,  6 Mar 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXg8tFuY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dn+gMbYw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6D2066F9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294238; cv=none; b=KCjoIhVaQIzMHwJFfjSG2O5BeY4yRzy75A8gLa8zL18gD6f9mz6R74GGWiTMnJwF4nU6IkeWZzdC5WKRB7q5NsiSWu4dKM1wzBqgNgHfiC64PJck7oAVJWqrme+E6JM+VA0eaKlvZGorpS0WwLmUWc0XNa6ZaTSRURpVLuFwOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294238; c=relaxed/simple;
	bh=JRqnuXcyiL3IN3+bfXeEvZVUd2YugMhoG/bz8wK0OO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZIpwra6k4qQsr4+XRbRC69si47h7lXk9g14nnegJDFkng1jU0DeiKcZXhZ5jid4s94rE7nMaoaEWVYA0xClQc6hFMv59m3XT0dsDKfYJbT2k7ZHjlZZwV44rSCEClvD+oDiQ/JvBm8jqm3/9Hd+D4awJQA06YM8qeaGnvfZRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXg8tFuY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dn+gMbYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WW1Y8LyQHuRwsd5UmjsCPLakQ7S1kYzT79l6VO68HNw=;
	b=rXg8tFuY+jaENqEa7NejDt3PvKgr5u2zhKOBnXApjHkanSOzaC4/JGyNTqXzUqqDtEVrJI
	pkIfcLlg8Vp/4zqvdXkua1iiyDAZKf7ZestOfsSPDKSFfAqjRdt7x8Z6tm4PWQn6H4k/yj
	h0yAFQ+lJWJqCZMa5azWeUx2xKeGRWn0FBKwFJ8U2R7HLyI0dkjjKdfaJZk9vZe/r6GDjE
	wsiQ4vqxfAt7PD+JgtV7UJY9zw+7SqONBnVhqbOs144/67J8w1jMmzV05xsiBVSUSC2XMn
	5h2KDbVgZnPeyMk9qMr9bn8cHoEdz1xbMp4RfT8MGUHwUdc3oCl7gsUxLSDzlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WW1Y8LyQHuRwsd5UmjsCPLakQ7S1kYzT79l6VO68HNw=;
	b=dn+gMbYwr3eLOuHsJHINBwf7FMvxHGkzmV8rGwmkn8js1KxJJtAS4/46S2EhkzUQ4jv9wz
	LvK6Q3ZZRnMBbXAg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 05/12] tools/x86/kcpuid: Refactor CPUID range handling for future expansion
Date: Thu,  6 Mar 2025 21:49:53 +0100
Message-ID: <20250306205000.227399-6-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kcpuid code assumes only two CPUID index ranges, standard (0x0...)
and extended (0x80000000...).

Since additional CPUID index ranges will be added in further commits,
replace the "is_ext" boolean with enumeration-based range classification.

Collect all CPUID ranges in a structured array and introduce helper
macros to iterate over it.  Use such helpers throughout the code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 103 ++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 41 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index c5e18a397e07..6f6a394486af 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -65,19 +65,52 @@ struct cpuid_func {
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
@@ -175,7 +208,7 @@ static void raw_dump_range(struct cpuid_range *range)
 	u32 f;
 	int i;
 
-	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
+	printf("%s Leafs :\n", range_to_str(range));
 	printf("================\n");
 
 	for (f = 0; (int)f < range->nr; f++) {
@@ -192,29 +225,19 @@ static void raw_dump_range(struct cpuid_range *range)
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
-		err(EXIT_FAILURE, NULL);
-
-	if (input_eax & 0x80000000)
-		range->is_ext = true;
-	else
-		range->is_ext = false;
-
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
@@ -265,8 +288,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		}
 
 	}
-
-	return range;
 }
 
 /*
@@ -325,13 +346,13 @@ static int parse_line(char *line)
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
 
@@ -521,24 +542,28 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	struct cpuid_range *range;
 	u32 func_idx;
 
-	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
-	func_idx = index & 0xffff;
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return NULL;
 
+	func_idx = index & 0xffff;
 	if ((func_idx + 1) > (u32)range->nr) {
 		warnx("Invalid input index (0x%x)", index);
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
 
@@ -565,15 +590,8 @@ static void show_info(void)
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
@@ -649,10 +667,13 @@ static void parse_options(int argc, char *argv[])
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
2.48.1


