Return-Path: <linux-kernel+bounces-543553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84CA4D703
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19733AF7FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD71FECB3;
	Tue,  4 Mar 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qxe3EL5b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvNB2p5l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497A1FC7F5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078366; cv=none; b=WKCSYzJE1HAqrR+rT4huqQLjS7D/u4ddLIF7j+C1uVncq4StQEnm9LrTV+QjpfeLonzHBRgFUNjca1KD+NVlZ2zz2yhWNLzj22CJJXbSKeDrFaf+sJL/eZ9rPFvzljXBlhVboC6DmU7aCu4pG30efh9/8Ff8Nr3J8NC0RS8U/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078366; c=relaxed/simple;
	bh=kr0XFF8MATjQQ8C5nVeTvNNWXuZKh754nmloxOWRwRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZWx5wqjQFqLwSt8M7CEh5oLk1IbzaU4cOOwAZ++gSm3LbPRkVbV/w9gZHQts7Wl7x3xrge6HamEqs6oQv2d1aOhjDEdyoExJxM0Ic2xWfZN+cctZPHOWWycQMWry8kNR6ZNHLkAdsi/nVgJirG+QXBHveMJCC5T8mvhk/Wc6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qxe3EL5b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bvNB2p5l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZetDRpn0NcCndrg1Y0AubvUguUN9OJwsJpVg/UfAF+0=;
	b=Qxe3EL5bbQMYBElxFRalaAWvamj7kuDM/ifC2mi0lhqSsq0A5J6mXLng5XaF4x9q/HuAs0
	YA5oU6K8m5OYL1BMQKvxnA2KBNs5Bm4DTw2OVaeUesD0FjegXbij26fPsYTw/+GQqCjy7h
	O+Zux/+MLxpnfuxiz8YHVkOcP/UiVXJNhFU+aap2nxIygyfIuetWqq5x16L3/mOn415lAO
	i41yRARrnUYIwtGJm27XqCFyTHWA0cDlS8K91wpUlnLNZxI9IRtMvZVvtc7ePO3wxyVldi
	dllRxvn8BagojKn75A4rfhArvfz6EXEYjjY+GQmnZH50OZJJNqUVXJd3fenaXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZetDRpn0NcCndrg1Y0AubvUguUN9OJwsJpVg/UfAF+0=;
	b=bvNB2p5lGRYEUh/arP4vpio5KpMEmxqA+ANr08oz8KulnxWhTp1CHVHOeG0/8U1Jt6OSrE
	ji2OKTPXZP3pqQCA==
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
Subject: [PATCH v1 10/40] x86/cpu: Remove leaf 0x2 parsing loop and add helpers
Date: Tue,  4 Mar 2025 09:51:21 +0100
Message-ID: <20250304085152.51092-11-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leaf 0x2 output includes a "query count" byte where it was supposed to
specify the number of repeated cpuid leaf 0x2 subleaf 0 queries needed
to extract all of the hardware's cache and TLB descriptors.

Per current Intel manuals, all CPUs supporting this leaf "will always"
return an iteration count of 1.

Remove the leaf 0x2 query count loop and just query the hardware once.
Parse the output with C99 bitfields instead of ugly bitwise operations.
Provide leaf 0x2 parsing helpers at asm/cpuid/types.h to do all that.

Use the new leaf 0x2 parsing helpers at x86/cpu intel.c.  Further
commits will also use them for x86/cacheinfo.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 79 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c        | 24 +++------
 2 files changed, 85 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/types.h

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
new file mode 100644
index 000000000000..50f6046a57b9
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_TYPES_H
+#define _ASM_X86_CPUID_TYPES_H
+
+#include <linux/types.h>
+
+#include <asm/cpuid.h>
+
+/*
+ * CPUID(0x2) parsing helpers
+ * Check for_each_leaf_0x2_desc() documentation.
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
+/**
+ * get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
+ * @regs:	Output parameter
+ *
+ * Get leaf 0x2 register output and store it in @regs.  Invalid byte
+ * descriptors returned by the hardware will be force set to zero (the
+ * NULL cache/TLB descriptor) before returning them to the caller.
+ */
+static inline void get_leaf_0x2_regs(union leaf_0x2_regs *regs)
+{
+	cpuid_leaf(0x2, regs);
+
+	/*
+	 * All Intel CPUs must report an iteration count of 1.  In case
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
+ * for_each_leaf_0x2_desc() - Iterator for leaf 0x2 descriptors
+ * @regs:	Leaf 0x2 register output, as returned by get_leaf_0x2_regs()
+ * @desc:	Pointer to the returned descriptor for each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed leaf 0x2 output registers
+ * @regs.  Provide each descriptor through @desc.
+ *
+ * Sample usage::
+ *
+ *	union leaf_0x2_regs regs;
+ *	u8 *desc;
+ *
+ *	get_leaf_0x2_regs(&regs);
+ *	for_each_leaf_0x2_desc(regs, desc) {
+ *		// Handle *desc value
+ *	}
+ */
+#define for_each_leaf_0x2_desc(regs, desc)				\
+	/* Skip the first byte as it is not a descriptor */		\
+	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)
+
+#endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index cfd492cf9c3b..57e170ffe3ba 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -15,6 +15,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/cpuid/types.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
@@ -778,28 +779,15 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	int i, j, n;
-	unsigned int regs[4];
-	unsigned char *desc = (unsigned char *)regs;
+	union leaf_0x2_regs regs;
+	u8 *desc;
 
 	if (c->cpuid_level < 2)
 		return;
 
-	/* Number of times to iterate */
-	n = cpuid_eax(2) & 0xFF;
-
-	for (i = 0 ; i < n ; i++) {
-		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 4 ; j++)
-			if (regs[j] & (1 << 31))
-				regs[j] = 0;
-
-		/* Byte 0 is level count, not a descriptor */
-		for (j = 1 ; j < 16 ; j++)
-			intel_tlb_lookup(desc[j]);
-	}
+	get_leaf_0x2_regs(&regs);
+	for_each_leaf_0x2_desc(regs, desc)
+		intel_tlb_lookup(*desc);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


