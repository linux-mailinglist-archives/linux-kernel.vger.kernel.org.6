Return-Path: <linux-kernel+bounces-567975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6877A68CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A2C8832F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0DE255E26;
	Wed, 19 Mar 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oCGQbpMc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZEvtxd/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1F2571CE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386920; cv=none; b=WXMgQ1HBabBWqCJCTp5w+tVfYzCcGgRPrVW6fX6Goejk1UTG72Nq13YKxLZFve4ZHf6max+z6E8sdlMJdnfMqOp2RzCrabenHi6sl5njq+NaM2qcuO4P8FiUecGs//3/HFDmqeNMzIKe+yjpn/iSTlncuaNYlo6iE2zbb4XNW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386920; c=relaxed/simple;
	bh=W3GXBnfLsCIM3g0I11/5obqb72B18v4dzsCQ6S4pDqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaV4FdQK9xpEAVAmqGh/Yq42HzU0oSHb8Jwj14EEB0vHhcYcIoU9tfklKNsG66ruFq31kxA8TN2XDvF52zzGkyQV50UenNcUUX+DdQ3s+Ds5Lq8ATqRAsLriYVeoZ5SsH1Fp0GarzaUftybXYYHPh7bjp6uNhRUmthDng70jdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oCGQbpMc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZEvtxd/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxA17mUjvVkz0uVhl5/KFi+0Clr/rkFfhSUGfgn+GZU=;
	b=oCGQbpMcA+8a27CBusw/StvJBHexY+IIloXJeZBGo+sZ9075uq+o1+EkYuZ8GDR87A16LM
	vL3KqpKg1BWXzli25IZmbzMnU/7G3LetnkqO2QHXtLwZyArxO1sOTkPo9EhQe4kCXuEq9K
	BLWpYXA8fcHFDvSZ5ZEbXODjo76nAVIy2yeyhrV0qPAPvA1Ew6X600UmAKBOyb0/ytZzez
	jFtvJ8PBGuPF2wFbPe98XWeu2IUf4U1BBLFMY/WOV/gQ7Mg1VA+nVmOFzi5g3j7XHDOGVH
	IF7WF5M2yugELUZeMC2Fwta++gj5l+1/hgekDf9/TqLhYj6vEppgxzVwASPyKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxA17mUjvVkz0uVhl5/KFi+0Clr/rkFfhSUGfgn+GZU=;
	b=uZEvtxd/Exqjh4iV0+AfkEJmiZbWzjvjfnvoBieM/O/Z7pVTTsHKuouLijoPzZxbvccFc1
	FXcTcKU28VpAF8AQ==
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
Subject: [PATCH v3 04/29] x86/cacheinfo: Use leaf 0x2 parsing helpers
Date: Wed, 19 Mar 2025 13:21:12 +0100
Message-ID: <20250319122137.4004-5-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parent commit introduced CPUID leaf 0x2 parsing helpers at
<asm/cpuid/leaf_0x2_api.h>.  The new API allows sharing leaf 0x2's output
validation and iteration logic across both intel.c and cacheinfo.c.

Convert cacheinfo.c to that new API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 36782fd017b3..6c610805e356 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <asm/amd_nb.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid.h>
 #include <asm/mtrr.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
@@ -783,29 +784,16 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		u32 regs[4];
-		u8 *desc = (u8 *)regs;
+		union leaf_0x2_regs regs;
+		u8 *desc;
 
-		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-		/* Intel CPUs must report an iteration count of 1 */
-		if (desc[0] != 0x01)
-			return;
-
-		/* If a register's bit 31 is set, it is an unknown format */
-		for (int i = 0; i < 4; i++) {
-			if (regs[i] & (1 << 31))
-				regs[i] = 0;
-		}
-
-		/* Skip the first byte as it is not a descriptor */
-		for (int i = 1; i < 16; i++) {
-			u8 des = desc[i];
+		cpuid_get_leaf_0x2_regs(&regs);
+		for_each_leaf_0x2_desc(regs, desc) {
 			u8 k = 0;
 
 			/* look up this descriptor in the table */
 			while (cache_table[k].descriptor != 0) {
-				if (cache_table[k].descriptor == des) {
+				if (cache_table[k].descriptor == *desc) {
 					switch (cache_table[k].cache_type) {
 					case LVL_1_INST:
 						l1i += cache_table[k].size;
-- 
2.48.1


