Return-Path: <linux-kernel+bounces-543551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30321A4D705
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83FD18841C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792F41FCCF1;
	Tue,  4 Mar 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CmlqvT5a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Zs17dyD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337581EB9E2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078360; cv=none; b=k88Z8Qjg35vBx7839Ku5Odx0LKj60wm78sioLQQQxCg1jbCo8IK0ajJxICSuocN+U0+UPu4xuQTtW4afc8KQPh5uuVNbreDZF1O0S/AK3/z8+OUs+lKw+bLBuK6cBZVe+64+ROC4xVnh8zpOLpVUybOvR8FqUNQIensOiMHE+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078360; c=relaxed/simple;
	bh=CmXBmlxisxYfICcVVw72tCNLH2pkwCIh/kTyeLQccfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrVRN8trhkFi5iWQd6uiJ1mFbgiOmvs2+4Y8aH5o8McMLRSYLhZidhBSCYr9ClZ1O7hXsTIycGUNJ4tOuigoK5emFPrqa8r+WStqJvctS9n9G3dZMnOwDLk9blMpDpO4KAl0XN4DMwvb6IVTcq1kMfRQ8ckF/1xYvWaFG9ZftfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CmlqvT5a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Zs17dyD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIj6d0Awb9GmuBboZEo5cpoLvkz83NhzBB7Rnz7sfts=;
	b=CmlqvT5aYkmw3pQ/WF8kLw3aV+ngJGOOKq9sfhrRv3SpQ1j4qVNTdTh7ReBl3udZt/JqRK
	xgta5qrUUht5hBe335Ake4VDz+jb2AK6Y3Eu9cb4hChMNyKwkLf2PdbJawWxbGu1gK/FOP
	y4UHFnhzimqQ+0QOiTAKeDLa0+sLCBmeULoIebfoAMrfPNsnZgTX0lLfYSVPwMsP9Qa8iR
	w06pjDuxuMBi1y/qdDzF2HTxD/D83HLmk9p1IQYUxNgir7soR+AiMZuAI7GWRY7wQ7LLtj
	crYVP0Cd7Y5qQWCO3NNm0BEHAYfXmQyywi0u7AIEEzWJabIVMVtGKqsx7xXFlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIj6d0Awb9GmuBboZEo5cpoLvkz83NhzBB7Rnz7sfts=;
	b=7Zs17dyDMB9arkZoBq54GdkMuJEt9c6s6f6MegBEQSap/1EJpXVgqfvw8Vn1QA6ySGl8l4
	EqD3/1+/O2aB4cAQ==
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
Subject: [PATCH v1 08/40] x86/cpu: Get rid of smp_store_cpu_info() indirection
Date: Tue,  4 Mar 2025 09:51:19 +0100
Message-ID: <20250304085152.51092-9-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

smp_store_cpu_info() is just a wrapper around identify_secondary_cpu()
without further value.

Move the extra bits from smp_store_cpu_info() into identify_secondary_cpu()
and remove the wrapper.

[darwi: Make it compile and fixup the xen/smp_pv.c instance]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/include/asm/smp.h       |  2 --
 arch/x86/kernel/cpu/common.c     | 11 +++++++++--
 arch/x86/kernel/smpboot.c        | 24 ++----------------------
 arch/x86/xen/smp_pv.c            |  2 +-
 5 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0ea227fa027c..d5d9a071cddc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -229,7 +229,7 @@ static inline unsigned long long l1tf_pfn_limit(void)
 void init_cpu_devs(void);
 void get_cpu_vendor(struct cpuinfo_x86 *c);
 extern void early_cpu_init(void);
-extern void identify_secondary_cpu(struct cpuinfo_x86 *);
+extern void identify_secondary_cpu(unsigned int cpu);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..820a90d2fb4a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -119,8 +119,6 @@ void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 
-void smp_store_cpu_info(int id);
-
 asmlinkage __visible void smp_reboot_interrupt(void);
 __visible void smp_reschedule_interrupt(struct pt_regs *regs);
 __visible void smp_call_function_interrupt(struct pt_regs *regs);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 486395356faf..749fe02ef1f7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1960,9 +1960,15 @@ static __init void identify_boot_cpu(void)
 	lkgs_init();
 }
 
-void identify_secondary_cpu(struct cpuinfo_x86 *c)
+void identify_secondary_cpu(unsigned int cpu)
 {
-	BUG_ON(c == &boot_cpu_data);
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	/* Copy boot_cpu_data only on the first bringup */
+	if (!c->initialized)
+		*c = boot_cpu_data;
+	c->cpu_index = cpu;
+
 	identify_cpu(c);
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
@@ -1973,6 +1979,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 		update_gds_msr();
 
 	tsx_ap_init();
+	c->initialized = true;
 }
 
 void print_cpu_info(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..e199465dc9e1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -190,7 +190,7 @@ static void ap_starting(void)
 	apic_ap_setup();
 
 	/* Save the processor parameters. */
-	smp_store_cpu_info(cpuid);
+	identify_secondary_cpu(cpuid);
 
 	/*
 	 * The topology information must be up to date before
@@ -215,7 +215,7 @@ static void ap_calibrate_delay(void)
 {
 	/*
 	 * Calibrate the delay loop and update loops_per_jiffy in cpu_data.
-	 * smp_store_cpu_info() stored a value that is close but not as
+	 * identify_secondary_cpu() stored a value that is close but not as
 	 * accurate as the value just calculated.
 	 *
 	 * As this is invoked after the TSC synchronization check,
@@ -315,26 +315,6 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
-/*
- * The bootstrap kernel entry code has set these up. Save them for
- * a given CPU
- */
-void smp_store_cpu_info(int id)
-{
-	struct cpuinfo_x86 *c = &cpu_data(id);
-
-	/* Copy boot_cpu_data only on the first bringup */
-	if (!c->initialized)
-		*c = boot_cpu_data;
-	c->cpu_index = id;
-	/*
-	 * During boot time, CPU0 has this setup already. Save the info when
-	 * bringing up an AP.
-	 */
-	identify_secondary_cpu(c);
-	c->initialized = true;
-}
-
 static bool
 topology_same_node(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 6863d3da7dec..688ff59318ae 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -70,7 +70,7 @@ static void cpu_bringup(void)
 		xen_enable_syscall();
 	}
 	cpu = smp_processor_id();
-	smp_store_cpu_info(cpu);
+	identify_secondary_cpu(cpu);
 	set_cpu_sibling_map(cpu);
 
 	speculative_store_bypass_ht_init();
-- 
2.48.1


