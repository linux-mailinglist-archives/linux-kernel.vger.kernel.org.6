Return-Path: <linux-kernel+bounces-425119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8009DBD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936CCB228C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20381CC140;
	Thu, 28 Nov 2024 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPsUkd6n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9yIzsKJP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAC1CBE97
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833054; cv=none; b=Vced6YDxCV9i5pCg980T26a0yjp0kvqXthUSuKmZSWmtGFKC+95sRlAkpcUA2moi2g/5WlBUsNIwFlPDC4bxo6XtRT3Y3Z6j310sRnx2hdTzF5+bZ4C5CqeyJpF3dEl0aLA+QQg9l/+1hEwQWN6ZO3p5b+SMhvRCyy98mHux1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833054; c=relaxed/simple;
	bh=94WGLjzC4kHI0/O239FkrTbi4VOi0Cp4g9z4/scvzwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRDuhLckOwOripgWd5kPFOYZ7wpFCnWxmeuCkrDQAqm/zDXWEhrhn5f29zrG4okH33M+2CHpiv51Uf3A+Z9CPVVTTNDzrXCPxpEBWvb+VpSGwV6BKz7RsCzUVzXWOqYACvxm6qfIjWPQANHxC5xP1tgdosmzs0fBwU6KMuuBG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPsUkd6n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9yIzsKJP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FamdnxzWzyBduKaDhUirDNdvHzFku3acofJxSAPgSI=;
	b=aPsUkd6nBHwSzniTJnDo600OvPMy+swXwvxd1YEnM/KkEK3mLVAl1QmcrFpwmx7i/YK0yp
	qr0K9nmzr/XbW5MCUeDOArzl/tYDEUmaT/LClVUiyP/pt6gOGZoCrUZlw0VyTkamR9hSGf
	XR+NE74jlz7vIQYIPc+Rk0CXQVeCa/LsSNq0JaJ/uVOk3UfPRhaeCMNSkUB8S3vTw4pwrk
	6+ov72VngRltO+dpyR4vD7xdwB35AUqDYpEjrWwNPuEqV+7lhrKw6rLRC78A81jNKQHhTx
	+J+aAdovAME0JEIaa05JrGmes2uesJRJagXbKyn3iIuB9BAQtprFHqr7I+DWgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FamdnxzWzyBduKaDhUirDNdvHzFku3acofJxSAPgSI=;
	b=9yIzsKJPjsdhLD/9h+MWujAXuT7UoWIV2LPrZSVb7NWKROoB309fAqbYz9XZ4aAYYvMiKu
	o6LYMPdxlUZP9QDQ==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 08/13] tools/x86/kcpuid: Extend index mask macro
Date: Thu, 28 Nov 2024 23:29:43 +0100
Message-ID: <20241128222948.579920-9-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the cpuid index mask macro from 0x80000000 to 0xffff0000, as
Centaur indices in the range (0x80860000+) will be later added to the
CSV file.

This automatically sets the cpuid function mask macro to 0x0000ffff, its
negation, which is the more correct value in general.  Use that function
mask macro in other places in the code as needed.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 245f55aa3170..bf0b4dd5b4e3 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -71,7 +71,7 @@ enum range_index {
 	RANGE_EXT = 0x80000000,		/* Extended */
 };
 
-#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_INDEX_MASK		0xffff0000
 #define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
 
 struct cpuid_range {
@@ -205,7 +205,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	 * Cut off vendor-prefix from CPUID function as we're using it as an
 	 * index into ->funcs.
 	 */
-	func = &range->funcs[f & 0xffff];
+	func = &range->funcs[f & CPUID_FUNCTION_MASK];
 
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
@@ -267,7 +267,7 @@ void setup_cpuid_range(struct cpuid_range *range)
 
 	cpuid(&eax, &ebx, &ecx, &edx);
 	max_func = eax;
-	idx_func = (max_func & 0xffff) + 1;
+	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
@@ -579,7 +579,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	if (!range)
 		return NULL;
 
-	func_idx = index & 0xffff;
+	func_idx = index & CPUID_FUNCTION_MASK;
 	if ((func_idx + 1) > (u32)range->nr) {
 		pr_err("ERR: invalid input index (0x%x)\n", index);
 		return NULL;
-- 
2.46.2


