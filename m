Return-Path: <linux-kernel+bounces-567990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F6A68CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B875B7AE8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAD25A339;
	Wed, 19 Mar 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w8nNf2u7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kN2WZISo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820225A327
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386966; cv=none; b=XP1ElUkucvQ/JGeK3KT9KOdgIzOJh4fsJy/dKTTEjlBE0VMzq26f7eYkUKiyiA2tcrQFQCf8gXJkzLnZbQP/r+m5JzR8jz9XpgLee/wmb4bUxXueEq0cr8MqQb4QbxDhET7FJTeIPs5uC3PUoL+sd7HyNz+iy7gDRq0FwQBmKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386966; c=relaxed/simple;
	bh=qpujk5hg4CvNJIdMcwYSj/OpC+5m48G6K2q4yWyS4wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zej731bmB3/JKIiBhGd+WQJ3vs3KIULQxHj98guKptzKFe1FHw+QHLsiFhfJlLQV6RFZXuUxNeDR3HFSiFcap/H8wZVFsa2VCjdnnh7ysUmhwi2sherGIGNGVFKmuXBu1R6NOIIeiLREHfa228TUzWiqB7YBs/Yej3qo2SJ8TP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w8nNf2u7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kN2WZISo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzZb8QZvQtSwW+L1cshEDC7N7oXLYfPopw4pUfO7Ik4=;
	b=w8nNf2u7bHj4s/hvZTQrKXtAgwVThkrHBBmdm1bm5d7yMQHB4CXfvpXGTqLQOQyxWckYTA
	WXKBbc3m0UHstWgFUdFd7E6EgAE2XC8j/qbnpfufMdoyoTs7To/gOue2p4WBDTcRonz8Gx
	ZHJoGJjtv4S2La76FayeBfxNk3WWMjXrBzAyQjtnNqRhRATptlTz6IKRq5EaV3CCYbUdgy
	GwT+Id/RQl/lPASO8i0hNRhXUt4PLoQzUL029FbDIOBWNrAg85Vckws5nwtfLd3yy/o7+1
	9VnaHDvCJQn4+sCjEFVCPa/eCvjD9Wc4KrrKzRc4NGvLCL1daxV4J0cVcCiE+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzZb8QZvQtSwW+L1cshEDC7N7oXLYfPopw4pUfO7Ik4=;
	b=kN2WZISoUs3KkRtuXHxK8tCNw8d+IfQMRjMnDZO/NPnuIQQO+Ga3MYpBiFYbWiaCtOW4Qz
	s/zZ+10tJjNxZUDA==
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
Subject: [PATCH v3 19/29] x86/cpu: Use enums for TLB descriptor types
Date: Wed, 19 Mar 2025 13:21:27 +0100
Message-ID: <20250319122137.4004-20-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf 0x2 one-byte TLB descriptor types:

	TLB_INST_4K
	TLB_INST_4M
	TLB_INST_2M_4M
	...

are just discriminators to be used within the intel_tlb_table[] mapping.
Their specific values are irrelevant.

Use enums for such types.

Make the enum packed and static assert that its values remain within a
single byte so that the intel_tlb_table[] size do not go out of hand.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 29 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c        | 28 +++-------------------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index bbbd0bccfce5..0c07df192749 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -58,4 +58,33 @@ enum _cache_table_type {
 } __packed;
 static_assert(sizeof(enum _cache_table_type) == 1);
 
+/*
+ * Leaf 0x2 1-byte descriptors' TLB types
+ * To be used for their mappings at intel_tlb_table[]
+ *
+ * Start at 1 since type 0 is reserved for HW byte descriptors which are
+ * not recognized by the kernel; i.e., those without an explicit mapping.
+ */
+enum _tlb_table_type {
+	TLB_INST_4K		= 1,
+	TLB_INST_4M,
+	TLB_INST_2M_4M,
+	TLB_INST_ALL,
+
+	TLB_DATA_4K,
+	TLB_DATA_4M,
+	TLB_DATA_2M_4M,
+	TLB_DATA_4K_4M,
+	TLB_DATA_1G,
+	TLB_DATA_1G_2M_4M,
+
+	TLB_DATA0_4K,
+	TLB_DATA0_4M,
+	TLB_DATA0_2M_4M,
+
+	STLB_4K,
+	STLB_4K_2M,
+} __packed;
+static_assert(sizeof(enum _tlb_table_type) == 1);
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index aeb7d6d48379..def433e0081f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -626,28 +626,6 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K		0x01
-#define TLB_INST_4M		0x02
-#define TLB_INST_2M_4M		0x03
-
-#define TLB_INST_ALL		0x05
-#define TLB_INST_1G		0x06
-
-#define TLB_DATA_4K		0x11
-#define TLB_DATA_4M		0x12
-#define TLB_DATA_2M_4M		0x13
-#define TLB_DATA_4K_4M		0x14
-
-#define TLB_DATA_1G		0x16
-#define TLB_DATA_1G_2M_4M	0x17
-
-#define TLB_DATA0_4K		0x21
-#define TLB_DATA0_4M		0x22
-#define TLB_DATA0_2M_4M		0x23
-
-#define STLB_4K			0x41
-#define STLB_4K_2M		0x42
-
 /*
  * All of leaf 0x2's one-byte TLB descriptors implies the same number of
  * entries for their respective TLB types.  The 0x63 descriptor is an
@@ -660,7 +638,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 
 struct _tlb_table {
 	unsigned char descriptor;
-	char tlb_type;
+	enum _tlb_table_type type;
 	unsigned int entries;
 };
 
@@ -718,11 +696,11 @@ static void intel_tlb_lookup(const unsigned char desc)
 	     intel_tlb_table[k].descriptor != 0; k++)
 		;
 
-	if (intel_tlb_table[k].tlb_type == 0)
+	if (intel_tlb_table[k].type == 0)
 		return;
 
 	entries = intel_tlb_table[k].entries;
-	switch (intel_tlb_table[k].tlb_type) {
+	switch (intel_tlb_table[k].type) {
 	case STLB_4K:
 		tlb_lli_4k = max(tlb_lli_4k, entries);
 		tlb_lld_4k = max(tlb_lld_4k, entries);
-- 
2.48.1


