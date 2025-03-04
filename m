Return-Path: <linux-kernel+bounces-543580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D549A4D720
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A190175864
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94D1FDE3B;
	Tue,  4 Mar 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vuax3yc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uk1KjxNW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B39204090
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078440; cv=none; b=drNf8+iP2O4IyT/Y8PJnKVJs0+W6XRm+LeBcZfxjd8xIpz5LdEp7U+XJqHvyxxMKhoF5CJ+TW8LlD1NG63jLZ9QeQPSw3g6z65LDM8sW5siT2SN4AWeuBJ4UO4qRto30d/RNYyFDgyE0imM/uCLxk9YGySXbEeDTwP2NFAIgOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078440; c=relaxed/simple;
	bh=usRBZ5LwIE2ZR/AkBDSsd+44ddL8FOK66OoAZpd+kNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjWmg1w+t0b8Y/rytGasoqsIgx1cenuUZpFm7aXsqZEI/A/1xj9MNZ7svoduGD3iGMnoElp5Wk3oZIK2z02YU2OxUFWi0G+jAwMKBJisS6ZAJVGgKwD+GRcpyvV2CM1q0870LZWNKpCr8lFu3zQhgJPeErjt6vQv5TBIURAbTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vuax3yc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uk1KjxNW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOsud2F9JoGdnqFP2WrHPfNLNSK6anqaFLxBys6zcuE=;
	b=4vuax3yciA8gF8TaUYguqS90FgE9F71dF6PiuKdamAXl0ewEY1vHKjAVl6NJNpyt+auJEu
	nB8SCYHDXj6IfvfOdJF+IJKnkLey58zmMywCqr0dlYCnIMLeXrHKejo3FE2GASV/oqRYJo
	NiUCUu60DhlW7zrMPfF4o64UdMtrGF3qKafXM6sfXbi1p+YE7T2jVaBpADnLpRTql+IZGj
	fM19Nj+ReqCv+A53sEOBbhX3oaKw48UVybVRgSxXfxRJXthmjbLLXevv5nW6b0+I+AwFZN
	D+CdoIgbwXVGLtiCwhsTCi82Bwg+LIm/AyendOBfJdiuw6zC/YPKdCT8WUy2hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOsud2F9JoGdnqFP2WrHPfNLNSK6anqaFLxBys6zcuE=;
	b=Uk1KjxNWKCJ2KWw5jNsgpR2/Ak2iamhQfOVUx9pRDybgF5LOcG/S9IcWnGDlcIDnIAvDrX
	38Mv49R1N8QyuGBA==
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
Subject: [PATCH v1 34/40] x86/cacheinfo: Separate leaf 0x2 handling and post-processing logic
Date: Tue,  4 Mar 2025 09:51:45 +0100
Message-ID: <20250304085152.51092-35-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
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
index a1cfb6716272..a15538d72432 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -352,14 +352,56 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
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
+	get_leaf_0x2_regs(&regs);
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
@@ -373,7 +415,8 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < ci->num_leaves; i++) {
+		for (int i = 0; i < ci->num_leaves; i++) {
+			unsigned int num_threads_sharing, index_msb;
 			struct _cpuid4_info id4 = {};
 			int retval;
 
@@ -384,18 +427,18 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
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
@@ -408,52 +451,19 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		const struct leaf_0x2_table *entry;
-		union leaf_0x2_regs regs;
-		u8 *ptr;
-
-		get_leaf_0x2_regs(&regs);
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


