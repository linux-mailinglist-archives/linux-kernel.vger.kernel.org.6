Return-Path: <linux-kernel+bounces-543549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40734A4D700
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CEF174B16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582791FDE1A;
	Tue,  4 Mar 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vX3Qs06K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvSwHJ5+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE101FDE03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078354; cv=none; b=HDie/VVbQUJ7Gn5C7UREhlWoSzBNASaStSknA6D/N9TPcAzB+TBaOA3Ec16+PMGvuJ4CFHUaEYYkKfVfNhhb6aR7YUuLgZl+7z+GEyvm5QLrTGK4oNjPIv52BYS8+jADt5Kj9rVnJOxRFYuLHEX8OL/7TNRLGRA7r3IcJKL8qPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078354; c=relaxed/simple;
	bh=q5G/qiY7yo3xCX0EWSKwfQpg5lBB95uOvEaDNzMqeqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoUm0r83hQhuPIxiIVtSD37eXxwJeBJYG1M464d3uTpYOg11jd0kz+2Cn56aJJlCYFr+ImY2MyLGJw9MpQuxnsI3MdH4BjG62yd4z+pmmqaxaIq7tBHFUdnyjG5+9kJ51Lkkb1k4iWnVt0s3BMFjSdB4VUVnt3nmvN0x8ZDf/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vX3Qs06K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvSwHJ5+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRpaNf+WhdKXg5YRbfSJcTqZ3UgP8MUrCu753p8Ma1I=;
	b=vX3Qs06KMu5x0Ule9pw0kSq78wETl7wYXcOj2TaYb+e9IUtKzcwQtKEglruHDNuDY2undV
	dXJCZJCJRJsTZGwJcSdsUr+k57MrGasS/LT7rdIxIcdN/JZjuyvzuOw/6TMZofEi/jMDy5
	6MFmeFsnqBGcCIN6OzAVyQ/Xx4bBX69bAe4HdT2oQZoSPWiRmVhdB7+b/Fguu7/Hw02f/G
	aaZSPtSdSQriKBAPpSOiOb4nUgCUoKUrNvNqxmsWNgAPS8zR7BaQnfjSSU0+Z3HGAkTJCk
	H2INwtMulVSBWGMVrAyZ2sbNTcfZDSfdm5pTit/BHF4EQoUJaDzmO/NydP57yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRpaNf+WhdKXg5YRbfSJcTqZ3UgP8MUrCu753p8Ma1I=;
	b=ZvSwHJ5+SC64G2KffrOlTaoJSF0s9dX1dduLXYExJg1q52Rto/11/YSwFWvSz27Oe4z24X
	FVN203bErzZsbDDg==
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
Subject: [PATCH v1 06/40] x86/cpu: Use max() for leaf 0x2 TLB descriptors parsing
Date: Tue,  4 Mar 2025 09:51:17 +0100
Message-ID: <20250304085152.51092-7-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conditional statement "if (x < y) { x = y; }" appears 22 times at
the Intel leaf 0x2 descriptors parsing logic.

Replace each of such instances with a max() expression.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 76 ++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 72f519534e2b..e972c72e2b5d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -3,6 +3,7 @@
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/smp.h>
 #include <linux/string.h>
 
@@ -699,7 +700,9 @@ static const struct _tlb_table intel_tlb_table[] = {
 
 static void intel_tlb_lookup(const unsigned char desc)
 {
+	unsigned int entries;
 	unsigned char k;
+
 	if (desc == 0)
 		return;
 
@@ -711,81 +714,58 @@ static void intel_tlb_lookup(const unsigned char desc)
 	if (intel_tlb_table[k].tlb_type == 0)
 		return;
 
+	entries = intel_tlb_table[k].entries;
 	switch (intel_tlb_table[k].tlb_type) {
 	case STLB_4K:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
 		break;
 	case STLB_4K_2M:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
+		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_INST_ALL:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
 		break;
 	case TLB_INST_4K:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
 		break;
 	case TLB_INST_4M:
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
 		break;
 	case TLB_INST_2M_4M:
-		if (tlb_lli_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_4K:
 	case TLB_DATA0_4K:
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
 		break;
 	case TLB_DATA_4M:
 	case TLB_DATA0_4M:
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_2M_4M:
 	case TLB_DATA0_2M_4M:
-		if (tlb_lld_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_4K_4M:
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_1G_2M_4M:
-		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
-			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
-		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
-			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
 		fallthrough;
 	case TLB_DATA_1G:
-		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_1g[ENTRIES] = max(tlb_lld_1g[ENTRIES], entries);
 		break;
 	}
 }
-- 
2.48.1


