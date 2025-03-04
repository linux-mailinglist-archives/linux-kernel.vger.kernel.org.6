Return-Path: <linux-kernel+bounces-543572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC41A4D71D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC38C1892F09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A3202995;
	Tue,  4 Mar 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BvT2ZQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELXvKaq8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2120298B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078421; cv=none; b=fHYr+jjw7kaMDxbmT00zNG1PoahZL6DLB4Gns5iVOwUMNqQ31DQ/wE3G33tYmDF85ZpVed9zPRZLWtkOKX/CINZYmTtHtG/zBbXf8l7H9YxQfKI6L+BWanqbJF7GSWlW46QEW1eyR1gluN7pMI1MGWvSwRX/BC8Xc2zE+rd+spg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078421; c=relaxed/simple;
	bh=lsxhQurcmM196BSH+oL0A4Qd/q/w2Y/kWtlldc1NdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lut/Y2xk93bwaa8jP2dtwhSnY0wAOpR5Fh7pV2exbiSeIX1ah1XI+/IjCjzVyLvyiSQciROPSt6yDDwSRYTOp9VvmTBBHwp+z6t3aE4C2DNO4Pon8TenGspRvmLAKhP9AwJl0o7FhXKV27GohTcHGT0/jMorlXAoI8a2nIVtPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BvT2ZQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELXvKaq8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyaqtxIU8m3/v0+B5MpQxFjLCTwaJUXCAgCjkjGIBQA=;
	b=4BvT2ZQd2KaFEG7/j9csj17Alf0lhmx2odBQSwdFeK9hawBS6P5gjI9I9ShDY8OqgnSSY5
	vWzk+CvQzRJPEKjXeLPBK8uGF5j3dW2tR6dUMXx/1SmE5i6RnOPgrwAiwrUdokohGhkruD
	tfGSoe7+9YOpLxlRdnXqpruJAhWYyHdtuzh7a+ZC6T5tH06EtDBG44sGIATY5OhY5IeDyN
	Jv0+/urrJLVk4MmVUGYxAlTXUGGKpNASGQGhNE5W3VrvDBaD3f3817uetXF7B/7WCZqr3Y
	IURLNFeKzRJqS+jkUoe+Dafy7urnwlV+QIOSMwUXZz1C6hIx5P49fA6bNTE2oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyaqtxIU8m3/v0+B5MpQxFjLCTwaJUXCAgCjkjGIBQA=;
	b=ELXvKaq8NQK7kDQF5xX5aub9QbzKZcGzVntck5qec7Q9LUVmDVT4NDshL729mCp5gHHJdB
	NKDnjivtKPkLV7CQ==
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
Subject: [PATCH v1 28/40] x86/cacheinfo: Use enums for cache descriptor types
Date: Tue,  4 Mar 2025 09:51:39 +0100
Message-ID: <20250304085152.51092-29-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
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
 arch/x86/include/asm/cpuid/types.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c    |  9 ++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 50f6046a57b9..0051d8c2b9ee 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_CPUID_TYPES_H
 #define _ASM_X86_CPUID_TYPES_H
 
+#include <linux/build_bug.h>
+#include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
 #include <asm/cpuid.h>
@@ -76,4 +78,16 @@ static inline void get_leaf_0x2_regs(union leaf_0x2_regs *regs)
 	/* Skip the first byte as it is not a descriptor */		\
 	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
 
+/*
+ * Leaf 0x2 1-byte descriptors' cache types
+ * To be used for their mappings at cache_table[]
+ */
+enum _cache_table_type {
+	CACHE_L1_INST,
+	CACHE_L1_DATA,
+	CACHE_L2,
+	CACHE_L3,
+} __packed;
+static_assert(sizeof(enum _cache_table_type) == 1);
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 9e87321466fe..a7fccbab268d 100644
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
 	unsigned char descriptor;
-	char cache_type;
+	enum _cache_table_type type;
 	short size;
 };
 
@@ -517,7 +512,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			if (!entry)
 				continue;
 
-			switch (entry->cache_type) {
+			switch (entry->type) {
 			case CACHE_L1_INST:	l1i += entry->size; break;
 			case CACHE_L1_DATA:	l1d += entry->size; break;
 			case CACHE_L2:		l2  += entry->size; break;
-- 
2.48.1


