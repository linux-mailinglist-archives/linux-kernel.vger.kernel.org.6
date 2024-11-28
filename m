Return-Path: <linux-kernel+bounces-425121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 856959DBD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151D7B22A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8A1CC88A;
	Thu, 28 Nov 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0xU6yN2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZDIssCT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBC1C760A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833060; cv=none; b=AKj5/OEMstfhBN/STiA+nBN3JfGZa2IpOpJJaOcjXMPzE6pXpBE12sIOoCDSMffRLmmCvdxpSt9Oh9GBYE3IqhucLoYmf9Zms83W7Qeftil8xhnL4LnS/50spmmsVOnUem085e8ocANuttt/0vRk9o5y+Am40D4zAWBGXVOcUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833060; c=relaxed/simple;
	bh=7yfsx9umgJEwmzn7IyrywWo5n0hNfH4QCALT0PYiz4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO/ju0lmLvJh2Ve67oqUBAHhUe+uPnwQ0sNMt03juiSVAXDnasM2k0wzmXHRuSh3YSDOsm1JJv/nhTWp/3wZEkiwDbetIhuuTDjkk2SEXFXhPkWZlZrGMWU9WoBxS1GTESz+2x1Gwt4sOEDRbCMbdHYeSCx7uB7Dj2kLjSkkOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0xU6yN2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZDIssCT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D06RX2KzUMmEivATJHBJLOB3vqBKk+5nvdsg+oOA1+k=;
	b=j0xU6yN2YFSq1AoUgq8mcO5YaXsR023+trmXQaRnM5hO42nyjedSPS2XgfSlSqP3nIy4Uh
	Z8Wi5ZzENXRGZOgZW3CHwbedZ4/hPSim3x8rf0D433atNf4qwAFZFsaNPLPb3hacy3saS6
	OXePDjht5UNXkS6zezzeLEvzrOstSN8U88/S46iCDECcNxVU2KRd+YGpkeVMlavXtCGOD3
	Ni27EauO7s7IZBAqviJJWOr5dmQUss75QAxz+RyRVxBDEwrXd7iiiQVREhJ8ZBTCqjbp0E
	ORBrloZMDLN8AimLRdXpWGHde3P+B86N4uiPHCdQ+ggDa5peYBh2mKpWyGkSXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D06RX2KzUMmEivATJHBJLOB3vqBKk+5nvdsg+oOA1+k=;
	b=iZDIssCT+vPDApigcQELkkpLrNA2uhSWnJZX9eJPsWVuPuJYzk11AQVNJICIezkdh/2g2F
	/2mD+6MZUVcHI4Bw==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 10/13] tools/x86/kcpuid: Scan valid cpuid ranges only
Date: Thu, 28 Nov 2024 23:29:45 +0100
Message-ID: <20241128222948.579920-11-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcpuid works in two runs: one run for invoking cpuid instructions and
saving all output in-memory, and another run for parsing that in-memory
output using the CSV bitfields specification.

CPU vendor detection was just added in previous commits.  In both kcpuid
runs, it makes no sense to deal with cpuid ranges that are not valid for
the current CPU.

Avoid ugly "is range valid for CPU?" conditionals throughout the code by
modifying the for_each_cpuid_range() macro to iterate over cpuid ranges
that are only known to be valid for the current CPU.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 9769da3e4494..f798c909c7b2 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -119,7 +119,9 @@ static char *range_to_str(struct cpuid_range *range)
 
 #define for_each_cpuid_range(range)				\
 	for (unsigned int i = 0;				\
-	     i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]);	\
+	     i < ARRAY_SIZE(ranges)		&&		\
+		     ((range) = &ranges[i])	&&		\
+		     (range->vendors & this_cpu_vendor);	\
 	     i++)
 
 struct cpuid_range *index_to_cpuid_range(u32 index)
-- 
2.46.2


