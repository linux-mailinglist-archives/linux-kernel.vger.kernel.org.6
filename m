Return-Path: <linux-kernel+bounces-347191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A098CF49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DA02841A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0B1974FE;
	Wed,  2 Oct 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qU2hNTYp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTzAfauK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7EF196C9B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859268; cv=none; b=cgnaqZTub8XgviQek4So1eflzJQGMH46cXo5GSmOgcGe5QltSkMcL5VI5P/HKDRx4ksKG+gyTHDHV51nHoPaS+j9cnNBIsFw1345OViP0CeAynKnPOuTHK2y3aym9T11ZDOwFMjBLu8TzHwZ1bLkkKQri5HAJ/Zf+ws207f0v0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859268; c=relaxed/simple;
	bh=1WOQ4towFV7OzbWcAmEgcY8i8BAO+Guj3cV+I7WpjCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+c7dF5qX17xevn3jtnRwZ2WcIvYa68jOYBem4cOsrO7Nwo5/PiWq+BD+pGPCjx72AxRpqFOaYAiz9gux59AnY3Qert9LMd1KlJiyz2RD7f4E5cUGX65lD2nnK3kjKiGM4Muh/ddcGcsicZnsJ/ZgoHibIGoUm/8Anr40AJWFYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qU2hNTYp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTzAfauK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Oct 2024 10:54:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727859264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JobR5A+SF1SfOE5ovpFuN/8jyIiqbSV9U/dgwI+evhg=;
	b=qU2hNTYpZpQgEXPt7S0Rvj3tFXmQ5SeE9x8asf3njKHyJ+VPmFr2F4qnWiHEDyWTRyuHrE
	PfNnTMFO1inQeGbqllz4dcr61/D5yCMGnHZKyb7VySl2tBrCE0vbDozHckNVS6x88vKtMO
	ryrrczliw2Yh20QdSm6qphQqi1DV5m2BHtEltzrfs6IDLIia09SuJM+I9RV+8oDbHk07jq
	N30MR6zYeRb4SMZo84rMTy6L2OYiSNoNkWYKh2oHYFqCVh8v5GCs5vNzQYs7b2d6ZrjVhP
	cVmaRuMwQGJM08mD+3nOI5PULU+1y+OTBUmsWrSFwpzXjZXuIeSGZQjQZ+PelQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727859264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JobR5A+SF1SfOE5ovpFuN/8jyIiqbSV9U/dgwI+evhg=;
	b=MTzAfauKUjCdh/YxPqYaKvjpvutELxxOfxPWbM14XN0SrKbq6l08hbxYHoxyyAeujSVDZd
	toiwLTE5nnhBYhBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
Subject: Re: [PATCH 1/2] powerpc/vdso: Add a page for non-time data
Message-ID: <20241002104334-b655500b-901b-42db-a2c8-582e10826889@linutronix.de>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>

Hi Christophe,

On Wed, Oct 02, 2024 at 10:39:28AM GMT, Christophe Leroy wrote:
> The page containing VDSO time data is swapped with the one containing
> TIME namespace data when a process uses a non-root time namespace.
> For other data like powerpc specific data and RNG data, it means
> tracking whether time namespace is the root one or not to know which
> page to use.
> 
> Simplify the logic behind by moving time data out of first data page
> so that the first data page which contains everything else always
> remains the first page. Time data is in the second or third page
> depending on selected time namespace.
> 
> While we are playing with get_datapage macro, directly take into
> account the data offset inside the macro instead of adding that offset
> afterwards.

FYI

I am currently working on a series to unify the storage of the
VDSO data for most architectures, including powerpc.
This will also include a dedicated rng data page.

That generic infrastructure would replace the need for Patch 1.
Obviously, if your series gets applied, I can adapt mine for that.

If you are about to also modify other architectures in a similar way,
we may want to coordinate.

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/vdso_datapage.h | 24 +++++++-----------------
>  arch/powerpc/kernel/vdso.c               | 16 ++++++++++------
>  arch/powerpc/kernel/vdso/cacheflush.S    |  2 +-
>  arch/powerpc/kernel/vdso/datapage.S      |  4 ++--
>  arch/powerpc/kernel/vdso/getrandom.S     |  3 +--
>  arch/powerpc/kernel/vdso/gettimeofday.S  |  5 ++---
>  arch/powerpc/kernel/vdso/vdso32.lds.S    |  2 +-
>  arch/powerpc/kernel/vdso/vdso64.lds.S    |  2 +-
>  8 files changed, 25 insertions(+), 33 deletions(-)


Thomas

