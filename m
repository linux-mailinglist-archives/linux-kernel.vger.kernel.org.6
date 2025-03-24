Return-Path: <linux-kernel+bounces-573731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E10A6DBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59884188D239
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE725F973;
	Mon, 24 Mar 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UaahKskW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LLIBhuhE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738725F7BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823220; cv=none; b=BbOKQTyn2EAcx1cpDp0YVMobLo680TTxMt402AcSXlgFL8MK8UtIUP23G13wSuEgiBgEN40fyWTm1wlPTCPUqGBzCjK1po1ayht3m9L+wP2rk4nb3wpKED7Y2pnr1qpfRkTj9Ed3f4U2HS8TKPZnIzFPM+nZdG0r3rtLEs+AvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823220; c=relaxed/simple;
	bh=nU4OSc713+t3FWKAhY+Xi2Wo/7zTOFNOruBVPTD2Wi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFNVXazy9yt0hvOc5GBP1hs4tCnAH9MP6aWl+ZmBO456519WU9BM7ddcocoY/EU/mf30FgQl60MBrHvxmzi7o+oOidwPjfperiuKgbh7BxTWU/w+K34jGl5BYcRXcn1L99mrUge+wm/aw7KtkQyIJBSsPNsu3dajtigmdXqVnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UaahKskW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LLIBhuhE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOEE5Ws6vnNWGAOctr95ZFkXsWR7b1uBZjnhDXrVsZY=;
	b=UaahKskWhE31C/T/VyNHhC3t8Iln3bT0Wqu060yOfECvf3F5LsHnWzUiG/wzHgXDxZR9mN
	MynKgg4nZ3rRrRDo3iKlCVZQxN87cIliY3h/oVZlB4w+mLvzidTUnIgcBjIZbiAK4zZyUa
	tpCLPNo9IpsmaX3MVwcNy7gtaIfXo+LWOCiiJb3aJ9MOj8VBNjkIL3UUKx6ia15dML4soS
	qEeMq5Bd1RyTZc7N8jsu4y7SrHYjcxGT2h5H/W1vZcV/jR8s4hdMBNuaLozDHG6cSUd8JQ
	mnGiI5OB1iYPhrVmcM4gIADRNOvYByl/yjxn7umBn8ybYdthYl/TasibuAM4FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOEE5Ws6vnNWGAOctr95ZFkXsWR7b1uBZjnhDXrVsZY=;
	b=LLIBhuhESHMWmj3ypme6I/Wqh3Fwv02eMZHXGARUO/7tnV2ekR8JtCInw1K52fLaA7Svbo
	tQRLDtC8jYoQr5Aw==
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
Subject: [PATCH v4 02/29] x86/cacheinfo: Remove leaf 0x2 parsing loop
Date: Mon, 24 Mar 2025 14:32:57 +0100
Message-ID: <20250324133324.23458-3-darwi@linutronix.de>
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
 arch/x86/kernel/cpu/cacheinfo.c | 77 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b3a520959b51..36782fd017b3 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -42,7 +42,7 @@ static cpumask_var_t cpu_cacheinfo_mask;
 unsigned int memory_caching_control __ro_after_init;
 
 struct _cache_table {
-	unsigned char descriptor;
+	u8 descriptor;
 	char cache_type;
 	short size;
 };
@@ -783,50 +783,47 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		/* supports eax=2  call */
-		int j, n;
-		unsigned int regs[4];
-		unsigned char *dp = (unsigned char *)regs;
-
-		/* Number of times to iterate */
-		n = cpuid_eax(2) & 0xFF;
-
-		for (i = 0 ; i < n ; i++) {
-			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 4 ; j++)
-				if (regs[j] & (1 << 31))
-					regs[j] = 0;
-
-			/* Byte 0 is level count, not a descriptor */
-			for (j = 1 ; j < 16 ; j++) {
-				unsigned char des = dp[j];
-				unsigned char k = 0;
-
-				/* look up this descriptor in the table */
-				while (cache_table[k].descriptor != 0) {
-					if (cache_table[k].descriptor == des) {
-						switch (cache_table[k].cache_type) {
-						case LVL_1_INST:
-							l1i += cache_table[k].size;
-							break;
-						case LVL_1_DATA:
-							l1d += cache_table[k].size;
-							break;
-						case LVL_2:
-							l2 += cache_table[k].size;
-							break;
-						case LVL_3:
-							l3 += cache_table[k].size;
-							break;
-						}
+		u32 regs[4];
+		u8 *desc = (u8 *)regs;
 
+		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
+
+		/* Intel CPUs must report an iteration count of 1 */
+		if (desc[0] != 0x01)
+			return;
+
+		/* If a register's bit 31 is set, it is an unknown format */
+		for (int i = 0; i < 4; i++) {
+			if (regs[i] & (1 << 31))
+				regs[i] = 0;
+		}
+
+		/* Skip the first byte as it is not a descriptor */
+		for (int i = 1; i < 16; i++) {
+			u8 des = desc[i];
+			u8 k = 0;
+
+			/* look up this descriptor in the table */
+			while (cache_table[k].descriptor != 0) {
+				if (cache_table[k].descriptor == des) {
+					switch (cache_table[k].cache_type) {
+					case LVL_1_INST:
+						l1i += cache_table[k].size;
+						break;
+					case LVL_1_DATA:
+						l1d += cache_table[k].size;
+						break;
+					case LVL_2:
+						l2 += cache_table[k].size;
+						break;
+					case LVL_3:
+						l3 += cache_table[k].size;
 						break;
 					}
 
-					k++;
+					break;
 				}
+				k++;
 			}
 		}
 	}
-- 
2.48.1


