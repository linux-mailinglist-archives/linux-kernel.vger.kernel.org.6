Return-Path: <linux-kernel+bounces-306202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D13963B14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E1E281823
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D66149C4F;
	Thu, 29 Aug 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jSBgYO/0"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9613AC28
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911991; cv=none; b=JTUUCSCDvxGl4r4Mwf7XEpLGmShtMDF7uICJk/JWE6dzGV2dPiroQkV4x6oORQbq/GB6/AKjwK+lyqZcup7ToVJ4+x5m2GLeLxj6eo4LEvuZwVrDSVV1whuh5NPW1+sbp0H3hMXoRlK1dVD6ohH5d6LZp/4G4qEYa3FaQY2LDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911991; c=relaxed/simple;
	bh=BA6m6MAyQ+Kxhnryh81UNy8sPqcncz1+q1K6dLqI/GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9Yo4pzhEwvVZNxesNBT75bwOqx3XnuOJKpzJHbWkljlk9koJQWnybBM/MGZCcpe8rLz7DM6XLpv7tSeGTDD0GoFctrPsD4mKZ7JOmJAJUSZLHqmHOvgy+h+bhF2DSOeBsTUiE6WtrVii4ulAuliSb2bEd/3uWEZPRKu9mkacH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jSBgYO/0; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id jYNksWM9P80YWjYNlsDqM7; Thu, 29 Aug 2024 08:11:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724911908;
	bh=AcHUMEdU0gMkEpOjDXZZrXyIoD33u8ICSG34gWcZhdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jSBgYO/0J0lH2Fb7wVKd/CaVUABvS3ezjXvTHWiQkQ/55BtzrfbE4c5bLJFdTZEdd
	 8zV1QHl3YTlT+4JIMBk8Zl75WOBrpbjU7lTB5X0GyF6LgDTDlf9X05kgZ7KwwtVyzV
	 yIotJtJIyludbZDNPQg7cmRmCwGO/X2HGOA0nmDHqnZL+/rn7RGL/4XQwr63kJ/Tlw
	 qyKNyBWvl2q4mFNDNzbtL2vQWpX9kIGwL4FbUsfh0BVhzsVFbp7+GOa4Ex2IG9KHhl
	 JDICMNlcGKIG04oXFLZgxI4n9D8jiOe/FPA0kNq6vXFAvIq/PpqMfhS0A8hy1w0ngr
	 PC+UvBSLUP/Kg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 29 Aug 2024 08:11:48 +0200
X-ME-IP: 90.11.132.44
Message-ID: <97643a07-bc9d-41d5-8e3c-e251f510129b@wanadoo.fr>
Date: Thu, 29 Aug 2024 08:11:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sched/topology: optimize topology_span_sane()
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20240807190522.432388-1-yury.norov@gmail.com>
 <ZrzcozFadC5xQdUq@yury-ThinkPad> <Zs8vmpwY2Dt9s0Ei@yury-ThinkPad>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Zs8vmpwY2Dt9s0Ei@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/08/2024 à 16:09, Yury Norov a écrit :
> Ping again?
> 

Hi,

The covert letter is v2, but the patch below it are without v2.

In patch 1/2, the Suggested-by: tags in v1 have been removed in this new 
version :(.

CJ

> On Wed, Aug 14, 2024 at 09:35:04AM -0700, Yury Norov wrote:
>> Ping?
>>
>> On Wed, Aug 07, 2024 at 12:05:19PM -0700, Yury Norov wrote:
>>> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
>>> even when cpu != i. In such case, cpumask_equal() would always return
>>> true, and we can proceed to the next iteration immediately.
>>>
>>> Valentin Schneider shares on it:
>>>
>>>    PKG can potentially hit that condition, and so can any
>>>    sched_domain_mask_f that relies on the node masks...
>>>    
>>>    I'm thinking ideally we should have checks in place to
>>>    ensure all node_to_cpumask_map[] masks are disjoint,
>>>    then we could entirely skip the levels that use these
>>>    masks in topology_span_sane(), but there's unfortunately
>>>    no nice way to flag them... Also there would be cases
>>>    where there's no real difference between PKG and NODE
>>>    other than NODE is still based on a per-cpu cpumask and
>>>    PKG isn't, so I don't see a nicer way to go about this.
>>>
>>> v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
>>> v2:
>>>   - defer initialization of 'mc' in patch #1 @Chen Yu;
>>>   - more comments from Valentin Schneider.
>>>
>>>
>>> Yury Norov (2):
>>>    sched/topology: pre-compute topology_span_sane() loop params
>>>    sched/topology: optimize topology_span_sane()
>>>
>>>   kernel/sched/topology.c | 20 ++++++++++++++++++--
>>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> -- 
>>> 2.43.0
> 
> 


