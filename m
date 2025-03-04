Return-Path: <linux-kernel+bounces-543578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33961A4D71E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFF3AABC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3E2040AD;
	Tue,  4 Mar 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UuigqRtC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86LxOivB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168520371B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078437; cv=none; b=eFyPdinLi/M/r2IvXUq25CvkGawdXTbu5AZAzrWYP8LCHytPK2+c19GnTODKwNC8f0sV+4yf4o2Y7+FBpO3hZ6t9RVh2qRyA4MwrrtidCFOkYH0w+egOcsEfqLMNNaVXj47vraxVupyPiE++nWQjVxWwneRb2BMDVmYkNEBzW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078437; c=relaxed/simple;
	bh=0zQX//uZaTbQ+G43xlCyNnsVKI4X2Tyu4fpWEIeU6Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsRQ+iD06YNbdpzghd2cHIDYibba/VRnrqHi83FjL1E6l7clT1FfINHsrrl3SiS0IEip76rQ9VtBuQzN8Mo5diE9ZSjz9ECh9ryvPkDJQL5ThXvzuBjtIEHjqm4CJ4p5VKJaaRVg/PdxC6A5uBkotB8N1oJP+yX+zE4b18a8QwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UuigqRtC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=86LxOivB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ji2mdUGlNKAZDUmAmKs5+fhlOipQyk7HkhBqujVvG2A=;
	b=UuigqRtCGcG54bu7/+XsHeN3U+JQyWnNSBjjLac3ovYZiXHH0CYdHauBaXUQEf1FXQcH1e
	oZpteS61LAZXz/r6CADIlPCI3fSxmGCwC3u6s/a/59XhqULKXTw6omL+s4KmlwOFxMTzJT
	nHwpUFnZ+uEFgt2QJzc/cRO+NlsNMTA22cHzWuW0hHw87Ybmw13waco7DTj7oW1db5Estk
	Xl9l7Tr9K98Qx0wvfORsUCcbMWh4/be/PRlDcPIG6kwdkZ6LO2x2EZY2u58QA6MyRs6K0J
	UNVyq/hMqowQ97mN5Yzo4FSQl8DXh3k1ctObND3ZNOHa91Hd7Z/yqqZ3i3Gn6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ji2mdUGlNKAZDUmAmKs5+fhlOipQyk7HkhBqujVvG2A=;
	b=86LxOivBQvNC4p6RhNH+7Vv/hyqDywBI2Wn5GsKbsuTCBLkpus6qsXU/v3ZAnTPuJUMHEx
	ok7/T312P500MsAg==
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
Subject: [PATCH v1 33/40] x86/cpu: Use consolidated leaf 0x2 descriptor table
Date: Tue,  4 Mar 2025 09:51:44 +0100
Message-ID: <20250304085152.51092-34-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid leaf 0x2 output is a stream of one-byte descriptors, each implying
certain details about the CPU's cache and TLB entries.

At previous commits, the mapping tables for such descriptors were merged
into one consolidated table.  The mapping was also transformed into a
hash lookup instead of a loop-based lookup for each descriptor.

Use the new consolidated table and its hash-based lookup through the
for_each_leaf_0x2_tlb_entry() accessor.

Remove the TLB-specific mapping, intel_tlb_table[], as it is now no
longer used.  Remove the cpuid/types.h macro, for_each_leaf_0x2_desc(),
since the converted code was its last user.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 33 ++++--------
 arch/x86/kernel/cpu/intel.c        | 83 +++---------------------------
 2 files changed, 17 insertions(+), 99 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 4af9f6c32895..4d4ab8fc4758 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -56,28 +56,6 @@ static inline void get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 	}
 }
 
-/**
- * for_each_leaf_0x2_desc() - Iterator for leaf 0x2 descriptors
- * @regs:	Leaf 0x2 register output, as returned by get_leaf_0x2_regs()
- * @desc:	Pointer to the returned descriptor for each iteration
- *
- * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
- * @regs.  Provide each descriptor through @desc.
- *
- * Sample usage::
- *
- *	union leaf_0x2_regs regs;
- *	u8 *desc;
- *
- *	get_leaf_0x2_regs(&regs);
- *	for_each_leaf_0x2_desc(regs, desc) {
- *		// Handle *desc value
- *	}
- */
-#define for_each_leaf_0x2_desc(regs, desc)				\
-	/* Skip the first byte as it is not a descriptor */		\
-	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
-
 /*
  * Leaf 0x2 1-byte descriptors' cache types
  * To be used for their mappings at cpuid_0x2_table[].
@@ -103,7 +81,7 @@ static_assert(sizeof(enum _cache_table_type) == 1);
 
 /*
  * Leaf 0x2 1-byte descriptors' TLB types
- * To be used for their mappings at intel_tlb_table[]
+ * To be used for their mappings at cpuid_0x2_table[]
  */
 enum _tlb_table_type {
 	TLB_INST_4K	= __TLB_TABLE_TYPE_BEGIN,
@@ -174,4 +152,13 @@ extern const struct leaf_0x2_table cpuid_0x2_table[256];
 	     __ptr < &(regs).desc[16];						\
 	     __ptr++, entry = &cpuid_0x2_table[*__ptr])
 
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of entries
+ * for their respective TLB types.  TLB descriptor 0x63 is an exception: it
+ * implies 4 dTLB entries for 1GB pages and 32 dTLB entries for 2MB or 4MB pages.
+ * Encode that descriptor's dTLB entry count for 2MB/4MB pages here, as the entry
+ * count for dTLB 1GB pages is already encoded at the cpuid_0x2_table[]'s mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES	32
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 884cd1b1e4ff..76be957196ef 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -626,81 +626,11 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-/*
- * All of leaf 0x2's one-byte TLB descriptors implies the same number of
- * entries for their respective TLB types.  The 0x63 descriptor is an
- * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
- * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
- * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
- * intel_tlb_table[] mapping.
- */
-#define TLB_0x63_2M_4M_ENTRIES	32
-
-struct _tlb_table {
-	unsigned char descriptor;
-	enum _tlb_table_type type;
-	unsigned int entries;
-};
-
-static const struct _tlb_table intel_tlb_table[] = {
-	{ 0x01, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages, 4-way set associative */
-	{ 0x02, TLB_INST_4M,		2},	/* TLB_INST 4 MByte pages, full associative */
-	{ 0x03, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way set associative */
-	{ 0x04, TLB_DATA_4M,		8},	/* TLB_DATA 4 MByte pages, 4-way set associative */
-	{ 0x05, TLB_DATA_4M,		32},	/* TLB_DATA 4 MByte pages, 4-way set associative */
-	{ 0x0b, TLB_INST_4M,		4},	/* TLB_INST 4 MByte pages, 4-way set associative */
-	{ 0x4f, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages */
-	{ 0x50, TLB_INST_ALL,		64},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x51, TLB_INST_ALL,		128},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x52, TLB_INST_ALL,		256},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
-	{ 0x55, TLB_INST_2M_4M,		7},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
-	{ 0x56, TLB_DATA0_4M,		16},	/* TLB_DATA0 4 MByte pages, 4-way set associative */
-	{ 0x57, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, 4-way associative */
-	{ 0x59, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, fully associative */
-	{ 0x5a, TLB_DATA0_2M_4M,	32},	/* TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative */
-	{ 0x5b, TLB_DATA_4K_4M,		64},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x5c, TLB_DATA_4K_4M,		128},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x5d, TLB_DATA_4K_4M,		256},	/* TLB_DATA 4 KByte and 4 MByte pages */
-	{ 0x61, TLB_INST_4K,		48},	/* TLB_INST 4 KByte pages, full associative */
-	{ 0x63, TLB_DATA_1G_2M_4M,	4},	/* TLB_DATA 1 GByte pages, 4-way set associative
-						 * (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here) */
-	{ 0x6b, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 8-way associative */
-	{ 0x6c, TLB_DATA_2M_4M,		128},	/* TLB_DATA 2 MByte or 4 MByte pages, 8-way associative */
-	{ 0x6d, TLB_DATA_1G,		16},	/* TLB_DATA 1 GByte pages, fully associative */
-	{ 0x76, TLB_INST_2M_4M,		8},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
-	{ 0xb0, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 4-way set associative */
-	{ 0xb1, TLB_INST_2M_4M,		4},	/* TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries */
-	{ 0xb2, TLB_INST_4K,		64},	/* TLB_INST 4KByte pages, 4-way set associative */
-	{ 0xb3, TLB_DATA_4K,		128},	/* TLB_DATA 4 KByte pages, 4-way set associative */
-	{ 0xb4, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 4-way associative */
-	{ 0xb5, TLB_INST_4K,		64},	/* TLB_INST 4 KByte pages, 8-way set associative */
-	{ 0xb6, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 8-way set associative */
-	{ 0xba, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way associative */
-	{ 0xc0, TLB_DATA_4K_4M,		8},	/* TLB_DATA 4 KByte and 4 MByte pages, 4-way associative */
-	{ 0xc1, STLB_4K_2M,		1024},	/* STLB 4 KByte and 2 MByte pages, 8-way associative */
-	{ 0xc2, TLB_DATA_2M_4M,		16},	/* TLB_DATA 2 MByte/4MByte pages, 4-way associative */
-	{ 0xca, STLB_4K,		512},	/* STLB 4 KByte pages, 4-way associative */
-	{ 0x00, 0, 0 }
-};
-
-static void intel_tlb_lookup(const unsigned char desc)
+static void intel_tlb_lookup(const struct leaf_0x2_table *entry)
 {
-	unsigned int entries;
-	unsigned char k;
-
-	if (desc == 0)
-		return;
-
-	/* look up this descriptor in the table */
-	for (k = 0; intel_tlb_table[k].descriptor != desc &&
-	     intel_tlb_table[k].descriptor != 0; k++)
-		;
-
-	if (intel_tlb_table[k].type == 0)
-		return;
+	short entries = entry->entries;
 
-	entries = intel_tlb_table[k].entries;
-	switch (intel_tlb_table[k].type) {
+	switch (entry->t_type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);
@@ -757,15 +687,16 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
+	const struct leaf_0x2_table *entry;
 	union leaf_0x2_regs regs;
-	u8 *desc;
+	u8 *ptr;
 
 	if (c->cpuid_level < 2)
 		return;
 
 	get_leaf_0x2_regs(&regs);
-	for_each_leaf_0x2_desc(regs, desc)
-		intel_tlb_lookup(*desc);
+	for_each_leaf_0x2_entry(regs, ptr, entry)
+		intel_tlb_lookup(entry);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


