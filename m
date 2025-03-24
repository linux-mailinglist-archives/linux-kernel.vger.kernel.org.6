Return-Path: <linux-kernel+bounces-573730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55858A6DBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EED7A2328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719DC25F7B2;
	Mon, 24 Mar 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dg8XNY43";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f1iIIcel"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083425F78A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823217; cv=none; b=M3TEwQXWJcZLIeDmtNaMzdX4FLDFs7zl68gxkBzpiucB11Zw7KKG7yfSvgTxQ49heH+SxNF09Yj5VRJetrVDl957BTIU+XzIJ8sGGwBeLK5/JDw6PtQCaT8IzqWanXRPxecWGS3ckVv1Qtppm15O7E6C69RqXIrgKdBDXd9HV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823217; c=relaxed/simple;
	bh=tjwaLaLIE24h6R3231TizZjukZ/rW3xkDxKWRUfWlc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsxMcjzkPB66TsDc3kycFJQM5bj4j6B6dxmXKGVyrDNW95mUYYA5pkGvygutkbAXHEsSmIrbQqTDOSTSELREjFR910zXMZghJAzQ0fkvfkESpSxAF0vtd55b0J7yIIsClHZEMOPLIi36z2i3woiQJXgUBLG0g5TgS8hxD4eq0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dg8XNY43; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f1iIIcel; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6bUDRKa3h7q/AVQQzk6Gc5gVSuHQk5hT+ivElcSG98=;
	b=Dg8XNY435s7beh5NdLucLbBnVf0OwePM6RNTOwN5rdOFYlWvAK4dHnmS7eX5H+ZljKlGsL
	HohLZKR5IOrXc3WQJW7I+MKnlIzOP66q7hGSWLId2Y1J3flaoaMH7Fkb6QpK4K1j9TyT5Y
	wBq4tB8Hojg67NvbUlO6//bsnTXSs49ZrMDxai+G5u2UCn0UrJN7QDd/lQwbNMtB3DaX9Y
	GUTBL5SLqVCEa/57L5WMZouGr2hYsfHgC1LyKEGZfIGDJITJIZqtacocOqPiNClD98Ql4z
	RfpIQy7rPzmitfLt1pI9HfsalT3kTVXu4gwizPdldqEzDbRTlaCiR5b+zbIFXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6bUDRKa3h7q/AVQQzk6Gc5gVSuHQk5hT+ivElcSG98=;
	b=f1iIIcelJ6tzvzpMQHJM9JcXkvI4v0W8L0vlSEyF4Y2YsiyRV/WQW5hN/vLLsCpzqNfKPG
	ppS4V+gPXhEP1sDg==
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
Subject: [PATCH v4 01/29] x86/cpu: Remove leaf 0x2 parsing loop
Date: Mon, 24 Mar 2025 14:32:56 +0100
Message-ID: <20250324133324.23458-2-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leaf 0x2 output includes a "query count" byte where it was supposed to
specify the number of repeated CPUID leaf 0x2 subleaf 0 queries needed to
extract all of the CPU's cache and TLB descriptors.

Per current Intel manuals, all CPUs supporting this leaf "will always"
return an iteration count of 1.

Remove the leaf 0x2 query loop and just query the hardware once.

Note, as previously done at commit aec28d852ed2 ("x86/cpuid: Standardize
on u32 in <asm/cpuid/api.h>"), standardize on using 'u32' and 'u8' types.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4cbb2e69bea1..0570d4d86006 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -6,6 +6,7 @@
 #include <linux/minmax.h>
 #include <linux/smp.h>
 #include <linux/string.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -777,28 +778,27 @@ static void intel_tlb_lookup(const unsigned char desc)
 
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
-	int i, j, n;
-	unsigned int regs[4];
-	unsigned char *desc = (unsigned char *)regs;
+	u32 regs[4];
+	u8 *desc = (u8 *)regs;
 
 	if (c->cpuid_level < 2)
 		return;
 
-	/* Number of times to iterate */
-	n = cpuid_eax(2) & 0xFF;
+	cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
-	for (i = 0 ; i < n ; i++) {
-		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 4 ; j++)
-			if (regs[j] & (1 << 31))
-				regs[j] = 0;
+	/* Intel CPUs must report an iteration count of 1 */
+	if (desc[0] != 0x01)
+		return;
 
-		/* Byte 0 is level count, not a descriptor */
-		for (j = 1 ; j < 16 ; j++)
-			intel_tlb_lookup(desc[j]);
+	/* If a register's bit 31 is set, it is an unknown format */
+	for (int i = 0; i < 4; i++) {
+		if (regs[i] & (1 << 31))
+			regs[i] = 0;
 	}
+
+	/* Skip the first byte as it is not a descriptor */
+	for (int i = 1; i < 16; i++)
+		intel_tlb_lookup(desc[i]);
 }
 
 static const struct cpu_dev intel_cpu_dev = {
-- 
2.48.1


