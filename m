Return-Path: <linux-kernel+bounces-568687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CFA6994E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D83422D46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0CD21325D;
	Wed, 19 Mar 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4/G/4HE"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E681DF258
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412570; cv=none; b=oxsTf/Ac8JmI5hK0IB5PmzPvgozzjIVxzGKRYMskwzBzMrywC5R0+3SE3w2Jtt8tO1Xy9xeLi50hHIuoSGVVL9jNtXt5PbIKRq34DyK6RUMkHwlGDjTtsuqE+XuH7SdmFVlQg5YHz2mYrx6KTTkaeuVeX1pYkYckJLSNHGTavnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412570; c=relaxed/simple;
	bh=Ld3HYYiWGqYVc5VRd0H7gfiUDWambAI2d+C0bn9VRn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocm3PhJNAjUCQ5SAYPqX7Wpgdh3YrDZ3iLFqjmB5T1qBv3FlYqhcK0C8UWF6eR2jLzrRSSLBA0q2udmdBikSvJ9c3Q6tko+6+PrqmzBuXwWFi4UxI+CgneH0nQ4wwRCcmVgPLgUetCBiOUJ2YBMY2bsq3KoMtgXTsbuJTWSgrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4/G/4HE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742412555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lgoOXi1p75eg5oXGkctS0LJrHBVQGqCMdSovDcPhhkg=;
	b=T4/G/4HERbRFM9YBFd+s6xthzabUPztVYkfs1fm3qMfpaE7HLiGtc8TVu+XsRDN1Df1/J2
	hR7WtWNYHg8twv7tLerOZ52CRMBN9rbr80pEW6kuhwSf7Nmjzu3QCZrLrDm82QATRLgYg1
	DVmXDRPpVWDHuA6piZbfcWa0yKTjFV4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 1/5] Kconfig: add SWAP_CHARGE_V1_MODE config
Message-ID: <edbqzi3hqfvkr36pawvjkrogjmjzxnhs5fcbye4oacyxye2s4h@vwq4ic7xzjoc>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-2-jingxiangzeng.cas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319064148.774406-2-jingxiangzeng.cas@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 02:41:44PM +0800, Jingxiang Zeng wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Added SWAP_CHARGE_V1_MODE config, which is disabled by default.
> When enabled in cgroupv2 mode, the memory accounting method of
> swap will be restored to cgroupv1 mode.
> 
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> ---
>  include/linux/memcontrol.h |  6 ++++++
>  init/Kconfig               | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 53364526d877..dcb087ee6e8d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -62,6 +62,12 @@ struct mem_cgroup_reclaim_cookie {
>  
>  #ifdef CONFIG_MEMCG
>  
> +/* Whether enable memory+swap account in cgroupv2 */
> +static inline bool do_memsw_account_on_dfl(void)
> +{
> +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> +}
> +

Please move the above to memcontrol-v1.h file.

>  #define MEM_CGROUP_ID_SHIFT	16
>  
>  struct mem_cgroup_id {
> diff --git a/init/Kconfig b/init/Kconfig
> index 7f67d8942a09..669e39214244 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1012,6 +1012,22 @@ config MEMCG_V1
>  
>  	  Say N if unsure.
>  
> +config MEMSW_ACCOUNT_ON_DFL
> +	bool "Whether enable memory+swap account in cgroup v2"
> +	depends on MEMCG && MEMCG_V1
> +	default n
> +	help
> +	  Say Y here to enable memory+swap account in cgroup v2. Enabling this
> +	  option means that the semantics of memory.swap.max will align with
> +	  memory.memsw.limit_in_bytes, and memory.swap.current will align with
> +	  memory.memsw.usage_in_bytes.
> +	  This is particularly useful for workloads that require strict memory
> +	  and swap limits.
> +
> +	  If you are unsure whether to enable this option, it is recommended
> +	  to leave it disabled (N) unless you specifically need memory and swap
> +	  accounting features in your cgroup v2 setup.
> +
>  config BLK_CGROUP
>  	bool "IO controller"
>  	depends on BLOCK
> -- 
> 2.41.1
> 

