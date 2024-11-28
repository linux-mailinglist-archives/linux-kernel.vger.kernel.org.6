Return-Path: <linux-kernel+bounces-425115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F99DBD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D15A16198E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D41C6F43;
	Thu, 28 Nov 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnUBBgRq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dp2BQZgr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5C1C4A3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732833041; cv=none; b=jvEj2Hd4Q3n/y6H7WbrUiZnDixfxorlGzK7q48anBClh0F4ZXEt7lpiO70PSaBT3AWBBPYtnaz/DnCUdyY6Wf8iQgkYVsoDJqa9MQ9Cnorr2kmAKM6G8RwTYxRtEtv1zTMMQR8nAdiljSzeMVB4Vbnx/Noc0OjNnibApfwl2sY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732833041; c=relaxed/simple;
	bh=QOtEoM0vuFWST33ydT3H+Rlps1PpwvRTUu26sqe9jYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=He/vHkTCikVs0jF0P+bFrmnGy0VIhOwmJ4+xTv/YH/IwV59lvtGbUc2XMyZLQR4MvErPaWEgh6e8038FPCMMHARzy6vi89z62ZM8NeJ+mrAtpDBLlylZKW5orztot93Z8rgxCHG2YTZAVF9izz23IouKvqK8vcRZNrRiVd1HyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnUBBgRq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dp2BQZgr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732833038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjTbtqtwxE7mL+k/Zr+LF1pFuhBwPYdCfPJaRSqLXII=;
	b=WnUBBgRqvNuS2VZckL+pbRlT/fuX5gG9FlXucXBtV3Wt+8h+itmgft/gX9Z+3ucsgSgu6o
	CW3/C2RgZSgmSUUDDeZL4meZPF7ef/PdgiROiHh+hLmdntpy2bUCZsfJpfPDcG4x8m9Kqx
	K++HqVD5unmN8rBxXULH0YuoP1V5ru6BrkMvHgMiHik8yYaYc/0ecTVg47WYBuIQPy3sLQ
	kR7KPNJ9e2gc9hntPCYO/5H+vt2qLHFY7uQzkDagPeI4dbZmzj+ITQzLWeIM14Gv8s8xdr
	4u0xaja6HaKPeBabD9VVi4AJDLuHAoLI/0+lntj+vApW4IbY2zaol3LaH4U0bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732833038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjTbtqtwxE7mL+k/Zr+LF1pFuhBwPYdCfPJaRSqLXII=;
	b=Dp2BQZgrm19jK3QFg7h+a5hg8qc2ezwI7REO6acwh8IauArVL+9ffiXBrM6GkAcdxI/mnn
	JIVZemhQxNR7QJDA==
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 04/13] tools/x86/kcpuid: Remove unused local variable
Date: Thu, 28 Nov 2024 23:29:39 +0100
Message-ID: <20241128222948.579920-5-darwi@linutronix.de>
In-Reply-To: <20241128222948.579920-1-darwi@linutronix.de>
References: <20241128222948.579920-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable "index" is not used anywhere; remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1ec60c892206..201382da07c3 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -211,10 +211,6 @@ static void raw_dump_range(struct cpuid_range *range)
 
 	for (f = 0; (int)f < range->nr; f++) {
 		struct cpuid_func *func = &range->funcs[f];
-		u32 index = f;
-
-		if (range->is_ext)
-			index += 0x80000000;
 
 		/* Skip leaf without valid items */
 		if (!func->nr)
-- 
2.46.2


