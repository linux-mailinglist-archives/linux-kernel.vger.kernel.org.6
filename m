Return-Path: <linux-kernel+bounces-573735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC1A6DBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29803B23A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330325FA22;
	Mon, 24 Mar 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BozSNkLf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZIcH/XS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01025FA1E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823232; cv=none; b=cTD5F1FKEmb5Zx1OkLoJ8aIaGAqXSc27qSKInoOUMBkBGDWSiS9oJmVzeFNuon9QlURw/AVIA9VQJPcn5/jKo3O/0NO98/uH3D/g+Bc2tCRrlNMTIr27MnGPFdBeZ/ljZTpAln52KFliUBith8wG/QuF5KooZGeowXjXg0wiM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823232; c=relaxed/simple;
	bh=+J2MUMA6FaqN89uo/gT4W5HA2WW9NsIVSlCj58sAbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJgCdEQN2oqD8/B1nhk5Uq6XL28aAcojlICxfsqg7KttltW0A9hng1+lsoJT6kZQG0YKCw5X0YndSoo97enLPvAjz7WV94pbcVFfEi2lQPiSpNUQy57Ur2lQK0bL5THlsIY4w4sgY0z2xWANX+Ylz9LlD6C/uIaWTDHf6ppzkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BozSNkLf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZIcH/XS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjwIQbDd6xf3kEosT4buGrof2c51/KArCUqdt8u05RA=;
	b=BozSNkLf0pY0AAgD1zXzCwWxHDTQX7YkgttiMg5s+a/PttSlI3pMJEeRcKy+RcHbxtWZEJ
	nnSUTjjowLLC1ZANEUWkRSNw5T41BuPsPVtvjyTdZpcqD9W0rN529/m1sp6PDa6iiaeSKY
	KTd2rL1enYs3PlEJSWh2lVKXXpV6wGZfkINP8jNFGLpLYCuIziJ3Nz+eSt284K/MX0hIch
	+j+/BCfzDZKFaN90PT/0B1S9Xvr/L1I7/3Kd9YMJmvY/rskwgfiTiTjg0N0irFD0vmVWwm
	wBdOC9rQAK4Pf/sUdouez/ffaUAbtLcKMUp1HQw3w/OiDg+9Hgafs0Ew9pxYTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjwIQbDd6xf3kEosT4buGrof2c51/KArCUqdt8u05RA=;
	b=GZIcH/XSGhI4GrIN6644r5oj95w4olyyxnIkj3UhQXhc0zxNCJQos+5AcWNqdWtgiLnirm
	EKbNO5wSaEKbr7CA==
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
Subject: [PATCH v4 06/29] x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
Date: Mon, 24 Mar 2025 14:33:01 +0100
Message-ID: <20250324133324.23458-7-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

amd_cpuid4()'s first parameter, "leaf", is not a CPUID leaf as the name
implies.  Rather, it's an index emulating CPUID(4)'s subleaf semantics;
i.e. an ID for the cache object currently enumerated.  Rename that
parameter to "index".

Apply minor coding style fixes to the rest of the function as well.

[ darwi: Move into a separate commit and write commit log.
	 Use "index" instead of "subleaf" for amd_cpuid4() first param,
	 as that's the name typically used at the whole of cacheinfo.c. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index d0bfdb85b96a..0fd4e9673665 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -233,12 +233,10 @@ static const enum cache_type cache_type_map[] = {
 };
 
 static void
-amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
-		     union _cpuid4_leaf_ebx *ebx,
-		     union _cpuid4_leaf_ecx *ecx)
+amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
+	   union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
-	unsigned dummy;
-	unsigned line_size, lines_per_tag, assoc, size_in_kb;
+	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
 	union l1_cache l1i, l1d;
 	union l2_cache l2;
 	union l3_cache l3;
@@ -251,7 +249,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
 	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
 
-	switch (leaf) {
+	switch (index) {
 	case 1:
 		l1 = &l1i;
 		fallthrough;
@@ -289,12 +287,11 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	}
 
 	eax->split.is_self_initializing = 1;
-	eax->split.type = types[leaf];
-	eax->split.level = levels[leaf];
+	eax->split.type = types[index];
+	eax->split.level = levels[index];
 	eax->split.num_threads_sharing = 0;
 	eax->split.num_cores_on_die = topology_num_cores_per_package();
 
-
 	if (assoc == 0xffff)
 		eax->split.is_fully_associative = 1;
 	ebx->split.coherency_line_size = line_size - 1;
-- 
2.48.1


