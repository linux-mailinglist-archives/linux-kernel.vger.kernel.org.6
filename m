Return-Path: <linux-kernel+bounces-251644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45611930776
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 23:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D2A1C20E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B3145FE9;
	Sat, 13 Jul 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eb+pzN87"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A513BADF
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720906022; cv=none; b=VdfzUoc3ErNZkvnZsZlOskqzMG/7S/FtMLL02dOkMIAUQxtNb00LHHWHAhCWiX582sJgFbDWphjDvzBrght+ICj0QpRUvQl+c0CCLTX5zTBDQvPvB2EJOAXcPlSca7xodIu9zy9EMjf/awOUC8GSGD21tYWjcQDHCIvwdOSb1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720906022; c=relaxed/simple;
	bh=irueSeqs31TC3pWF9q4YX8it9LQcfV0MI+mLUMb7DK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD0WCYa7HhccmicUFRQrjXcdz1DhCrrb6cC+9dSi309RfbQXPvwi7es2ufU5gML9xdgh+wM5GdGJ9GAFmct7NIUyzHhr0aYohjyntsx7OXNvGg1D6epYA/wD9wpJvwk0R/4co+1rvNTumVIutFrRbnxwXWyhmUBRWuuDaT0DCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eb+pzN87; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: valdis.kletnieks@vt.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720906016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kBeePj1W5iBxlXATWc+ITusLHrfg+eDuL0wNTf5K8dg=;
	b=eb+pzN87a8HBoEoVFTQ7A+3OepNk1B3bvENZ8FwL/NT+X716F6ABasp5fHc5ghHRE2VZQf
	Ocg0yzFZCVZs8ERAb2jXgrx3alfAzeIwfMWyI3hH/y1yRZB7JYgSxYfPDKJXD/GNhFhRZf
	GNSazLU6emWLFpxs62D9ryTd3VqrBu8=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 13 Jul 2024 21:26:52 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix typo in Kconfig
Message-ID: <ZpLxHECzlRXsblBy@google.com>
References: <78656.1720853990@turing-police>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78656.1720853990@turing-police>
X-Migadu-Flow: FLOW_OUT

On Sat, Jul 13, 2024 at 02:59:50AM -0400, Valdis Kletnieks wrote:
> Fix typo in Kconfig help
> 
> Fixes: e93d4166b40a8 ("mm: memcg: put cgroup v1-specific code under a config option")
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!

> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 1c701db1033e..bd378757d0ac 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -984,7 +984,7 @@ config MEMCG_V1
>  	  going to shrink due to deprecation process. New deployments with v1
>  	  controller are highly discouraged.
>  
> -	  San N is unsure.
> +	  Say N if unsure.
>  
>  config BLK_CGROUP
>  	bool "IO controller"
> 

