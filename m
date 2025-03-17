Return-Path: <linux-kernel+bounces-564696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C501A6594D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52E8163E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718020468F;
	Mon, 17 Mar 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEI++gdz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmIeOjuK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116B20468E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230407; cv=none; b=m0g6vxc5X0Yk0CIDY74BwXnitrlgyyMnfoDD1vQmtyEoUClYi1YydQtw+aypvZYVCxMuW5guGugiJkCbOXBt/JY93dWTwFA+1+wu9e5hYPbhJIqcXJ2o+KZ6VNlmnaORWB98zgkSnf/volo88XYSveZZLu3LytwCjLW/ImbMm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230407; c=relaxed/simple;
	bh=iJrqqXJgUqBoWhlvG19Hd6SiAnGy58C4nmpyNGGoB8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2A51Au+oaL2y9RGZ8mZqmyYCDE4hpfWdZaewNXbg+9RvvgMz+oL+TAcqaSLpS73ErAuKVJcDdZEm+qmT6qQh30Ve83luzcGhgAumkz1n2OdegoOCZLP7/1YGch9+QtQRxLl/p9FqT7r0RRI1sKOTaG7zKkXavbxRSOBYZTnoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEI++gdz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmIeOjuK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZneOLcyys9a4jDakDRYtIPf3Hs5hi9xTLfvMDJmSfg=;
	b=WEI++gdzHJ9/HhnG44xEXKQfXyzCqHAScx9NLyzUgBXEK8lDERccJqLK/wnOn3xV5Eo5FL
	L8auREwD63oCjYg3G8jkqlSnDqmMLSPJAz/YE9n+EqtJIC1qd8eB4IE636P3rytukOvUnT
	T2vkOfl3fUJ+Cqf8GqiYYKPpBDazdHTv0KoX6SJwcKGZv3TBGOcH1PzYBWa/0QrNU7W/p8
	IuEM4IqXj8OuuXmHaBy50BGdaqAUswvao7kiIAPu+JVEoxOHjRJBk0nLA//aiLekvVewcw
	VGCR9R8JveQCM/JoKfmqciLL7PZcdcJ4RwjsygOSIKbwAEKVaKxHBSQjPD2MHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZneOLcyys9a4jDakDRYtIPf3Hs5hi9xTLfvMDJmSfg=;
	b=zmIeOjuKAAQuzOhJlh73GJMfE52eMUXlAswzD+wIo+iDgUBEQr4vf8Z4A4nMyzxnDDXvTc
	DywEdELVrEFLkMDw==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 18/29] x86/cacheinfo: Use enums for cache descriptor types
Date: Mon, 17 Mar 2025 17:47:34 +0100
Message-ID: <20250317164745.4754-19-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf 0x2 one-byte cache descriptor types:

	CACHE_L1_INST
	CACHE_L1_DATA
	CACHE_L2
	CACHE_L3

are just discriminators to be used within the cache_table[] mapping.
Their specific values are irrelevant.

Use enums for such types.

Make the enum packed and static assert that its values remain within a
single byte so that the cache_table[] array size do not go out of hand.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 13 +++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c    |  9 ++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 864047113e37..a66192f9df4c 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_CPUID_TYPES_H
 #define _ASM_X86_CPUID_TYPES_H
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 /*
@@ -42,4 +43,16 @@ union leaf_0x2_regs {
 	u8			desc[16];
 };
 
+/*
+ * Leaf 0x2 1-byte descriptors' cache types
+ * To be used for their mappings at cache_table[]
+ */
+enum _cache_table_type {
+	CACHE_L1_INST,
+	CACHE_L1_DATA,
+	CACHE_L2,
+	CACHE_L3
+} __packed;
+static_assert(sizeof(enum _cache_table_type) == 1);
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 777f95c86e03..9f5bf57fd4fc 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -23,11 +23,6 @@
 
 #include "cpu.h"
 
-#define CACHE_L1_INST	1
-#define CACHE_L1_DATA	2
-#define CACHE_L2	3
-#define CACHE_L3	4
-
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
@@ -41,7 +36,7 @@ unsigned int memory_caching_control __ro_after_init;
 
 struct _cache_table {
 	unsigned char descriptor;
-	char cache_type;
+	enum _cache_table_type type;
 	short size;
 };
 
@@ -517,7 +512,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			if (!entry)
 				continue;
 
-			switch (entry->cache_type) {
+			switch (entry->type) {
 			case CACHE_L1_INST:	l1i += entry->size; break;
 			case CACHE_L1_DATA:	l1d += entry->size; break;
 			case CACHE_L2:		l2  += entry->size; break;
-- 
2.48.1


