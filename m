Return-Path: <linux-kernel+bounces-510621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1765A31FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231B7188729B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE9D1FF1B7;
	Wed, 12 Feb 2025 07:07:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBA1E9B04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344043; cv=none; b=TufnykzcWmujPj6zRmSIYVRC28wQhVOLWMNTsO9C9AmizrO1QnkJdjDe+BYLf5m19oxuCE7/w7JBwN6IVAEU+ZhsIpZAMJXkwaarY0Yg+rMH0SYh96b7Xx1U+iSADEFkSr1JxLTTjKU1NUR7gyVXo4wPxm3KF5GXBo0XvEpRbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344043; c=relaxed/simple;
	bh=QBinI3ZpmHPFKNWbZhPbEIoTL33xTki5lhOCx7pFcgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amSTZDKHj6HiY2MZwimKja3B3arX2NOAemB8HkybwNgDIo8ZQfRnIrlqXKO6mxcx/C1THg+vScQp42e4eTzY7CsKZidVUgcrYaZ2qr4EJSal3WVruujhC3hCIdqcs3pGFnCzL5f4B8iCAbwhkoAtyKKIhpQkvgit3Duwr3QJdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fac2f86ee90f11efa216b1d71e6e1362-20250212
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e3dd149b-2576-4b37-9dea-e55243a52ccc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-3
X-CID-INFO: VERSION:1.1.45,REQID:e3dd149b-2576-4b37-9dea-e55243a52ccc,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-3
X-CID-META: VersionHash:6493067,CLOUDID:91b523715575d846567a18ed804d03fa,BulkI
	D:250212131311UOV0929M,BulkQuantity:2,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|100|101|102|841,TC:nil,Content:0|52,EDM:-3,IP:nil,URL:0,File:nil,RT
	:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: fac2f86ee90f11efa216b1d71e6e1362-20250212
X-User: liuye@kylinos.cn
Received: from [172.30.70.73] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 232799130; Wed, 12 Feb 2025 15:07:11 +0800
Message-ID: <52fcd6b2-bbe1-4de7-85d1-1e5968f87e0d@kylinos.cn>
Date: Wed, 12 Feb 2025 15:07:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
To: Dev Jain <dev.jain@arm.com>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
 <1739340112672653.3.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <1739340112672653.3.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/2/12 13:12, Dev Jain 写道:
> 
> 
> On 12/02/25 8:28 am, Liu Ye wrote:
>> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
>> used. Write it as a macro definition to improve the readability and
>> maintainability of the code.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>   include/linux/mm.h | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 7b1068ddcbb7..750e75f45557 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>>   struct mmu_gather;
>>   struct inode;
>>   +#define FOLIO_ORDER(folio) ((folio)->_flags_1 & 0xff)
>> +
>>   /*
>>    * compound_order() can be called without holding a reference, which means
>>    * that niceties like page_folio() don't work.  These callers should be
>> @@ -1111,7 +1113,7 @@ static inline unsigned int compound_order(struct page *page)
>>         if (!test_bit(PG_head, &folio->flags))
>>           return 0;
>> -    return folio->_flags_1 & 0xff;
>> +    return FOLIO_ORDER(folio);
>>   }
>>     /**
>> @@ -1127,7 +1129,7 @@ static inline unsigned int folio_order(const struct folio *folio)
>>   {
>>       if (!folio_test_large(folio))
>>           return 0;
>> -    return folio->_flags_1 & 0xff;
>> +    return FOLIO_ORDER(folio);
>>   }
>>     #include <linux/huge_mm.h>
>> @@ -2061,7 +2063,7 @@ static inline long folio_nr_pages(const struct folio *folio)
>>   #ifdef CONFIG_64BIT
>>       return folio->_folio_nr_pages;
>>   #else
>> -    return 1L << (folio->_flags_1 & 0xff);
>> +    return 1L << FOLIO_ORDER(folio);
>>   #endif
>>   }
>>   @@ -2086,7 +2088,7 @@ static inline unsigned long compound_nr(struct page *page)
>>   #ifdef CONFIG_64BIT
>>       return folio->_folio_nr_pages;
>>   #else
>> -    return 1L << (folio->_flags_1 & 0xff);
>> +    return 1L << FOLIO_ORDER(folio);
>>   #endif
>>   }
>>   
> 
> Personally I do not think this is improving readability. You are introducing one more macro for people to decipher instead of directly seeing folio->_flags_1 & 0xff. This is similar to whether to write
> if (x) => do_stuff(), or if (x != 0) => do_stuff(). The former is more "readable" by convention but the latter makes it easier and obvious to understand.
> 
Or simply for maintenance purposes, if the meaning of a bit changes, only the macro definition needs to be modified.

Thanks，
Liu Ye



