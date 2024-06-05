Return-Path: <linux-kernel+bounces-203140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29808FD6EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AB41C22750
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4E155359;
	Wed,  5 Jun 2024 19:59:09 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A4154452
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617549; cv=none; b=jnL2fMQWSjl3tGCXpFo75djptJygQJYwytYsAZ2eWcxczIlXSxgYejzCbhUNR2ANMprUjY9GFrRBJgVewUD0p+FnJgcnE9hPMhcIaX9JnhGTbLuZ8ZSNaZrNPO7iyHdGJbE1xiLn6Ml1U2oyxXERpXzIHS9WOWeodLKUqvb9Fqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617549; c=relaxed/simple;
	bh=y6xww9ta5Ut+yT5rnLQgc5PnpjLGuO3gstDiJD4or2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb8SNV5cEOG7+5W9sMWRRczdxJdl+nrWvd0lhF+HDUCWQeiZgj86c5H5uKGD5HCDLFvDUqKKV1R7In+NWgaoJNTQKo7ElFGR/cRFbQtDV0OkZ8ONgI2FS6QEh9ezNFClheQ9WIJQwRqHhmPPj7ke7xtsGIqUi7RMRab3EfvBBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vvd4h0TBtz9v7Jg
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:36:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E8724140445
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:58:57 +0800 (CST)
Received: from [10.81.202.105] (unknown [10.81.202.105])
	by APP1 (Coremail) with SMTP id LxC2BwBnXxh0w2BmBkmdCQ--.62044S2;
	Wed, 05 Jun 2024 20:58:57 +0100 (CET)
Message-ID: <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
Date: Wed, 5 Jun 2024 21:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
To: Alan Stern <stern@rowland.harvard.edu>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBnXxh0w2BmBkmdCQ--.62044S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxCryktr1DKr1DGry7GFg_yoW5GryrpF
	WrtayrKFs8Jr4293yxW397JFyYkayrGw13Grnaqwn5u3Z8WFy8tr4akF45ZF97urZ3W342
	vryUtrykX3WqyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bY-B_UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
> On Tue, Jun 04, 2024 at 05:29:18PM +0200, Jonas Oberhauser wrote:
>> Currently, the effect of several tag on operations is defined only in
>> the herd7 tool's OCaml code as syntax transformations, while the effect
>> of all other tags is defined in tools/memory-model.
>> This asymmetry means that two seemingly analogous definitions in
>> tools/memory-model behave quite differently because the generated
>> representation is sometimes modified by hardcoded behavior in herd7.
>>
>> It also makes it hard to see that the behavior of the formalization
>> matches the intuition described in explanation.txt without delving into
>> the implementation of herd7.
>>
>> Furthermore, this hardcoded behavior is hard to maintain inside herd7 and
>> other tools implementing WMM, and has caused several bugs and confusions
>> with the tool maintainers, e.g.:
>>
>>    https://github.com/MPI-SWS/genmc/issues/22
>>    https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904
>>    https://github.com/hernanponcedeleon/Dat3M/issues/254
>>
>> It also means that potential future extensions of LKMM with new tags may
>> not work without changing internals of the herd7 tool.
>>
>> In this patch series, we first emulate the effect of herd7 transformations
>> in tools/memory-model through explicit rules in .cat and .bell files that
>> reference the transformed tags.
>> These transformations do not have any immediate effect with the current
>> herd7 implementation, because they apply after the syntax transformations
>> have already modified those tags.
>>
>> In a second step, we then distinguish between syntactic tags (that are
>> placed by the programmer on operations, e.g., an 'ACQUIRE tag on both the
>> read and write of an xchg_acquire() operation) and sets of events (that
>> would be defined after the (emulated) transformations, e.g., an Acquire
>> set that includes only on the read of the xchg_acquire(), but "has been
>> removed" from the write).
>>
>> This second step is incompatible with the current herd7 implementation,
>> since herd7 uses hardcoded tag names to decide what to do with LKMM;
>> therefore, the newly introduced syntactic tags will be ignored or
>> processed incorrectly by herd7.
> 
> The patches look good to me.
> 
> Just to clarify: Your first step encompasses patches 1 - 3, and the
> second step is patch 4.  The first three patches can be applied now, but
> the last one needs to wait until herd7 has been updated.  Is this all
> correct?

Exactly.


