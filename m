Return-Path: <linux-kernel+bounces-172570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199EE8BF3CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D303328435E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04491637;
	Wed,  8 May 2024 00:45:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23838F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129102; cv=none; b=HfAZ6zR48NlpouosjexPPDlnQxbZu27vOozfwj9GLCzhlNHR+irEUziikCGPthRDIpcCsNt7573+cNzD+ES0CcsqNG7FYAy1CmXYgFCgOSu77LlxBKJVzm8Q2FIFueBR9pjSOrRGexL7Dwh7t/AeMbU5kLDvyjgqe7rs2FTfhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129102; c=relaxed/simple;
	bh=yfQw/3vqdF4+42mil5aRcLojxuwgAsyxYBx/zV3endY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TC85D2ovgNz7dO7mu+QvlsK+RZsak44YRY6s700/sW4huMv1k5Pn9QacXxqOzNy1FK/83uRWyrm+CQno17/I/TiE/BPyH58VrGtblOqeKMRy9ue2bMD5P8FKZqweHncs3hvbN3gqUjDoY/qkfyewu9zKzz6vFO4HTZj1ebkjogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 706b27a40cd311ef9305a59a3cc225df-20240508
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e66522b2-69bb-40e4-8a42-b1c626a2eeff,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.37,REQID:e66522b2-69bb-40e4-8a42-b1c626a2eeff,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ed6f28bb4c424293f5dd8bc025c82a57,BulkI
	D:240508083935XHS2JZ5I,BulkQuantity:0,Recheck:0,SF:44|64|66|38|24|17|19|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 706b27a40cd311ef9305a59a3cc225df-20240508
X-User: lijun01@kylinos.cn
Received: from [172.30.60.202] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1605079120; Wed, 08 May 2024 08:39:33 +0800
Message-ID: <9af195f9-c47c-a323-dcc8-9b0bb6926d7e@kylinos.cn>
Date: Wed, 8 May 2024 08:39:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] LoongArch: Update the flush cache policy
Content-Language: en-US
To: chenhuacai@kernel.org, kernel@xen0n.name, lvjianmin@loongson.cn,
 dongbiao@loongson.cn, zhangbaoqi@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240507074357.2156083-1-lijun01@kylinos.cn>
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <20240507074357.2156083-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Superseded.

在 2024/5/7 15:43, Li Jun 写道:
> fix when LoongArch s3 resume, Can't find image information
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> ---
>   arch/loongarch/mm/cache.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
> index 6be04d36ca07..89eeb9a97dd5 100644
> --- a/arch/loongarch/mm/cache.c
> +++ b/arch/loongarch/mm/cache.c
> @@ -63,6 +63,27 @@ static void flush_cache_leaf(unsigned int leaf)
>   	} while (--nr_nodes > 0);
>   }
>   
> +static void flush_cache_last_level(unsigned int leaf)
> +{
> +	u64 addr;
> +	int i, j, nr_nodes;
> +	struct cache_desc *cdesc = current_cpu_data.cache_leaves + leaf;
> +
> +	nr_nodes = loongson_sysconf.nr_nodes;
> +
> +	addr = CSR_DMW1_BASE;
> +	iocsr_write32(0x1, 0x280);
> +	do {
> +		for (i = 0; i < (cdesc->ways * 3); i++) {
> +			for (j = 0; j < (cdesc->sets); j++) {
> +				*(volatile u32 *)addr;
> +				addr += cdesc->linesz;
> +			}
> +		}
> +		addr += 0x100000000000;
> +	} while (--nr_nodes > 0);
> +}
> +
>   asmlinkage __visible void __flush_cache_all(void)
>   {
>   	int leaf;
> @@ -71,7 +92,7 @@ asmlinkage __visible void __flush_cache_all(void)
>   
>   	leaf = cache_present - 1;
>   	if (cache_inclusive(cdesc + leaf)) {
> -		flush_cache_leaf(leaf);
> +		flush_cache_last_level(leaf);
>   		return;
>   	}
>   

