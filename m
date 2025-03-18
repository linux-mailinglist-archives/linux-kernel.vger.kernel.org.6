Return-Path: <linux-kernel+bounces-566082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87220A672E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8619A0335
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E220B1FE;
	Tue, 18 Mar 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDbomSqx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kHtqDdWD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C8207657
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297998; cv=none; b=pOEM4Kng1X351c5P0B5Y1uNcWDtFBP0Mbg6rTia+eA3xGknkTwaV3ag40P3GIYxFxCBhXiKAR7BmiBoUM0MJn18nYWhF+8pzYX1RC7duFdbrL32FMb3dJFV0u37qXBvQdueRQCH0soeckVEIpie6dXulvMOM9CVDedHTf3xA6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297998; c=relaxed/simple;
	bh=7aiYn3w9hN8oZA0SnlIz2klLCVihwhGr7juPxbuOyUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzlghEtCtyqxuTuZQA6NFcxFCSam4zXFbhD1/A1jvzbB4iqc2GDPoAfwCoexig1cmnzI7RrdlDwvvAHgt0rryd7bPlau2M/45gKhGYX9RudZpVjGGfnGRMlGGkL873r63WXYUa9xHBnRNArh7F11GwJ+GE8o4gLgY+4t43W7w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDbomSqx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kHtqDdWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:39:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742297994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qzd26m9hOlJuJpPwAnp79rQkGlrUfkncxZH1j+3O99o=;
	b=VDbomSqxOSA4icAc83aRwqV92FVRDi5wE6nhJSz7xPKDQmjRgh5UKRYXZ6Nh5vSAv+t9RO
	K0nmQCUrAM/iIisvBZgQXbFTmHI8DwmC77rEcfMLnm/xWeuMBBbwZL/VxNUpMirLr+pGFP
	Jc4j/VstUVSQLm3tkziUjlcX7bCxYYMU7WPit4K0y771c/qQo9nVqGgeQO3uNvc4eSrO9t
	ZIOBossRSXlx6lUDCB/jGFdsJ1YhjS6t5cJH+On7EGDqKA50BBA/upSMq7FKL+zePxFQHo
	0fRiySl2RWVE0PoyxDSNaRq7hkTivPmkAOgJ3B6NTV1aRuWVKRsJq5J2PYYVpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742297994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qzd26m9hOlJuJpPwAnp79rQkGlrUfkncxZH1j+3O99o=;
	b=kHtqDdWDV0RGuugFHvAMqWMcMPxNjM9OoGsFfzrXIdIDEE/ak++d7S2m9I6TZ8Wp4XZCmj
	vT+KVkZcHxO003Aw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
Message-ID: <Z9lbieqhnsVsAf4J@lx-t490>
References: <20250317223039.3741082-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317223039.3741082-1-mingo@kernel.org>

Hi,

On Mon, 17 Mar 2025, mingo@kernel.org wrote:
>
> From: Ingo Molnar <mingo@kernel.org>
>
> This series contains Ahmed S. Darwish's splitting up of <asm/cpuid.h>
> into <asm/cpuid/types.h> and <asm/cpuid/api.h>, followed by a couple
> of cleanups that create a more maintainable base.
>
> [ This is a resend with a proper SMTP setup. Apologies for the duplication. ]
>

Thanks a lot!

Just a small hint that I see this PQ in tip/master, merge commit
b8fefef00c0d ("Merge branch into tip/master: 'x86/cpu'"):

   # New commits in x86/cpu:
      ba501f14e1e6 ("x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>")
      aec28d852ed2 ("x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>")
      f2f828b547ab ("x86/cpuid: Clean up <asm/cpuid/api.h>")
      67a7ae050e7c ("x86/cpuid: Clean up <asm/cpuid/types.h>")
      02b63b33dfc9 ("x86/cpuid: Refactor <asm/cpuid.h>")

But for some reason the above 5 commits are not yet pushed to x86/cpu.

(Sorry if this is expected.)

All the best,

--
Ahmed S. Darwish
Linutronix GmbH

