Return-Path: <linux-kernel+bounces-557894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180BAA5DF28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15897188B1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85202561C2;
	Wed, 12 Mar 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWsz2x7p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gaTeWF0A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84652254AF8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790294; cv=none; b=PcJEhQQVG0WYrmz2/HIXsGMY7yIFR7gY6RmcEpr5aHoPSrxxZ9Xc3goOrUmYEDcru4y4fJ4Suc/3EiahSzPoI5vKJE9VTU+kWk7LVSwNcEXBfkQXbVlu8kMijXF4EFMmFt8hdYmkboRBWTi62MoqcxaMK48/7Rb9ZRE2GurPZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790294; c=relaxed/simple;
	bh=U3FmrnZ/4s402XkrjUkox44nIGjdsllUxaqR4EvG7sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9ywctNAbCgcJh3XDTU9V13Va7WM6VZ+trmwr19fuzFIB1AIxLDESbeAJrEwG9bu2W+lDSKpsoi1LP9gfSZ+2DskOoaaCwjcPti/kMpuAvhL0C8EIUdchTjAguHnZRVIT/xjW136r9gMwYigVymnmWgmS589zuNwO2e7uNE7I5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWsz2x7p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gaTeWF0A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB5MGuGK6W7gcR2a2ltq4pCZnHfnzbng6Wl2oKZ1l8c=;
	b=HWsz2x7pbWSFn0Nyi5lZmCxfAEeSzrm54cl9VFKpxNXDIqxEntCYPlx6c9dC+k79stICxQ
	mSAsKXzVRsFfil1eF90/YxkysElzrfDBrYwaVYJOGCNwHyeyDTalzbD/A+8EEKds2R6cJR
	JY36GqL5oKP5NWdFrnmE/KxcKyStIjsdFg3n3LVw9bgOyQB7guBeQpLboaVs6w02Mu/bzN
	2KD3pwrwiYfB5ygMoBgtRQUDMzr2o6aFur42Be4aaw6XLeB23bu5Ji2CXw4wGMv90AcTWo
	a3u4yaTRVW12y8hVOHWsZXGqFxYQburxb9yEx5hzMlo1pJOYM0XYM5CrhOI0Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB5MGuGK6W7gcR2a2ltq4pCZnHfnzbng6Wl2oKZ1l8c=;
	b=gaTeWF0Al7dnSL4qWC9SBSfno/89YaqJ5qE62wSCIr42HvWRUQ+LqOkRCzHWnD9M8OsNop
	TTIALH3exD3BQ0AA==
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
Subject: [PATCH v2 08/20] tools/x86/kcpuid: Set function return type to void
Date: Wed, 12 Mar 2025 15:37:25 +0100
Message-ID: <20250312143738.458507-9-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_line() returns an integer but its caller ignored it. Change the
function signature to return void.

While at it, adjust some of the "Skip line" comments for readability.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 908f0de2d4f0..1db2c8d7cf27 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -277,7 +277,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
  *	0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
  *	1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
  */
-static int parse_line(char *line)
+static void parse_line(char *line)
 {
 	char *str;
 	int i;
@@ -307,7 +307,7 @@ static int parse_line(char *line)
 
 	/* Skip comments and NULL line */
 	if (line[0] == '#' || line[0] == '\n')
-		return 0;
+		return;
 
 	strncpy(buffer, line, 511);
 	buffer[511] = 0;
@@ -330,16 +330,15 @@ static int parse_line(char *line)
 	else
 		range = leafs_basic;
 
-	index &= 0x7FFFFFFF;
 	/* Skip line parsing for non-existing indexes */
+	index &= 0x7FFFFFFF;
 	if ((int)index >= range->nr)
-		return -1;
+		return;
 
+	/* Skip line parsing if the index CPUID output is all zero */
 	func = &range->funcs[index];
-
-	/* Return if the index has no valid item on this platform */
 	if (!func->nr)
-		return 0;
+		return;
 
 	/* subleaf */
 	buf = tokens[1];
@@ -352,11 +351,11 @@ static int parse_line(char *line)
 		subleaf_start = strtoul(start, NULL, 0);
 		subleaf_end = min(subleaf_end, (u32)(func->nr - 1));
 		if (subleaf_start > subleaf_end)
-			return 0;
+			return;
 	} else {
 		subleaf_start = subleaf_end;
 		if (subleaf_start > (u32)(func->nr - 1))
-			return 0;
+			return;
 	}
 
 	/* register */
@@ -389,12 +388,11 @@ static int parse_line(char *line)
 		strcpy(bdesc->simp, strtok(tokens[4], " \t"));
 		strcpy(bdesc->detail, tokens[5]);
 	}
-	return 0;
+	return;
 
 err_exit:
 	warnx("Wrong line format:\n"
 	      "\tline[%d]: %s", flines, line);
-	return -1;
 }
 
 /* Parse csv file, and construct the array of all leafs and subleafs */
-- 
2.48.1


