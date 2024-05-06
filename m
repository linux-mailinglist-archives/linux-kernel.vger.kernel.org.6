Return-Path: <linux-kernel+bounces-169643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C443A8BCBA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CC1F22DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7B14265F;
	Mon,  6 May 2024 10:08:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8B140366
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990101; cv=none; b=OvcTVJ8lisTeQ/iOgQynNppt/W1dciiQ6tpLBdgBcyF4EAo2uxdSXWYWHU9TuZKQ4HxWZiZ9fO0WmDnb1lwx4Uz9JON/6VbElHz+2suaF7JpEjgmCj2zD9u+0YqlOt4gOIyq6zXukemXthkzewzTH74mOYFdPpKuUcun/Xus4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990101; c=relaxed/simple;
	bh=5tt9UHxkjMRw9ZpmjC2bLDh0xKGB94yXOmNXH9DS2Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXkjcyX/NdEpxjdBk395TQnU3Wy0Gg7ESVwnvPHJYuKSIpkgY69QrmkLY7+hnEZdC59ONdToqlg4BpAuKi3Y76cknmfT9FIyEpKcfpDAy4bT7i52fvgM506m6crQipM+t5i+nsBxdHTNeENYrFhMdrsYlz5w6V2yeuUqEBsWZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8b6baaea0b9011ef9305a59a3cc225df-20240506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a472e662-3e4d-42be-9da1-17e8815f3882,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:1
X-CID-INFO: VERSION:1.1.37,REQID:a472e662-3e4d-42be-9da1-17e8815f3882,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:1
X-CID-META: VersionHash:6f543d0,CLOUDID:e470eda73e5737a57e1e885eb669231e,BulkI
	D:240506172954AHTO5EQK,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|43|74|64
	|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 8b6baaea0b9011ef9305a59a3cc225df-20240506
X-User: lijun01@kylinos.cn
Received: from [172.30.60.202] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1779528453; Mon, 06 May 2024 18:08:11 +0800
Message-ID: <cbb24599-8b40-cd27-6ce7-215476c0ddf4@kylinos.cn>
Date: Mon, 6 May 2024 18:08:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Update the flush cache policy
To: Xi Ruoyao <xry111@xry111.site>, chenhuacai@kernel.org, kernel@xen0n.name,
 lvjianmin@loongson.cn, dongbiao@loongson.cn, zhangbaoqi@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240506092419.4109941-1-lijun01@kylinos.cn>
 <8a8135eb0f1dc724cfbb4402dc6daf08db5b0bc7.camel@xry111.site>
Content-Language: en-US
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <8a8135eb0f1dc724cfbb4402dc6daf08db5b0bc7.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

volatile prevents compiler optimization by allowing the compiler

  to reread the address value of addr every time

在 2024/5/6 17:28, Xi Ruoyao 写道:
> On Mon, 2024-05-06 at 17:24 +0800, Li Jun wrote:
>> fix when LoongArch s3 resume, Can't find image information
>>
>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
>> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
>> ---
>>   arch/loongarch/mm/cache.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
>> index 6be04d36ca07..52872fa0e5d8 100644
>> --- a/arch/loongarch/mm/cache.c
>> +++ b/arch/loongarch/mm/cache.c
>> @@ -63,6 +63,28 @@ static void flush_cache_leaf(unsigned int leaf)
>>   	} while (--nr_nodes > 0);
>>   }
>>   
>> +static void flush_cache_last_level(unsigned int leaf)
>> +{
>> +	u64 addr;
>> +	int i, j, nr_nodes, way_size;
>> +	struct cache_desc *cdesc = current_cpu_data.cache_leaves +
>> leaf;
>> +
>> +	nr_nodes = loongson_sysconf.nr_nodes;
>> +
>> +	addr = CSR_DMW1_BASE;
>> +	iocsr_write32(0x1, 0x280);
>> +	way_size = cdesc->sets * cdesc->linesz;
>> +	do {
>> +		for (i = 0; i < (cdesc->ways * 3); i++) {
>> +			for (j = 0; j < (cdesc->sets); j++) {
>> +				*(volatile u32 *)addr;
> ??? what does this line do?
>

