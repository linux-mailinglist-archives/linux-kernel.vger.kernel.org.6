Return-Path: <linux-kernel+bounces-564699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F088FA65979
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0437188E9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C61FE45F;
	Mon, 17 Mar 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEOg+xUQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MiXQ5CKN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C361FDE28
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230414; cv=none; b=SA+cq1jUH3MksNRP/o7f946jCHjGNZdkkI3ggf7AvUzpRrwsxEOuKHV4aawi8fdT+Z5UsdXMCy9gCJJwlc+qir3OEKkqd8wSik4weEuj79ePZ1+LbCbBU72aVgUwpCmm5gL3/nYEhwsUmI6kcAQUZuYHdwk1Uho4btDxAZ7A/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230414; c=relaxed/simple;
	bh=bm2CVVQyd0izouxFaOS1K7sJO5NSoEXAtAkEaCHf4WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRd44bU7eViqejT7UlZomrvYRiQT+29HylPLE12/apzQkQhsZmpHJBXtJOjDp6U/gtX0DZUvz5CvGz3KsIRCLBLI9XQFjtQcAMPw9kNoDAUA4S0dFgkEoFNw1AqC3pWI13ImgW1iW5gU425lL7O34+hTKPR6jwOS4E0f7MalHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEOg+xUQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MiXQ5CKN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73nQyuAh6ksUETIonyRhEiJpuJOZrsHb4OA2TCJlHoQ=;
	b=SEOg+xUQ3z7jWzE5nMEcmVG+hyTVY6OwaQQ1uAcMGDA1wx7MmhNlh95Ex0EKsR1MMQ96BG
	ZKjrCrBlbcoPCu5Iai7gItc6MNma+zYlSII4CEGIOJEqyZRM1Q538Pmp8w1qrHQbtaJNu0
	zWJkbvAvTwzvLGXBRy6AUGJNVNaHl+jaja+uEfSQr7amLnXCrNl1HYmkBfy5wV6yzMmWuK
	JI2k8fdGNpv1jX9Xg0fLk2YpFuPmYFgO0Vwfw2gweb4S8hvHmMT8Rikd6jy6coVykFjP7S
	rk4T6xG9Jy+W8mWc+OHPlGWbjUmi5G/DROyxM2z35kuqSecebhvhBwhmRb1QwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73nQyuAh6ksUETIonyRhEiJpuJOZrsHb4OA2TCJlHoQ=;
	b=MiXQ5CKNhypne7+/A2CKe1sj6pkqszP9LAq5NAv8+jAcaahLXataR/mJebjUGTLkUvhuSF
	hGVRX0yXws/KTLDA==
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
Subject: [PATCH v2 20/29] x86/cpu: Consolidate CPUID leaf 0x2 tables
Date: Mon, 17 Mar 2025 17:47:36 +0100
Message-ID: <20250317164745.4754-21-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

CPUID leaf 0x2 describes TLBs and caches. So there are two tables with the
respective descriptor constants in intel.c and cacheinfo.c. The tables
occupy almost 600 byte and require a loop based lookup for each variant.

Combining them into one table occupies exactly 1k rodata and allows to get
rid of the loop based lookup by just using the descriptor byte provided by
CPUID leaf 0x2 as index into the table, which simplifies the code and
reduces text size.

The conversion of the intel.c and cacheinfo.c code is done separately.

[ darwi: Actually define struct leaf_0x2_table.
	 Tab-align all of cpuid_0x2_table[] mapping entries.
	 Define needed SZ_* macros at <linux/sizes.h> instead (merged commit.)
	 Use CACHE_L1_{INST,DATA} as names for L1 cache descriptor types.
	 Set descriptor 0x63 type as TLB_DATA_1G_2M_4M and explain why.
	 Use enums for cache and TLB descriptor types (parent commits.)
	 Start enum types at 1 since type 0 is reserved for unknown descriptors.
	 Ensure that cache and TLB enum type values do not intersect.
	 Add leaf 0x2 table accessor for_each_leaf_0x2_entry() + documentation. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/leaf_0x2_api.h |  33 +++++-
 arch/x86/include/asm/cpuid/types.h        |  38 +++++--
 arch/x86/kernel/cpu/Makefile              |   2 +-
 arch/x86/kernel/cpu/cpuid_0x2_table.c     | 128 ++++++++++++++++++++++
 4 files changed, 192 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/cpuid_0x2_table.c

diff --git a/arch/x86/include/asm/cpuid/leaf_0x2_api.h b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
index b64e4a20a3ce..c73837e6f1da 100644
--- a/arch/x86/include/asm/cpuid/leaf_0x2_api.h
+++ b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
@@ -13,7 +13,8 @@
  * invalid 1-byte descriptor returned by the hardware to zero (the NULL
  * cache/TLB descriptor) before returning it to the caller.
  *
- * Use for_each_leaf_0x2_desc() to iterate over the returned output.
+ * Use for_each_leaf_0x2_entry() to iterate over the register output in
+ * parsed form.
  */
 static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 {
@@ -62,4 +63,34 @@ static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 #define for_each_leaf_0x2_desc(regs, desc)				\
 	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
 
+/**
+ * for_each_leaf_0x2_entry() - Iterator for parsed leaf 0x2 descriptors
+ * @regs:   Leaf 0x2 register output, returned by cpuid_get_leaf_0x2_regs()
+ * @__ptr:  u8 pointer, for macro internal use only
+ * @entry:  Pointer to parsed descriptor information at each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
+ * @regs.  Provide the parsed information for each descriptor through @entry.
+ *
+ * To handle cache-specific descriptors, switch on @entry->c_type.  For TLB
+ * descriptors, switch on @entry->t_type.
+ *
+ * Example usage for cache descriptors::
+ *
+ *	const struct leaf_0x2_table *entry;
+ *	union leaf_0x2_regs regs;
+ *	u8 *ptr;
+ *
+ *	cpuid_get_leaf_0x2_regs(&regs);
+ *	for_each_leaf_0x2_entry(regs, ptr, entry) {
+ *		switch (entry->c_type) {
+ *			...
+ *		}
+ *	}
+ */
+#define for_each_leaf_0x2_entry(regs, __ptr, entry)			\
+	for (__ptr = &(regs).desc[1], entry = &cpuid_0x2_table[*__ptr];	\
+	     __ptr < &(regs).desc[16];					\
+	     __ptr++, entry = &cpuid_0x2_table[*__ptr])
+
 #endif /* _ASM_X86_CPUID_LEAF_0x2_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 39b6577987bf..172fc88dc685 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -45,25 +45,32 @@ union leaf_0x2_regs {
 
 /*
  * Leaf 0x2 1-byte descriptors' cache types
- * To be used for their mappings at cache_table[]
+ * To be used for their mappings at cpuid_0x2_table[]
+ *
+ * Start at 1 since type 0 is reserved for HW byte descriptors which are
+ * not recognized by the kernel; i.e., those without an explicit mapping.
  */
 enum _cache_table_type {
-	CACHE_L1_INST,
+	CACHE_L1_INST		= 1,
 	CACHE_L1_DATA,
 	CACHE_L2,
 	CACHE_L3
+	/* Adjust __TLB_TABLE_TYPE_BEGIN before adding more types */
 } __packed;
 static_assert(sizeof(enum _cache_table_type) == 1);
 
+/*
+ * Ensure that leaf 0x2 cache and TLB type values do not intersect,
+ * since they share the same type field at struct cpuid_0x2_table.
+ */
+#define __TLB_TABLE_TYPE_BEGIN		(CACHE_L3 + 1)
+
 /*
  * Leaf 0x2 1-byte descriptors' TLB types
- * To be used for their mappings at intel_tlb_table[]
- *
- * Start at 1 since type 0 is reserved for HW byte descriptors which are
- * not recognized by the kernel; i.e., those without an explicit mapping.
+ * To be used for their mappings at cpuid_0x2_table[]
  */
 enum _tlb_table_type {
-	TLB_INST_4K		= 1,
+	TLB_INST_4K		= __TLB_TABLE_TYPE_BEGIN,
 	TLB_INST_4M,
 	TLB_INST_2M_4M,
 	TLB_INST_ALL,
@@ -84,4 +91,21 @@ enum _tlb_table_type {
 } __packed;
 static_assert(sizeof(enum _tlb_table_type) == 1);
 
+/*
+ * Combined parsing table for leaf 0x2 cache and TLB descriptors.
+ */
+
+struct leaf_0x2_table {
+	union {
+		enum _cache_table_type	c_type;
+		enum _tlb_table_type	t_type;
+	};
+	union {
+		short			c_size;
+		short			entries;
+	};
+};
+
+extern const struct leaf_0x2_table cpuid_0x2_table[256];
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 3a39396d422d..1e26179ff18c 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -24,7 +24,7 @@ obj-y			+= rdrand.o
 obj-y			+= match.o
 obj-y			+= bugs.o
 obj-y			+= aperfmperf.o
-obj-y			+= cpuid-deps.o
+obj-y			+= cpuid-deps.o cpuid_0x2_table.o
 obj-y			+= umwait.o
 obj-y 			+= capflags.o powerflags.o
 
diff --git a/arch/x86/kernel/cpu/cpuid_0x2_table.c b/arch/x86/kernel/cpu/cpuid_0x2_table.c
new file mode 100644
index 000000000000..89bc8db5e9c6
--- /dev/null
+++ b/arch/x86/kernel/cpu/cpuid_0x2_table.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/sizes.h>
+
+#include <asm/cpuid/types.h>
+
+#include "cpu.h"
+
+#define CACHE_ENTRY(_desc, _type, _size)	\
+	[_desc] = {				\
+		.c_type = (_type),		\
+		.c_size = (_size) / SZ_1K,	\
+	}
+
+#define TLB_ENTRY(_desc, _type, _entries)	\
+	[_desc] = {				\
+		.t_type = (_type),		\
+		.entries = (_entries),		\
+	}
+
+const struct leaf_0x2_table cpuid_0x2_table[256] = {
+	CACHE_ENTRY(0x06, CACHE_L1_INST,	SZ_8K	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x08, CACHE_L1_INST,	SZ_16K	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x09, CACHE_L1_INST,	SZ_32K	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x0a, CACHE_L1_DATA,	SZ_8K	),	/* 2 way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x0c, CACHE_L1_DATA,	SZ_16K	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x0d, CACHE_L1_DATA,	SZ_16K	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x0e, CACHE_L1_DATA,	SZ_24K	),	/* 6-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x21, CACHE_L2,		SZ_256K	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x22, CACHE_L3,		SZ_512K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x23, CACHE_L3,		SZ_1M	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x25, CACHE_L3,		SZ_2M	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x29, CACHE_L3,		SZ_4M	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x2c, CACHE_L1_DATA,	SZ_32K	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x30, CACHE_L1_INST,	SZ_32K	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x39, CACHE_L2,		SZ_128K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x3a, CACHE_L2,		SZ_192K	),	/* 6-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x3b, CACHE_L2,		SZ_128K	),	/* 2-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x3c, CACHE_L2,		SZ_256K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x3d, CACHE_L2,		SZ_384K	),	/* 6-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x3e, CACHE_L2,		SZ_512K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x3f, CACHE_L2,		SZ_256K	),	/* 2-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x41, CACHE_L2,		SZ_128K	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x42, CACHE_L2,		SZ_256K	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x43, CACHE_L2,		SZ_512K	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x44, CACHE_L2,		SZ_1M	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x45, CACHE_L2,		SZ_2M	),	/* 4-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x46, CACHE_L3,		SZ_4M	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x47, CACHE_L3,		SZ_8M	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x48, CACHE_L2,		SZ_3M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x49, CACHE_L3,		SZ_4M	),	/* 16-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x4a, CACHE_L3,		SZ_6M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x4b, CACHE_L3,		SZ_8M	),	/* 16-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x4c, CACHE_L3,		SZ_12M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x4d, CACHE_L3,		SZ_16M	),	/* 16-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x4e, CACHE_L2,		SZ_6M	),	/* 24-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x60, CACHE_L1_DATA,	SZ_16K	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x66, CACHE_L1_DATA,	SZ_8K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x67, CACHE_L1_DATA,	SZ_16K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x68, CACHE_L1_DATA,	SZ_32K	),	/* 4-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x78, CACHE_L2,		SZ_1M	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x79, CACHE_L2,		SZ_128K	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x7a, CACHE_L2,		SZ_256K	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x7b, CACHE_L2,		SZ_512K	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x7c, CACHE_L2,		SZ_1M	),	/* 8-way set assoc, sectored cache, 64 byte line size */
+	CACHE_ENTRY(0x7d, CACHE_L2,		SZ_2M	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x7f, CACHE_L2,		SZ_512K	),	/* 2-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x80, CACHE_L2,		SZ_512K	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x82, CACHE_L2,		SZ_256K	),	/* 8-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x83, CACHE_L2,		SZ_512K	),	/* 8-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x84, CACHE_L2,		SZ_1M	),	/* 8-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x85, CACHE_L2,		SZ_2M	),	/* 8-way set assoc, 32 byte line size */
+	CACHE_ENTRY(0x86, CACHE_L2,		SZ_512K	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0x87, CACHE_L2,		SZ_1M	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xd0, CACHE_L3,		SZ_512K	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xd1, CACHE_L3,		SZ_1M	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xd2, CACHE_L3,		SZ_2M	),	/* 4-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xd6, CACHE_L3,		SZ_1M	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xd7, CACHE_L3,		SZ_2M	),	/* 8-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xd8, CACHE_L3,		SZ_4M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xdc, CACHE_L3,		SZ_2M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xdd, CACHE_L3,		SZ_4M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xde, CACHE_L3,		SZ_8M	),	/* 12-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xe2, CACHE_L3,		SZ_2M	),	/* 16-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xe3, CACHE_L3,		SZ_4M	),	/* 16-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xe4, CACHE_L3,		SZ_8M	),	/* 16-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xea, CACHE_L3,		SZ_12M	),	/* 24-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xeb, CACHE_L3,		SZ_18M	),	/* 24-way set assoc, 64 byte line size */
+	CACHE_ENTRY(0xec, CACHE_L3,		SZ_24M	),	/* 24-way set assoc, 64 byte line size */
+
+	TLB_ENTRY(  0x01, TLB_INST_4K,		32	),	/* TLB_INST 4 KByte pages, 4-way set associative */
+	TLB_ENTRY(  0x02, TLB_INST_4M,		2	),	/* TLB_INST 4 MByte pages, full associative */
+	TLB_ENTRY(  0x03, TLB_DATA_4K,		64	),	/* TLB_DATA 4 KByte pages, 4-way set associative */
+	TLB_ENTRY(  0x04, TLB_DATA_4M,		8	),	/* TLB_DATA 4 MByte pages, 4-way set associative */
+	TLB_ENTRY(  0x05, TLB_DATA_4M,		32	),	/* TLB_DATA 4 MByte pages, 4-way set associative */
+	TLB_ENTRY(  0x0b, TLB_INST_4M,		4	),	/* TLB_INST 4 MByte pages, 4-way set associative */
+	TLB_ENTRY(  0x4f, TLB_INST_4K,		32	),	/* TLB_INST 4 KByte pages */
+	TLB_ENTRY(  0x50, TLB_INST_ALL,		64	),	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	TLB_ENTRY(  0x51, TLB_INST_ALL,		128	),	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	TLB_ENTRY(  0x52, TLB_INST_ALL,		256	),	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	TLB_ENTRY(  0x55, TLB_INST_2M_4M,	7	),	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
+	TLB_ENTRY(  0x56, TLB_DATA0_4M,		16	),	/* TLB_DATA0 4 MByte pages, 4-way set associative */
+	TLB_ENTRY(  0x57, TLB_DATA0_4K,		16	),	/* TLB_DATA0 4 KByte pages, 4-way associative */
+	TLB_ENTRY(  0x59, TLB_DATA0_4K,		16	),	/* TLB_DATA0 4 KByte pages, fully associative */
+	TLB_ENTRY(  0x5a, TLB_DATA0_2M_4M,	32	),	/* TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative */
+	TLB_ENTRY(  0x5b, TLB_DATA_4K_4M,	64	),	/* TLB_DATA 4 KByte and 4 MByte pages */
+	TLB_ENTRY(  0x5c, TLB_DATA_4K_4M,	128	),	/* TLB_DATA 4 KByte and 4 MByte pages */
+	TLB_ENTRY(  0x5d, TLB_DATA_4K_4M,	256	),	/* TLB_DATA 4 KByte and 4 MByte pages */
+	TLB_ENTRY(  0x61, TLB_INST_4K,		48	),	/* TLB_INST 4 KByte pages, full associative */
+	TLB_ENTRY(  0x63, TLB_DATA_1G_2M_4M,	4	),	/* TLB_DATA 1 GByte pages, 4-way set associative
+								 * (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here) */
+	TLB_ENTRY(  0x6b, TLB_DATA_4K,		256	),	/* TLB_DATA 4 KByte pages, 8-way associative */
+	TLB_ENTRY(  0x6c, TLB_DATA_2M_4M,	128	),	/* TLB_DATA 2 MByte or 4 MByte pages, 8-way associative */
+	TLB_ENTRY(  0x6d, TLB_DATA_1G,		16	),	/* TLB_DATA 1 GByte pages, fully associative */
+	TLB_ENTRY(  0x76, TLB_INST_2M_4M,	8	),	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
+	TLB_ENTRY(  0xb0, TLB_INST_4K,		128	),	/* TLB_INST 4 KByte pages, 4-way set associative */
+	TLB_ENTRY(  0xb1, TLB_INST_2M_4M,	4	),	/* TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries */
+	TLB_ENTRY(  0xb2, TLB_INST_4K,		64	),	/* TLB_INST 4KByte pages, 4-way set associative */
+	TLB_ENTRY(  0xb3, TLB_DATA_4K,		128	),	/* TLB_DATA 4 KByte pages, 4-way set associative */
+	TLB_ENTRY(  0xb4, TLB_DATA_4K,		256	),	/* TLB_DATA 4 KByte pages, 4-way associative */
+	TLB_ENTRY(  0xb5, TLB_INST_4K,		64	),	/* TLB_INST 4 KByte pages, 8-way set associative */
+	TLB_ENTRY(  0xb6, TLB_INST_4K,		128	),	/* TLB_INST 4 KByte pages, 8-way set associative */
+	TLB_ENTRY(  0xba, TLB_DATA_4K,		64	),	/* TLB_DATA 4 KByte pages, 4-way associative */
+	TLB_ENTRY(  0xc0, TLB_DATA_4K_4M,	8	),	/* TLB_DATA 4 KByte and 4 MByte pages, 4-way associative */
+	TLB_ENTRY(  0xc1, STLB_4K_2M,		1024	),	/* STLB 4 KByte and 2 MByte pages, 8-way associative */
+	TLB_ENTRY(  0xc2, TLB_DATA_2M_4M,	16	),	/* TLB_DATA 2 MByte/4MByte pages, 4-way associative */
+	TLB_ENTRY(  0xca, STLB_4K,		512	),	/* STLB 4 KByte pages, 4-way associative */
+};
-- 
2.48.1


