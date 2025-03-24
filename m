Return-Path: <linux-kernel+bounces-573757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA9A6DBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889A41887F81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE3261368;
	Mon, 24 Mar 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQRGTuzo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgN4S7YR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE58263C6E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823301; cv=none; b=MH26Xa3rL0Gmx4ipqX134Yv3Oc7Plur2+ZW47ztYZQHjXW2dFaoU8lAmpxHzr90qS1i2oWAAz7fKs0s2sAEQfoQYRR8IAn8qr2xVCpkju2WUrcwEINtNJHeirIVwLdJs0oMHZD3w9sTzLYE+mTWjE9dUfTc6O59qvv3fFUdxo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823301; c=relaxed/simple;
	bh=B55xocFyVxdqukbCblGeupZ4FOypS1hRd2oMu0imjt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsfweorYvQ7X3lGY/g7LkE/pSZ3BpyyFJIyOvwovMxtjHxD5T2pSK+mRJA0iT0lafxJMpd+UxJqa9eqrBLUtmNLMsUwCJ5zXIDbccu+85YiZoQEI0/kjo++B4lGMjicsJBllEYxH60tATypqhK8fUXwxEqPwj2BflSxV4Ls7NH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQRGTuzo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgN4S7YR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntKI302TdIxPIUCA8Z4MCB4EWwJT8XNQPNHNyU54E1U=;
	b=gQRGTuzop83WEo9l1pQ5AjooRtESW9ylaKtX6PneTLDHMdRp0XTuQkIvdvkXOSK+SQA3ZP
	Qdq8YLKBr9YzImgPiMMZ4qfsBE2CHk9Cl2qHtfqfsAg0rh3Fhn7u6G1Jv/V3SgU+RPd9Om
	l+ZE9tDLgPhLZ+qbYsN8dMe/00oRkOfCK19xlN7bbnCspVUwZ3lTiWHwowF4jqsjlmWU2l
	aHsTNgT+xQ5tH8PQpzakuUnig0tq9rffte1enc0lCGkbKx47t7nkx2LGNpi/zslEIfQZOD
	7hU3CKsvF5Fx66yC7y2JqdPfHu2cKMu6A4n8UNaiq9qA/mkJBjN3+MGYJ/AqHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntKI302TdIxPIUCA8Z4MCB4EWwJT8XNQPNHNyU54E1U=;
	b=wgN4S7YRmf1PzOmM4j8gAmzXC1qUl2ZbseVxXeeRJrVFK6Jwn2+RPDU0i5X+A69yGZNhL3
	HQUMAGAawIWgt5Bg==
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
Subject: [PATCH v4 28/29] x86/cacheinfo: Introduce cpuid_amd_hygon_has_l3_cache()
Date: Mon, 24 Mar 2025 14:33:23 +0100
Message-ID: <20250324133324.23458-29-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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
index 9c180c9cc58e..bf75c6267311 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -207,4 +207,13 @@ static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
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
index 6d12a9b69432..5a8cc48f80be 100644
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
 
@@ -91,10 +93,7 @@ static int amd_cache_northbridges(void)
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
index e0d531e27ff3..71587570705f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -281,29 +281,29 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
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
 
@@ -321,16 +321,12 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 
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


