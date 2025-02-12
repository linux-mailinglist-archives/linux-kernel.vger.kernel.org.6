Return-Path: <linux-kernel+bounces-510626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE528A31FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940951637B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F3201249;
	Wed, 12 Feb 2025 07:11:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930F1E7C32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344318; cv=none; b=SifQxzccG8dfota7Q3RTt4+fFg9v4LaWoL+TM8xSR/ZWs2uuQGptI+6hGYMEp2/gDovDvVPS6H8dXCJ/BLQasKaICjfjDMEe1yEi8e958rrNclMrakDT901wizmTYTlzrlMtVv9/OiWJYKinUOwZBDmrovzVLNq9VZxhH2e1sTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344318; c=relaxed/simple;
	bh=GJPdY5itbmQGjcWc9TSzKmlbHCws3oJAUihXTwLsbIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drnPK9pqUOYGFfKzy6evYxD37of+Qll6uX60uR+dYc+kAp/OsCUtmKnq17Zcc7ETcvMNzSfV/WXxl5zhFg6nZKTFBOYsWIv991ECRjuLgMXThcZkHgjxOC1Y8FX85D/+x06qI1lFTkNC7IxClUtlvKC+HVJXSmnVYm98drOInik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1774a2ae91011efa216b1d71e6e1362-20250212
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:638f534e-e92e-4ec0-86e3-0b026c1322ba,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:638f534e-e92e-4ec0-86e3-0b026c1322ba,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:b2009f6d2ef2126a1645f1d817ca7c41,BulkI
	D:250212131311UOV0929M,BulkQuantity:3,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|841,TC:nil,Content:0|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bul
	k:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a1774a2ae91011efa216b1d71e6e1362-20250212
X-User: liuye@kylinos.cn
Received: from [172.30.70.73] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2105293162; Wed, 12 Feb 2025 15:11:50 +0800
Message-ID: <ea27222c-1306-45d5-ad55-6d7780ada06b@kylinos.cn>
Date: Wed, 12 Feb 2025 15:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
To: Shivank Garg <shivankg@amd.com>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
 <50f02ce2-85f8-4dda-b3c4-ad3f20f8b9a2@amd.com>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <50f02ce2-85f8-4dda-b3c4-ad3f20f8b9a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/2/12 13:40, Shivank Garg 写道:
> On 2/12/2025 8:28 AM, Liu Ye wrote:
>> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
>> used. Write it as a macro definition to improve the readability and
>> maintainability of the code.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>  include/linux/mm.h | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 7b1068ddcbb7..750e75f45557 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
>>  struct mmu_gather;
>>  struct inode;
>>  
>> +#define FOLIO_ORDER(folio) ((folio)->_flags_1 & 0xff)
> 
> This folio order calculation is only valid for !large folios.
> When it's a single page (not a large folio), the memory is interpreted as struct page.
> 
> struct folio {
> ...
>         union {
>                 struct {
>                         unsigned long _flags_1;
>                         unsigned long _head_1;
>         /* public: */
>                         atomic_t _large_mapcount;
>                         atomic_t _entire_mapcount;
>                         atomic_t _nr_pages_mapped;
>                         atomic_t _pincount;
> #ifdef CONFIG_64BIT
>                         unsigned int _folio_nr_pages;
> #endif
>         /* private: the union with struct page is transitional */
>                 };
>                 struct page __page_1;
>         };
> ...
> }
> 
> I feel this to be risky, considering someone may directly use FOLIO_ORDER() macro
> without folio_test_large() check.
> 
> Correct macro should look like:
> 
> #define FOLIO_ORDER(folio) (folio_test_large(folio) ? ((folio)->_flags_1 & 0xff) : 0)
> 

Yes, this is safer.
At present, the positions using FOLIO-ORDER have been checked using folio_test_1arge or
test-bit (PG_cead,&folio ->flags), and these positions may need to be simplified.

> 
> Thanks,
> Shivank
>> +
>>  /*
>>   * compound_order() can be called without holding a reference, which means
>>   * that niceties like page_folio() don't work.  These callers should be
>> @@ -1111,7 +1113,7 @@ static inline unsigned int compound_order(struct page *page)
>>  
>>  	if (!test_bit(PG_head, &folio->flags))
>>  		return 0;
>> -	return folio->_flags_1 & 0xff;
>> +	return FOLIO_ORDER(folio);
>>  }
>>  
>>  /**
>> @@ -1127,7 +1129,7 @@ static inline unsigned int folio_order(const struct folio *folio)
>>  {
>>  	if (!folio_test_large(folio))
>>  		return 0;
>> -	return folio->_flags_1 & 0xff;
>> +	return FOLIO_ORDER(folio);
>>  }
>>  
>>  #include <linux/huge_mm.h>
>> @@ -2061,7 +2063,7 @@ static inline long folio_nr_pages(const struct folio *folio)
>>  #ifdef CONFIG_64BIT
>>  	return folio->_folio_nr_pages;
>>  #else
>> -	return 1L << (folio->_flags_1 & 0xff);
>> +	return 1L << FOLIO_ORDER(folio);
>>  #endif
>>  }
>>  
>> @@ -2086,7 +2088,7 @@ static inline unsigned long compound_nr(struct page *page)
>>  #ifdef CONFIG_64BIT
>>  	return folio->_folio_nr_pages;
>>  #else
>> -	return 1L << (folio->_flags_1 & 0xff);
>> +	return 1L << FOLIO_ORDER(folio);
>>  #endif
>>  }
>>  
> 

