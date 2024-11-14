Return-Path: <linux-kernel+bounces-409321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A929C8B45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E47288528
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16521FAC52;
	Thu, 14 Nov 2024 12:56:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184F1E4A6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588979; cv=none; b=SQ4XHmk+tWQhjrkXhMbrOPut7hJBkH6Ap4PmJdspBXPBBtJ3zGQWU4c7QomGu9JV3mfnE2FdsJRQkUAoDqOkxLLGO1Jl9+YWIexUSbth0X6FuMo5N8IuphuC6wz80l06YLLFTbED5gXBdBLny0zw5X1oxgHbdZNqGDAazTkrnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588979; c=relaxed/simple;
	bh=yKXqlA2kUQFDHdirirA5Ike4d+vNbGIRESPscLWPZ7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yu/c56cOKQc/UFaEv6wI41vokHvWs2ZjO9WpwK70mBzxVoQZtiF3yTo6NnBtVaQ+skmZai1QOg0wBifmpFl88Ox1lYrP/aYXxBs3VaAm4CKC2oH6ZNJCTwGVfZy+DD0mMTkhNwRMR0T9IhxtVMOiUkOPzGV38SGWorZkq6AJoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xq0Tj3MDdz10VmH;
	Thu, 14 Nov 2024 20:54:17 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id DD28B1400DC;
	Thu, 14 Nov 2024 20:56:12 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 14 Nov
 2024 20:56:11 +0800
Message-ID: <3ca4efb9-3cd2-4bee-8968-cb5d1e6a69a6@huawei.com>
Date: Thu, 14 Nov 2024 20:56:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYzXSBtbS92bXNjYW46IHN0b3AgdGhl?=
 =?UTF-8?Q?_loop_if_enough_pages_have_been_page=5Fout?=
To: =?UTF-8?B?6KejIOWSj+aihQ==?= <xieym_ict@hotmail.com>, Barry Song
	<21cnbao@gmail.com>
CC: Chen Ridong <chenridong@huaweicloud.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wangweiyang2@huawei.com" <wangweiyang2@huawei.com>, Michal Hocko
	<mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
	<yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, David Hildenbrand
	<david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Ryan Roberts
	<ryan.roberts@arm.com>
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
 <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
 <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
 <62bd2564-76fa-4cb0-9c08-9eb2f96771b6@huawei.com>
 <CAGsJ_4x=nqKFMqDmfmvXVAhQNTo1Fx-aQ2MoSKSGQrSCccqr3Q@mail.gmail.com>
 <28b3eae5-92e7-471f-9883-d03684e06d1b@huaweicloud.com>
 <CAGsJ_4yx8Z2w=FbBCUHtDa-=jDVDcdsBAHu26-LNeuOuquoOmg@mail.gmail.com>
 <c85a035b-70d2-47df-b2c3-db255c98f6ff@huawei.com>
 <CAGsJ_4yfpPoEnR2DOGcytEe0Xzuhq05W8Ncrb=z7OZ_icdWAww@mail.gmail.com>
 <CAGsJ_4z9YqZ0-KFfOMrSXZyt7QEeCp4MF1zLEXdzRNGJGnPqQA@mail.gmail.com>
 <ME0P300MB04140204BBE0CA183B3EBE968E562@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ME0P300MB04140204BBE0CA183B3EBE968E562@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/11/1 16:49, 解 咏梅 wrote:
> Hi Barry & Ridong
> 
> Small change for your solution.  Below is my navie idea :P
> 
> func shrink_page_list()
> {
>     loop for iterate the pages on page_list {
>          if (page is compound_page && page size > 32 * 4k)
>                try_lock(page);
>                call split_folio_to_list
>                return; // let move_folios_to_lru to push those splited pages back to the head of lru. and wait for the subsequent scan to handle those splited pages one by one
>     }
> }
> 
> BTW: page_unlock is called after folio_start_writeback. if swap backend is based on memory, it's synced I/O and __end_swap_bio_write will be called before the next try_lock(page) after pageout.
> That means, there's no racing between folio_end_writeback and shrink_page_list for synced swapout.
> 

Hi, Yongmei,
Sorry for the later reply, I have been busy with other job for while.
As Barry said: "We should ensure that pageout() is always called for all
subpages, regardless of whether an mTHP is split". Your solution will
not satisfy this either.

I am trying to follow  Barry's suggestion to adjust how the folio_list
is returned to the LRU. If the pages have been writeback completely,
move them to the tail of lru.

Thanks,
Ridong

> On Mon, Oct 21, 2024 at 11:09 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Mon, Oct 21, 2024 at 10:56 PM chenridong <chenridong@huawei.com> wrote:
>>>
>>>
>>>
>>> On 2024/10/21 17:42, Barry Song wrote:
>>>> On Mon, Oct 21, 2024 at 9:14 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2024/10/21 12:44, Barry Song wrote:
>>>>>> On Fri, Oct 11, 2024 at 7:49 PM chenridong <chenridong@huawei.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2024/10/11 0:17, Barry Song wrote:
>>>>>>>> On Thu, Oct 10, 2024 at 4:59 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Ridong,
>>>>>>>>>
>>>>>>>>> This should be the first version for upstream, and the issue only
>>>>>>>>> occurred when large folio is spited.
>>>>>>>>>
>>>>>>>>> Adding more CCs to see if there's more feedback.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2024/10/10 16:18, Chen Ridong wrote:
>>>>>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>>>>>
>>>>>>>>>> An issue was found with the following testing step:
>>>>>>>>>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y
>>>>>>>>>> 2. Mount memcg v1, and create memcg named test_memcg and set
>>>>>>>>>>       usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
>>>>>>>>>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.
>>>>>>>>>>
>>>>>>>>>> It was found that:
>>>>>>>>>>
>>>>>>>>>> cat memory.usage_in_bytes
>>>>>>>>>> 2144940032
>>>>>>>>>> cat memory.memsw.usage_in_bytes
>>>>>>>>>> 2255056896
>>>>>>>>>>
>>>>>>>>>> free -h
>>>>>>>>>>                  total        used        free
>>>>>>>>>> Mem:           31Gi       2.1Gi        27Gi
>>>>>>>>>> Swap:         1.0Gi       618Mi       405Mi
>>>>>>>>>>
>>>>>>>>>> As shown above, the test_memcg used about 100M swap, but 600M+ swap memory
>>>>>>>>>> was used, which means that 500M may be wasted because other memcgs can not
>>>>>>>>>> use these swap memory.
>>>>>>>>>>
>>>>>>>>>> It can be explained as follows:
>>>>>>>>>> 1. When entering shrink_inactive_list, it isolates folios from lru from
>>>>>>>>>>       tail to head. If it just takes folioN from lru(make it simple).
>>>>>>>>>>
>>>>>>>>>>       inactive lru: folio1<->folio2<->folio3...<->folioN-1
>>>>>>>>>>       isolated list: folioN
>>>>>>>>>>
>>>>>>>>>> 2. In shrink_page_list function, if folioN is THP, it may be splited and
>>>>>>>>>>       added to swap cache folio by folio. After adding to swap cache, it will
>>>>>>>>>>       submit io to writeback folio to swap, which is asynchronous.
>>>>>>>>>>       When shrink_page_list is finished, the isolated folios list will be
>>>>>>>>>>       moved back to the head of inactive lru. The inactive lru may just look
>>>>>>>>>>       like this, with 512 filioes have been move to the head of inactive lru.
>>>>>>>>>>
>>>>>>>>>>       folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
>>>>>>>>>>
>>>>>>>>>> 3. When folio writeback io is completed, the folio may be rotated to tail
>>>>>>>>>>       of lru. The following lru list is expected, with those filioes that have
>>>>>>>>>>       been added to swap cache are rotated to tail of lru. So those folios
>>>>>>>>>>       can be reclaimed as soon as possible.
>>>>>>>>>>
>>>>>>>>>>       folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>>>>>>>>>
>>>>>>>>>> 4. However, shrink_page_list and folio writeback are asynchronous. If THP
>>>>>>>>>>       is splited, shrink_page_list loops at least 512 times, which means that
>>>>>>>>>>       shrink_page_list is not completed but some folios writeback have been
>>>>>>>>>>       completed, and this may lead to failure to rotate these folios to the
>>>>>>>>>>       tail of lru. The lru may look likes as below:
>>>>>>>>
>>>>>>>> I assume you’re referring to PMD-mapped THP, but your code also modifies
>>>>>>>> mTHP, which might not be that large. For instance, it could be a 16KB mTHP.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>       folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>>>>>>>>>>       folioN51<->folioN52<->...folioN511<->folioN512
>>>>>>>>>>
>>>>>>>>>>       Although those folios (N1-N50) have been finished writing back, they
>>>>>>>>>>       are still at the head of lru. When isolating folios from lru, it scans
>>>>>>>>>>       from tail to head, so it is difficult to scan those folios again.
>>>>>>>>>>
>>>>>>>>>> What mentioned above may lead to a large number of folios have been added
>>>>>>>>>> to swap cache but can not be reclaimed in time, which may reduce reclaim
>>>>>>>>>> efficiency and prevent other memcgs from using this swap memory even if
>>>>>>>>>> they trigger OOM.
>>>>>>>>>>
>>>>>>>>>> To fix this issue, it's better to stop looping if THP has been splited and
>>>>>>>>>> nr_pageout is greater than nr_to_reclaim.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>>>>>> ---
>>>>>>>>>>     mm/vmscan.c | 16 +++++++++++++++-
>>>>>>>>>>     1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>>>>> index 749cdc110c74..fd8ad251eda2 100644
>>>>>>>>>> --- a/mm/vmscan.c
>>>>>>>>>> +++ b/mm/vmscan.c
>>>>>>>>>> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>>>>>>>>         LIST_HEAD(demote_folios);
>>>>>>>>>>         unsigned int nr_reclaimed = 0;
>>>>>>>>>>         unsigned int pgactivate = 0;
>>>>>>>>>> -     bool do_demote_pass;
>>>>>>>>>> +     bool do_demote_pass, splited = false;
>>>>>>>>>>         struct swap_iocb *plug = NULL;
>>>>>>>>>>
>>>>>>>>>>         folio_batch_init(&free_folios);
>>>>>>>>>> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>>>>>>>>
>>>>>>>>>>                 cond_resched();
>>>>>>>>>>
>>>>>>>>>> +             /*
>>>>>>>>>> +              * If a large folio has been split, many folios are added
>>>>>>>>>> +              * to folio_list. Looping through the entire list takes
>>>>>>>>>> +              * too much time, which may prevent folios that have completed
>>>>>>>>>> +              * writeback from rotateing to the tail of the lru. Just
>>>>>>>>>> +              * stop looping if nr_pageout is greater than nr_to_reclaim.
>>>>>>>>>> +              */
>>>>>>>>>> +             if (unlikely(splited && stat->nr_pageout > sc->nr_to_reclaim))
>>>>>>>>>> +                     break;
>>>>>>>>
>>>>>>>> I’m not entirely sure about the theory behind comparing stat->nr_pageout
>>>>>>>> with sc->nr_to_reclaim. However, the condition might still hold true even
>>>>>>>> if you’ve split a relatively small “large folio,” such as 16kB?
>>>>>>>>
>>>>>>>
>>>>>>> Why compare stat->nr_pageout with sc->nr_to_reclaim? It's because if all
>>>>>>> pages that have been pageout can be reclaimed, then enough pages can be
>>>>>>> reclaimed when all pages have finished writeback. Thus, it may not have
>>>>>>> to pageout more.
>>>>>>>
>>>>>>> If a small large folio(16 kB) has been split, it may return early
>>>>>>> without the entire pages in the folio_list being pageout, but I think
>>>>>>> that is fine. It can pageout more pages the next time it enters
>>>>>>> shrink_folio_list if there are not enough pages to reclaimed.
>>>>>>>
>>>>>>> However, if pages that have been pageout are still at the head of the
>>>>>>> LRU, it is difficult to scan these pages again. In this case, not only
>>>>>>> might it "waste" some swap memory but it also has to pageout more pages.
>>>>>>>
>>>>>>> Considering the above, I sent this patch. It may not be a perfect
>>>>>>> solution, but i think it's a good option to consider. And I am wondering
>>>>>>> if anyone has a better solution.
>>>>>>
>>>>>> Hi Ridong,
>>>>>> My overall understanding is that you have failed to describe your problem
>>>>>> particularly I don't understand what your 3 and 4 mean:
>>>>>>
>>>>>>> 3. When folio writeback io is completed, the folio may be rotated to tail
>>>>>>>     of lru. The following lru list is expected, with those filioes that have
>>>>>>>     been added to swap cache are rotated to tail of lru. So those folios
>>>>>>>   can be reclaimed as soon as possible.
>>>>>>>
>>>>>>>   folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>>>>>
>>>>>>   > 4. However, shrink_page_list and folio writeback are asynchronous. If THP
>>>>>>   >    is splited, shrink_page_list loops at least 512 times, which means that
>>>>>>   >    shrink_page_list is not completed but some folios writeback have been
>>>>>>   >    completed, and this may lead to failure to rotate these folios to the
>>>>>>    >  tail of lru. The lru may look likes as below:
>>>>>>
>>>>>> can you please describe it in a readable approach?
>>>>>>
>>>>>> i feel your below diagram is somehow wrong:
>>>>>> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>>>>>
>>>>>> You mentioned "rotate', how could "rotate" makes:
>>>>>> folioN512<->folioN511<->...filioN1 in (2)
>>>>>> become
>>>>>> filioN1<->...folioN511<->folioN512 in (3).
>>>>>>
>>>>>
>>>>> I am sorry for any confusion.
>>>>>
>>>>> If THP is split, filioN1, filioN2, filioN3, ...filioN512 are committed
>>>>> to writeback one by one. it assumed that filioN1,
>>>>> filioN2,filioN3,...filioN512 are completed in order.
>>>>>
>>>>> Orignal:
>>>>> folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
>>>>>
>>>>> filioN1 is finished, filioN1 is rotated to the tail of LRU:
>>>>> folioN512<->folioN511<->...filioN2<->folio1<->folio2...<->folioN-1<->folioN1
>>>>>
>>>>> filioN2 is finished:
>>>>> folioN512<->folioN511<->...filioN3<->folio1<->folio2...<->folioN-1<->folioN1<->folioN2
>>>>>
>>>>> filioN3 is finished:
>>>>> folioN512<->folioN511<->...filioN4<->folio1<->folio2...<->folioN-1<->folioN1<->folioN2<->filioN3
>>>>>
>>>>> ...
>>>>>
>>>>> filioN512 is finished:
>>>>> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>>>>
>>>>> When the filios are finished, the LRU might just like this:
>>>>> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>>>
>>>> understood, thanks!
>>>>
>>>> Let me try to understand the following part:
>>>>
>>>>> 4:
>>>>>    folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>>>>>    folioN51<->folioN52<->...folioN511<->folioN512
>>>>
>>>>   >  Although those folios (N1-N50) have been finished writing back, they
>>>>   >  are still at the head of lru. When isolating folios from lru, it scans
>>>>   >  from tail to head, so it is difficult to scan those folios again.
>>>>
>>>> What is the reason that "those folios (N1-N50) have finished writing back,
>>>> yet they remain at the head of the LRU"? Is it because their writeback_end
>>>> occurred while we were still looping in shrink_folio_list(), causing
>>>> folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
>>>> these folios, which are still in the "folio_list", to the tail of the LRU?
>>>>
>>>
>>> Yes, you are right.
>>>
>>>>>
>>>>>> btw, writeback isn't always async. it could be sync for zram and sync_io
>>>>>> swap. in that case, your patch might change the order of LRU. i mean,
>>>>>> for example, while a mTHP becomes cold, we always reclaim all of them,
>>>>>> but not part of them and put back part of small folios to the head of lru.
>>>>>>
>>>>>
>>>>> Yes, This can be changed.
>>>>> Although it may put back part of small folios to the head of lru, it can
>>>>> return in time from shrink_folio_list without causing much additional I/O.
>>>>>
>>>>> If you have understood this issue, do you have any suggestions to fix
>>>>> it? My patch may not be a perfect way to fix this issue.
>>>>>
>>>>
>>>> My point is that synchronous I/O, like zRAM, doesn't have this issue and
>>>> doesn't require this fix, as writeback is always completed without
>>>> asynchronous latency.
>>>>
>>>
>>> I have tested zRAM and found no issues.
>>> This is version 1, and I don't know whether this fix will be accepted.
> 
> Hi Ridong,
> 
> Let me clarify further. I don't believe this is the right fix for either
> asynchronous or synchronous I/O, as the coldness of the folios
> is being overlooked in both cases. It could lead to more refaults
> because cold memory isn't having pageout() executed with the
> earlier break you're trying to add, even though it works around
> the problem you're facing.
> 
> We should ensure that pageout() is always called for all subpages,
> regardless of whether an mTHP is split. However, we can adjust
> how the folio_list is returned to the LRU.
> 
>>> If it is accepted, perhaps this patch could be modified to apply only to
>>> asynchronous io.
>>
>> Consider a 2MB THP: when it becomes cold, we detect that it is cold and
>> decide to page it out. Even if we split it into 512 * 4KiB folios, the entire
>> 2MB is still cold, so we want pageout() to be called for the entire 2MB.
>> With your current approach, some parts of the 2MB are moved to the
>> LRU head while we're still paging out other parts, which seems
>> problematic.
>>
>> Could we address this in move_folios_to_lru()? Perhaps we could find
>> a way to detect folios whose writeback has done and move them to the
>> tail instead of always placing them at the head.
>>
>>>
>>> Best regards,
>>> Ridong
> 
> Thanks
> Barry

