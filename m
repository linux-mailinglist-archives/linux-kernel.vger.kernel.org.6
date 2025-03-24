Return-Path: <linux-kernel+bounces-573741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51BA6DBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D387A82E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94026157E;
	Mon, 24 Mar 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYam1kCA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QUGa5R5t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71026157B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823250; cv=none; b=NVGLmnfbsQZnv58kpHcC9dO14VnUjacnh86qjjta8Z/Ra2tnVPQSI6F3UNorRh/gYd0rOvn897ODpKLXmAOpROktNmz8I+m/ywi9gsGa0IuWuOp8JHZi6FjJiQ7dTUz0uV71sfknLTlzHrawCbbwLGYi133AcfhJ3I5gB9J6VdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823250; c=relaxed/simple;
	bh=Te/nCPJoiBNbyUTWshkZ1ebwFT8DMgtFuf2HdtXmP9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY/RzegUfR4ppubZ+a24wMOh3nERoSiuk/YXj7GnNneamB4ul80lrbAbSG/I8Ys53u8x9M/MKLYo50taSBL4/2AtSYKQvFAT1ryoNT83q5u1O7pN0fXaAgn4pD7ch/AfHPYXwn0O9+d9Yk4LEd93y2pfTA91YwUzoSnmc6lApdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYam1kCA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QUGa5R5t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDtSqRQzgAIZaXyH6tzIadWLbO0ybWRSQG6EjY6QOvI=;
	b=uYam1kCAa2W10NYYWkd+YaZOeG1E7HhlxfciG6mhkQjIo6CiQb8cnlMmSy73bj8KAMPHeo
	V1NByC7ymR1p6ga3xNJYrlABl+9PcoccdjcvxGS+j0nSFr7lOXksRMv56nlYSq6OmFCcJ/
	2zCuhpahLVcnBU9f255ByrUvzoMKhNHzzfokeuGjuSlSPt4GVP3NUIPZt3WjsxqBvFJDId
	R1DSX8OsMM1K5YmKUrGxCvp02OJYINhUQG06E9a4P5p8O7B5jNSSvQTKElqb/H81mxPrA6
	3UWLd5AkdUWW5K9+h9H1LAnWJ7aATJ5EY3CLyAPEfX7RzdMH1bHvH3l0GMi7xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDtSqRQzgAIZaXyH6tzIadWLbO0ybWRSQG6EjY6QOvI=;
	b=QUGa5R5tsrVslUmd6gsC8e11XtDbh0Xc+W+qZLkkSYwwfyz6e/yTMFHW+Kdy8Kta9wxQrn
	ARr4By4/97j93xBw==
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
Subject: [PATCH v4 12/29] x86/cacheinfo: Separate amd_northbridge from _cpuid4_info_regs
Date: Mon, 24 Mar 2025 14:33:07 +0100
Message-ID: <20250324133324.23458-13-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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
index f1055e806c9f..8c2b51bb032a 100644
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
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 	union _cpuid4_leaf_eax eax;
@@ -607,7 +617,9 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
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
 
@@ -934,8 +946,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci,
-			 const struct _cpuid4_info_regs *id4)
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
 	ci->attributes			= CACHE_ID;
@@ -946,7 +958,7 @@ static void ci_info_init(struct cacheinfo *ci,
 	ci->size			= id4->size;
 	ci->number_of_sets		= id4->ecx.split.number_of_sets + 1;
 	ci->physical_line_partition	= id4->ebx.split.physical_line_partition + 1;
-	ci->priv			= id4->nb;
+	ci->priv			= nb;
 }
 
 int init_cache_level(unsigned int cpu)
@@ -982,13 +994,14 @@ int populate_cache_leaves(unsigned int cpu)
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


