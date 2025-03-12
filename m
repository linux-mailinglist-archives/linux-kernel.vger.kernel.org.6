Return-Path: <linux-kernel+bounces-557889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D08A5DF21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5353BA73B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455424FC09;
	Wed, 12 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDttEXTT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="73tlTTqJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DC24F5A4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790278; cv=none; b=NaFTsle9JH718U5GnjJfjaJ8qesyi1nj4g74oC1r5ryru7m6CZcPsx//6B7EwqPuu/JAod6Bog+OIQlGrpjYbRNX3YakJjrstFjkYOn6dkvrXlqwZ+JcsHPeTALsk3nlOdJY/Wn/u+jvzA+IsUpIE/Ze83g6f/GgeRd9Gj18dkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790278; c=relaxed/simple;
	bh=4dO68SUYqAkwEY7UThLrLaHl7z6KmwFajAtnun0lg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqdbHv8DgqMA2N9Ifl9ENzSSSm0Z/jBVAS9AaC0kSan6PE3rfIcvmsot4CokF+3I3aDRPxBHrNyZ9t0SdUxdLX3Le6Ax8lFPnwskla93tKNkdX3bEL2EJMScbzZkD2W1V2F32lU0OLh+n9VK92KHUo5tKNuOnW2jsTN2RDE1+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDttEXTT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=73tlTTqJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHWQiTB669kI6RnmP2jWsT5HKf7kcLriNh6vDP9weFU=;
	b=hDttEXTT6wpd4ZO1SHqhJXXJhCSwGoItQutjBK04F4omrpUbdfN/ljz06k4GC7PsZdgfNr
	oRKBmGTmVJGKFWxdSfNhT2qP5Z6V4tIHZWLqwkawWvqqz5gaRzyLwGDdU3AnTxyyzpYj0e
	dKMvB4lKaVvGzC4eSoZl80QfPpkjtLGozg7wER4SZGfAoY2g2Ov0NqefbK1LggnODsJDjD
	6KxwpmnCqPrJzxPzu5Oia9ZCrt7dv5ElPMYkpQ8p3iAmDpKeV+PcsWULuqBxxDYgssYAUz
	fJmG570kKVESUk7M3zx9rcsHaWhHuF5ggDyTQTD9i1dh777cZ/M0XWHzw86keQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHWQiTB669kI6RnmP2jWsT5HKf7kcLriNh6vDP9weFU=;
	b=73tlTTqJ3jxm2v/K9GKgyhZs1LTqvP5HnYwRmp/bwhZdatkCW9N/DT2fJ+oXbb+h8o2ax3
	H6e2FQVrBYkNSJDg==
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
Subject: [PATCH v2 03/20] tools/x86/kcpuid: Simplify usage() handling
Date: Wed, 12 Mar 2025 15:37:20 +0100
Message-ID: <20250312143738.458507-4-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor usage() to accept an exit code parameter and exit the program
after usage output.  This streamlines its callers' code paths.

Remove the "Invalid option" error message since getopt_long(3) already
emits a similar message by default.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 8585c1009c8b..b760c5730c89 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -10,6 +10,7 @@
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
+#define __noreturn	__attribute__((__noreturn__))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -584,17 +585,17 @@ static void setup_platform_cpuid(void)
 	leafs_ext = setup_cpuid_range(0x80000000);
 }
 
-static void usage(void)
+static void __noreturn usage(int exit_code)
 {
-	warnx("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
-	      "\t-a|--all             Show both bit flags and complex bit fields info\n"
-	      "\t-b|--bitflags        Show boolean flags only\n"
-	      "\t-d|--detail          Show details of the flag/fields (default)\n"
-	      "\t-f|--flags           Specify the cpuid csv file\n"
-	      "\t-h|--help            Show usage info\n"
-	      "\t-l|--leaf=index      Specify the leaf you want to check\n"
-	      "\t-r|--raw             Show raw cpuid data\n"
-	      "\t-s|--subleaf=sub     Specify the subleaf you want to check"
+	errx(exit_code, "kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	     "\t-a|--all             Show both bit flags and complex bit fields info\n"
+	     "\t-b|--bitflags        Show boolean flags only\n"
+	     "\t-d|--detail          Show details of the flag/fields (default)\n"
+	     "\t-f|--flags           Specify the cpuid csv file\n"
+	     "\t-h|--help            Show usage info\n"
+	     "\t-l|--leaf=index      Specify the leaf you want to check\n"
+	     "\t-r|--raw             Show raw cpuid data\n"
+	     "\t-s|--subleaf=sub     Specify the subleaf you want to check"
 	);
 }
 
@@ -610,7 +611,7 @@ static struct option opts[] = {
 	{ NULL, 0, NULL, 0 }
 };
 
-static int parse_options(int argc, char *argv[])
+static void parse_options(int argc, char *argv[])
 {
 	int c;
 
@@ -630,9 +631,7 @@ static int parse_options(int argc, char *argv[])
 			user_csv = optarg;
 			break;
 		case 'h':
-			usage();
-			exit(1);
-			break;
+			usage(EXIT_SUCCESS);
 		case 'l':
 			/* main leaf */
 			user_index = strtoul(optarg, NULL, 0);
@@ -645,11 +644,8 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			warnx("Invalid option '%c'", optopt);
-			return -1;
-	}
-
-	return 0;
+			usage(EXIT_FAILURE);
+		}
 }
 
 /*
@@ -662,8 +658,7 @@ static int parse_options(int argc, char *argv[])
  */
 int main(int argc, char *argv[])
 {
-	if (parse_options(argc, argv))
-		return -1;
+	parse_options(argc, argv);
 
 	/* Setup the cpuid leafs of current platform */
 	setup_platform_cpuid();
-- 
2.48.1


