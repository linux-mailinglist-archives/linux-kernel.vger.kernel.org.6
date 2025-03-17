Return-Path: <linux-kernel+bounces-564678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0109A6594A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEFC1898051
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBF1ACEDE;
	Mon, 17 Mar 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMtRPP9H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bh6UBTwS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C31A3152
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230357; cv=none; b=LeTKAhOwD+V4Xilx7FgPXumTu+MYXHGX+akNVdmcSnF9KqpcRGmeHo0QzcJngfFaevyqQOz5Mb2QKvlipLJMz2WncoB1L2/lQJA3L6+t1ixgCNxht6ySUTICZP7JYIAKwsWajHB9NQ9a3OkIAV8yqHuqftIq/XCS2GTb/rx3xl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230357; c=relaxed/simple;
	bh=qbRTBl+8n1tb+eIxXCb+esnpwVd5sd4ujNEqtrtkNj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjrLNglbBv/88YpICow3OUs8MNgFSy62svI6Gfx6pBhKOmnE5oCJv8PRf3LkcJkoALp+bPQE4nnjDa1RPmWG5HW6i/2ecVhKxp5lvDcVrUZ4MxOFLPMbTZnVboMK5MCyNTymL6a5vC/+lPbyo4S9rFCt8kUFbocv1PkEFz1DGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMtRPP9H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bh6UBTwS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYPreuPadP6Ec1wM4X2Q3ewOl74/mnHmwvvpFvEBolk=;
	b=fMtRPP9HdArWTUhvUGIR2EN71nHfx4GODsQEtcSw1vJ84EAR7ybM6MKzpf87HU22v+EdPG
	9NjyyK5SWiOzA6HRf8jRjWnVhspKdPPr0s72fVudRT23cOFbP3LZaf9ZOta5w7UfPJKz1M
	j+X+mGIJLdibq/QLSnu6DXslYjo4p2eJbHFNUzsEL9sJhr/ymurumQpw6ubqFvMafBb+8Y
	5v6J5FECGU1QL7etddhyWeZ6GnI6Eqoh5x+3ndbrjMwJl2OGjbEghhZfqrePKZIBeRv86S
	Dr19wsyprDLsUvfmCdQdPnDtbu1Q4Nde5CtA4QMfKrHcASSyedlrU4JYjCY7GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYPreuPadP6Ec1wM4X2Q3ewOl74/mnHmwvvpFvEBolk=;
	b=Bh6UBTwSPXUdvOQPA5ZztC8rtVyemuAFNo+XEZ0o8LNykaKOpIYvcz/ojOfawWVghe8z+9
	USiS8UDAUwm3KZBQ==
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
Subject: [PATCH v2 01/29] x86: treewide: Introduce x86_vendor_amd_or_hygon()
Date: Mon, 17 Mar 2025 17:47:17 +0100
Message-ID: <20250317164745.4754-2-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern to check if an x86 vendor is AMD or HYGON (or not both) is
pretty common.  Introduce x86_vendor_amd_or_hygon() at <asm/processor.h>
and use it across the x86 tree.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/events/amd/uncore.c       |  3 +--
 arch/x86/events/rapl.c             |  3 +--
 arch/x86/include/asm/processor.h   |  5 +++++
 arch/x86/kernel/amd_nb.c           |  9 +++------
 arch/x86/kernel/cpu/bugs.c         | 12 ++++--------
 arch/x86/kernel/cpu/cacheinfo.c    |  6 ++----
 arch/x86/kernel/cpu/mce/core.c     |  4 ++--
 arch/x86/kernel/cpu/mce/severity.c |  3 +--
 arch/x86/kernel/cpu/mtrr/cleanup.c |  3 +--
 arch/x86/kvm/svm/svm.c             |  3 +--
 arch/x86/pci/amd_bus.c             |  3 +--
 arch/x86/xen/enlighten.c           | 15 +++++----------
 arch/x86/xen/pmu.c                 |  3 +--
 13 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 49c26ce2b115..5141c0375990 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1023,8 +1023,7 @@ static int __init amd_uncore_init(void)
 	int ret = -ENODEV;
 	int i;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6941f4811bec..999ea90059ae 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -123,8 +123,7 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
  *	     them as die-scope.
  */
 #define rapl_pkg_pmu_is_pkg_scope()				\
-	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
-	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+	x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor)
 
 struct rapl_pmu {
 	raw_spinlock_t		lock;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 7a3918308a36..527e6e00de88 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -203,6 +203,11 @@ struct cpuinfo_x86 {
 
 #define X86_VENDOR_UNKNOWN	0xff
 
+static inline bool x86_vendor_amd_or_hygon(u8 vendor)
+{
+	return (vendor == X86_VENDOR_AMD || vendor == X86_VENDOR_HYGON);
+}
+
 /*
  * capabilities of CPUs
  */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 11fac09e3a8c..bac8d3b6f12b 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -127,8 +127,7 @@ bool __init early_is_amd_nb(u32 device)
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return false;
 
 	if (cpu_feature_enabled(X86_FEATURE_ZEN))
@@ -147,8 +146,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return NULL;
 
 	/* assume all cpus from fam10h have mmconfig */
@@ -320,8 +318,7 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return 0;
 
 	amd_cache_northbridges();
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a5d0998d7604..b0dc4e96f4bc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1081,8 +1081,7 @@ static void __init retbleed_select_mitigation(void)
 
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor)) {
 			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
@@ -1106,8 +1105,7 @@ static void __init retbleed_select_mitigation(void)
 
 		x86_return_thunk = retbleed_return_thunk;
 
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 			pr_err(RETBLEED_UNTRAIN_MSG);
 
 		mitigate_smt = true;
@@ -1872,8 +1870,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 */
 	if (boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 	    boot_cpu_has(X86_FEATURE_IBPB) &&
-	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
+	    x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor)) {
 
 		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
 			setup_force_cpu_cap(X86_FEATURE_USE_IBPB_FW);
@@ -2903,8 +2900,7 @@ static ssize_t retbleed_show_state(char *buf)
 {
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
 	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
 
 		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b3a520959b51..584811ffca0c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -637,8 +637,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	union _cpuid4_leaf_eax	cache_eax;
 	int 			i = -1;
 
-	if (c->x86_vendor == X86_VENDOR_AMD ||
-	    c->x86_vendor == X86_VENDOR_HYGON)
+	if (x86_vendor_amd_or_hygon(c->x86_vendor))
 		op = 0x8000001d;
 	else
 		op = 4;
@@ -930,8 +929,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	int index_msb, i;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor == X86_VENDOR_AMD ||
-	    c->x86_vendor == X86_VENDOR_HYGON) {
+	if (x86_vendor_amd_or_hygon(c->x86_vendor)) {
 		if (__cache_amd_cpumap_setup(cpu, index, base))
 			return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9894c7..135d7b8f3e55 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -227,7 +227,7 @@ static void print_mce(struct mce_hw_err *err)
 
 	__print_mce(err);
 
-	if (m->cpuvendor != X86_VENDOR_AMD && m->cpuvendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(m->cpuvendor))
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
@@ -2060,7 +2060,7 @@ static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
  */
 static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
+	if (x86_vendor_amd_or_hygon(c->x86_vendor)) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..a3f2f1c236bc 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -413,8 +413,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
 
 int noinstr mce_severity(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+	if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return mce_severity_amd(m, regs, msg, is_excp);
 	else
 		return mce_severity_intel(m, regs, msg, is_excp);
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 18cf79d6e2c5..236d7e3b4e55 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -820,8 +820,7 @@ int __init amd_special_default_mtrr(void)
 {
 	u32 l, h;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return 0;
 	if (boot_cpu_data.x86 < 0xf)
 		return 0;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a713c803a3a3..8c88f3c0c2cd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -523,8 +523,7 @@ static bool __kvm_is_svm_supported(void)
 	int cpu = smp_processor_id();
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor != X86_VENDOR_AMD &&
-	    c->x86_vendor != X86_VENDOR_HYGON) {
+	if (!x86_vendor_amd_or_hygon(c->x86_vendor)) {
 		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
 		return false;
 	}
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 631512f7ec85..43033d54080a 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -399,8 +399,7 @@ static int __init pci_io_ecs_init(void)
 
 static int __init amd_postcore_init(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return 0;
 
 	early_root_info_init();
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 43dcd8c7badc..13df4917d7d8 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -82,11 +82,9 @@ void xen_hypercall_setfunc(void)
 	if (static_call_query(xen_hypercall) != xen_hypercall_hvm)
 		return;
 
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
-		static_call_update(xen_hypercall, xen_hypercall_amd);
-	else
-		static_call_update(xen_hypercall, xen_hypercall_intel);
+	static_call_update(xen_hypercall,
+			   x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor) ?
+			   xen_hypercall_amd : xen_hypercall_intel);
 }
 
 /*
@@ -118,11 +116,8 @@ noinstr void *__xen_hypercall_setfunc(void)
 	if (!boot_cpu_has(X86_FEATURE_CPUID))
 		xen_get_vendor();
 
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
-		func = xen_hypercall_amd;
-	else
-		func = xen_hypercall_intel;
+	func = x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor) ?
+		xen_hypercall_amd : xen_hypercall_intel;
 
 	static_call_update_early(xen_hypercall, func);
 
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index f06987b0efc3..af5cb19b5990 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -130,8 +130,7 @@ static inline uint32_t get_fam15h_addr(u32 addr)
 
 static inline bool is_amd_pmu_msr(unsigned int msr)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (!x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return false;
 
 	if ((msr >= MSR_F15H_PERF_CTL &&
-- 
2.48.1


