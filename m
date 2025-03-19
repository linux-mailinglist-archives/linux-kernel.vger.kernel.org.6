Return-Path: <linux-kernel+bounces-567979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE7A68CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B1719C4292
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6572580CC;
	Wed, 19 Mar 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1gezVie";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFpjDIRb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97486257AF9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386932; cv=none; b=lcdYCduPWzNuJchhCDUsTAPAQaGz4FNB8uXu/zHJNK3p1GtIOz7pwo/XqZbH90G2ke6Y6kx8zf1GUGc3XxdUkoTLv1qgEH5QULqfGqh/AVm+oEy0oLafYmGm1aVHJoPzDTVezi4w2Rkkqg3Q2qxRQXuJZpuv/Q/E+4+WLbQYvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386932; c=relaxed/simple;
	bh=GZolcfzm1JnZkKqjVbXM2gj9PLpHcVbDueFdV984WbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuYzjvIQVO1cO1kJo7OpyIlwpBHSY7MtAmb47jJHqRkYuC4P3lKRvUaNq6wOZgDSs5/7TCZaWTYlr87rfVsD9/hRqxeJTLYSBHEFAQ1kfDzoehZQh/7M8gO34OdJtu8DbFiV8AZ6LbSW8plHPFUCF9tpNzyZ+utTVVzA5ONmh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1gezVie; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFpjDIRb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IZo4crAyQCBNwnRyQzdxn5oekpXAzTH9DnGF+58/1U=;
	b=N1gezVieGnwnwclnj1gURR2OHiJZPEMUS9V/hcEtnF/7X/bnHMsTluebKp3IdgjItEPW8G
	ahO6UkLHFsPsoZJBBRPRQui/gY2BWUe43mXZbSKp+pXtCKebRz9pBfxZbO+b8oitAnPwDD
	8i+a9r6qyeLBHpQuWpf8PnSM5USMzoT4rmt5qzMjFCsJz1fsiFsmRSDqgt0VIoP+dvKsqm
	PhToVnrXlAQQ25kgJZnu/fxLNAO4UJ49YzNYkBzzq7kTSLahFSnQZcO7qU2HLXVgYOxiPp
	XqE1MIqA72f+dB6PPQjmEhTQ7Tyqt1Vvgem7BPGs94GanE1COCE2f4Z/yZDuFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IZo4crAyQCBNwnRyQzdxn5oekpXAzTH9DnGF+58/1U=;
	b=SFpjDIRbYITPtuDTmc5Xh2+4YTXeSM93cn97JbKWw7eZcQRvRCCjg4WT3JSu+qSJUzSEvQ
	5McFjaezAi5rBVDw==
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
Subject: [PATCH v3 08/29] x86/cacheinfo: Constify _cpuid4_info_regs instances
Date: Wed, 19 Mar 2025 13:21:16 +0100
Message-ID: <20250319122137.4004-9-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_cpuid4_info_regs instances are passed through a large number of
functions at cacheinfo.c.  For clarity, constify the instance parameters
where _cpuid4_info_regs is only read from.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index be9be5e56b44..fc4b49ec42df 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -841,7 +841,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    struct _cpuid4_info_regs *base)
+				    const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -898,7 +898,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 struct _cpuid4_info_regs *base)
+				 const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -933,7 +933,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, struct _cpuid4_info_regs *base)
+static void ci_info_init(struct cacheinfo *ci,
+			 const struct _cpuid4_info_regs *base)
 {
 	ci->id = base->id;
 	ci->attributes = CACHE_ID;
-- 
2.48.1


