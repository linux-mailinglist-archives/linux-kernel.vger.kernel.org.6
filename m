Return-Path: <linux-kernel+bounces-564679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2300A6594B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5333B3B4488
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6E1B0420;
	Mon, 17 Mar 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfarSvpy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubRHtSez"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016E1A8F93
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230359; cv=none; b=CpGXmiF/5YWO91hYUuAEbIgkfKxYgIJuqy03T3K6aQI+xKaCQzBliSS6iXy/0cpMWomardOaW1h8HeF3bZ8CrirGGxIWNijhmLeRtFl4Ehf38l6I+0GDn6CEiYpXz1OOs73FBTXEmUZjlAraQDSgRgKOhhBtTUD8iHORLFr2LwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230359; c=relaxed/simple;
	bh=w4OyWtEP5btI6Hrc223n/71G8AYBgI3lei3u4+Qe7RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nim5wQuR1Q88qgGrI7ibw3QNcQrlY8voNKkur0cg+scM4YKTZMW/22hn1rfpZMy2pRkfypXGJ6LqyBP6atrWqIJEWENpSmdErpce2o8PZ/MfPM+pFMy2ZIfVQiDhsRUjlDe+WfvTl9tI4z1KqQib/Ho71DLO2WvztfJavqzvRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfarSvpy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ubRHtSez; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drkSrK4AL7wqH7zKVRmHTme3spximGRUgI3UCWZ06rs=;
	b=jfarSvpyT2nIY06DZSthtdiDktUWOT3e8E2QYv2VmHm6abMu5pyJmYcBdVdUJ1Whx+0COY
	orqQ5+oJfuA+CuXCpwLGYEoivoiPRQgvka9H8mdLL7uM6UKTgOBhzY2c26yAZ/MMo2l0vJ
	BQPNKWKJmlLvxoB8PbAP5RxxElpJcqQ2/tO9i9qd5+gzx7GfR3d2/ruShcNbLsTCmESoJP
	kSHzudHqetDFxTcp+CsZ2jz7tR2w1lcaY29M5CmfZ5YwjutgAUnE8wWW91Bl/U5Nyo4ma2
	n8h57JCasOrZn9XouegrEgYPljcCUW9bsVZovqqvbBS6vXjuDGcHcq/nSR62UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drkSrK4AL7wqH7zKVRmHTme3spximGRUgI3UCWZ06rs=;
	b=ubRHtSezxkpuZjaSsK2DL+wwNGP4FRFMtHX+LzcTpAEAnyF+R2Etac6IM+iLMhCohJ60G6
	MJWs9OYuhneldkCg==
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
Subject: [PATCH v2 02/29] x86/cpuid: Refactor <asm/cpuid.h>
Date: Mon, 17 Mar 2025 17:47:18 +0100
Message-ID: <20250317164745.4754-3-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for next commits where CPUID headers will be expanded,
refactor the CPUID header <asm/cpuid.h> into:

    asm/cpuid/
    ├── api.h
    └── types.h

Move the CPUID data structures into <asm/cpuid/types.h> and the access
APIs into <asm/cpuid/api.h>.  Let <asm/cpuid.h> be just an include of
<asm/cpuid/api.h> so that existing call sites do not break.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h       | 217 +----------------------------
 arch/x86/include/asm/cpuid/api.h   | 208 +++++++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h |  29 ++++
 3 files changed, 238 insertions(+), 216 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/api.h
 create mode 100644 arch/x86/include/asm/cpuid/types.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index a92e4b08820a..d5749b25fa10 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -1,223 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * CPUID-related helpers/definitions
- */
 
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
-#include <linux/build_bug.h>
-#include <linux/types.h>
-
-#include <asm/string.h>
-
-struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
-};
-
-enum cpuid_regs_idx {
-	CPUID_EAX = 0,
-	CPUID_EBX,
-	CPUID_ECX,
-	CPUID_EDX,
-};
-
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
-#define CPUID_LEAF_XSTATE	0x0d
-#define CPUID_LEAF_TSC		0x15
-#define CPUID_LEAF_FREQ		0x16
-#define CPUID_LEAF_TILE		0x1d
-
-#ifdef CONFIG_X86_32
-bool have_cpuid_p(void);
-#else
-static inline bool have_cpuid_p(void)
-{
-	return true;
-}
-#endif
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=a" (*eax),
-	      "=b" (*ebx),
-	      "=c" (*ecx),
-	      "=d" (*edx)
-	    : "0" (*eax), "2" (*ecx)
-	    : "memory");
-}
-
-#define native_cpuid_reg(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
-{								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
-								\
-	native_cpuid(&eax, &ebx, &ecx, &edx);			\
-								\
-	return reg;						\
-}
-
-/*
- * Native CPUID functions returning a single datum.
- */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
-
-#ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
-#else
-#define __cpuid			native_cpuid
-#endif
-
-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = 0;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = count;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return eax;
-}
-
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ebx;
-}
-
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ecx;
-}
-
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return edx;
-}
-
-static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
-{
-	regs[CPUID_EAX] = leaf;
-	regs[CPUID_ECX] = subleaf;
-	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
-}
-
-#define cpuid_subleaf(leaf, subleaf, regs) {		\
-	static_assert(sizeof(*(regs)) == 16);		\
-	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
-}
-
-#define cpuid_leaf(leaf, regs) {			\
-	static_assert(sizeof(*(regs)) == 16);		\
-	__cpuid_read(leaf, 0, (u32 *)(regs));		\
-}
-
-static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
-				    enum cpuid_regs_idx regidx, u32 *reg)
-{
-	u32 regs[4];
-
-	__cpuid_read(leaf, subleaf, regs);
-	*reg = regs[regidx];
-}
-
-#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
-	static_assert(sizeof(*(reg)) == 4);			\
-	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
-}
-
-#define cpuid_leaf_reg(leaf, regidx, reg) {			\
-	static_assert(sizeof(*(reg)) == 4);			\
-	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
-}
-
-static __always_inline bool cpuid_function_is_indexed(u32 function)
-{
-	switch (function) {
-	case 4:
-	case 7:
-	case 0xb:
-	case 0xd:
-	case 0xf:
-	case 0x10:
-	case 0x12:
-	case 0x14:
-	case 0x17:
-	case 0x18:
-	case 0x1d:
-	case 0x1e:
-	case 0x1f:
-	case 0x24:
-	case 0x8000001d:
-		return true;
-	}
-
-	return false;
-}
-
-#define for_each_possible_hypervisor_cpuid_base(function) \
-	for (function = 0x40000000; function < 0x40010000; function += 0x100)
-
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
-{
-	uint32_t base, eax, signature[3];
-
-	for_each_possible_hypervisor_cpuid_base(base) {
-		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-
-		/*
-		 * This must not compile to "call memcmp" because it's called
-		 * from PVH early boot code before instrumentation is set up
-		 * and memcmp() itself may be instrumented.
-		 */
-		if (!__builtin_memcmp(sig, signature, 12) &&
-		    (leaves == 0 || ((eax - base) >= leaves)))
-			return base;
-	}
-
-	return 0;
-}
+#include <asm/cpuid/api.h>
 
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
new file mode 100644
index 000000000000..4d1da9cc8b6f
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_CPUID_API_H
+#define _ASM_X86_CPUID_API_H
+
+#include <linux/build_bug.h>
+#include <linux/types.h>
+
+#include <asm/cpuid/types.h>
+#include <asm/string.h>
+
+/*
+ * Raw CPUID accessors
+ */
+
+#ifdef CONFIG_X86_32
+bool have_cpuid_p(void);
+#else
+static inline bool have_cpuid_p(void)
+{
+	return true;
+}
+#endif
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}
+
+#define native_cpuid_reg(reg)					\
+static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax = op, ebx, ecx = 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
+}
+
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
+
+#ifdef CONFIG_PARAVIRT_XXL
+#include <asm/paravirt.h>
+#else
+#define __cpuid			native_cpuid
+#endif
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op,
+			 unsigned int *eax, unsigned int *ebx,
+			 unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = 0;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(unsigned int op, int count,
+			       unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ebx;
+}
+
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ecx;
+}
+
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return edx;
+}
+
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+{
+	regs[CPUID_EAX] = leaf;
+	regs[CPUID_ECX] = subleaf;
+	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs) {		\
+	static_assert(sizeof(*(regs)) == 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
+}
+
+#define cpuid_leaf(leaf, regs) {			\
+	static_assert(sizeof(*(regs)) == 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs));		\
+}
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg = regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
+	static_assert(sizeof(*(reg)) == 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
+}
+
+#define cpuid_leaf_reg(leaf, regidx, reg) {			\
+	static_assert(sizeof(*(reg)) == 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
+}
+
+static __always_inline bool cpuid_function_is_indexed(u32 function)
+{
+	switch (function) {
+	case 4:
+	case 7:
+	case 0xb:
+	case 0xd:
+	case 0xf:
+	case 0x10:
+	case 0x12:
+	case 0x14:
+	case 0x17:
+	case 0x18:
+	case 0x1d:
+	case 0x1e:
+	case 0x1f:
+	case 0x24:
+	case 0x8000001d:
+		return true;
+	}
+
+	return false;
+}
+
+#define for_each_possible_hypervisor_cpuid_base(function) \
+	for (function = 0x40000000; function < 0x40010000; function += 0x100)
+
+static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+{
+	uint32_t base, eax, signature[3];
+
+	for_each_possible_hypervisor_cpuid_base(base) {
+		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
+
+		/*
+		 * This must not compile to "call memcmp" because it's called
+		 * from PVH early boot code before instrumentation is set up
+		 * and memcmp() itself may be instrumented.
+		 */
+		if (!__builtin_memcmp(sig, signature, 12) &&
+		    (leaves == 0 || ((eax - base) >= leaves)))
+			return base;
+	}
+
+	return 0;
+}
+
+#endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
new file mode 100644
index 000000000000..724002aaff4d
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_TYPES_H
+#define _ASM_X86_CPUID_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * Types for raw CPUID access
+ */
+
+struct cpuid_regs {
+	u32 eax, ebx, ecx, edx;
+};
+
+enum cpuid_regs_idx {
+	CPUID_EAX = 0,
+	CPUID_EBX,
+	CPUID_ECX,
+	CPUID_EDX,
+};
+
+#define CPUID_LEAF_MWAIT	0x5
+#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_XSTATE	0x0d
+#define CPUID_LEAF_TSC		0x15
+#define CPUID_LEAF_FREQ		0x16
+#define CPUID_LEAF_TILE		0x1d
+
+#endif /* _ASM_X86_CPUID_TYPES_H */
-- 
2.48.1


