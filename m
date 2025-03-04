Return-Path: <linux-kernel+bounces-543559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D882EA4D70C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04982174DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C941FF7AE;
	Tue,  4 Mar 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFCv2pcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cTjxwVqC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B01FF613
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078385; cv=none; b=oVi9yXSRK/j0lNb1UUP4FQRXlciXzAr1qiOpcuaAdbJuxuEh01MBhQruYJnNdSXz4HyZ/pxH2nIbtTZlEsJ72bT3X38DUdN+CHXU6ebrdyWrPWVSjeS5OdNuQqhJR6dikokNJ2QC120F+47Dq9+b9uV/hHm0Ri7uFKFvCjJn8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078385; c=relaxed/simple;
	bh=FXI0EngGufpm1ClJZawAgo79SDBHK0lEe5QmJ9Fn4/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUsjr9q32JZ/FdTQRTL6HIZVPjMBHhDnGiMtOb49P+3aVTeJ7KTNu1LpR+2dfSTzvEa4s7mcII9V4jiH3WOEOba0CmtwGNHegPebR6pvhTwr46vSMo3txW5Lt0fZlMcFx8BW1bjcp1FamOTjEsj/QV9rClnNAhU0qWlyru/lhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFCv2pcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cTjxwVqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR43TTpUL94TkpNNz9T2pfL2pjZcLoSQvUc3OWGFnAg=;
	b=iFCv2pcC45HY4800VbKA7hrUIFvD7VmWxvhzljI/iYPx4hx7wpJN0Ww9XQqNmuID7JFw2H
	/8YU6dEZY9Zb/clIuCxdhReqWXaRMpm3V5NBaPw720t3GIznFKu7a3NLkjs4fmvAh29t0Z
	Jtb/NioUy/Z4UkvDTS4YQ0MHWC+bORNWWrgNxmrkslSgrZ0dYBcEBccFc8wNf01zSLFvd+
	S53Aqzksj2/ov+uOn2htS5DFm8fA6ym1aCJi3gxff7Y7wjZkZvDldmTEqIJ/O/dQilmAf1
	tOfdHVaTQsv12y6bDeJNOoG4VHRu+EptaOyiXc2IPfC7THodn2uhe/mrKviISw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nR43TTpUL94TkpNNz9T2pfL2pjZcLoSQvUc3OWGFnAg=;
	b=cTjxwVqCdCjMALGXTIoPPDefM9V/PzFet7H1lbrojf7uFADcW4ObKLVBZdSEBkEgdm72/O
	hNS2Xcocu9gMDUDw==
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
Subject: [PATCH v1 16/40] x86/cacheinfo: Use proper name for cacheinfo instances
Date: Tue,  4 Mar 2025 09:51:27 +0100
Message-ID: <20250304085152.51092-17-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The cacheinfo structure defined at include/linux/cacheinfo.h is a
generic cache info object representation.

Calling its instances at x86 cacheinfo.c "leaf" confuses it with a cpuid
leaf -- especially that multiple cpuid calls are already sprinkled across
that file.  Most of such instances also have a redundant "this_" prefix.

Rename all of the cacheinfo "this_leaf" instances to just "ci".

[darwi: Move into separate commit and write commit log]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 89 ++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 24a7503f37e2..5deffc834291 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -349,11 +349,10 @@ static int amd_get_l3_disable_slot(struct amd_northbridge *nb, unsigned slot)
 	return -1;
 }
 
-static ssize_t show_cache_disable(struct cacheinfo *this_leaf, char *buf,
-				  unsigned int slot)
+static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int slot)
 {
 	int index;
-	struct amd_northbridge *nb = this_leaf->priv;
+	struct amd_northbridge *nb = ci->priv;
 
 	index = amd_get_l3_disable_slot(nb, slot);
 	if (index >= 0)
@@ -367,8 +366,8 @@ static ssize_t								\
 cache_disable_##slot##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)	\
 {									\
-	struct cacheinfo *this_leaf = dev_get_drvdata(dev);		\
-	return show_cache_disable(this_leaf, buf, slot);		\
+	struct cacheinfo *ci = dev_get_drvdata(dev);			\
+	return show_cache_disable(ci, buf, slot);			\
 }
 SHOW_CACHE_DISABLE(0)
 SHOW_CACHE_DISABLE(1)
@@ -435,18 +434,17 @@ static int amd_set_l3_disable_slot(struct amd_northbridge *nb, int cpu,
 	return 0;
 }
 
-static ssize_t store_cache_disable(struct cacheinfo *this_leaf,
-				   const char *buf, size_t count,
-				   unsigned int slot)
+static ssize_t store_cache_disable(struct cacheinfo *ci, const char *buf,
+				   size_t count, unsigned int slot)
 {
 	unsigned long val = 0;
 	int cpu, err = 0;
-	struct amd_northbridge *nb = this_leaf->priv;
+	struct amd_northbridge *nb = ci->priv;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	cpu = cpumask_first(&this_leaf->shared_cpu_map);
+	cpu = cpumask_first(&ci->shared_cpu_map);
 
 	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
@@ -467,8 +465,8 @@ cache_disable_##slot##_store(struct device *dev,			\
 			     struct device_attribute *attr,		\
 			     const char *buf, size_t count)		\
 {									\
-	struct cacheinfo *this_leaf = dev_get_drvdata(dev);		\
-	return store_cache_disable(this_leaf, buf, count, slot);	\
+	struct cacheinfo *ci = dev_get_drvdata(dev);			\
+	return store_cache_disable(ci, buf, count, slot);		\
 }
 STORE_CACHE_DISABLE(0)
 STORE_CACHE_DISABLE(1)
@@ -476,8 +474,8 @@ STORE_CACHE_DISABLE(1)
 static ssize_t subcaches_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
-	int cpu = cpumask_first(&this_leaf->shared_cpu_map);
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	int cpu = cpumask_first(&ci->shared_cpu_map);
 
 	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
 }
@@ -486,8 +484,8 @@ static ssize_t subcaches_store(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
-	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
-	int cpu = cpumask_first(&this_leaf->shared_cpu_map);
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	int cpu = cpumask_first(&ci->shared_cpu_map);
 	unsigned long val;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -511,10 +509,10 @@ cache_private_attrs_is_visible(struct kobject *kobj,
 			       struct attribute *attr, int unused)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+	struct cacheinfo *ci = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
-	if (!this_leaf->priv)
+	if (!ci->priv)
 		return 0;
 
 	if ((attr == &dev_attr_subcaches.attr) &&
@@ -562,11 +560,11 @@ static void init_amd_l3_attrs(void)
 }
 
 const struct attribute_group *
-cache_get_priv_group(struct cacheinfo *this_leaf)
+cache_get_priv_group(struct cacheinfo *ci)
 {
-	struct amd_northbridge *nb = this_leaf->priv;
+	struct amd_northbridge *nb = ci->priv;
 
-	if (this_leaf->level < 3 || !nb)
+	if (ci->level < 3 || !nb)
 		return NULL;
 
 	if (nb && nb->l3_cache.indices)
@@ -846,7 +844,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 				    struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
-	struct cacheinfo *this_leaf;
+	struct cacheinfo *ci;
 	int i, sibling;
 
 	/*
@@ -858,12 +856,12 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 			this_cpu_ci = get_cpu_cacheinfo(i);
 			if (!this_cpu_ci->info_list)
 				continue;
-			this_leaf = this_cpu_ci->info_list + index;
+			ci = this_cpu_ci->info_list + index;
 			for_each_cpu(sibling, cpu_llc_shared_mask(cpu)) {
 				if (!cpu_online(sibling))
 					continue;
 				cpumask_set_cpu(sibling,
-						&this_leaf->shared_cpu_map);
+						&ci->shared_cpu_map);
 			}
 		}
 	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
@@ -883,14 +881,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 			if ((apicid < first) || (apicid > last))
 				continue;
 
-			this_leaf = this_cpu_ci->info_list + index;
+			ci = this_cpu_ci->info_list + index;
 
 			for_each_online_cpu(sibling) {
 				apicid = cpu_data(sibling).topo.apicid;
 				if ((apicid < first) || (apicid > last))
 					continue;
 				cpumask_set_cpu(sibling,
-						&this_leaf->shared_cpu_map);
+						&ci->shared_cpu_map);
 			}
 		}
 	} else
@@ -903,7 +901,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 				 struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf, *sibling_leaf;
+	struct cacheinfo *ci, *sibling_ci;
 	unsigned long num_threads_sharing;
 	int index_msb, i;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -914,10 +912,10 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 			return;
 	}
 
-	this_leaf = this_cpu_ci->info_list + index;
+	ci = this_cpu_ci->info_list + index;
 	num_threads_sharing = 1 + base->eax.split.num_threads_sharing;
 
-	cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
+	cpumask_set_cpu(cpu, &ci->shared_cpu_map);
 	if (num_threads_sharing == 1)
 		return;
 
@@ -929,28 +927,27 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 
 			if (i == cpu || !sib_cpu_ci->info_list)
 				continue;/* skip if itself or no cacheinfo */
-			sibling_leaf = sib_cpu_ci->info_list + index;
-			cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
-			cpumask_set_cpu(cpu, &sibling_leaf->shared_cpu_map);
+			sibling_ci = sib_cpu_ci->info_list + index;
+			cpumask_set_cpu(i, &ci->shared_cpu_map);
+			cpumask_set_cpu(cpu, &sibling_ci->shared_cpu_map);
 		}
 }
 
-static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 struct _cpuid4_info_regs *base)
+static void ci_info_init(struct cacheinfo *ci, struct _cpuid4_info_regs *base)
 {
-	this_leaf->id = base->id;
-	this_leaf->attributes = CACHE_ID;
-	this_leaf->level = base->eax.split.level;
-	this_leaf->type = cache_type_map[base->eax.split.type];
-	this_leaf->coherency_line_size =
+	ci->id = base->id;
+	ci->attributes = CACHE_ID;
+	ci->level = base->eax.split.level;
+	ci->type = cache_type_map[base->eax.split.type];
+	ci->coherency_line_size =
 				base->ebx.split.coherency_line_size + 1;
-	this_leaf->ways_of_associativity =
+	ci->ways_of_associativity =
 				base->ebx.split.ways_of_associativity + 1;
-	this_leaf->size = base->size;
-	this_leaf->number_of_sets = base->ecx.split.number_of_sets + 1;
-	this_leaf->physical_line_partition =
+	ci->size = base->size;
+	ci->number_of_sets = base->ecx.split.number_of_sets + 1;
+	ci->physical_line_partition =
 				base->ebx.split.physical_line_partition + 1;
-	this_leaf->priv = base->nb;
+	ci->priv = base->nb;
 }
 
 int init_cache_level(unsigned int cpu)
@@ -984,7 +981,7 @@ int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct cacheinfo *ci = this_cpu_ci->info_list;
 	struct _cpuid4_info_regs id4_regs = {};
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
@@ -992,7 +989,7 @@ int populate_cache_leaves(unsigned int cpu)
 		if (ret)
 			return ret;
 		get_cache_id(cpu, &id4_regs);
-		ci_leaf_init(this_leaf++, &id4_regs);
+		ci_info_init(ci++, &id4_regs);
 		__cache_cpumap_setup(cpu, idx, &id4_regs);
 	}
 	this_cpu_ci->cpu_map_populated = true;
-- 
2.48.1


