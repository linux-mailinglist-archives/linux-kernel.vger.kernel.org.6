Return-Path: <linux-kernel+bounces-426808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF999DF8D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986ACB21157
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304D18EAD;
	Mon,  2 Dec 2024 02:13:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E36F9E6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733105581; cv=none; b=XvRiE37LSbRTECOqxW/WdHyvgTHm1Z2WlVerfHxAplRqEAOeUD/ljRIQq2PYNkt7Xi2MzoRznCwDkguHzr73XiR/hGShcJbE+P1jBSXbWS22SbHQPt+bIifwmC6ZH3bjT5BT2tTUoJt6bXvX4jc2R/B1ffHvDcsvSftY0Gy5PRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733105581; c=relaxed/simple;
	bh=o0mzDaCr9jfSE0FwdgHYxVgj75KGN9AulUGLeO3Vhu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fo/LXBzB20lZVaFMtEIiZ6prmlQbRBBUQU7rc2/aOsXm6ebgCxBip0aOZ2X66mj7I8edO2AGjtOgT30Da1KBRSCbmRMuKhEWNZodbo2RLQCapwK25VQy/ZW61m8BYSobJ30VJ71dUuc+yBvO9sx2N4IiL8nh8axa2Z6vjPm8jUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y1nMS0vQWz21mGv;
	Mon,  2 Dec 2024 10:11:16 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id D5D801402CB;
	Mon,  2 Dec 2024 10:12:50 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Dec 2024 10:12:50 +0800
Message-ID: <79fd4520-f974-76f7-f538-0c72dc8acd40@huawei.com>
Date: Mon, 2 Dec 2024 10:12:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v2 0/6] arm_mpam:
 Introduce the Narrow-PARTID feature for MPAM driver
Content-Language: en-US
To: Dave Martin <Dave.Martin@arm.com>
CC: <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <xiexiuqi@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <bobo.shaobowang@huawei.com>
References: <20241119135104.595630-1-zengheng4@huawei.com>
 <Zzyvbx9uubrLNv1C@e133380.arm.com>
 <c5c5de75-151b-e6bd-952e-606326b46e9a@huawei.com>
 <Z0SaMZ00MZ6288v8@e133380.arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Z0SaMZ00MZ6288v8@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)



On 2024/11/25 23:39, Dave Martin wrote:

>> The advantages of doing this are:
>>
>>    1. There is no need to modify or disrupt the existing resctrl layer
>>
>>     interface, ensuring that each control group has same resource
>>
>>     control functionality;
> 
> I don't think this is guaranteed.
> 
> If there is some MSC that does not have PARTID Narrowing support, and
> this MSC has a memory bandwidth control that the MPAM driver exposes
> through resctrl, then there is no way to configure that MSC that
> exhibits the behaviour that the resctrl user expects.
> 
> For a concrete example:
> 
> Suppose that n=8, and the user asks for P1 to be given 30% of system
> memory bandwidth.
> 
> On the affected MSC, P1 maps to eight PARTIDs, each with its own memory
> bandwidth regulation.
> 
> If the work that happens to be in M1_1 dominates P1's bandwith
> requirment, then PARTID_1_1 needs to be given 30% of total memory bandwidth.
> 
> If the work in P1 is evenly spread across M1_1, M1_2 ... M1_m, then
> they would each need to be given 30% / 8 = 3.75% of total memory
> bandwidth so that the total allocated bandwidth is 30%.
> 
> But we don't know how memory bandwidth consumption is distributed among
> M1_1, M2_2 etc., so there is no way to program the memory bandiwdth
> regulation on that MSC that guarantees the expected result of P1
> receiving 30% of the total available bandwidth.
> 
> 
> This means that on some hardware, a choice needs to be made: should the
> MPAM driver hide from resctrl any controls that have this problem, or
> should it disable the use of PARTID Narrowing for providing additional
> monitoring groups.
> 
> My concern is that the correct choice is likely to be use-case-
> dependent.
> 
> Do you have a view on this?

I understand your meaning and concerns, and this is indeed a problem.

 From a software perspective, I think the use cases should be limited. 
For scenarios where mata does not support narrow-partid, I tend to favor
disabling the narrow-partid feature in the driver for such scenarios.

 From a hardware perspective, MSCs, such as L2/L3, are designed with area
considerations in mind and choose to implement the narrow-partid feature.

MATA, on the other hand, is located on a different die and does not have 
similar concerns, often not considering the implementation of the 
narrow-partid feature, which makes this a rather thorny issue.

>>    2. MSCs that support narrow-partid (including intPARTID and reqPARTID)
>>
>>     and MSCs that do not support (only including PARTID) can share the
>>
>>     same PARTID space;
> 
> This seems like it may be problematic on some hardware, as I tried to
> explain above for point 1.
> 
> Note though, if the non-Narrowing MSCs only have bitmap-type controls,
> then sharing the PARTID space is harmless.  This comes about because
> because these controls explicitly allow contention: cache way 0 for
> example is contended between all the work that is allowed by MPAM to
> use this cache way.  Breaking up the work arbitrarily under different
> PARTIDs makes no difference in this case: the amount of work allocated
> to that cache way, and the amount of contention is still the same.
> 

Completely agree. MSCs without the narrow-partid feature, if they only 
have bitmap-type controls, can be compatible with the shared PARTID 
space scheme.

>>
>>    3. On the premise of ensuring the (1) point, the number of control
>>
>>     groups can be maximized, because users can always choose to make a
>>
>>     control group act as a sub-monitoring group under another control
>>
>>     group;
> 
> What do you mean by "control group" here?
> 
> resctrl's group hierarchy is strict: work is distributed across one or
> more control groups at the top level, and the work in each control
> group is further distributed across one or more monitoring groups
> within that control group.
> 
> There is no way to repurpose a resctrl control group is a monitoring
> group under some other control group.
> 
> Or were you referring to something else here?
> 

Apologies for my miscommunication.

What I meant to say is to use the extra PARTIDs of MSC (which do not support
the narrow-partid feature) as an expansion for number of sub-monitoring 
groups.

>>> 2) The resctrl core code uses CLOSIDs and RMIDs to identify control
>>> groups and monitoring groups.  If a particular driver wants to
>>> translate these into other values (reqPARTID, intPARTID, PMG) then it
>>> can do so, but this mapping logic should be encapsulated in the driver.
>>> This should be better for maintainability, since the details of the
>>> remapping will be arch-specific -- and in general not all arches are
>>> going to require it.  With this in mind, I think that changes in the
>>> resctrl core code would be minimal (perhaps no changes at all).
> 
>>    Yes, maintaining the interface of the resctrl core code unchanged is,
>> in essence, the (first) important constraint of the current MPAM code.
>> We try the best to keep all resctrl interfaces and ensure the existing
>> functionality of x86 RDT.
>>
>>    The only thing that falls short of being ideal (forgive me), is that
>> it introduces the sole new function resctrl_arch_alloc_rmid() into the
>> resctrl code (resctrl_arch_free_rmid() will be optimized away in the next
>> version, and there are no other new functions any more).
>>
>>    The resctrl_arch_alloc_rmid() is the result of several restructuring
>> iterations and it is one of the most critical points in the patch series.
> 
> I was concerned about the changes in patch 6 for example, where the new
> function task_belongs_to_ctrl_group() now has to look at more
> information that just rdtgroup->closid, in order to determine which
> control group a task belongs to.  This is precisely what
> resctrl_arch_match_closid() is supposed to do, using just the closid.
> 
> This suggests that the meaning of "closid" in the core code has been
> changed: if closid is the control group identifier, then each control
> group should have exactly one closid value.
> 
> 
> For comparison, you may want to take a look at the top 3 commits of
> this experimental branch:
> 
> https://git.gitlab.arm.com/linux-arm/linux-dm/-/commits/mpam/partid-pmg-remap/v0.2/head/?ref_type=heads
> 
> which attempts to do all the mapping within the MPAM driver instead.
> Note, the approach is a bit over-complicated and I decided that a
> simpler approach is needed.  But it may help to illustrate what I mean
> about keeping all the remapping out of the resctrl core code.
> 
> 

I understand your suggestion. I will consider refactoring the mapping 
relationships between closid/rmid and partid/reqpartid/intpartid/pmg.

In fact, I prepared a simplified version of v2 as v3. But in light of 
your suggestions, I decide to reconstruct the solution. At present, I'm 
not sure if I can completely isolated the mapping within the MPAM driver 
layer only. If my reconstructed version goes smoothly, I will reply ASAP.

>>> 4) If the mapping between reqPARTIDs and (CLOSID,RMID) pairs is static,
>>> is it necessary to track which reqPARTIDs are in use?  Would it be
>>> simpler to treat all n reqPARTIDs as permanently assigned to the
>>> corresponding CLOSID?
>>>
>>> If reqPARTID usage is not tracked, then every control change on MSCs
>>> that do not support PARTID Narrowing would need to be replicated across
>>> all reqPARTIDs corresponding to the affected resctrl control partition.
>>> But control changes are a relatively rare event, so this approach feels
>>> acceptable as a way of keeping the driver complexity down.  It partly
>>> depends on how large the "n" parameter can become.
>>    Yes, totally agree. I will try to remove the reqPARTID bitmap and
>> the resctrl_arch_free_rmid(). As mentioned, this will simplify the code
>> logic and reduce changes to the resctrl layer code.
>>
>>    Initially, to reduce the number of IPI interrupt, keep this resource
>> tracking until now, and I will prioritize optimization for the next
>> version.
>>   (In fact, the initial version of the patch set was dynamically allocated,
>> and during the code restructuring process, it was inevitable to retain
>> some of the original ideas.)
>>
>> Best regards,
>> Zeng Heng
>>
> 
> OK; fair enough.
> 
> This kind of feature could always be re-added later on if it proves to
> be important for performance in real use-cases, but it is probably best
> to keep things as simple as possible initially.
> 

Many thanks as always for your prompt reply and insightful suggestions.

Best Regards,
Zeng Heng


