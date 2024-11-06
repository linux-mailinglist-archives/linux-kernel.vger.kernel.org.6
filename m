Return-Path: <linux-kernel+bounces-398691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F09BF4BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D7D1F24B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40BF2076DE;
	Wed,  6 Nov 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UznUGVdT"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157C2071E2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915985; cv=none; b=DUlBwNLYeMddC+mFd+NQs6oGMJqxjQ1hCIHZqNzL2SMyVpm7KcLQnkdZwQqRh7G53NphWook21paBt3DVcBdPDLKKD3icJGUOojg72OnjxXVFafk6DLKfyvUieLV9HUOfJ8i4Qpicct2Z3BZwXd4pHpJ1AoZ7P+ti34mUa+DcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915985; c=relaxed/simple;
	bh=IwUKzsdSnOkefCuk2y9bjZ7OSC0p2jvrbYV6ywdPeQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fa7zveK5fk3QUVGxU2q79774UBhTl0Rj4arUrPKbxE9DAI6MDbTi2FcCxXiPHXilptgX7L3EI6ifkBlG4vpwuP+fmmp3qBE9WaEOVORDhVfX4qyOlOKgTdNstnBRWYPcnnQdz1e1QUocBNnV0QcJL/X7VcflUvVA1iiJMGW05uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UznUGVdT; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 8kIRtGOdtj0218kIRtYl3W; Wed, 06 Nov 2024 18:58:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730915908;
	bh=sAI1t49uY1vzpGkibesf6A/6SiFuBftz4fsouvSiR8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UznUGVdTyKvLZfR9glgErBk9eBsk7yYTl0pAz2zZvx11BO9X0DhyY+st0bi22bG+5
	 LOXJBMJJ17CRdgNgxXvx+FKTqWuxCHdyyr2LnNZntZl39Kx/cESIgyDgWsAqejlucw
	 mAXehyYJf2Sle7Yz3dlLAjTg3gv6X9c/vog7lBx0tnfaI7hvwJgp5pRuvyp0tfPwNN
	 lk6wH17QV67YY+r1Hv20rDGNMxRCJjJrgNO8RoSkAb0qfH9Qpg+ajurOw/Ah3Fp9Xh
	 r8vYQ4qkDnCPhuaycshWXd/k1XIOyym00RsdQ6vV8nUeAfxBlxP73kWAsopsCoefes
	 8ivFvBjhDvkDw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 06 Nov 2024 18:58:28 +0100
X-ME-IP: 90.11.132.44
Message-ID: <14fd8032-51b2-4182-b74d-699df550ffec@wanadoo.fr>
Date: Wed, 6 Nov 2024 18:58:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
 <ZuW_0fMfPSix4qqX@yury-ThinkPad> <Zvr4s9ErpD9F81YH@yury-ThinkPad>
 <ZyuZJoD4hKa3hIvR@yury-ThinkPad>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZyuZJoD4hKa3hIvR@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/11/2024 à 17:28, Yury Norov a écrit :
> Last reminder. If you guys don't care, I don't care either.

Hi Yury,

I'm the only one in the To: field, but I'm not a maintainer.

Maybe, try to move people in the Cc: field into the To: field, to 
increase visibility?

CJ

> 
> On Mon, Sep 30, 2024 at 12:15:02PM -0700, Yury Norov wrote:
>> Ping again?
>>
>> On Sat, Sep 14, 2024 at 09:54:43AM -0700, Yury Norov wrote:
>>> Ping?
>>>
>>> On Mon, Sep 02, 2024 at 11:36:04AM -0700, Yury Norov wrote:
>>>> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
>>>> even when cpu != i. In such case, cpumask_equal() would always return
>>>> true, and we can proceed to the next iteration immediately.
>>>>
>>>> Valentin Schneider shares on it:
>>>>
>>>>    PKG can potentially hit that condition, and so can any
>>>>    sched_domain_mask_f that relies on the node masks...
>>>>
>>>>    I'm thinking ideally we should have checks in place to
>>>>    ensure all node_to_cpumask_map[] masks are disjoint,
>>>>    then we could entirely skip the levels that use these
>>>>    masks in topology_span_sane(), but there's unfortunately
>>>>    no nice way to flag them... Also there would be cases
>>>>    where there's no real difference between PKG and NODE
>>>>    other than NODE is still based on a per-cpu cpumask and
>>>>    PKG isn't, so I don't see a nicer way to go about this.
>>>>
>>>> v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
>>>> v2: https://lkml.org/lkml/2024/8/7/1299
>>>> v3:
>>>>   - add topology_cpumask_equal() helper in #3;
>>>>   - re-use 'cpu' as an iterator int the for_each_cpu() loop;
>>>>   - add proper versioning for all patches.
>>>>
>>>> Yury Norov (3):
>>>>    sched/topology: pre-compute topology_span_sane() loop params
>>>>    sched/topology: optimize topology_span_sane()
>>>>    sched/topology: reorganize topology_span_sane() checking order
>>>>
>>>>   kernel/sched/topology.c | 29 +++++++++++++++++++++++++----
>>>>   1 file changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> -- 
>>>> 2.43.0
> 
> 


