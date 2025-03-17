Return-Path: <linux-kernel+bounces-564689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16198A65968
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16EA188AFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B841EB5FB;
	Mon, 17 Mar 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUuTLJLs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJ4gnbrF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BC1E1E0A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230386; cv=none; b=FbDwlpf5ESHViIfX6Wa78330lhW8aMvv75U198KZtQYBBKR+uLnqfH42VTJIGDkxiB38Q9j9852skh4kwpiXjlQrF/wAwcgcr6I+VV9J036mmY6DmE44ALmklzHjMvH9AOushfXBO5POXoyqshpRwnC9+c2D+OJOQeQrWQ2+eZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230386; c=relaxed/simple;
	bh=xTWO37S4IuZtbiAqhYDUKPpe4BnDqa0ACxPtcIFDA+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDCsmjPntHTT6YhlDbGEbU0mOyG66Z7Y2zwahMDBacyPO0j8Jj/NuQ0SXUC7m+Ndypttz2U6sNuZoa6FVVZhQcekCvxpRtmvelwpH6PkXqLdi9j4wrQ9GZMQhDAibM5V0S+ZPSXgcsOOb1go/FRxHIHvVvKOixd22q9ml3XYX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUuTLJLs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJ4gnbrF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+kj5oY0XXH8fghQdYIw8mnzqdT2hz86AUiWvx2HBMw=;
	b=cUuTLJLsRwqGSe6TC5QXwSAAGRYTX5nx2N1MKJcSEdd1L0LqRW2rVcyw9pJkcaGCHvnJ6N
	3tcOC4KcBH1UtXw5Uigb3ZXxFq0hLjkjL3RsL5bGRx6HylwpXPcWMgxJE6Q6R6pAcEFB6V
	dFQa+Ul9QX2PR9mtN5Vi+X0XxvzpdNB46ULVA+MYfMP9Q47AphrzJxbXcmRxyQGF4nc2ag
	EuncU2JgfmoHQ4Gu9Q/u4SEDt9viJ9c1GyjHUhYEfo6giEZTKQ/3Kz9wlYFXRZcG7I5Vdl
	EdepFAmwSmYOADatZ6vDqfjBi9/PankOPzMMqgtgNHN0EYkWIX5WAnedf9PmKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+kj5oY0XXH8fghQdYIw8mnzqdT2hz86AUiWvx2HBMw=;
	b=eJ4gnbrFfeWpFBlwID9lYyBxQgQMok8czrKImpG/jo6Qp+WKw8SicZYnbQdj6q8fPGrcdI
	HjN4SzlDeng+nmDw==
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
Subject: [PATCH v2 11/29] x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
Date: Mon, 17 Mar 2025 17:47:27 +0100
Message-ID: <20250317164745.4754-12-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While gathering CPU cache info, CPUID leaf 0x8000001d is invoked in two
separate if blocks: one for Hygon CPUs and one for AMDs with topology
extensions.  After each invocation, amd_init_l3_cache() is called.

Merge the two if blocks into a single condition, thus removing the
duplicated code.  Future commits will expand these if blocks, so
combining them now is both cleaner and more maintainable.

Note, while at it, remove a useless "better error?" comment that was
within the same function since the 2005 commit e2cac78935ff ("[PATCH]
x86_64: When running cpuid4 need to run on the correct CPU").

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 06de593e75e1..3eff2f321388 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -598,23 +598,24 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 	union _cpuid4_leaf_ecx	ecx;
 	unsigned		edx;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
+	if (x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor)) {
+		if (boot_cpu_has(X86_FEATURE_TOPOEXT) ||
+		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+			/* AMD with TOPOEXT, or HYGON */
 			cpuid_count(0x8000001d, index, &eax.full,
 				    &ebx.full, &ecx.full, &edx);
-		else
+		} else {
+			/* Legacy AMD fallback */
 			amd_cpuid4(index, &eax, &ebx, &ecx);
-		amd_init_l3_cache(id4, index);
-	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		cpuid_count(0x8000001d, index, &eax.full,
-			    &ebx.full, &ecx.full, &edx);
+		}
 		amd_init_l3_cache(id4, index);
 	} else {
+		/* Intel */
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
 	}
 
 	if (eax.split.type == CTYPE_NULL)
-		return -EIO; /* better error ? */
+		return -EIO;
 
 	id4->eax = eax;
 	id4->ebx = ebx;
-- 
2.48.1


