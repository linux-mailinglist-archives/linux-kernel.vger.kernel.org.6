Return-Path: <linux-kernel+bounces-425120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC199DBDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E7B165060
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714391CC166;
	Thu, 28 Nov 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHmElYwh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMisl4iG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3F1CC153
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833057; cv=none; b=AdZQNjJhB42PBa65ViB7rxXqnRE0W/lcBV3wagJ4O7qwG99qNEjixwdtTIQ7qHhPsxCZqx/nfb0CtGE6WE5jVddid7vooP3DMXIjeT/F11u+k4gYx/kcwmW1h0V8tX8jsIzTa/DqPgqsIi0zU40QiNZ/Mg2ZCPc7Am3hfHi6S6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833057; c=relaxed/simple;
	bh=eqphXXU+ajFLQ1I7gs5mjYwNZpiP0dQe89Xps7S3jNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS2OCIJYpjx7AZlaCaDVqKDutKrjz8EMsg6WKJRnuw1k88GfUh3+eA7kZ1ETTtEFO6ug2MRyyQeVLGeCuEhpRaqQVmqtQdUDE2k7TYgtTfWAvhALHjp/Y/1mY1MHNkTswf5vCidpz5bWpuPNwQgVP2uw4NQ8neOs3NzT9aqpVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHmElYwh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EMisl4iG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4HSzWjbm/ROpXvi8MiJFtw09jlE1Tgz+SQql+ft5cY=;
	b=JHmElYwhMca9i24kniYvOQTWpMt2DvCFf+JsS/kt5CiVKhlyDrl+scm4GYq+XVcYiHMNYO
	Eqg+cGOc9A/1ih8QUmaOohtPftzrLDgIOMXaPAMxEEgIo1crCnivoZ0x5qVj8Ot8teMB2v
	5DtRZ2PwLS3RV9bxDKn+li5qylv+J5U3o8VViD/Y6Dq3kbCGs8B5KBTiiV3u8j8ok8xvoP
	oeHQLj1wbaqUnZsQ3ZD/d/JsGucLdJ6GmQn4BWIb6dicZQ11865pphz58rc6/WOD3gA5Oz
	4gUmaUIdjbaXnOGYlEftuXSW0MukbyknIYnnLJvS3JvMlf2pQx0DkloYntVzoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4HSzWjbm/ROpXvi8MiJFtw09jlE1Tgz+SQql+ft5cY=;
	b=EMisl4iGHjaU0mWT4yPHfA2YU05srnJ1zMXz3UqOOyN9QOTSC4TwZNBoV6FbqO2iMl/itj
	9yM7CEhN7iawm9Dg==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 09/13] tools/x86/kcpuid: Add rudimentary vendors detection
Date: Thu, 28 Nov 2024 23:29:44 +0100
Message-ID: <20241128222948.579920-10-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CSV file will be updated with indices that are only valid for
vendors like Centaur or Transmeta.  Thus, introduce rudimentary x86
vendor detection to kcpuid.

For each known cpuid index range, list its compatible CPU vendors in a
bitmask.  Define vendor markers for Intel, AMD, Centaur, and Transmeta.
Since fine-grained vendor classification is not needed, cover Hygons
under AMD, and Zhaoxins under Centaur.

Define a fallback marker for unknown vendors.  Mark standard (0x0) and
extended (0x80000000) index ranges as valid for all vendors, including
unknown.  This ensures that kcpuid still works in case of x86 vendor
detection failure.

Save the result of vendor detection at a "this_cpu_vendor" global, which
will be utilized in further commits.

Note, vendor detection is done only through leaf 0x0 EDX register, "CPU
vendor ID string bytes 4 - 7".  This is to avoid needlessly complicating
the code.  Complete x86 vendor detection can be later added as needed.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 65 +++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index bf0b4dd5b4e3..9769da3e4494 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -9,12 +9,16 @@
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
@@ -66,6 +70,17 @@ struct cpuid_func {
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
@@ -80,11 +95,17 @@ struct cpuid_range {
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
@@ -146,6 +167,40 @@ static inline bool has_subleafs(u32 f)
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
 /**
  * pr_err - Print passed error message to stderr
  */
@@ -704,6 +759,8 @@ int main(int argc, char *argv[])
 
 	parse_options(argc, argv);
 
+	this_cpu_vendor = identify_cpu_vendor();
+
 	/* Setup the cpuid leafs of current platform */
 	for_each_cpuid_range(range)
 		setup_cpuid_range(range);
-- 
2.46.2


