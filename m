Return-Path: <linux-kernel+bounces-573812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372AFA6DCCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D86188B3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557726139E;
	Mon, 24 Mar 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mKlWO9LO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJamdeSj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CA25FA1B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826065; cv=none; b=RvLKGh0+76j13nScSwMutFNSyonf84Cx6zN3lyKEQxN23YVGH6335qVZofgaWf9E+/GfL1B3bVD2S57tuHQXM4hQ5KED6bCEIMLPGGJjjIuEXDrjFiKTh6up3x0Bfd14dOYh4kMdjSAe3+nRXovI+p6kwPvJNzaf7929wzrxKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826065; c=relaxed/simple;
	bh=a0P0gl/D62qUuSPbpqJlT0jpvngBvF4VU9cToBKlJjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0uwTzr11/6P6fnLj7bFpRCY9AcSlrF6L/6wKKImHKlw4HP5d9ZAlaJw4a5MFUJPLTXbhvgXqUv/FvjnYXKz6LXwoXubtsH/iZNkgVzThRmtKl6hY0gRMqP596WCIeCZ/ADMHgLrySq1zqjIN826n6C6vCnVnVWH+j5+Ec9gPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mKlWO9LO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJamdeSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ3mWi1ubbGZzGTVge5QxLcEVVnFacXIqMDfQWpgz5U=;
	b=mKlWO9LOvVen1dUVeKpn8FMktvshTFah6D06gbXfXDa9a3vwPis2ya7gNcOCNxrRfgR05g
	gaqFcHdiLe8G2D5hlRWEPdabhmiwwViXdFTOWsmbW5SO1F/NTmC9PTkBsNNFaFeFCk72gy
	vCqkwhiiWXkXwdAuNITjNcWr38JQWJqahSFP+4iulZ9EXZPk8hqrrfjQ3k4P+YjFhM75by
	2cjf8VJo7YnzVvyPK8Lh+szq4i3dWIQ9b7h9UbnwJzu0nIgG9AzrRFOypqAEW4DQuDlRwg
	ti1MHgf01KAceG//urClW4Kk+EFrV9EhXIOxFXi43+0kAcA0Sns2U5AEtKXShg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ3mWi1ubbGZzGTVge5QxLcEVVnFacXIqMDfQWpgz5U=;
	b=YJamdeSjPBgV3Ooj7j+O66wpxA8E/l0jYOPeDq4Y8aILObJupVqWZGHCCmXOL8J525dqW/
	CCUU9ogx56Z2qQAg==
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
Subject: [PATCH v3 05/20] tools/x86/kcpuid: Print correct CPUID output register names
Date: Mon, 24 Mar 2025 15:20:26 +0100
Message-ID: <20250324142042.29010-6-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
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


