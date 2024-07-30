Return-Path: <linux-kernel+bounces-266611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575494033A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D485C282F64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5B8C13;
	Tue, 30 Jul 2024 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qEseTiOI"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA433C8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302050; cv=none; b=K86am/5XtqpusOX9eSF6RRxrxisTxCt30/IvBIFLjMi6fbDamUua7+SnUSTUSpPRUuxEBMURjmNe0vaIQNCM9VizWP89UrqIJAvcCrgsgo8bz/L9D2zh+U6aT1EQQOfBlnwqWWwpld/BoB3zmr045pbhTtCncvxjYeCmsG7PfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302050; c=relaxed/simple;
	bh=sZOnK1aeLSOPpk9wS2utqsMObUtLnJUI/AIc757QsFY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DRDJKUt+/UQaG8J+PfqeyypR3Z6namvgq/WyIrWl49js9EcmknYiF0yNMaMoxisLCFLQ8/yvhKWiEcaid//ZC87MZA+K2H8s1YohTEk7PfsZk9E9pg2Wx0m4ZNofEopUHaD25S4dDn0yf386PcGL03hEzQWuop8RFUZDV6Ds41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qEseTiOI; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722302040; h=Message-ID:Subject:Date:From:To;
	bh=01UZHdydYYAgRYChk9eT/vFNzPkghP7L50ewNEGelrk=;
	b=qEseTiOIx/vjzlJHjqmlu1eDYgHH19q9L4RBXLdo3KZeTqKCgYvLPnkQfblz5Mhztxdn2JgHCCVSNZR6CcPhp5HDagYn8iYDIFD+bhAMAL8AcnOpAB3idOFdX2OkPHv4RrMTfcpIYDQSpIb/TwhYQ8YjPvUPVFAnDAv3nxIFIV4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0WBdZO0r_1722302039;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WBdZO0r_1722302039)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 09:13:59 +0800
Message-ID: <1722302031.9577713-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] tools/virtio:Fix the wrong format specifier
Date: Tue, 30 Jul 2024 09:13:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: eperezma@redhat.com,
 zhujun2@cmss.chinamobile.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com
References: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 24 Jul 2024 00:41:08 -0700, Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:
> The unsigned int should use "%u" instead of "%d".
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  tools/virtio/ringtest/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
> index 5a18b2301a63..e471d8e7cfaa 100644
> --- a/tools/virtio/ringtest/main.c
> +++ b/tools/virtio/ringtest/main.c
> @@ -276,7 +276,7 @@ static void help(void)
>  	fprintf(stderr, "Usage: <test> [--help]"
>  		" [--host-affinity H]"
>  		" [--guest-affinity G]"
> -		" [--ring-size R (default: %d)]"
> +		" [--ring-size R (default: %u)]"
>  		" [--run-cycles C (default: %d)]"
>  		" [--batch b]"
>  		" [--outstanding o]"
> --
> 2.17.1
>
>
>

