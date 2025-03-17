Return-Path: <linux-kernel+bounces-564707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A2A6598B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9350F19A0871
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EB1C5489;
	Mon, 17 Mar 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQBdAjlL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zw/mrv6j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D22066F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230438; cv=none; b=b4oLMlmvM2zSY9DMdP7Bj7NzJt0M+0r+cpPlw4NonLZwcr64Um9fTL0U6hPQeVdiaJk/KF+OzFfJ2J/fHOBoh+bA0S1sTGKBRFsK0CcKbjWs19Ebm8dYx5Ng5mv9C3nK402RiZHYnXmyRYeTRb7Qy1Mw6x7BqFtlKV+934JeKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230438; c=relaxed/simple;
	bh=fvYYDx9hTjGIth43jLB1ml1x+uMHDlTmJMvBhct6rVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgwI88/qMStQCjKzTtct2trNqzhQyZad2Yf3ma9jh07FXdWn7fbNOGCSF0+V3/LLtR8Pdn+LMjo8pD5k2u9oY4iI/ahcu6KupQAoa2BWF1IJzkz1BW++gUHYnjEq7ZsWODSdgd5YpHX1QkwDCDaKwZ6FU8Sxdmiouv3jsnQCBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQBdAjlL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zw/mrv6j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niBwqtqShdIz6ZMpX7H1qJm98xh963YIGXpxqXvmLcQ=;
	b=fQBdAjlLQqcXcgALO2I9yqATxZcq7D6ei1Msc+IBD1W1UyAAYUZiL33qr2p8JCQQNEtbKa
	Ux2Eg5jQgC4U2rxwf8nz7b5yO74DafEeISWH8uN79cArxZCefl5Wp3UjajJOi8Y8jyL0Kt
	6s6V3Uf6PcPj8mUcg17SVLo981X73M9ePbAN4AIoo5GMNO/Tv/p5YIsZgK3yFz5tlwc5cA
	PmcUuD5ISRwGuFaTLzuRxCN9wcF773g+Xy3L9ICjJZZxdLzqaVMCzzzWALymdlPBc3lVh3
	7NqIkGBIWDmPz6EdYX1BhqJcvGvTTgoGNu51RPR3J1Y93jeGQIa/41cuPSlAdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niBwqtqShdIz6ZMpX7H1qJm98xh963YIGXpxqXvmLcQ=;
	b=Zw/mrv6j+yWG3cAhN6e0TmS/qUrmjClRfx0Or98gmLU+EPKwnSRggQzPxT2efKGvSimLAN
	XU10YDBVgWHV7vAg==
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
Subject: [PATCH v2 28/29] x86/cacheinfo: Introduce cpuid_amd_hygon_has_l3_cache()
Date: Mon, 17 Mar 2025 17:47:44 +0100
Message-ID: <20250317164745.4754-29-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
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
 arch/x86/include/asm/cpuid/api.h |  9 +++++++++
 arch/x86/kernel/amd_nb.c         |  7 +++----
 arch/x86/kernel/cpu/cacheinfo.c  | 32 ++++++++++++++------------------
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 4d1da9cc8b6f..d2ca5d813523 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -205,4 +205,13 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 	return 0;
 }
 
+/*
+ * CPUID(0x80000006) parsing helpers
+ */
+
+static inline bool cpuid_amd_hygon_has_l3_cache(void)
+{
+	return cpuid_edx(0x80000006);
+}
+
 #endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index bac8d3b6f12b..6d51689ffbf2 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -13,7 +13,9 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/pci_ids.h>
+
 #include <asm/amd_nb.h>
+#include <asm/cpuid.h>
 
 static u32 *flush_words;
 
@@ -92,10 +94,7 @@ static int amd_cache_northbridges(void)
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
-	/*
-	 * Check for L3 cache presence.
-	 */
-	if (!cpuid_edx(0x80000006))
+	if (!cpuid_amd_hygon_has_l3_cache())
 		return 0;
 
 	/*
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 38683e86fab4..397c3dbc5851 100644
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
+	if (!cpuid_amd_hygon_has_l3_cache())
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
+	if (!cpuid_amd_hygon_has_l3_cache())
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


