Return-Path: <linux-kernel+bounces-253817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9C93276D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28243B21503
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A319AD6B;
	Tue, 16 Jul 2024 13:27:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B919645E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136427; cv=none; b=srqz3k0m+kM6qLURfiZN9TSxDwUBVpee1YQ8SIptkTc3rhm2bzV5lN11pU1KD25VhT8LdDVLRifeWt09UL7ptA4+mNTux1SVA/DPbpKiqLXm1coeVhihyR2PFXqerbGZJf/+qXfbcdjj8SGdHATexVY7+D4SxnrrRDLnMES7Y6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136427; c=relaxed/simple;
	bh=AxtB/lm2jW5e/hK0f+ovoWdve6yM24Dk6nMxzgUuflE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNfrTuy4F7for4NqLKLhil4YxcYnWDr2S5PaInNTAZNy/K412PcdMdMeKnbGvfpfuVY3a6y7KJKhKLpLKJdzuqaP9e4a3fwFyIOVbEk+sfLHsVNoT48kTsxDcYsF3qphjGxrRPbjsf3f63TAIT2tOf8c0BHjg2m9TadBNBTgAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D9F1063;
	Tue, 16 Jul 2024 06:27:29 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B0E03F762;
	Tue, 16 Jul 2024 06:27:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:26:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, masahiroy@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/Kconfig: Remove redundant 'if
 HAVE_FUNCTION_GRAPH_TRACER'
Message-ID: <ZpZ1E0r0oFn7CTBF@J2N7QTR9R3.cambridge.arm.com>
References: <20240716050915.2657694-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716050915.2657694-1-anshuman.khandual@arm.com>

On Tue, Jul 16, 2024 at 10:39:15AM +0530, Anshuman Khandual wrote:
> Since the commit 819e50e25d0c ("arm64: Add ftrace support"),
> HAVE_FUNCTION_GRAPH_TRACER has always been enabled. Although a subsequent
> commit 364697032246 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
> redundantly added check on HAVE_FUNCTION_GRAPH_TRACER, while enabling the
> config HAVE_FUNCTION_GRAPH_RETVAL. Let's just drop this redundant check.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 79a656a62cbc..cf1781cdc062 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -211,8 +211,8 @@ config ARM64
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FUNCTION_ERROR_INJECTION
> -	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_FUNCTION_GRAPH_RETVAL
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
>  		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> -- 
> 2.30.2
> 

