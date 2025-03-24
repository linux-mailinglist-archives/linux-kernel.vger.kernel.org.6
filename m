Return-Path: <linux-kernel+bounces-573740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41881A6DBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAC16D2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C5126156F;
	Mon, 24 Mar 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tg+J52qO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8wGIEsM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116626156D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823248; cv=none; b=AkpHSw5YJvDVU+pvDup5HGJPiuZGeDJiP6ZP4H/m1zEX3DTdTI6iNiQ/hIpC4k1F/kmB7ZJO4eKjFIUKhynhFWKFMYMvvYnJGwnyiMwx5xGYZ3Nrmln8Qm0YLfES5lPlW9TJUPb5QGHlAlJuUzRENG+Scd2+7mJLCQMa9GkZtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823248; c=relaxed/simple;
	bh=AZlG9LYByybwrOEfCF+vQCcrCTZi+EZ50a8ylx8Z23g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGLfijlTD0qIa2d592racur2zILkuPQRrEHLQDj5utxGu+lKrvoT4SVx/3fTO38ejXXeRR3vvHBiQppt+V6a+N+vmCrIWSdRG6na/1Krh//MujbxVO89gstc8+4yFC8kiAJqTxGptYMkerSs+IYTyIbre4JZGL5IBOh6u+ZXXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tg+J52qO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8wGIEsM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y30/Lu67ZUIffp0uywi7TFTyLpyoX3QoyFYflTofPOI=;
	b=Tg+J52qOq8rxNmNy+3iXhagMEwdQCKqekxzsTxVnpRHHEmF5nHsbaWb+tX9OFxzNzYfsAW
	qIuTLgCWDHWyo/OzfTSSp3Iws7QCp9ve5qiCtar2W0jc6980eib9ySZc5iXpm6bavNPEtc
	n3RwrZmbcLW1DUYoqZnmjjxaPTO4JPKthx0qgzU4sEEZPKP4i94nunita/tKLztaNWU05c
	JgOIMj+FhXzBTiEgNK6Ds93zN5+q0tlq/cRTfkSBTslttGyC+OUDqB3KhIgP7Ugb+RbHzf
	9AUwDDfct7cO83R/584DBC9u28gW4LM6ERbHqOZ1csE92aD7S6T8iIFP1ry9LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y30/Lu67ZUIffp0uywi7TFTyLpyoX3QoyFYflTofPOI=;
	b=8wGIEsM0+QOO5sv6Y4/2FGnWL/nteP7d88zuFKD5VPKanNn4cw0+JP0F2sJCSukXegmY6l
	6fWdlRKlHyEaNYBQ==
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
Subject: [PATCH v4 11/29] x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
Date: Mon, 24 Mar 2025 14:33:06 +0100
Message-ID: <20250324133324.23458-12-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While gathering CPU cache info, CPUID leaf 0x8000001d is invoked in two
separate if blocks: one for Hygon CPUs and one for AMDs with topology
extensions.  After each invocation, amd_init_l3_cache() is called.

Merge the two if blocks into a single condition, thus removing the
duplicated code.  Future commits will expand these if blocks, so
combining them now is both cleaner and more maintainable.

Note, while at it, remove a useless "better error?" comment that was
within the same function since the 2005 commit e2cac78935ff ("[PATCH]
x86_64: When running cpuid4 need to run on the correct CPU").

Note, as previously done at commit aec28d852ed2 ("x86/cpuid: Standardize
on u32 in <asm/cpuid/api.h>"), standardize on using 'u32' and 'u8' types.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 1b2a2bf97d7f..f1055e806c9f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -593,28 +593,28 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *id4, int index)
 static int
 cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 {
-	union _cpuid4_leaf_eax	eax;
-	union _cpuid4_leaf_ebx	ebx;
-	union _cpuid4_leaf_ecx	ecx;
-	unsigned		edx;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
-			cpuid_count(0x8000001d, index, &eax.full,
-				    &ebx.full, &ecx.full, &edx);
-		else
+	u8 cpu_vendor = boot_cpu_data.x86_vendor;
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	u32 edx;
+
+	if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) {
+		if (boot_cpu_has(X86_FEATURE_TOPOEXT) || cpu_vendor == X86_VENDOR_HYGON) {
+			/* AMD with TOPOEXT, or HYGON */
+			cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &edx);
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


