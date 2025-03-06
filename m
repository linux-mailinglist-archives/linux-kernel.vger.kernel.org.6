Return-Path: <linux-kernel+bounces-549843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECEEA557CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507A818940C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91827935D;
	Thu,  6 Mar 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0pCzjjG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6APigC/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B782206F22
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294244; cv=none; b=LI0AH74YWk0j/1SZMUT5LkX+vdhAaBQle9YXC/0C8JHBfVEY9MLx7Gj+9Sijmzh3OR5anxv/URJDFAaTx9uiX77inLkh3wIHMzK7FWrpmhftoEVYg7vWH7685hFulW7nUuOdMq/yLqXhGw9PIkv1n6ku1Vit/HdoAX4DZVwmUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294244; c=relaxed/simple;
	bh=bC9MJfynTdb206YBE832HbVqruIbRmYVUbYmc43PQaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piUyRvOZq1I843owHv5kbsSMIX8Fc1FamsVFfRFAqSlVOmlte/TSsGW2HVr75oQZgI/taze0XV4wSGdI580Li8K0u0PHbD06xy71yN4nqkFYnS6CuX2fhSH6e3mbj3NRAK+ZVvjrJbEzO6v/jD5odzssNxnmua+A3gDa+6xPoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0pCzjjG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6APigC/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qT46OHAQ0Id4t8iEJKmnosKGJmcnq/7L9c0wFS85XMA=;
	b=h0pCzjjGvniSaHlidsaRSOIn9vcrbiVPENRpnWSlMZNjOoHUhPmV90g+qac9/bw25ZG7d5
	BGUL9H6BaWmnaUrzkEJgmUjSspwLJdFl0TsdPdZGXe/nqrEwhcEhuMi/whpI1yI3KaUKOS
	zGfEgOCvOdWYUaIaKEY+wVN1E2q58+7IV0Mw8x1/VGtwyK3c0E4bzQYdX0Ldlsb4fck115
	NM+Vw82LdEOn/7BSX2eWOAEhyI0VAvY80FHzCjOQPdj1nrlS2MGY4sCohbO9Xmzj8Inofm
	LKWmHXEdsFs1WA0Ncm36pgp+e2pNg4lo0ZGuzamn+sNPbQCsgdmGqJlTtK1ohA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qT46OHAQ0Id4t8iEJKmnosKGJmcnq/7L9c0wFS85XMA=;
	b=U6APigC/I3tPK+CmE/o/H2UMex64pzAtd8oGMzeiKEZk5oti1eV+LQCUOZSOy4f9LhKM6/
	ZU+HbAVWHdwGwMCA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 07/12] tools/x86/kcpuid: Add rudimentary CPU vendor detection
Date: Thu,  6 Mar 2025 21:49:55 +0100
Message-ID: <20250306205000.227399-8-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kcpuid CSV file will soon be updated with CPUID indices that are only
valid for certain CPU vendors, such as Centaur or Transmeta.  Thus,
introduce rudimentary x86 vendor detection to kcpuid.

Associate each known CPUID index range with a bitmask indicating its
compatible CPU vendors.  Define CPU vendor markers for Intel, AMD,
Centaur, and Transmeta.  Since fine-grained vendor detection is not
needed, classify Hygon CPUs under AMD and Zhaoxin CPUs under Centaur.

Mark standard (0x0) and extended (0x80000000) CPUID index ranges as valid
for all vendors, including unknown ones.  This ensures that kcpuid still
works in case of an x86 vendor detection failure.

Save the result of CPU vendor detection at a "this_cpu_vendor" global,
which will be utilized in next commits.

Note, to avoid needlessly complicating the kcpuid code, implement vendor
detection only in terms of leaf 0x0's EDX register.  Complete x86 vendor
detection can be later added if needed.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 65 +++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 6a4c845bc1de..36efcb753b77 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -8,12 +8,16 @@
 #include <stdlib.h>
 #include <string.h>
 
+typedef unsigned int u32;
+typedef unsigned long long u64;
+
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#define BIT(x)		(1UL << (x))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
 #define __noreturn	__attribute__((__noreturn__))
 
-typedef unsigned int u32;
-typedef unsigned long long u64;
+#define fourcc(a, b, c, d)	\
+	((u32)(a) | ((u32)(b) << 8) | ((u32)(c) << 16) | ((u32)(d) << 24))
 
 char *def_csv = "/usr/share/misc/cpuid.csv";
 char *user_csv;
@@ -65,6 +69,17 @@ struct cpuid_func {
 	int nr;
 };
 
+enum cpu_vendor {
+	VENDOR_INTEL		= BIT(0),
+	VENDOR_AMD		= BIT(1),	/* includes Hygon */
+	VENDOR_CENTAUR		= BIT(2),	/* includes Zhaoxin */
+	VENDOR_TRANSMETA	= BIT(3),
+	VENDOR_UNKNOWN		= BIT(15),
+	VENDOR_ALL		= ~0UL,
+};
+
+static enum cpu_vendor this_cpu_vendor;
+
 enum range_index {
 	RANGE_STD = 0,			/* Standard */
 	RANGE_EXT = 0x80000000,		/* Extended */
@@ -79,11 +94,17 @@ struct cpuid_range {
 	/* number of valid leafs */
 	int nr;
 	enum range_index index;
+	/* compatible cpu vendors */
+	enum cpu_vendor vendors;
 };
 
 static struct cpuid_range ranges[] = {
-	{	.index		= RANGE_STD,	},
-	{	.index		= RANGE_EXT,	},
+	{	.index		= RANGE_STD,
+		.vendors	= VENDOR_ALL,
+	},
+	{	.index		= RANGE_EXT,
+		.vendors	= VENDOR_ALL,
+	},
 };
 
 static char *range_to_str(struct cpuid_range *range)
@@ -145,6 +166,40 @@ static inline bool has_subleafs(u32 f)
 	return false;
 }
 
+/*
+ * Leaf 0x0 EDX output, CPU vendor ID string bytes 4 - 7.
+ */
+enum {
+	EDX_INTEL	= fourcc('i', 'n', 'e', 'I'),	/* Genu_ineI_ntel */
+	EDX_AMD		= fourcc('e', 'n', 't', 'i'),	/* Auth_enti_cAMD */
+	EDX_HYGON	= fourcc('n', 'G', 'e', 'n'),	/* Hygo_nGen_uine */
+	EDX_TRANSMETA	= fourcc('i', 'n', 'e', 'T'),	/* Genu_ineT_Mx86 */
+	EDX_CENTAUR	= fourcc('a', 'u', 'r', 'H'),	/* Cent_aurH_auls */
+	EDX_ZHAOXIN	= fourcc('a', 'n', 'g', 'h'),	/*   Sh_angh_ai	  */
+};
+
+static enum cpu_vendor identify_cpu_vendor(void)
+{
+	u32 eax = 0, ebx, ecx = 0, edx;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	switch (edx) {
+	case EDX_INTEL:
+		return VENDOR_INTEL;
+	case EDX_AMD:
+	case EDX_HYGON:
+		return VENDOR_AMD;
+	case EDX_TRANSMETA:
+		return VENDOR_TRANSMETA;
+	case EDX_CENTAUR:
+	case EDX_ZHAOXIN:
+		return VENDOR_CENTAUR;
+	default:
+		return VENDOR_UNKNOWN;
+	}
+}
+
 static void leaf_print_raw(struct subleaf *leaf)
 {
 	if (has_subleafs(leaf->index)) {
@@ -671,6 +726,8 @@ int main(int argc, char *argv[])
 
 	parse_options(argc, argv);
 
+	this_cpu_vendor = identify_cpu_vendor();
+
 	/* Setup the cpuid leafs of current platform */
 	for_each_cpuid_range(range)
 		setup_cpuid_range(range);
-- 
2.48.1


