Return-Path: <linux-kernel+bounces-253141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1302E931D29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D931C21B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BE13CFA5;
	Mon, 15 Jul 2024 22:28:18 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C020EB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082497; cv=none; b=iQNE4/3dEuWohF14yZu6JFcj1A6aSp4r1M8U7wRT0NXwB29gVNGr6kgaknS0VPExpCHgexqhcec6rq4Y0NiE/q3rOoioA7ul2U0utDZcN7AIu0JyAK/dbsxkb/TpUGGHINoVVk7TUuvMToJqvJ1HTiwEBxArbz6OYcSIDtG71Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082497; c=relaxed/simple;
	bh=k9hsNumpl9JRsOLX+bY2tjkResNlEXIlcFwi0XSlhXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DciOPrFuY3gcqZR5xPL6u/D9G1Q6QUfhLT9CcjfUUyqfy8psKKEeQzvfgSCGkMQRTl7gyCtF9AsAdUDX4bIpsl9rTh08WmuDAurhhTrZqJili86Krkr5vu0hn3+lA2BySu5vvWmhBylRdOKyN4SEbGv9epW54hIlHRCeHvA+DE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea0a4e8cfso544269e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082493; x=1721687293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsit9J/lGQzgcJVZgdOzeNmTKfTbZWv5F1tvlczn9DI=;
        b=pTrBCTi5iSYAb0jDU/4NBjD+zoXI9/18eUPh8VvfsizWn7nbNhhMt1iW4FU+LGv5IB
         V5lhexOCu76y0zN1RY7OPeJhPqw1fUDePHFDGQNbVjQbTsg7EBh8YHDaOWmFHeMTo5ZX
         clqysnCDP40j2rJ2QkK/OEsExphZqFNXHF/z7Wr7aTCwJscE7mX0V4Q7VQBTvuLzwR+N
         qVd8m8zfVxRPBlkZ4X9PDfOjKFb6bdyUVy7EdnHjo8iC2rswX1sSnjMMump0p+TZ5kc2
         r5c6Wj14jKkP3vNoZrMLFofXg/ODhkoJWUCIUEohhzqSuLlDCgwbiLSZzUYfbvr0/RuE
         II5g==
X-Forwarded-Encrypted: i=1; AJvYcCUpiHPgJAXERQwbWiW4AacbWkw0vnA7qiQup5YW4eYgxxufl0tNhXr248rfwnzo0RYK49j9JH2GwB3jBjR+ruIMSgyYmaq97diD5CYJ
X-Gm-Message-State: AOJu0YyKtJPXdYoJgi27K1/GRWffKM1l24KmbYFRiPl3z1HZoVlA/eCM
	gFXOQ0VUzlxieqo9CwNL+6ogVtx8TBkE6Qqsi76we71nppQZjHS8
X-Google-Smtp-Source: AGHT+IG2MfKCJtfRqX2mA/PJVIBummHIZz/L2uZHJk4V9zProwzV3BXN7x0Skc+Dq+coH+wdR8Bbcg==
X-Received: by 2002:a2e:9e59:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2eef2dc0b7bmr3468451fa.5.1721082493205;
        Mon, 15 Jul 2024 15:28:13 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239876sm136929735e9.3.2024.07.15.15.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 15:28:12 -0700 (PDT)
Message-ID: <76fbe503-a8e7-47aa-9335-6e0a90cba4c2@grimberg.me>
Date: Tue, 16 Jul 2024 01:28:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme_core: scan namespaces asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2024 23:34, Stuart Hayes wrote:
> Use async function calls to make namespace scanning happen in parallel.
>
> Without the patch, NVME namespaces are scanned serially, so it can take
> a long time for all of a controller's namespaces to become available,
> especially with a slower (TCP) interface with large number of
> namespaces.
>
> It is not uncommon to have large numbers (hundreds or thousands) of
> namespaces on nvme-of with storage servers.
>
> The time it took for all namespaces to show up after connecting (via
> TCP) to a controller with 1002 namespaces was measured on one system:
>
> network latency   without patch   with patch
>       0                 6s            1s
>      50ms             210s           10s
>     100ms             417s           18s
>
> Measurements taken on another system show the effect of the patch on the
> time nvme_scan_work() took to complete, when connecting to a linux
> nvme-of target with varying numbers of namespaces, on a network of
> 400us.
>
> namespaces    without patch   with patch
>       1            16ms           14ms
>       2            24ms           16ms
>       4            49ms           22ms
>       8           101ms           33ms
>      16           207ms           56ms
>     100           1.4s           0.6s
>    1000          12.9s           2.0s

Not sure how common is the 1000 namespaces use-case, but the dozens of 
namespaces
seems compelling enough.

>
> On the same system, connecting to a local PCIe NVMe drive (a Samsung
> PM1733) instead of a network target:
>
> namespaces    without patch   with patch
>       1            13ms           12ms
>       2            41ms           13ms
>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> changes from V2:
>    * make a separate function nvme_scan_ns_async() that calls
>      nvme_scan_ns(), instead of modifying nvme_scan_ns()
>    * only scan asynchronously from nvme_scan_ns_list(), not from
>      nvme_scan_ns_sequential()
>    * provide more timing data in the commit message
>
> changes from V1:
>    * remove module param to enable/disable async scanning
>    * add scan time measurements to commit message
>
>
>   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 782090ce0bc1..dbf05cfea063 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2011-2014, Intel Corporation.
>    */
>   
> +#include <linux/async.h>
>   #include <linux/blkdev.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-integrity.h>
> @@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	}
>   }
>   
> +/*
> + * struct async_scan_info - keeps track of controller & NSIDs to scan
> + * @ctrl:	Controller on which namespaces are being scanned
> + * @next_idx:	Index of next NSID to scan in ns_list
> + * @ns_list:	Pointer to list of NSIDs to scan
> + */
> +struct async_scan_info {
> +	struct nvme_ctrl *ctrl;
> +	atomic_t next_idx;

next_nsid ?

> +	__le32 *ns_list;
> +};
> +
> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> +{
> +	struct async_scan_info *scan_info = data;
> +	int idx;
> +	u32 nsid;
> +
> +	idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
> +	nsid = le32_to_cpu(scan_info->ns_list[idx]);
> +
> +	nvme_scan_ns(scan_info->ctrl, nsid);
> +}
> +
>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   					unsigned nsid)
>   {
> @@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   {
>   	const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
> -	__le32 *ns_list;
> +	struct async_scan_info scan_info;

What initializes next_idx?

>   	u32 prev = 0;
>   	int ret = 0, i;
> +	ASYNC_DOMAIN(domain);
>   
> -	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> -	if (!ns_list)
> +	scan_info.ctrl = ctrl;
> +	scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> +	if (!scan_info.ns_list)
>   		return -ENOMEM;

I think you can leave the local variable ns_list as is, and just assign 
it to scan_info
after, its common practice to allocate to a local pointer and use it to 
init a struct member.

Plus it will make the patch diff simpler.

>   
>   	for (;;) {
> @@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>   			.identify.nsid		= cpu_to_le32(prev),
>   		};
>   
> -		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
> -					    NVME_IDENTIFY_DATA_SIZE);
> +		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
> +					   scan_info.ns_list,
> +					   NVME_IDENTIFY_DATA_SIZE);
>   		if (ret) {
>   			dev_warn(ctrl->device,
>   				"Identify NS List failed (status=0x%x)\n", ret);
>   			goto free;
>   		}
>   
> +		atomic_set(&scan_info.next_idx, 0);
>   		for (i = 0; i < nr_entries; i++) {
> -			u32 nsid = le32_to_cpu(ns_list[i]);
> +			u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
>   
>   			if (!nsid)	/* end of the list? */
>   				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
> +						&domain);
>   			while (++prev < nsid)
>   				nvme_ns_remove_by_nsid(ctrl, prev);
>   		}
> +		async_synchronize_full_domain(&domain);
>   	}
>    out:
>   	nvme_remove_invalid_namespaces(ctrl, prev);
>    free:
> -	kfree(ns_list);
> +	async_synchronize_full_domain(&domain);
> +	kfree(scan_info.ns_list);
>   	return ret;
>   }
>   


