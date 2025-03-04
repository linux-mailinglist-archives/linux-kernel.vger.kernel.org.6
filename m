Return-Path: <linux-kernel+bounces-543554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7DA4D709
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0F31899CCA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE41FCD0C;
	Tue,  4 Mar 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xnj8RG68";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFom4vVq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425E1FECA6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078369; cv=none; b=qLAGxW0k5D7xWyusY/mkwAZebT9qjDoO52dwzB2EOCYUxEi7d1/oH32xBYkU4UuQqbeVtp+4vxUayAAbo9HWG3AGTM7P8ulMSlT2yDfRh0CNekqb+UQzmC6YAzSRuncGTFmVBtfpNkEh/kpMo7bJzaoUnIJRtkp+WB6D6hLIAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078369; c=relaxed/simple;
	bh=Tmj/cLIyeG6+f+uZ16VKIG/sVwDhoLo8Vqglr6TX98c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA9vifDXxi1UAxvrpytjibXGIwoowRzsUAMpkhsyUoWzuPm6gUwpl7UHIYxdnlKpvBg+gEhrwq2PrRS1D34dRAt+ICZuZ7kPxlXzEcmgYz9egJ82l2jGt0NiQz2I3Q74bbcsfMX3C4E/1ZTgP+/Rpj83g5E7FYKJClQ4NRx12E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xnj8RG68; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFom4vVq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyMX8soR+fgFHwjHOc5NCrkcv2E7TNoGZkTf9OqgSm4=;
	b=Xnj8RG68pM6Lfmqt0AXl376Sbv8mDwI62MG8Hw/Ls6hpS9ettgFhHrcqGBiPNpDfznljc+
	lqCYq62U1RZBF1sH7LIEBtjmDgk5yVCGfrtLvYTP0oqtzBFQaCS3HeABXWfPmszMaYxi+i
	5vtFiH2DJD2sjt+VGzYufzoH7YBxp8qeAolWh3QxAndsQ8go6q+tAgRYfAjpf3JrXMKRQY
	5jOh4wfJrdpg608MLRTF0xXjzE8UvPV5FjVM2Oq3FfDIKQcf6NPDVIGn/j/uNQ2XZ4YJdu
	NY1rGBRXy3tWQ8nQySVPXEj0JBnB4Jcpj0MQUNeTv8KIZ+47Qw180VSvvSsjdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyMX8soR+fgFHwjHOc5NCrkcv2E7TNoGZkTf9OqgSm4=;
	b=BFom4vVq9eGlnA1qDBWMLueLbFD8L1M/odxgkol3x6ij1I+XlgnSVjOa670jdm3jT+adza
	YOvbh7Z2ibRfKBBA==
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
Subject: [PATCH v1 11/40] x86/cacheinfo: Remove the P4 trace leftovers for real
Date: Tue,  4 Mar 2025 09:51:22 +0100
Message-ID: <20250304085152.51092-12-darwi@linutronix.de>
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

commit 851026a2bf54 ("x86/cacheinfo: Remove unused trace variable") removed
the switch case for LVL_TRACE but did not get rid of the surrounding gunk.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index a6c6bccfa8b8..eccffe2ea06c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -31,7 +31,6 @@
 #define LVL_1_DATA	2
 #define LVL_2		3
 #define LVL_3		4
-#define LVL_TRACE	5
 
 /* Shared last level cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
@@ -96,10 +95,6 @@ static const struct _cache_table cache_table[] =
 	{ 0x66, LVL_1_DATA, 8 },	/* 4-way set assoc, sectored cache, 64 byte line size */
 	{ 0x67, LVL_1_DATA, 16 },	/* 4-way set assoc, sectored cache, 64 byte line size */
 	{ 0x68, LVL_1_DATA, 32 },	/* 4-way set assoc, sectored cache, 64 byte line size */
-	{ 0x70, LVL_TRACE,  12 },	/* 8-way set assoc */
-	{ 0x71, LVL_TRACE,  16 },	/* 8-way set assoc */
-	{ 0x72, LVL_TRACE,  32 },	/* 8-way set assoc */
-	{ 0x73, LVL_TRACE,  64 },	/* 8-way set assoc */
 	{ 0x78, LVL_2,      MB(1) },	/* 4-way set assoc, 64 byte line size */
 	{ 0x79, LVL_2,      128 },	/* 8-way set assoc, sectored cache, 64 byte line size */
 	{ 0x7a, LVL_2,      256 },	/* 8-way set assoc, sectored cache, 64 byte line size */
@@ -787,19 +782,13 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			}
 		}
 	}
-	/*
-	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
-	 * trace cache
-	 */
-	if ((!ci->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
+
+	/* Don't use CPUID(2) if CPUID(4) is supported. */
+	if (!ci->num_leaves && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
-		int only_trace = 0;
-
-		if (ci->num_leaves && c->x86 == 15)
-			only_trace = 1;
 
 		/* Number of times to iterate */
 		n = cpuid_eax(2) & 0xFF;
@@ -820,8 +809,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 				/* look up this descriptor in the table */
 				while (cache_table[k].descriptor != 0) {
 					if (cache_table[k].descriptor == des) {
-						if (only_trace && cache_table[k].cache_type != LVL_TRACE)
-							break;
 						switch (cache_table[k].cache_type) {
 						case LVL_1_INST:
 							l1i += cache_table[k].size;
-- 
2.48.1


