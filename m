Return-Path: <linux-kernel+bounces-573811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB23A6DCCC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C12D188AF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305C926138C;
	Mon, 24 Mar 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVJ0aYqQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mt9Ipq6P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71425FA12
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826061; cv=none; b=Px0P9ZOWfmRoMu9QHVf+4vR9ojEZr42n92BT3UlACG5HIRD7h7uSHQjAxQDdSESme6mUXNCtArhav7uK3IcBOAqWcxubiyNDLT1URY4DTHtZ4Is+sqSka/3CBsSpbJJJve2Bo0YkvPaseSpCXn8aHUqmEVEHX+LvyPtUzyKEo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826061; c=relaxed/simple;
	bh=TTRr9DIck2vTMBqimKMjA0AXz1JdWsyxH9ey+9dIcDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7z7El3m2fMfJiyJMTr6sXD+hPuVIifjL3V2jxzMUso7j2HmjvCdC2BK9H1mVOCZFQg70q45Y5F0xRzKUYBm29UEqh3ykw6CKtnAdHLFjiF5vi+hT7fObkt9hZJrmaKvlgC+YIQ0QF4pOfQ3XrhtQYyXtGU3bEWDqKCWAHpgTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fVJ0aYqQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mt9Ipq6P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3d5eMFovfuZpkqxG/MKiEnTBJi/aFV7p1SdqOI2eFGM=;
	b=fVJ0aYqQsATo4p0iZaMVNec8ixgye02y/1BJS3gNL9/QdxEvc6ISzLFacjlRzo1Tj2KGNt
	4Qlxm4Pvvq6aTZyxpd6IBsNpqKLNUxjJd2pVSppkeNdq4sBWBVv4xJlDVlqv+blrmWNeyV
	pDpGYtGwOG+PJ7Aq8AJzEGKz6tA/2tXSMRMeGx79LpozQc+8x4Hsf0pzX89cdUQxDBGNLq
	VNLJddFigpgclaBEHKWO3lj1bgeziCqjy1pseuRotBDXEFEZjJ0lZFmM1l/mv8u2Ko7tBH
	emQDmu7LN1XQVnOa52+jcxPCWJUM+GF+gKh6xrHbzrdzlqZVzyZvgRDMGKKWJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3d5eMFovfuZpkqxG/MKiEnTBJi/aFV7p1SdqOI2eFGM=;
	b=mt9Ipq6PdxJCtv/3RNHal1yFZSJuoizBMlfW7mLmRHbrQ9cpMr8XRf5GtzXp/bHROo/7Ms
	+81TTUTxelHL14Aw==
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
Subject: [PATCH v3 04/20] tools/x86/kcpuid: Save CPUID output in an array
Date: Mon, 24 Mar 2025 15:20:25 +0100
Message-ID: <20250324142042.29010-5-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For each CPUID leaf/subleaf query, save the output in an output[] array
instead of spelling it out using EAX to EDX variables.

This allows the CPUID output to be accessed programmatically instead of
calling decode_bits() four times.  Loop-based access also allows "kcpuid
--detail" to print the correct output register names in next commit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index b760c5730c89..dfabc0a56507 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -51,7 +51,7 @@ static const char * const reg_names[] = {
 struct subleaf {
 	u32 index;
 	u32 sub;
-	u32 eax, ebx, ecx, edx;
+	u32 output[NR_REGS];
 	struct reg_desc info[NR_REGS];
 };
 
@@ -119,11 +119,11 @@ static void leaf_print_raw(struct subleaf *leaf)
 		if (leaf->sub == 0)
 			printf("0x%08x: subleafs:\n", leaf->index);
 
-		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
-			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n", leaf->sub,
+		       leaf->output[0], leaf->output[1], leaf->output[2], leaf->output[3]);
 	} else {
-		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
-			leaf->index, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n", leaf->index,
+		       leaf->output[0], leaf->output[1], leaf->output[2], leaf->output[3]);
 	}
 }
 
@@ -163,10 +163,10 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 	leaf->index = f;
 	leaf->sub = subleaf;
-	leaf->eax = a;
-	leaf->ebx = b;
-	leaf->ecx = c;
-	leaf->edx = d;
+	leaf->output[R_EAX] = a;
+	leaf->output[R_EBX] = b;
+	leaf->output[R_ECX] = c;
+	leaf->output[R_EDX] = d;
 
 	return false;
 }
@@ -490,10 +490,8 @@ static void show_leaf(struct subleaf *leaf)
 				leaf->index, leaf->sub);
 	}
 
-	decode_bits(leaf->eax, &leaf->info[R_EAX], R_EAX);
-	decode_bits(leaf->ebx, &leaf->info[R_EBX], R_EBX);
-	decode_bits(leaf->ecx, &leaf->info[R_ECX], R_ECX);
-	decode_bits(leaf->edx, &leaf->info[R_EDX], R_EDX);
+	for (int i = R_EAX; i < NR_REGS; i++)
+		decode_bits(leaf->output[i], &leaf->info[i], i);
 
 	if (!show_raw && show_details)
 		printf("\n");
-- 
2.48.1


