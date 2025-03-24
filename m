Return-Path: <linux-kernel+bounces-573829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDEA6DCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4471716A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C988263C88;
	Mon, 24 Mar 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+L32Pq0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8Y0QgrP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5B263C6F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826109; cv=none; b=XlPAX5KonoZpAdmvG1jYoI849SD02KCPO+YPKrt3m3GSa5c/XiXPY58bXEaeF1G0qIrYrJaC+dqm58mpk07qiRcMI16MguS+T2HGoLjFhYMOBt4X8B8+6PDarvLb6vty/ObFaEE3IQLmiw99hyTqoc52wW0RzfgQ0tybFOLRQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826109; c=relaxed/simple;
	bh=DdrgOC/ggKpvFTOf3woucjPhC1Yx7eqWnxWMyK4nTHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzXBv52KXDknW5EoZmTtg4H2AN4OYhb8jYq+2ZKTCf9FY50dKQxcuWpU2MX5M58XIktt9mGF9d/VT2ZxpyYfFuJKozNiLYy0BN//x8l4Hy8CbT88F1HS4y/yHhX7iAA+SsomrLnPYXwyfGqs8xfC7CNwdVRYIr2IlUJ5SvD6BR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+L32Pq0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8Y0QgrP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1U4m9SNGi3KlloknfPR199afz7Ixt0noMcHP+/8Ra5Y=;
	b=L+L32Pq0yW+qQDzGpoxf7h2DBKfGf/WT15mApNO2O2rfbMIcnR3f1quuikUoNQF8IaVNH2
	1+OMboPiN/tWQJPOk0q4b90cIx2+kHiu56YWYL7+14sK4ZB2oJygCn7uaUNem63I1Rk6jU
	GdHXaXL9D+0bEJ+wpw2xI/4pLcFrayKLjkdMg51JRIr7G6/LxcRtRsaPq2oNgLnn8tnwuc
	Csxt2KD0GAOw3Qqi8klrg8gCLz4CNBLD3MXGPo8wibE4c/vSpTjLq8YJujdD4aXOkGdU08
	qz9izkjRR55M2iI0IagJFAu+Sy81MahM8wJTKRZUaWL1Tvmbde3xV2tdhfMD/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1U4m9SNGi3KlloknfPR199afz7Ixt0noMcHP+/8Ra5Y=;
	b=h8Y0QgrPZ5nHbA3YcAZHts7DwdL4VGFKQ+7Uaun9il9n6z8r6BgjRxB6mO5TSJ1akWnSki
	g3COwNDCQHmYZvBA==
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
Subject: [PATCH v3 19/20] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.3
Date: Mon, 24 Mar 2025 15:20:40 +0100
Message-ID: <20250324142042.29010-20-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update kcpuid's CSV file to version 2.3, as generated by x86-cpuid-db.

Summary of the v2.3 changes:

* Per H. Peter Anvin's feedback, leaf 0x3 is not unique to Transmeta as
  the CSV file earlier claimed.  Since leaf 0x3's format differs between
  Intel and Transmeta, and the project does not yet support having the
  same CPUID bitfield with varying interpretations across vendors, leaf
  0x3 is removed for now.  Given that Intel discontinued support for PSN
  from Pentium 4 onward, and Linux force disables it on early boot for
  privacy concerns, this should have minimal impact.

* Leaf 0x80000021: Make bitfield IDs and descriptions coherent with each
  other.  Remove "_support" from bitfield IDs, as no other leaf has such
  convention.

Reported-by: "H. Peter Anvin" <hpa@zytor.com>
Closes: https://lkml.kernel.org/r/C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/blob/v2.3/CHANGELOG.rst
---
 tools/arch/x86/kcpuid/cpuid.csv | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 9613e09cbfb3..8d25b0b49f3b 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: CC0-1.0
-# Generator: x86-cpuid-db v2.2
+# Generator: x86-cpuid-db v2.3
 
 #
 # Auto-generated file.
@@ -116,14 +116,6 @@
        0x2,         0,  edx,   30:24,    desc15                 , Descriptor #15
        0x2,         0,  edx,      31,    edx_invalid            , Descriptors 12-15 are invalid if set
 
-# Leaf 3H
-# Transmeta Processor Serial Number (PSN)
-
-       0x3,         0,  eax,    31:0,    cpu_psn_0              , Processor Serial Number bytes 0 - 3
-       0x3,         0,  ebx,    31:0,    cpu_psn_1              , Processor Serial Number bytes 4 - 7
-       0x3,         0,  ecx,    31:0,    cpu_psn_2              , Processor Serial Number bytes 8 - 11
-       0x3,         0,  edx,    31:0,    cpu_psn_3              , Processor Serial Number bytes 12 - 15
-
 # Leaf 4H
 # Intel deterministic cache parameters
 
@@ -1020,20 +1012,20 @@
 0x80000021,         0,  eax,       0,    no_nested_data_bp      , No nested data breakpoints
 0x80000021,         0,  eax,       1,    fsgs_non_serializing   , WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing
 0x80000021,         0,  eax,       2,    lfence_rdtsc           , LFENCE always serializing / synchronizes RDTSC
-0x80000021,         0,  eax,       3,    smm_page_cfg_lock      , SMM paging configuration lock is supported
+0x80000021,         0,  eax,       3,    smm_page_cfg_lock      , SMM paging configuration lock
 0x80000021,         0,  eax,       6,    null_sel_clr_base      , Null selector clears base
-0x80000021,         0,  eax,       7,    upper_addr_ignore      , EFER MSR Upper Address Ignore Enable bit supported
-0x80000021,         0,  eax,       8,    autoibrs               , EFER MSR Automatic IBRS enable bit supported
-0x80000021,         0,  eax,       9,    no_smm_ctl_msr         , SMM_CTL MSR (0xc0010116) is not present
-0x80000021,         0,  eax,      10,    fsrs_supported         , Fast Short Rep STOSB (FSRS) is supported
-0x80000021,         0,  eax,      11,    fsrc_supported         , Fast Short Rep CMPSB (FSRC) is supported
-0x80000021,         0,  eax,      13,    prefetch_ctl_msr       , Prefetch control MSR is supported
+0x80000021,         0,  eax,       7,    upper_addr_ignore      , EFER MSR Upper Address Ignore
+0x80000021,         0,  eax,       8,    autoibrs               , EFER MSR Automatic IBRS
+0x80000021,         0,  eax,       9,    no_smm_ctl_msr         , SMM_CTL MSR (0xc0010116) is not available
+0x80000021,         0,  eax,      10,    fsrs                   , Fast Short Rep STOSB
+0x80000021,         0,  eax,      11,    fsrc                   , Fast Short Rep CMPSB
+0x80000021,         0,  eax,      13,    prefetch_ctl_msr       , Prefetch control MSR is available
 0x80000021,         0,  eax,      16,    opcode_reclaim         , Reserves opcode space
 0x80000021,         0,  eax,      17,    user_cpuid_disable     , #GP when executing CPUID at CPL > 0 is supported
-0x80000021,         0,  eax,      18,    epsf_supported         , Enhanced Predictive Store Forwarding (EPSF) is supported
+0x80000021,         0,  eax,      18,    epsf                   , Enhanced Predictive Store Forwarding
 0x80000021,         0,  eax,      22,    wl_feedback            , Workload-based heuristic feedback to OS
-0x80000021,         0,  eax,      24,    eraps_support          , Enhanced Return Address Predictor Security
-0x80000021,         0,  eax,      27,    sbpb                   , Support for the Selective Branch Predictor Barrier
+0x80000021,         0,  eax,      24,    eraps                  , Enhanced Return Address Predictor Security
+0x80000021,         0,  eax,      27,    sbpb                   , Selective Branch Predictor Barrier
 0x80000021,         0,  eax,      28,    ibpb_brtype            , Branch predictions flushed from CPU branch predictor
 0x80000021,         0,  eax,      29,    srso_no                , CPU is not subject to the SRSO vulnerability
 0x80000021,         0,  eax,      30,    srso_uk_no             , CPU is not vulnerable to SRSO at user-kernel boundary
-- 
2.48.1


