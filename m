Return-Path: <linux-kernel+bounces-573754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A357A6DBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97FF7A929D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678952638A8;
	Mon, 24 Mar 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IkV3Tutq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NP7LIfbi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1525FA2F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823291; cv=none; b=q/bTYypT6bauHtsQGMTXJqPZAxu4u4XCFtZaiT0KQPsIi9nejWuqE2YW3mZlJisBzFd7RYLh83Rt5sDFWA/rRVlvwcD+s0/Ynzfz5P3s8unguNxfoa1Rp2xFgPSJhQCQxCYAqypEqn5QrKLUb1KG02x+dx50MS3nnFJOjmlJIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823291; c=relaxed/simple;
	bh=3BKY/tdXYfNHltAGaSPaLrYi3N/AfCY072jY5D3JS/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi+jdhRJKVs7e/MoY9Eh5TFL+fxvE/5bdG/kOYCf2Gt8nqqr0iwVMZyCl/rpru0/VKtv45lMZ2DGa1Fho+oPmgpyfuGrHGh9YDhb33VpscRCs/GqSemrDVId4lTvyr70ow2ZyQTwMpIRZjgDTOJMKadWNMsLbn1PQVY18EfkzCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IkV3Tutq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NP7LIfbi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7qWyKmI7d4ylHBghOpPKLLOgaxJRqfMrX5QN8Pw+nA=;
	b=IkV3TutqQEqJup/KfCDthOacxqtoaAf/3+CDIcSoNeXj7up9t1GwP48FLrpIy3pwLepZTb
	3fjH7RqTw+lhE4/XOkVWe+zDD8EDjqvZEr8kNcl00B2NL4tnPE/tQUZkDHhIK/Tyfo0nOX
	aSQc8jiW4Wivr6mYsOPOJgHtyQ2MXGDFi9hLRLSELR9ocdSwAWFt2twy28Q1psvH9jc0e/
	w8dqtf8YyeoutpABinxs1UGuIInzfViO4YU+d9WiFuHGvYyTrEZIR24Mu4hTqDHg22Thrj
	Ficit96eM5ELm+6/flQA6CJjxCEHKWVmAE1hOUYi9d75P3Ce5P3+m8kr5PP64A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7qWyKmI7d4ylHBghOpPKLLOgaxJRqfMrX5QN8Pw+nA=;
	b=NP7LIfbiVFdmm7G8502OSc6AD9yoKjARGnteUFZ6qubcAQIasJqV6IPzPM1RPhbEWBZN+r
	iDozRaQdV2N4C4Cw==
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
Subject: [PATCH v4 25/29] x86/cacheinfo: Extract out cache level topology ID calculation
Date: Mon, 24 Mar 2025 14:33:20 +0100
Message-ID: <20250324133324.23458-26-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Intel leaf 0x4 parsing, refactor the cache level topology ID
calculation code into its own method instead of repeating the same logic
twice for L2 and L3.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 72cc32d22c4d..7b274da7c725 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -400,6 +400,16 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
 }
 
+static unsigned int calc_cache_topo_id(struct cpuinfo_x86 *c, const struct _cpuid4_info *id4)
+{
+	unsigned int num_threads_sharing;
+	int index_msb;
+
+	num_threads_sharing = 1 + id4->eax.split.num_threads_sharing;
+	index_msb = get_count_order(num_threads_sharing);
+	return c->topo.apicid & ~((1 << index_msb) - 1);
+}
+
 static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
@@ -420,7 +430,6 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		return false;
 
 	for (int i = 0; i < ci->num_leaves; i++) {
-		unsigned int num_threads_sharing, index_msb;
 		struct _cpuid4_info id4 = {};
 		int ret;
 
@@ -437,15 +446,11 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 			break;
 		case 2:
 			l2 = id4.size / 1024;
-			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-			index_msb = get_count_order(num_threads_sharing);
-			l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			l2_id = calc_cache_topo_id(c, &id4);
 			break;
 		case 3:
 			l3 = id4.size / 1024;
-			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-			index_msb = get_count_order(num_threads_sharing);
-			l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			l3_id = calc_cache_topo_id(c, &id4);
 			break;
 		default:
 			break;
-- 
2.48.1


