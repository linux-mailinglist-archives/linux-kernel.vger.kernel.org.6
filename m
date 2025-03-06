Return-Path: <linux-kernel+bounces-549840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B669BA557CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79CB3A64C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719827811E;
	Thu,  6 Mar 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUJhaMeJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljn5aK4R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963EC2777FD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294235; cv=none; b=QGy5NfN37JjMGjor/sWmqlO60onXkTitTdDPzmNN+DgidBLYk/H7j7r99CgnSqK+SD2CMJVkGfrGig7J23wgboufOBIeC48enRZCaPGo2l46GGryxGgGZbSK7/fKvhPqrHOeYjNeQGZJ/pNKIqqpgs/TyGBPvLczzDLZFx7oYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294235; c=relaxed/simple;
	bh=48MXf2D3f+m/CXIPCWPp+NC0YZqPpT13wi5sfchvN9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl9mXo5DvvyGH3qAl2SRHhHONoNVgZWr/GgturjnzHCoMkwYmQLjdMn87OciMH2W8w2oh+pgTLoc9ubs2xh871V1qUEoZ7GWf6ekeh2G9gfrW944n8z/xwnYucyyuZivho0L9TfYO+vDtqlcjvhjXZnoYY2wgSDXiXBHKM2rG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HUJhaMeJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljn5aK4R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiiSrcFhoCWM+cN6vIlMkn6419ep59GqZWiwARwlvYk=;
	b=HUJhaMeJ8wm0v1+tstI9jT/Q96oSyxCQrshHGHEeaw3OwF0P2Ntl8tQT6ifCSYQkphtzCD
	yRlZ1eFOM1/oninBrBZ2l3rmtcAJxX6J7/aQH6Bcbyn7/SIbXqIDjmrtVUSC34WsR3RqS/
	3ZTCde1yzopLXo3uq4YJwcVjT0Zn8S67vU1oi19amrYtA0upk5WDTupHdjBObZMv8XzVfJ
	MJbFY2hWJF5CAnhVbBcOpKR/Sn+ybHGELkrdZmxAKbok68vu1NIxV493H+R1KKB2kOTlkk
	7mo+F0upqIWl/xI89CYNDh4rEYkawz1aHxlpb0GE+LGPbQ9tW56oTw4bA8g5Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiiSrcFhoCWM+cN6vIlMkn6419ep59GqZWiwARwlvYk=;
	b=ljn5aK4RrcOO0HPsO5A32TGgqTsxv8NCfHYpNwXLQCb7QzS3HQ1S2EluJxyFzO0n8VLnLy
	kdNu8+YgQwS+3RBw==
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
Subject: [PATCH v1 04/12] tools/x86/kcpuid: Simplify usage() handling
Date: Thu,  6 Mar 2025 21:49:52 +0100
Message-ID: <20250306205000.227399-5-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor usage() to accept an exit code parameter and exit the program
after usage printing.  This streamlines its callers' code paths.

Remove the "Invalid option" error message since getopt_long(3) already
emits a similar message by default.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index ceed560cd8a3..c5e18a397e07 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -10,6 +10,7 @@
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
+#define __noreturn	__attribute__((__noreturn__))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -575,17 +576,17 @@ static void setup_platform_cpuid(void)
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
+	err(exit_code, "kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	    "\t-a|--all             Show both bit flags and complex bit fields info\n"
+	    "\t-b|--bitflags        Show boolean flags only\n"
+	    "\t-d|--detail          Show details of the flag/fields (default)\n"
+	    "\t-f|--flags           Specify the cpuid csv file\n"
+	    "\t-h|--help            Show usage info\n"
+	    "\t-l|--leaf=index      Specify the leaf you want to check\n"
+	    "\t-r|--raw             Show raw cpuid data\n"
+	    "\t-s|--subleaf=sub     Specify the subleaf you want to check"
 	);
 }
 
@@ -601,7 +602,7 @@ static struct option opts[] = {
 	{ NULL, 0, NULL, 0 }
 };
 
-static int parse_options(int argc, char *argv[])
+static void parse_options(int argc, char *argv[])
 {
 	int c;
 
@@ -621,9 +622,7 @@ static int parse_options(int argc, char *argv[])
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
@@ -636,11 +635,8 @@ static int parse_options(int argc, char *argv[])
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
@@ -653,8 +649,7 @@ static int parse_options(int argc, char *argv[])
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


