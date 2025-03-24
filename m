Return-Path: <linux-kernel+bounces-573732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8BFA6DBAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8B1660BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7E25F79E;
	Mon, 24 Mar 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etNWPIDI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y0Alil/M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5925EFB8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823223; cv=none; b=GrUlzCZBnBUqChj9R9rUNkJH2Des/dGlQYbhjSoj/9M5lUtshkTdfYqD8GGoGqtwU1zrLpipnribOm8qteGdwizfF7UtlE2JvhWkLLPjCLneQrjpTJAUL3hkqHqiI8y7/RdEzLuC8M7SLQZPaBIpabU+AoUA/7eps0008KPU4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823223; c=relaxed/simple;
	bh=HlC2VyZgCA26vEg1uzqeEX+cghnr3JEFvxlGFcxFtS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDRHsSrd9slsKFDutCQf2UTOIMAUszp+ZoTqwJqggUk//sDyeA5HHVKqhCeH4nFYAKcQbkpUt432D9l2G1rxHMn95wDKV2Q+S8d0UhH1p2+GaqpPulWrX80VBTdO8YLpc/zf5vWbQevZlgKx3g2rBAOzBWghLFuZvn+t3N+ey2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etNWPIDI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y0Alil/M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3kKrwykp7K2hYkCCBfT55S/xZ2U7zEFrml/gv7Bp/0=;
	b=etNWPIDIW42GRp+/vXTDn0KZ0qNIaK9LM7hc8yjAIeZot8WhMVzizfogp8tVs3QVVyWro6
	dr1PDSSA/9OWUb6b0k9rYva/d2z9qHQtLLbbBZPwPhzk1JF+aMSWWP7c1eWDaGJ1MZ/Is3
	qWE8yIh4y25ofQRAwSSF64GFRFI9PFvNZRvu7MsWByJcaQglRu9soD2L6zYaVW91pLACQ5
	gd6lygOVacxYtBDt0sxMAokjrdm5LV3oicOllbiJn7tLugeHewkdqtGTOp5LpCPVOelK6B
	AdA6S+2nB+QPDpRLUPu3cjIKYSO+OrZr/CzIlrv760x5N0Hrih4siTZwKSFD1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3kKrwykp7K2hYkCCBfT55S/xZ2U7zEFrml/gv7Bp/0=;
	b=Y0Alil/MB1I96Yd3tFH4wd5vXI+tF2Ud/kOaRXmuymeZn3FxJsucR7Fr+QuphBYeNbUS5e
	BkgaMfH3UroeDiAw==
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
Subject: [PATCH v4 03/29] x86/cpu: Introduce and use leaf 0x2 parsing helpers
Date: Mon, 24 Mar 2025 14:32:58 +0100
Message-ID: <20250324133324.23458-4-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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


