Return-Path: <linux-kernel+bounces-543565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C727A4D710
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89947174FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D82200BA8;
	Tue,  4 Mar 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sHZPYetF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UPo8pp1Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874C200130
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078403; cv=none; b=Cb7B/+tMPArqcpWd4B8k8lXPb66Ug7EesaTWDgkZsAkPlDrDTTYPvN2vkh0giyfvtgzcO5Jaegy0i4ch+GfN1TLjwy8cgnRORdsOACUh+NgipIvah/yOB65HmLzu6bm+syHWKqy8h/nTR8k9vbLjV26AqXuLsRqXa4EFn59ogIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078403; c=relaxed/simple;
	bh=Ol/Et/TBYJWmcfag2qO/uanvP2pT7byOM/gEyvpusfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kcc/UFoXZlxmAr3cUf4tcu3Mz0UN6OWNaSPdCSSGqvIIJ6UVckfgUqGTjc7uD2LiNMXr27on7pbKpmC1ElKZW9usQr/INkgUXQeQ56ZjMRf5hk2CJ99B54Bjdq3In6cqLkPW7EAuIXczNaMH6odZisIGzDEBYJJw6ZFjtYQlZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sHZPYetF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UPo8pp1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H36zecaZUTad0CS+C/0cOZo8dyDDwXF4r/drrx9Rm0E=;
	b=sHZPYetFhk38K88PP50FRVZB2H9G8qt3lqtnV9PHjEMIIO7azdnXPz0eGTd9x29z8zRLDH
	6Uc+zAwfixcfr4xBMbHmdtxOO0s69L32vOWiJWqiwmsm9TadkQkY3kSXnbPyEJbocPvuGe
	w+jElJJ8MJ5qwy+Tjm/dnvkFfuXgdKAIjjUAzLjyLZ7VUG44Phr/GMyoPLXFmSyOioRKdN
	jsgI50Qb2GKpvhhN/iADuRo0V2QNOvkYW69DnBON91QaDJuFENQquYz5KySDvkLZ1uwi1A
	qnMyK//GXWTvUMPHkEEmorN9iVtVXtreBnwMr+iz+911CwmEI2LAyYA2tBsVJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H36zecaZUTad0CS+C/0cOZo8dyDDwXF4r/drrx9Rm0E=;
	b=UPo8pp1Qwk3xOMlfhkIqW+s7oPGNGge9FdDm9uPeNGGoe3ieYpcLAr6jVyArVs4jx2R6BY
	0Fe3hMs5QpRdqmDQ==
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
Subject: [PATCH v1 22/40] x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
Date: Tue,  4 Mar 2025 09:51:33 +0100
Message-ID: <20250304085152.51092-23-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _cpuid4_info_regs structure is meant to hold the cpuid leaf 0x4
output registers (EAX, EBX, and ECX), as well as derived information
such as the cache node ID and size.

It also contains a reference to amd_northbridge, which is there only to
be "parked" until ci_info_init() can store it in the priv pointer of the
linux/cacheinfo.h API.  That priv pointer is then used by AMD-specific
L3 cache_disable_0/1 sysfs attributes.

Decouple amd_northbridge from _cpuid4_info_regs and pass it explicitly
through the functions at x86/cacheinfo.  Doing so clarifies when
amd_northbridge is actually needed (AMD-only code) and when it is
not (Intel-specific code).  It also prepares for moving the AMD-specific
L3 cache_disable_0/1 sysfs code into its own file in next commit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 45 +++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 6aeabbd94997..2a56c7cc3c2d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -168,7 +168,6 @@ struct _cpuid4_info_regs {
 	union _cpuid4_leaf_ecx ecx;
 	unsigned int id;
 	unsigned long size;
-	struct amd_northbridge *nb;
 };
 
 /* AMD doesn't have CPUID4. Emulate it here to report the same
@@ -573,25 +572,36 @@ cache_get_priv_group(struct cacheinfo *ci)
 	return &cache_private_group;
 }
 
-static void amd_init_l3_cache(struct _cpuid4_info_regs *id4, int index)
+static struct amd_northbridge *amd_init_l3_cache(int index)
 {
+	struct amd_northbridge *nb;
 	int node;
 
 	/* only for L3, and not in virtualized environments */
 	if (index < 3)
-		return;
+		return NULL;
 
 	node = topology_amd_node_id(smp_processor_id());
-	id4->nb = node_to_amd_nb(node);
-	if (id4->nb && !id4->nb->l3_cache.indices)
-		amd_calc_l3_indices(id4->nb);
+	nb = node_to_amd_nb(node);
+	if (nb && !nb->l3_cache.indices)
+		amd_calc_l3_indices(nb);
+
+	return nb;
 }
 #else
-#define amd_init_l3_cache(x, y)
+static struct amd_northbridge *amd_init_l3_cache(int index)
+{
+	return NULL;
+}
 #endif  /* CONFIG_AMD_NB && CONFIG_SYSFS */
 
-static int
-cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
+/*
+ * Fill passed _cpuid4_info_regs structure.
+ * Intel-only code paths should pass NULL for the amd_northbridge
+ * return pointer.
+ */
+static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
+				    struct amd_northbridge **nb)
 {
 	union _cpuid4_leaf_eax	eax;
 	union _cpuid4_leaf_ebx	ebx;
@@ -608,7 +618,9 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 			/* Legacy AMD fallback */
 			amd_cpuid4(index, &eax, &ebx, &ecx);
 		}
-		amd_init_l3_cache(id4, index);
+
+		if (nb)
+			*nb = amd_init_l3_cache(index);
 	} else {
 		/* Intel */
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
@@ -758,7 +770,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			struct _cpuid4_info_regs id4 = {};
 			int retval;
 
-			retval = cpuid4_cache_lookup_regs(i, &id4);
+			retval = cpuid4_cache_lookup_regs(i, &id4, NULL);
 			if (retval < 0)
 				continue;
 
@@ -932,8 +944,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci,
-			 const struct _cpuid4_info_regs *id4)
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
 	ci->attributes			= CACHE_ID;
@@ -944,7 +956,7 @@ static void ci_info_init(struct cacheinfo *ci,
 	ci->size			= id4->size;
 	ci->number_of_sets		= id4->ecx.split.number_of_sets + 1;
 	ci->physical_line_partition	= id4->ebx.split.physical_line_partition + 1;
-	ci->priv			= id4->nb;
+	ci->priv			= nb;
 }
 
 int init_cache_level(unsigned int cpu)
@@ -980,13 +992,14 @@ int populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	struct _cpuid4_info_regs id4 = {};
+	struct amd_northbridge *nb;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = cpuid4_cache_lookup_regs(idx, &id4);
+		ret = cpuid4_cache_lookup_regs(idx, &id4, &nb);
 		if (ret)
 			return ret;
 		get_cache_id(cpu, &id4);
-		ci_info_init(ci++, &id4);
+		ci_info_init(ci++, &id4, nb);
 		__cache_cpumap_setup(cpu, idx, &id4);
 	}
 	this_cpu_ci->cpu_map_populated = true;
-- 
2.48.1


