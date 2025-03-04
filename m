Return-Path: <linux-kernel+bounces-543582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C4A4D724
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D5D7AA39E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C12046A0;
	Tue,  4 Mar 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpUIq/bb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/D4696s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258FC20459C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078445; cv=none; b=d0oZZ9JLKTdJ+1FZzuB6yKtmKaA9hXlX8IUOY/kF4VmgJhjaZqihxu0xn1I3Qol4NWGatIQOitFQ/lWTU4zyl7sv0hl9P8wQ97QPgpbfH8rYvTJaDDDeO8Mrf6Njp7HWuiv2iHYtS8wr+Ma5O/304PudzAaldMugydXlNdYdOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078445; c=relaxed/simple;
	bh=hFL16DLhDtQtcLZvrMYplDpdu0nW4c2wh0/lfU7dn5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDmMgPhh/DS5XcN+Nn/YaLyYZDcbWjiXPwNqEDwfEa9n3QgijGi9mSpgiB81H9z3vOXUy0Ylp+/NscvpYVUE0C6xy+HTzDKui909/dNHjvUwhQxXCDexVTd06CYQcbioKSHaV7596xnHjJQed8dN2XJPQ2oFggnKEdHOtCAZaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpUIq/bb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/D4696s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+qVD+HyH5QeO/DmxqVT8U0QebtNRgiqMb5NT91qfgs=;
	b=qpUIq/bbT5nROtYfKMfI5Elqsu6fbjZl+YstH3OmrEiP2q2ekPb2kT8WfC+flOff9pdDgK
	rhsWq2nVJt8TS60W9g6kB+LaZgaG6ZMNQEcTMFi5bn9y9if0M0MI5c1lGlXlHF2rNwDDI/
	Hi/G/XV+3HOfAW+oPKbaFN8hhH2yIyQT7troqoeELCSqX4LAuGjMN9q+4L5R1KoJOtfcyp
	fv1Z5Pf0r7Y82gZuTa0MR0ngzGkHvgtRUHncmszUGGqr5D4E/xDKbh0ClJeL3SAqVw1zOZ
	sHl7Skk7xc6DVuTf3Otcp6iMGARGtU3ZS1yD4F8RBGDe25J8Hnub5EsCFBn7lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+qVD+HyH5QeO/DmxqVT8U0QebtNRgiqMb5NT91qfgs=;
	b=T/D4696sD9by54Ii4nDly0TlQTZ35GZJ5IYZdKnV00Z2slG+VA2DvBKaG5EjJuBwxnS489
	xnJB367UTwnrKzBA==
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
Subject: [PATCH v1 36/40] x86/cacheinfo: Extract out cache level topology ID calculation
Date: Tue,  4 Mar 2025 09:51:47 +0100
Message-ID: <20250304085152.51092-37-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For intel leaf 0x4 parsing, refactor the cache level topology ID
calculation code into its own method instead of repeating the same logic
twice for L2 and L3.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 7bd3c33b7f04..254c0b2e1d72 100644
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


