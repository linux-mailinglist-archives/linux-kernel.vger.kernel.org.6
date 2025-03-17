Return-Path: <linux-kernel+bounces-564694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166F5A6596B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9510A3BF78D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E952040B3;
	Mon, 17 Mar 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHAHxX1W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NsXWY56C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361272036FD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230401; cv=none; b=DmSPyLdYf3FFOM4oHxOJcP8i9Zj/hOE/vtTTpem/M9W+brQUspP9rUcZGKrzfQPlbhSBzZF6weNMEqYYTbVOdswe7ZeitDVoHXhV+cMnJIrZ1w5oApG5X82NXEELTHALmqUtDor+gnPBvuqApBN458htYsnkL5szYTepWgL6+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230401; c=relaxed/simple;
	bh=LnTJm4mGf0RQgHGzlsPp/SRaszZBLC9pdhcPNqmrAGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qox1Mb/fQpeKzFApjFlNWGOmY/t89cEDfIn8yfJ2AGTSdRZ+km6IUpfDaVcpKWhSYQpXVzbETE8DiMesYlGlg4tAXsJMu9Ah7L9JelPrsY5lEs5fltRfcHZGWF6242M0SeUzUcjWmfmsic4zzZYmNubJOnFzFhhCTXRvyggXQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHAHxX1W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NsXWY56C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YbusUlI7ecs7aYF7W/prLkvtEjoYUbZ4FHRaSGRxAU=;
	b=WHAHxX1WdMKCjJO3bh9nsizr3RYqzvzYWUUfbO3YUJZO3HKC8sOLv+3ta/Yz8Be3Kd8q8R
	1vTqzpfJCSvPNRhJnv6dZ6cfSN9lv8PgmasmGnr3EnQMGZmgGvI2k0k4rSYuT1w2wEARg8
	UL2HkaYqR2ibinNXset3m/CFJ8DSBDC1uwYbbtgcglO44+BJH5H7gZoLHyYKG+8OaaQcmg
	m8Ecso1PeH/O1TIdcES3/AJKmRrL1NSKQiviAXErXRkiHQsOfnDMS1lGaUURk3Nu0n3EW0
	Hu8p39CW2AZme2N6OpZO+zkM0EQCh6Gk+WeIUpjVCm5vXeOiKYPT+4PrBHfYlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YbusUlI7ecs7aYF7W/prLkvtEjoYUbZ4FHRaSGRxAU=;
	b=NsXWY56C68AEly5CIeyRuOTRHzh4cOTTu44447ZtxKuXkfy06BxZqBLoxXlGN8I7Zc3wvU
	KhqnIqndTMuxYvCA==
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
Subject: [PATCH v2 16/29] x86/cacheinfo: Rename _cpuid4_info_regs to _cpuid4_info
Date: Mon, 17 Mar 2025 17:47:32 +0100
Message-ID: <20250317164745.4754-17-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
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
index 5d4ae5e048a0..ce00265233bc 100644
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
@@ -651,7 +651,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info *id4,
 			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
@@ -682,7 +682,7 @@ int init_cache_level(unsigned int cpu)
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
-static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
+static void get_cache_id(int cpu, struct _cpuid4_info *id4)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned long num_threads_sharing;
@@ -697,8 +697,8 @@ int populate_cache_leaves(unsigned int cpu)
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


