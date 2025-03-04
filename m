Return-Path: <linux-kernel+bounces-543550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C0A4D701
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E8B16D133
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6A1FDE3D;
	Tue,  4 Mar 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gA8FnjaQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Re+7GWGU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823C1FDE23
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078358; cv=none; b=TOZYqH9/5WtchMlAh1MEqwwrY0q3vCPlE6n6UKJpb9ICEUzNff7eIhpmWn65d2Qte5+yOg2KBVxOexPqJGSRHtv0sVaS+5bN0uXXj+LrXXXgLcmtsaEAL+NrJjSwo+RDNbb5pM76ufCJNkMZOU0j1j17vdqZoU6GLYH6FR/1sJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078358; c=relaxed/simple;
	bh=id36i8J/zyy5ThlQnMyoIPAp4eLTHBrmXgVUE22Q5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRDpmbs+hlwtjyGOkhvk4OA+/B6XPLPPHlA4ypH9LRXw0TSBOFzwJqkYOsfNWGlSYRvHmFM6EwhApf/tztrOHpJh1u2K9spwoF7i5jnyJE+1RzqMqnWroD3eavI8Bss+BZIEnMZ+SJQOHW95QkpVeBCZ3c7dbQ2p+eWsv30gKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gA8FnjaQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Re+7GWGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uldPKprmaw7IDxQ/zbMkEdchvGCL/8P/7tZVYavu56A=;
	b=gA8FnjaQj7K0Mn8XxFnAqU824K0CdwTtojvIJH3Y9drK+KdMgKlauRBlwtKJfQ6Sumg8eb
	R+zi1aquaaNO5S2LQSfzJ2uYJm9EzGvhBwSIYwXFw5M4K7bs4BQ+8nPbc4+l1GNGij43n7
	/g0FQF/Of3S+/u10BvGsxqfgNKs5tsinccZsapqskD2wgi6SACUnxox5LOo/IeYux02l+7
	Bkfulimenw5owtewUdNIeIjU7SZS92K08sEsfxI8CylFt9DsV7oRPRQcvprLV1UY+ixYOT
	qFRQgxVnQ8p/uYJ6RYCv57jAo3ldOSBao2U9ceBUHc/tgYG0RU2nLM4iyvwUDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uldPKprmaw7IDxQ/zbMkEdchvGCL/8P/7tZVYavu56A=;
	b=Re+7GWGUO7spRUWKSkKL3M9NIVQEtplHgs+4L81Oqq/yKgJbqQ8rzADr5smRP/ZI4bjWe1
	XECoF2QBUZuzGwCw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 07/40] x86/cpu: Simplify TLB entry count storage
Date: Tue,  4 Mar 2025 09:51:18 +0100
Message-ID: <20250304085152.51092-8-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of
CPU") introduced u16 "info" arrays for each TLB type.

Since 2012 and each array stores just one type of information: the
number of TLB entries for its respective TLB type.

Replace such arrays with simple variables.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/processor.h | 19 +++++--------
 arch/x86/kernel/cpu/amd.c        | 18 ++++++------
 arch/x86/kernel/cpu/common.c     | 20 ++++++-------
 arch/x86/kernel/cpu/hygon.c      | 16 +++++------
 arch/x86/kernel/cpu/intel.c      | 48 ++++++++++++++++----------------
 5 files changed, 57 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0cd10182e90..0ea227fa027c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -60,18 +60,13 @@ struct vm86;
 # define ARCH_MIN_MMSTRUCT_ALIGN	0
 #endif
 
-enum tlb_infos {
-	ENTRIES,
-	NR_INFO
-};
-
-extern u16 __read_mostly tlb_lli_4k[NR_INFO];
-extern u16 __read_mostly tlb_lli_2m[NR_INFO];
-extern u16 __read_mostly tlb_lli_4m[NR_INFO];
-extern u16 __read_mostly tlb_lld_4k[NR_INFO];
-extern u16 __read_mostly tlb_lld_2m[NR_INFO];
-extern u16 __read_mostly tlb_lld_4m[NR_INFO];
-extern u16 __read_mostly tlb_lld_1g[NR_INFO];
+extern u16 __read_mostly tlb_lli_4k;
+extern u16 __read_mostly tlb_lli_2m;
+extern u16 __read_mostly tlb_lli_4m;
+extern u16 __read_mostly tlb_lld_4k;
+extern u16 __read_mostly tlb_lld_2m;
+extern u16 __read_mostly tlb_lld_4m;
+extern u16 __read_mostly tlb_lld_1g;
 
 /*
  * CPU type and hardware bug flags. Kept separately for each CPU.
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54194f5995de..c43e5d4033bb 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1105,8 +1105,8 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 
 	cpuid(0x80000006, &eax, &ebx, &ecx, &edx);
 
-	tlb_lld_4k[ENTRIES] = (ebx >> 16) & mask;
-	tlb_lli_4k[ENTRIES] = ebx & mask;
+	tlb_lld_4k = (ebx >> 16) & mask;
+	tlb_lli_4k = ebx & mask;
 
 	/*
 	 * K8 doesn't have 2M/4M entries in the L2 TLB so read out the L1 TLB
@@ -1119,26 +1119,26 @@ static void cpu_detect_tlb_amd(struct cpuinfo_x86 *c)
 
 	/* Handle DTLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!((eax >> 16) & mask))
-		tlb_lld_2m[ENTRIES] = (cpuid_eax(0x80000005) >> 16) & 0xff;
+		tlb_lld_2m = (cpuid_eax(0x80000005) >> 16) & 0xff;
 	else
-		tlb_lld_2m[ENTRIES] = (eax >> 16) & mask;
+		tlb_lld_2m = (eax >> 16) & mask;
 
 	/* a 4M entry uses two 2M entries */
-	tlb_lld_4m[ENTRIES] = tlb_lld_2m[ENTRIES] >> 1;
+	tlb_lld_4m = tlb_lld_2m >> 1;
 
 	/* Handle ITLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!(eax & mask)) {
 		/* Erratum 658 */
 		if (c->x86 == 0x15 && c->x86_model <= 0x1f) {
-			tlb_lli_2m[ENTRIES] = 1024;
+			tlb_lli_2m = 1024;
 		} else {
 			cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
-			tlb_lli_2m[ENTRIES] = eax & 0xff;
+			tlb_lli_2m = eax & 0xff;
 		}
 	} else
-		tlb_lli_2m[ENTRIES] = eax & mask;
+		tlb_lli_2m = eax & mask;
 
-	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+	tlb_lli_4m = tlb_lli_2m >> 1;
 }
 
 static const struct cpu_dev amd_cpu_dev = {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..486395356faf 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -846,13 +846,13 @@ void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 	c->x86_cache_size = l2size;
 }
 
-u16 __read_mostly tlb_lli_4k[NR_INFO];
-u16 __read_mostly tlb_lli_2m[NR_INFO];
-u16 __read_mostly tlb_lli_4m[NR_INFO];
-u16 __read_mostly tlb_lld_4k[NR_INFO];
-u16 __read_mostly tlb_lld_2m[NR_INFO];
-u16 __read_mostly tlb_lld_4m[NR_INFO];
-u16 __read_mostly tlb_lld_1g[NR_INFO];
+u16 __read_mostly tlb_lli_4k;
+u16 __read_mostly tlb_lli_2m;
+u16 __read_mostly tlb_lli_4m;
+u16 __read_mostly tlb_lld_4k;
+u16 __read_mostly tlb_lld_2m;
+u16 __read_mostly tlb_lld_4m;
+u16 __read_mostly tlb_lld_1g;
 
 static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 {
@@ -860,12 +860,10 @@ static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 		this_cpu->c_detect_tlb(c);
 
 	pr_info("Last level iTLB entries: 4KB %d, 2MB %d, 4MB %d\n",
-		tlb_lli_4k[ENTRIES], tlb_lli_2m[ENTRIES],
-		tlb_lli_4m[ENTRIES]);
+		tlb_lli_4k, tlb_lli_2m, tlb_lli_4m);
 
 	pr_info("Last level dTLB entries: 4KB %d, 2MB %d, 4MB %d, 1GB %d\n",
-		tlb_lld_4k[ENTRIES], tlb_lld_2m[ENTRIES],
-		tlb_lld_4m[ENTRIES], tlb_lld_1g[ENTRIES]);
+		tlb_lld_4k, tlb_lld_2m, tlb_lld_4m, tlb_lld_1g);
 }
 
 void get_cpu_vendor(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index c5191b06f9f2..6af4a4a90a52 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -240,26 +240,26 @@ static void cpu_detect_tlb_hygon(struct cpuinfo_x86 *c)
 
 	cpuid(0x80000006, &eax, &ebx, &ecx, &edx);
 
-	tlb_lld_4k[ENTRIES] = (ebx >> 16) & mask;
-	tlb_lli_4k[ENTRIES] = ebx & mask;
+	tlb_lld_4k = (ebx >> 16) & mask;
+	tlb_lli_4k = ebx & mask;
 
 	/* Handle DTLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!((eax >> 16) & mask))
-		tlb_lld_2m[ENTRIES] = (cpuid_eax(0x80000005) >> 16) & 0xff;
+		tlb_lld_2m = (cpuid_eax(0x80000005) >> 16) & 0xff;
 	else
-		tlb_lld_2m[ENTRIES] = (eax >> 16) & mask;
+		tlb_lld_2m = (eax >> 16) & mask;
 
 	/* a 4M entry uses two 2M entries */
-	tlb_lld_4m[ENTRIES] = tlb_lld_2m[ENTRIES] >> 1;
+	tlb_lld_4m = tlb_lld_2m >> 1;
 
 	/* Handle ITLB 2M and 4M sizes, fall back to L1 if L2 is disabled */
 	if (!(eax & mask)) {
 		cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
-		tlb_lli_2m[ENTRIES] = eax & 0xff;
+		tlb_lli_2m = eax & 0xff;
 	} else
-		tlb_lli_2m[ENTRIES] = eax & mask;
+		tlb_lli_2m = eax & mask;
 
-	tlb_lli_4m[ENTRIES] = tlb_lli_2m[ENTRIES] >> 1;
+	tlb_lli_4m = tlb_lli_2m >> 1;
 }
 
 static const struct cpu_dev hygon_cpu_dev = {
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e972c72e2b5d..905f39fce375 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -717,55 +717,55 @@ static void intel_tlb_lookup(const unsigned char desc)
 	entries = intel_tlb_table[k].entries;
 	switch (intel_tlb_table[k].tlb_type) {
 	case STLB_4K:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
 		break;
 	case STLB_4K_2M:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
-		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
-		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
+		tlb_lli_2m = max(tlb_lli_2m, entries);
+		tlb_lld_2m = max(tlb_lld_2m, entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_INST_ALL:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
-		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
+		tlb_lli_2m = max(tlb_lli_2m, entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
 		break;
 	case TLB_INST_4K:
-		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lli_4k = max(tlb_lli_4k, entries);
 		break;
 	case TLB_INST_4M:
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
 		break;
 	case TLB_INST_2M_4M:
-		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
-		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lli_2m = max(tlb_lli_2m, entries);
+		tlb_lli_4m = max(tlb_lli_4m, entries);
 		break;
 	case TLB_DATA_4K:
 	case TLB_DATA0_4K:
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
 		break;
 	case TLB_DATA_4M:
 	case TLB_DATA0_4M:
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_DATA_2M_4M:
 	case TLB_DATA0_2M_4M:
-		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lld_2m = max(tlb_lld_2m, entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_DATA_4K_4M:
-		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
+		tlb_lld_4k = max(tlb_lld_4k, entries);
+		tlb_lld_4m = max(tlb_lld_4m, entries);
 		break;
 	case TLB_DATA_1G_2M_4M:
-		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
-		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
+		tlb_lld_2m = max(tlb_lld_2m, TLB_0x63_2M_4M_ENTRIES);
+		tlb_lld_4m = max(tlb_lld_4m, TLB_0x63_2M_4M_ENTRIES);
 		fallthrough;
 	case TLB_DATA_1G:
-		tlb_lld_1g[ENTRIES] = max(tlb_lld_1g[ENTRIES], entries);
+		tlb_lld_1g = max(tlb_lld_1g, entries);
 		break;
 	}
 }
-- 
2.48.1


