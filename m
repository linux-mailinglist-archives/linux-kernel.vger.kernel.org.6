Return-Path: <linux-kernel+bounces-573830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB2A6DCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33FA3AF994
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B9263C9E;
	Mon, 24 Mar 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UtNKb9pu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPZjC/se"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDA263F21
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826112; cv=none; b=qIYkfe0X9FCP1JW3f5C3iq4tIUo/e1PhERYzI3iplakC6TLV0XVJE5tKsOcE38+YFQLR0YP00wVqQvfUyikFvcOvraspj+l8YicZ+rNS0G6Il9PzxXTayvhb4DUHP9HTyvqPg2dRltc5UV0iYgb182AIa7HMwNnikQMDVP9iM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826112; c=relaxed/simple;
	bh=orEF3ElbFiE+HwWTPI0u5RxMzDv56Yxx3YBuRtJzP9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCKXVYLGW47g6LDIrJxHSVh0kdasSlvsS000zPjaKnwUVM6QQyinwN2bV5aerBfIjO4vak/xCKyNOtVNdknmrjx4/d3BM4uCRHRf8XpeakhkV/m81LUkLPlGSrFHVc30vhT/m6365kDjw/KYH4ZUMfGiLIeEYb5Sf31WQ3qIicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UtNKb9pu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rPZjC/se; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uvV+fE9cnvutiFe3bOPEKqMevSmxtNJHCBehIzVQ3U=;
	b=UtNKb9puDACp0Qt0bmU6pNAVy6dwNZD5kbDhagiZq4H9cQzOkvOkYAZhyyZAIahQd2luJU
	G+DCMuu3fQd3/owZ7GpZ4sL4I6BUjYQ57p3GpjU2+5u6iyhrp/zDwiEj8dkpvJK39q81ZK
	Hawd4XFMY3ww0liCnEYXnFLyGJ52Q0wYtBLbF+WhFDSOIA0I9g4AKPws2lW4PLyk6/CFg2
	ZISFQloa3Ssz1dh590FM/le8qQVfwPGQGtLo5xPSbNbnKIohrF5jJE2TwXKB6YJ7IJvp3V
	l72kHVgcrhif1N0MMICfRjR3cet2TP0fBoKJQo7STp0ATBgZ6wAqCTmMruZrhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uvV+fE9cnvutiFe3bOPEKqMevSmxtNJHCBehIzVQ3U=;
	b=rPZjC/seXPq7JTz0kIsF2hkbPgfSFpdh2QO3sIF377fwmLsz0gOe9nkImYvr+VUbSb2flu
	oyfEgDFCwj0SNjBw==
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
Subject: [PATCH v3 20/20] MAINTAINERS: Include kcpuid under X86 CPUID DATABASE
Date: Mon, 24 Mar 2025 15:20:41 +0100
Message-ID: <20250324142042.29010-21-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcpuid's CSV file is covered by the "x86 CPUID database" MAINTAINERS
entry.  Recent patches have shown that changes to that file may require
updates to the kcpuid code, so include the whole of tools/x86/kcpuid
under the same entry.

This also ensures that myself and the x86-cpuid mailing list are CCed on
future kcpuid patches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..2a7b54b83052 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25713,7 +25713,7 @@ R:	Ahmed S. Darwish <darwi@linutronix.de>
 L:	x86-cpuid@lists.linux.dev
 S:	Maintained
 W:	https://x86-cpuid.org
-F:	tools/arch/x86/kcpuid/cpuid.csv
+F:	tools/arch/x86/kcpuid/
 
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>
-- 
2.48.1


