Return-Path: <linux-kernel+bounces-427979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B99E08C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA275170002
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4078F17ADE8;
	Mon,  2 Dec 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0IQbRZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2817A5A4;
	Mon,  2 Dec 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156293; cv=none; b=qAL6mZ6CdoqYR73imzyvjWogTjqjx6pWXOWs5R86KJ5ZwaslHgFf7NyiWEQ4cogNG6wAg2j+g93MDCzs84bWbJrNql0388cOZtSr9bIwchN+8L5+tczhBTF7JxZxudYUQKfkZqdMpJ8gi38tnAKQGW0QPLe4o6swFvcH2QCnBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156293; c=relaxed/simple;
	bh=K9RvKaeGIZciK0oc/lzLsRgwO2mx9HYeWzJYKl3YzOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfHuqBF0r9JTnqmTg3XpWdDxbaVECmVJxMH2okkVXVtNWeEjRAzUKrPBVyiCfKrPSKnEXL3O7FreMaiUQJnl1rtAeXxYrxauxEHjTWLMVsRtWImwmHII4EdfE6GfqGe/hpFciHPHmMFZM/ZqOzUtt73G6NXwRHVirUtF/V3JaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0IQbRZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E249CC4CED1;
	Mon,  2 Dec 2024 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733156293;
	bh=K9RvKaeGIZciK0oc/lzLsRgwO2mx9HYeWzJYKl3YzOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0IQbRZ4jPpo06QjiIwmloNh4UewG8aKvF2ThywKR6IQS6bhcsV4hzxZydYAQ19G9
	 TCipXDuc+2rEaaTGzVR35oiM1qj/2S1VHkU42GR0TAW5MiEOd8kzcIL5XYCxts82Rn
	 A19cmZsrpQX0jlSQF1VzhhVeY/jhsAl/gP0zb66OvVr+qXrzx+bKEo0Fc8bRhGtdv5
	 rZr2FPBO8Tp03LBSxSEOdoSRJRAoAjOUZPJI6IOaPgxYfx1QIlgW9X84Cd5DvlNpmA
	 +3cg5xUXMkLfJbKXomHP8AEuH/IbB1EYleNJ9VKheCBEpMx6KDl2Up1LWz0Fm5jcw+
	 DWMhucaJUJFHg==
Date: Mon, 2 Dec 2024 09:18:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] mm: vmstat.h: Annotate operations between enums
Message-ID: <20241202161811.GA2843691@thelio-3990X>
References: <20241202-fix-vmstat-v1-1-c995585b7df5@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-fix-vmstat-v1-1-c995585b7df5@chromium.org>

Hi Ricardo,

On Mon, Dec 02, 2024 at 04:02:19PM +0000, Ricardo Ribalda wrote:
> Compiler is confused when we do arithmetic operations between two
> different enum types.
> In this case NR_VM_STAT_ITEMS and NR_LRU_BASE are not actual
> enumerators, they are used to find the first and the count of the
> enumerator.
> 
> Add a casting to int, to avoid the following llvm 9 warning:
> ./include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>   504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>       |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>   505 |                            item];
>       |                            ~~~~
> ./include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>   511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>       |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>   512 |                            NR_VM_NUMA_EVENT_ITEMS +
>       |                            ~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>   518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>       |                               ~~~~~~~~~~~ ^ ~~~
> ./include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>   524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>       |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>   525 |                            NR_VM_NUMA_EVENT_ITEMS +
>       |                            ~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I think it is just better to disable this specific warning for normal
and W=1 builds so that it is not visible for people, as this objectively
makes the code uglier:

https://lore.kernel.org/20241008005136.GA241099@thelio-3990X/

https://lore.kernel.org/20241017-disable-two-clang-enum-warnings-v2-1-163ac04346ae@kernel.org/

I have just pinged that patch for acceptance.

Cheers,
Nathan

> ---
>  include/linux/vmstat.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index d2761bf8ff32..32c641d25bea 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -501,27 +501,26 @@ static inline const char *zone_stat_name(enum zone_stat_item item)
>  #ifdef CONFIG_NUMA
>  static inline const char *numa_stat_name(enum numa_stat_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> -			   item];
> +	return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS + item];
>  }
>  #endif /* CONFIG_NUMA */
>  
>  static inline const char *node_stat_name(enum node_stat_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> +	return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS +
>  			   NR_VM_NUMA_EVENT_ITEMS +
>  			   item];
>  }
>  
>  static inline const char *lru_list_name(enum lru_list lru)
>  {
> -	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
> +	return node_stat_name((int)NR_LRU_BASE + lru) + 3; // skip "nr_"
>  }
>  
>  #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
>  static inline const char *vm_event_name(enum vm_event_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> +	return vmstat_text[(int)NR_VM_ZONE_STAT_ITEMS +
>  			   NR_VM_NUMA_EVENT_ITEMS +
>  			   NR_VM_NODE_STAT_ITEMS +
>  			   NR_VM_STAT_ITEMS +
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241202-fix-vmstat-88968bcaa955
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
> 

