Return-Path: <linux-kernel+bounces-551023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E057A5670C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DA53B3129
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20848217F3D;
	Fri,  7 Mar 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOIPOpPR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FD20B7EF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348171; cv=none; b=HD9O4H8wbLrXzKlHFPpgCHT7wHB/9pdHQs+gZqprcjiiojRg7Il6HS3IaJZgqrD6wi+GhrtRk7+aRg1U+uKj9lgLLSCaHQCckkWY09+sibVrvRzuk1dmzOdkl4NXG7/xubVD9NnsQ8t5P6czefIGpr1ahMmntTdpj0p/GaWGAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348171; c=relaxed/simple;
	bh=xWPqk9op8LnEwmlIjCdkjHvP/Hn++itWoNVlPGjgD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtFxjExTXbb85tGIApO9CRBu7jQrrokmI9gLbbF5gZ0KJr7L/yEB9IoosE/9EFW7EK0Ce6YMZB+tMqtbWEU+KONjhuAiig/DEHpIwyx7RKo3FqvaKLxWo1Cvix4uNyMwtVssvhvLETaOz9i5f9iwhU4e+N3wpf7nfw1u1u1l8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOIPOpPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A27C4CED1;
	Fri,  7 Mar 2025 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741348170;
	bh=xWPqk9op8LnEwmlIjCdkjHvP/Hn++itWoNVlPGjgD0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOIPOpPRScSkBBWpACcCHzIeQ7Df26p4/UkVvS2xtl1ocCObM0Xs7uZm1ioI0Gw1e
	 9DE6BrVr/FClmspLwZdCAlepXTGaDAHhd7+pg1OMJhIzsyzsij0/eLj+Cc057RKFSg
	 45ctt28kGghGQjTOp0lDJbbNHYdJKYjAQK7y35j1MBTTPJ+wtqlFiKuuB0PXl5fj1v
	 bOKtyzaecBKE01Smn8C93ps+2Ktc+QDtUqYG2TpkO+lS19tjpDv2f6r4Lv8F0zO2/e
	 RDnZpt7UhNPEvegu8adScjTFq/ZGzly4HSnFIfH+K1HyirrD4778IdVQbhuo0UIsgP
	 2HuzoS4lWSpOw==
Date: Fri, 7 Mar 2025 12:49:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/asm: delete dummy variables in movdir64b()
Message-ID: <Z8rdRljzdRdh9hu6@gmail.com>
References: <20250307061203.3281-1-adobriyan@gmail.com>
 <20250307061203.3281-3-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307061203.3281-3-adobriyan@gmail.com>


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Cast to pointer-to-array instead.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  arch/x86/include/asm/special_insns.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index d349aa0f0a83..b24c6c945c38 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -215,13 +215,10 @@ static __always_inline void serialize(void)
>  /* The dst parameter must be 64-bytes aligned */
>  static inline void movdir64b(void *dst, const void *src)
>  {
> -	const struct { char _[64]; } *__src = src;
> -	struct { char _[64]; } *__dst = dst;
> -
>  	/*
>  	 * MOVDIR64B %(rdx), rax.
>  	 *
> -	 * Both __src and __dst must be memory constraints in order to tell the
> +	 * Both src and dst must be memory constraints in order to tell the
>  	 * compiler that no other memory accesses should be reordered around
>  	 * this one.
>  	 *
> @@ -230,8 +227,8 @@ static inline void movdir64b(void *dst, const void *src)
>  	 * I.e., not the pointers but what they point to, thus the deref'ing '*'.
>  	 */
>  	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> -		     : "+m" (*__dst)
> -		     :  "m" (*__src), "a" (__dst), "d" (__src));
> +		     : "+m" (*(char(*)[64])dst)
> +		     :  "m" (*(const char(*)[64])src), "a" (dst), "d" (src));

In what world is putting type casts inside asm() statements an 
improvement to the code?

Thanks,

	Ingo

