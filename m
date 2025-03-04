Return-Path: <linux-kernel+bounces-543552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AEBA4D702
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3001749BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834A1FE47C;
	Tue,  4 Mar 2025 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBsb5RRy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIgxgf7m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80B1FE45B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078363; cv=none; b=UcDej3fk5RkVxZg9vXq8XaLzaZl4gjV6MqFKTXA5FLbp1cf35+ttWQyJfvn6KOjFDThOVJmaT80yXEBj+8B0kp1a5UomRpVaNTYj+6x2oIso3Yi6WZ7X8VW4ieBV6OhBpNOha0dp2KaxoQ5ZJQ9yqze+rvaACPXEDvmwbunHWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078363; c=relaxed/simple;
	bh=I7lWy4oxXtM92TgxDHeDJE8J2SKPngVboSsqddFra7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWCduV6LEH9gIci8M4ikqYMGd6Q0UVxVhReUZrazUjUigK4fEcaI5AIAxGUvu0QFaidMOrS4kil60uRAbuH26n44kER2x7vj4LR3P0p6L8BdpoWWrWVj+59ASorxfXdtinRdMl+NqsFxV7vZI0b8MY2ewit5d/EMI1V2IiFuRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBsb5RRy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIgxgf7m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dop/qkJkK0O7Tda551vacFbdZKiU0QbyO4ChptChL2o=;
	b=OBsb5RRyruCefHZyHXyusry/xryMJ8ZSn2DSfuPUVzc4jhy0I8367ao3MFaidff6ziINxY
	jDK1ax9GO8XL9AXzKJfTemVDw2TrY5WLE8WyPJ0NtkaiPOe1ix6YHXXA+t8hMFoe2Y792A
	mXytNRWBL9YT5btU9Fui6cJzogDLmSNes6DCM+AdXqx0qKjmE7silY6d6eGtAwZb/262NU
	qN6Q4g3oyzB4FIOmChfsyxsiL7phS24R2Kj6x3T8pf8tPrc9H1d9lB+uxdGiOFhCOn+cmd
	LLysmx3RYTSJPqdNn0F3UiwHZkh00ldnRlFd+PssQ/IcqCZXk8BEUSc/c+1Ndw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dop/qkJkK0O7Tda551vacFbdZKiU0QbyO4ChptChL2o=;
	b=BIgxgf7mVuYP57mgI/v5ygZis/MiYYkq2XTWLTy6pZP8QddV1ETA0aU9IWZO38Kkedcc4U
	zxvjv0vJYYqnf/Bw==
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
Subject: [PATCH v1 09/40] x86/cpu: Remove unused TLB strings
Date: Tue,  4 Mar 2025 09:51:20 +0100
Message-ID: <20250304085152.51092-10-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

commit e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of
CPU") added the TLB table for parsing CPUID(0x4) including strings
describing them. The string entry in the table was never used.

Convert it to a comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cpu.h   |  8 ----
 arch/x86/kernel/cpu/intel.c | 80 ++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 1beccefbaff9..51deb60a9d26 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -33,14 +33,6 @@ struct cpu_dev {
 #endif
 };
 
-struct _tlb_table {
-	unsigned char descriptor;
-	char tlb_type;
-	unsigned int entries;
-	/* unsigned int ways; */
-	char info[128];
-};
-
 #define cpu_dev_register(cpu_devX) \
 	static const struct cpu_dev *const __cpu_dev_##cpu_devX __used \
 	__section(".x86_cpu_dev.init") = \
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 905f39fce375..cfd492cf9c3b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -657,44 +657,50 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
  */
 #define TLB_0x63_2M_4M_ENTRIES	32
 
+struct _tlb_table {
+	unsigned char descriptor;
+	char tlb_type;
+	unsigned int entries;
+};
+
 static const struct _tlb_table intel_tlb_table[] = {
-	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
-	{ 0x02, TLB_INST_4M,		2,	" TLB_INST 4 MByte pages, full associative" },
-	{ 0x03, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way set associative" },
-	{ 0x04, TLB_DATA_4M,		8,	" TLB_DATA 4 MByte pages, 4-way set associative" },
-	{ 0x05, TLB_DATA_4M,		32,	" TLB_DATA 4 MByte pages, 4-way set associative" },
-	{ 0x0b, TLB_INST_4M,		4,	" TLB_INST 4 MByte pages, 4-way set associative" },
-	{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages" },
-	{ 0x50, TLB_INST_ALL,		64,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
-	{ 0x51, TLB_INST_ALL,		128,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
-	{ 0x52, TLB_INST_ALL,		256,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
-	{ 0x55, TLB_INST_2M_4M,		7,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
-	{ 0x56, TLB_DATA0_4M,		16,	" TLB_DATA0 4 MByte pages, 4-way set associative" },
-	{ 0x57, TLB_DATA0_4K,		16,	" TLB_DATA0 4 KByte pages, 4-way associative" },
-	{ 0x59, TLB_DATA0_4K,		16,	" TLB_DATA0 4 KByte pages, fully associative" },
-	{ 0x5a, TLB_DATA0_2M_4M,	32,	" TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative" },
-	{ 0x5b, TLB_DATA_4K_4M,		64,	" TLB_DATA 4 KByte and 4 MByte pages" },
-	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
-	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
-	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
-						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
-	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
-	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
-	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
-	{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
-	{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
-	{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },
-	{ 0xb2, TLB_INST_4K,		64,	" TLB_INST 4KByte pages, 4-way set associative" },
-	{ 0xb3, TLB_DATA_4K,		128,	" TLB_DATA 4 KByte pages, 4-way set associative" },
-	{ 0xb4, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 4-way associative" },
-	{ 0xb5, TLB_INST_4K,		64,	" TLB_INST 4 KByte pages, 8-way set associative" },
-	{ 0xb6, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 8-way set associative" },
-	{ 0xba, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way associative" },
-	{ 0xc0, TLB_DATA_4K_4M,		8,	" TLB_DATA 4 KByte and 4 MByte pages, 4-way associative" },
-	{ 0xc1, STLB_4K_2M,		1024,	" STLB 4 KByte and 2 MByte pages, 8-way associative" },
-	{ 0xc2, TLB_DATA_2M_4M,		16,	" TLB_DATA 2 MByte/4MByte pages, 4-way associative" },
-	{ 0xca, STLB_4K,		512,	" STLB 4 KByte pages, 4-way associative" },
+	{ 0x01, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages, 4-way set associative */
+	{ 0x02, TLB_INST_4M,		2},	/* TLB_INST 4 MByte pages, full associative */
+	{ 0x03, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way set associative */
+	{ 0x04, TLB_DATA_4M,		8},	/* TLB_DATA 4 MByte pages, 4-way set associative */
+	{ 0x05, TLB_DATA_4M,		32},	/* TLB_DATA 4 MByte pages, 4-way set associative */
+	{ 0x0b, TLB_INST_4M,		4},	/* TLB_INST 4 MByte pages, 4-way set associative */
+	{ 0x4f, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages */
+	{ 0x50, TLB_INST_ALL,		64},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	{ 0x51, TLB_INST_ALL,		128},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	{ 0x52, TLB_INST_ALL,		256},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	{ 0x55, TLB_INST_2M_4M,		7},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
+	{ 0x56, TLB_DATA0_4M,		16},	/* TLB_DATA0 4 MByte pages, 4-way set associative */
+	{ 0x57, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, 4-way associative */
+	{ 0x59, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, fully associative */
+	{ 0x5a, TLB_DATA0_2M_4M,	32},	/* TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative */
+	{ 0x5b, TLB_DATA_4K_4M,		64},	/* TLB_DATA 4 KByte and 4 MByte pages */
+	{ 0x5c, TLB_DATA_4K_4M,		128},	/* TLB_DATA 4 KByte and 4 MByte pages */
+	{ 0x5d, TLB_DATA_4K_4M,		256},	/* TLB_DATA 4 KByte and 4 MByte pages */
+	{ 0x61, TLB_INST_4K,		48},	/* TLB_INST 4 KByte pages, full associative */
+	{ 0x63, TLB_DATA_1G_2M_4M,	4},	/* TLB_DATA 1 GByte pages, 4-way set associative
+						 * (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here) */
+	{ 0x6b, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 8-way associative */
+	{ 0x6c, TLB_DATA_2M_4M,		128},	/* TLB_DATA 2 MByte or 4 MByte pages, 8-way associative */
+	{ 0x6d, TLB_DATA_1G,		16},	/* TLB_DATA 1 GByte pages, fully associative */
+	{ 0x76, TLB_INST_2M_4M,		8},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
+	{ 0xb0, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 4-way set associative */
+	{ 0xb1, TLB_INST_2M_4M,		4},	/* TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries */
+	{ 0xb2, TLB_INST_4K,		64},	/* TLB_INST 4KByte pages, 4-way set associative */
+	{ 0xb3, TLB_DATA_4K,		128},	/* TLB_DATA 4 KByte pages, 4-way set associative */
+	{ 0xb4, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 4-way associative */
+	{ 0xb5, TLB_INST_4K,		64},	/* TLB_INST 4 KByte pages, 8-way set associative */
+	{ 0xb6, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 8-way set associative */
+	{ 0xba, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way associative */
+	{ 0xc0, TLB_DATA_4K_4M,		8},	/* TLB_DATA 4 KByte and 4 MByte pages, 4-way associative */
+	{ 0xc1, STLB_4K_2M,		1024},	/* STLB 4 KByte and 2 MByte pages, 8-way associative */
+	{ 0xc2, TLB_DATA_2M_4M,		16},	/* TLB_DATA 2 MByte/4MByte pages, 4-way associative */
+	{ 0xca, STLB_4K,		512},	/* STLB 4 KByte pages, 4-way associative */
 	{ 0x00, 0, 0 }
 };
 
-- 
2.48.1


