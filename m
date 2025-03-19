Return-Path: <linux-kernel+bounces-567995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89296A68CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2630119C455F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8625B69A;
	Wed, 19 Mar 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CrPa8YUo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYCPtCBw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790B25B686
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386981; cv=none; b=Dse0eRVSTn2EwzjEAH0GW6mM3sQrGQvL8v8WMwIq+amLrKSVoQm5xYvy12LNRwTAWTe2T//2D8VNHW/jHs8I1Z73/zRMUGWYyrqSReNdOU47B4OjktwjTDQ0E7d1SrDh81ozf/71UFNVbScdPm614BV2cIJJbHdr+UWWYetEjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386981; c=relaxed/simple;
	bh=bgH4GnCFa3f6HaDcCjTmhIWuxb5iDGJ5lLVgqaR1N8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEqK6Hh7hIf5fopBinE3EfqVnayAZcprGOAXmp5MPTHfZqt9UdflwNd9Z6M1W0kESLgOv3/h4+zYKxLPW+sRUQUC7xaxyp7wg9yMwFi7EduwRQN7nJ8B3BxEJV0bnaUPVeAWI7lejLU+fsGgn5CxfxIC6Qm6ubX7w8Z/IDjcl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CrPa8YUo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYCPtCBw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r8iJX+a/1PDmMGUecVZ46+84pOafUoXB4WDPGnjw4A=;
	b=CrPa8YUoXyGd8drG4fLOr6INLHeUAWMBZuHnmFztXPaQZG6h/E5ORQyj1m8Mo/0Vg1NRPY
	7kgRb/RvWFcUhKexQQjLy7n7Vn9eMF24jn5epXTijUEIGkaSqIlfEaMSVopJ6uqvKBJolW
	o72L7kuVx/Z8rLJF3otF+rdTV9QNvcNfwzSgMeBYtuaTSjJb2TI3IMVEfJRkQlEAFoe5EJ
	s70yn6x51IftU/10d6R3or54GGwXj7tlcIihHnEXW1y27ZYr/9Sk670LhVFZ7FRqlf1LY/
	MVpLpYbAqgR4vzFnu1JJV0J3Xio1kLQmGqPhlHknH0V3Zc7/OqBCDjq17bEbYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r8iJX+a/1PDmMGUecVZ46+84pOafUoXB4WDPGnjw4A=;
	b=cYCPtCBwBO1CrepG8qblhiU4pccPbQT1HsErS9H5Iyijv4DXRH1/oGyxsU8ClRktva2Une
	nNhVkgv9FMyKaBBA==
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
Subject: [PATCH v3 24/29] x86/cacheinfo: Separate Intel leaf 0x4 handling
Date: Wed, 19 Mar 2025 13:21:32 +0100
Message-ID: <20250319122137.4004-25-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_intel_cacheinfo() was overly complex.  It parsed leaf 0x4 data,
leaf 0x2 data, and performed post-processing, all within one function.
Parent commit moved leaf 0x2 parsing and the post-processing logic into
their own functions.

Continue the refactoring by extracting leaf 0x4 parsing into its own
function.  Initialize local L2/L3 topology ID variables to BAD_APICID by
default, thus ensuring they can be used unconditionally.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 110 ++++++++++++++++----------------
 1 file changed, 54 insertions(+), 56 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b39aad1ecf9c..72cc32d22c4d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -400,73 +400,71 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
 }
 
-void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 {
 	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
-	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
-	unsigned int l2_id = 0, l3_id = 0;
-
-	if (c->cpuid_level > 3) {
-		/*
-		 * There should be at least one leaf. A non-zero value means
-		 * that the number of leaves has been initialized.
-		 */
-		if (!ci->num_leaves)
-			ci->num_leaves = find_num_cache_leaves(c);
+	unsigned int l2_id = BAD_APICID, l3_id = BAD_APICID;
+	unsigned int l1d = 0, l1i = 0, l2 = 0, l3 = 0;
 
-		/*
-		 * Whenever possible use cpuid(4), deterministic cache
-		 * parameters cpuid leaf to find the cache details
-		 */
-		for (int i = 0; i < ci->num_leaves; i++) {
-			unsigned int num_threads_sharing, index_msb;
-			struct _cpuid4_info id4 = {};
-			int retval;
+	if (c->cpuid_level < 4)
+		return false;
 
-			retval = intel_fill_cpuid4_info(i, &id4);
-			if (retval < 0)
-				continue;
+	/*
+	 * There should be at least one leaf. A non-zero value means
+	 * that the number of leaves has been previously initialized.
+	 */
+	if (!ci->num_leaves)
+		ci->num_leaves = find_num_cache_leaves(c);
 
-			switch (id4.eax.split.level) {
-			case 1:
-				if (id4.eax.split.type == CTYPE_DATA)
-					l1d = id4.size / 1024;
-				else if (id4.eax.split.type == CTYPE_INST)
-					l1i = id4.size / 1024;
-				break;
-			case 2:
-				l2 = id4.size / 1024;
-				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-				index_msb = get_count_order(num_threads_sharing);
-				l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
-				break;
-			case 3:
-				l3 = id4.size / 1024;
-				num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
-				index_msb = get_count_order(num_threads_sharing);
-				l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
-				break;
-			default:
-				break;
-			}
+	if (!ci->num_leaves)
+		return false;
+
+	for (int i = 0; i < ci->num_leaves; i++) {
+		unsigned int num_threads_sharing, index_msb;
+		struct _cpuid4_info id4 = {};
+		int ret;
+
+		ret = intel_fill_cpuid4_info(i, &id4);
+		if (ret < 0)
+			continue;
+
+		switch (id4.eax.split.level) {
+		case 1:
+			if (id4.eax.split.type == CTYPE_DATA)
+				l1d = id4.size / 1024;
+			else if (id4.eax.split.type == CTYPE_INST)
+				l1i = id4.size / 1024;
+			break;
+		case 2:
+			l2 = id4.size / 1024;
+			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
+			index_msb = get_count_order(num_threads_sharing);
+			l2_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			break;
+		case 3:
+			l3 = id4.size / 1024;
+			num_threads_sharing = 1 + id4.eax.split.num_threads_sharing;
+			index_msb = get_count_order(num_threads_sharing);
+			l3_id = c->topo.apicid & ~((1 << index_msb) - 1);
+			break;
+		default:
+			break;
 		}
 	}
 
+	c->topo.l2c_id = l2_id;
+	c->topo.llc_id = (l3_id == BAD_APICID) ? l2_id : l3_id;
+	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
+	return true;
+}
+
+void init_intel_cacheinfo(struct cpuinfo_x86 *c)
+{
 	/* Don't use CPUID(2) if CPUID(4) is supported. */
-	if (!ci->num_leaves && c->cpuid_level > 1) {
-		intel_cacheinfo_0x2(c);
+	if (intel_cacheinfo_0x4(c))
 		return;
-	}
-
-	if (l2) {
-		c->topo.llc_id = l2_id;
-		c->topo.l2c_id = l2_id;
-	}
-
-	if (l3)
-		c->topo.llc_id = l3_id;
 
-	intel_cacheinfo_done(c, l3, l2, l1i, l1d);
+	intel_cacheinfo_0x2(c);
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-- 
2.48.1


