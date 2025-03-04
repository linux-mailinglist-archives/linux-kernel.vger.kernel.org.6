Return-Path: <linux-kernel+bounces-543573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51485A4D71B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BBB3AC6FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985DC202C49;
	Tue,  4 Mar 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/Z3HA4e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQeQsp4j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043E20299B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078424; cv=none; b=bl1uG+4e6XSmT7+u/UEa8JCmN25SG0P2qubGrteavYjeLb0q8diCP3/NSLwPQgizCvmOMY/gTwgwjHBbPG605xvBjfkT2n/z7IKoHNbEwxLTOBZ8GXKfIqjG9zEW7Pv5OVpZYtAMnrCjuXb/8wbw9GKPa42PZU1woTIXRWXAgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078424; c=relaxed/simple;
	bh=jQG2vJwletYh/YmRc/akLKRggomuDVR/3lDBbg5HsJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFftPUDfETZ6RtuEijYmXmwzTE0S+Mi02TuJEMQnqEE1eV1M4OfAARv2/rQCZ3JvcJb3E2GfkK7xibhRVpbdFv/gYYDvSBXuDiFfmdqBzkrp2NWtLwfAE2cao9zAIwWpj4PT1egawZ5/pDD38F8TqGw610k0e+YxDsnhHQLW1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/Z3HA4e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQeQsp4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb6teOml12m9BN6gMTZxK6kbam1cyV9ClzejVYMjaJU=;
	b=R/Z3HA4e7Drq/q7dj2tcYf+HJho2mxb+2xdZ7pRwVAdKMT2yzt37aewTKarwqHI9m5w2pR
	BJj+mh7DXOgExCebJ+hFn/LbWdu6K5uuWqSGOlVU22t8MZsaxCVfsV3Gv9YdIaYxieyeST
	L1DwzHfgEVLoO2zgvLBVskYit3wCZGC1lQTt4odEb07F5/8iJYWXoGW80uMBZx1CvTkLJq
	8eKYCPSG87Hx341Hfh+O7s4DR65QTKfBq4MQl9AKYgs73M6idwLL7peUXm/ubRwT5bXn1O
	GDgiX9Ew953TIkAN00kGP9Wb8zTLLFTQXzYEAIMeYSbYm7tCi2rKwnXJpZDoEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb6teOml12m9BN6gMTZxK6kbam1cyV9ClzejVYMjaJU=;
	b=bQeQsp4jnrBujqCNCkSubATgyit6WtTwlzd7J/0rhjCKExMKMG5vOXl0FhNTNhvdGNj7Kk
	Gduws+4hLK9RGUCQ==
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
Subject: [PATCH v1 29/40] x86/cpu: Use enums for TLB descriptor types
Date: Tue,  4 Mar 2025 09:51:40 +0100
Message-ID: <20250304085152.51092-30-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
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

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c        | 28 +++-------------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 0051d8c2b9ee..2a4653af2ba2 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -90,4 +90,30 @@ enum _cache_table_type {
 } __packed;
 static_assert(sizeof(enum _cache_table_type) == 1);
 
+/*
+ * Leaf 0x2 1-byte descriptors' TLB types
+ * To be used for their mappings at intel_tlb_table[]
+ */
+enum _tlb_table_type {
+	TLB_INST_4K,
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
+static_assert(sizeof(enum _tlb_table_type) == 1);
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 57e170ffe3ba..884cd1b1e4ff 100644
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


