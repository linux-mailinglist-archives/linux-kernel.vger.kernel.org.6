Return-Path: <linux-kernel+bounces-573814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075ACA6DCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FA3188C0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC5261583;
	Mon, 24 Mar 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtLt/JtF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzKnTmIE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71826157C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826071; cv=none; b=Q/tz4LPYPFjjQ2V1XmZBcrjlOjfRFRyuMMQF1i3/TRgPuY2zxNuliRqThx2feUFCetVUGPlJgipUCqL9ay3aTyeYOfb0O9zoWnCa88CB5SRYt+O1lXRFM+gNGTKrOOKkOvpXKgVxWh/PDxLQZgVFcAyFG93YhZfGBaPCVipCJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826071; c=relaxed/simple;
	bh=3y7y/+TG/coMCKwSXE98CIgHpa9wr5XS5fRq2IuwG2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq+ZZR5038O4yQhfSEF9MvXeAGz9vWGG/G5mWmeeX0+sYUDNfYzkmpC21d6Omay9WDLpQZqphXHr4mSvuQ0nmN1zdnaZBtn2MO2uMJLgAJHgV6vt1fR6YNteh2miBj+uO1TA01nw6a3eDlGsGq2/WFKYjt23z33LvgseNT2bDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtLt/JtF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzKnTmIE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIX9iztgFANy05YMRQ46LT6rBpzO+z+5MvvNejEwmuw=;
	b=rtLt/JtFXO6L88RTFXD26CZsttfYxajC8/n6P+VK7/UHjzi41MJtK5OaAhjVGj4/InaZE1
	wDd7XTSCJ180UTjhjfhGR89xLjDfOi5eOBuS3OTBSaoGR2TlAFXjfCRkQWvYrTIou3G3pB
	DvZzxPXlPocjZvEJV56T513d7D/RmSyjHjJnw/wWrq9o4T5Uiuwo4sNt3WGCukt610KBWs
	x8JDgx+dN+6oLDq8f0UHU7hk+mUpK7V1hUe68FAvUnw2iDpVyvldXeTRe+dqzRSINkalGb
	jopg3UEt4K0TTKvk71E5Y6ATbmlgcVTDs94uiRRZLEYENyGJp7NEzjgrucEOaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIX9iztgFANy05YMRQ46LT6rBpzO+z+5MvvNejEwmuw=;
	b=GzKnTmIE6D+DjQFSYT9cTauTEuPqklCyyAMc9dMd8mctoBwMBpqg1Av68dXJySI2O7/plv
	2tWvUqdITqLoM0CA==
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
Subject: [PATCH v3 07/20] tools/x86/kcpuid: Remove unused global variable
Date: Mon, 24 Mar 2025 15:20:28 +0100
Message-ID: <20250324142042.29010-8-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable "is_amd" is written to, but is not read from
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index a89da2af98e9..908f0de2d4f0 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -79,7 +79,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static bool is_amd;
 static bool show_details;
 static bool show_raw;
 static bool show_flags_only = true;
@@ -559,16 +558,6 @@ static void show_info(void)
 
 static void setup_platform_cpuid(void)
 {
-	 u32 eax, ebx, ecx, edx;
-
-	/* Check vendor */
-	eax = ebx = ecx = edx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
-
-	/* "htuA" */
-	if (ebx == 0x68747541)
-		is_amd = true;
-
 	/* Setup leafs for the basic and extended range */
 	leafs_basic = setup_cpuid_range(0x0);
 	leafs_ext = setup_cpuid_range(0x80000000);
-- 
2.48.1


