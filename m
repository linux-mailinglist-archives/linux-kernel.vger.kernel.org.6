Return-Path: <linux-kernel+bounces-543561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50DA4D70E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313C47A5040
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C9B1FFC4A;
	Tue,  4 Mar 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vubWpRqZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fUFMznx/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA11FF7C9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078390; cv=none; b=qQ5mzzhx0jcwHnWrbRZrZQ0pbT7F7SPQ7x8uYPH+dA5/hWKL7btENh1PZce0r/pN9hpMt5Lr6ZMm395nJPYmd96J2YXo31Ve1+mMzMoPH9kQcJ6oAbxbpNeUtY0jjHQRABib3f5pMRddtI5Pq1LxYBLKlFXNdqaErTgPKvIYP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078390; c=relaxed/simple;
	bh=Kim3Ql4VpH7O2dg8cgk7RCn41yCK6GPz5lqei6i/q90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqEVKSaVpy4DSLnPw0rRtaxFRRv4FhhT7gfkmLK2SayzhqqrDR2hYwdUBDmL8ff3oE5t/bUL8DsL9Jw6CO+XpgNNQav/RJtectmziU/e9btUrwg8JzWtjaRX+vmPcPdyoz4hN4PBNs1POUkp+/d+hLHh3/AQa4OvJRWRu3/heT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vubWpRqZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fUFMznx/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Y2lm76UT6sjXHq4RDQHsnw2W5bv5hekdL5WgofSYTg=;
	b=vubWpRqZA8PiHtWqi+ENhgZxW5Xw3+ZIrvn4yXx4lK8F41h+JdeLlfg0xyLDoEFENNHuEx
	XiKqJDwJZGjKEaJmXmV+VNtEGFiyQkKpolhe21jeWcNSrcb32+by8qenIcJvaFNe3GY/WN
	7kBI2vVWa39BSS3dUUfzq98itGhPhXZ+JL5FY3uR8CLEW4VyXejZ8D1WrQkFev4VMHBw+o
	i8LErh9yOADsHkS4g8jCrjcfTtY3QqODqjkwLU+DpgzoUzHywSUaGGaiJncR5f2r3cP0rG
	1/PJ3f2b88GzlMi50A8SzHtFtjM/gttT4yrtc/8BlQXjanI5CMyZZWp5jwlx/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Y2lm76UT6sjXHq4RDQHsnw2W5bv5hekdL5WgofSYTg=;
	b=fUFMznx/soCargjOSQVd9namUY7UgVL2duPUhhnwM738ezNMzkQutIJNvUTWYx4XH81oMX
	M7cmTaepMAsP/aAg==
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
Subject: [PATCH v1 18/40] x86/cacheinfo: Align ci_info_init() assignment expressions
Date: Tue,  4 Mar 2025 09:51:29 +0100
Message-ID: <20250304085152.51092-19-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ci_info_init() function initializes 10 members of a struct cacheinfo
instance using passed data from cpuid leaf 0x4.

Such assignment expressions are difficult to read in their current form.
Align them for clarity.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 15ae12c92a83..f825d68e8de6 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -936,19 +936,16 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 static void ci_info_init(struct cacheinfo *ci,
 			 const struct _cpuid4_info_regs *base)
 {
-	ci->id = base->id;
-	ci->attributes = CACHE_ID;
-	ci->level = base->eax.split.level;
-	ci->type = cache_type_map[base->eax.split.type];
-	ci->coherency_line_size =
-				base->ebx.split.coherency_line_size + 1;
-	ci->ways_of_associativity =
-				base->ebx.split.ways_of_associativity + 1;
-	ci->size = base->size;
-	ci->number_of_sets = base->ecx.split.number_of_sets + 1;
-	ci->physical_line_partition =
-				base->ebx.split.physical_line_partition + 1;
-	ci->priv = base->nb;
+	ci->id				= base->id;
+	ci->attributes			= CACHE_ID;
+	ci->level			= base->eax.split.level;
+	ci->type			= cache_type_map[base->eax.split.type];
+	ci->coherency_line_size		= base->ebx.split.coherency_line_size + 1;
+	ci->ways_of_associativity	= base->ebx.split.ways_of_associativity + 1;
+	ci->size			= base->size;
+	ci->number_of_sets		= base->ecx.split.number_of_sets + 1;
+	ci->physical_line_partition	= base->ebx.split.physical_line_partition + 1;
+	ci->priv			= base->nb;
 }
 
 int init_cache_level(unsigned int cpu)
-- 
2.48.1


