Return-Path: <linux-kernel+bounces-557899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6DA5DF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E29D3BAAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A88257421;
	Wed, 12 Mar 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22jyB/2Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86+UfwIM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9552571BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790309; cv=none; b=nsTXCy+gnc1iypdwYAatdCFAmq2Ye/R3DL5plC7h0W6tx9j46npOye6i4LGDi+QLLMap/kApx8j1JKo5QvpVmsfTRtHUIn9l1YaN4V9B3FRwi93FQvh3i7IddB284njr1Nt7uH9KstMe0Cnn4K0gcvUb1zEr7LJ9dAYpgrFcBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790309; c=relaxed/simple;
	bh=qWrm+5sdJIBIXXCJ0kSnHvIZfC2T8C6svN5rvbnkpiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3tilvyy/6li1KQygnmI7vfGqspHE8pHNGBw96TQPyO8usDjSKHJWpqQAb21jSMtIop+OW33vLr6XTkL3VMfNXiFHQvg+744Yv8uWjD66bSSfPZCDwmmRwQ//Jf/S5Vyb4a/fcjQwRD9u90LKffQi6VZyrvxksw5g0waZdEE8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22jyB/2Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=86+UfwIM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug2XSIyXFgWR3Oi6TV0HW8fjI9rdKYlILIEfOFbHB+I=;
	b=22jyB/2YvlJ7N88O9EWHxH3ZqXoHCJ2D/0TSBDNVSGoIX0cWoo8fbB0p4wb27fPQwAojEy
	t0aIXaYfufOM87LWFciTgGZYeBfiP1cuxcRvz+R6T+/OHsE7zF7fkfo82PkPGyKCu02RWe
	Tzz0K9QVg8QkJAep2rAY/W/4gjMSL9IiTaVHIlzDHdUXwsCepTO6d9l/SSCwe0bSAoI7we
	WfEyswTCJJS5KGsuozxKAvstm71vX9LxfNPXTXA8YGGLnMFDequMNzZRrhvQ6k0/1Y2Cnb
	8Di44YQvW3WcHUWkjU4oWNtEEaY/LLWR4b4FfHowyQECxW4U+smPT3FDF7QB2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug2XSIyXFgWR3Oi6TV0HW8fjI9rdKYlILIEfOFbHB+I=;
	b=86+UfwIMMCbu8kbwfmJdLyonVYC37kNHyERvDwx1NYoghaDIW38BMzqSVQk5Kjm2n5mOp3
	yJWlolQ5SuM13gDQ==
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
Subject: [PATCH v2 13/20] tools/x86/kcpuid: Consolidate index validity checks
Date: Wed, 12 Mar 2025 15:37:30 +0100
Message-ID: <20250312143738.458507-14-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let index_to_cpuid_range() return a range only if the passed index is
within that range's maximum supported function on the CPU.

This avoids repeating the same index validity check at both
setup_cpuid_range() and index_to_func().

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 0ba0d440482c..fff6db1119ed 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -101,10 +101,12 @@ static char *range_to_str(struct cpuid_range *range)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
 {
+	u32 func_idx = index & CPUID_FUNCTION_MASK;
+	u32 range_idx = index & CPUID_INDEX_MASK;
 	struct cpuid_range *range;
 
 	for_each_cpuid_range(range) {
-		if (range->index == (index & CPUID_INDEX_MASK))
+		if (range->index == range_idx && (u32)range->nr > func_idx)
 			return range;
 	}
 
@@ -331,16 +333,14 @@ static void parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	/* Skip line parsing if it's not covered by known ranges */
+	/*
+	 * Skip line parsing if the index is not covered by known-valid
+	 * CPUID ranges on this CPU.
+	 */
 	range = index_to_cpuid_range(index);
 	if (!range)
 		return;
 
-	/* Skip line parsing for non-existing indexes */
-	index &= CPUID_FUNCTION_MASK;
-	if ((int)index >= range->nr)
-		return;
-
 	/* Skip line parsing if the index CPUID output is all zero */
 	func = &range->funcs[index];
 	if (!func->nr)
@@ -505,17 +505,13 @@ static void show_range(struct cpuid_range *range)
 
 static inline struct cpuid_func *index_to_func(u32 index)
 {
+	u32 func_idx = index & CPUID_FUNCTION_MASK;
 	struct cpuid_range *range;
-	u32 func_idx;
 
 	range = index_to_cpuid_range(index);
 	if (!range)
 		return NULL;
 
-	func_idx = index & CPUID_FUNCTION_MASK;
-	if ((func_idx + 1) > (u32)range->nr)
-		return NULL;
-
 	return &range->funcs[func_idx];
 }
 
-- 
2.48.1


