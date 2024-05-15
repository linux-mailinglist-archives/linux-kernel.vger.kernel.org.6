Return-Path: <linux-kernel+bounces-179458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31F8C6027
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFD81F2286E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58CA3A1B0;
	Wed, 15 May 2024 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L408mwvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184AD39ACD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715750951; cv=none; b=QQMlokrN544JxgBJpzCwVyymU/kf+/cYzEudQ9HU+9kkC7wMqSmgdWOe38T4y6pxSPkVrhapLAohODJBpM1t5bX6iwiouCo/GFiNjT2ZSGZcroYIcVTwM0FQBE1rnSmgJXZlVoASThfwmTz12p3pmtOSOTPS0gsMWI64d9E36rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715750951; c=relaxed/simple;
	bh=KYV3IyS77KkYiDrdE4Rp2al8luhE12DTz/ap5AMIVKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTgxEx5mKsB4TrEoaUPecurKUESZEWIEiC/GnX3Wk4zCswrkdoPRx4KbWZmCRytwSW/KwJ5U8E5L7TPOBYEPDxgdc28gTqS8F1Pxpw7iwS2q7HHQWnhOi02fV/QNfmsL1QqEZ+uWZCU0BEwg8N5WVpjZxKo5Gk/fcIYoy4rHhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L408mwvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E080FC2BD11;
	Wed, 15 May 2024 05:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715750950;
	bh=KYV3IyS77KkYiDrdE4Rp2al8luhE12DTz/ap5AMIVKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L408mwvUMOeIe8NIh1DXQD4E9z4z9dV1uQCbEeR/h5oHuaALVr3+KyJVOuWQ1fDBv
	 5kkZKC1c57bnpNb2BZfCzwdB/xxsMnOcn+5Af2yfMOKAXhg7+DI++l09N08TleJaje
	 o86OlC881cWpA1QS5wvrBKBmm0GcnqaWCjpTUHUYwkPKrk47JlfQgJYKCHQT1Ijj9/
	 iMJmkKXjnBF3qYkPlFQF+/eZkIQiueMYbkM2bu5t8ifD0Je6SgKnzPgXjxbt0ZpugZ
	 uDegFDq8prIXnEv2AgBx6drbwQsWJnPLerYGysi8SOo1Sw+qMiabXGeDYnAh54KDZa
	 WJu6guhn66vnQ==
Date: Wed, 15 May 2024 10:53:42 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	aboorvad@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/powerpc: Remove unused cede related functions
Message-ID: <cdzbxdhl2cj754m2erxdt5wwsztdsvrjvhq54szow4ufst44j7@bx2i4w7hpo5v>
References: <20240514132457.292865-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514132457.292865-1-gautam@linux.ibm.com>

On Tue, May 14, 2024 at 06:54:55PM GMT, Gautam Menghani wrote:
> Remove extended_cede_processor() and its helpers as
> extended_cede_processor() has no callers since
> commit 48f6e7f6d948("powerpc/pseries: remove cede offline state for CPUs")
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Remove helpers of extended_cede_processor()

Acked-by: Naveen N Rao <naveen@kernel.org>

> 
>  arch/powerpc/include/asm/plpar_wrappers.h | 28 -----------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
> index b3ee44a40c2f..71648c126970 100644
> --- a/arch/powerpc/include/asm/plpar_wrappers.h
> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
> @@ -18,16 +18,6 @@ static inline long poll_pending(void)
>  	return plpar_hcall_norets(H_POLL_PENDING);
>  }
>  
> -static inline u8 get_cede_latency_hint(void)
> -{
> -	return get_lppaca()->cede_latency_hint;
> -}
> -
> -static inline void set_cede_latency_hint(u8 latency_hint)
> -{
> -	get_lppaca()->cede_latency_hint = latency_hint;
> -}
> -
>  static inline long cede_processor(void)
>  {
>  	/*
> @@ -37,24 +27,6 @@ static inline long cede_processor(void)
>  	return plpar_hcall_norets_notrace(H_CEDE);
>  }
>  
> -static inline long extended_cede_processor(unsigned long latency_hint)
> -{
> -	long rc;
> -	u8 old_latency_hint = get_cede_latency_hint();
> -
> -	set_cede_latency_hint(latency_hint);
> -
> -	rc = cede_processor();
> -
> -	/* Ensure that H_CEDE returns with IRQs on */
> -	if (WARN_ON(IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && !(mfmsr() & MSR_EE)))
> -		__hard_irq_enable();
> -
> -	set_cede_latency_hint(old_latency_hint);
> -
> -	return rc;
> -}
> -
>  static inline long vpa_call(unsigned long flags, unsigned long cpu,
>  		unsigned long vpa)
>  {
> -- 
> 2.45.0
> 

