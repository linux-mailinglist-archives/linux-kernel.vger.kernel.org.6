Return-Path: <linux-kernel+bounces-549839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18EA557C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175161894117
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD883277020;
	Thu,  6 Mar 2025 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WF7clCWO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/NVMlQ52"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663326BD82
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294232; cv=none; b=uSzCrtpC1k6jbS7iGpWlDHYnJ6i6qOiTWZENExXurBIH3HLNEYK2UxuZH0AVVMV6xlzS4ZSozok+nlfopzeTs8i8PHuvayejfZr22RpatZoqB0E5xYJMuYMcqVETsQGDq5SHV4iYuuHV5de0MBCZV/o3ZZXZFgvyS4adtEV7REc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294232; c=relaxed/simple;
	bh=Sj8ehWyrASLJgEund+Zuejdi3dIiwuMMC4gFlwFkq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdV/5B6pN1CJlYoU3uNEc1SJ3uypZ5DnMD/bQExt0Lc9so2Geo4LCsWGM3m6p/t2JR8wNsgikad8eWOPhLm/JlFOET/M51CjsE13XW5uI9BB9jTIZ+s4NlAD/B+IQHqhQLHvFVzAX9VgXMvwbYyeQ87VcXz/KNmKfaSkHNUqfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WF7clCWO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/NVMlQ52; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrZ9M2b7UwXQTxopgU+2U3Wtm3uX6MOzB4ctL4A5ucs=;
	b=WF7clCWOVQjZ9s3XJNMy1f0FKUFdVXB3UjbiIVvCvLqkzTL30n/L44knwiZ13HfkLW1x2Y
	K3dT2KLfktMnO2H0nSn3RNPKp5SB9mB5CEo2i59sTtuoH8coQCQuXhq9lznh3v9sAbQjdc
	zIi6Fwv/qSRl9NL8LPi/HaAOqs0jSzvgESlQ/F67uD6dtyRy6MZcm2FdnyEFP1uGg+Mvku
	9fd+j440Lz6v6DB24hH9uUcyuDVcakESM1tbofWa3QEwAFzI6gdwZqWs4AGz4o80XVrNis
	K10kImqPWzt43w6q0Id2HGUSOFfH6VznGur7rgeIN+HfUfDT5lXh1C8zK6jW2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrZ9M2b7UwXQTxopgU+2U3Wtm3uX6MOzB4ctL4A5ucs=;
	b=/NVMlQ52ZXD0VtEEm8jJklXs8XFITGOdFDY9DzM5uFbQORC1jIXZZo+r/IwYwDjYGtygpN
	mUP+SE00nw8AHpCA==
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
Subject: [PATCH v1 01/12] tools/x86/kcpuid: Fix error handling
Date: Thu,  6 Mar 2025 21:49:49 +0100
Message-ID: <20250306205000.227399-2-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error handling in kcpuid is unreliable.  On malloc() failures, the code
prints an error then just goes on.  The error messages are also printed
to standard output instead of standard error.

Use err() and errx() from <err.h> to direct all error messages to
standard error and automatically exit the program.  Use err() to include
the errno information, and errx() otherwise.  Use warnx() for warnings.

While at it, alphabetically reorder the header includes.

Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")
Closes: https://lkml.kernel.org/r/20240926223557.2048-1-rbrasga@uci.edu
Reported-by: Remington Brasga <rbrasga@uci.edu>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 47 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a95d3f..abfeecce5aa8 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
-#include <stdio.h>
+#include <err.h>
+#include <getopt.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <getopt.h>
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
@@ -145,14 +146,14 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
 		if (!func->leafs)
-			perror("malloc func leaf");
+			err(EXIT_FAILURE, NULL);
 
 		func->nr = 1;
 	} else {
 		s = func->nr;
 		func->leafs = realloc(func->leafs, (s + 1) * sizeof(*leaf));
 		if (!func->leafs)
-			perror("realloc f->leafs");
+			err(EXIT_FAILURE, NULL);
 
 		func->nr++;
 	}
@@ -211,7 +212,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range = malloc(sizeof(struct cpuid_range));
 	if (!range)
-		perror("malloc range");
+		err(EXIT_FAILURE, NULL);
 
 	if (input_eax & 0x80000000)
 		range->is_ext = true;
@@ -220,7 +221,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
-		perror("malloc range->funcs");
+		err(EXIT_FAILURE, NULL);
 
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
@@ -395,8 +396,8 @@ static int parse_line(char *line)
 	return 0;
 
 err_exit:
-	printf("Warning: wrong line format:\n");
-	printf("\tline[%d]: %s\n", flines, line);
+	warnx("Wrong line format:\n"
+	      "\tline[%d]: %s", flines, line);
 	return -1;
 }
 
@@ -418,10 +419,8 @@ static void parse_text(void)
 		file = fopen("./cpuid.csv", "r");
 	}
 
-	if (!file) {
-		printf("Fail to open '%s'\n", filename);
-		return;
-	}
+	if (!file)
+		err(EXIT_FAILURE, "%s", filename);
 
 	while (1) {
 		ret = getline(&line, &len, file);
@@ -530,7 +529,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	func_idx = index & 0xffff;
 
 	if ((func_idx + 1) > (u32)range->nr) {
-		printf("ERR: invalid input index (0x%x)\n", index);
+		warnx("Invalid input index (0x%x)", index);
 		return NULL;
 	}
 	return &range->funcs[func_idx];
@@ -562,7 +561,7 @@ static void show_info(void)
 				return;
 			}
 
-			printf("ERR: invalid input subleaf (0x%x)\n", user_sub);
+			warnx("Invalid input subleaf (0x%x)", user_sub);
 		}
 
 		show_func(func);
@@ -593,15 +592,15 @@ static void setup_platform_cpuid(void)
 
 static void usage(void)
 {
-	printf("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
-		"\t-a|--all             Show both bit flags and complex bit fields info\n"
-		"\t-b|--bitflags        Show boolean flags only\n"
-		"\t-d|--detail          Show details of the flag/fields (default)\n"
-		"\t-f|--flags           Specify the cpuid csv file\n"
-		"\t-h|--help            Show usage info\n"
-		"\t-l|--leaf=index      Specify the leaf you want to check\n"
-		"\t-r|--raw             Show raw cpuid data\n"
-		"\t-s|--subleaf=sub     Specify the subleaf you want to check\n"
+	warnx("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	      "\t-a|--all             Show both bit flags and complex bit fields info\n"
+	      "\t-b|--bitflags        Show boolean flags only\n"
+	      "\t-d|--detail          Show details of the flag/fields (default)\n"
+	      "\t-f|--flags           Specify the cpuid csv file\n"
+	      "\t-h|--help            Show usage info\n"
+	      "\t-l|--leaf=index      Specify the leaf you want to check\n"
+	      "\t-r|--raw             Show raw cpuid data\n"
+	      "\t-s|--subleaf=sub     Specify the subleaf you want to check"
 	);
 }
 
@@ -652,7 +651,7 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			printf("%s: Invalid option '%c'\n", argv[0], optopt);
+			warnx("Invalid option '%c'", optopt);
 			return -1;
 	}
 
-- 
2.48.1


