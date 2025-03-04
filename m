Return-Path: <linux-kernel+bounces-543571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B4A4D719
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10357A391E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E620298C;
	Tue,  4 Mar 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMH/AlDY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6vqJRVD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575B202974
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078418; cv=none; b=d06Fw0UYNWuAHbuebzu+36C+2ntuJRwDmlIEFU1TmsztZ9CvGXXpueY+F8c8f1eo1G3HZH98rRs2dKkEojl7yghuAEbeeglWqcBz1ookSw4Tuu8IclYwbI0koMC3cYwY7DpLr5np2C9MJoTYVq8uP7IHsoDsBSk0k1IccngO5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078418; c=relaxed/simple;
	bh=Xf6TMQaIsyJCUu2qh2Sto6zALHdaoZ30+dLgDhZ0Q/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ambGhpwC2lkLcOFl7gtS9Nj68e9Dm8FUrLW8wT05c2BXimd73yHuiMNArhmSiZOkyNX/wJt3XYPgATnEw1Sp9h1uk0olmdV+LEI62Laj4bV5Zt8429XOzRcnPnkhGgsceFAyRvfY+FHP0e6fFNb//Vyyc6ej56FdvawNBNWs/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMH/AlDY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6vqJRVD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyVJW/uhOsel/N7suYlz5Goimcr1uKn+zKWoOmAy3e0=;
	b=dMH/AlDYkIoauy1pKXP7R0bTrEzZwjK/cbGyAVEc0LjKH9GXape/c8Pw3ANohlnJuRxZPy
	xnHDIYn6B4AYU3VE99Y+DQ8FIKaH0ou2Qw+x/UokjDnCPYZwVnNJl+Jk/oc4M2B3usHeVa
	2VCdp7eX6COZXe32GAFI2ldHEeV1XdV4XHFbL6vBI/m8pMUY32KQx36vsv2AIsgBmZ5jwk
	r5HkaW3T/TXKZnJQ5Qh9odhIL6gXxCDnbkznd9CAEgkvilPrmmahuBbGFI0cG615z8uiUv
	O6aMM89j+xoA2K8EROniUxnD9k5CK/ZJcKlIi6D1y6v79rZ8jyuGJ84uv40zhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyVJW/uhOsel/N7suYlz5Goimcr1uKn+zKWoOmAy3e0=;
	b=O6vqJRVDPFxwR09Le1eQFicXsbeG3wA0ORX0hRoh14eLZAeVDEykPOoibQEQvNir/6FYAy
	90d3jGBmKMgxcvBA==
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
Subject: [PATCH v1 27/40] x86/cacheinfo: Clarify type markers for leaf 0x2 cache descriptors
Date: Tue,  4 Mar 2025 09:51:38 +0100
Message-ID: <20250304085152.51092-28-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid leaf 0x2 output is a stream of one-byte descriptors, each implying
certain details about the CPU's cache and TLB entries.

Two separate tables exist for interpreting these descriptors: one for
TLBs at intel.c and one for caches at cacheinfo.c.  These mapping tables
will be merged in further commits, among other improvements to their
model.

In preparation for this, use more descriptive type names for the leaf
0x2 descriptors associated with cpu caches.  Namely:

	LVL_1_INST	=>	CACHE_L1_INST
	LVL_1_DATA	=>	CACHE_L1_DATA
	LVL_2		=>	CACHE_L2
	LVL_3		=>	CACHE_L3

After the TLB and cache descriptors mapping tables are merged, this will
make it clear that such descriptors correspond to cpu caches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 152 ++++++++++++++++----------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 2d4180b961f4..9e87321466fe 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -23,10 +23,10 @@
 
 #include "cpu.h"
 
-#define LVL_1_INST	1
-#define LVL_1_DATA	2
-#define LVL_2		3
-#define LVL_3		4
+#define CACHE_L1_INST	1
+#define CACHE_L1_DATA	2
+#define CACHE_L2	3
+#define CACHE_L3	4
 
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
@@ -52,74 +52,74 @@ struct _cache_table {
 
 static const struct _cache_table cache_table[] =
 {
-	{ 0x06, LVL_1_INST, 8 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x08, LVL_1_INST, 16 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x09, LVL_1_INST, 32 },	/* 4-way set assoc, 64 byte line size */
-	{ 0x0a, LVL_1_DATA, 8 },	/* 2 way set assoc, 32 byte line size */
-	{ 0x0c, LVL_1_DATA, 16 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x0d, LVL_1_DATA, 16 },	/* 4-way set assoc, 64 byte line size */
-	{ 0x0e, LVL_1_DATA, 24 },	/* 6-way set assoc, 64 byte line size */
-	{ 0x21, LVL_2,      256 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x22, LVL_3,      512 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x23, LVL_3,      MB(1) },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x25, LVL_3,      MB(2) },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x29, LVL_3,      MB(4) },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x2c, LVL_1_DATA, 32 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x30, LVL_1_INST, 32 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x39, LVL_2,      128 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3a, LVL_2,      192 },	/* 6-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3b, LVL_2,      128 },	/* 2-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3c, LVL_2,      256 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3d, LVL_2,      384 },	/* 6-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3e, LVL_2,      512 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x3f, LVL_2,      256 },	/* 2-way set assoc, 64 byte line size */
-	{ 0x41, LVL_2,      128 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x42, LVL_2,      256 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x43, LVL_2,      512 },	/* 4-way set assoc, 32 byte line size */
-	{ 0x44, LVL_2,      MB(1) },	/* 4-way set assoc, 32 byte line size */
-	{ 0x45, LVL_2,      MB(2) },	/* 4-way set assoc, 32 byte line size */
-	{ 0x46, LVL_3,      MB(4) },	/* 4-way set assoc, 64 byte line size */
-	{ 0x47, LVL_3,      MB(8) },	/* 8-way set assoc, 64 byte line size */
-	{ 0x48, LVL_2,      MB(3) },	/* 12-way set assoc, 64 byte line size */
-	{ 0x49, LVL_3,      MB(4) },	/* 16-way set assoc, 64 byte line size */
-	{ 0x4a, LVL_3,      MB(6) },	/* 12-way set assoc, 64 byte line size */
-	{ 0x4b, LVL_3,      MB(8) },	/* 16-way set assoc, 64 byte line size */
-	{ 0x4c, LVL_3,      MB(12) },	/* 12-way set assoc, 64 byte line size */
-	{ 0x4d, LVL_3,      MB(16) },	/* 16-way set assoc, 64 byte line size */
-	{ 0x4e, LVL_2,      MB(6) },	/* 24-way set assoc, 64 byte line size */
-	{ 0x60, LVL_1_DATA, 16 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x66, LVL_1_DATA, 8 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x67, LVL_1_DATA, 16 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x68, LVL_1_DATA, 32 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x78, LVL_2,      MB(1) },	/* 4-way set assoc, 64 byte line size */
-	{ 0x79, LVL_2,      128 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7a, LVL_2,      256 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7b, LVL_2,      512 },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7c, LVL_2,      MB(1) },	/* 8-way set assoc, sectored cache, 64 byte line size */
-	{ 0x7d, LVL_2,      MB(2) },	/* 8-way set assoc, 64 byte line size */
-	{ 0x7f, LVL_2,      512 },	/* 2-way set assoc, 64 byte line size */
-	{ 0x80, LVL_2,      512 },	/* 8-way set assoc, 64 byte line size */
-	{ 0x82, LVL_2,      256 },	/* 8-way set assoc, 32 byte line size */
-	{ 0x83, LVL_2,      512 },	/* 8-way set assoc, 32 byte line size */
-	{ 0x84, LVL_2,      MB(1) },	/* 8-way set assoc, 32 byte line size */
-	{ 0x85, LVL_2,      MB(2) },	/* 8-way set assoc, 32 byte line size */
-	{ 0x86, LVL_2,      512 },	/* 4-way set assoc, 64 byte line size */
-	{ 0x87, LVL_2,      MB(1) },	/* 8-way set assoc, 64 byte line size */
-	{ 0xd0, LVL_3,      512 },	/* 4-way set assoc, 64 byte line size */
-	{ 0xd1, LVL_3,      MB(1) },	/* 4-way set assoc, 64 byte line size */
-	{ 0xd2, LVL_3,      MB(2) },	/* 4-way set assoc, 64 byte line size */
-	{ 0xd6, LVL_3,      MB(1) },	/* 8-way set assoc, 64 byte line size */
-	{ 0xd7, LVL_3,      MB(2) },	/* 8-way set assoc, 64 byte line size */
-	{ 0xd8, LVL_3,      MB(4) },	/* 12-way set assoc, 64 byte line size */
-	{ 0xdc, LVL_3,      MB(2) },	/* 12-way set assoc, 64 byte line size */
-	{ 0xdd, LVL_3,      MB(4) },	/* 12-way set assoc, 64 byte line size */
-	{ 0xde, LVL_3,      MB(8) },	/* 12-way set assoc, 64 byte line size */
-	{ 0xe2, LVL_3,      MB(2) },	/* 16-way set assoc, 64 byte line size */
-	{ 0xe3, LVL_3,      MB(4) },	/* 16-way set assoc, 64 byte line size */
-	{ 0xe4, LVL_3,      MB(8) },	/* 16-way set assoc, 64 byte line size */
-	{ 0xea, LVL_3,      MB(12) },	/* 24-way set assoc, 64 byte line size */
-	{ 0xeb, LVL_3,      MB(18) },	/* 24-way set assoc, 64 byte line size */
-	{ 0xec, LVL_3,      MB(24) },	/* 24-way set assoc, 64 byte line size */
+	{ 0x06, CACHE_L1_INST,	8	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x08, CACHE_L1_INST,	16	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x09, CACHE_L1_INST,	32	},	/* 4-way set assoc, 64 byte line size */
+	{ 0x0a, CACHE_L1_DATA,	8	},	/* 2 way set assoc, 32 byte line size */
+	{ 0x0c, CACHE_L1_DATA,	16	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x0d, CACHE_L1_DATA,	16	},	/* 4-way set assoc, 64 byte line size */
+	{ 0x0e, CACHE_L1_DATA,	24	},	/* 6-way set assoc, 64 byte line size */
+	{ 0x21, CACHE_L2,	256	},	/* 8-way set assoc, 64 byte line size */
+	{ 0x22, CACHE_L3,	512	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x23, CACHE_L3,	MB(1)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x25, CACHE_L3,	MB(2)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x29, CACHE_L3,	MB(4)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x2c, CACHE_L1_DATA,	32	},	/* 8-way set assoc, 64 byte line size */
+	{ 0x30, CACHE_L1_INST,	32	},	/* 8-way set assoc, 64 byte line size */
+	{ 0x39, CACHE_L2,	128	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3a, CACHE_L2,	192	},	/* 6-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3b, CACHE_L2,	128	},	/* 2-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3c, CACHE_L2,	256	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3d, CACHE_L2,	384	},	/* 6-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3e, CACHE_L2,	512	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x3f, CACHE_L2,	256	},	/* 2-way set assoc, 64 byte line size */
+	{ 0x41, CACHE_L2,	128	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x42, CACHE_L2,	256	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x43, CACHE_L2,	512	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x44, CACHE_L2,	MB(1)	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x45, CACHE_L2,	MB(2)	},	/* 4-way set assoc, 32 byte line size */
+	{ 0x46, CACHE_L3,	MB(4)	},	/* 4-way set assoc, 64 byte line size */
+	{ 0x47, CACHE_L3,	MB(8)	},	/* 8-way set assoc, 64 byte line size */
+	{ 0x48, CACHE_L2,	MB(3)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0x49, CACHE_L3,	MB(4)	},	/* 16-way set assoc, 64 byte line size */
+	{ 0x4a, CACHE_L3,	MB(6)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0x4b, CACHE_L3,	MB(8)	},	/* 16-way set assoc, 64 byte line size */
+	{ 0x4c, CACHE_L3,	MB(12)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0x4d, CACHE_L3,	MB(16)	},	/* 16-way set assoc, 64 byte line size */
+	{ 0x4e, CACHE_L2,	MB(6)	},	/* 24-way set assoc, 64 byte line size */
+	{ 0x60, CACHE_L1_DATA,	16	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x66, CACHE_L1_DATA,	8	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x67, CACHE_L1_DATA,	16	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x68, CACHE_L1_DATA,	32	},	/* 4-way set assoc, sectored cache, 64 byte line size */
+	{ 0x78, CACHE_L2,	MB(1)	},	/* 4-way set assoc, 64 byte line size */
+	{ 0x79, CACHE_L2,	128	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7a, CACHE_L2,	256	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7b, CACHE_L2,	512	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7c, CACHE_L2,	MB(1)	},	/* 8-way set assoc, sectored cache, 64 byte line size */
+	{ 0x7d, CACHE_L2,	MB(2)	},	/* 8-way set assoc, 64 byte line size */
+	{ 0x7f, CACHE_L2,	512	},	/* 2-way set assoc, 64 byte line size */
+	{ 0x80, CACHE_L2,	512	},	/* 8-way set assoc, 64 byte line size */
+	{ 0x82, CACHE_L2,	256	},	/* 8-way set assoc, 32 byte line size */
+	{ 0x83, CACHE_L2,	512	},	/* 8-way set assoc, 32 byte line size */
+	{ 0x84, CACHE_L2,	MB(1)	},	/* 8-way set assoc, 32 byte line size */
+	{ 0x85, CACHE_L2,	MB(2)	},	/* 8-way set assoc, 32 byte line size */
+	{ 0x86, CACHE_L2,	512	},	/* 4-way set assoc, 64 byte line size */
+	{ 0x87, CACHE_L2,	MB(1)	},	/* 8-way set assoc, 64 byte line size */
+	{ 0xd0, CACHE_L3,	512	},	/* 4-way set assoc, 64 byte line size */
+	{ 0xd1, CACHE_L3,	MB(1)	},	/* 4-way set assoc, 64 byte line size */
+	{ 0xd2, CACHE_L3,	MB(2)	},	/* 4-way set assoc, 64 byte line size */
+	{ 0xd6, CACHE_L3,	MB(1)	},	/* 8-way set assoc, 64 byte line size */
+	{ 0xd7, CACHE_L3,	MB(2)	},	/* 8-way set assoc, 64 byte line size */
+	{ 0xd8, CACHE_L3,	MB(4)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0xdc, CACHE_L3,	MB(2)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0xdd, CACHE_L3,	MB(4)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0xde, CACHE_L3,	MB(8)	},	/* 12-way set assoc, 64 byte line size */
+	{ 0xe2, CACHE_L3,	MB(2)	},	/* 16-way set assoc, 64 byte line size */
+	{ 0xe3, CACHE_L3,	MB(4)	},	/* 16-way set assoc, 64 byte line size */
+	{ 0xe4, CACHE_L3,	MB(8)	},	/* 16-way set assoc, 64 byte line size */
+	{ 0xea, CACHE_L3,	MB(12)	},	/* 24-way set assoc, 64 byte line size */
+	{ 0xeb, CACHE_L3,	MB(18)	},	/* 24-way set assoc, 64 byte line size */
+	{ 0xec, CACHE_L3,	MB(24)	},	/* 24-way set assoc, 64 byte line size */
 };
 
 
@@ -518,10 +518,10 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 				continue;
 
 			switch (entry->cache_type) {
-			case LVL_1_INST: l1i += entry->size; break;
-			case LVL_1_DATA: l1d += entry->size; break;
-			case LVL_2:	 l2  += entry->size; break;
-			case LVL_3:	 l3  += entry->size; break;
+			case CACHE_L1_INST:	l1i += entry->size; break;
+			case CACHE_L1_DATA:	l1d += entry->size; break;
+			case CACHE_L2:		l2  += entry->size; break;
+			case CACHE_L3:		l3  += entry->size; break;
 			}
 		}
 	}
-- 
2.48.1


