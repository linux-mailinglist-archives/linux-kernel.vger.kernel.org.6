Return-Path: <linux-kernel+bounces-573820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83432A6DCD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A5E188F477
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09026281A;
	Mon, 24 Mar 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dPWJyiHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1VG5FbW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003602620EA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826086; cv=none; b=E1GwjBxHolt0lllTH8z6Ao3mwD0m34DetCcK9pIL8gM0VNIsZ99xzY4/xJJkTZcEAS8Na4C7HyjDjLPFNIlzLUS3hguPENI5l7WZC9GnmKBCra3cIlvPSt9RGI0GAB9cW6/S6CFqQSQ57Zbmzb4SPNUN79XPKl7pPiGbxnCQUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826086; c=relaxed/simple;
	bh=dIBtuB0ReHZ0I98KRhCaiisrdZFa1qbIYTsgucwFjWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU21UKAnxuRJ8bWWlSJE9VDFEVttVD4emUR8i3WAcQJEII1dkPdlJMwF9FuHnB2H93jMvQPUjPPBRsEo8UmC5RrY+mcKTFF3Vr/OcYtmpV4SrCkcjhFQRUlWF1oiigratoxI1umUiFWeufpC/1juYvOvooVqVnMrb/RP+BEQOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dPWJyiHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1VG5FbW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wgd9Z5xliY0FLir3Fxtmd2/fDU0K1REFKT60qee/L0c=;
	b=dPWJyiHlyKTtUTIJqGVeHUwlUJ36FPacv+6UhOge48861IfLBF2nCbm+stKkHycfAsVQhh
	S9qTeFU0lngRSw2Dl9FqkHVoojDJD9DS+LEFqoQN23RaHDFutKlpu1DnGuE6F5mt9d8kbm
	G+KWGkr0HFGYsIM9k7VhhR49T9FQpi4UwjEqDhGKtXRR8Mk24Yy9b5JEki0CZ74dDitIW+
	CqGIVYn+pO6lweDIc7N3/j81R5yfDVV3bbh4Nw+P/pMQ+tah2ewhDLjiJLmFrTfDS7LfgC
	NuQVif1i5MT5XdphIfBig5CGM8J1HaD5p8sfc63/4ku/TY3IRKku2rFa9jXkOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wgd9Z5xliY0FLir3Fxtmd2/fDU0K1REFKT60qee/L0c=;
	b=u1VG5FbWVEtq2NCeRhYm5fWHf9MdFS1oWn0gZ0zwojPk4KZGOTUH1qtfILmlvHAeBH1sH3
	CxLOMChVEX8AInAw==
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
Subject: [PATCH v3 11/20] tools/x86/kcpuid: Refactor CPUID range handling for future expansion
Date: Mon, 24 Mar 2025 15:20:32 +0100
Message-ID: <20250324142042.29010-12-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
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
 tools/arch/x86/kcpuid/kcpuid.c | 100 +++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 0dbd93ab652a..00a3b7a8953c 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -66,19 +66,50 @@ struct cpuid_func {
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
+#define for_each_cpuid_range(range)		\
+	for (unsigned int i = 0; i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]); i++)
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
@@ -173,7 +204,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 static void raw_dump_range(struct cpuid_range *range)
 {
-	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
+	printf("%s Leafs :\n", range_to_str(range));
 	printf("================\n");
 
 	for (u32 f = 0; (int)f < range->nr; f++) {
@@ -190,22 +221,12 @@ static void raw_dump_range(struct cpuid_range *range)
 }
 
 #define MAX_SUBLEAF_NUM		64
-struct cpuid_range *setup_cpuid_range(u32 input_eax)
+void setup_cpuid_range(struct cpuid_range *range)
 {
-	struct cpuid_range *range;
 	u32 max_func, idx_func;
 	u32 eax, ebx, ecx, edx;
 
-	cpuid(input_eax, max_func, ebx, ecx, edx);
-
-	range = malloc(sizeof(struct cpuid_range));
-	if (!range)
-		err(EXIT_FAILURE, NULL);
-
-	if (input_eax & 0x80000000)
-		range->is_ext = true;
-	else
-		range->is_ext = false;
+	cpuid(range->index, max_func, ebx, ecx, edx);
 
 	idx_func = (max_func & 0xffff) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
@@ -215,7 +236,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
 
-	for (u32 f = input_eax; f <= max_func; f++) {
+	for (u32 f = range->index; f <= max_func; f++) {
 		u32 max_subleaf = MAX_SUBLEAF_NUM;
 		bool allzero;
 
@@ -254,8 +275,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		}
 
 	}
-
-	return range;
 }
 
 /*
@@ -312,13 +331,13 @@ static void parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	if (index & 0x80000000)
-		range = leafs_ext;
-	else
-		range = leafs_basic;
+	/* Skip line parsing if it's not covered by known ranges */
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return;
 
 	/* Skip line parsing for non-existing indexes */
-	index &= 0x7FFFFFFF;
+	index &= CPUID_FUNCTION_MASK;
 	if ((int)index >= range->nr)
 		return;
 
@@ -489,9 +508,11 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	struct cpuid_range *range;
 	u32 func_idx;
 
-	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
-	func_idx = index & 0xffff;
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return NULL;
 
+	func_idx = index & 0xffff;
 	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
 
@@ -500,12 +521,13 @@ static inline struct cpuid_func *index_to_func(u32 index)
 
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
 
@@ -533,15 +555,8 @@ static void show_info(void)
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
@@ -617,10 +632,13 @@ static void parse_options(int argc, char *argv[])
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


