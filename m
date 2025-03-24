Return-Path: <linux-kernel+bounces-573824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F219AA6DCDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B8018831F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A626388A;
	Mon, 24 Mar 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qQok99My";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRnU/E8N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE48262D2A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826093; cv=none; b=As4uKwHps/OR7Ucd6ZmDEVB1PldeLW1zQPgwCJ8Jc1YlCXPxnBQbhRqLNZFt93mnzajrow0JOktJ94oX8JOq2lwpRFhWIw8YHxGxrx0DSO/cjYEPhiJLOaC6PLiLwv5KlkHWuxvdUSE+VbuIwj/yxF0gFY9nZ2kw5P6+y92QE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826093; c=relaxed/simple;
	bh=CWzDzV9WkeT3NVx3S+77beRZgfgEX6McvtpWsmaoxeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwhsg4b/5RALWEYgHpHWbCjV9pHwIlCEd/pAY9f6Dkw7SRdeIKo/LuUxACm5D5IXOgYfRCXCX7gvSKeC/Rq/3A/NdSq3L4AjcMGSU2RDVpBjDD9MNamGfNipkMpqHu8VwagH9xUH5gG1Pda8HTL7CDscNLcDUbzDeIlJv9sFuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qQok99My; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRnU/E8N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKF6tN/roj0XApjiNOmY4sh8uEAK0MbjBL1IP5D5/m4=;
	b=qQok99MykriWZdslCdH1g3DeJuAi3xobemtUQmXNk/dkeMd0aQ/psISYyiWdAw6AlvOuKJ
	qO6lqHhKhNX4qoQ5WqFlOECm/eIW/WdpTpWy0hFIttKULZsQOT7Deon2288CDEkfYLX5nz
	QHm8w4bAjO2Fu7ktH9mDDs5wd9pe5tGBZiGxT2PObbkbwttvfQ1s9C+yFlD70FYStx8w50
	Px4MExSe+XBX6LcTgq7UVyuaQs4P8UxGIv8jUnDX7IZz6k1flqaJv8uWu25wg8844yfkzW
	4+jPjsGSMYvSabB8AzY745usrfY2iJEn1zqDqzo8UtR1UwJOLsuDRbtjGT38Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKF6tN/roj0XApjiNOmY4sh8uEAK0MbjBL1IP5D5/m4=;
	b=JRnU/E8Na4TlaWP1RJA3X8Nw222ktncypbKfSPWU0uJcbq1QoZXvvEx769S21/rTVNAynM
	WQ/l7h/8HZ1nARDQ==
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
Subject: [PATCH v3 14/20] tools/x86/kcpuid: Filter valid CPUID ranges
Date: Mon, 24 Mar 2025 15:20:35 +0100
Message-ID: <20250324142042.29010-15-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Next commits will introduce vendor-specific CPUID ranges like Transmeta's
0x8086000 range and Centaur's 0xc0000000.

Initially explicit vendor detection was implemented, but it turned out to
be not strictly necessary.  As Dave Hansen noted, even established tools
like cpuid(1) just tries all ranges indices, and see if the CPU responds
back with something sensible.

Do something similar at setup_cpuid_range().  Query the range's index,
and check the maximum range function value returned.  If it's within an
expected interval of [range_index, range_index + MAX_RANGE_INDEX_OFFSET],
accept the range as valid and further query its leaves.

Set MAX_RANGE_INDEX_OFFSET to a heuristic of 0xff.  That should be
sensible enough since all the ranges covered by x86-cpuid-db XML database
are:

	0x00000000	0x00000023
	0x40000000	0x40000000
	0x80000000	0x80000026
	0x80860000	0x80860007
	0xc0000000	0xc0000001

At setup_cpuid_range(), if the range's returned maximum function was not
sane, mark it as invalid by setting its number of leaves, range->nr, to
zero.

Introduce the for_each_valid_cpuid_range() iterator instead of sprinkling
"range->nr != 0" checks throughout the code.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 +++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 8f81fd66e8dd..94a5926d00d0 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -96,8 +96,13 @@ static char *range_to_str(struct cpuid_range *range)
 	}
 }
 
-#define for_each_cpuid_range(range)		\
-	for (unsigned int i = 0; i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]); i++)
+#define __for_each_cpuid_range(range, __condition)				\
+	for (unsigned int i = 0;						\
+	     i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]) && (__condition);	\
+	     i++)
+
+#define for_each_valid_cpuid_range(range)	__for_each_cpuid_range(range, (range)->nr != 0)
+#define for_each_cpuid_range(range)		__for_each_cpuid_range(range, true)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
 {
@@ -105,7 +110,7 @@ struct cpuid_range *index_to_cpuid_range(u32 index)
 	u32 range_idx = index & CPUID_INDEX_MASK;
 	struct cpuid_range *range;
 
-	for_each_cpuid_range(range) {
+	for_each_valid_cpuid_range(range) {
 		if (range->index == range_idx && (u32)range->nr > func_idx)
 			return range;
 	}
@@ -223,20 +228,32 @@ static void raw_dump_range(struct cpuid_range *range)
 }
 
 #define MAX_SUBLEAF_NUM		64
+#define MAX_RANGE_INDEX_OFFSET	0xff
 void setup_cpuid_range(struct cpuid_range *range)
 {
-	u32 max_func, idx_func;
+	u32 max_func, range_funcs_sz;
 	u32 eax, ebx, ecx, edx;
 
 	cpuid(range->index, max_func, ebx, ecx, edx);
 
-	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
-	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
+	/*
+	 * If the CPUID range's maximum function value is garbage, then it
+	 * is not recognized by this CPU.  Set the range's number of valid
+	 * leaves to zero so that for_each_valid_cpu_range() can ignore it.
+	 */
+	if (max_func < range->index || max_func > (range->index + MAX_RANGE_INDEX_OFFSET)) {
+		range->nr = 0;
+		return;
+	}
+
+	range->nr = (max_func & CPUID_FUNCTION_MASK) + 1;
+	range_funcs_sz = range->nr * sizeof(struct cpuid_func);
+
+	range->funcs = malloc(range_funcs_sz);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
 
-	range->nr = idx_func;
-	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
+	memset(range->funcs, 0, range_funcs_sz);
 
 	for (u32 f = range->index; f <= max_func; f++) {
 		u32 max_subleaf = MAX_SUBLEAF_NUM;
@@ -523,7 +540,7 @@ static void show_info(void)
 
 	if (show_raw) {
 		/* Show all of the raw output of 'cpuid' instr */
-		for_each_cpuid_range(range)
+		for_each_valid_cpuid_range(range)
 			raw_dump_range(range);
 		return;
 	}
@@ -552,7 +569,7 @@ static void show_info(void)
 	}
 
 	printf("CPU features:\n=============\n\n");
-	for_each_cpuid_range(range)
+	for_each_valid_cpuid_range(range)
 		show_range(range);
 }
 
-- 
2.48.1


