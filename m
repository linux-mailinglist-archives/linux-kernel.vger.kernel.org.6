Return-Path: <linux-kernel+bounces-543564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF9A4D70F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E909B174F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F4200110;
	Tue,  4 Mar 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/gdyDWF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1j4DIei"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD61FFC7D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078399; cv=none; b=nkmW+eZ+iUCVbrl5mBUsUFigcs9ZCL0l/HX65bszHqnhXXKyTbHDMZRzr4pP9tT25DFLltekMFz0SOc4dAoEiD6syylhKpdHGym8xw5mJbb2GzQfOJbEeFfU4CJ0WsltNxJlBEtjNJZyNSqLBvpMWzVD7O3lxLNmH1rZjr/HVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078399; c=relaxed/simple;
	bh=DSPQqfoV/n6tHzAVZaK7QIZDoZqS2S2XEA1CHVRVB38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGdPGlzQM5bKfbbXkmXAMmwuwsCrk5bazKj5ipMxe27wm4kwQk5Lr4h4KPQM4T3iwfC1qYLupaX7TfzirByh4IOfVbERkxA7gceuuarCr3s1eVLHFtcuqKrOHMWzOIr0Gfi+Wr9BZE7RPCyRiu+4CuJys/IdkvnmEq1YPFPsleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/gdyDWF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1j4DIei; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCxUUPYdIi4eq4csvJ6zzf6QHEMekx2axM9W90pgfbE=;
	b=D/gdyDWFKuU+Jv6fljXzL40nf8l2AwStfhlDdKP8eTfyT8uRWnuLAT5qP5WSsSz9TECYl8
	8dRgcWLjMU/+yziQvt4SPS/hCyRqlHG1GPz9JV3lNQZUH5aFqD0COJGj+Q2Lkzkawm3KHH
	P/dFtPfotHYmqWk7RTAHnaKDwyyGHXeh6M+0YUzYGJmoMbGOyxMYqf4oaju1/ccYu2O1lM
	1xtkTGM2IkuzHKk2EqbbFnT9liNXsnIxR0m6B6JplNKEfh5VSSyXTzZU418AXSVUUUNziv
	0OjU9g9uceLOcg1KBm1HMavNUMW1ncwmlunexawraq1FBXi2O5IAriliiLgB+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCxUUPYdIi4eq4csvJ6zzf6QHEMekx2axM9W90pgfbE=;
	b=m1j4DIeiTMWMqhsN/ZBsxcBadr4kYWKBZLPkEoGDh8Nkv7QeanEm9sAc7XUe9rcAMPN5R4
	jjrtneQYLxD21CAA==
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
Subject: [PATCH v1 21/40] x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
Date: Tue,  4 Mar 2025 09:51:32 +0100
Message-ID: <20250304085152.51092-22-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While gathering CPU cache info, cpuid leaf 0x8000001d is invoked in two
separate if blocks: one for Hygon CPUs and one for AMDs with topology
extensions.  After each invocation, amd_init_l3_cache() is called.

Merge the two if blocks into a single condition, thus removing the
duplicated code.  Future commits will expand these if blocks, so
combining them now is both cleaner and more maintainable.

Note, while at it, remove a useless "better error?" comment that was
within the same function since the 2005 commit e2cac78935ff ("[PATCH]
x86_64: When running cpuid4 need to run on the correct CPU").

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 0024d126c385..6aeabbd94997 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -598,23 +598,24 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 	union _cpuid4_leaf_ecx	ecx;
 	unsigned		edx;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
+	if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor)) {
+		if (boot_cpu_has(X86_FEATURE_TOPOEXT) ||
+		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+			/* AMD with TOPOEXT, or HYGON */
 			cpuid_count(0x8000001d, index, &eax.full,
 				    &ebx.full, &ecx.full, &edx);
-		else
+		} else {
+			/* Legacy AMD fallback */
 			amd_cpuid4(index, &eax, &ebx, &ecx);
-		amd_init_l3_cache(id4, index);
-	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		cpuid_count(0x8000001d, index, &eax.full,
-			    &ebx.full, &ecx.full, &edx);
+		}
 		amd_init_l3_cache(id4, index);
 	} else {
+		/* Intel */
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
 	}
 
 	if (eax.split.type == CTYPE_NULL)
-		return -EIO; /* better error ? */
+		return -EIO;
 
 	id4->eax = eax;
 	id4->ebx = ebx;
-- 
2.48.1


