Return-Path: <linux-kernel+bounces-266045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461A93F9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D998B1C218E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DF15A84D;
	Mon, 29 Jul 2024 15:44:47 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16919823A9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267887; cv=none; b=SDA5Gdx9rr9l78kFhsudhLyDko55gJ9aWn4AtRQdTyJMLJIm+w0W7zYouufyOu3+CHRqJbO11jWdP1GbRaj18Egfp78FcnQsJn5rZoHSCpl5/M0d5lQveaadVB/6EpIaztjtTSsL6Om+14JGHmjPHUpuwviWXFY0zmdamBxJxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267887; c=relaxed/simple;
	bh=GeCTtz/LXSesm0O9iEhYfbhMk5z0S+5Y3N6jtI57iaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwabWHexv3Z1pRAwswfBk/o74d5LYjypWItONoVmNhY+bew3OtUr1iv1HEq1ZyZ9yo+t1vaMAwqQo/PJp+MP6FjgVUpEhMs/3eOR45eet43nsmnxMFOtEnYskv2wQQKz1BaH9vauVyaZHZSobLlkpjULI6eXl0lKFp6oz7inCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4WXhym1vNVz9v7Hr
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:26:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B097C140413
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:44:36 +0800 (CST)
Received: from [10.45.144.33] (unknown [10.45.144.33])
	by APP2 (Coremail) with SMTP id GxC2BwC31MHYuKdm7vAkAA--.5591S2;
	Mon, 29 Jul 2024 16:44:36 +0100 (CET)
Message-ID: <9ac4a586-ef37-4c48-8e66-df3d02b53b6a@huaweicloud.com>
Date: Mon, 29 Jul 2024 17:44:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <e45bd166-348a-95b6-c17c-dcd2525f263c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC31MHYuKdm7vAkAA--.5591S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyxCrWkKF4xKr4fJFW8WFg_yoWrGw1UpF
	y5JF45Kr4ktr4fJrn2yr1rXFyavrWxtF15Xr15trWDKryqyry5tr4Yyr4YkFyq9rs3XF42
	vrWUt34xZFyDXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 7/29/2024 um 5:19 PM schrieb Hernan Ponce de Leon:
> On 7/29/2024 4:45 PM, Jonas Oberhauser wrote:
>>
>>
>> Am 7/29/2024 um 3:30 PM schrieb Hernan Ponce de Leon:
>>> On 7/12/2024 10:06 AM, Hernan Ponce de Leon wrote:
>>>> On 6/10/2024 10:38 AM, Hernan Ponce de Leon wrote:
>>>>> On 6/8/2024 3:00 AM, Alan Stern wrote:
>>>>>> On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
>>>>>>>
>>>>>>>
>>>>>>> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
>>>>>>>> Just to clarify: Your first step encompasses patches 1 - 3, and the
>>>>>>>> second step is patch 4.  The first three patches can be applied 
>>>>>>>> now, but
>>>>>>>> the last one needs to wait until herd7 has been updated.  Is 
>>>>>>>> this all
>>>>>>>> correct?
>>>>>>>
>>>>>>> Exactly.
>>>>>>
>>>>>> With regard to patch 4, how much thought have you and Hernan given to
>>>>>> backward compatibility?  Once herd7 is changed, old memory model 
>>>>>> files
>>>>>> will no longer work correctly.
>>>>>>
>>>>>
>>>>> Honestly, I did not think much about this (at least until Akira 
>>>>> mentioned in my PR). My hope was that changes to the model could be 
>>>>> back-ported to previous kernel versions. However that would not 
>>>>> work for existing out-of-tree files.
>>>>>
>>>>> My question is: is compatibility with out-of-tree files really a 
>>>>> requirement? I would argue that if people are using outdated 
>>>>> models, they may get wrong results anyway. This is because some of 
>>>>> the changes done to lkmm during the last few years change the 
>>>>> expected result for some litmus tests.
>>>>>
>>>>> Hernan
>>>>
>>>> I pushed some new changes to the code for backward compatibility 
>>>> [1]. The series also needs the patch at the bottom to properly deal 
>>>> with the ordering of failing CAses and non-returning operations. 
>>>> With it, all litmus tests return the correct result (the script 
>>>> needs to pass option -lkmm-legacy false to herd).
>>>
>>> I have been playing around with an alternative to this.
>>>
>>> Rather than implementing this as an "option", I can implemented it as 
>>> a "model variant (*)" and add this to the model
>>
>> How exactly do these model variants get selected?
>>
>> I was thinking that another good approach could be to have a new 
>> generic C model which doesn't know anything about LKMM. I believe this 
>> would be specified in the header of the .litmus files?
>>
>>
>>> flag ~empty (if "lkmmlatest" then 0 else _)
>>>    as new-lkmm-models-require-variant-lkmmlatest
>>>
>>> If the user forgets to set the variant for the new model, herd7 will 
>>> flag the executions showing that something is off.
>>>
>>> To be fully backward compatible, we would need to backport this to 
>>> old models
>>>
>>> flag ~empty (if "lkmmlatest" then 1 else _)
>>>    as new-lkmm-models-require-variant-lkmmlatest
>>
>> should this be then _ else 0  ? or what does the _ do here?
> 
> Yes, my bad.
> 
>>
>> I also don't think we can backport things to old models
> 
> IIRC I have seen (non lkmm related) patches being backported to stable 
> kernel versions. Why can't we do this for lkmm if backward compatibility 
> is really a requirement? Otherwise I don't see a way of preventing 
> developers to use old models with the new option (since I plan to keep 
> the "old variant" as default, this would have to be done on purpose, but 
> still).

I don't think this is a problem. If the old version is the default, and 
we define it in the .cfg file for the tree version of LKMM, then it will 
work correctly for both the old and new versions. People playing around 
with Memory Models should be careful enough not to intentionally break 
the model by passing bogus options.

Of course, defining a new syntax identifier and putting it in all 
headers would be more robust. But it's more work and I would only do 
that if we really got rid of all the LKMM specifics.

Have fun,
   jonas


