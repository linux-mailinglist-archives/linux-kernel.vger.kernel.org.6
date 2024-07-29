Return-Path: <linux-kernel+bounces-266053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B218393F9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAD21C21F73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C015CD46;
	Mon, 29 Jul 2024 15:53:54 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA78004F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268434; cv=none; b=rjZwXqZpRJ96LvXz34/525h+I4Hd51sXsD5RSG4TPNDPPY/pcpUAGQJu+rG1RNLwxqzBgx6HHyuD+vIb0R34Bf2QTllY0gv/GMxfvV+5EeK7iygPdIIUBx3xu/o6V/WI2xFmaR5zZq9AEMSEN/OFM/1NT+TD5TPu5yUSiPH10PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268434; c=relaxed/simple;
	bh=d90sHxRYX3H/y/PoRA4nPTN4ZYPcwBKZRwbFDTttc1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE3vb077m1aLgM7GM65jJltN160lWSwoi786srBl7LxY0Sw0E2fU6Ef3CUfONXGKao3PZJDYt+lsT11wI9s1uOmA61EbcCssDKhGagDp6MIH/AK9nxwyEqyrD9NCFR82LOe0x3nWoBDf9wo1x93bylAXsSyl49wmtlaEmA5Viuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4WXj9H56Hvz9v7Hp
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:35:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id ABA55140DAE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:53:37 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4X1uqdmn7gkAA--.4420S2;
	Mon, 29 Jul 2024 16:53:37 +0100 (CET)
Message-ID: <cd5a269a-9c6a-a311-d796-ce65c935887b@huaweicloud.com>
Date: Mon, 29 Jul 2024 17:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
Content-Language: en-US
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
 <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
 <f93f140b-13bc-4d00-adee-46cc1c016480@rowland.harvard.edu>
 <4792c9e7-2594-3600-5d82-4cb1443fe670@huaweicloud.com>
 <d6a76968-d10b-c60b-245a-f58116eca6af@huaweicloud.com>
 <eb9548de-e66e-3dcd-9136-8702a5bc2934@huaweicloud.com>
 <00f58d20-f92d-461e-beac-b307905cab3b@huaweicloud.com>
 <e45bd166-348a-95b6-c17c-dcd2525f263c@huaweicloud.com>
 <9ac4a586-ef37-4c48-8e66-df3d02b53b6a@huaweicloud.com>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <9ac4a586-ef37-4c48-8e66-df3d02b53b6a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXm4X1uqdmn7gkAA--.4420S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw13AryDurykJFykur1Dtrb_yoWrCF1UpF
	y5JF45Krs7tr4xJrn2yrn5XF12qFW7tF15Xr15trZrKr90yry5tr4Yyr4YkFyqvrs3Xr42
	vrWUt34xZFyUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRH
	UDLUUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 7/29/2024 5:44 PM, Jonas Oberhauser wrote:
> 
> 
> Am 7/29/2024 um 5:19 PM schrieb Hernan Ponce de Leon:
>> On 7/29/2024 4:45 PM, Jonas Oberhauser wrote:
>>>
>>>
>>> Am 7/29/2024 um 3:30 PM schrieb Hernan Ponce de Leon:
>>>> On 7/12/2024 10:06 AM, Hernan Ponce de Leon wrote:
>>>>> On 6/10/2024 10:38 AM, Hernan Ponce de Leon wrote:
>>>>>> On 6/8/2024 3:00 AM, Alan Stern wrote:
>>>>>>> On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
>>>>>>>>> Just to clarify: Your first step encompasses patches 1 - 3, and 
>>>>>>>>> the
>>>>>>>>> second step is patch 4.  The first three patches can be applied 
>>>>>>>>> now, but
>>>>>>>>> the last one needs to wait until herd7 has been updated.  Is 
>>>>>>>>> this all
>>>>>>>>> correct?
>>>>>>>>
>>>>>>>> Exactly.
>>>>>>>
>>>>>>> With regard to patch 4, how much thought have you and Hernan 
>>>>>>> given to
>>>>>>> backward compatibility?  Once herd7 is changed, old memory model 
>>>>>>> files
>>>>>>> will no longer work correctly.
>>>>>>>
>>>>>>
>>>>>> Honestly, I did not think much about this (at least until Akira 
>>>>>> mentioned in my PR). My hope was that changes to the model could 
>>>>>> be back-ported to previous kernel versions. However that would not 
>>>>>> work for existing out-of-tree files.
>>>>>>
>>>>>> My question is: is compatibility with out-of-tree files really a 
>>>>>> requirement? I would argue that if people are using outdated 
>>>>>> models, they may get wrong results anyway. This is because some of 
>>>>>> the changes done to lkmm during the last few years change the 
>>>>>> expected result for some litmus tests.
>>>>>>
>>>>>> Hernan
>>>>>
>>>>> I pushed some new changes to the code for backward compatibility 
>>>>> [1]. The series also needs the patch at the bottom to properly deal 
>>>>> with the ordering of failing CAses and non-returning operations. 
>>>>> With it, all litmus tests return the correct result (the script 
>>>>> needs to pass option -lkmm-legacy false to herd).
>>>>
>>>> I have been playing around with an alternative to this.
>>>>
>>>> Rather than implementing this as an "option", I can implemented it 
>>>> as a "model variant (*)" and add this to the model
>>>
>>> How exactly do these model variants get selected?
>>>
>>> I was thinking that another good approach could be to have a new 
>>> generic C model which doesn't know anything about LKMM. I believe 
>>> this would be specified in the header of the .litmus files?
>>>
>>>
>>>> flag ~empty (if "lkmmlatest" then 0 else _)
>>>>    as new-lkmm-models-require-variant-lkmmlatest
>>>>
>>>> If the user forgets to set the variant for the new model, herd7 will 
>>>> flag the executions showing that something is off.
>>>>
>>>> To be fully backward compatible, we would need to backport this to 
>>>> old models
>>>>
>>>> flag ~empty (if "lkmmlatest" then 1 else _)
>>>>    as new-lkmm-models-require-variant-lkmmlatest
>>>
>>> should this be then _ else 0  ? or what does the _ do here?
>>
>> Yes, my bad.
>>
>>>
>>> I also don't think we can backport things to old models
>>
>> IIRC I have seen (non lkmm related) patches being backported to stable 
>> kernel versions. Why can't we do this for lkmm if backward 
>> compatibility is really a requirement? Otherwise I don't see a way of 
>> preventing developers to use old models with the new option (since I 
>> plan to keep the "old variant" as default, this would have to be done 
>> on purpose, but still).
> 
> I don't think this is a problem. If the old version is the default, and 
> we define it in the .cfg file for the tree version of LKMM, then it will 
> work correctly for both the old and new versions. People playing around 
> with Memory Models should be careful enough not to intentionally break 
> the model by passing bogus options.

The same was true for my implementation using the lkmm-legacy option 
rather than the model variant, but this was still considered to break 
backward compatibility.

https://github.com/herd/herdtools7/pull/865#issuecomment-2229930493

> 
> Of course, defining a new syntax identifier and putting it in all 
> headers would be more robust. But it's more work and I would only do 
> that if we really got rid of all the LKMM specifics.
> 
> Have fun,
>    jonas


