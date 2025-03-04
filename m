Return-Path: <linux-kernel+bounces-543558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD4A4D70B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F867A94D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6B1FF603;
	Tue,  4 Mar 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNm4AuxD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yfc74S8C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FABF1FF5F1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078381; cv=none; b=I/T87Gfx0Hne5k1giPFrH/UxjX14atlDzz4H+v/qeflThEPtaZ2etDjXrEwdFT0g/OWEaxel5Aqp29gQ6f8E4FjC5sd+XTC/MWSxZaihXzJGwMjW1EF5pAjGMAiZK7UGBIBvg4zB3mkFxfDvom7Qlpx33rDqROrKQRE89t4T12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078381; c=relaxed/simple;
	bh=2ISi/BmkfTGvQiIunIigGmW6qc7/h3mdah4zLn6e808=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgp/a5U3X02Ne/z+v3vqrJbQQdrHLsLOq1NfYMSN5yywKWz0wdtaskgAi3pkaCj6MpBJ0n5GY8WpIzpvqMGMzpGvSRfbVS1JuOMlh31UxCUhDfbyyirzNr1vuBHfxImUopfydZb+u2S4xU9cJRcgKdOMT0BExLsT99fcQjDIhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNm4AuxD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yfc74S8C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEB1hgCePv+Z7eLVlwXr81lW6Eepp/nb4cZzNnOU4zE=;
	b=eNm4AuxDKI+Iznd/DSfUs3X7G0l0krIVgfu9p1n18jDtJmcFdwm9ReZ0zRTRLpPd6K5pH6
	0IQEjLLcRKSeCzNOCFsQgivMiWI+co+BcwNxuM2QnnrNAF44OkClqBw1IjzBxS9fohbepR
	rYcpI8epwwBTHRd8Lvx7wciEZm2fKqPQdAPrjYxZrsMOu3nV9FIl7mW4bmVYOApjNI8ReI
	7yHTNV4SrmmdYMxRelEtjE7P3LvzC5++uVIhnjiofEeRQiynRjBLQgem1r3H8Ja0pH5qTS
	842487dFhRRdUfduhjAAV8sqm/buEHSeZzwV6pOjNkst/5C498d7H9Zpv0Vxmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEB1hgCePv+Z7eLVlwXr81lW6Eepp/nb4cZzNnOU4zE=;
	b=yfc74S8CthYcAJri1vgvQ2qzJT3z32Q4wDS7oPWCN82jTXeWj0qsn3ZiSHUZsc97yzG1bb
	3LZdaSkr0+x6CeCw==
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
Subject: [PATCH v1 15/40] x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
Date: Tue,  4 Mar 2025 09:51:26 +0100
Message-ID: <20250304085152.51092-16-darwi@linutronix.de>
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

amd_cpuid4()'s first parameter, "leaf", is not a cpuid leaf as the name
implies.  Rather, it's an index emulating CPUID(4)'s subleaf semantics;
i.e. an ID for the cache object currently enumerated.  Rename that
parameter to "index".

Apply minor coding style fixes to the rest of the function as well.

[darwi: Move into a separate commit and write commit log.
        Use "index" instead of "subleaf" for amd_cpuid4() first param,
	as that's the name typically used at the whole of cacheinfo.c.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3be7ea8444ec..24a7503f37e2 100644
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


