Return-Path: <linux-kernel+bounces-424194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C5C9DB17D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9846B21496
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29F5D8F0;
	Thu, 28 Nov 2024 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9yFp5Il"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D232134BD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732761149; cv=none; b=alvlhhNvobxiHlU0QVz7HJ0fXsqetIqFvwrIdUCaIU1ze5m8G9ojE1P2ObfKz37trdmYFDA5pmh7px4uHbWHpEdnOdEvyItaR+p0LeyN+ZjKFVQ+uRHCXN0Frg/9mYK7h2qFtgXckPB4v63NbA31RLz4xYDyXU7r+kfxBtcsXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732761149; c=relaxed/simple;
	bh=pUt0G2pTgBtD8Oxv5bDbUeB0qR4Z5G2NerF+Y0gnhL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+YzAr82iCOtT3kJzL0pJNYUHWtUngy2Xdot6lwpsGwc+zeMhWqw3JWeIkCVoDrGKT0OXjOQzMuPvXmQq4DVqSPYovlY5ydSCzfoYKbAcE63+hRvXIz3FTRK5m3atX3HGuQ9hujckYThXLTeXp/YUX9S0mVKnIfcVRWjhi3iUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9yFp5Il; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abedc173-0760-41fd-a73d-e84dccfc3209@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732761141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnffHKnBprsXvLH02UkVO9BmPdsjg3eRtoSxQDZ8h+s=;
	b=Z9yFp5Ilf+kf2Qx8CfWNnxrfu9HwMxI95bknJLcvEqnv7thAViIxQu8PJV74nP4zWtLXPV
	t4CWSACLrZH5wm/SNmRrhyDTU8x7KZ5ttOIpCuL63eKDqyRqVpoTrvGYLMGrmHZo9hDtDo
	CK9Ad7gNRlhfpRVwzWfGUtHIxBZthiQ=
Date: Thu, 28 Nov 2024 10:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/zswap: add LRU_STOP to comment about dropping the lru
 lock
To: Alice Ryhl <aliceryhl@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241127-lru-stop-comment-v1-1-f54a7cba9429@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241127-lru-stop-comment-v1-1-f54a7cba9429@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/11/27 21:53, Alice Ryhl wrote:
> This function has been able to return LRU_STOP since commit b49547ade38a
> ("mm/zswap: stop lru list shrinking when encounter warm region"). To
> reduce confusion, update the comment to also list LRU_STOP as an option.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>   mm/zswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..9718c33f8192 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1156,7 +1156,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>   
>   	/*
>   	 * It's safe to drop the lock here because we return either
> -	 * LRU_REMOVED_RETRY or LRU_RETRY.
> +	 * LRU_REMOVED_RETRY, LRU_RETRY or LRU_STOP.
>   	 */
>   	spin_unlock(&l->lock);
>   
> 
> ---
> base-commit: aaf20f870da056752f6386693cc0d8e25421ef35
> change-id: 20241127-lru-stop-comment-09dab2427b6e
> 
> Best regards,

