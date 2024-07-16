Return-Path: <linux-kernel+bounces-253251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D09931EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481E028232E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6D79E0;
	Tue, 16 Jul 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FMU5MRqV"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31881876
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095977; cv=none; b=Y0T2BzNSjTkA5S7n09quG1o+s0FGulgHBkF6HoJ2P7ESJl9VioTeQib/j1XGY/BgOH1X0ezTJTB/RbuMJZmKle88KbFDUUxftxWG61GpxEuahdfxUc/f6Kg60Zubb9F1W0xEaVltirpn1yTOfLWxr1g8GU1dFAzGEjuyf6ba9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095977; c=relaxed/simple;
	bh=1/93/zNm6AeVY9EQeAYq84mgdF/NBgDByAl5Pf8K4no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBnKmGE4izKkJ9i8JL7X+R/jHMj/I7V5YZHfBxgVIr4+OLncGSljTlj5DSuAAlk/DewFpUiT2jSHfYNIL/wdcXWUWzPLstbWsKugS2mhMItQ/3Kjuy0J2SoEmefJqPg7g3LxtofUO/VUNP5P2j2gwfDKVCo8Z/qe+P1VrOaeE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FMU5MRqV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dan.carpenter@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721095972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUwgP6b0XLZ9LYeyGLdT+XvxAMFGp+mm7CM4eFLG6qk=;
	b=FMU5MRqV1j2i4xAzVGbOYSj1Q/4cZ74YnVVvz2mKeiQLY56+5UnIRtqY1cf5uug5+mJ4q4
	SYqti4oNX0EoCbPautk+HePpD8uxP5qiSv2Ap7Nkzb4/fA4+2rYXVIIZLb9UkhwLR1OQwi
	bDouv7XKGjhL/Uuf+cITME1LYaH1ukI=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-janitors@vger.kernel.org
Message-ID: <cc1a6407-1af8-44ea-9f99-fbcd94e8188d@linux.dev>
Date: Tue, 16 Jul 2024 10:12:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zswap: fix a white space issue
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c15066a0-f061-42c9-b0f5-d60281d3d5d8@stanley.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <c15066a0-f061-42c9-b0f5-d60281d3d5d8@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/16 04:23, Dan Carpenter wrote:
> We accidentally deleted a tab in commit f84152e9efc5 ("mm/zswap: use only
> one pool in zswap").  Add it back.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>   mm/zswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 66decab33d14..adeaf9c97fde 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -803,7 +803,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
>   		atomic_dec(&zswap_same_filled_pages);
>   	else {
>   		zswap_lru_del(&zswap_list_lru, entry);
> -	zpool_free(entry->pool->zpool, entry->handle);
> +		zpool_free(entry->pool->zpool, entry->handle);
>   		zswap_pool_put(entry->pool);
>   	}
>   	if (entry->objcg) {

