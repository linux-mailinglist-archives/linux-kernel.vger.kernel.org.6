Return-Path: <linux-kernel+bounces-543548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DCA4D6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25F81740E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBB1FCFFB;
	Tue,  4 Mar 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYm5Ig67";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vc/f4lqp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC81FCFF3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078351; cv=none; b=uOsT7zfgUYLVkuo9DucNwpxIUTPp8MUGhZCkEf9srXwrcubgwsGV6KZ587kYqCLvSMtP/vnR0rkx2LIMlgjKssGTvPCHf0VW8ovJWJeSyYp+tQz8W878XhXU4b8igK4LA2nc+GT25P76iPeIrIYyQJg2FnU1TI8UtkHMzvJv1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078351; c=relaxed/simple;
	bh=TtkjCaEfovdST0vQ/3l+CT6q0XDurgzYkizr7i+OBGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5+tMkL6Q/pa62ujLwdC55krmI/iqpo/740XL7PXStJc8i+fckHfLxr4SROZD26nT4qLAk3nHPnRo3PALTbeA9IHXl55g6dacQTn4KbAzxmN8pf72spyy1NHMxVwcdKz4veJKwPGVYJsatKvBQcr6mYkskt7W3WAk+J1/8dsA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYm5Ig67; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vc/f4lqp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yF4ckw4bp1d8zZFTp92YozOjejKXwsco3zqZ2FJcqLM=;
	b=wYm5Ig67OoGCCtfh53NPxUaGJ9jM8G0PVyiAoAvFMJKIT1vN0BI2Gu4HBWHHF/2GmR6ZQE
	XK7hqoQ5h6wjPUaNstrKRcXoUrkaaO2QeFQ4Wy+fGqbD3HaSk2VKvv7Ae3BqHksDbFHDWv
	Uvr/bX5OU0U4C2oLxPD/ozNaMqE5KDOS+aLAw7EbLwq8hoYGR2YqatUwfzzvQmwdgo7L/U
	wJG91jiiMXaGB+4O3D/5hJJf/gRlRVg8aCCv9I/1EkjHA2iFw5DdDqyhJTI1uPHZGV2PhZ
	XfuQ7mTpCel4a/CvdDjhsWpJoCALZRgSq28urRdDrgual5fk8hq7vSFVuV4yEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yF4ckw4bp1d8zZFTp92YozOjejKXwsco3zqZ2FJcqLM=;
	b=vc/f4lqpJTv7MldpX5Pc3umWonX2Wi0uMAlw+NuMKhUtfhFxdJ/NqNcppMipMGobjz9Wd7
	JUCqkyThVmbPzQBA==
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
Subject: [PATCH v1 05/40] x86/cpu: Remove unnecessary headers and reorder the rest
Date: Tue,  4 Mar 2025 09:51:16 +0100
Message-ID: <20250304085152.51092-6-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the headers at intel.c that are no longer required.

Alphabetically reorder what remains since more headers will be included
in further commits.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 134368a3f4b1..72f519534e2b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1,40 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/pgtable.h>
 
-#include <linux/string.h>
 #include <linux/bitops.h>
-#include <linux/smp.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
-#include <linux/thread_info.h>
 #include <linux/init.h>
-#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+
+#ifdef CONFIG_X86_64
+#include <linux/topology.h>
+#endif
 
-#include <asm/cpufeature.h>
-#include <asm/msr.h>
 #include <asm/bugs.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu.h>
+#include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
-#include <asm/hwcap2.h>
-#include <asm/elf.h>
-#include <asm/cpu_device_id.h>
-#include <asm/resctrl.h>
+#include <asm/msr.h>
 #include <asm/numa.h>
+#include <asm/resctrl.h>
 #include <asm/thermal.h>
 
-#ifdef CONFIG_X86_64
-#include <linux/topology.h>
-#endif
-
 #include "cpu.h"
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/mpspec.h>
-#include <asm/apic.h>
-#endif
-
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
-- 
2.48.1


