Return-Path: <linux-kernel+bounces-566023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D985A67239
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FEE18910F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769220A5C6;
	Tue, 18 Mar 2025 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6tHMYLG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4xkpF7U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DC209F4A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296081; cv=none; b=KFoYSobNWzM65wibqDKm2RUbY4APqkw8ZrcErdWW2z2V8dtH9hExQy6tc0kj2yFGt0J6Gvv/oy00kh2J/2X13e782DlTGEeKnG+CeIW2nfn/qOvEOWFcJRTGz0iYa+Y1qsyC8enJaHw/tBfrFO6eGtcK2FduFSj7coNrchjBrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296081; c=relaxed/simple;
	bh=X39AUEG5nv3lS/OxEL47cpT/j233rj4yGQy3dPiHJIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eanX3YBzoFt5ScqwGwfMq6UvE5U0usOWbFS6iOLfqjXzXXwxhDXArZvw814MeBc74wREhHWjKysZDx/72zgNzWRU8qLBTEiJik6aJ4ULEJl0wOTG/VL/b333fgczk8dwqNgIXPfj39VQhkV2xCHPjJsJXTP/QMIrpNPjxj/pzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6tHMYLG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4xkpF7U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:07:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742296073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=so7iBW617bBZ+P6Esht8Cob0j8gL2z/4LrETFf/UzOI=;
	b=q6tHMYLG4Scg+mhtwT+VkKIGhJqOMifwsD/Y6O/eyZx6nPBkcKY9ORhjVEVo7S2uT8ovxQ
	bdLbqi2kzlVXaS4aRSu+5GUmCOzs+x0alXboSl21oFXPPe9rZyf63Ikmknl1GPfNoXLqVq
	O7RJtIChSw7mUQQ/85Q5x3cKMHP1u7SixQ8Li8BBGPD07RMNJG9wsL8HOoFtnJByVqW+0d
	/NFUVbG8XUBGYadDPoPeiwWNJ3v6Bh21ZFdAB7TWH08O1kfg13y2bD0aNLdMdnjS8YACd0
	FkJybkw2IlYE/ITT/7TOH74Rj3Gpg3RtgF+pkBcoyPt6yJNhO+sbZlRHltd5Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742296073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=so7iBW617bBZ+P6Esht8Cob0j8gL2z/4LrETFf/UzOI=;
	b=E4xkpF7UmNwjiDYs8O1xww5LMPx+ES365xYoH0ER3l9msS9/k1SRzuu31aAsxs5vdjlIEC
	LsJIuwVYxj2AH4Dg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/29] x86: treewide: Introduce
 x86_vendor_amd_or_hygon()
Message-ID: <Z9lUB2t0eZ8bz4vW@lx-t490>
References: <20250317164745.4754-1-darwi@linutronix.de>
 <20250317164745.4754-2-darwi@linutronix.de>
 <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317173216.GGZ9hcoDICYl1fBtBG@fat_crate.local>

Hi,

On Mon, 17 Mar 2025, Borislav Petkov wrote:
>
> On Mon, Mar 17, 2025, Ahmed S. Darwish wrote:
> > The pattern to check if an x86 vendor is AMD or HYGON (or not both) is
> > pretty common.  Introduce x86_vendor_amd_or_hygon() at <asm/processor.h>
>
> So if we need to check "intel too", we do
>
> x86_vendor_amd_or_hygon_or_intel?
>
> Nah, this is silly.
>

I needed this while refactoring the cacheinfo.c leaf 0x8000001d code at
patch 11/29 ("x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d
calls") as the combined check was done multiple times.

Then I found that there are 28 other cases in the x86 tree where the
AMD/Hygon CPU vendor check is also combined.  So I did that macro and it
also made a number the affected sites more succinct; e.g.:

|  diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
|  index 43dcd8c7badc..13df4917d7d8 100644
|  --- a/arch/x86/xen/enlighten.c
|  +++ b/arch/x86/xen/enlighten.c
|  @@ -82,11 +82,9 @@ void xen_hypercall_setfunc(void)
|   	if (static_call_query(xen_hypercall) != xen_hypercall_hvm)
|   		return;
|
|  -	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
|  -	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
|  -		static_call_update(xen_hypercall, xen_hypercall_amd);
|  -	else
|  -		static_call_update(xen_hypercall, xen_hypercall_intel);
|  +	static_call_update(xen_hypercall,
|  +			   x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor) ?
|  +			   xen_hypercall_amd : xen_hypercall_intel);
|   }
|
|   /*
|  @@ -118,11 +116,8 @@ noinstr void *__xen_hypercall_setfunc(void)
|   	if (!boot_cpu_has(X86_FEATURE_CPUID))
|   		xen_get_vendor();
|
|  -	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
|  -	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
|  -		func = xen_hypercall_amd;
|  -	else
|  -		func = xen_hypercall_intel;
|  +	func = x86_vendor_amd_or_hygon(boot_cpu_data.x86_vendor) ?
|  +		xen_hypercall_amd : xen_hypercall_intel;
|
|   	static_call_update_early(xen_hypercall, func);

Nonetheless, I've seen your other emails in the thread, and I'll drop the
patch.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

