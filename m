Return-Path: <linux-kernel+bounces-564687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1B4A65966
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1AB882AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3F1E5721;
	Mon, 17 Mar 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/VR0+Bo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQeuQhGb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82271E5218
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230380; cv=none; b=fHtdXJXK7U3UIF9e0ChBhLIJPDf3Q+SQVykVHzshA76l4x2pBgJL9vj3V7qmqcQJTf9Km7D713L+yr3c+96DlSVkMlCu52Seou9iXCV+cU8/okw9Qmu8zvqTfGwH/pLSkuZvB8zAW43Jiyopua912SEex9En0rD0chvoduXA6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230380; c=relaxed/simple;
	bh=IW0nejMdjvFNeBpXQN8vbW4ILHz/PnBifoX0PNlWNHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boA9obpDfgxgc4aOU7/ZL+4Xzj2ZwIPTsPcHhNnGSKnUwAExXUAVV5uy4T1UjVY3cbcwaLhC0vvFKnV5cyJ6qA6FX1oxg3oobM6t/mKu+G+IncTfBAW9THSNwu25G1RpGCcx7SiGEKT1fBmHH1VE9YB330kfpmGDTpvP6X5HZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/VR0+Bo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQeuQhGb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU7gsf9XotSfzH0GtVUJuZqFyPmgVAr3nmJWCmwT1HE=;
	b=X/VR0+BoEzotmeH3Tf/SKUoC5GMaFItRZv3ytzJQdbnxP/B2vDiQGwZD109TYisr+fs4HG
	4QPROvgLgddqB37R40SS0C+vM6OQgBaeKXKx5upEavz3vCjSCCDui6BxGW8QSsSJHwf+pm
	0UsO5wE0RxbLWVNjkSXh2tjaJ5h8/SOXDUkRwZHyNIn2slPdEGzAIpSxTNrwZ2t5N6yL0v
	DY1hPJBFUHgLZLfoSaCxyCR7iLOL3CLFdqxRuGXc95L+LvJ3zyN3pE3sKmFwEIQXfvoxQN
	F0D2YUAeUPwW3nIqm/euc6hAS+yUA+4QplR+n2xdzRKg6ZAIayrUITq1oBRy+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU7gsf9XotSfzH0GtVUJuZqFyPmgVAr3nmJWCmwT1HE=;
	b=DQeuQhGb2yMVOvMPtTScr3VI0/lPxxioDw/92gDxlRjOgBS+frbGmLUbMK4Ls17eDl4uvj
	KTLoNJoqrmeGoMBw==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 09/29] x86/cacheinfo: Align ci_info_init() assignment expressions
Date: Mon, 17 Mar 2025 17:47:25 +0100
Message-ID: <20250317164745.4754-10-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ci_info_init() function initializes 10 members of a struct cacheinfo
instance using passed data from CPUID leaf 0x4.

Such assignment expressions are difficult to read in their current form.
Align them for clarity.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 8368eb26c909..3b97e475b09d 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -934,19 +934,16 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
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


