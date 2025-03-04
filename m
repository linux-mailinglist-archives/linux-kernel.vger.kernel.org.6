Return-Path: <linux-kernel+bounces-543569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD09A4D714
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A921750A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBF1FDA9D;
	Tue,  4 Mar 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhlZ2jxe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZ1Foueq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C4201113
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078412; cv=none; b=N2og6Wx6YlpSdD7TKKiYwXwi1xt3IPvMbtMmSq6iWTaeiJVNm3/AGAGKS4YgPQZlEpmQhKIBGtx3MAkvF8eeYDJVwxpLcdVhyKGTNHz49wEkdbwgga+nx7BSsckRChMfFZN+jYmEnl6/35CNHxpEB0R9yHhDChxlH2zNcVdojlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078412; c=relaxed/simple;
	bh=K1hPwdgJoPejrVvcCPX6kdTs0OYpck9lAIlrDpNss8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coYT6QflQi0MNLVu4r592YqeupEnwk7/RvXIVi3RJEJF5D7cEoOP0rx8qB0S88baMHi5KgMbFnxuGnWiPRcjEFxg/zoHa12hdGsFMZO61bY7jQYZRLSQ83ajI0cJK764wkgFamqq+lDSLz3t6vvmE7mbuTXFFQgVyG5UJrzoxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhlZ2jxe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BZ1Foueq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwov3ONbr2OPdQ03jCxI51Xzj9Lk7s4sEUU22jCJ/XU=;
	b=nhlZ2jxeo2dtSgci28OEKBWavHRzOq2SScz99xEl0nqtV6kCKv6V6dPE+j5xTaIvzk+6Lv
	zcshjRZdeQfiik0G6ma0WMSOesxYB1EY0VCJA4EgEE16DQL6kJxxGYIDjtu8a7dWhXMe5h
	PRjA8NDbKpxEBalnzTDEuID4aMpQpadETC8hjVZWfKhJaCokksYDai4AFnLsheS6aieceO
	36fvZPDm9OVyVuhf54N5DiL4eAuxUU5NxQItc4PrYAesc1oEbUNp6mK4JDTAxSrkhTZ7PT
	1ZEO9AbLvK1uKMJnfSh6arJLTeVDdGi13yaEf908axfm/ome5BxWnf3wITj/XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwov3ONbr2OPdQ03jCxI51Xzj9Lk7s4sEUU22jCJ/XU=;
	b=BZ1FoueqMetQNEaTNLG37qPNDqsDfUBJXE7Wdqptf9q7JVJRrfeKCHlprtAEHh1iHp6oSa
	K7iS+0k4nJ30+vDA==
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
Subject: [PATCH v1 25/40] x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
Date: Tue,  4 Mar 2025 09:51:36 +0100
Message-ID: <20250304085152.51092-26-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
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
  - Intel CPUs via the actual cpuid leaf 0x4

AMD L3 northbridge initialization is also awkwardly placed alongside the
cpuid calls of the first two scenarios.

Refactor all of that as follows:

  - Update AMD's leaf 0x4 emulation comment to represent current state.
  - Clearly label the AMD leaf 0x4 emulation function as a fallback.
  - Split AMD/Hygon and Intel code paths into separate functions.
  - Move AMD L3 northbridge initialization out of leaf 0x4 code, and
    into populate_cache_leaves() where it belongs.  There,
    ci_info_init() can directly store the initialized object in the
    priv pointer of the linux/cacheinfo.h API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 93 ++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index eadd117c05e1..cc320817cfc3 100644
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
 
@@ -690,17 +694,22 @@ static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
 
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


