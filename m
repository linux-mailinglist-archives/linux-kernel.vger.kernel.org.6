Return-Path: <linux-kernel+bounces-557898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17FA5DF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A077AD0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127672571C7;
	Wed, 12 Mar 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Edt61PlO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZ6WyitZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC82571B5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790306; cv=none; b=R75iyBHca8RFIGTmwQ/NZxedFUlms16l6SQJQIZYFF/iAjGd9D/AOzdFQsStZr0MEX12Ua6IlFB/g+wuB62edgUDrgrgsWOikpbhZIt/pTotjPCWH5hJOtzldMuOuEY42QRJDH4io15VKxA8wKVNIjgCj8FW09nAJbv7PgVqpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790306; c=relaxed/simple;
	bh=Adf+zN0jZwi1RYzCLoCEtx2M+jktmNOuFEJOe/QrH74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttnqPPqA/c0h0t3LIB7DFE7EXzmIvD4DULF99NMiuLFnqVaQUWnuLc/KRF6QarQ6BR7OPW6/6tIsDcu+NZbspb3/VSjJ9dVVMNYn7lI/nMmukvkUcNMd/dstNe5bz3T0gdOA0WxxM/ER5YcdtDt9aSt/DSH5oG38OrDTXR/BS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Edt61PlO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZ6WyitZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLdZ2DXpJDx8yhYu4D1b1KQ/w9DYKov9AN7jy9kVAKA=;
	b=Edt61PlOLARx2gizMoOJKFGoW5gIFTA2eu9pOyw+fumbHpWIJm694RefvfsxFccfoNNAv3
	YKbYp6txF7vD7T8tsEeT/ehpMFzNTo8stg87oPCJfiJ5YuS/I0gvRVnVLw1pRa5YMW4cw/
	xWR9O7GfTt5cZmOB6xPiOQwYPKAjREjy3+81dmMTfTAPDtGlSDsU0e+MF+ejukzCW+irsK
	+cFJ0Rnv7JNJTpz1neSzBjuoWd0/u082pjLve17y8s+aAgXww/9pXtCSg9ZSTAHD8ENs/n
	voWsrk3iPC1AB/3ZBNKm0KArH/9RLIlrezCejPOf1lXwLQ7ZIJblpoLlrjNnyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLdZ2DXpJDx8yhYu4D1b1KQ/w9DYKov9AN7jy9kVAKA=;
	b=dZ6WyitZ1Wm2v97P+gtzH5VNw0NxhC0BSVWtNoTAHajjaxuX4YdBp/4VFRbdj1kfBLOrzK
	V+UTQBfr+jd7z8BA==
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
Subject: [PATCH v2 12/20] tools/x86/kcpuid: Extend CPUID index mask macro
Date: Wed, 12 Mar 2025 15:37:29 +0100
Message-ID: <20250312143738.458507-13-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the CPUID index mask macro from 0x80000000 to 0xffff0000.  This
accommodates the Transmeta (0x80860000) and Centaur (0xc0000000) index
ranges which will be later added.

This also automatically sets CPUID_FUNCTION_MASK to 0x0000ffff, which is
the actual correct value.  Use that macro, instead of the 0xffff literal
where appropriate.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 00a3b7a8953c..0ba0d440482c 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -71,7 +71,7 @@ enum range_index {
 	RANGE_EXT = 0x80000000,		/* Extended */
 };
 
-#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_INDEX_MASK		0xffff0000
 #define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
 
 struct cpuid_range {
@@ -173,7 +173,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	 * Cut off vendor-prefix from CPUID function as we're using it as an
 	 * index into ->funcs.
 	 */
-	func = &range->funcs[f & 0xffff];
+	func = &range->funcs[f & CPUID_FUNCTION_MASK];
 
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
@@ -228,7 +228,7 @@ void setup_cpuid_range(struct cpuid_range *range)
 
 	cpuid(range->index, max_func, ebx, ecx, edx);
 
-	idx_func = (max_func & 0xffff) + 1;
+	idx_func = (max_func & CPUID_FUNCTION_MASK) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
 		err(EXIT_FAILURE, NULL);
@@ -512,7 +512,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	if (!range)
 		return NULL;
 
-	func_idx = index & 0xffff;
+	func_idx = index & CPUID_FUNCTION_MASK;
 	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
 
-- 
2.48.1


