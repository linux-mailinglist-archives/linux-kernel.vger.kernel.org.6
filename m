Return-Path: <linux-kernel+bounces-256435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A05934E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14851F21085
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31A143881;
	Thu, 18 Jul 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bj1wk4v+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipOCnBt0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FD13E8AE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310502; cv=none; b=prK+W8pPwnoPXyrp9+vx8WZqHQ7GRiOzeulsFuaH0GbN3X7WTu8m7bedD7BQu8igoKxu53iz1boa1x5l2GgfJnEjUQRZrvrDSU/MRn+LdicwP6tasP7oKNlr0x+AywuPXeErB0+yTmr9Yw2eYnv7pOhmP5IhFnP4BzS5rIVUjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310502; c=relaxed/simple;
	bh=3bnhIpIPATYvjQ1WJKVL2yW74O40GkBPPq/Iy/ikT+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otZ6dWRJc+AZyFB0i97Y7Ser8kr/4tJkO5U/vSeTpNJSoCKRWTcuAbmUAbCOvo+scAx8zU0QPx/jeDW7J8L+0ixMVGb2MTlw2WhHgWh5OLhSd31T2VnuF/kp33qusIQsUTmd9PmJdcPwXtOxRerZJs4ctQliuNpKGS287lI4eCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bj1wk4v+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipOCnBt0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dosa+u3t/N5oBogRtAI7JeqNchQlS8ciUK+MeBJvoEc=;
	b=bj1wk4v+pvGVLOEprOTAuBzzlyuGHmSZobbdz4Ju7udnRV247/5xiSQQrEj0JPAgUlzylY
	GT8r2dZwtNASdistzPfuZXPsO3Uc6WyeYjyjf4YS605YmhJrL5wLrjUGT39M7AdpM2K2+L
	NsGBEBK8syXp+6MFL7TYUgesNIUPqzOGmbuJQ8bMkwEXH/uYkLsAFeHQA7LMCGwQHtki85
	B2FJFk2WWy4O1akAF0PRxtV/Hn8I9rppPNYqBo0kfE9CcRGErTxx2z4jW9v8FbzG7mgZek
	kxqmLZSVuQz1XuQPrjZGybvj3MeTQJOnlsO3LbhMZ7a2O9VjZUmjsU4a1FXUnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dosa+u3t/N5oBogRtAI7JeqNchQlS8ciUK+MeBJvoEc=;
	b=ipOCnBt0NmkiMFZ1XRP7OPwF0wy3g8oQI3WZIIQ2ReIyiln0uyuGmNwejM4Iku2RfXIvfD
	TW6ylQe5tCaN/4CA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 5/9] tools/x86/kcpuid: Strip bitfield names leading/trailing whitespace
Date: Thu, 18 Jul 2024 15:47:45 +0200
Message-ID: <20240718134755.378115-6-darwi@linutronix.de>
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

While parsing and saving bitfield names from the CSV file, an extra
leading space is copied verbatim.  That extra space is not a big issue
now, but further commits will add a new CSV file with much more padding
for the bitfield's name column.

Strip leading/trailing whitespaces while saving bitfield names.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index c93015ee02e0..ccbf3b36724f 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -381,7 +381,7 @@ static int parse_line(char *line)
 	if (start)
 		bdesc->start = strtoul(start, NULL, 0);
 
-	strcpy(bdesc->simp, tokens[4]);
+	strcpy(bdesc->simp, strtok(tokens[4], " \t"));
 	strcpy(bdesc->detail, tokens[5]);
 	return 0;
 
-- 
2.45.2


