Return-Path: <linux-kernel+bounces-564693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80641A6596C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF2F1892D84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DE2036F5;
	Mon, 17 Mar 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJSwrC6R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jdEyKxXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1C1F5858
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230399; cv=none; b=TBehEaJ3N3/ABtPtqqeDNKL3Fkfpac03abAr6FX9Xiu17fECPe3M7pRrb2D/jGDiW8KRMtIylM3nf3E0K3Vu7LHpvYe8bAhNoIvb+tDEOZ/+ynUg9EhZpaEkZtU1kNIl062Vkscj+G5ddRkGxizd+1VZesZ7agaUfoE0joSvlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230399; c=relaxed/simple;
	bh=QU+n/NJIk+w+/8g+uc+PWfwFJF7sfSuYbrRO6ukkfKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoqmNJATOZxMu/wRRWmgGqGRFgUW9A+Itl3ej4v980FaCPF8e9aQJS4ELk9hjIopK7+ghbdET7CTLVisQh7u7xduI6ezVleftBvm7XRaUBZnGt3MZoAg0vlXfRjRGzOsc08p7hNvUBjqaufZQpzTGnv5MW6FpdOV3XfV4qXgZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJSwrC6R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jdEyKxXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjaYjptHFnbTwCLwkZnghv3h+4uXNh74xfpfo98weo8=;
	b=WJSwrC6ResG4xbbaLYvh1ir16KNb9nvlSImSR8LrTqzFZneAemDigax7/In307Pe15G1eP
	2sgaVpFyGgT1wBWUvCTiPR5wk7tYQuPDwPdNl9e9X30doyN1USyWWo8G4WOIV6qr0muxzm
	pTv/Uj8Th3wePvkbXllugyHAbvNgkU7MLBR6Z0SmL0kwODu0obOULGtTvqZu2MNcYSgxjm
	njuRSxM79ScXakGOvAaRmcXAc9EYSoxFOwBGZerLF0NMrcUn/u9fVutw0yOWAkpGVc9Sxc
	0PCbLEPZObxE5Ojn8ZAn9cl+w/5Rdg17Cl77ExyFt9vS31deTiz/TneresS//g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjaYjptHFnbTwCLwkZnghv3h+4uXNh74xfpfo98weo8=;
	b=jdEyKxXpVFRycMbg30QvFNzdQDeUwJRh8sWKrnZINV+JrfRgG4Vw9QD5Ra/1YAdj8dt9VF
	9aTGHJPCUTTsbiCw==
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
Subject: [PATCH v2 15/29] x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
Date: Mon, 17 Mar 2025 17:47:31 +0100
Message-ID: <20250317164745.4754-16-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf 0x4 parsing code at cpuid4_cache_lookup_regs() is ugly and
convoluted.  It's tangled with multiple nested conditions to handle:

  - AMD with TOPEXT, or Hygon CPUs via leaf 0x8000001d
  - Legacy AMD fallback via leaf 0x4 emulation
  - Intel CPUs via the actual CPUID leaf 0x4

AMD L3 northbridge initialization is also awkwardly placed alongside the
CPUID calls of the first two scenarios.

Refactor all of that as follows:

  - Update AMD's leaf 0x4 emulation comment to represent current state.
  - Clearly label the AMD leaf 0x4 emulation function as a fallback.
  - Split AMD/Hygon and Intel code paths into separate functions.
  - Move AMD L3 northbridge initialization out of leaf 0x4 code, and
    into populate_cache_leaves() where it belongs.  There,
    ci_info_init() can directly store the initialized object in the
    private pointer of the <linux/cacheinfo.h> API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 93 ++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 211272b70006..5d4ae5e048a0 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -167,12 +167,11 @@ struct _cpuid4_info_regs {
 	unsigned long size;
 };
 
-/* AMD doesn't have CPUID4. Emulate it here to report the same
-   information to the user.  This makes some assumptions about the machine:
-   L2 not shared, no SMT etc. that is currently true on AMD CPUs.
+/*
+ * Fallback AMD CPUID(4) emulation
+ * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
+ */
 
-   In theory the TLBs could be reported as fake type (they are in "dummy").
-   Maybe later */
 union l1_cache {
 	struct {
 		unsigned line_size:8;
@@ -228,9 +227,8 @@ static const enum cache_type cache_type_map[] = {
 	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
 };
 
-static void
-amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
-	   union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
+static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
+			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
 	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
 	union l1_cache l1i, l1d;
@@ -297,37 +295,9 @@ amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-/*
- * Fill passed _cpuid4_info_regs structure.
- * Intel-only code paths should pass NULL for the amd_northbridge
- * return pointer.
- */
-static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
-				    struct amd_northbridge **nb)
+static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_leaf_eax eax,
+				 union _cpuid4_leaf_ebx ebx, union _cpuid4_leaf_ecx ecx)
 {
-	union _cpuid4_leaf_eax	eax;
-	union _cpuid4_leaf_ebx	ebx;
-	union _cpuid4_leaf_ecx	ecx;
-	unsigned		edx;
-
-	if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor)) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT) ||
-		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			/* AMD with TOPOEXT, or HYGON */
-			cpuid_count(0x8000001d, index, &eax.full,
-				    &ebx.full, &ecx.full, &edx);
-		} else {
-			/* Legacy AMD fallback */
-			amd_cpuid4(index, &eax, &ebx, &ecx);
-		}
-
-		if (nb)
-			*nb = amd_init_l3_cache(index);
-	} else {
-		/* Intel */
-		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
-	}
-
 	if (eax.split.type == CTYPE_NULL)
 		return -EIO;
 
@@ -342,6 +312,40 @@ static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
 	return 0;
 }
 
+static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	unsigned int ignored;
+
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT) || boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+	else
+		legacy_amd_cpuid4(index, &eax, &ebx, &ecx);
+
+	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+}
+
+static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	unsigned int ignored;
+
+	cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+
+	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+}
+
+static int fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	return x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor) ?
+		amd_fill_cpuid4_info(index, id4) :
+		intel_fill_cpuid4_info(index, id4);
+}
+
 static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 {
 	unsigned int		eax, ebx, ecx, edx, op;
@@ -472,7 +476,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			struct _cpuid4_info_regs id4 = {};
 			int retval;
 
-			retval = cpuid4_cache_lookup_regs(i, &id4, NULL);
+			retval = intel_fill_cpuid4_info(i, &id4);
 			if (retval < 0)
 				continue;
 
@@ -691,17 +695,22 @@ static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
 
 int populate_cache_leaves(unsigned int cpu)
 {
-	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	struct _cpuid4_info_regs id4 = {};
-	struct amd_northbridge *nb;
+	struct amd_northbridge *nb = NULL;
+	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = cpuid4_cache_lookup_regs(idx, &id4, &nb);
+		ret = fill_cpuid4_info(idx, &id4);
 		if (ret)
 			return ret;
+
 		get_cache_id(cpu, &id4);
+
+		if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
+			nb = amd_init_l3_cache(idx);
+
 		ci_info_init(ci++, &id4, nb);
 		__cache_cpumap_setup(cpu, idx, &id4);
 	}
-- 
2.48.1


