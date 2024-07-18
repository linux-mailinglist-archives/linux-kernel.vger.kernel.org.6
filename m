Return-Path: <linux-kernel+bounces-256437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340D934E80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8656D1C22665
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075D1448C6;
	Thu, 18 Jul 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xmoymz7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43CymuwJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9A13E88B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310506; cv=none; b=i21WD7uIvm3NJ158Opxc/KRhQLVbM8w6AhF6ewvYtC45T6BoXyF+D+dHi+X2l3oLorixWrIsPHDFyeXETd6J5wk6Aq0qFJFDrkdsgTiR0b5LK7/pSAkyg6RlMSfRRxERZR7o93vCEAlBx0WzakVNHuuEBp6r8q07vF1jP/IqwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310506; c=relaxed/simple;
	bh=OOTpUM8hhqy1KXrLRcwqprmY1TDDOxn6rAHfKP7MTQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJjxwhNEe9PVjGygiOh94QHiwdAGqdY/9740uXmGYkLO6rphqVoPa1wRnHjKYmjTWFPPBO8pOHPeZb3afOaKA9agiGYKZKjGNzRBnP5swMQJms8Jv6LtiY468FdnTd6Ebw2Pbv4B95YRugNXyI2AE8TmCOCwVE6wM8xxQX+QieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xmoymz7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43CymuwJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nh3LDCA/zxyfmQviVCKs8MIpfCuX+Z1MRa25LfO8bGY=;
	b=Xmoymz7Gdraf8PrFInCcWxzhzMIf9DzldEGL404TTFXUsfbLZy5h9sPviND2kL4PacaytR
	wB7jQYWnRJltrVyKq7UkNGFZSrnfwtbOqtDxdUfzbxIIIoPdwr4udNiofaMmoskTmTOBzF
	dzfgT3r9xUeBzsengkA9r/d569gJ9uEyGhJeJCf1dI96dyidCl5Y1zIsxWlAk1dM56K5qO
	0I91IbqO8DcJzemSyKKmhj5qY1vnoCwUFaZbpEFxHQunk3ctYeQGbJXpflgsIJfygGl1T4
	Mm19Cr0B5+BL2Im5lqch513Zcy/TYbh8lYC2LffOWvhJa0L9zM1lvaH08+BehA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nh3LDCA/zxyfmQviVCKs8MIpfCuX+Z1MRa25LfO8bGY=;
	b=43CymuwJBuUEkFxJpj5oMTX9npWECbUVnKFx0y1Ri9Hm5ucnnXvh6iXkKrK7k9gaSRe/P0
	A39YFd9sRiXqazCA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 7/9] tools/x86/kcpuid: Parse subleaf ranges if provided
Date: Thu, 18 Jul 2024 15:47:47 +0200
Message-ID: <20240718134755.378115-8-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a common pattern in cpuid leaves to have the same bitfields format
repeated across a number of subleaves.  Typically, this is used for
enumerating hierarchial structures like cache and TLB levels, CPU
topology levels, etc.

Modify kcpuid.c to handle subleaf ranges in the CSV file subleaves
column.  For example, make it able to parse lines in the form:

 # LEAF, SUBLEAVES,  reg,    bits,    short_name             , ...
    0xb,       1:0,  eax,     4:0,    x2apic_id_shift        , ...
    0xb,       1:0,  ebx,    15:0,    domain_lcpus_count     , ...
    0xb,       1:0,  ecx,     7:0,    domain_nr              , ...

This way, full output can be printed to the user.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 50 ++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index beb4fde48145..c321db86750b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -307,6 +307,8 @@ static int parse_line(char *line)
 	struct bits_desc *bdesc;
 	int reg_index;
 	char *start, *end;
+	u32 subleaf_start, subleaf_end;
+	unsigned bit_start, bit_end;
 
 	/* Skip comments and NULL line */
 	if (line[0] == '#' || line[0] == '\n')
@@ -345,13 +347,25 @@ static int parse_line(char *line)
 		return 0;
 
 	/* subleaf */
-	sub = strtoul(tokens[1], NULL, 0);
-	if ((int)sub > func->nr)
-		return -1;
+	buf = tokens[1];
+	end = strtok(buf, ":");
+	start = strtok(NULL, ":");
+	subleaf_end = strtoul(end, NULL, 0);
+
+	/* A subleaf range is given? */
+	if (start) {
+		subleaf_start = strtoul(start, NULL, 0);
+		subleaf_end = min(subleaf_end, (u32)(func->nr - 1));
+		if (subleaf_start > subleaf_end)
+			return 0;
+	} else {
+		subleaf_start = subleaf_end;
+		if (subleaf_start > (u32)(func->nr - 1))
+			return 0;
+	}
 
-	leaf = &func->leafs[sub];
+	/* register */
 	buf = tokens[2];
-
 	if (strcasestr(buf, "EAX"))
 		reg_index = R_EAX;
 	else if (strcasestr(buf, "EBX"))
@@ -363,23 +377,23 @@ static int parse_line(char *line)
 	else
 		goto err_exit;
 
-	reg = &leaf->info[reg_index];
-	bdesc = &reg->descs[reg->nr++];
-
 	/* bit flag or bits field */
 	buf = tokens[3];
-
 	end = strtok(buf, ":");
-	bdesc->end = strtoul(end, NULL, 0);
-	bdesc->start = bdesc->end;
-
-	/* start != NULL means it is bit fields */
 	start = strtok(NULL, ":");
-	if (start)
-		bdesc->start = strtoul(start, NULL, 0);
-
-	strcpy(bdesc->simp, strtok(tokens[4], " \t"));
-	strcpy(bdesc->detail, tokens[5]);
+	bit_end = strtoul(end, NULL, 0);
+	bit_start = (start) ? strtoul(start, NULL, 0) : bit_end;
+
+	for (sub = subleaf_start; sub <= subleaf_end; sub++) {
+		leaf = &func->leafs[sub];
+		reg = &leaf->info[reg_index];
+		bdesc = &reg->descs[reg->nr++];
+
+		bdesc->end = bit_end;
+		bdesc->start = bit_start;
+		strcpy(bdesc->simp, strtok(tokens[4], " \t"));
+		strcpy(bdesc->detail, tokens[5]);
+	}
 	return 0;
 
 err_exit:
-- 
2.45.2


