Return-Path: <linux-kernel+bounces-564690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68EA65939
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5777A3AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754C1F3BBF;
	Mon, 17 Mar 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ebKZZsqZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="++hWBMM5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B201EEA5D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230389; cv=none; b=PJF9b0rxooTWD07metDjh1Z4WgN0wbXXI4tLKgccncSaQXJCssPrxfOSaYyMv62AwOoZZ0Ooco/0YFx/YlxZLtda0yQz259s8YmV2kbruZeTAcjN1tSTAIldGwJOPue6Hur14KWxKG4fwwzG2PlNScPcmt/gPuloONYqoFbd0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230389; c=relaxed/simple;
	bh=k14IRKgI1MHFaQ17zE1+BsBs6nw8jZzL0inbLKS1vdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCugH8tRNLcbTM2CnNxYOYhZq7RIqudQU8zD6p/q04T7+KQkJHMezBlS9Z4I2FZ9GKGtq//Gv4PYp7DARHSFBrYXoJsHgH11R6A/2hd7ZLPAUkY5kMrZmDT7W8y+ggInaoYjDoQYXWl4rg4Y536exUd47tAMG84O0s2yzYbwAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ebKZZsqZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=++hWBMM5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgnJawMPP7oCb+nS9pnvSb4wGQnGnu0kqEKVTGLMcGs=;
	b=ebKZZsqZQUF7Rrj3NqdPuUES/AWvjrbN5HMztR2bmSm8fOO1+J3pdikv6aKmPyxb/qvxob
	YadEOhbOQ2AE4LxoDb8X/8dOgCuAN2BxpGO0bNAWJQDad7QTDfFpnduGHbu7x2RMmtM3jq
	vNg106f9uJ95BBew/HJvM7gZkQWQOaW87jcNwWNg7sG6rWo72O7uGq4DatqVoHDyrnZADB
	azYH5ibssa+bWKqaMhwTFvoSvVPEuCubuOx74QLr+WsrUuxDyB0yabjhvv9ncWhqTkoeDK
	XFtv0F4NmKYGLJig/JR94QBX7/cQYyFEBmHFgrpuTi9sBJAeZjy/E2uBhuRGWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgnJawMPP7oCb+nS9pnvSb4wGQnGnu0kqEKVTGLMcGs=;
	b=++hWBMM5+ugVkNN/FLBgLOmp4I2MB5at0cNaO2R5cRl7ht0IS8utwKMnmQtxPyWRsMvE3Q
	4CRThC1cpK2/LtCw==
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
Subject: [PATCH v2 12/29] x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
Date: Mon, 17 Mar 2025 17:47:28 +0100
Message-ID: <20250317164745.4754-13-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The _cpuid4_info_regs structure is meant to hold the CPUID leaf 0x4
output registers (EAX, EBX, and ECX), as well as derived information
such as the cache node ID and size.

It also contains a reference to amd_northbridge, which is there only to
be "parked" until ci_info_init() can store it in the priv pointer of the
<linux/cacheinfo.h> API.  That priv pointer is then used by AMD-specific
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
index 3eff2f321388..690a6088bff2 100644
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
 
@@ -933,8 +945,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci,
-			 const struct _cpuid4_info_regs *id4)
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
 	ci->attributes			= CACHE_ID;
@@ -945,7 +957,7 @@ static void ci_info_init(struct cacheinfo *ci,
 	ci->size			= id4->size;
 	ci->number_of_sets		= id4->ecx.split.number_of_sets + 1;
 	ci->physical_line_partition	= id4->ebx.split.physical_line_partition + 1;
-	ci->priv			= id4->nb;
+	ci->priv			= nb;
 }
 
 int init_cache_level(unsigned int cpu)
@@ -981,13 +993,14 @@ int populate_cache_leaves(unsigned int cpu)
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


