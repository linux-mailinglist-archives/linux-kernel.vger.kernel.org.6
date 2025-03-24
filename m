Return-Path: <linux-kernel+bounces-573739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9A6A6DBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DAF188F77C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4A26139F;
	Mon, 24 Mar 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbs5T3wZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UPOjpVkd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48AE26139B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823244; cv=none; b=b/VNv5qieGv2M9w9LAh4hlYZBONOie101fLu73Fcq/HARKzh6jo5TOI1z7dz+VEQ/bNg7MA4CAhJSl5ucbZBPYXsw4rx43V6brJ2LOtoIazcpczOqlEyRc/aVqICgjtg+bHrA6DDswS3pOnsQHbac7xlSXXUOhH5XWA2u7FQGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823244; c=relaxed/simple;
	bh=aE016W8b9s8G1p7pMupUW4RrDDEGtwwRil1/PDlHSqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJkoCMJcXi9TdJIlo8jBWhhot10lhq3HajdgMtUJeZ7ihvMdcE+5PgIokTWQzTpiEZkqV062PLraNXjvvLLMALDAIvtluY+wO57UsBLHNgeQJpVx01O4OZOEhgZzSM2iT48e4NsP395oaegRwH7Nh6DFsCSVnXqz42uUR8Bua/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbs5T3wZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UPOjpVkd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIS91U2B+xF0EmmM6VIYVMN1YLL1xaHjZJ8dOVwZViY=;
	b=cbs5T3wZ1by0jy6ZtzyddI1w84OW1SUjMYZLpokdQwu5n+piwnm7YTDD/TPGebEt4edGf/
	+eqUKAPoBdZHKWKs4p8CT24UjnKh0E+CwyZA50ADcRVH46lPTGhE08pS/oxkRnuGsEGmSY
	z6Yuxj9njZxAXOmiWUR3a5NRoKtYGlT0S4POzv8JJ49f/eNpFYpA5lcs5NvbzvYa/zDYRx
	M9KTveK+iXkYN6q1J3zdj29AymaOdGcp3HPzXNfLjWuqFBgLB57Lh9jVhy2Q0SQV+52bYc
	Nt0RdAaO6EgGuNtwBrXmMliOKmDCmUFSQpcsJcUUBvHd1M8SpeZtXKD/REXFHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIS91U2B+xF0EmmM6VIYVMN1YLL1xaHjZJ8dOVwZViY=;
	b=UPOjpVkdjmG/0CvAuxlr8lQeYh6Q/QG5pBRRL8Cbqm7Q7GiBCmVoF7p8VyB5k73068kub9
	wSd64NiL2Mvv8eBA==
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
Subject: [PATCH v4 10/29] x86/cacheinfo: Standardize _cpuid4_info_regs instance naming
Date: Mon, 24 Mar 2025 14:33:05 +0100
Message-ID: <20250324133324.23458-11-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cacheinfo code frequently uses the output registers from CPUID leaf
0x4.  Such registers are cached at struct _cpuid4_info_regs, augmented
with related information, and are then passed across functions.

The naming of these _cpuid4_info_regs instances is confusing at best.

Some instances are called "this_leaf", which is vague as "this" lacks
context and "leaf" is overly generic given that other CPUID leaves are
also processed within cacheinfo.  Other _cpuid4_info_regs instances are
just called "base", adding further ambiguity.

Standardize on id4 for all instances.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 97 +++++++++++++++++----------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b273ecf3f538..1b2a2bf97d7f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -573,7 +573,7 @@ cache_get_priv_group(struct cacheinfo *ci)
 	return &cache_private_group;
 }
 
-static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
+static void amd_init_l3_cache(struct _cpuid4_info_regs *id4, int index)
 {
 	int node;
 
@@ -582,16 +582,16 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
 		return;
 
 	node = topology_amd_node_id(smp_processor_id());
-	this_leaf->nb = node_to_amd_nb(node);
-	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
-		amd_calc_l3_indices(this_leaf->nb);
+	id4->nb = node_to_amd_nb(node);
+	if (id4->nb && !id4->nb->l3_cache.indices)
+		amd_calc_l3_indices(id4->nb);
 }
 #else
 #define amd_init_l3_cache(x, y)
 #endif  /* CONFIG_AMD_NB && CONFIG_SYSFS */
 
 static int
-cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
+cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 {
 	union _cpuid4_leaf_eax	eax;
 	union _cpuid4_leaf_ebx	ebx;
@@ -604,11 +604,11 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 				    &ebx.full, &ecx.full, &edx);
 		else
 			amd_cpuid4(index, &eax, &ebx, &ecx);
-		amd_init_l3_cache(this_leaf, index);
+		amd_init_l3_cache(id4, index);
 	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		cpuid_count(0x8000001d, index, &eax.full,
 			    &ebx.full, &ecx.full, &edx);
-		amd_init_l3_cache(this_leaf, index);
+		amd_init_l3_cache(id4, index);
 	} else {
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
 	}
@@ -616,13 +616,14 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 	if (eax.split.type == CTYPE_NULL)
 		return -EIO; /* better error ? */
 
-	this_leaf->eax = eax;
-	this_leaf->ebx = ebx;
-	this_leaf->ecx = ecx;
-	this_leaf->size = (ecx.split.number_of_sets          + 1) *
-			  (ebx.split.coherency_line_size     + 1) *
-			  (ebx.split.physical_line_partition + 1) *
-			  (ebx.split.ways_of_associativity   + 1);
+	id4->eax = eax;
+	id4->ebx = ebx;
+	id4->ecx = ecx;
+	id4->size = (ecx.split.number_of_sets          + 1) *
+		    (ebx.split.coherency_line_size     + 1) *
+		    (ebx.split.physical_line_partition + 1) *
+		    (ebx.split.ways_of_associativity   + 1);
+
 	return 0;
 }
 
@@ -754,29 +755,29 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * parameters cpuid leaf to find the cache details
 		 */
 		for (i = 0; i < ci->num_leaves; i++) {
-			struct _cpuid4_info_regs this_leaf = {};
+			struct _cpuid4_info_regs id4 = {};
 			int retval;
 
-			retval = cpuid4_cache_lookup_regs(i, &this_leaf);
+			retval = cpuid4_cache_lookup_regs(i, &id4);
 			if (retval < 0)
 				continue;
 
-			switch (this_leaf.eax.split.level) {
+			switch (id4.eax.split.level) {
 			case 1:
-				if (this_leaf.eax.split.type == CTYPE_DATA)
-					new_l1d = this_leaf.size/1024;
-				else if (this_leaf.eax.split.type == CTYPE_INST)
-					new_l1i = this_leaf.size/1024;
+				if (id4.eax.split.type == CTYPE_DATA)
+					new_l1d = id4.size/1024;
+				else if (id4.eax.split.type == CTYPE_INST)
+					new_l1i = id4.size/1024;
 				break;
 			case 2:
-				new_l2 = this_leaf.size/1024;
-				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
+				new_l2 = id4.size/1024;
+				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
 				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			case 3:
-				new_l3 = this_leaf.size/1024;
-				num_threads_sharing = 1 + this_leaf.eax.split.num_threads_sharing;
+				new_l3 = id4.size/1024;
+				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
 				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
@@ -841,7 +842,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    const struct _cpuid4_info_regs *base)
+				    const struct _cpuid4_info_regs *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -867,7 +868,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		unsigned int apicid, nshared, first, last;
 
-		nshared = base->eax.split.num_threads_sharing + 1;
+		nshared = id4->eax.split.num_threads_sharing + 1;
 		apicid = cpu_data(cpu).topo.apicid;
 		first = apicid - (apicid % nshared);
 		last = first + nshared - 1;
@@ -898,7 +899,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 const struct _cpuid4_info_regs *base)
+				 const struct _cpuid4_info_regs *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -908,12 +909,12 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 
 	if (c->x86_vendor == X86_VENDOR_AMD ||
 	    c->x86_vendor == X86_VENDOR_HYGON) {
-		if (__cache_amd_cpumap_setup(cpu, index, base))
+		if (__cache_amd_cpumap_setup(cpu, index, id4))
 			return;
 	}
 
 	ci = this_cpu_ci->info_list + index;
-	num_threads_sharing = 1 + base->eax.split.num_threads_sharing;
+	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
 
 	cpumask_set_cpu(cpu, &ci->shared_cpu_map);
 	if (num_threads_sharing == 1)
@@ -934,18 +935,18 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void ci_info_init(struct cacheinfo *ci,
-			 const struct _cpuid4_info_regs *base)
+			 const struct _cpuid4_info_regs *id4)
 {
-	ci->id				= base->id;
+	ci->id				= id4->id;
 	ci->attributes			= CACHE_ID;
-	ci->level			= base->eax.split.level;
-	ci->type			= cache_type_map[base->eax.split.type];
-	ci->coherency_line_size		= base->ebx.split.coherency_line_size + 1;
-	ci->ways_of_associativity	= base->ebx.split.ways_of_associativity + 1;
-	ci->size			= base->size;
-	ci->number_of_sets		= base->ecx.split.number_of_sets + 1;
-	ci->physical_line_partition	= base->ebx.split.physical_line_partition + 1;
-	ci->priv			= base->nb;
+	ci->level			= id4->eax.split.level;
+	ci->type			= cache_type_map[id4->eax.split.type];
+	ci->coherency_line_size		= id4->ebx.split.coherency_line_size + 1;
+	ci->ways_of_associativity	= id4->ebx.split.ways_of_associativity + 1;
+	ci->size			= id4->size;
+	ci->number_of_sets		= id4->ecx.split.number_of_sets + 1;
+	ci->physical_line_partition	= id4->ebx.split.physical_line_partition + 1;
+	ci->priv			= id4->nb;
 }
 
 int init_cache_level(unsigned int cpu)
@@ -964,15 +965,15 @@ int init_cache_level(unsigned int cpu)
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
-static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4_regs)
+static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned long num_threads_sharing;
 	int index_msb;
 
-	num_threads_sharing = 1 + id4_regs->eax.split.num_threads_sharing;
+	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
 	index_msb = get_count_order(num_threads_sharing);
-	id4_regs->id = c->topo.apicid >> index_msb;
+	id4->id = c->topo.apicid >> index_msb;
 }
 
 int populate_cache_leaves(unsigned int cpu)
@@ -980,15 +981,15 @@ int populate_cache_leaves(unsigned int cpu)
 	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
-	struct _cpuid4_info_regs id4_regs = {};
+	struct _cpuid4_info_regs id4 = {};
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = cpuid4_cache_lookup_regs(idx, &id4_regs);
+		ret = cpuid4_cache_lookup_regs(idx, &id4);
 		if (ret)
 			return ret;
-		get_cache_id(cpu, &id4_regs);
-		ci_info_init(ci++, &id4_regs);
-		__cache_cpumap_setup(cpu, idx, &id4_regs);
+		get_cache_id(cpu, &id4);
+		ci_info_init(ci++, &id4);
+		__cache_cpumap_setup(cpu, idx, &id4);
 	}
 	this_cpu_ci->cpu_map_populated = true;
 
-- 
2.48.1


