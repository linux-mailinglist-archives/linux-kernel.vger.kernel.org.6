Return-Path: <linux-kernel+bounces-349836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9498FC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A91F21B22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C317547;
	Fri,  4 Oct 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iKsdWQ3A"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E38134D1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728006868; cv=none; b=cAoH8Jj6CRtL372EpL69kAzMb/PNIVvw9FlzZtpNRklCaSEhzFUUZI2yyPT17Dw2vtj1+e6wcrT+5AueZyFznfFJLswU6bxnDeZH08DtllxKNKe7OUrCZkBqZnCaAuDqh8OcWDi7cbmqSfjYmvTg9qgTpM8cQ3KCOMcI7uZvVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728006868; c=relaxed/simple;
	bh=atN6qSOHapkNDNM1pOjU4zYPXXOT3eQJsA7yB3twgis=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNcLjQuAT7C4JZIDCqOEjGLTjJnSsA7tR788mWryKvQgvqFOQA78U0Ul2/5npYZXfQMFLl8n8Poh1I1/GvYR2S8SvfXjubgvsBuhmN3auEiCpsnjk5ZRN4ZIw/CmnbaikVmjcvbQiH5GGb9ZtBHvSYiQeHo3bWppjeXby4VLmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=iKsdWQ3A; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id wOIhspTvrg2lzwXWTsMsov; Fri, 04 Oct 2024 01:54:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id wXWSswLHsmNYjwXWSs6Xbx; Fri, 04 Oct 2024 01:54:24 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=66ff4ad0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=IF2tD_PbCvr-fGPPTaoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vt4PmUivxb819zkb6zOIRD9RtOeOEpY6fOXiUKMFEpI=; b=iKsdWQ3AxaGRSMqNZzf8Yy7XHt
	cxArIQCJnFDQKHhbFjr2ZDrnPrS0yQS1WXFsGwK7fh7ZLM9FGU07tu8SBRdRbeHRZnimJFJSRKCaY
	mOw8Y5nvtrBx2jNRUkAJant2ddC7oe9bJikaly5EirbbVKG0zYolHFqHOSTc4IphFarjLtUN1+K10
	03fE+r8Jc13cA+MWUgnJpGuwcQ7htHlkfsDV8ExrFAfpK8jDfRjDR935m3U3ZZYQBKMwvCAqtdeX+
	8TMGSL+05ZJgwE6I34szTlA1tvApCjCx4JubfZsYGrKPEpcz0zdRW97/gnN7zJexfN5whuc8YwlPZ
	VZoe9Dhw==;
Received: from [201.172.174.147] (port=59556 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1swXWR-0009Il-2S;
	Thu, 03 Oct 2024 20:54:23 -0500
Message-ID: <674d86d6-4073-4630-b8b1-fe73ab7e995e@embeddedor.com>
Date: Thu, 3 Oct 2024 19:54:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: linux: Fix flex array member not at the end in
 bpf_empty_prog_array
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240930181700.22839-1-philipp.g.hortmann@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240930181700.22839-1-philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1swXWR-0009Il-2S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.174.147]:59556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHBfsaIhiyg+tKR5J8iFZv2SGjzIZBVENrXnWdhQD53ZEh9dI5GGAeBLfVNy2uVhqGs5Tp/yhnZfY/e4l/pHJR3Nnpiy2bIE9MeFvfvy05t7jrqqlXGP
 C7DJGCrUGXjDk6EcIUgh63YNzJ1pJ00bWucP0LzZAvweg4DGAhG7oEBTw/o45BBI14Zo1xrIx2IHFNa4xkvnIIE0bxLVeuoMG7+Hr6fG9Yq6ZHxnd/ZCZO2I



On 30/09/24 12:16, Philipp Hortmann wrote:
> Struct bpf_prog_array has a flex array member at the end and needs
> therefore to be last in struct bpf_empty_prog_array.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   include/linux/bpf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 19d8ca8ac960..1ce319045048 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2018,8 +2018,8 @@ struct bpf_prog_array {
>   };
>   
>   struct bpf_empty_prog_array {
> -	struct bpf_prog_array hdr;
>   	struct bpf_prog *null_prog;
> +	struct bpf_prog_array hdr;
>   };
>   
>   /* to avoid allocating empty bpf_prog_array for cgroups that

