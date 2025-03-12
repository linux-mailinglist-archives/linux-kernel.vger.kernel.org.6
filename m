Return-Path: <linux-kernel+bounces-557891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D601A5DF23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2213AFDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F9252904;
	Wed, 12 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAhTpxAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7QQxuGL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A72517B8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790285; cv=none; b=dH7qmNHgB+C2ABlQO8sO7YAn+ldyAIuZmEHhJiPt6tiqhzOpKAIQS57laZVVG/00keDxOnq9vGfUYtS7e0E52XnixuGgaOBkBWv9At6LB12y6XtF5EqomZoAvfiDHdsEY+gfCDwpW4lbfLhv+tHNKNK87IgeA+qwDMVA+ZNDuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790285; c=relaxed/simple;
	bh=a0P0gl/D62qUuSPbpqJlT0jpvngBvF4VU9cToBKlJjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcrPZ212rttTSQhZ/7oWRmST8NKMWuOc2ii5LCQAzntsLFkO84plR0Utx3V8h3lpxbqQRb9inSvxvTte4RWpBrNWNWpDBzWfbVF3DCCUEfxjixpSoaMOkaKDH/uwqHj4NTKM9O0AgwQHkLJ7iqQeEv9UqZxogTEEE+MUNG9NFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAhTpxAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7QQxuGL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ3mWi1ubbGZzGTVge5QxLcEVVnFacXIqMDfQWpgz5U=;
	b=CAhTpxAViVnxz1+szk46mnBYXb6Krln1qkcnlPhkux8n1M5OlDTSO1HXzItJwfagOvciV7
	X0mO/G6QY7Tl1t6L8aSuv55pqBaQ3quegVg39mNavVLbUlNVYFIuk2oPAKhAzZRZMzTyoo
	9XP/uyjA6crm1PHZkHONADTPPZsFXBkkHatDhK5zAeQtQO8ApLmiHgjLKBtvmhxg5c4J75
	kn1dfA8xypwQBsYj2HKng6E23C5Ky5ZRl6xEFGtKsSCZN7Xphiy88DIELRwIbM7gWRjVd7
	SlIjKtGXIPhDd/Tfu75uiU2Je8Rjy86+kwh6/hqD/lGXyPk1NSbHDGLDXLbw/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ3mWi1ubbGZzGTVge5QxLcEVVnFacXIqMDfQWpgz5U=;
	b=P7QQxuGLcvVCWNzWJlWs9AqfcRpVY0o3xBmMPfvsRTFgD7xsDC4N5r3ZvLO8Am7kZD0l90
	hmgAIHBvwyWYqrAQ==
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
Subject: [PATCH v2 05/20] tools/x86/kcpuid: Print correct CPUID output register names
Date: Wed, 12 Mar 2025 15:37:22 +0100
Message-ID: <20250312143738.458507-6-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcpuid --all --detail claims that all bits belong to ECX, in the form
of the header CPUID_${leaf}_ECX[${subleaf}].

Print the correct register name for all CPUID output.

kcpuid --detail also dumps the raw register value if a leaf/subleaf is
covered in the CSV file, but a certain output register within it is not
covered by any CSV entry.  Since register names are now properly printed,
and since the CSV file has become exhaustive using x86-cpuid-db, remove
that value dump as it pollutes the output.

While at it, rename decode_bits() to show_reg().  This makes it match its
show_range(), show_leaf() and show_reg_header() counterparts.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index dfabc0a56507..d518a13e4386 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -436,20 +436,12 @@ static void parse_text(void)
 	fclose(file);
 }
 
-
-/* Decode every eax/ebx/ecx/edx */
-static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
+static void show_reg(const struct reg_desc *rdesc, u32 value)
 {
-	struct bits_desc *bdesc;
+	const struct bits_desc *bdesc;
 	int start, end, i;
 	u32 mask;
 
-	if (!rdesc->nr) {
-		if (show_details)
-			printf("\t %s: 0x%08x\n", reg_names[reg], value);
-		return;
-	}
-
 	for (i = 0; i < rdesc->nr; i++) {
 		bdesc = &rdesc->descs[i];
 
@@ -480,18 +472,21 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 	}
 }
 
+static void show_reg_header(bool has_entries, u32 leaf, u32 subleaf, const char *reg_name)
+{
+	if (show_details && has_entries)
+		printf("CPUID_0x%x_%s[0x%x]:\n", leaf, reg_name, subleaf);
+}
+
 static void show_leaf(struct subleaf *leaf)
 {
-	if (show_raw) {
+	if (show_raw)
 		leaf_print_raw(leaf);
-	} else {
-		if (show_details)
-			printf("CPUID_0x%x_ECX[0x%x]:\n",
-				leaf->index, leaf->sub);
-	}
 
-	for (int i = R_EAX; i < NR_REGS; i++)
-		decode_bits(leaf->output[i], &leaf->info[i], i);
+	for (int i = R_EAX; i < NR_REGS; i++) {
+		show_reg_header((leaf->info[i].nr > 0), leaf->index, leaf->sub, reg_names[i]);
+		show_reg(&leaf->info[i], leaf->output[i]);
+	}
 
 	if (!show_raw && show_details)
 		printf("\n");
-- 
2.48.1


