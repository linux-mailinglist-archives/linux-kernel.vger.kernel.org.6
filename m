Return-Path: <linux-kernel+bounces-543570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC47A4D717
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1D1175207
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009D202970;
	Tue,  4 Mar 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SKgQ6yWz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/01IoSI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683C201035
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078415; cv=none; b=PvJgKjLTBcfVtoURJE4qtQ/9zlNXjKrmUCRkHqH+ngR3UQYCJ4FeGdZVHQhBhauEfMC+y7gME61z2SfmNSon6NAxA5W8gTwMMkT1zwilWYtJMxA++JHclHRtpZhh3dKMWvQ0wH7rUhQgtRlQ7vUAylGq7UGsks1/XatK0oMo+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078415; c=relaxed/simple;
	bh=xfuli/6Bk10AYSMF8dE3nvNxHUUUcl16U1XYIU9Ak9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFiOU4fwUE682jqMxILlRjmpsMSek3JDSI4p63kA2X42Q+lxwMcvFf1/iv8mHoWEJ61V3NyclowgzzNhJ39Te0r041U7xjdKn+JtN8SVhrdR2O+hVr5bVfl3fTj5x4dGD/l4w4sY7aqSFBg7fx09GuFFt8doEUo7mJ04f5fkeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SKgQ6yWz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/01IoSI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErUogKnyYbOrLN500X12sFjQxofXjma3yuw+5jvrHP8=;
	b=SKgQ6yWzJnXAITRXZ5hkbQ1Kq745/NFuNAVmh/AGdVoWqYqlnDKNbn4R6uhO/zIaG1FtUH
	G8AGV8q+gweSiAQhzTyyxWHm2NB9QFHOmElQu8XT5w9HES6cRCpuWdxD8eKacaYaZqB13n
	qqQEgDxGwxv4WCooad3A4Xy+9S0L6REYzeOTetzITDeYDs8ZO03vwHS+yMCcROzCluMesG
	INtCtCNrX2P8yTbJ1h5aQPWBgvDIH+80JTEjD8bZ++OmWpoqaUjDD173aaKwLNGTeYRlMa
	WoaJM5Usmfn6nyymtA/UcR+W2WdGe9sZu7be7nrJNv+nwf/mIWtvkZuyUqdpcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErUogKnyYbOrLN500X12sFjQxofXjma3yuw+5jvrHP8=;
	b=F/01IoSIH1XiN02Rr7sqGN9XDD6blIlsTbIfWHKlC8NrVWVeRr9SedilrUOHyOmuLbtdKt
	K5CAhWaq073u3/Aw==
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
Subject: [PATCH v1 26/40] x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
Date: Tue,  4 Mar 2025 09:51:37 +0100
Message-ID: <20250304085152.51092-27-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parent commits decoupled amd_northbridge from _cpuid4_info_regs, moved
AMD L3 northbridge cache_disable_0/1 sysfs code to its own file, and
splitted AMD vs. Intel leaf 0x4 handling into:

    amd_fill_cpuid4_info()
    intel_fill_cpuid4_info()
    fill_cpuid4_info()

After doing all that, the "_cpuid4_info_regs" name becomes a mouthful.
It is also not totally accurate, as the structure holds cpuid4 derived
information like cache node ID and size -- not just regs.

Rename struct _cpuid4_info_regs to _cpuid4_info.  That new name also
better matches the AMD/Intel leaf 0x4 functions mentioned above.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index cc320817cfc3..2d4180b961f4 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -159,7 +159,7 @@ union _cpuid4_leaf_ecx {
 	u32 full;
 };
 
-struct _cpuid4_info_regs {
+struct _cpuid4_info {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
 	union _cpuid4_leaf_ecx ecx;
@@ -295,7 +295,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_leaf_eax eax,
+static int cpuid4_info_fill_done(struct _cpuid4_info *id4, union _cpuid4_leaf_eax eax,
 				 union _cpuid4_leaf_ebx ebx, union _cpuid4_leaf_ecx ecx)
 {
 	if (eax.split.type == CTYPE_NULL)
@@ -312,7 +312,7 @@ static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_le
 	return 0;
 }
 
-static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -327,7 +327,7 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int intel_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -339,7 +339,7 @@ static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	return x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor) ?
 		amd_fill_cpuid4_info(index, id4) :
@@ -473,7 +473,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * parameters cpuid leaf to find the cache details
 		 */
 		for (i = 0; i < ci->num_leaves; i++) {
-			struct _cpuid4_info_regs id4 = {};
+			struct _cpuid4_info id4 = {};
 			int retval;
 
 			retval = intel_fill_cpuid4_info(i, &id4);
@@ -560,7 +560,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    const struct _cpuid4_info_regs *id4)
+				    const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -617,7 +617,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 const struct _cpuid4_info_regs *id4)
+				 const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -650,7 +650,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info *id4,
 			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
@@ -681,7 +681,7 @@ int init_cache_level(unsigned int cpu)
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
-static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
+static void get_cache_id(int cpu, struct _cpuid4_info *id4)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned long num_threads_sharing;
@@ -696,8 +696,8 @@ int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
-	struct _cpuid4_info_regs id4 = {};
 	struct amd_northbridge *nb = NULL;
+	struct _cpuid4_info id4 = {};
 	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-- 
2.48.1


