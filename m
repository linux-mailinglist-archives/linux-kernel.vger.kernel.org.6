Return-Path: <linux-kernel+bounces-557890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8754A5DF22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18445165776
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE076251783;
	Wed, 12 Mar 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GS+qQpf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYij7p6v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA04250C0E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790282; cv=none; b=owEa93Lr2y+PHfm5KDB6RhnMeelbP9kvTKMDQ7SebbyHj1L9QktUuTupVw4nkXVo/FpFnKXtezObYiTzodSfl2UsukQKXIybWMTrwgNDQMqYD37C1bj90XWEbRPAzs8Cl6nvjeSim0vNHw7Zs1qaj5oGybx6Xibn5z2/10v5b4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790282; c=relaxed/simple;
	bh=TTRr9DIck2vTMBqimKMjA0AXz1JdWsyxH9ey+9dIcDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQkbKw7UAHWqtNvQE2u2psZh6t29p6V8dRPg25D5OSQh7hJBy+CUzOOVCxrRDBaVzI4SXndCt/VgFQSByRGlGnUtBaRTdnZT3kguG3bBUn3Bee0b0B+eU7kSksNXRuk+DvbTWiO5dPvO4PF5zqYxVC0Q8sTMCQZbbIA440+FCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GS+qQpf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYij7p6v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3d5eMFovfuZpkqxG/MKiEnTBJi/aFV7p1SdqOI2eFGM=;
	b=4GS+qQpf2fAUw68ryg3YfljeI1xeOPLstOsHfMO3m9Mb0zcn6vAMy275MiykVvUJ1g+c0o
	GVxYjP7PImgePnGDMLosyXMZWKquq+llfIIlv6uVH2TSBpLQTZJmY7L4qtpUyTIjBfB/rF
	4SMvUsV28JYG2UzTcN7EBKpYf3c+yN2gAYFqVUONXeqFT2n39cbvge6Hfb4brJPALBwGYS
	vgbTN/yAdb3OVdVEWCNKZYXgBDtChq4ZszzrPwyInflis3EpDqifWVoRkE5OOqDO8hlGXz
	mR+rySjbYAYq+Q70qQAfZaqGnNgO4p8rj9VRlUG5aVYdbwgnpdqgZqnKBlExIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3d5eMFovfuZpkqxG/MKiEnTBJi/aFV7p1SdqOI2eFGM=;
	b=cYij7p6vGy52QVodOi92Xut0To8arn5r4txpmc/jOK66g8xA0HxJDAJiAX/PvDple2Itg6
	KTcRwLBWXEabxvAQ==
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
Subject: [PATCH v2 04/20] tools/x86/kcpuid: Save CPUID output in an array
Date: Wed, 12 Mar 2025 15:37:21 +0100
Message-ID: <20250312143738.458507-5-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
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


