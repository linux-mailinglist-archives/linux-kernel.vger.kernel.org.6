Return-Path: <linux-kernel+bounces-543560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3013A4D70D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EF83AFC80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985DB1FF7B9;
	Tue,  4 Mar 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ed8RF6tw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JhWCumRj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27751FCFD2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078388; cv=none; b=NDQsKmW52zJKX31H+I22HyX6Aczr96D2U85qVFronKAjL2/7CIyDF2tXMS6qOD7PSfCpryk4LMfJxhHyxfsO+6iRlw8AyUxrTuNA2tJmajbVhrS003zCPsSt3aS13s+NOKgc5xnxeQTt4ccP4ymBTJ0+daWB7oJJ7pTkGkpt6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078388; c=relaxed/simple;
	bh=CZOBlrKslq4YWqHeNKiFoVf0iAMklIwd5UDHUvzTcG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2F38biYlksEFlVamvKaBP39TGyIOoxiooKrHe4k9yzUxLEnegtqwaf4lNGOqUyjXC8yM6/32jbftYuD/B1P36fZV5ZTb7N2AyrPQb8jcgz89qNr9IcDH2rxHUMpeZCGsCz+QcPcuNrqTg5BeMgV/4Lrrl5bdTpxa5CXgJ34I2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ed8RF6tw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JhWCumRj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9GXN+I+HxjtZy8DzjkmjTZt67y3X5bRcXOLv7ZM9iU=;
	b=Ed8RF6tw5GsGELM7gXSqyOqP0VWC+RPN/yG/Ub/vdiMAxzZl3B9P2H5Vx/1M7RZNN6isHd
	d9CF//yjCCMHXxxzjEMjDdCfC2zPJ/cdXaA+QINlkLigMP/xyqz+DPrtZCsgpodKe3JosI
	00dzlyy9y+VlXqYPUMQVqzhKnK8EfiwCEVAkSkqek65cDZH+HaMFbjOXAEhs5bLl1vE2oy
	VeYakuUfTdcFawp/GyB4JnmnBAP+6UqkYSvqA0m3HqH0tIwVbPdLDWYt8uHXieHTfjmXFq
	YOvMSJzGDydPtzquI3N1ahp+dmmzx6icVz3Dj1fZKpsY79yr49m40iZRM67sMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9GXN+I+HxjtZy8DzjkmjTZt67y3X5bRcXOLv7ZM9iU=;
	b=JhWCumRjFt5iuaKHPL3bnnW/KSR4OfOZNrBNtPDJh4rgWE+scOTsWbgmdrolhsQ5CYmYmX
	ZBNaNga05SawnACA==
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
Subject: [PATCH v1 17/40] x86/cacheinfo: Constify _cpuid4_info_regs instances
Date: Tue,  4 Mar 2025 09:51:28 +0100
Message-ID: <20250304085152.51092-18-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
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
index 5deffc834291..15ae12c92a83 100644
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


