Return-Path: <linux-kernel+bounces-170763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8868BDBA9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5840928416F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBD78274;
	Tue,  7 May 2024 06:38:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7AA757E4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063912; cv=none; b=Q7p40Gzquaui5cZvblVFcF5wpNDbNMJjjUYw+BLeC2VGKw4vmpkR7lHICLFyzEY2bkXLOEYgG0alzTPkrU4Lu7AYMPePluPcGr539TBd0ZESL+yHsl8yPzeQ+LrAYoIma5ogwNf2DoeGce8b5R5BK2XBnsNyIyh3TyaWDv57S9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063912; c=relaxed/simple;
	bh=dEp3R47T5tHK8UzsdRnd6Hp9PzXbWW/9+dURtHMSmZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjmKNBWPAP40+gvSNJWDJfGSVHzLBp0QzGvYF+gklf8DWz7n/VboxoHDJCxJXpggaaCjhMpgc3j1Ma1FAFiCosz1EwdN9iy4eI9l3w/vowWONZbM+3UU+cWDJE8NSIJzq+tjiAkIn5qxlRyAPfcOuTf7V2HNURa58f7bVavaLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6508af400c3c11ef9305a59a3cc225df-20240507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9e0df8ec-e169-4d7f-bc05-3f8e2edcf482,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:16
X-CID-INFO: VERSION:1.1.37,REQID:9e0df8ec-e169-4d7f-bc05-3f8e2edcf482,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:16
X-CID-META: VersionHash:6f543d0,CLOUDID:c6ffa1d6dfb8b6ea58f8b2298f38ddf0,BulkI
	D:240506172954AHTO5EQK,BulkQuantity:6,Recheck:0,SF:17|19|43|74|64|66|38|24
	|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: 6508af400c3c11ef9305a59a3cc225df-20240507
X-User: lijun01@kylinos.cn
Received: from [172.30.60.202] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1905821853; Tue, 07 May 2024 14:38:20 +0800
Message-ID: <18342368-ce79-9820-26be-01834876fc9e@kylinos.cn>
Date: Tue, 7 May 2024 14:38:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Update the flush cache policy
Content-Language: en-US
To: Xi Ruoyao <xry111@xry111.site>, chenhuacai@kernel.org, kernel@xen0n.name,
 lvjianmin@loongson.cn, dongbiao@loongson.cn, zhangbaoqi@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240506092419.4109941-1-lijun01@kylinos.cn>
 <8a8135eb0f1dc724cfbb4402dc6daf08db5b0bc7.camel@xry111.site>
 <cbb24599-8b40-cd27-6ce7-215476c0ddf4@kylinos.cn>
 <cbd6ed9d5be1d7112d69117a72e0cb0081f9b64b.camel@xry111.site>
 <8809f5a7-de6e-0794-feab-726c26f87344@kylinos.cn>
 <cf5df629b88fe38ae04cfa5714b9de2a44792704.camel@xry111.site>
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <cf5df629b88fe38ae04cfa5714b9de2a44792704.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I guess, final the value of addr is not important, just all of addr must 
read once is very important,

so use two 'for()' and 'volatile' to flush all of addr  's cache, 
exactly as the name of the function is

"flush_cache_last_level".

在 2024/5/7 11:55, Xi Ruoyao 写道:
> On Tue, 2024-05-07 at 08:53 +0800, lijun wrote:
>> The value of addr changes very very quickly, and 'volatile' ensures that
>> every change can be read
> No, volatile has nothing to do with changing quickly or not.
>
> It's only useful when the compiler cannot know the change, for example
> it's changed by the hardware or another thread.
>
> And in the Linux kernel memory model for the hardware change you should
> use READ_ONCE/WRITE_ONCE instead (they are actually wrappers of volatile
> so in the kernel you should almost never need to directly use volatile),
> for the change from another thread using volatile is just wrong and you
> should use some atomic or locked operation instead.
>
> See
> https://www.kernel.org/doc/html/latest/process/volatile-considered-harmful.html.
>
> In this case I'd like to ask first: why won't a simple addr += cdesc-
>> linesz * cdesc->sets * cdesc->ways * 3 work?  Which value(s) of addr,
> cdesc, or cdesc->{linesz,sets,ways} may change w/o the compiler's
> knowledge?
>
>> 在 2024/5/6 18:17, Xi Ruoyao 写道:
>>> On Mon, 2024-05-06 at 18:08 +0800, lijun wrote:
>>>> volatile prevents compiler optimization by allowing the compiler
>>>>
>>>>     to reread the address value of addr every time
>>> But why is this ever needed?  What's wrong if the compiler optimizes
>>> it?
>>>
>>> If the problem is the compiler may optimize it to cdesc->ways * 3 *
>>> cdesc->sets * cdesc->linesz, unknowing cdesc->ways etc may magically
>>> change, you should use READ_ONCE(cdesc->ways) etc.
>>>
>>> I.e. use READ_ONCE on the expression which may magically change,
>>> instead
>>> of hacking addr.  addr won't magically change.
>>>
>>>> 在 2024/5/6 17:28, Xi Ruoyao 写道:
>>>>> On Mon, 2024-05-06 at 17:24 +0800, Li Jun wrote:
>>>>>> fix when LoongArch s3 resume, Can't find image information
>>>>>>
>>>>>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
>>>>>> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
>>>>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
>>>>>> ---
>>>>>>     arch/loongarch/mm/cache.c | 24 +++++++++++++++++++++++-
>>>>>>     1 file changed, 23 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/loongarch/mm/cache.c
>>>>>> b/arch/loongarch/mm/cache.c
>>>>>> index 6be04d36ca07..52872fa0e5d8 100644
>>>>>> --- a/arch/loongarch/mm/cache.c
>>>>>> +++ b/arch/loongarch/mm/cache.c
>>>>>> @@ -63,6 +63,28 @@ static void flush_cache_leaf(unsigned int
>>>>>> leaf)
>>>>>>     	} while (--nr_nodes > 0);
>>>>>>     }
>>>>>>     
>>>>>> +static void flush_cache_last_level(unsigned int leaf)
>>>>>> +{
>>>>>> +	u64 addr;
>>>>>> +	int i, j, nr_nodes, way_size;
>>>>>> +	struct cache_desc *cdesc =
>>>>>> current_cpu_data.cache_leaves
>>>>>> +
>>>>>> leaf;
>>>>>> +
>>>>>> +	nr_nodes = loongson_sysconf.nr_nodes;
>>>>>> +
>>>>>> +	addr = CSR_DMW1_BASE;
>>>>>> +	iocsr_write32(0x1, 0x280);
>>>>>> +	way_size = cdesc->sets * cdesc->linesz;
>>>>>> +	do {
>>>>>> +		for (i = 0; i < (cdesc->ways * 3); i++) {
>>>>>> +			for (j = 0; j < (cdesc->sets); j++) {
>>>>>> +				*(volatile u32 *)addr;
>>>>> ??? what does this line do?
>>>>>

