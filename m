Return-Path: <linux-kernel+bounces-256436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3246934E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3AB22543
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3F143C74;
	Thu, 18 Jul 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rM1IhNQy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KzGOUU6B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED7143891
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310504; cv=none; b=HrB5hE2m3l+/ovR08tERzTBKCpHzLRiIyrK+KgeejU6f/XIAvRfeyZz57b2VLMkf117jkbojPX5pRfhKoiHmXmxLrDQ3T8pNuT6y4vJtfTlmnozTuVnC7jqrhbbqu7GtsHcAuqYxldoyvdCCpi7ifx/2r2tpN1F+nXWgi3xY7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310504; c=relaxed/simple;
	bh=omyVhzXb1POuFb3g3JKHB8dVH7nIuqPhKHn1MTX2ckE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0kdP7076akNqWLkf8pPI0z6pfpKaHKaBFBPPErj81I8xvUl2BH5KKvDd9dskBPOIHQxHnWoY8TtZ0c6YExL1aUGskFPVoEWjDKnX2jH24kBIEaTQWDqM2GoKTgjLX2QO7Ps4G7kebVt00n8vFuhl71wfV9AGWw3tatyK8IMv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rM1IhNQy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KzGOUU6B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cssV5FJl85ZfJCD7dQMLFaOjrMNVhp+60A/FUsQHzE=;
	b=rM1IhNQyw8LaolVhJGtrW/+KMo+vOI/tp/1FC1I9mr+3qEgxarpuLJ6dWIGeYKpYuHiL+w
	SI9rYAHYEWk+JNRtVRKNhbmxMLci+EZF3FRx1cNtwaWrm73fkPUIqrXCbGfq/kllXVZc7Y
	7uS8qX02cvPAaJkCYaJvKalOOYUWAYOUiejJP61MijpR84Ud5W8q5sq7AXqRrs77WUcocq
	14K3VlSwdhsIgdA4/Rx/6KGBvmgoW2xI/7s9pa6gMcJeSqyP7ViX/OsCkqgehFzvtgfv9F
	BFwqYIIVq9OdkcKkQYlXLLiDN0Hgx8xOhCZNufL5WHZLG2zf0pmZ98hL5843Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cssV5FJl85ZfJCD7dQMLFaOjrMNVhp+60A/FUsQHzE=;
	b=KzGOUU6BcdUc49xEDKBeAYnUTE4IbKG5NJB/n8UnKKO64UDZJHZGrxPNeZIuDF5cd7RXpW
	8p5WDgU8qJdh0RAw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 6/9] tools/x86/kcpuid: Recognize all leaves with subleaves
Date: Thu, 18 Jul 2024 15:47:46 +0200
Message-ID: <20240718134755.378115-7-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid.csv will be extended in further commits with all-publicly-known
CPUID leaves and bitfields.  Thus, modify has_subleafs() to identify all
known leaves with subleaves.

Remove the redundant "is_amd" check since all x86 vendors already report
the maxium supported extended leaf at leaf 0x80000000 EAX register.

The extra mentioned leaves are:

  - Leaf 0x12, Intel Software Guard Extensions (SGX) enumeration
  - Leaf 0x14, Intel process trace (PT) enumeration
  - Leaf 0x17, Intel SoC vendor attributes enumeration
  - Leaf 0x1b, Intel PCONFIG (Platform configuration) enumeration
  - Leaf 0x1d, Intel AMX (Advanced Matrix Extensions) tile information
  - Leaf 0x1f, Intel v2 extended topology enumeration
  - Leaf 0x23, Intel ArchPerfmonExt (Architectural PMU ext) enumeration
  - Leaf 0x80000020, AMD Platform QoS extended features enumeration
  - Leaf 0x80000026, AMD v2 extended topology enumeration

Set the 'max_subleaf' variable for all the newly marked leaves with extra
subleaves.  Ideally, this should be fetched from the CSV file instead,
but the current kcpuid code architecture has two runs: one run to
serially invoke the cpuid instructions and save all the output in-memory,
and one run to parse this in-memory output through the CSV specification.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 39 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index ccbf3b36724f..beb4fde48145 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -98,27 +98,17 @@ static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
 
 static inline bool has_subleafs(u32 f)
 {
-	if (f == 0x7 || f == 0xd)
-		return true;
-
-	if (is_amd) {
-		if (f == 0x8000001d)
+	u32 with_subleaves[] = {
+		0x4,  0x7,  0xb,  0xd,  0xf,  0x10, 0x12,
+		0x14, 0x17, 0x18, 0x1b, 0x1d, 0x1f, 0x23,
+		0x8000001d, 0x80000020, 0x80000026,
+	};
+
+	for (unsigned i = 0; i < ARRAY_SIZE(with_subleaves); i++)
+		if (f == with_subleaves[i])
 			return true;
-		return false;
-	}
 
-	switch (f) {
-	case 0x4:
-	case 0xb:
-	case 0xf:
-	case 0x10:
-	case 0x14:
-	case 0x18:
-	case 0x1f:
-		return true;
-	default:
-		return false;
-	}
+	return false;
 }
 
 static void leaf_print_raw(struct subleaf *leaf)
@@ -255,11 +245,18 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		 * Some can provide the exact number of subleafs,
 		 * others have to be tried (0xf)
 		 */
-		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18)
+		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18 || f == 0x1d)
 			max_subleaf = min((eax & 0xff) + 1, max_subleaf);
-
 		if (f == 0xb)
 			max_subleaf = 2;
+		if (f == 0x1f)
+			max_subleaf = 6;
+		if (f == 0x23)
+			max_subleaf = 4;
+		if (f == 0x80000020)
+			max_subleaf = 4;
+		if (f == 0x80000026)
+			max_subleaf = 5;
 
 		for (subleaf = 1; subleaf < max_subleaf; subleaf++) {
 			eax = f;
-- 
2.45.2


