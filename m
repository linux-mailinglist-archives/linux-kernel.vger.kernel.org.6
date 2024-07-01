Return-Path: <linux-kernel+bounces-235924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D791DB53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F0F1F2266C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597383CC1;
	Mon,  1 Jul 2024 09:23:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270A7CF39
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825832; cv=none; b=CASrWb6zW1phxvWvbvFBlhxg62tVbK3ZQTZB9EIbs2OTmcs2cMZTGyRanXGSjat0QztT9Zs2DXh03NaSDOFo+eA/W3qiVZmasyvotX7GWJvs3LDFZfriASUaJythK+nfBDR4yYsDvBcfKMXpMnPd50kokJdOB9KTIVjUnWyBxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825832; c=relaxed/simple;
	bh=Z4px4spfm6Wh5gEcHUzDtmXM+WL+7mH8MX2nH+C0EPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePD09n34zxtSFmteY1gDBQuwKCWZE3jCgtwkgusbTg4y4kzFzWiuN0DgefEN7i1UTqGiyFNdthqE0llGzazrIfKmIQBV0QwhuJy1Q+qgounNUgbi5xtKLJIdVDgNjInxCWypQRqYz4bdyIPMGkQSv6AWb/SyFxKCGu4/h/ktInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b78bbf4378b11ef93f4611109254879-20240701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:13c0e2da-aab1-4f07-b9bf-c24fa7a263a1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:13c0e2da-aab1-4f07-b9bf-c24fa7a263a1,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:be0518f9baa1d9b65e9bfc58a855e5b2,BulkI
	D:240701151641C3XG98L4,BulkQuantity:1,Recheck:0,SF:64|66|38|17|19|102,TC:n
	il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 9b78bbf4378b11ef93f4611109254879-20240701
X-User: zhaomengmeng@kylinos.cn
Received: from [172.29.156.86] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1003373823; Mon, 01 Jul 2024 17:23:42 +0800
Message-ID: <1141ee04-1466-d1c5-e2b7-8512e9f8f78c@kylinos.cn>
Date: Mon, 1 Jul 2024 17:23:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] mm: gup: add forward declaration for
 try_grab_folio_fast
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 yang@os.amperecomputing.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240701034052.9988-1-zhaomengmeng@kylinos.cn>
 <5b9dafac-1561-4dfa-a0ff-9445cddc0932@redhat.com>
Content-Language: en-US
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
In-Reply-To: <5b9dafac-1561-4dfa-a0ff-9445cddc0932@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/7/1 15:16, David Hildenbrand wrote:
> On 01.07.24 05:40, Zhao Mengmeng wrote:
>> try_grab_folio_fast() was used in gup_hugepte(), while itself was
>> defined after gup_hugepte(), so add a forward declaration to eliminate
>> the -Wimplicit-function-declaration warning.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202407010039.D3sIu3fu-lkp@intel.com/
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>> ---
>>   mm/gup.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 7439359d0b71..222b83a87d7d 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -488,6 +488,9 @@ static unsigned long hugepte_addr_end(unsigned
>> long addr, unsigned long end,
>>       return (__boundary - 1 < end - 1) ? __boundary : end;
>>   }
>>   +static struct folio *try_grab_folio_fast(struct page *page, int refs,
>> +                     unsigned int flags);
>> +
>
> This function should really be called "gup_fast_", just like all other
> gup_fast_ specific functions. I might send some follow-up cleanups later.
>
Yeah, looking forward to your patch. Besides, I have seen Yang's fix in

https://lore.kernel.org/linux-mm/CAHbLzkowMSso-4Nufc9hcMehQsK9PNz3OSu-+eniU-2Mm-xjhA@mail.gmail.com/T/#m7ff03bf88814d8352052fbd8a1c90fee0ba5b576

and it is better. So sorry to bother you all.


