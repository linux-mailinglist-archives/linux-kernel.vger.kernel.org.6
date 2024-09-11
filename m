Return-Path: <linux-kernel+bounces-325288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB6975779
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D49A287B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824851AC43E;
	Wed, 11 Sep 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1H+CCog"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1419CC19
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069688; cv=none; b=r71b12C/+mxy2JDL9Y/YCrmd+6prD7I/Otn9Bpfho4ONF2ZlYFBoYkwUh7JlMunFVCWJR5D07lVMcS97KBTDntyyRfyrkUhkXGM95KEHHzDq/QkfZMADZN8UJjsGD9I+BHARFzdFZmN8UbkZIWNm9EA4x/bkUVYEfzznf2bbef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069688; c=relaxed/simple;
	bh=fI3XQOxlFluHG72zXx7/N5FWclch0225esKChDMzphA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcWPxamE9IaRLGoNh7587cWQZSONs/ldLtFufj/MZuh8JdBPcNyU+mtpTxUt9VGZLETB5HDHDjyeEn+V4Z983RonVOiLylVJ+j8AWzfzmtG7ODk9S61s/5mj+t0cb3i/pYqZrkAeL6PJCmefDYRPABdHrSxH9vpfb0HJGCrdYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1H+CCog; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28de0e9b-bbe0-4b9d-bd22-8efe0f456ec1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726069683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvmloE06/v+am5tMLnrNeQIH8UZ8+bT+4FORftz19Pc=;
	b=r1H+CCogUs/QFDwnI+iZWWc3H3qvu2aQCseOfeo2xKG8kYIxrILoTnCVlq4FOHZsAPZYPv
	VmRU9fq/ebYVEo351u+GvUjYfsEaAzM0nrCCF2g7NrK4+q8NsZ2R5qCpCvBDDSKypJV+5I
	MA1IKmjTLmUm6zIIqIUtLvzxL1rn6B4=
Date: Wed, 11 Sep 2024 16:47:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: ethernet: ag71xx: Remove dead code
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Chris Snook <chris.snook@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240911135828.378317-1-usama.anjum@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240911135828.378317-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/09/2024 14:58, Muhammad Usama Anjum wrote:
> The err variable isn't being used anywhere other than getting
> initialized to 0 and then it is being checked in if condition. The
> condition can never be true. Remove the err and deadcode.
> 
> Move the rx_dropped counter above when skb isn't found.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Move the rx_dropped counter above when skb isn't found.
> ---
>   drivers/net/ethernet/atheros/ag71xx.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index db2a8ade62055..2effceeb191db 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1619,7 +1619,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
>   		unsigned int i = ring->curr & ring_mask;
>   		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
>   		int pktlen;
> -		int err = 0;
>   
>   		if (ag71xx_desc_empty(desc))
>   			break;
> @@ -1643,20 +1642,16 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
>   		skb = napi_build_skb(ring->buf[i].rx.rx_buf, ag71xx_buffer_size(ag));
>   		if (!skb) {
>   			skb_free_frag(ring->buf[i].rx.rx_buf);
> +			ndev->stats.rx_dropped++;
>   			goto next;
>   		}
>   
>   		skb_reserve(skb, offset);
>   		skb_put(skb, pktlen);
>   
> -		if (err) {
> -			ndev->stats.rx_dropped++;
> -			kfree_skb(skb);
> -		} else {
> -			skb->dev = ndev;
> -			skb->ip_summed = CHECKSUM_NONE;
> -			list_add_tail(&skb->list, &rx_list);
> -		}
> +		skb->dev = ndev;
> +		skb->ip_summed = CHECKSUM_NONE;
> +		list_add_tail(&skb->list, &rx_list);
>   
>   next:
>   		ring->buf[i].rx.rx_buf = NULL;


Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

