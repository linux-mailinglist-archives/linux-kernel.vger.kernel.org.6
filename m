Return-Path: <linux-kernel+bounces-236470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90AB91E2B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2901F226F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC916C845;
	Mon,  1 Jul 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKbBMRrU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/XG5mGU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BA16C69B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845297; cv=none; b=iXpE4MXQVPNwAQ2G3gz0qg109oCMWDS1PrCQRDcBPx8Jl7dJOE//1IlpQRFnEJFh7lwRK1+IJUeHE258njD3PXk5RD0CjnWPvXZ1g41n/o5VXhujTqAfOcFlNEfdM65KXuUep1R+vxmCU3PLh8IqYGbMFOCOBx1acFRH78g8EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845297; c=relaxed/simple;
	bh=4m6IQFozutLRp58djnWYUIxu0luvFjZhZv0Tfwlq8bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRo27ZUxN/9uto7adcbTJZx/MQxOGlt1fx0iIwyM+1fwATcFPcYhRh0WWITCl4EYRxpEUda642mMcmnIsi3gVXXbU0ca1V2eXAStQSSm5JwZyQOYRkseQ+kVP8iEgz8m4BbL5CC8wr8vHzG5U/bqCc0ZpMY1KPgaH6b4F8siuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKbBMRrU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/XG5mGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719845292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl3L/H0hVP5FIiMNPME4ljyQbOQiPpTP2acmwCBwrew=;
	b=eKbBMRrUfIiuG0YRUZE7aBez4I420ZTY9knqG2rlkYJTOCcbVOlIOJEGgqJgEwknyVCBm1
	FqK609jB3swlTca0sa3wQ9OQdouWmglBJH2WiiZBmo1YgDL0tntw2E/KwNwD9qtbyShWLn
	r35I4KExgjOyxk7sNBaaUnO0OaWK0yM5RZbXPg1EYH9I3EZqI/x+WxsHe5ya3X6DKnw5X2
	WYpWWr4duhNbRaNWghLAJd3J8hNxrwYElTmnszLOF2Op5qdoAZGoExRArUIX68RwXXyOI9
	lqIqmlfMv44/J45k3aPmCpvO8AHbAAJYq4onAXmuGPnwlL0qgAnrgwSSJiPrgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719845292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl3L/H0hVP5FIiMNPME4ljyQbOQiPpTP2acmwCBwrew=;
	b=d/XG5mGUqYTSrX1I7hRgk95MpfVKuN7GbZ44QXkJQvH2CDLMi96O1n7GXndv6M1piTpp3S
	ozyrZCrYx9F+aSDQ==
Date: Mon, 01 Jul 2024 16:47:57 +0200
Subject: [PATCH 4/5] x86/vgtod: Remove unused typedef gtod_long_t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-vdso-cleanup-v1-4-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
In-Reply-To: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

The typedef gtod_long_t is not used anymore so remove it.

The header file contains then only includes dependent on
CONFIG_GENERIC_GETTIMEOFDAY to not break ARCH=um. Nevertheless, keep the
header file only with those includes to prevent spreading ifdeffery all
over the place.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 arch/x86/include/asm/vgtod.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 7aa38b2ad8a9..a0ce291abcae 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -14,11 +14,6 @@
 
 #include <uapi/linux/time.h>
 
-#ifdef BUILD_VDSO32_64
-typedef u64 gtod_long_t;
-#else
-typedef unsigned long gtod_long_t;
-#endif
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #endif /* _ASM_X86_VGTOD_H */

-- 
2.39.2


