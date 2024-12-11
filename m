Return-Path: <linux-kernel+bounces-442173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB409ED8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DF3166E33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0901D90DC;
	Wed, 11 Dec 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKvnV9kX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BC1C5488
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953424; cv=none; b=uGV5v2QAwK8ZSlDqJ0BnXFoZCGaVF2Y4pkUlQt8jqHk7IkKDmLTK+E1glgPEzxOGwqTFE9/x2OqKGqDTWqGYQsBu9z8gSsqJPZrt6EGoY9/ecZUEDSVeu1hfcnd79D52aRPEkn7evtqC/vyBXWiljsNtQB3dwHA1WMdVyBMPxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953424; c=relaxed/simple;
	bh=C1XymWqfodxSnsIvmXLKqjg7LIUnl1Qfra4eDbeAd/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQaUOgRw6pRpKLpwdwA/U5nACpRp/bDyUb69RKgHfrMruqmqSbI3KI1+gS3A7XMjptH1YigSznJq7ZbQQ6ncL0grf40j3Stqaw5gbzp3CwVyK/llPb6MsA3mxBaQFruoW5lz2ZwQl6eHcVjjVpfwu51uXnKQves0Ztf/kxPMlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKvnV9kX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DFAC4CED2;
	Wed, 11 Dec 2024 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733953424;
	bh=C1XymWqfodxSnsIvmXLKqjg7LIUnl1Qfra4eDbeAd/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKvnV9kXvmCjXmLPPKS4tLsHWN9qQvZDMulx8M0mYORsaYyFdu/BxUw88PDSuLIdC
	 G2yAG8Qhp4RkoJsd47nnbXFLnsHLWQLZ47lkHKJvi8bFu3f4xEgxncifgLqto7IkA/
	 UQGnn/9QQqvZg1+FwPk3UxhrcgH+ciegg8p2Aq0C2eNQEb82ljzck6BlzHGL0+Grl3
	 JoNVRuc04uY3h4pay24pyaeKYfQQH0z+RRdOPuXorC/xYfHQ3IJhDQ/bFW32xH178/
	 sjjR6tweESRmNTrPvhMicFuSFsfJ2VEVcFisSh8gumUVGhnnN5+s/ZFTC5oUFNUsal
	 oxDyNzeAUg8gg==
Date: Wed, 11 Dec 2024 21:43:39 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/Kconfig: Drop EXECMEM dependency from
 ARCH_WANTS_EXECMEM_LATE
Message-ID: <20241211214338.GC17486@willie-the-truck>
References: <20241210043257.715822-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210043257.715822-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 10, 2024 at 10:02:57AM +0530, Anshuman Khandual wrote:
> ARCH_WANTS_EXECMEM_LATE indicates subscribing platform's preference for
> EXECMEM late initialisation without creating a new dependency. Hence this
> just drops EXECMEM dependency while selecting ARCH_WANTS_EXECMEM_LATE.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.13-rc1
> 
> Changes in V2:
> 
> - Dropped generic EXECMEM config changes per Catalin
> - Updated the commit message as required
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20241209031251.515903-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5479c8b454c..b146372bc365 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -113,7 +113,7 @@ config ARM64
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>  	select ARCH_WANT_LD_ORPHAN_WARN
> -	select ARCH_WANTS_EXECMEM_LATE if EXECMEM
> +	select ARCH_WANTS_EXECMEM_LATE
>  	select ARCH_WANTS_NO_INSTR
>  	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>  	select ARCH_HAS_UBSAN

tbh, I really don't see what we gain from this change but it also
looks harmless. *shrug* I guess I can pick it up.

Will

