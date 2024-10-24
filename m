Return-Path: <linux-kernel+bounces-379971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C799AE68F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC631C25633
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC71E0487;
	Thu, 24 Oct 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0+jU53Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77B1DD9D1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776463; cv=none; b=LYoqyTIU2y9RRpurY9CiEJVEJEHQtwBj1kPIh85uj0ahyNp5eE7/EMJOMOqDV81EfmtlB2j+vZxPhSFYrBydmAV8yFDq+edaPGU/6152CGPbzgu8X/0HYOEbkMQ9Bz9qdYuYXgXX873wFSPGzNuvhY3ztKstc0qbD0p2w5ne5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776463; c=relaxed/simple;
	bh=IwYiZVV7fVvD1ooD/I4eHLt5Mcmsgl+8V5a9Fm7VQX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kA/peDn6LUGNojTVTsnMjrE45J2BooeJyHjPIYqC5l+l142tfSjNaBiCPr1xvwtj+DuRgNhGS9niPaRmd4gT/ln9OeHsym3i2dXnsxP2TlykLts7qSomX5eSlDrcUGNeX3AjVpk5w68HFfRaLzUplVbc7qbD13K/ord9MguIbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0+jU53Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7D1C4CEC7;
	Thu, 24 Oct 2024 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776462;
	bh=IwYiZVV7fVvD1ooD/I4eHLt5Mcmsgl+8V5a9Fm7VQX4=;
	h=Date:From:To:Cc:Subject:From;
	b=Z0+jU53ZfVoxC59uRAT24vT9YUwFTxFiSFwFOrddA4VVPRnfQhPGc+qfWyhLfkmgJ
	 YFH8vXOyCaski9XfcJn3rlCjCAVZOKXr4Kiya41Cf22SyF5m9/TSIuuS/JTdli1qsm
	 xm+Yk9wlYIisMvPkvsZ1QRpuGFEf3AuvPr6i0AUOSVKaOv5Aq3n4X7rW/oKzw3jaSz
	 0XLt/xRhRzSJa7rzmSirEfA7Vj19Iuv1bVLW14n15YdN2DCthb9HjHuhKJQO+YBwbW
	 bZO1Jta2RB1V+6xCpeiJsw2q2MZWMEZ1I991xXFXTYmgLRVjlRSqhp5+ABYDNgMoIf
	 rSlwXvtASX85A==
Date: Thu, 24 Oct 2024 10:27:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Xin Li <xin3.li@intel.com>, Sean Christopherson <seanjc@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <ZxpLSBzGin3vjs3b@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes from these csets:

  dc1e67f70f6d4e33 ("KVM VMX: Move MSR_IA32_VMX_MISC bit defines to asm/vmx.h")
  d7bfc9ffd58037ff ("KVM: VMX: Move MSR_IA32_VMX_BASIC bit defines to asm/vmx.h")
  beb2e446046f8dd9 ("x86/cpu: KVM: Move macro to encode PAT value to common header")
  e7e80b66fb242a63 ("x86/cpu: KVM: Add common defines for architectural memory types (PAT, MTRRs, etc.)")

That cause no changes to tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  $

To see how this works take a look at this previous update:

  https://git.kernel.org/torvalds/c/174372668933ede5

  174372668933ede5 ("tools arch x86: Sync the msr-index.h copy with the kernel sources to pick IA32_MKTME_KEYID_PARTITIONING")

Just silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Xin Li <xin3.li@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index a7c06a46fb767d4a..3ae84c3b8e6dba73 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -36,6 +36,20 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
 
+/*
+ * Architectural memory types that are common to MTRRs, PAT, VMX MSRs, etc.
+ * Most MSRs support/allow only a subset of memory types, but the values
+ * themselves are common across all relevant MSRs.
+ */
+#define X86_MEMTYPE_UC		0ull	/* Uncacheable, a.k.a. Strong Uncacheable */
+#define X86_MEMTYPE_WC		1ull	/* Write Combining */
+/* RESERVED			2 */
+/* RESERVED			3 */
+#define X86_MEMTYPE_WT		4ull	/* Write Through */
+#define X86_MEMTYPE_WP		5ull	/* Write Protected */
+#define X86_MEMTYPE_WB		6ull	/* Write Back */
+#define X86_MEMTYPE_UC_MINUS	7ull	/* Weak Uncacheabled (PAT only) */
+
 /* FRED MSRs */
 #define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
 #define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
@@ -365,6 +379,12 @@
 
 #define MSR_IA32_CR_PAT			0x00000277
 
+#define PAT_VALUE(p0, p1, p2, p3, p4, p5, p6, p7)			\
+	((X86_MEMTYPE_ ## p0)      | (X86_MEMTYPE_ ## p1 << 8)  |	\
+	(X86_MEMTYPE_ ## p2 << 16) | (X86_MEMTYPE_ ## p3 << 24) |	\
+	(X86_MEMTYPE_ ## p4 << 32) | (X86_MEMTYPE_ ## p5 << 40) |	\
+	(X86_MEMTYPE_ ## p6 << 48) | (X86_MEMTYPE_ ## p7 << 56))
+
 #define MSR_IA32_DEBUGCTLMSR		0x000001d9
 #define MSR_IA32_LASTBRANCHFROMIP	0x000001db
 #define MSR_IA32_LASTBRANCHTOIP		0x000001dc
@@ -1159,15 +1179,6 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
 
-/* VMX_BASIC bits and bitmasks */
-#define VMX_BASIC_VMCS_SIZE_SHIFT	32
-#define VMX_BASIC_TRUE_CTLS		(1ULL << 55)
-#define VMX_BASIC_64		0x0001000000000000LLU
-#define VMX_BASIC_MEM_TYPE_SHIFT	50
-#define VMX_BASIC_MEM_TYPE_MASK	0x003c000000000000LLU
-#define VMX_BASIC_MEM_TYPE_WB	6LLU
-#define VMX_BASIC_INOUT		0x0040000000000000LLU
-
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
@@ -1185,11 +1196,6 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
-/* MSR_IA32_VMX_MISC bits */
-#define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
-#define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
-#define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
-
 /* AMD-V MSRs */
 #define MSR_VM_CR                       0xc0010114
 #define MSR_VM_IGNNE                    0xc0010115
-- 
2.47.0


