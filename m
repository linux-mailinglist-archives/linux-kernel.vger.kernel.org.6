Return-Path: <linux-kernel+bounces-549844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0996A557D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CC8177467
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E120764C;
	Thu,  6 Mar 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWGv10sr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60mIn93+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720927BF75
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294246; cv=none; b=thF0Bh4AMfHgyV1FtosHiSHG0mgLKlwTh0rTRMzK9OjDYITHhjPWDsoVolprt1vx03HeWs02SMTpEiqxvpeziQs0K3cPOwsGOZfFXuEr6BPwarn+NjyXnaeCCgXC6bFshxsD13dpYIQlviZSCjKLFp4gZp/h+LtRXh5uRM+fXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294246; c=relaxed/simple;
	bh=3dyKvFwIOoPeXrZ1fE8S9QLS4SSkGAFsSLgxF9LTb58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbUUHlqGKd1EyQl7FBuH1lfOW16f3yvr3lgLO2+iSUZZ4M+zlf1Sdz2EAOFcCT5IiPs7YOFfxOeq0JqHghQoe3eHE13sRxT01VyCPg3G8idwi076TlY5eedgM+6hSheNgPTgtJt7C9Vf5KWRWZWOsmqHUKOsSnrHbj4a7OP90pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWGv10sr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60mIn93+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5giKA4hI6lP210LiWSpQ+UIAfT5RrxzXmAOgFMYyg2E=;
	b=nWGv10srjuZie/zEzumA6tKEyt12G55NcQ1I29zCrY+5lOfBJH3TwfHpD26GgbmGf9zqcx
	yJTGNYa5p1CSHX4+kcIYNB3GnTxM3F06idMRJ44+9EzAibUL41XqB/51N7xRjJR3og7bLN
	EWhs9yRR749lnUnZER/gAjPvskBTj3oKy6ltEHFs2AHpDduV2NBfPP/wvpuLkOo0W7SeBc
	YGqQfB7NG6h7078ALp31dBuvB76v6VP3PO7vr6G9jx2g7ZwQ23bNVEf6vOlY7buU/CnZjW
	K8KhJwOwhlHRjfRHbfybBtti1QEhj4EmAg7agD3b+tiMKO2r3p2Gybqj4wjPNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5giKA4hI6lP210LiWSpQ+UIAfT5RrxzXmAOgFMYyg2E=;
	b=60mIn93+i6J/vq1H+uc7mfGQXHl9otuqxZjQc1gnu+OXK5HaBxIqywgsQzwwbhZXLYY4rA
	gqfg7u3nmwGowVAA==
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
Subject: [PATCH v1 08/12] tools/x86/kcpuid: Restrict CPUID scanning to valid vendor ranges
Date: Thu,  6 Mar 2025 21:49:56 +0100
Message-ID: <20250306205000.227399-9-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcpuid works in two runs: one run for invoking the CPUID instructions and
saving all their output in memory, and another for parsing that raw
in-memory output using the CSV file specification.  In both runs, kcpuid
should only process CPUID ranges that are valid for the current CPU
vendor.

Restrict for_each_cpuid_range() to only iterate over CPUID ranges that
are known to be valid for this CPU vendor.  Doing it at the iterator
level avoids sprinkling ugly CPU-vendor CPUID range validity conditionals
throughout the code.  Overall, this allows adding vendor-specific CPUID
rages to the CSV file at later commits.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 36efcb753b77..3153c8eba0c4 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -118,7 +118,9 @@ static char *range_to_str(struct cpuid_range *range)
 
 #define for_each_cpuid_range(range)				\
 	for (unsigned int i = 0;				\
-	     i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]);	\
+	     i < ARRAY_SIZE(ranges)		&&		\
+		     ((range) = &ranges[i])	&&		\
+		     (range->vendors & this_cpu_vendor);	\
 	     i++)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
-- 
2.48.1


