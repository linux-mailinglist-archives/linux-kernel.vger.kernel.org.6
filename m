Return-Path: <linux-kernel+bounces-573816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC530A6DCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16D2188ABA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C81261599;
	Mon, 24 Mar 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TwXhnVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTr8d3BY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBA261364
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826078; cv=none; b=EdyEQPrK4TlhoassKS9Y+BMcAONBH4lV5vhwspXr75EpiJeO8ujPZpsNj5no7oZLdaBfOnuRqDMN87eYOkrU3LkqC1DbNxjx+xoLoxdANJvNVw7IMlHfkXiV7Z5gZj0ZcwRXnvq+v2VjjxTSYL3+SpTY6E1YZ0yeDCPXrNBI2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826078; c=relaxed/simple;
	bh=hlJEINp0MWs4PvmYX5e/esVtPDzXEBFZZKKS3C7B3kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkiKpUnYNlXoQ/MMI9/F9vgp/4qEEyPuagOa3+bSFGcojrFW9lCxKLBra3vwAyS+myZ8l1cQCUaQYMAmK0j422EzhvpfwLHVKYumN36xJC9f+an+/vCX6FWQEBRKKUmaWc8q4RtvG7DcGTmZtCO/fZEJz2t+YRxfqNLtjGz7CHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TwXhnVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTr8d3BY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=057rGxAD1cvihnAjC3OKTQL5jAwYl0z9M+EMf1Xwooo=;
	b=1TwXhnVM+dY3ebKjP5pwQF0rvXNZ1+nN+kynN73wH5uwVGfsov6pE0FaHObjwZ0RWGlz9Z
	w6VVnz03lnLuclcLf03Bu1YvunPyinlrcuTXTyBOkVQNwQxvhb9mlWLmRiTxYDmIW0/BiE
	jJb6EWt6rX7jA7KLqdwnDw5UWj5D3XBkSyctdC3VkYj/QprDm75PE5cT+WFTgHCB6A5dDI
	uqepRY1UfFO2Xsr7SiNkIxhOpPjImNIOT/WDwPLdPo09ydzMBKZgegNB9WH2LW/ClZ99Yz
	qwLb9cNz65k0o9ewOD/G5AbZwcflb+/hNc7hw3acF9U0JTF86DcSZE1TIGNKnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=057rGxAD1cvihnAjC3OKTQL5jAwYl0z9M+EMf1Xwooo=;
	b=CTr8d3BYIzD5c6nxvfbKwl4s3nyVRy2/r/dlGv5Tn6FKq6Ow7dQPSdoifomfnfBqXRpMe4
	gDqAwihPFwWyNeDw==
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
Subject: [PATCH v3 09/20] tools/x86/kcpuid: Use C99-style for loops
Date: Mon, 24 Mar 2025 15:20:30 +0100
Message-ID: <20250324142042.29010-10-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit e8c07082a810 ("Kbuild: move to -std=gnu11") and the kernel
allows C99-style variable declarations inside of a for() loop.

Adjust the kcpuid code accordingly.

Note, this helps readability as some of the kcpuid functions have a huge
list of variable declarations on top.

Note, remove the empty lines before cpuid() invocations as it is clearer
to have their parameter initialization and the actual call in one block.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 52 ++++++++++++++--------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1db2c8d7cf27..79deb506b349 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -172,13 +172,10 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 static void raw_dump_range(struct cpuid_range *range)
 {
-	u32 f;
-	int i;
-
 	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
 	printf("================\n");
 
-	for (f = 0; (int)f < range->nr; f++) {
+	for (u32 f = 0; (int)f < range->nr; f++) {
 		struct cpuid_func *func = &range->funcs[f];
 
 		/* Skip leaf without valid items */
@@ -186,7 +183,7 @@ static void raw_dump_range(struct cpuid_range *range)
 			continue;
 
 		/* First item is the main leaf, followed by all subleafs */
-		for (i = 0; i < func->nr; i++)
+		for (int i = 0; i < func->nr; i++)
 			leaf_print_raw(&func->leafs[i]);
 	}
 }
@@ -194,15 +191,14 @@ static void raw_dump_range(struct cpuid_range *range)
 #define MAX_SUBLEAF_NUM		64
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
-	u32 max_func, idx_func, subleaf, max_subleaf;
-	u32 eax, ebx, ecx, edx, f = input_eax;
 	struct cpuid_range *range;
-	bool allzero;
+	u32 max_func, idx_func;
+	u32 eax, ebx, ecx, edx;
 
 	eax = input_eax;
 	ebx = ecx = edx = 0;
-
 	cpuid(&eax, &ebx, &ecx, &edx);
+
 	max_func = eax;
 	idx_func = (max_func & 0xffff) + 1;
 
@@ -222,20 +218,21 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
 
-	for (; f <= max_func; f++) {
-		eax = f;
-		subleaf = ecx = 0;
+	for (u32 f = input_eax; f <= max_func; f++) {
+		u32 max_subleaf = MAX_SUBLEAF_NUM;
+		bool allzero;
 
+		eax = f;
+		ecx = 0;
 		cpuid(&eax, &ebx, &ecx, &edx);
-		allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
+
+		allzero = cpuid_store(range, f, 0, eax, ebx, ecx, edx);
 		if (allzero)
 			continue;
 
 		if (!has_subleafs(f))
 			continue;
 
-		max_subleaf = MAX_SUBLEAF_NUM;
-
 		/*
 		 * Some can provide the exact number of subleafs,
 		 * others have to be tried (0xf)
@@ -253,13 +250,12 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		if (f == 0x80000026)
 			max_subleaf = 5;
 
-		for (subleaf = 1; subleaf < max_subleaf; subleaf++) {
+		for (u32 subleaf = 1; subleaf < max_subleaf; subleaf++) {
 			eax = f;
 			ecx = subleaf;
-
 			cpuid(&eax, &ebx, &ecx, &edx);
-			allzero = cpuid_store(range, f, subleaf,
-						eax, ebx, ecx, edx);
+
+			allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
 			if (allzero)
 				continue;
 		}
@@ -280,12 +276,10 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 static void parse_line(char *line)
 {
 	char *str;
-	int i;
 	struct cpuid_range *range;
 	struct cpuid_func *func;
 	struct subleaf *leaf;
 	u32 index;
-	u32 sub;
 	char buffer[512];
 	char *buf;
 	/*
@@ -312,7 +306,7 @@ static void parse_line(char *line)
 	strncpy(buffer, line, 511);
 	buffer[511] = 0;
 	str = buffer;
-	for (i = 0; i < 5; i++) {
+	for (int i = 0; i < 5; i++) {
 		tokens[i] = strtok(str, ",");
 		if (!tokens[i])
 			goto err_exit;
@@ -378,7 +372,7 @@ static void parse_line(char *line)
 	bit_end = strtoul(end, NULL, 0);
 	bit_start = (start) ? strtoul(start, NULL, 0) : bit_end;
 
-	for (sub = subleaf_start; sub <= subleaf_end; sub++) {
+	for (u32 sub = subleaf_start; sub <= subleaf_end; sub++) {
 		leaf = &func->leafs[sub];
 		reg = &leaf->info[reg_index];
 		bdesc = &reg->descs[reg->nr++];
@@ -432,10 +426,10 @@ static void parse_text(void)
 static void show_reg(const struct reg_desc *rdesc, u32 value)
 {
 	const struct bits_desc *bdesc;
-	int start, end, i;
+	int start, end;
 	u32 mask;
 
-	for (i = 0; i < rdesc->nr; i++) {
+	for (int i = 0; i < rdesc->nr; i++) {
 		bdesc = &rdesc->descs[i];
 
 		start = bdesc->start;
@@ -487,17 +481,13 @@ static void show_leaf(struct subleaf *leaf)
 
 static void show_func(struct cpuid_func *func)
 {
-	int i;
-
-	for (i = 0; i < func->nr; i++)
+	for (int i = 0; i < func->nr; i++)
 		show_leaf(&func->leafs[i]);
 }
 
 static void show_range(struct cpuid_range *range)
 {
-	int i;
-
-	for (i = 0; i < range->nr; i++)
+	for (int i = 0; i < range->nr; i++)
 		show_func(&range->funcs[i]);
 }
 
-- 
2.48.1


