Return-Path: <linux-kernel+bounces-207795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE3901C49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D6A1C21240
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC7558B6;
	Mon, 10 Jun 2024 08:04:55 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252B4D8BC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006695; cv=none; b=g1yXwmcxL2fU/zZBukD3M27flNBXKhqwPA1lVk85B2x7a9ZG74ke+RNoHqGM3AaZuuri1XyeOy1yAqpi2MML0JGnQpTWanFdjm1l+GSaHRQ3QT/rIl7lyzg5ovVSLG2yasmtRtKQ+vtzLjvcTRHfdqaDbK8bDEjPzzs2O/MN+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006695; c=relaxed/simple;
	bh=2OPoc+UK2kuduohQq5i3tqCh18Kok+L5ON1ds87rC1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOlWFTlRTBIVlNmF1/yOrUPUqDvdgtZUdQAnyUruNIEhC2ZDFrB14m5tIEZMCMrx8mAmvCWAsIca7M6FBurnxOGiPIAI3YUKRbPyAHH9n43XsTiczSArc086SKqovqnx91qY6C56GDkSIbY39aMttTCRqqLO3JM5LJViuEGACGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VyP062jr9z9v7Jb
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:42:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 0CAFE1400CB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:04:44 +0800 (CST)
Received: from [10.81.205.125] (unknown [10.81.205.125])
	by APP2 (Coremail) with SMTP id GxC2BwCHDjmNs2ZmbcchAA--.46614S2;
	Mon, 10 Jun 2024 09:04:43 +0100 (CET)
Message-ID: <1aed7106-cb94-451e-93d1-53062e6f3639@huaweicloud.com>
Date: Mon, 10 Jun 2024 10:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
To: paulmck@kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
 will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
 joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
 frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
 <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
 <cbced924-3f22-484d-8e65-4eebe7c9329a@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <cbced924-3f22-484d-8e65-4eebe7c9329a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCHDjmNs2ZmbcchAA--.46614S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48Gw4UGr4fJr13Xr4rGrg_yoW5Aw1fpF
	W5GayrKFs8Jry29w4Igrs7XFyayayfG347Xrn5Jw1fu3Z0gFy8Kr4akr45uF97GrZ7Wa4j
	vryUtr93Xw1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 6/6/2024 um 6:37 PM schrieb Paul E. McKenney:
> On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
>>> On Tue, Jun 04, 2024 at 05:29:18PM +0200, Jonas Oberhauser wrote:
>>>> Currently, the effect of several tag on operations is defined only in
>>>> the herd7 tool's OCaml code as syntax transformations, while the effect
>>>> of all other tags is defined in tools/memory-model.
>>>> This asymmetry means that two seemingly analogous definitions in
>>>> tools/memory-model behave quite differently because the generated
>>>> representation is sometimes modified by hardcoded behavior in herd7.
>>>>
>>>> It also makes it hard to see that the behavior of the formalization
>>>> matches the intuition described in explanation.txt without delving into
>>>> the implementation of herd7.
>>>>
>>>> Furthermore, this hardcoded behavior is hard to maintain inside herd7 and
>>>> other tools implementing WMM, and has caused several bugs and confusions
>>>> with the tool maintainers, e.g.:
>>>>
>>>>     https://github.com/MPI-SWS/genmc/issues/22
>>>>     https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904
>>>>     https://github.com/hernanponcedeleon/Dat3M/issues/254
>>>>
>>>> It also means that potential future extensions of LKMM with new tags may
>>>> not work without changing internals of the herd7 tool.
>>>>
>>>> In this patch series, we first emulate the effect of herd7 transformations
>>>> in tools/memory-model through explicit rules in .cat and .bell files that
>>>> reference the transformed tags.
>>>> These transformations do not have any immediate effect with the current
>>>> herd7 implementation, because they apply after the syntax transformations
>>>> have already modified those tags.
>>>>
>>>> In a second step, we then distinguish between syntactic tags (that are
>>>> placed by the programmer on operations, e.g., an 'ACQUIRE tag on both the
>>>> read and write of an xchg_acquire() operation) and sets of events (that
>>>> would be defined after the (emulated) transformations, e.g., an Acquire
>>>> set that includes only on the read of the xchg_acquire(), but "has been
>>>> removed" from the write).
>>>>
>>>> This second step is incompatible with the current herd7 implementation,
>>>> since herd7 uses hardcoded tag names to decide what to do with LKMM;
>>>> therefore, the newly introduced syntactic tags will be ignored or
>>>> processed incorrectly by herd7.
>>>
>>> The patches look good to me.
>>>
>>> Just to clarify: Your first step encompasses patches 1 - 3, and the
>>> second step is patch 4.  The first three patches can be applied now, but
>>> the last one needs to wait until herd7 has been updated.  Is this all
>>> correct?
>>
>> Exactly.
> 
> Just to make sure that I am following along properly...  My belief is
> that there will be a new version of this series.  Please let me know if
> I am missing something.

At least one :))

Have fun,
   jonas


