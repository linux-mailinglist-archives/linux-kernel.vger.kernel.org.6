Return-Path: <linux-kernel+bounces-573744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3082A6DBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285AF170123
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F222620D8;
	Mon, 24 Mar 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YA7/R/pg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHE9JkYk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874892620D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823262; cv=none; b=UM+V+NmfEwD1BbE3MsJf1XOtrUt4Ynxg9MBw1SLY4BL4BHrImef63AEET3ANKkLL2AfPxVt+oRYGgqUZwii9UsPBRmAWWSpBBwUawSUN1BuGczW+oBVu66Z9I1oqWqygHeKlNtLraqk34fKiOjVvayHTpl0BahgUmi0m3UEFSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823262; c=relaxed/simple;
	bh=Bjtsf7lg8EHicKEMmbJfmtIdAuqMzZKYuPZta9u7Auo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/hOIQQ6sYY3z2K2dqHTIXVM70O3onTfJ+tBRynBCAPyX3tIHucCOP4NpFHI8BRFNiSOo/qzFqaOzENKlTnYdhQHGBsfPcXDrDDf/jiS8UllDEE4e1hExWv8lJy3uwwu21SpiLDbrM2fCZ9gbEd6y6hVH5Am1JhpgoijXUYDe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YA7/R/pg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHE9JkYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDndO82aVgh8tOwhp/eC/3rwOEZ9NJG0L96Sv7FsXQA=;
	b=YA7/R/pgn2TrAtmOOC5HNinLawIQbex9HXZz94IGK1LGbDwF4UGMR7L6PJHH1n4BU3hHBe
	ErT5u5G4VO+4ZxCa+7fGqOao5sbwQWObIv7IbTv7isCS0+3PB8f7/xzLtFLtQOxbzGZ7Aq
	fnUTk76jXoIjpGfHOQDGpK7bRhDfwy5anQtHy9CTlDglxh1KGJTSJ0L72jCzAXulLKD8YM
	H6lk7XSfPvnjro7qX7shY8eKuIT618/ywWqnan22cNeb67YoNFlxlEav9i2XBm0USRgFTj
	+5/kaC7XaYz1mqI1TjWhy49ywcAbKH8twwD7Q9br/vE6Pmpj9XLpeFlSioXD2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDndO82aVgh8tOwhp/eC/3rwOEZ9NJG0L96Sv7FsXQA=;
	b=FHE9JkYkjaTfJ23HjS0hPv9HHsE5LLa4diTVeuq+MZx2oAPYjc46NRNHYANkoZ9yijgA72
	Oeng7o0Wnu98ApDw==
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
Subject: [PATCH v4 15/29] x86/cacheinfo: Separate Intel and AMD leaf 0x4 code paths
Date: Mon, 24 Mar 2025 14:33:10 +0100
Message-ID: <20250324133324.23458-16-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf 0x4 parsing code at cpuid4_cache_lookup_regs() is ugly and
convoluted.  It is tangled with multiple nested conditions to handle:

  * AMD with TOPEXT, or Hygon CPUs via leaf 0x8000001d

  * Legacy AMD fallback via leaf 0x4 emulation

  * Intel CPUs via the actual CPUID leaf 0x4

Moreover, AMD L3 northbridge initialization is also awkwardly placed
alongside the CPUID calls of the first two scenarios above.  Refactor all
of that as follows:

  * Update AMD's leaf 0x4 emulation comment to represent current state

  * Clearly label the AMD leaf 0x4 emulation function as a fallback

  * Split AMD/Hygon and Intel code paths into separate functions

  * Move AMD L3 northbridge initialization out of CPUID leaf 0x4 code,
    and into populate_cache_leaves() where it belongs.  There,
    ci_info_init() can directly store the initialized object in the
    private pointer of the <linux/cacheinfo.h> API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 95 +++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index ea6fba942d27..10a79d87ce86 100644
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
@@ -297,36 +295,9 @@ amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
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
-	u8 cpu_vendor = boot_cpu_data.x86_vendor;
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
-	u32 edx;
-
-	if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT) || cpu_vendor == X86_VENDOR_HYGON) {
-			/* AMD with TOPOEXT, or HYGON */
-			cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &edx);
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
 
@@ -341,6 +312,42 @@ static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
 	return 0;
 }
 
+static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	u32 ignored;
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
+	u32 ignored;
+
+	cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+
+	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+}
+
+static int fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	u8 cpu_vendor = boot_cpu_data.x86_vendor;
+
+	return (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) ?
+		amd_fill_cpuid4_info(index, id4) :
+		intel_fill_cpuid4_info(index, id4);
+}
+
 static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 {
 	unsigned int		eax, ebx, ecx, edx, op;
@@ -472,7 +479,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			struct _cpuid4_info_regs id4 = {};
 			int retval;
 
-			retval = cpuid4_cache_lookup_regs(i, &id4, NULL);
+			retval = intel_fill_cpuid4_info(i, &id4);
 			if (retval < 0)
 				continue;
 
@@ -692,17 +699,23 @@ static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
 
 int populate_cache_leaves(unsigned int cpu)
 {
-	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
+	u8 cpu_vendor = boot_cpu_data.x86_vendor;
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
+		if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON)
+			nb = amd_init_l3_cache(idx);
+
 		ci_info_init(ci++, &id4, nb);
 		__cache_cpumap_setup(cpu, idx, &id4);
 	}
-- 
2.48.1


