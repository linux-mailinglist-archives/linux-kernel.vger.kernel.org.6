Return-Path: <linux-kernel+bounces-567993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA7A68CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171CC3AB542
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7F25A631;
	Wed, 19 Mar 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wviva36O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKZ36iDR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AA25A353
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386975; cv=none; b=TtbBmIq7BMXRbCpIxJdPz2sW7yoGh5lDgmrHowiNpxw5pPxGl2lkPDyUzOhKCVZGCF5HQ2WqU8PNGt83dPBBf/8kAN623VLs2CIyvIX9JJwjq1TYcHEUiqoK/sq+acEEFQUwtGFP47NY8T14ZIntRwqqogUxNP8JR6XVdkjcVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386975; c=relaxed/simple;
	bh=c7gHvoppGb7F1AXejIsHD9V4Yf6yLhTIOeZOOGfbOYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERWDg1HTVLw2KXSD8DdLaY6NeXxbB933aKV6ZSnLK5U3aPa3TDZyHoZ7HqojhLn9/1Zv0JUJ3vWIPrBpKTZPhHWhazc3vbZbXBBxk+yKmnB7JMhQgz5w3MZZNm+zDXqs312Js5noiaSmWya6oUge+atZC1zT2cFph9IgEWree0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wviva36O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iKZ36iDR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgPSlSGzqhyhprXQ1IZvqFI257oe8TfUU7AH4jWJhVE=;
	b=Wviva36O96fARthoNx4MmIXhw+wC/mUemBnnvb73N63UZbElf7DB0ck+Fm8mM5uUuqrYUT
	7xbaxwISXCah/rhGL4inZ9p3xbsrs08amD6lX72NSTwk7CdxYbS3r9zltxOJqcye3HEcOA
	osSIInZ6jrJS44NknC3H6/SCGeWGenmEcomkX9FtC3qVqbpJYYL6/WuYzuqbI75Z6oO9NM
	FWGfGhM62CtHlCMLtKcO+QtAkJ5Wf5TCPU1EjxOPIzRYSCg+UJFUCJ0LIJdSuOjOdI7mxX
	aLkzA91fHoIGlLWH5R0yusbEofa0zSva5tVQE91JoWfasz3llklTRpoVOTaFgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgPSlSGzqhyhprXQ1IZvqFI257oe8TfUU7AH4jWJhVE=;
	b=iKZ36iDRDy4eQJP+DjVHfses+leMJ3tQ/04c3V6jxsubk/2jmT60XxZEhY8A1mJy1txV4q
	t2a+hEdc859AhTCQ==
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
Subject: [PATCH v3 22/29] x86/cpu: Use consolidated leaf 0x2 descriptor table
Date: Wed, 19 Mar 2025 13:21:30 +0100
Message-ID: <20250319122137.4004-23-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPUID leaf 0x2 output is a stream of one-byte descriptors, each implying
certain details about the CPU's cache and TLB entries.

At previous commits, the mapping tables for such descriptors were merged
into one consolidated table.  The mapping was also transformed into a
hash lookup instead of a loop-based lookup for each descriptor.

Use the new consolidated table and its hash-based lookup through the
for_each_leaf_0x2_tlb_entry() accessor.

Remove the TLB-specific mapping, intel_tlb_table[], as it is now no
longer used.  Remove the <cpuid/types.h> macro, for_each_leaf_0x2_desc(),
since the converted code was its last user.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 10 ++++
 arch/x86/kernel/cpu/intel.c        | 83 +++---------------------------
 2 files changed, 17 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 4426198f2078..10d16f6bbe6f 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -111,4 +111,14 @@ struct leaf_0x2_table {
 
 extern const struct leaf_0x2_table cpuid_0x2_table[256];
 
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of entries
+ * for their respective TLB types.  TLB descriptor 0x63 is an exception: it
+ * implies 4 dTLB entries for 1GB pages and 32 dTLB entries for 2MB or 4MB pages.
+ *
+ * Encode that descriptor's dTLB entry count for 2MB/4MB pages here, as the entry
+ * count for dTLB 1GB pages is already encoded at the cpuid_0x2_table[]'s mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES		32
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index def433e0081f..e5d814703406 100644
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
 
 	cpuid_get_leaf_0x2_regs(&regs);
-	for_each_leaf_0x2_desc(regs, desc)
-		intel_tlb_lookup(*desc);
+	for_each_leaf_0x2_entry(regs, ptr, entry)
+		intel_tlb_lookup(entry);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


