Return-Path: <linux-kernel+bounces-178581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C242B8C510B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3CB20907
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE212EBD4;
	Tue, 14 May 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhIZOkwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0755C0A
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684008; cv=none; b=bzldnraTssoLevwGSBT5fu9dOdz+Xj04nGvSCKH7QG4PCLFyv+fQbvR9WMncYJNFSoeMZS24iRoEA6nzRhTeKzvLZ0tJVvIFLDZ3rym8Ej2meGCWbRCNHKMVOEW0/WEp3Ti2MOcIwS3mNZ8VRFRGTXhFIjn4ExPfIpg72dEXOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684008; c=relaxed/simple;
	bh=aU1RwmVoZA1OHt1xQFp3L8EH8NSGi/JkZ+0wsLin0kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxYh29EzQEA5WMV28MfMdlfd8DtLjbJ1u7aF1xtb5XRuwJfDXku3OhzYJe3Ayp/6m7NUuXY87ulrWLq4o55mGLotcG/8JqcccnZnkOKzd5+cprt4QWlT6Or9vK9AqYMHrY4/wgIuvZGKvwu64qAPGPuklHm0EwOw8AGfNzTones=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhIZOkwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D3CC32781;
	Tue, 14 May 2024 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715684008;
	bh=aU1RwmVoZA1OHt1xQFp3L8EH8NSGi/JkZ+0wsLin0kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhIZOkwal34GZ1VVw0JrpLrXyv1VHEeYDo7S0XiBZcMN+jqcjxV7nvHqVk5nayOMj
	 EKELqxj/mmmPo/LD+JMHU5hOx1j7KnlWHfKYZjk9M48EwXTwIUCykA5kqnxgqQ+Ove
	 /2iBh+sMiwkGQFBn66lSDnO/sYhBjd/W5J4QQFnK47WLC8cqDl6YIKDYqNI/FKbdxZ
	 qDhKMClYu5SM0jfnrDM/qR6CN8hyjxZpu++QVR0oGKgVXZXCaEV89eWrwYAViqWK45
	 d1gCWgg4KHUukpzf/XAGOKd9fhBrytEaVnlwbMB/GJNI9Ri4QCW5p7Qtf37let0DDk
	 Qw3DeZDcZuFZg==
Date: Tue, 14 May 2024 16:20:04 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove the definition of unused cede
 function
Message-ID: <vfx2z4dn6afpkl4z7ygewadw7mohfd7l3tfazdya4sbxniurkg@vrubq25slkvs>
References: <20240514100507.271681-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514100507.271681-1-gautam@linux.ibm.com>

On Tue, May 14, 2024 at 03:35:03PM GMT, Gautam Menghani wrote:
> Remove extended_cede_processor() definition as it has no callers since
> commit 48f6e7f6d948("powerpc/pseries: remove cede offline state for CPUs")

extended_cede_processor() was added in commit 69ddb57cbea0 
("powerpc/pseries: Add extended_cede_processor() helper function."), 
which also added [get|set]_cede_latency_hint(). Those can also be 
removed if extended_cede_processor() is no longer needed.

- Naveen

> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/plpar_wrappers.h | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
> index b3ee44a40c2f..6431fa1e1cb1 100644
> --- a/arch/powerpc/include/asm/plpar_wrappers.h
> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
> @@ -37,24 +37,6 @@ static inline long cede_processor(void)
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

