Return-Path: <linux-kernel+bounces-564681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDAA65925
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17BA7ADFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161FF1BC9E2;
	Mon, 17 Mar 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lH8HzpyT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b30CgE5a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C11B4232
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230365; cv=none; b=WtRqn1UwV1EsjLdntVWKL183SUCfPKU2I9QJTfLLno444lbf3LGZw9Dql+03N0eacICgiOorY9jZj302cwdcoHqzTJtQIZAGV/rx6HfxLVy+teOdxDSh6MumIMDcdLHGqAX9MBu48mbzUz6yiXjxLLnkOguDfTDY5Rktf2otvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230365; c=relaxed/simple;
	bh=g5nCTLUQ7v/dgeHO9ZdiBcj0f1KcnklqusMEc/U04jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+OR409yLx8SlxvzPK3VF3VBJzEf+BUiAfL5lCbMB6tgNXCHcyoa6F/13DKY5qgDj9al55LaVqkHWX0jR6zQbRpawKi75wDqiRIC/Ro/ETnaeTLN/J3o4tGIm6CQyZEP9pmh9ID32DH1V5rWL46uYb5cPqB5noCD6jZaeXfcYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lH8HzpyT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b30CgE5a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XG4Vc/qKmqnIpTdZ4sagmxTTKpcTja3KbsV8H2WxcY=;
	b=lH8HzpyTJRGzZTtJVPipk9ZYX2+2q7lRbXZ/faQjRILORybDUZhFB1xksZEXz9SR6IE7ai
	a71jwvC53F5CpBk0gGQe6QxfVlDV1LWl1FBXtOERiU2skJPIuh9n6W/VApuWWMt0UaQ8vc
	5O8AfK7azZpSQocPRIqtwHAxzHhigwI9+cs3RKpfK/ksQHre/GjiEloPVVnrDpLMdVWIti
	IU8L0U9O0JpgFimejesoQFOpmXDa33MT+eb/NHERMXpBLDbJU4cce5mfKtXRJ8gX5eQjQt
	ETrvc8DoYlPHXgunmFyuTBkGFeqpwcA6t5x2CyWvkFmPe9fAAWHbaCxefKf6Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XG4Vc/qKmqnIpTdZ4sagmxTTKpcTja3KbsV8H2WxcY=;
	b=b30CgE5a3wh4w7odNYO6VdN82hFC6VhZn5T4jS74yNYnVTlBytaGDSzAqPh8BvyYbWUNXG
	YDmBnAchWVlqkgAg==
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
Subject: [PATCH v2 04/29] x86/cacheinfo: Use CPUID leaf 0x2 parsing helpers
Date: Mon, 17 Mar 2025 17:47:20 +0100
Message-ID: <20250317164745.4754-5-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the CPUID leaf 0x2 parsing helpers added in previous commits, which
queries the CPUID leaf just once.  This also makes the same leaf 0x2
parsing logic used by both x86/cacheinfo and x86/cpu intel.c

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 66 +++++++++++++--------------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 584811ffca0c..53f51acefac6 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <asm/amd_nb.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpuid.h>
 #include <asm/mtrr.h>
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
@@ -782,50 +783,35 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
 	if (!ci->num_leaves && c->cpuid_level > 1) {
-		/* supports eax=2  call */
-		int j, n;
-		unsigned int regs[4];
-		unsigned char *dp = (unsigned char *)regs;
-
-		/* Number of times to iterate */
-		n = cpuid_eax(2) & 0xFF;
-
-		for (i = 0 ; i < n ; i++) {
-			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
-
-			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 4 ; j++)
-				if (regs[j] & (1 << 31))
-					regs[j] = 0;
-
-			/* Byte 0 is level count, not a descriptor */
-			for (j = 1 ; j < 16 ; j++) {
-				unsigned char des = dp[j];
-				unsigned char k = 0;
-
-				/* look up this descriptor in the table */
-				while (cache_table[k].descriptor != 0) {
-					if (cache_table[k].descriptor == des) {
-						switch (cache_table[k].cache_type) {
-						case LVL_1_INST:
-							l1i += cache_table[k].size;
-							break;
-						case LVL_1_DATA:
-							l1d += cache_table[k].size;
-							break;
-						case LVL_2:
-							l2 += cache_table[k].size;
-							break;
-						case LVL_3:
-							l3 += cache_table[k].size;
-							break;
-						}
-
+		union leaf_0x2_regs regs;
+		u8 *desc;
+
+		cpuid_get_leaf_0x2_regs(&regs);
+		for_each_leaf_0x2_desc(regs, desc) {
+			unsigned char k = 0;
+
+			/* look up this descriptor in the table */
+			while (cache_table[k].descriptor != 0) {
+				if (cache_table[k].descriptor == *desc) {
+					switch (cache_table[k].cache_type) {
+					case LVL_1_INST:
+						l1i += cache_table[k].size;
+						break;
+					case LVL_1_DATA:
+						l1d += cache_table[k].size;
+						break;
+					case LVL_2:
+						l2 += cache_table[k].size;
+						break;
+					case LVL_3:
+						l3 += cache_table[k].size;
 						break;
 					}
 
-					k++;
+					break;
 				}
+
+					k++;
 			}
 		}
 	}
-- 
2.48.1


