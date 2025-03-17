Return-Path: <linux-kernel+bounces-564704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27738A65983
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D50189B3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919F4200BB2;
	Mon, 17 Mar 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="em/hmoP/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQzXWF24"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F192063C9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230429; cv=none; b=VHMk7a8zs2/Ixl2i73bhrrsuCx1ejdkeA3cOEk2Hvlx76PEDVoaASid51n9J+Nfgx0+tRz5HG0c15t9FBVJvGOMBnc55Hqpvp7ym74/ZNVVz7vsg8FFPIcjBA9HoKWawADNKST2xQlmVYlJWnIuBdfE/vTkDac74+rDefJXtDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230429; c=relaxed/simple;
	bh=L4ZG610tJGe5Smjyd3bD8sRBTZdSM3p2vK7/2axOPpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KauQ37doOsLRuM2lJjDd3mma7yjamvnnP+vQO0OY4BC29+NG37UChTMzvYTzPb9ANEkWrJkVilQCjA9fEHlkC/33Mixd32iKw6gsXeWvimfjFS+Veg3jUdkPmK8hwr1G0n0VOmcELaXaqHQdB7iqhBmr4pkDXg6Yp1p+MxQorVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=em/hmoP/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQzXWF24; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImIdr7wWHuYAycxUJ2XI6Rs2AyCxISpaoAPM8TQVpis=;
	b=em/hmoP/m+ak0fUbU3Jnmjlii8JC43O/A6Y4JgFqQgD4uf5G4KJFUNBrHu4Sh2XZBxjC/G
	oi0L7wHSI+Vp0E/m7Nn2uB5pChQLC2rMFK4iZLnMjbi77Q2XbgIle/PSV5cdW91dsoGQjG
	/3G9X67EibqrmHVHHZvwKrIpBQ2YUoga7A3S8iGM3Ydje3iPLpX9TwthS+DsBXn27uKgx/
	WcO1fLOFhJRBC9E2pZU93WsRKZuRT0GqLmDYdn81np4MgkVvGyz9Qmhm7NgFDsrRZDhyAO
	u5ie8qtiHveqG+vVOQW/PIZZuETqTLXFcDTw0xJvJ6Cug3PMc805RTFzbjXpvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImIdr7wWHuYAycxUJ2XI6Rs2AyCxISpaoAPM8TQVpis=;
	b=lQzXWF24lXzXtC9jXI3G0sYRtgGrwy9kdHUrUzClfGMUdkXEqKMAAnXA7o5xAziupPJumB
	taB0S+bCkU5tCODA==
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
Subject: [PATCH v2 25/29] x86/cacheinfo: Extract out cache level topology ID calculation
Date: Mon, 17 Mar 2025 17:47:41 +0100
Message-ID: <20250317164745.4754-26-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
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
index f1db8182deeb..78636de752ba 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -397,6 +397,16 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
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
@@ -417,7 +427,6 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 		return false;
 
 	for (int i = 0; i < ci->num_leaves; i++) {
-		unsigned int num_threads_sharing, index_msb;
 		struct _cpuid4_info id4 = {};
 		int ret;
 
@@ -434,15 +443,11 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
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


