Return-Path: <linux-kernel+bounces-573747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCA7A6DBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023C17A8791
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF02627FA;
	Mon, 24 Mar 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pF1ygvpR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVFkubNr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1762627F0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823270; cv=none; b=bNnyHL2fQgc9OVgF9YpbCoam4H5JcJzvyzY1qooPh4oh2PZaR4pUsKEGtZWT01rIoPTouSfD1DiNW5wSYnENZjSHlM94Ery/RwoAzIJuSUKqGDYNVyKZxTjdoEWpKsoZpcZY1nuX190+VycxrVilKrejHpDNepIIqwVYB46Hyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823270; c=relaxed/simple;
	bh=CCsVGPhMTEHdw0KyIC3xSOxU5ckL+Ig+2aAbm8+B5KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5MytRnGOzEw7fIXN2qIEjIuqI0QBhnl74Ge4LYlWby+piu2Ce9GEIcwsZVwgkop+uhTO6D0cACrcXmgM8ksORC0Ft62aKXbgYtxNWD3AoiQE9JCigcqutROiXsQ9jfGU/yCbt4wuueh+V6wMfQzQ34hN5I+Bb+v9DhMPQLCQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pF1ygvpR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVFkubNr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1Bssu+qRSO7OksQLyO3GqGguJ7uDaDXjuRfoD8zv3k=;
	b=pF1ygvpRTOvIlClz2P+35jnin2nDCh42ozkOsd0BN724x6cJespeXbLdhn/BUq6yCX2Ci7
	sqK90i2+QSDvV40RBgM6TqnMUFbM+uZoNp1xy80Yod2WkPgE8CmBmG3jIzngrIp8LFqsCi
	emJhgn6RJtXV99CdWys6/hx6VdsltkWwkHo86JHtUa1d0n1V+hvqDa0OnxxzyqsxfD5Q+r
	c64MGM+RzEVGABftW0ITve0W2CFpGi7orzHxbUrPVFh4WW0m4zOGH0i7Pfb6F3++zK/Iu6
	LUTQn4FP7gNaEX/BgA+sYchQS0FyB1RbudAVYyqeOQAVuyQsI5TYUISPCRRDLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1Bssu+qRSO7OksQLyO3GqGguJ7uDaDXjuRfoD8zv3k=;
	b=GVFkubNrzlnJ7appiqOol899xXEskQ4SKNGckDcDNZXricSO9/uA1UregPOlvSCfrxMyDQ
	1Qrog8LbAV25jYCw==
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
Subject: [PATCH v4 18/29] x86/cacheinfo: Use enums for cache descriptor types
Date: Mon, 24 Mar 2025 14:33:13 +0100
Message-ID: <20250324133324.23458-19-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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

Use a __CHECKER__ guard for the static_assert(sizeof(enum) == 1) line as
sparse ignores the __packed annotation on enums.  This is similar to
commit fe3944fb245a ("fs: Move enum rw_hint into a new header file") for
core SCSI code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/r/Z9rsTirs9lLfEPD9@lx-t490
---
 arch/x86/include/asm/cpuid/types.h | 15 +++++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c    |  9 ++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 753f6c4514f4..39c3c79c081b 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_CPUID_TYPES_H
 #define _ASM_X86_CPUID_TYPES_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 /*
@@ -45,4 +46,18 @@ union leaf_0x2_regs {
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
+	CACHE_L3,
+} __packed;
+#ifndef __CHECKER__
+static_assert(sizeof(enum _cache_table_type) == 1);
+#endif
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


