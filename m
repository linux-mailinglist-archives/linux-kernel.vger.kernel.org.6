Return-Path: <linux-kernel+bounces-425114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB949DBD99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D6B22F10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258951C82F1;
	Thu, 28 Nov 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VapD0n1s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwiCF1Md"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4C1C6F43
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833038; cv=none; b=PoYh2pYqv7G9vOoYHupw+TlKGHeU/mtxgdlK8FUsxnqTJhZezySsPMfRF6wD1CZdN+ilhfkR9JrMHvqir/26yVME83dNKf18UAcMocarliSR+9+gDhZH+MjqgqxD0GdkuAx8l01GYJmJFhvEezgjYpwFiHW/Ac7g0Mx9/8JtZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833038; c=relaxed/simple;
	bh=et53JOXTJFJ5g5vIa2M9xdCwGZiKx9tOeM/e2fPpGB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoghhqZkBEvHB45ND/GLrZH6VrppGkPKOYcYScCR58fh7ZUnO5dKjmQkfk9CUAV7Ku//wS2EauA/NG9nJYNM4SgIDXS0tzQYTiFAA0n1b08f3OFcplUFXHWSabHlz/YpKzLVg3CsQ6lR/HtAOvVpKP8/UdIwkH1EgCxUPlBcvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VapD0n1s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwiCF1Md; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STB9Xp8RPHykOZtZUboSY9JLbUrK76OO1irMSu8LVzM=;
	b=VapD0n1sCaLqPkSNa3y3+ovhZliC9ifDShqRsRMEBNMOpiR/T+yK21SnGdqJET6M5jp+jW
	cOsK47UaBbOPslOxkFD/vw+1P48LXklCbhjmBa6XhJECw4/eMJdEwbYCS/wgS87IBXDeuf
	eJbOaFy//bs7b65VjdsCJvJ4aJvuk3MN5UljB8jaEsaBt0JhR4cb9DEpd9A72joUz6Q0Ri
	scCSofKK3GV8Ov5fvjqOhnJl6zzagt2pKBE4HMMzvEdr1M+SgRk0a3HbRQKMHVljbSrsA7
	Q0yYlLmIWXeKFlNC8gpNWJjjN8KKaGTvLbHgXvUGjm9l/NEKf323cjVdKKFbpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STB9Xp8RPHykOZtZUboSY9JLbUrK76OO1irMSu8LVzM=;
	b=WwiCF1MdemDbTxJ4oD3BYYDYVWXHeZUdIsZBQczNqn9nRHwZc7tRVUFLpJisHg71kc1QYS
	tGwBmLSld2b5/1Dg==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 03/13] tools/x86/kcpuid: Fix error handling
Date: Thu, 28 Nov 2024 23:29:38 +0100
Message-ID: <20241128222948.579920-4-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error handling in kcpuid is unreliable:

  - on malloc() failures, the code prints an error then just goes on.

  - Error messages are printed to standard output, and thus getting
    mixed with cpuid flags listings.

Introduce pr_err() and pr_warn() to automatically direct error and
warning messages to standard error.  Use such macros throughout the
code.

Introduce pr_err_exit(), which is like pr_err(), but with the addition
of process termination through exit(3).  Use pr_err_exit() in case of
malloc() failures; further commits will utilize it further.

Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")
Reported-by: Remington Brasga <rbrasga@uci.edu>
Closes: https://lkml.kernel.org/r/20240926223557.2048-1-rbrasga@uci.edu
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 54 +++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 62a77509a5b5..1ec60c892206 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
+#include <errno.h>
 #include <getopt.h>
+#include <stdarg.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -111,6 +113,36 @@ static inline bool has_subleafs(u32 f)
 	return false;
 }
 
+/**
+ * pr_err - Print passed error message to stderr
+ */
+static void pr_err(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+}
+
+/**
+ * pr_warn - Print passed warning message to stderr
+ */
+#define pr_warn(...)		pr_err(__VA_ARGS__)
+
+/**
+ * pr_err_exit - Print passed error message to stderr, then exit
+ *
+ * @ecode:	One-byte exit code.  errno can be passed here as
+ *		the passed value is quickly cached.
+ */
+#define pr_err_exit(ecode, ...)	do {	\
+	int __ecode = (ecode);		\
+					\
+	pr_err(__VA_ARGS__);		\
+	exit(__ecode);			\
+} while (0)
+
 static void leaf_print_raw(struct subleaf *leaf)
 {
 	if (has_subleafs(leaf->index)) {
@@ -145,14 +177,14 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
 		if (!func->leafs)
-			perror("malloc func leaf");
+			pr_err_exit(errno, "malloc func leaf");
 
 		func->nr = 1;
 	} else {
 		s = func->nr;
 		func->leafs = realloc(func->leafs, (s + 1) * sizeof(*leaf));
 		if (!func->leafs)
-			perror("realloc f->leafs");
+			pr_err_exit(errno, "realloc f->leafs");
 
 		func->nr++;
 	}
@@ -211,7 +243,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range = malloc(sizeof(struct cpuid_range));
 	if (!range)
-		perror("malloc range");
+		pr_err_exit(errno, "malloc range");
 
 	if (input_eax & 0x80000000)
 		range->is_ext = true;
@@ -220,7 +252,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
-		perror("malloc range->funcs");
+		pr_err_exit(errno, "malloc range->funcs");
 
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
@@ -395,8 +427,8 @@ static int parse_line(char *line)
 	return 0;
 
 err_exit:
-	printf("Warning: wrong line format:\n");
-	printf("\tline[%d]: %s\n", flines, line);
+	pr_warn("Warning: wrong line format:\n"
+		"\tline[%d]: %s\n", flines, line);
 	return -1;
 }
 
@@ -419,7 +451,7 @@ static void parse_text(void)
 	}
 
 	if (!file) {
-		printf("Fail to open '%s'\n", filename);
+		pr_err("Fail to open '%s'\n", filename);
 		return;
 	}
 
@@ -530,7 +562,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	func_idx = index & 0xffff;
 
 	if ((func_idx + 1) > (u32)range->nr) {
-		printf("ERR: invalid input index (0x%x)\n", index);
+		pr_err("ERR: invalid input index (0x%x)\n", index);
 		return NULL;
 	}
 	return &range->funcs[func_idx];
@@ -562,7 +594,7 @@ static void show_info(void)
 				return;
 			}
 
-			printf("ERR: invalid input subleaf (0x%x)\n", user_sub);
+			pr_err("ERR: invalid input subleaf (0x%x)\n", user_sub);
 		}
 
 		show_func(func);
@@ -593,7 +625,7 @@ static void setup_platform_cpuid(void)
 
 static void usage(void)
 {
-	printf("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	pr_err("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
 		"\t-a|--all             Show both bit flags and complex bit fields info\n"
 		"\t-b|--bitflags        Show boolean flags only\n"
 		"\t-d|--detail          Show details of the flag/fields (default)\n"
@@ -652,7 +684,7 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			printf("%s: Invalid option '%c'\n", argv[0], optopt);
+			pr_err("%s: Invalid option '%c'\n", argv[0], optopt);
 			return -1;
 	}
 
-- 
2.46.2


