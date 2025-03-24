Return-Path: <linux-kernel+bounces-573748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FEA6DBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03EC3A770A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164726280A;
	Mon, 24 Mar 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpozj9oQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/tse191R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282B25FA0B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823273; cv=none; b=aE41RaBdHCNg9hEbFcX9EtJ7r6tCpJMUFIqwceCgsrWo84zU13Q2lsSGSKQB3SikEWVp7a6CfnWYMWFXUilgXFAWocedkuLLJ+z3akbDYTdmiEyHtN1/5/43eT2ZS9YRyPaIhppfSKZkL9uBFiUJZEmQVcY/AekuHmesABtcbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823273; c=relaxed/simple;
	bh=oJBlFC8RVHGgl8j5wwdUCD6FwPiik3nx0cWpMgPmt1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL4yZue7/scst40EPL1r0MQIarPtW/rub6gLOlLajQkrMY0asrafYq5e/FuZCMsIXAgvWtei6g4lAquSWluS4E+D3IyS1t+rqTolTwawNzVn+Aj2Km1oD3qQ0JuYX6KFVn+b+T46ugzGjaO1NauLVi5aAGZG8eiEx2xUbVb1EN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpozj9oQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/tse191R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6RSxh+ngXoYWpeKOf12JK5PZIX476LSn57y3yYtrgk=;
	b=lpozj9oQ2V2n6Nh9jNWEQdmKC697+mIB0e3zuvjXqV1zq8/cktn6LzqxE8F0jAgLtOQC42
	a/KoFNMnV0PmZpLuMsqBx+tHOQryH1SX7tgA6LF/WrI0HjnlZVef5nsw/Y+NWAMIsHUZ/o
	kJtXQbqOF3JhZJXE4dpisb13MvknYDeDWqJlw7nTzv9o/BExKx/LdhNP4ygP2u0Rs95I08
	103QW/aPwQEqXybv2rnxqQivzgGYJKX54+vx8Ikk65D6yFPM9VZSjhNjJfqcFCAU5A0i9Q
	i5UQmv3PAUW9FKYbRlchHQ2j9WRcZfTs2Or8R/5CaqOWvmi4yTHl+nRIn/e4FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6RSxh+ngXoYWpeKOf12JK5PZIX476LSn57y3yYtrgk=;
	b=/tse191RVktpzQ4sOOuuRz9nvPn74ABPslv4UgkxUivR1OfPjmfP5SudJt1pToyIpehjOu
	c5I2RChxK5+DszDA==
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
Subject: [PATCH v4 19/29] x86/cpu: Use enums for TLB descriptor types
Date: Mon, 24 Mar 2025 14:33:14 +0100
Message-ID: <20250324133324.23458-20-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf 0x2 one-byte TLB descriptor types:

	TLB_INST_4K
	TLB_INST_4M
	TLB_INST_2M_4M
	...

are just discriminators to be used within the intel_tlb_table[] mapping.
Their specific values are irrelevant.

Use enums for such types.

Make the enum packed and static assert that its values remain within a
single byte so that the intel_tlb_table[] size do not go out of hand.

Use a __CHECKER__ guard for the static_assert(sizeof(enum) == 1) line as
sparse ignores the __packed annotation on enums.  This is similar to
commit fe3944fb245a ("fs: Move enum rw_hint into a new header file") for
core SCSI code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/r/Z9rsTirs9lLfEPD9@lx-t490
---
 arch/x86/include/asm/cpuid/types.h | 31 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c        | 28 +++------------------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 39c3c79c081b..e756327f8e02 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -60,4 +60,35 @@ enum _cache_table_type {
 static_assert(sizeof(enum _cache_table_type) == 1);
 #endif
 
+/*
+ * Leaf 0x2 1-byte descriptors' TLB types
+ * To be used for their mappings at intel_tlb_table[]
+ *
+ * Start at 1 since type 0 is reserved for HW byte descriptors which are
+ * not recognized by the kernel; i.e., those without an explicit mapping.
+ */
+enum _tlb_table_type {
+	TLB_INST_4K		= 1,
+	TLB_INST_4M,
+	TLB_INST_2M_4M,
+	TLB_INST_ALL,
+
+	TLB_DATA_4K,
+	TLB_DATA_4M,
+	TLB_DATA_2M_4M,
+	TLB_DATA_4K_4M,
+	TLB_DATA_1G,
+	TLB_DATA_1G_2M_4M,
+
+	TLB_DATA0_4K,
+	TLB_DATA0_4M,
+	TLB_DATA0_2M_4M,
+
+	STLB_4K,
+	STLB_4K_2M,
+} __packed;
+#ifndef __CHECKER__
+static_assert(sizeof(enum _tlb_table_type) == 1);
+#endif
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index aeb7d6d48379..def433e0081f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -626,28 +626,6 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K		0x01
-#define TLB_INST_4M		0x02
-#define TLB_INST_2M_4M		0x03
-
-#define TLB_INST_ALL		0x05
-#define TLB_INST_1G		0x06
-
-#define TLB_DATA_4K		0x11
-#define TLB_DATA_4M		0x12
-#define TLB_DATA_2M_4M		0x13
-#define TLB_DATA_4K_4M		0x14
-
-#define TLB_DATA_1G		0x16
-#define TLB_DATA_1G_2M_4M	0x17
-
-#define TLB_DATA0_4K		0x21
-#define TLB_DATA0_4M		0x22
-#define TLB_DATA0_2M_4M		0x23
-
-#define STLB_4K			0x41
-#define STLB_4K_2M		0x42
-
 /*
  * All of leaf 0x2's one-byte TLB descriptors implies the same number of
  * entries for their respective TLB types.  The 0x63 descriptor is an
@@ -660,7 +638,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 
 struct _tlb_table {
 	unsigned char descriptor;
-	char tlb_type;
+	enum _tlb_table_type type;
 	unsigned int entries;
 };
 
@@ -718,11 +696,11 @@ static void intel_tlb_lookup(const unsigned char desc)
 	     intel_tlb_table[k].descriptor != 0; k++)
 		;
 
-	if (intel_tlb_table[k].tlb_type == 0)
+	if (intel_tlb_table[k].type == 0)
 		return;
 
 	entries = intel_tlb_table[k].entries;
-	switch (intel_tlb_table[k].tlb_type) {
+	switch (intel_tlb_table[k].type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);
-- 
2.48.1


