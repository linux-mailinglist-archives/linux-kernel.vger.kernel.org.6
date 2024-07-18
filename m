Return-Path: <linux-kernel+bounces-256431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E557934E78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5528B2243E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4B14037F;
	Thu, 18 Jul 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MU2toyyk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7umEflX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEB13E41D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310492; cv=none; b=shTN9lolma0SSEmo67X+GkO4VzvbxzCdq4K6hqfBq6XHoFFjKaqQJrAGNwFWHdRD4mf+LrY1htYGYvz2Cmen5uLRXStKDYhrHppmgJa7NdnUofIFsfavBH3ns5hGZwx8fg8JrCYTjgJmRsIOhhjr2J/o12QAXHhN40LBOP9q+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310492; c=relaxed/simple;
	bh=rDL/H4swq5vWFG8nI1kb1FbbSTKnnKfTWZQMQdVPLuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAOi7whxthPvRJQsvQWfqnBmo+kF+fUjnaeTSbSNYtko+pAdDRS4wIAus9mSs7N9rtT2VDuMPNSmvHmLbGwwiooA//SyPBHDLI1cqeE9p+J9JkNrhNnnGFdvRyCFC+vfCtkybO98CsYUThxYz4Hm5MA6PDJwu00evc8hXItDNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MU2toyyk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7umEflX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTXkR8T3kLHV3No5jIU3m0/aEpNcwQkpCfNEeOLSNS4=;
	b=MU2toyykCBl9x7ohgzejkx5R0cfcJS97sJd3UJxrSMDdU/pk8KhkkyXy0BGFOoj7OvEEdW
	YHf27rkSXETcznuzt2uaIXCVyX4pZuUSW+ywPJzhH2IHr5jj0o8r9Y9r0fdSaxSKhlOvFt
	2jfNdrpoCd7ZLvX4UjrXJ5IbKkjBQXOx4UewgDA2Cq9SVODOWMNjaJktmlDExSTkO3unNW
	kaCT8MZMQKXtrbox7jDwb7WjfaoZOWf239Zjf9Q6G4o1Fs2KvObiY0wtv/ErzRUjDSKZO7
	Giq+AE/I3wK2Nil/YfVMZafVYeA+BFyuUla0pHV/RiWOkZguT7qC6bhc32Fvag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTXkR8T3kLHV3No5jIU3m0/aEpNcwQkpCfNEeOLSNS4=;
	b=k7umEflXbJReBenA8FAmSzm0EIiIwUPnjag2Rnmfc36Dbh24Vh/IHYJTBOJ2UDIJAxO2ae
	NYkCPgGLhFuWjuCA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 1/9] tools/x86/kcpuid: Remove unused variable
Date: Thu, 18 Jul 2024 15:47:41 +0200
Message-ID: <20240718134755.378115-2-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variable "num_leafs" is set in multiple places but is never read
anywhere.  Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 24b7d017ec2c..e1973d8b322e 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -76,7 +76,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static int num_leafs;
 static bool is_amd;
 static bool show_details;
 static bool show_raw;
@@ -246,7 +245,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
 		if (allzero)
 			continue;
-		num_leafs++;
 
 		if (!has_subleafs(f))
 			continue;
@@ -272,7 +270,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 						eax, ebx, ecx, edx);
 			if (allzero)
 				continue;
-			num_leafs++;
 		}
 
 	}
-- 
2.45.2


