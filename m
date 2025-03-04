Return-Path: <linux-kernel+bounces-543556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241ADA4D708
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4115F174E07
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB81FECDF;
	Tue,  4 Mar 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6wIki+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTXMQpbj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43F1FCF45
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078375; cv=none; b=dBpu8swg4xkhrRwq537+wHuKZARdZ4wxp97kG/+3LBQb2MZnWfmeva5ng07j0nQmqNuyIAKtjJ0FZzIr8xHTwdU81Cj9Cp79qHBxjw10z9E9sa61MXt5UQDWEcx66T+2nrIlgTVVmEZqEJOUpRLKbSkJ3GBjuWdPMchtHnBEIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078375; c=relaxed/simple;
	bh=P7qlq6ZvwZDsjPBTexjUFuLSgzMlMlKKacbkQDaQfEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge2i2xvBxKx+5NkKXhZ5LDz0oPsC7O8IX8hGQ2HxjzslnMd8p7+blvCBDjbr3irqm2NaEQm5/dJmv8XTq3+lfWgebZdKeX5fZoZOPCevOVzDPZKJ9/QrYHqPNAK0cZWM2N6uEBTGO+JVTte5hd8FJeIYAagugapzf3JX04w2sDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o6wIki+A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTXMQpbj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec7bhkZNZivmIllIc/9fS7tooTG3RoeriGRfob1Am3g=;
	b=o6wIki+A/58P5BL6w7/cmGJ/1iUpMKgi6YbnvfhRYcY5Y2sJvL+tD3yzwy5zV4+X2sF/oM
	m/TRZ1IgijZRM0h06jcjOWnHrFLTb+tbVAb99gHBXWvf5qSLCE55wo6udRzcCea5ic1JlT
	SNgjIfpg2hO9UDSpp9lMvNelhnFfaz44yQu6+FDuvbYRCm3Brg0JXI5Sm3Kk5NaLLXufjJ
	ioKEMCmmBxqi2Ae2MsiHX5JwLL+PsbmLgMCzCIjgudp0IIHY72Ohg8scLathf2oyFuVsbP
	/bsbJKvx1G5MdCLvwUjdllVBnND2JaYsK1FmKrXJloGiE83zpqeMShyUZrebLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec7bhkZNZivmIllIc/9fS7tooTG3RoeriGRfob1Am3g=;
	b=zTXMQpbjJYiDL9SUwOo7IwX3r2wbqva+BDK8b2RB++dAmrsORSsObXt/XcC9Z9I52+cmUG
	surjLxPddcBrvUBA==
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
Subject: [PATCH v1 13/40] x86/cacheinfo: Use cpuid leaf 0x2 parsing helpers
Date: Tue,  4 Mar 2025 09:51:24 +0100
Message-ID: <20250304085152.51092-14-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the cpuid leaf 0x2 parsing helpers added in previous commits, which
queries the cpuid leaf just once.

Note, this also makes the leaf 0x2 parsing logic be shared with x86/cpu
intel.c

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 66 +++++++++++++--------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b3a520959b51..ebd72016e7a2 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <asm/amd_nb.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid/types.h>
 #include <asm/mtrr.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
@@ -783,50 +784,35 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
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
-
+		union leaf_0x2_regs regs;
+		u8 *desc;
+
+		get_leaf_0x2_regs(&regs);
+		for_each_leaf_0x2_desc(regs, desc) {
+			unsigned char k = 0;
+
+			/* look up this descriptor in the table */
+			while (cache_table[k].descriptor != 0) {
+				if (cache_table[k].descriptor == *desc) {
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
+
+					k++;
 			}
 		}
 	}
-- 
2.48.1


