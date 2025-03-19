Return-Path: <linux-kernel+bounces-567980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B78A68CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C0885D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D112580F2;
	Wed, 19 Mar 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cKN6TFGq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="692R01hy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C32580FE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386936; cv=none; b=X9i7VlV+sh4U1fEa/dWCMbE/rDK3Fj98+zS9Ki1YfvWp+b7v+lZxfvx/SJyhuj5wdeUGfD3kF3ppmJBs2dBu7PFmaUaBDeEpceT5rlNclZ83/07wwTTi3QFYtFTPH92Vvf1LOhaYpugjohO301hK7OHfWQ5ds6kKwNpyzDrTVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386936; c=relaxed/simple;
	bh=D6MoNQnMIu0yWa3uh0hhdaUOlxNQ3SZzfhKRe7XAQRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDOdgKv9MR473B7MzZKPzLpvXNiRB5AauuR9L82EHuh1FYw8yx6qVWs994y9SdEgHUP2ols2fi+qaXBf9mnHhBh7ZPrF2mmCE5lidgvz3EFYdrznlIn+It2GLyKMfifJPh80e0UYe59LbAavTipJtuY/M0kToCeg7NvB4LO8kkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKN6TFGq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=692R01hy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Yz7MYWtdIz2Z6Ew7EmnlMJcHLa1Fmv3VryPW4eNU0Y=;
	b=cKN6TFGqQkh1IplLUlvlE+h6I5SNYrQQg2bk2Bz/ZcdgpSXcqsSJIj/yc1BKrUHRIppGdS
	U7+c1NipWyVtOSeQEIkWyDK1Po4aAteWSu9T8jjLOu6/b4qrQSwghbgU4TiQNlP8pVdJFO
	HAtkRzlxgHav3vexZ5xQbKgyvriPrrHlv7ekdVMrQg7sQes+G3JGfVtXeRLLQyjvp5oJcO
	cmGqzOibR5B1SAndkGMOm4R0mJP4NKaWLTSbg0rP0ZvSzb7J3mHlgY1zQQ7HQNIC3jtY0g
	DimPS6mFky5RnbKb+Q101kDZjlkVbDFk2TFlGSYySMM2zZfuYlCBFdDGwXIJVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Yz7MYWtdIz2Z6Ew7EmnlMJcHLa1Fmv3VryPW4eNU0Y=;
	b=692R01hywIZC12p+XVEjX+oXmZfQp1paMKkGtsrW3MLFqHZ6xIdkZ6erkhPGJMXeRRSXGD
	J4fkG6af0p1qeABg==
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
Subject: [PATCH v3 09/29] x86/cacheinfo: Align ci_info_init() assignment expressions
Date: Wed, 19 Mar 2025 13:21:17 +0100
Message-ID: <20250319122137.4004-10-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
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
index fc4b49ec42df..b273ecf3f538 100644
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


