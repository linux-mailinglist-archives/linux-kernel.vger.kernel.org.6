Return-Path: <linux-kernel+bounces-543546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA934A4D6FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9813AEC3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27331FC7C9;
	Tue,  4 Mar 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSqUSpGY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3BcREA2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CF1FCD0F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078346; cv=none; b=qhzqJSDor4yWL60Azgin7PKluFsusUQS6xeL1D6rMQx5dkVdGD4X6bxjN1DfXL47Dnaf/t5+nOCEQonBSBJJx2dDy5PxdZc8Negp6ykSfngA5PzaMsE1QsWANcJR/tw/uZOQhAkZ4KIuZF6LsKF5Hj3D8xCw2Cf+Clsk58sQCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078346; c=relaxed/simple;
	bh=vKqcvavr9pOXr6uy7VVLJhpPYo3fWrUTp4PYQ+J/dPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdLUiErEB9evqVy+hrFuLUrnchviZXezwghtOVJDvmuTlQBqVF0mTQzOI1dR7x8iovjXQ2mRDLQsN+kCKXv+T3DdLYaSj9ujgsXZSjM3g4qZq/N9Ia6UAYI2HCPGKwIJP1ejtjcU2ldZ9DHwWl7mfZYR+++3ClhmGicvw1l4/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eSqUSpGY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3BcREA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdHm42jE7oEmVWRACBGiP+be9b9OnOGdWQRJRma4eKg=;
	b=eSqUSpGYrAoTNVcBvE0xDr8/JtsygooxxhDah9fw1V62d6PMncx11ZMl+w8O9bhXARR8jv
	kcCvGuM48LgP2mzKjuiq/67/7cyQVbutjwzfRwWUf9vW+v2MDvUP/jFrDK/CeWEY3EiQ8r
	AtUd+wx131dlaihvRbnQC3dHpPzbW+svjUHQLjWKRrdSGsy9CmVD5YCSwrO8WwMce8epHd
	H2+Sv5OCGOsbgjyQcpLMpcLIy4p+Isy5jUBIznD/kkV1+F6/wY6jeVh5bXsr+5CtFRtqsz
	CQRKm5s29U1dJiLWTip3xnLD6/modFBXA7N1HGIIHidZmAvenkaiCslmjUJm2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdHm42jE7oEmVWRACBGiP+be9b9OnOGdWQRJRma4eKg=;
	b=U3BcREA2vQjZWiH0h08wAyOPE8n9hiXCkSGLvRj/bi5jxdPHUCSYAkr0b7A6c3CBTs/Hyb
	SOTD0H4x0ymPXLAA==
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
Subject: [PATCH v1 03/40] x86/cpu: Properly parse leaf 0x2 TLB descriptor 0x63
Date: Tue,  4 Mar 2025 09:51:14 +0100
Message-ID: <20250304085152.51092-4-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid leaf 0x2's one-byte TLB descriptors report the number of entries
for specific TLB types, among other properties.

Typically, each emitted descriptor implies the same number of entries
for its respective TLB type(s).  An emitted 0x63 descriptor is an
exception: it implies 4 data TLB entries for 1GB pages and 32 data TLB
entries for 2MB or 4MB pages.

For the TLB descriptors parsing code, the entry count for 1GB pages is
encoded at the intel_tlb_table[] mapping, but the 2MB/4MB entry count is
totally ignored.

Update leaf 0x2's parsing logic 0x2 to account for 32 data TLB entries
for 2MB/4MB pages implied by the 0x63 descriptor.

Fixes: e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 50 +++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2a3716afee63..134368a3f4b1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -635,26 +635,37 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K	0x01
-#define TLB_INST_4M	0x02
-#define TLB_INST_2M_4M	0x03
+#define TLB_INST_4K		0x01
+#define TLB_INST_4M		0x02
+#define TLB_INST_2M_4M		0x03
 
-#define TLB_INST_ALL	0x05
-#define TLB_INST_1G	0x06
+#define TLB_INST_ALL		0x05
+#define TLB_INST_1G		0x06
 
-#define TLB_DATA_4K	0x11
-#define TLB_DATA_4M	0x12
-#define TLB_DATA_2M_4M	0x13
-#define TLB_DATA_4K_4M	0x14
+#define TLB_DATA_4K		0x11
+#define TLB_DATA_4M		0x12
+#define TLB_DATA_2M_4M		0x13
+#define TLB_DATA_4K_4M		0x14
 
-#define TLB_DATA_1G	0x16
+#define TLB_DATA_1G		0x16
+#define TLB_DATA_1G_2M_4M	0x17
 
-#define TLB_DATA0_4K	0x21
-#define TLB_DATA0_4M	0x22
-#define TLB_DATA0_2M_4M	0x23
+#define TLB_DATA0_4K		0x21
+#define TLB_DATA0_4M		0x22
+#define TLB_DATA0_2M_4M		0x23
 
-#define STLB_4K		0x41
-#define STLB_4K_2M	0x42
+#define STLB_4K			0x41
+#define STLB_4K_2M		0x42
+
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of
+ * entries for their respective TLB types.  The 0x63 descriptor is an
+ * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
+ * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
+ * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
+ * intel_tlb_table[] mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES	32
 
 static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
@@ -676,7 +687,8 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
+						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
 	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
 	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
 	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
@@ -776,6 +788,12 @@ static void intel_tlb_lookup(const unsigned char desc)
 		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
 		break;
+	case TLB_DATA_1G_2M_4M:
+		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		fallthrough;
 	case TLB_DATA_1G:
 		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
-- 
2.48.1


