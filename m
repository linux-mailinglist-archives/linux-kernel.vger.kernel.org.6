Return-Path: <linux-kernel+bounces-202176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EC08FC8BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6463D1F23984
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F919006E;
	Wed,  5 Jun 2024 10:14:14 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997918FC6F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582454; cv=none; b=r3Lr0esCbkKl23hcp+gH+lnlgnxOvFbXL4QFR0XYC7SemsBZ5k9WyiBtSkAOrPds+mSRr9t8srk7/mbCQx9PPcqwof804yYMS0tzaDNAxgaMxtQ+NUpG/RJSX9C2zbOrvg/bfaVIbeB8mLFQNZkPfssLdKZzyN42AFGFY5Gcv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582454; c=relaxed/simple;
	bh=NND9Bq19l6tIThaJCmjP0foh63weKcb1C19vc9ckFao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5afU8sKuWA7mCU1QkqMlXIwpS/kXOxx/nR0MYefYjeyZp/ApH44bqgwDk5T9QV6HacvC7w6GdhVpeKxSkX0eZuD8xyBZ12JO0qGyFITmVsRhWezgMYaD/J5/hkDnxD+DneN8GeHtH/pXK7nutCdsM9/mmqQUvVAvUEjcqBo3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VvMgT6qG2z9v7JM
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:32:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 286811404F5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:54:33 +0800 (CST)
Received: from [10.81.200.103] (unknown [10.81.200.103])
	by APP2 (Coremail) with SMTP id GxC2BwC3oyfKNWBmNTWTCQ--.2480S2;
	Wed, 05 Jun 2024 10:54:32 +0100 (CET)
Message-ID: <879ee1b3-46eb-40c8-9b2a-3f215e527f53@huaweicloud.com>
Date: Wed, 5 Jun 2024 11:54:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] tools/memory-model: Define applicable tags on
 operation in tools/...
To: Boqun Feng <boqun.feng@gmail.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <20240604160409.498190-1-jonas.oberhauser@huaweicloud.com>
 <Zl_oxj9-ypX0U2HZ@Boquns-Mac-mini.home>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Zl_oxj9-ypX0U2HZ@Boquns-Mac-mini.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwC3oyfKNWBmNTWTCQ--.2480S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr17urWxtFyxArWrtryftFb_yoW8tF1Dpr
	ykXayrKr9rtr1Sk397Xw1ruFW5Wa1rGFy5Jr9ag3s5Zryqgr1Iya1DWanxWF93JrWfJa1j
	vw4jqFyDGa1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 6/5/2024 um 6:25 AM schrieb Boqun Feng:
> On Tue, Jun 04, 2024 at 06:04:09PM +0200, Jonas Oberhauser wrote:
>> Herd7 transforms reads, writes, and read-modify-writes by eliminating
>> 'acquire tags from writes, 'release tags from reads, and 'acquire,
>> 'release, and 'mb tags from failed read-modify-writes. We emulate this
>> behavior by redefining Acquire, Release, and Mb sets in linux-kernel.bell
>> to explicitly exclude those combinations.
>>
>> Herd7 furthermore adds 'noreturn tag to certain reads. Currently herd7
>> does not allow specifying the 'noreturn tag manually, but such manual
>> declaration (e.g., through a syntax __atomic_op{noreturn}) would add
>> invalid 'noreturn tags to writes; in preparation, we already also exclude
>> this combination.
>>
>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> ---
>>   tools/memory-model/linux-kernel.bell | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
>> index dba6b5b6dee0..2f49993644ed 100644
>> --- a/tools/memory-model/linux-kernel.bell
>> +++ b/tools/memory-model/linux-kernel.bell
>> @@ -36,6 +36,13 @@ enum Barriers = 'wmb (*smp_wmb*) ||
>>   		'after-srcu-read-unlock (*smp_mb__after_srcu_read_unlock*)
>>   instructions F[Barriers]
>>   
>> +(* Remove impossible tags, such as Acquire on a store or failed RMW *)
> 
> This comment needs a bit help, "failed RMW"s still exist, they just
> don't provide ordering. How about:


Oh, I see how the comment can be misread. A smaller fix would be

"Acquire on a store or on a failed RMW"

but I actually like your longer explanation better, so I think I'll go 
with that.

> 
> (*
>   * Filter out syntactic annotations that don't provide the corresponding
>   * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
>   *)
> 
> ?
> 
> Regards,
> Boqun
> 
>> +let FailedRMW = RMW \ (domain(rmw) | range(rmw))
>> +let Acquire = Acquire \ W \ FailedRMW
>> +let Release = Release \ R \ FailedRMW
>> +let Mb = Mb \ FailedRMW
>> +let Noreturn = Noreturn \ W
>> +
>>   (* SRCU *)
>>   enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
>>   instructions SRCU[SRCU]
>> -- 
>> 2.34.1
>>


