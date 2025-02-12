Return-Path: <linux-kernel+bounces-511455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD6A32B42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623BC1884D82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC66212FB3;
	Wed, 12 Feb 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssiqaj8b"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1D1D89E4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376834; cv=none; b=lmkGgrmPtODwtRM07xBYB3sNQN6pc0Qsjh6ogKW0XLNMJlEH/Gf3kpuHNJW9UPFoEQS85nSkGOBBColfhPMbsGcsD1n+dtpLmVoTN7R9X+xjpk6uYt40Avg6QKllI2Cc2Cw5QkohAlLBuzG0mpCq1bLkY6PzBADDBzg2xuJmVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376834; c=relaxed/simple;
	bh=eaqQ1KPDcaSO3s+GkFMNZ4xLOMCSPwH/klSMD0aEMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1f6v3UVWnWG+KE0UAeWy4W/bbfYLex8jCt+Yv9ODTaUgrVCICWQEwjmd5oBhM8xteIXTLjl2mOcW5PpiyYJeaYkZVBRL/5bN0/7nV7VAu6iDpwp0vieBaIwF2z6y36c5Lggjv3jJZp61d+KlKe9UQDC+y+o0zHfjfIwSy189G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssiqaj8b; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Feb 2025 16:13:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739376829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQjPm/FYeJonJ+z609Qz/2KCORZ2hGgk5RPersdsl3o=;
	b=ssiqaj8bx4Ch1HBsrZI8yA5xQdbQkDNsLfTdGX3yPmgCupk3UOsCaw/C2n/0gvVfVwJVlZ
	bwcgHov4uaQeFVvDfcA1haSFA0r00hzbX74WUnc5cXAGNsX01EcgV5xUa9LYxwnZZt/TmU
	tP+9+dhmPMdKDUhJZnmEVrBp5FZW9yA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/18] zram: remove crypto include
Message-ID: <Z6zIuC0Dv2pcwSDy@google.com>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-4-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212063153.179231-4-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 03:27:01PM +0900, Sergey Senozhatsky wrote:
> Remove a leftover crypto header include.

The subject and log is not very descriptive imo. We stop using
CRYPTO_MAX_ALG_NAME and define our own limit in zram, and removing the
include is just an artifact of that.

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zcomp.c    | 1 -
>  drivers/block/zram/zram_drv.c | 4 +++-
>  drivers/block/zram/zram_drv.h | 1 -
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index e83dd9a80a81..c393243eeb5c 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -8,7 +8,6 @@
>  #include <linux/sched.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
> -#include <linux/crypto.h>
>  #include <linux/vmalloc.h>
>  
>  #include "zcomp.h"
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 43f460a45e3e..12fb260e3355 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
>  static int zram_major;
>  static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
>  
> +#define ZRAM_MAX_ALGO_NAME_SZ	64
> +
>  /* Module params (documentation at end) */
>  static unsigned int num_devices = 1;
>  /*
> @@ -1149,7 +1151,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
>  	size_t sz;
>  
>  	sz = strlen(buf);
> -	if (sz >= CRYPTO_MAX_ALG_NAME)
> +	if (sz >= ZRAM_MAX_ALGO_NAME_SZ)
>  		return -E2BIG;
>  
>  	compressor = kstrdup(buf, GFP_KERNEL);
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 63b933059cb6..97c98fa07954 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -17,7 +17,6 @@
>  
>  #include <linux/rwsem.h>
>  #include <linux/zsmalloc.h>
> -#include <linux/crypto.h>
>  
>  #include "zcomp.h"
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

