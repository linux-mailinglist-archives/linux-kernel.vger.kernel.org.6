Return-Path: <linux-kernel+bounces-265974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B493F88D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47721B212E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541B153812;
	Mon, 29 Jul 2024 14:46:27 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8C1DFFC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264387; cv=none; b=ErjapaI2FlU+rHVld3YX95nQq3LdH5qUooaHNRrjD1lpYCu01yMC0aIRO/lEGYQF9pF+fqhyvxJcWFtKZKgiE5EETc4SIFVOt1SQr+YS6pbio1GYnU2yGW0pkVOg2gGk7x+6Gcrbp08t12tUbF77B6Qs7Sx15LU8QhSJR4ryyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264387; c=relaxed/simple;
	bh=oHcq7nl0d+/qsLBV8ODB4Tv02gHyy9C2ctfYNWXMdIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy7IS/r8rSnMXqtHZ6en0iNQGFUkdeHfepvzwVffYTtM3s+1OAG89Q2R/jTX+Q23YXsly3whRFTfAzmjYJnJqz5KcfYJSPxSaTo18+tsXZMiOEGJd6Lv5aCWkMEysGm/X+3ayswhHwJved/wfEH5RV6kkj9b3eq5UYnuCjMngU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4WXggP2lSrz9v7Hm
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:27:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DD7D7140B31
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:46:12 +0800 (CST)
Received: from [10.45.144.33] (unknown [10.45.144.33])
	by APP2 (Coremail) with SMTP id GxC2BwCHpMEoq6dmpEAkAA--.5208S2;
	Mon, 29 Jul 2024 15:46:12 +0100 (CET)
Message-ID: <00f58d20-f92d-461e-beac-b307905cab3b@huaweicloud.com>
Date: Mon, 29 Jul 2024 16:45:58 +0200
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <eb9548de-e66e-3dcd-9136-8702a5bc2934@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCHpMEoq6dmpEAkAA--.5208S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1DJr45XFWkJr1rJFWkZwb_yoW5ArW5pF
	y5tFW3KFs7KF4ftr1Ikwnaqas2vF4xJF45XFn8trZrtr90vF9Ikr4Fyw1j9Fyq9rs3Wa1j
	vFsxt3s7Z3WDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
	7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjNtxUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 7/29/2024 um 3:30 PM schrieb Hernan Ponce de Leon:
> On 7/12/2024 10:06 AM, Hernan Ponce de Leon wrote:
>> On 6/10/2024 10:38 AM, Hernan Ponce de Leon wrote:
>>> On 6/8/2024 3:00 AM, Alan Stern wrote:
>>>> On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
>>>>>
>>>>>
>>>>> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
>>>>>> Just to clarify: Your first step encompasses patches 1 - 3, and the
>>>>>> second step is patch 4.  The first three patches can be applied 
>>>>>> now, but
>>>>>> the last one needs to wait until herd7 has been updated.  Is this all
>>>>>> correct?
>>>>>
>>>>> Exactly.
>>>>
>>>> With regard to patch 4, how much thought have you and Hernan given to
>>>> backward compatibility?  Once herd7 is changed, old memory model files
>>>> will no longer work correctly.
>>>>
>>>
>>> Honestly, I did not think much about this (at least until Akira 
>>> mentioned in my PR). My hope was that changes to the model could be 
>>> back-ported to previous kernel versions. However that would not work 
>>> for existing out-of-tree files.
>>>
>>> My question is: is compatibility with out-of-tree files really a 
>>> requirement? I would argue that if people are using outdated models, 
>>> they may get wrong results anyway. This is because some of the 
>>> changes done to lkmm during the last few years change the expected 
>>> result for some litmus tests.
>>>
>>> Hernan
>>
>> I pushed some new changes to the code for backward compatibility [1]. 
>> The series also needs the patch at the bottom to properly deal with 
>> the ordering of failing CAses and non-returning operations. With it, 
>> all litmus tests return the correct result (the script needs to pass 
>> option -lkmm-legacy false to herd).
> 
> I have been playing around with an alternative to this.
> 
> Rather than implementing this as an "option", I can implemented it as a 
> "model variant (*)" and add this to the model

How exactly do these model variants get selected?

I was thinking that another good approach could be to have a new generic 
C model which doesn't know anything about LKMM. I believe this would be 
specified in the header of the .litmus files?


> flag ~empty (if "lkmmlatest" then 0 else _)
>    as new-lkmm-models-require-variant-lkmmlatest
> 
> If the user forgets to set the variant for the new model, herd7 will 
> flag the executions showing that something is off.
> 
> To be fully backward compatible, we would need to backport this to old 
> models
> 
> flag ~empty (if "lkmmlatest" then 1 else _)
>    as new-lkmm-models-require-variant-lkmmlatest

should this be then _ else 0  ? or what does the _ do here?

I also don't think we can backport things to old models

> If the user (wrongly) sets the variant for an old model, the the 
> executions will be flagged.
> 
> Any thoughts?
> 
> Hernan
> 
> (*) This trick seems to be used for some arm models
> 
> https://github.com/herd/herdtools7/blob/master/herd/libdir/arm-models/mixed/ec.cat#L66C1-L67C67



