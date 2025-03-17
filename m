Return-Path: <linux-kernel+bounces-564684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7F7A6592A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4AE7AE3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239431DDA2D;
	Mon, 17 Mar 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1viEIcG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOiqMabH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE61D90D7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230371; cv=none; b=HIDTuZjWvLVhPMpkwUv53AJMA+ulrQmJiyoJCo3QMUD/pJHGarMV+pU4OkJ+Qn2jVXMw27TWyS/PqoGzh8CBo7ZXdGnlXtDpxwpodL9odpkz+ogqLNSeT6SMjjiqzpo0E8fdh4KFLaAN1dmBFeblhpsuTqG54f9ZRPseUlxid3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230371; c=relaxed/simple;
	bh=edpa9U7aIHjjfUkvmwzg7+VcE2XL3xu0KWUiZVUyDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/Yqd5JF+xZzwSeqf3H01wN4piSUB/mpnj6MCt+DmFBaiB6lGLV+Qvgpy103WBxT2HbMmY1ItilETVY5wXAzMSPEqz+gE8fVkc980ZVmg5yPGozY6pfa/NTBottSrDC1v+jiJ/0IkmGSPYruXwVCYSo/Xy38jlrEz0SPXRJ7vUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1viEIcG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wOiqMabH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QHPm+Y/XNCvn/eR1qnN3OcSq/VP/rkFhSLCT5e3BNA=;
	b=J1viEIcGjrjuzJDEAJTJN7ccYKqV3uLNIqHJcMbJMA+yKNa6c+9XSqe69U4E2tBkYaoqUF
	Sg0ja+6CcdqtP+IV6NFUDZ7CRqeDCx8FsDBaBlfsWKo4hMs2gIdr/VJ+/uXWiGpwDCQdFP
	MCeMFFKsoY0dqJfbMH2Pf+S211HKWCqJjdQ9LkeVNPSYZRZv9XRJfp+8yZmO/nluEhwiiL
	mPnnYoqPfNJOGigUILEe/YY0/fVlSgVjUVGQMOYHmhykGxVhXT/+yXrf4kt26IKhiFK1ez
	aTxq275MV/Mj6NKzAqmS9h4pxi2cpbNRYrTDkP6SY48uiSCFswlkKkqr168hwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QHPm+Y/XNCvn/eR1qnN3OcSq/VP/rkFhSLCT5e3BNA=;
	b=wOiqMabHJDXAt6CXN9EumCKoNE8wPps/hLwuo7U8oODMqq7VjNVyF1obGwvn2aZGbaL7tt
	MlIypwb/5S/uC8BQ==
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
Subject: [PATCH v2 06/29] x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
Date: Mon, 17 Mar 2025 17:47:22 +0100
Message-ID: <20250317164745.4754-7-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
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
index 44bc044aa9a2..64effa2d7674 100644
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


