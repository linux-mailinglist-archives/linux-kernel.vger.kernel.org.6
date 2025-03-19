Return-Path: <linux-kernel+bounces-567989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07576A68CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B117ADFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2025A2D3;
	Wed, 19 Mar 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqXsJ1Vs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKH+z9Qt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69625A2AE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386962; cv=none; b=nu6GkP0us0JrIrKp4jHXlDI95ZiLtokiO+OP1f3xDsdCvKfzIPot+kPtXWEcgnurmF9swD2YNu7jJifWqciEREHyzcUcnQ29sTZ9p+Ac9x/UOjqyS6Tzna0YU72cWGNVyR6uHy2mbVpi6aDAuuc8cAEN5aZHvpJ82sXO54Hw+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386962; c=relaxed/simple;
	bh=+ZO3cstnk+Qtjbiuce3hmo81jqYr5zJP225yAULx8xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfPrWePZh93qgdKMri/s6Fn5FAVvVeanTPR4P0k70HizvoNZmAzW4MQMUNIRNQ+SxUvL9cg/+jaRRsB3QXJqgHMtbpgbq/m7H13VWSRRMrGRq3APXPNvDFrPpjt3BxrbXc9UFUBeG82g0TbkmyRnUtHsxGKY1Vz1fUvrxjSgh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqXsJ1Vs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKH+z9Qt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOrMlzky1UJmtHOQOOS0cJPF/UEaZvfpDRp0DAMYOQk=;
	b=mqXsJ1Vs1XlQ0KIQvA03e7y73FrIyiRPBm6V4joE+jKWsJ6EP22GfXMG04FRIpG21oT7LN
	w9Uz/GwJnZiwn5Gue4avUsr/ejrdrP+b6zslsp++KRlXCh+nBrMxxoyj4H0wDd3rveigMY
	y1WrOnKMrAoHi43lOQ6pvkCKLvguUjCOIB+2v/e4MvnmXHtqKLm7emxprFHqJd13sk2JuJ
	tRIGDRHP4lv9oECD6Vjm170Keg2rhojdGNuYUaAfaI4ZOS6IFld1uj9UM0bxFJtBwnJz+D
	EgdAoPbuDRrdEYSbG6gybQ6phwzj3nzrkvRvDK96i5LIBY5FvOHysc4DfkmgqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOrMlzky1UJmtHOQOOS0cJPF/UEaZvfpDRp0DAMYOQk=;
	b=IKH+z9Qt4xHy1t+/3deJK62U1zzekDiTr9rafqLjrPtim2Ec5K7H3/dAAM/4ymv47Bidgo
	1HJ5Djx7fI7zslDA==
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
Subject: [PATCH v3 18/29] x86/cacheinfo: Use enums for cache descriptor types
Date: Wed, 19 Mar 2025 13:21:26 +0100
Message-ID: <20250319122137.4004-19-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf 0x2 one-byte cache descriptor types:

	CACHE_L1_INST
	CACHE_L1_DATA
	CACHE_L2
	CACHE_L3

are just discriminators to be used within the cache_table[] mapping.
Their specific values are irrelevant.

Use enums for such types.

Make the enum packed and static assert that its values remain within a
single byte so that the cache_table[] array size do not go out of hand.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 13 +++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c    |  9 ++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 753f6c4514f4..bbbd0bccfce5 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_CPUID_TYPES_H
 #define _ASM_X86_CPUID_TYPES_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 /*
@@ -45,4 +46,16 @@ union leaf_0x2_regs {
 	u8			desc[16];
 };
 
+/*
+ * Leaf 0x2 1-byte descriptors' cache types
+ * To be used for their mappings at cache_table[]
+ */
+enum _cache_table_type {
+	CACHE_L1_INST,
+	CACHE_L1_DATA,
+	CACHE_L2,
+	CACHE_L3
+} __packed;
+static_assert(sizeof(enum _cache_table_type) == 1);
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 626f55f960dc..09c5aa9af973 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -23,11 +23,6 @@
 
 #include "cpu.h"
 
-#define CACHE_L1_INST	1
-#define CACHE_L1_DATA	2
-#define CACHE_L2	3
-#define CACHE_L3	4
-
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
@@ -41,7 +36,7 @@ unsigned int memory_caching_control __ro_after_init;
 
 struct _cache_table {
 	u8 descriptor;
-	char cache_type;
+	enum _cache_table_type type;
 	short size;
 };
 
@@ -520,7 +515,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			if (!entry)
 				continue;
 
-			switch (entry->cache_type) {
+			switch (entry->type) {
 			case CACHE_L1_INST:	l1i += entry->size; break;
 			case CACHE_L1_DATA:	l1d += entry->size; break;
 			case CACHE_L2:		l2  += entry->size; break;
-- 
2.48.1


