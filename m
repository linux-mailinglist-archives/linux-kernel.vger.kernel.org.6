Return-Path: <linux-kernel+bounces-543563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE876A4D712
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F5189AA99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AE1FFC7A;
	Tue,  4 Mar 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBlbMNX6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/qZbgqsG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9A71FFC62
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078397; cv=none; b=HLsXRbuo/bSHyxCyCIHApOmT4tV5RZrh9Qrg2W2zA6UcGxrgV6+ppd2xo7DSqb7Raxv7GD4GjQW0ww+5Z46V0pzEpQ3/r6FG6HHZksuuB1NzAWzAYFUMT3RkxsBCQ4ppucBbu1C29jRax6pDcS5/ZGKgMlTLdYNqDmrYt1NFexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078397; c=relaxed/simple;
	bh=4mVs32IP/JJwhwIrsKAxI9VHzWvehSi+ZVAbjv/FwJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwDEMHBakTt6UOAwKHdp0CohkEgy9f4A+WnrHMGo4oayFfx+5+2ls1VNU70FiVweBVmN1QJlPhZwK0nRQN6LjTb1ayU5nVS7O6kxCL/WroqaQ+A2bztA6tS0PHpNm3Qzo6A4Yqh0+e5jzTtv04qZPTRDXVK26viz0Py79aIE/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBlbMNX6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/qZbgqsG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1f/wmwFxuOm6NrbQ051GrZqcSL5nUPMeX+arERDp4+A=;
	b=LBlbMNX69QeNxID6lY+6SSLV0ftXgGZm/0OwqJbLdAahr9dXp2KzVp95uFrSM18+uQ7ROm
	vghxaHCZBUBrDFj45jfFfLF5GGcmaiDUZvZYfHKWGha96F4+N7zU7ZZwhlFq/EVbZdtg5r
	8M9DN/pho85RiTAGTeQAjbTEPkTSuxHFhai9FSjUBYk7LGrPqNCBEoMTVkRfvPJ7avEbi6
	B+n4jhxJqcua59CROeGoZzUU/u+zMAVpstOnl8L7PgUbtwClhGOzqSRdyMsCKUNNnJJtkO
	NdtqSL7cGAknQaXcGZ3PVx3A2RQyY0PaX3rOUin7q45bLZeombHTR2YvAVNsHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1f/wmwFxuOm6NrbQ051GrZqcSL5nUPMeX+arERDp4+A=;
	b=/qZbgqsGs98NaRjGy5tp9QX7DUnBpESXsJf7rCQ/yu4VdyOFuhmWT00M+SlWy5s88/1Z8Z
	3Ii29lcB7cwgTjCA==
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
Subject: [PATCH v1 20/40] x86: treewide: Introduce x86_vendor_amd_or_hygon()
Date: Tue,  4 Mar 2025 09:51:31 +0100
Message-ID: <20250304085152.51092-21-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern to check if an x86 vendor is AMD or HYGON (or not both), is
pretty common across the x86 tree.

Introduce x86_vendor_amd_or_hygon() macro at asm/processor.h, and use it
across the x86 tree.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/events/amd/uncore.c       |  3 +--
 arch/x86/events/rapl.c             |  3 +--
 arch/x86/include/asm/processor.h   |  5 +++++
 arch/x86/kernel/amd_nb.c           |  9 +++------
 arch/x86/kernel/cpu/bugs.c         | 12 ++++--------
 arch/x86/kernel/cpu/cacheinfo.c    |  7 ++-----
 arch/x86/kernel/cpu/mce/core.c     |  4 ++--
 arch/x86/kernel/cpu/mce/severity.c |  3 +--
 arch/x86/kernel/cpu/mtrr/cleanup.c |  3 +--
 arch/x86/kernel/smpboot.c          |  3 +--
 arch/x86/kvm/svm/svm.c             |  3 +--
 arch/x86/pci/amd_bus.c             |  3 +--
 arch/x86/xen/enlighten.c           | 15 +++++----------
 arch/x86/xen/pmu.c                 |  3 +--
 14 files changed, 29 insertions(+), 47 deletions(-)

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
index d5d9a071cddc..0f586c638e87 100644
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
index 74a2949ff872..0024d126c385 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -633,8 +633,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	union _cpuid4_leaf_eax	cache_eax;
 	int 			i = -1;
 
-	if (c->x86_vendor == X86_VENDOR_AMD ||
-	    c->x86_vendor == X86_VENDOR_HYGON)
+	if (x86_vendor_amd_or_hygon(c->x86_vendor))
 		op = 0x8000001d;
 	else
 		op = 4;
@@ -907,11 +906,9 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 	int index_msb, i;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86_vendor == X86_VENDOR_AMD ||
-	    c->x86_vendor == X86_VENDOR_HYGON) {
+	if (x86_vendor_amd_or_hygon(c->x86_vendor))
 		if (__cache_amd_cpumap_setup(cpu, index, id4))
 			return;
-	}
 
 	ci = this_cpu_ci->info_list + index;
 	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e199465dc9e1..5ba8424cf4e6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1250,8 +1250,7 @@ static inline void mwait_play_dead(void)
 	unsigned int highest_subcstate = 0;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+	if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor))
 		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
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


