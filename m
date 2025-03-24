Return-Path: <linux-kernel+bounces-573810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CCA6DCCA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06516188A7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F1261373;
	Mon, 24 Mar 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eII7KQWb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37n/eOJ9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C325FA3B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826058; cv=none; b=QkOIrksEOCbfh9zEIiUPd8mkXmfgpQlQk2ueqFEBxiOlbbNdzzph8EBX15kHO+NaJocOuOrmJO8MjDoIdlrFK9bRt1DwX67qqJ5uI/povbN1F0EhyK+s+Buo02QL0fynvA9kEUgiIDM98NszlaUH4O4RN66AuMDMeMoAKkuKHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826058; c=relaxed/simple;
	bh=4dO68SUYqAkwEY7UThLrLaHl7z6KmwFajAtnun0lg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKL2bmOHd93r9W1VzuHvd8F5/fSS3dsokZwFKkalwzwqrvOolDc2Kmz2s0hhNyu9yTRWEQq9agrixizuwouWYBPHG1gw2GZPzS304J1/UAZaydD46ZEbUrwqAvmFBjT7Qf0lxqSzXA4qjnOFz+4KonD5t2gmC2eRvk4n6VgN720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eII7KQWb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37n/eOJ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHWQiTB669kI6RnmP2jWsT5HKf7kcLriNh6vDP9weFU=;
	b=eII7KQWbKbjKeareonnC8mm29Z2h72sgKpTB7qRLwI1+1grGrIfsVW976DC2fHHRjMEEmK
	Z4WUPuqVDLApPCqef1H8cvZ6lDseGrv16wpARfiOPvhpJNmLxf/qEPTWmWzJy0mBqbTPmH
	ExnpUPBZSTFIA8ozLuWOcachLlRKF+9RCYB7arFrkbxuZru16ELucju8HXVD6Z4BuzrCwQ
	/OqV6llM2a3Z+RyPrQzYDVGAJd//oqH9nqqbVo3sl2dOfEcK9pmhbxzkmSKSe6cwFLlZbQ
	y68x6sowGa3lIbRvUE2knQkgeal3kLCkS2+L57Oulzjyji7tp3h/p6a0eoLTtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHWQiTB669kI6RnmP2jWsT5HKf7kcLriNh6vDP9weFU=;
	b=37n/eOJ9c8RImhbDyUcADvABB3ILtWIq6byOPRhhGQpV8B9Ytu5pUEi29gkAI+CvwzeKnV
	6JCv/Sqee2dcHqCw==
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
Subject: [PATCH v3 03/20] tools/x86/kcpuid: Simplify usage() handling
Date: Mon, 24 Mar 2025 15:20:24 +0100
Message-ID: <20250324142042.29010-4-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
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


