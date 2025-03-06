Return-Path: <linux-kernel+bounces-549842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F98BA557CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD518924DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D927817F;
	Thu,  6 Mar 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKiHUj6R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5oBf0l3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF7278150
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294242; cv=none; b=cek6Od59I+FlUx+MmltvnSO3v2hRDNQ5dHfbflzjSIqwb3QApPi8fIKF9opMxSbUw6h3xLghCqjBTuhvOtSVN6c8bRE3DmeYXwEfZZrpLOOq1Ilve7CGpwIEdl37vnRTzY0f6GYwIEY6SXay70AGrSWZr7erZSa57u/EZFRKdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294242; c=relaxed/simple;
	bh=nPB/Nn8SelnBvMhQSnTJZZlN5sI/ygflWttSB0phHTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bryPW+PRQsYPvvleRaCCPOszfmVi7ArTL115N98bNBFAKgX70BYDmmUaUYvOAToArW5+T6xOH69a29Zhis4PwVFXzulSL3LwvBdaRe1XpyLvh9e/Qi5OfVB4/TQuENoB9+9f1sUqgp8rE1INf+Jvus3059wBlJMHjUhYk7tqZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKiHUj6R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e5oBf0l3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rldM0mUMihWhnurfBIFQ+jK3pHZELWpih4z+AvIEmms=;
	b=DKiHUj6RIOUeARSWa4/bsx3tQ3goIBAElJfwb9GXt/MS1Vf4+zrBb1Jn1fRJeVaoG6dRFM
	ZmLR7f2BXpWzedLORA9t8MdutpQ5rMn4w0cjY5NOV8gEXpbM27t8Ls5UJIfqXOBYxXVksf
	rcQdOYzTGAaTFhXmM15BRn5Fxv2P3DpN7dmesDXjrNhaQf0bCN5dDNG249KdcMj8a6ssM1
	fykFa8xF7T0bhzbvgrgf8Wt4BmHO+KqfHIrE4yr5rpCfefBR6zjLeBOaseL1r8gnlG0R4S
	P+GaRriR8dW3JosPEnFt6aT2VxYOkqIKgTKRe250ufr0k7ezcoT34I1XG0EJyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rldM0mUMihWhnurfBIFQ+jK3pHZELWpih4z+AvIEmms=;
	b=e5oBf0l3fY3d2/1YmLjQAftVwheA9/Yq/yovD92f7QHETreM98kc7Bx+T7rrxsX6qUIhp/
	H2tdUKIXCWk3veBw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 06/12] tools/x86/kcpuid: Extend CPUID index mask macro
Date: Thu,  6 Mar 2025 21:49:54 +0100
Message-ID: <20250306205000.227399-7-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the CPUID index mask macro from 0x80000000 to 0xffff0000.  This
accommodates the Centaur-specific indices (0x80860000+) which will be
later added.

Note that this also automatically sets CPUID_FUNCTION_MASK to 0x0000ffff,
which is the actual correct value.  Use it instead of the 0xffff literal
where appropriate.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 6f6a394486af..6a4c845bc1de 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -70,7 +70,7 @@ enum range_index {
 	RANGE_EXT = 0x80000000,		/* Extended */
 };
 
-#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_INDEX_MASK		0xffff0000
 #define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
 
 struct cpuid_range {
@@ -174,7 +174,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	 * Cut off vendor-prefix from CPUID function as we're using it as an
 	 * index into ->funcs.
 	 */
-	func = &range->funcs[f & 0xffff];
+	func = &range->funcs[f & CPUID_FUNCTION_MASK];
 
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
@@ -236,7 +236,7 @@ void setup_cpuid_range(struct cpuid_range *range)
 
 	cpuid(&eax, &ebx, &ecx, &edx);
 	max_func = eax;
-	idx_func = (max_func & 0xffff) + 1;
+	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
@@ -546,7 +546,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	if (!range)
 		return NULL;
 
-	func_idx = index & 0xffff;
+	func_idx = index & CPUID_FUNCTION_MASK;
 	if ((func_idx + 1) > (u32)range->nr) {
 		warnx("Invalid input index (0x%x)", index);
 		return NULL;
-- 
2.48.1


