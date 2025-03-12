Return-Path: <linux-kernel+bounces-557904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D523A5DF33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6438167155
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A4258CD5;
	Wed, 12 Mar 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NO5NVGHi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5bMM7x3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66123A563
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790326; cv=none; b=nyn4RPXvn5JogVoTPfx79Qbcnzbwom9GmNDOnHH2Zy/vcNtbjldp7g4Aiu7JcTKbcp3ulRWtVYf4eHkyr0g6eCo2txeLFj1BN/LkeS25fQnkyqtGBp+RrTTNO/U9cSdYBt58qBMB0nq/d2/X/+cvOP96lsJaBvufLfJ2oM/Wre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790326; c=relaxed/simple;
	bh=Gtz9m6NcqXYjShb2QDYZo/kr0004SCXazlBWWkQiv9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9B57lK6uf0rRBpbHPQ8+ud0DbhwVYpd74PwH6vgSEJ4zP4MpxdSGDhmThq6M9WFXkNtO9kwtg08DgIij/frnWqHjBEIHlwZfhlZ/rk+tJTFzXQsvKSgXMFoTo60WsvnvXNUnOHko2uIehbpDklS8fusXFRQC2ZjFhY4ZDaqwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NO5NVGHi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5bMM7x3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPJKxtmg1G1j/NbUW2zI+jeu875d2C94o5k0++534hw=;
	b=NO5NVGHif28ATjp4IB9I4xoOBIu27iyR4WuKLVcqI6FGcsjMGzYJd2YYBBzmt8qxXhE6QS
	USPq8am9NaTbqoUWScuSZpUXaxfJvFxD+f8WTvxVKPmrhA2u2Iwlc/G5cyfce63S1oVOH8
	gFNyYJWhYbuYQdB71zAxa7ENfRUICpD/dJXEao+ehgQ29FJhiqx1Ymn+jx80ock14oRK/L
	061jllAfFEcJ5y4P6JKYluvj/YlHJYoeq6wKhG1tTd/R5Wd48rscE6HL+MKXhfKGn/30lb
	kWffVgm1OWbhTr9gd0mS3x5t32Dbp/gOdA/KqDzU0NAgNmbudBiF8A6iJ5rJjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPJKxtmg1G1j/NbUW2zI+jeu875d2C94o5k0++534hw=;
	b=W5bMM7x3QoUzYOj/DiqADXmJ/1z9gMHSumGq9M3qN7pgD4T1mWj6QqccEWB6ARqK7lIFhf
	G+lG5Xrk92JNx8DQ==
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
Subject: [PATCH v2 18/20] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.2
Date: Wed, 12 Mar 2025 15:37:35 +0100
Message-ID: <20250312143738.458507-19-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update kcpuid's CSV file to version 2.2, as generated by x86-cpuid-db.

Per Ingo Molnar's feedback, it is desired to always use CPUID in its
capitalized form.  The v2.2 release fixed all instances of small case
"cpuid" at the project's XML database, and thus all of its generated
files.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lkml.kernel.org/r/Z8bHK391zKE4gUEW@gmail.com
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.2/CHANGELOG.rst
---
 tools/arch/x86/kcpuid/cpuid.csv | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 0f9c11208674..9613e09cbfb3 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v2.1
+# Generator: x86-cpuid-db v2.2
 
 #
 # Auto-generated file.
@@ -12,7 +12,7 @@
 # Leaf 0H
 # Maximum standard leaf number + CPU vendor string
 
-       0x0,         0,  eax,    31:0,    max_std_leaf           , Highest cpuid standard leaf supported
+       0x0,         0,  eax,    31:0,    max_std_leaf           , Highest standard CPUID leaf supported
        0x0,         0,  ebx,    31:0,    cpu_vendorid_0         , CPU vendor ID string bytes 0 - 3
        0x0,         0,  ecx,    31:0,    cpu_vendorid_2         , CPU vendor ID string bytes 8 - 11
        0x0,         0,  edx,    31:0,    cpu_vendorid_1         , CPU vendor ID string bytes 4 - 7
@@ -193,7 +193,7 @@
 # Leaf 7H
 # Extended CPU features enumeration
 
-       0x7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of cpuid 0x7 subleaves
+       0x7,         0,  eax,    31:0,    leaf7_n_subleaves      , Number of leaf 0x7 subleaves
        0x7,         0,  ebx,       0,    fsgsbase               , FSBASE/GSBASE read/write support
        0x7,         0,  ebx,       1,    tsc_adjust             , IA32_TSC_ADJUST MSR supported
        0x7,         0,  ebx,       2,    sgx                    , Intel SGX (Software Guard Extensions)
@@ -281,7 +281,7 @@
        0x7,         1,  eax,       5,    avx512_bf16            , AVX-512 bfloat16 instructions
        0x7,         1,  eax,       6,    lass                   , Linear address space separation
        0x7,         1,  eax,       7,    cmpccxadd              , CMPccXADD instructions
-       0x7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: CPUID leaf 0x23 is supported
+       0x7,         1,  eax,       8,    arch_perfmon_ext       , ArchPerfmonExt: leaf 0x23 is supported
        0x7,         1,  eax,      10,    fzrm                   , Fast zero-length REP MOVSB
        0x7,         1,  eax,      11,    fsrs                   , Fast short REP STOSB
        0x7,         1,  eax,      12,    fsrc                   , Fast Short REP CMPSB/SCASB
@@ -319,7 +319,7 @@
        0xa,         0,  eax,     7:0,    pmu_version            , Performance monitoring unit version ID
        0xa,         0,  eax,    15:8,    pmu_n_gcounters        , Number of general PMU counters per logical CPU
        0xa,         0,  eax,   23:16,    pmu_gcounters_nbits    , Bitwidth of PMU general counters
-       0xa,         0,  eax,   31:24,    pmu_cpuid_ebx_bits     , Length of cpuid leaf 0xa EBX bit vector
+       0xa,         0,  eax,   31:24,    pmu_cpuid_ebx_bits     , Length of leaf 0xa EBX bit vector
        0xa,         0,  ebx,       0,    no_core_cycle_evt      , Core cycle event not available
        0xa,         0,  ebx,       1,    no_insn_retired_evt    , Instruction retired event not available
        0xa,         0,  ebx,       2,    no_refcycle_evt        , Reference cycles event not available
@@ -453,7 +453,7 @@
 # Leaf 14H
 # Intel Processor Trace enumeration
 
-      0x14,         0,  eax,    31:0,    pt_max_subleaf         , Max cpuid 0x14 subleaf
+      0x14,         0,  eax,    31:0,    pt_max_subleaf         , Maximum leaf 0x14 subleaf
       0x14,         0,  ebx,       0,    cr3_filtering          , IA32_RTIT_CR3_MATCH is accessible
       0x14,         0,  ebx,       1,    psb_cyc                , Configurable PSB and cycle-accurate mode
       0x14,         0,  ebx,       2,    ip_filtering           , IP/TraceStop filtering; Warm-reset PT MSRs preservation
@@ -490,7 +490,7 @@
 # Leaf 17H
 # Intel SoC vendor attributes enumeration
 
-      0x17,         0,  eax,    31:0,    soc_max_subleaf        , Max cpuid leaf 0x17 subleaf
+      0x17,         0,  eax,    31:0,    soc_max_subleaf        , Maximum leaf 0x17 subleaf
       0x17,         0,  ebx,    15:0,    soc_vendor_id          , SoC vendor ID
       0x17,         0,  ebx,      16,    is_vendor_scheme       , Assigned by industry enumeration scheme (not Intel)
       0x17,         0,  ecx,    31:0,    soc_proj_id            , SoC project ID, assigned by vendor
@@ -503,7 +503,7 @@
 # Leaf 18H
 # Intel determenestic address translation (TLB) parameters
 
-      0x18,      31:0,  eax,    31:0,    tlb_max_subleaf        , Max cpuid 0x18 subleaf
+      0x18,      31:0,  eax,    31:0,    tlb_max_subleaf        , Maximum leaf 0x18 subleaf
       0x18,      31:0,  ebx,       0,    tlb_4k_page            , TLB 4KB-page entries supported
       0x18,      31:0,  ebx,       1,    tlb_2m_page            , TLB 2MB-page entries supported
       0x18,      31:0,  ebx,       2,    tlb_4m_page            , TLB 4MB-page entries supported
@@ -634,7 +634,7 @@
 # Leaf 80000000H
 # Maximum extended leaf number + AMD/Transmeta CPU vendor string
 
-0x80000000,         0,  eax,    31:0,    max_ext_leaf           , Maximum extended cpuid leaf supported
+0x80000000,         0,  eax,    31:0,    max_ext_leaf           , Maximum extended CPUID leaf supported
 0x80000000,         0,  ebx,    31:0,    cpu_vendorid_0         , Vendor ID string bytes 0 - 3
 0x80000000,         0,  ecx,    31:0,    cpu_vendorid_2         , Vendor ID string bytes 8 - 11
 0x80000000,         0,  edx,    31:0,    cpu_vendorid_1         , Vendor ID string bytes 4 - 7
@@ -669,7 +669,7 @@
 0x80000001,         0,  ecx,      17,    tce                    , Translation cache extension
 0x80000001,         0,  ecx,      19,    nodeid_msr             , NodeId MSR (0xc001100c)
 0x80000001,         0,  ecx,      21,    tbm                    , Trailing bit manipulations
-0x80000001,         0,  ecx,      22,    topoext                , Topology Extensions (cpuid leaf 0x8000001d)
+0x80000001,         0,  ecx,      22,    topoext                , Topology Extensions (leaf 0x8000001d)
 0x80000001,         0,  ecx,      23,    perfctr_core           , Core performance counter extensions
 0x80000001,         0,  ecx,      24,    perfctr_nb             , NB/DF performance counter extensions
 0x80000001,         0,  ecx,      26,    bpext                  , Data access breakpoint extension
-- 
2.48.1


