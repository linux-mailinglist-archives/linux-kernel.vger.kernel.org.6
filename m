Return-Path: <linux-kernel+bounces-567974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D70A68CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D183B5961
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE382571C4;
	Wed, 19 Mar 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KhR0nYpn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w0i/RW2i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF22561C3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386916; cv=none; b=EaqWesfv91MY/3LPZZetWWo7qy48VbFdQWVvX3P2DzH7X/XPEFCsnfTTZNbzC7nF/h6H4QNuay1hZ75xS63gbvNBVbEGobyS3hHhzQer1QOI9Qk8IQRhkTQ7jCruF6IVNuen3xz/3dGETLsqGUnltPHLjR6uP/4JMkrXmY0HoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386916; c=relaxed/simple;
	bh=HlC2VyZgCA26vEg1uzqeEX+cghnr3JEFvxlGFcxFtS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2nB6JhH3sRgGHTB06WWFDZUCHu07IBP7MZvxhR/m3QCB4XHw6Z4KzcbCfx8Z5T3qFNZX9EhuyCEFsrHL7Xfxx4yo0qPCd071bxXhqpBJfC00mm3uYYphEha1W7sm/lbLrkg3EGPpcNROw5iL2w7ivCx3e7fEmyT6DbWI0CT04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KhR0nYpn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w0i/RW2i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3kKrwykp7K2hYkCCBfT55S/xZ2U7zEFrml/gv7Bp/0=;
	b=KhR0nYpnjNqMjevlvaavq8Nqn5sJXbVVc5rrZl94ArJYZkX5xnNPn+EQyaBh2Sn5beP7hx
	0t9zfwY55v9aKZNRJV1tL/ABq5Wk7gSa9f3ToyDBsyGC2BWiTQIIToWZOwq87xoDIS/540
	T26ZizKeN/XkBmBwR9K1koFEG/+akBZTvVmBdmg7y7xyYk9FO9ORJKe7i6QLn8i3DFca/C
	KscTnFHTopfbSJUjz26TnC2yG0izgW6Ow6ceAmMcVmV10PdXIVQwotLqA7OQ7NS2uvBkZu
	ERmedpf2Lq3UOEmefUqpQ5MwVDbIj3C0IlTPgQQE5aWuUZ1M3nBa8sw7oNrIoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3kKrwykp7K2hYkCCBfT55S/xZ2U7zEFrml/gv7Bp/0=;
	b=w0i/RW2ioFlBSM5JAlFSHwasK3uUwwJN1FufSZdJueb5j0PNH3lOdtdLobfVOOW+MRQtlH
	3faEMy9ItUUvKAAQ==
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
Subject: [PATCH v3 03/29] x86/cpu: Introduce and use leaf 0x2 parsing helpers
Date: Wed, 19 Mar 2025 13:21:11 +0100
Message-ID: <20250319122137.4004-4-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce CPUID leaf 0x2 parsing helpers at <asm/cpuid/leaf_0x2_api.h>.
This allows sharing the leaf 0x2's output validation and iteration logic
across both x86/cpu intel.c and cacheinfo.c.

Start by converting intel.c to the new API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h              |  1 +
 arch/x86/include/asm/cpuid/leaf_0x2_api.h | 65 +++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h        | 16 ++++++
 arch/x86/kernel/cpu/intel.c               | 23 +++-----
 4 files changed, 88 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/leaf_0x2_api.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index d5749b25fa10..585819331dc6 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -4,5 +4,6 @@
 #define _ASM_X86_CPUID_H
 
 #include <asm/cpuid/api.h>
+#include <asm/cpuid/leaf_0x2_api.h>
 
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/leaf_0x2_api.h b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
new file mode 100644
index 000000000000..4c845fc96716
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/leaf_0x2_api.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_LEAF_0x2_API_H
+#define _ASM_X86_CPUID_LEAF_0x2_API_H
+
+#include <asm/cpuid/api.h>
+#include <asm/cpuid/types.h>
+
+/**
+ * cpuid_get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
+ * @regs:	Output parameter
+ *
+ * Query CPUID leaf 0x2 and store its output in @regs.	Force set any
+ * invalid 1-byte descriptor returned by the hardware to zero (the NULL
+ * cache/TLB descriptor) before returning it to the caller.
+ *
+ * Use for_each_leaf_0x2_desc() to iterate over the returned output.
+ */
+static inline void cpuid_get_leaf_0x2_regs(union leaf_0x2_regs *regs)
+{
+	cpuid_leaf(0x2, regs);
+
+	/*
+	 * All Intel CPUs must report an iteration count of 1.	In case
+	 * of bogus hardware, treat all returned descriptors as NULL.
+	 */
+	if (regs->desc[0] != 0x01) {
+		for (int i = 0; i < 4; i++)
+			regs->regv[i] = 0;
+		return;
+	}
+
+	/*
+	 * The most significant bit (MSB) of each register must be clear.
+	 * If a register is invalid, replace its descriptors with NULL.
+	 */
+	for (int i = 0; i < 4; i++) {
+		if (regs->reg[i].invalid)
+			regs->regv[i] = 0;
+	}
+}
+
+/**
+ * for_each_leaf_0x2_desc() - Iterator for CPUID leaf 0x2 descriptors
+ * @regs:	Leaf 0x2 output, as returned by cpuid_get_leaf_0x2_regs()
+ * @desc:	Pointer to the returned descriptor for each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
+ * @regs.  Provide each descriptor through @desc.
+ *
+ * Note that the first byte is skipped as it is not a descriptor.
+ *
+ * Sample usage::
+ *
+ *	union leaf_0x2_regs regs;
+ *	u8 *desc;
+ *
+ *	cpuid_get_leaf_0x2_regs(&regs);
+ *	for_each_leaf_0x2_desc(regs, desc) {
+ *		// Handle *desc value
+ *	}
+ */
+#define for_each_leaf_0x2_desc(regs, desc)				\
+	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
+
+#endif /* _ASM_X86_CPUID_LEAF_0x2_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 8582e27e836d..753f6c4514f4 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -29,4 +29,20 @@ enum cpuid_regs_idx {
 #define CPUID_LEAF_FREQ		0x16
 #define CPUID_LEAF_TILE		0x1d
 
+/*
+ * Types for CPUID(0x2) parsing
+ * Check <asm/cpuid/leaf_0x2_api.h>
+ */
+
+struct leaf_0x2_reg {
+		u32		: 31,
+			invalid	: 1;
+};
+
+union leaf_0x2_regs {
+	struct leaf_0x2_reg	reg[4];
+	u32			regv[4];
+	u8			desc[16];
+};
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0570d4d86006..aeb7d6d48379 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -16,6 +16,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
@@ -778,27 +779,15 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	u32 regs[4];
-	u8 *desc = (u8 *)regs;
+	union leaf_0x2_regs regs;
+	u8 *desc;
 
 	if (c->cpuid_level < 2)
 		return;
 
-	cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-	/* Intel CPUs must report an iteration count of 1 */
-	if (desc[0] != 0x01)
-		return;
-
-	/* If a register's bit 31 is set, it is an unknown format */
-	for (int i = 0; i < 4; i++) {
-		if (regs[i] & (1 << 31))
-			regs[i] = 0;
-	}
-
-	/* Skip the first byte as it is not a descriptor */
-	for (int i = 1; i < 16; i++)
-		intel_tlb_lookup(desc[i]);
+	cpuid_get_leaf_0x2_regs(&regs);
+	for_each_leaf_0x2_desc(regs, desc)
+		intel_tlb_lookup(*desc);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


