Return-Path: <linux-kernel+bounces-573745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE48EA6DBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A648E170C61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2CD2620F9;
	Mon, 24 Mar 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGMOTatL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDYIJtmY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39AC2620E7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823264; cv=none; b=mC25GH+MUbHbg8rN4ytAD2NJwp56xuIGCyMnuYshP3x34ObpzJ8tLXMwgg5f7pbrTLdkcOA2xwMaZ6Il6iwixfvVa66uyAOgGvvQnOfOA75VzqG5dRv0BNwl1vJp8W05a+aIcJyoZZAfvqO1X4XFLJMmCCxKVk/5DIc3tu8anKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823264; c=relaxed/simple;
	bh=th2v8uIZxkNCwoK+iUYJGOuhkFbvACgd0pAZP4DTsZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S45agc2/6Vm3RwJMp5ViCLzaUurmRpW0Du1K8mcIVB2zg/1qssmSka9E7LTuAmt/n874oRK3xuP0lVifg+Q5ZPfuTPn4EWjri1bF9GOoN2GysyYF1EeAgSzWmUISP7uBF4Ycd3Lmqo9190vMJE99koNxpJ+f4yE7UglKvZANRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGMOTatL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDYIJtmY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONR2OjC3vdtbfqAVF3kBhl5I8v4wLD4Vyr+ztNwbbYs=;
	b=fGMOTatL4a4R1XjH0capG9dpWU8TCEEOwY0e9dbX45Vraso42oLutMWSthsfnT1MPTJnPg
	l8bGAp3rxVsCF/WCP7HaarcOHmOYVkZpyUTa22jbWAI/ZYAZRE7rwlQNq08XDi2E26O1TX
	3vD3Q/7LJyjCFFsqcxmZFpNw88HlwmROzq9dbDCpxyzwG5Bfrm6IVPo8vuM4Svqk8KOXnB
	1qdyn5QlvaSJ6YwfkjIpPe4kbG6MFtgEgP2mEMngL85WnvuPwjPgro4Iey46RWSm90DsSa
	wFlLKGn02CatdBGmrWikyZwFfNHZJeu4Aiaqmc8avcoLzD7OGqHEH63sArhY9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONR2OjC3vdtbfqAVF3kBhl5I8v4wLD4Vyr+ztNwbbYs=;
	b=gDYIJtmYOT16xN4ODPVo5LP+H0qDRPNGY/+2yn4ao6AnZmZ1+uboANgmghiybwTQsStAHe
	xvTWYae6xt/z3JBA==
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
Subject: [PATCH v4 16/29] x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
Date: Mon, 24 Mar 2025 14:33:11 +0100
Message-ID: <20250324133324.23458-17-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parent commits decoupled amd_northbridge from _cpuid4_info_regs, moved
AMD L3 northbridge cache_disable_0/1 sysfs code to its own file, and
splitted AMD vs. Intel leaf 0x4 handling into:

    amd_fill_cpuid4_info()
    intel_fill_cpuid4_info()
    fill_cpuid4_info()

After doing all that, the "_cpuid4_info_regs" name becomes a mouthful.
It is also not totally accurate, as the structure holds cpuid4 derived
information like cache node ID and size -- not just regs.

Rename struct _cpuid4_info_regs to _cpuid4_info.  That new name also
better matches the AMD/Intel leaf 0x4 functions mentioned above.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 10a79d87ce86..2aaa0f830ec3 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -159,7 +159,7 @@ union _cpuid4_leaf_ecx {
 	u32 full;
 };
 
-struct _cpuid4_info_regs {
+struct _cpuid4_info {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
 	union _cpuid4_leaf_ecx ecx;
@@ -295,7 +295,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_leaf_eax eax,
+static int cpuid4_info_fill_done(struct _cpuid4_info *id4, union _cpuid4_leaf_eax eax,
 				 union _cpuid4_leaf_ebx ebx, union _cpuid4_leaf_ecx ecx)
 {
 	if (eax.split.type == CTYPE_NULL)
@@ -312,7 +312,7 @@ static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_le
 	return 0;
 }
 
-static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -327,7 +327,7 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int intel_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -339,7 +339,7 @@ static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 
@@ -476,7 +476,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * parameters cpuid leaf to find the cache details
 		 */
 		for (i = 0; i < ci->num_leaves; i++) {
-			struct _cpuid4_info_regs id4 = {};
+			struct _cpuid4_info id4 = {};
 			int retval;
 
 			retval = intel_fill_cpuid4_info(i, &id4);
@@ -563,7 +563,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    const struct _cpuid4_info_regs *id4)
+				    const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -620,7 +620,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 const struct _cpuid4_info_regs *id4)
+				 const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -655,7 +655,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info *id4,
 			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
@@ -686,7 +686,7 @@ int init_cache_level(unsigned int cpu)
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
-static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
+static void get_cache_id(int cpu, struct _cpuid4_info *id4)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned long num_threads_sharing;
@@ -702,8 +702,8 @@ int populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
-	struct _cpuid4_info_regs id4 = {};
 	struct amd_northbridge *nb = NULL;
+	struct _cpuid4_info id4 = {};
 	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-- 
2.48.1


