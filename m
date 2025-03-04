Return-Path: <linux-kernel+bounces-543555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD80A4D706
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6B3AFAD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0D1FF1A3;
	Tue,  4 Mar 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L72zysiZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ff5CIIAX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B21FECDF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078372; cv=none; b=bR8u6q03k/TA46r7otm+kW8cNzaF14m5+1Z29DiFZtmjTa7U2lrm2aIHnGxo3wVtQcFAFFFq/SBSWJZabSORAv7lsWuCIkNm72E6GAdXIsjzrpvgkk3M3ODAb6q0eo6kJLJrPWxdM3twdp0mV/Nr72zW9zUCMvzxPX9gGIfyE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078372; c=relaxed/simple;
	bh=ka6KnAwJyLF+pZAcSuUypA3tLRXWbzf3/ahC0RCkJ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoA+QU3Aoq2HcPfaJij15cJihSw7iFYVbWjClB8IzXeMR+spYxPDsOuHYHs24WjEFK+9FE46DES8fnJGEGRBPidca1PXEPYT9HNwM6vQ85ZoX5dIj0CBiwFGWBrKROjrnygq0Kb3dsii40cMpOiYA7g1XhmRp+UHQ8CwGDhoYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L72zysiZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ff5CIIAX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBenYQvYHCMUAVdV1uDeDm0GAHb1Xqw9kFWAtKQ364A=;
	b=L72zysiZeaquGuhk+c8CdDE7BL5EPdJhAPttcsoqRp9u/+JsaqW7ryjdTRA42uRIxLOHf7
	exb6nWsPVtuei4T9maGlc7asHWTKKkLjW4iGi9ULpqOpYivH+Mdm0tcyaIXoe90cl7AJlp
	ZelzZ6rF/HCo9gkayseqkCaKJIgM/rDNE811KVtFJxfXOfFrO4O9XNWtM+IPj9qPkFyWXI
	H+OIII6CkUhASy4+WoVyGYyMrzdQyKQH8o/113q/41VehY8DSdAX+Ws6gG8UR/6KiruGnJ
	wPC73FY/X+OGDXzUwvVOdguIzJYlAFnsFZi1Fa4fGTmqL1Lu/ZvXNOdvXY3Mxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBenYQvYHCMUAVdV1uDeDm0GAHb1Xqw9kFWAtKQ364A=;
	b=ff5CIIAXtWGu/8dy6eRsJTD1pRl8ogujd3bMgPJNNHrWZKhrWZVyrXOqgAAO/BnBfeWk/e
	1/Ih/8rkjpCZDUCA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 12/40] x86/cacheinfo: Remove unnecessary headers and reorder the rest
Date: Tue,  4 Mar 2025 09:51:23 +0100
Message-ID: <20250304085152.51092-13-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the headers at cacheinfo.c that are no longer required.

Alphabetically reorder what remains since more headers will be included
in further commits.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index eccffe2ea06c..b3a520959b51 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -8,21 +8,19 @@
  *	Andi Kleen / Andreas Herrmann	: CPUID4 emulation on AMD.
  */
 
-#include <linux/slab.h>
 #include <linux/cacheinfo.h>
+#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
-#include <linux/sched.h>
-#include <linux/capability.h>
-#include <linux/sysfs.h>
 #include <linux/pci.h>
 #include <linux/stop_machine.h>
+#include <linux/sysfs.h>
 
-#include <asm/cpufeature.h>
-#include <asm/cacheinfo.h>
 #include <asm/amd_nb.h>
-#include <asm/smp.h>
+#include <asm/cacheinfo.h>
+#include <asm/cpufeature.h>
 #include <asm/mtrr.h>
+#include <asm/smp.h>
 #include <asm/tlbflush.h>
 
 #include "cpu.h"
-- 
2.48.1


