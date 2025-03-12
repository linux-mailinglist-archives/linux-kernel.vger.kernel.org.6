Return-Path: <linux-kernel+bounces-557888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EDDA5DF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EB5164EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E224FC08;
	Wed, 12 Mar 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyvoIAmm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ruQW06ub"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514A24BBEF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790277; cv=none; b=YsOLgCuAw1YNOEt3eWPXnuzfFtol6qAF2gfNstkY/gq2gvD9o5tcfp3xk89K55rVn2mKXfE7lxYArtKWNZVlIi09VzJi1BIKw8CHy5xaQknuk1Ob1HBbekJvLRXOpafUxMPQx785quOD7itD0cvYP3V7j/Yiz8AYuvYUhpPAq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790277; c=relaxed/simple;
	bh=6GF/cyvtwarm61iqKRBEKqwKaoiqcTQEU9Sk3cTJfVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kid3ZXvkGs7awM+AtmpxymhqwieQguCGc36GZe5ZGiixrTmoC/vjYaDkqlqejXoj6GjQD0Uozdqle5MGbcSezqq1SmIKD5JPNxTCd5xF5aPK4EveH9Cfh/3jIG9AqcpCszpjsUMOqWA93PfKcSiTsQYvgvaKSZkF9yohnDXwRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyvoIAmm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ruQW06ub; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBfo8AXB79SPLI7+74Hw01qjH5lduLL/N5gJi7n6n7M=;
	b=UyvoIAmmq5d4AzDEw17Yn3fLtsNAd+kKSiWuswXDeR/NMePT7XmVlNsX/aI+tHlGPA5s15
	KPo/uOo+HHPo/SbhO1jsR07dJGyDyiQDvyqPpcmVY7e/0w2wAZGBwx5Y4Gx6N4EOk8+qMR
	3dIs7Kf/bi7HkqtEdt95WPhVhAE7jzjRBSAdYmCuh3raRgg5pGQ239WNSY5Jf6cH5twCKZ
	whglolOqOpiOu4t9dsdHabV3JFz/UP1HryUMejrl7NW3maiptHEiXk2Kt1wYT2SJpy7YuN
	8vG1j9nstI91NA9gD77T1xFyDulf1vjDTc0l1g0nPEHsZsN3mUdutaIxNCsryQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBfo8AXB79SPLI7+74Hw01qjH5lduLL/N5gJi7n6n7M=;
	b=ruQW06ubK65R5tjuR436vL10XXigHzlX714b0sxsYlqpisOneqMrByaiR/kLcaH3lkaIAW
	vDyIz6pRw9MI36Ag==
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
Subject: [PATCH v2 02/20] tools/x86/kcpuid: Exit the program on invalid parameters
Date: Wed, 12 Mar 2025 15:37:19 +0100
Message-ID: <20250312143738.458507-3-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user passed an invalid CPUID index value through --leaf=index,
kcpuid prints a warning, does nothing, then exits successfully.
Transform the warning to an error, and exit the program with a proper
error code.

Similarly, if the user passed an invalid subleaf, kcpuid prints a
warning, dumps the whole leaf, then exits successfully.  Print a clear
error message regarding the invalid subleaf and exit the program with the
proper error code.

Note, moving the "Invalid input index" message from index_to_func() to
show_info() localizes error message handling to the latter, where it
should be.  It also allows index_to_func() to be refactored at further
commits.

Note, since after this commit and its parent kcpuid does not just "move
on" on failures, remove the NULL parameter check plus silent exit at
show_func() and show_leaf().

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index abfeecce5aa8..8585c1009c8b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -481,9 +481,6 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 
 static void show_leaf(struct subleaf *leaf)
 {
-	if (!leaf)
-		return;
-
 	if (show_raw) {
 		leaf_print_raw(leaf);
 	} else {
@@ -505,9 +502,6 @@ static void show_func(struct cpuid_func *func)
 {
 	int i;
 
-	if (!func)
-		return;
-
 	for (i = 0; i < func->nr; i++)
 		show_leaf(&func->leafs[i]);
 }
@@ -528,10 +522,9 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
 	func_idx = index & 0xffff;
 
-	if ((func_idx + 1) > (u32)range->nr) {
-		warnx("Invalid input index (0x%x)", index);
+	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
-	}
+
 	return &range->funcs[func_idx];
 }
 
@@ -550,18 +543,19 @@ static void show_info(void)
 		/* Only show specific leaf/subleaf info */
 		func = index_to_func(user_index);
 		if (!func)
-			return;
+			errx(EXIT_FAILURE, "Invalid input leaf (0x%x)", user_index);
 
 		/* Dump the raw data also */
 		show_raw = true;
 
 		if (user_sub != 0xFFFFFFFF) {
-			if (user_sub + 1 <= (u32)func->nr) {
-				show_leaf(&func->leafs[user_sub]);
-				return;
+			if (user_sub + 1 > (u32)func->nr) {
+				errx(EXIT_FAILURE, "Leaf 0x%x has no valid subleaf = 0x%x",
+				     user_index, user_sub);
 			}
 
-			warnx("Invalid input subleaf (0x%x)", user_sub);
+			show_leaf(&func->leafs[user_sub]);
+			return;
 		}
 
 		show_func(func);
-- 
2.48.1


