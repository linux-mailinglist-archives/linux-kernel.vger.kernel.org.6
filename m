Return-Path: <linux-kernel+bounces-557892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69798A5DF25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DC16649D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960F253B64;
	Wed, 12 Mar 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="33tg6GIJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XFXTnEw/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C3252913
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790288; cv=none; b=EQ9A5TaQ/ECDzG1kwhS+aitRgj2S+ZDfl/YWhFQquu2WN1gyTSG3gJSPSAO7WYYNpSLUabJ07NYI6EYKiRhNjh6L3kIT2K5bAsVUVL48GyBqfmkP2hP0zQbwLdluRxyfden4ZdXOhLCdf0zm9GWJYadqR2tOaMr0QeJDSO/vUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790288; c=relaxed/simple;
	bh=Ushz4JR4gBXwlY3rF7uYB5PnO6rgziwqmj7rQX1GkQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rc0GuUdc3cob2xvohE8m/zB3Td8OrJ2lIwR7V4Bzg2LBcEnaIPgmnzBstZ7vvFZ+ZG3P6qWUPhHP0jX/hMsQ4Q8CVE4Qe+F0FeVRDjQ3WvJRk3kuSO7Phnsm6TNyLjDcJ72PK2WjllFfW6RFUDxjJtVBxqSchrqkVH3QoZ0FO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=33tg6GIJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XFXTnEw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aVpvhv/pT52r13e6wll8TyOiNsXUS27/wMFfsB28/g=;
	b=33tg6GIJmdg0y8KK27z7FeGkRLv8mU2la1PmiDeg8PmUaQNWrCGlmPs/8LzhvEkGOO31/U
	VhSFH8pAiYQnkX5N+LlDuvSaR05B4bybwqSQvOwf1qOf3b3ZzbY3PiJIlymL+NNDcJy1J1
	vnJeB7h0oIQu5Rg61993jYfEFQ7Xkx23CZ78mGFlePO2ctXUBiuPUKGTVpXwhbMgY5RT0o
	leFA8LIuTRcbGUFBKGgqxwJeU2krMujbSzBTj3hwUBV0/nXaolqqAlfurL/ZHIydjXTaPD
	1MVxpKZ/yQ1QaVVyjzl27mq7spzb8whQeMeIYg2UVIs3m+eQk8XfL046qaOlfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aVpvhv/pT52r13e6wll8TyOiNsXUS27/wMFfsB28/g=;
	b=XFXTnEw/Ga6sbY7fVEayGl+SMZzilAN4EDI+pPiKrXSGtlp1pHjUEpZhxjDFiMg2yiBv28
	Am+CiHBOUW/1PcDw==
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
Subject: [PATCH v2 06/20] tools/x86/kcpuid: Remove unused local variable
Date: Wed, 12 Mar 2025 15:37:23 +0100
Message-ID: <20250312143738.458507-7-darwi@linutronix.de>
In-Reply-To: <20250312143738.458507-1-darwi@linutronix.de>
References: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable "index" is written to, but is not read from
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index d518a13e4386..a89da2af98e9 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -181,10 +181,6 @@ static void raw_dump_range(struct cpuid_range *range)
 
 	for (f = 0; (int)f < range->nr; f++) {
 		struct cpuid_func *func = &range->funcs[f];
-		u32 index = f;
-
-		if (range->is_ext)
-			index += 0x80000000;
 
 		/* Skip leaf without valid items */
 		if (!func->nr)
-- 
2.48.1


