Return-Path: <linux-kernel+bounces-573752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53888A6DBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA7B18928D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256F263882;
	Mon, 24 Mar 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bImzMsJs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5RAIQ35h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7E262D0D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823286; cv=none; b=rUfcfC7Kh1xPh62NMMhZAmXax08w+h270/2e58DXHIW8Td+dgRCQFpi3444MDsnxi+BoQMCQwh/zdc1em2MqN3W76EMGvnkDohOz6icTrUYGSgSZITfP/MJgo/d80PvaOhkm19K/qAhJZO4A0nsVp8rodEpq1hMrFU6WQc8JcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823286; c=relaxed/simple;
	bh=m/K01KgXGVST7kNCinXLCQl3HbIi2grBBdYW7CRD18A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJvXccAEmPd8I8S2kbu/bEZiTCjHTsvyomMAuanVPcvQK5VM49lL9xfSacJJh/TAKQD03kj8FLU22fENZVdsHCuXY9LPUJ8WMJzMvU4MVp46f5WWr6pRZfDj768pmO/NEk5WZbpQzgvYNcvSyuw5iMym+RdGl98HLpJnOwFnP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bImzMsJs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5RAIQ35h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWsflW12l3h8RYZJxhtdnrG6wdMqcnEWMvzT4KUkGLM=;
	b=bImzMsJsw6F/PkNndmEAosCdikzOV7ogqDpu5Vqp2Ijw3EMvKlzD60Mihfcu+r3BfXsct5
	mVfy9RDwISw6GndC3YinymcxfqHtpZQA4UyUgXXKZdr8KuZMpGggKYgneAKG9rMe5IAjZG
	2j+gXzeDmI5iVPE3SM2df74/nLGjpZKYVmb5L10bPD2XXTOLU9iMLo7VPc2rjxfsrbo6qi
	mDTv8Vg1B/LCwarLStL6aOD959MrXzIqKnRSGdqthvz4fuVoubgOx2Jz7fY4emh1xakbkV
	TzxLHUaX1q+QAvXGkzplB3cld203+hTJW897MoeUxqF0Mr9DtlAW8OEIw01EMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWsflW12l3h8RYZJxhtdnrG6wdMqcnEWMvzT4KUkGLM=;
	b=5RAIQ35hT6hYaqu5qJTH1BY9t355dY+u5PDq2F0PTCBb4jEQYh0TiCh2mQ2c3MYvfKuEZL
	uHpXXnSnmLsdciCg==
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
Subject: [PATCH v4 23/29] x86/cacheinfo: Separate leaf 0x2 handling and post-processing logic
Date: Mon, 24 Mar 2025 14:33:18 +0100
Message-ID: <20250324133324.23458-24-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic of init_intel_cacheinfo() is quite convoluted: it mixes leaf
0x4 parsing, leaf 0x2 parsing, plus some post-processing, in a single
place.

Begin simplifying its logic by extracting the leaf 0x2 parsing code, and
the post-processing logic, into their own functions.  While at it,
rework the SMT LLC topology ID comment for clarity.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 106 +++++++++++++++++---------------
 1 file changed, 58 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e399bf2a701d..b39aad1ecf9c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -355,14 +355,56 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 	ci->num_leaves = find_num_cache_leaves(c);
 }
 
-void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
+				 unsigned int l2, unsigned int l1i, unsigned int l1d)
+{
+	/*
+	 * If llc_id is still unset, then cpuid_level < 4, which implies
+	 * that the only possibility left is SMT.  Since CPUID(2) doesn't
+	 * specify any shared caches and SMT shares all caches, we can
+	 * unconditionally set LLC ID to the package ID so that all
+	 * threads share it.
+	 */
+	if (c->topo.llc_id == BAD_APICID)
+		c->topo.llc_id = c->topo.pkg_id;
+
+	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : l1i + l1d);
+
+	if (!l2)
+		cpu_detect_cache_sizes(c);
+}
+
+/*
+ * Legacy Intel CPUID(2) path if CPUID(4) is not available.
+ */
+static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
-	/* Cache sizes */
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
-	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
-	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
-	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
+	const struct leaf_0x2_table *entry;
+	union leaf_0x2_regs regs;
+	u8 *ptr;
+
+	if (c->cpuid_level < 2)
+		return;
+
+	cpuid_get_leaf_0x2_regs(&regs);
+	for_each_leaf_0x2_entry(regs, ptr, entry) {
+		switch (entry->c_type) {
+		case CACHE_L1_INST:	l1i += entry->c_size; break;
+		case CACHE_L1_DATA:	l1d += entry->c_size; break;
+		case CACHE_L2:		l2  += entry->c_size; break;
+		case CACHE_L3:		l3  += entry->c_size; break;
+		}
+	}
+
+	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
+}
+
+void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+{
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
+	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
+	unsigned int l2_id = 0, l3_id = 0;
 
 	if (c->cpuid_level > 3) {
 		/*
@@ -376,7 +418,8 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < ci->num_leaves; i++) {
+		for (int i = 0; i < ci->num_leaves; i++) {
+			unsigned int num_threads_sharing, index_msb;
 			struct _cpuid4_info id4 = {};
 			int retval;
 
@@ -387,18 +430,18 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			switch (id4.eax.split.level) {
 			case 1:
 				if (id4.eax.split.type == CTYPE_DATA)
-					new_l1d = id4.size/1024;
+					l1d = id4.size / 1024;
 				else if (id4.eax.split.type == CTYPE_INST)
-					new_l1i = id4.size/1024;
+					l1i = id4.size / 1024;
 				break;
 			case 2:
-				new_l2 = id4.size/1024;
+				l2 = id4.size / 1024;
 				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
 				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			case 3:
-				new_l3 = id4.size/1024;
+				l3 = id4.size / 1024;
 				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
 				index_msb = get_count_order(num_threads_sharing);
 				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
@@ -411,52 +454,19 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		const struct leaf_0x2_table *entry;
-		union leaf_0x2_regs regs;
-		u8 *ptr;
-
-		cpuid_get_leaf_0x2_regs(&regs);
-		for_each_leaf_0x2_entry(regs, ptr, entry) {
-			switch (entry->c_type) {
-			case CACHE_L1_INST:	l1i += entry->c_size; break;
-			case CACHE_L1_DATA:	l1d += entry->c_size; break;
-			case CACHE_L2:		l2  += entry->c_size; break;
-			case CACHE_L3:		l3  += entry->c_size; break;
-			}
-		}
+		intel_cacheinfo_0x2(c);
+		return;
 	}
 
-	if (new_l1d)
-		l1d = new_l1d;
-
-	if (new_l1i)
-		l1i = new_l1i;
-
-	if (new_l2) {
-		l2 = new_l2;
+	if (l2) {
 		c->topo.llc_id = l2_id;
 		c->topo.l2c_id = l2_id;
 	}
 
-	if (new_l3) {
-		l3 = new_l3;
+	if (l3)
 		c->topo.llc_id = l3_id;
-	}
 
-	/*
-	 * If llc_id is not yet set, this means cpuid_level < 4 which in
-	 * turns means that the only possibility is SMT (as indicated in
-	 * cpuid1). Since cpuid2 doesn't specify shared caches, and we know
-	 * that SMT shares all caches, we can unconditionally set cpu_llc_id to
-	 * c->topo.pkg_id.
-	 */
-	if (c->topo.llc_id == BAD_APICID)
-		c->topo.llc_id = c->topo.pkg_id;
-
-	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
-
-	if (!l2)
-		cpu_detect_cache_sizes(c);
+	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-- 
2.48.1


