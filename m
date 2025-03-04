Return-Path: <linux-kernel+bounces-543585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2FA4D737
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7553188DC74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EA1FE462;
	Tue,  4 Mar 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Al11Xq5M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8yo/IeCa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE4204C02
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078455; cv=none; b=GBSRErnbbvMx5hDN7CT8LLClcHbtc5Kp78e5O0sgYXBe8iuLgXR72YGNmi3+7xZE6CGbq+CTL1IpzOmgQMs8lQxGbt4gbfnmrGCG24SWGJqk3M+7WBrUvyW66OZ/SOHotlalGf/jCNv+53w0sKJADO6Pw3nCVztLp2ul4StiiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078455; c=relaxed/simple;
	bh=hp6m0qQToWqUG9NcPNoxQ1ym2SFqOwUzAbH23TCilr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+CGViOJfHrq857YoGIoOeiIvoc4g+S+s0qPbantTxcm1FoIRF0RdPK10G03L5RlM9ww+P2fW+fUvOYwbhvYqRY20gfoRrSBgHm72NEmkUdUkitLegKWEVFIiMWDaxXmX3aYTYJIi6hMk9C16eEy9FiNAHXj0sFaw3YQBl5nn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Al11Xq5M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8yo/IeCa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28eD/vgFI5SHsIs8fRQvhuQI5yGryhWDyE2/9tAGKwg=;
	b=Al11Xq5M6hpj4/9q6SH8n+S8j6mzU2ME8p4BhVlLmfskgmpQIphhR2qLMvytKvssjJSLpB
	sb8mSptKNUTs5sWbdyqLh1zyHMKkkKNP3fym06OgcKLbtWb9qMKvknKQr9/CC3Kq8XxKsa
	b3G+xtUNDo2RwLFbE4GrlrSrnYJmas6N+mheAkC6IGib86Em6VsgAsKErcJ0GKKag85uD0
	Eu8VK+J1qgJN72zUMRqtCgunDxxacX9QEmwfTeszEzulZTb3g3YCi5TzjBOt7gDc+53ALu
	bqoTmDrQwXKDjOWiyrhdoTSjwt0loYzJTbSNZLluKZMtqssEC8F/G7vtL32ksw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28eD/vgFI5SHsIs8fRQvhuQI5yGryhWDyE2/9tAGKwg=;
	b=8yo/IeCan+8dSIaPVs4XU/4PFGezSdmgc+4Z2VTsLmxlNrXrIEzFwkit4p4ubmfL4DzkwP
	I39k2975W+DOh7Dg==
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
Subject: [PATCH v1 39/40] x86/cacheinfo: Introduce amd_hygon_cpu_has_l3_cache()
Date: Tue,  4 Mar 2025 09:51:50 +0100
Message-ID: <20250304085152.51092-40-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple code paths at cacheinfo.c and amd_nb.c check for AMD/Hygon CPUs
L3 cache presensce by directly checking leaf 0x80000006 EDX output.

Extract that logic into its own function.  While at it, rework the
AMD/Hygon LLC topology ID caclculation comments for clarity.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h |  9 +++++++++
 arch/x86/kernel/amd_nb.c           |  7 +++----
 arch/x86/kernel/cpu/cacheinfo.c    | 32 +++++++++++++-----------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 4d4ab8fc4758..a01cea960ea0 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -161,4 +161,13 @@ extern const struct leaf_0x2_table cpuid_0x2_table[256];
  */
 #define TLB_0x63_2M_4M_ENTRIES	32
 
+/*
+ * CPUID(0x80000006) parsing helpers
+ */
+
+static inline bool amd_hygon_cpu_has_l3_cache(void)
+{
+	return cpuid_edx(0x80000006);
+}
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index bac8d3b6f12b..e73697cefa16 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -13,7 +13,9 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/pci_ids.h>
+
 #include <asm/amd_nb.h>
+#include <asm/cpuid/types.h>
 
 static u32 *flush_words;
 
@@ -92,10 +94,7 @@ static int amd_cache_northbridges(void)
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
-	/*
-	 * Check for L3 cache presence.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!amd_hygon_cpu_has_l3_cache())
 		return 0;
 
 	/*
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index bb934f81dcd1..f85a3ddfc3cc 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -278,29 +278,29 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
+/*
+ * AMD/Hygon CPUs may have multiple LLCs if L3 caches exist.
+ */
+
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
-	/*
-	 * We may have multiple LLCs if L3 caches exist, so check if we
-	 * have an L3 cache by looking at the L3 cache CPUID leaf.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!amd_hygon_cpu_has_l3_cache())
 		return;
 
 	if (c->x86 < 0x17) {
-		/* LLC is at the node level. */
+		/* Pre-Zen: LLC is at the node level */
 		c->topo.llc_id = die_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
-		 * LLC is at the core complex level.
-		 * Core complex ID is ApicId[3] for these processors.
+		 * Family 17h up to 1F models: LLC is at the core
+		 * complex level.  Core complex ID is ApicId[3].
 		 */
 		c->topo.llc_id = c->topo.apicid >> 3;
 	} else {
 		/*
-		 * LLC ID is calculated from the number of threads sharing the
-		 * cache.
-		 * */
+		 * Newer families: LLC ID is calculated from the number
+		 * of threads sharing the L3 cache.
+		 */
 		u32 eax, ebx, ecx, edx, num_sharing_cache = 0;
 		u32 llc_index = find_num_cache_leaves(c) - 1;
 
@@ -318,16 +318,12 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 {
-	/*
-	 * We may have multiple LLCs if L3 caches exist, so check if we
-	 * have an L3 cache by looking at the L3 cache CPUID leaf.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!amd_hygon_cpu_has_l3_cache())
 		return;
 
 	/*
-	 * LLC is at the core complex level.
-	 * Core complex ID is ApicId[3] for these processors.
+	 * Hygons are similar to AMD Family 17h up to 1F models: LLC is
+	 * at the core complex level.  Core complex ID is ApicId[3].
 	 */
 	c->topo.llc_id = c->topo.apicid >> 3;
 }
-- 
2.48.1


