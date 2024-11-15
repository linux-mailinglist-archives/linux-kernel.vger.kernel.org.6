Return-Path: <linux-kernel+bounces-410110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0849CCE64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23356B22411
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC121106;
	Fri, 15 Nov 2024 00:33:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156E1362
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630807; cv=none; b=inOm29tWUz3kOJNtC9VOIv7in8sWVt8wDoAlr3uE5XhEktg+cxIuFtmKdhphC6p8PYIibnfKHt74MQz4SHzED9w7/QZKxZpSKctZaOz5WbqtmjtWRoUmrTiuWCmaK2pDgyKvJbG703tcP2xmaneAIoQHgmrx1GCGF688tIApFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630807; c=relaxed/simple;
	bh=TpfaO18ZewFvK8/Vzfq3MR2zI//UJ7UuMOKzZxyr3vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfWlqSoQOSPFAxkXLIrFiNMwXER0vLHWbF45QdpdYa1SWwV8Jp/GkpRaCqU8wj8gFfY0+dGGDFRfz4CMx/PqtaEEeN8T/ryyoUYKRHmKcPAw7Wiq9tCr3BMSnsvb2TQy4yBe8LNDM4O7SijhAMHxQFORde+VKYHuGCf5tnU3Czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 312592daa2e911efa216b1d71e6e1362-20241115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d405ee10-21a9-4659-b63b-dc39b6426624,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:d405ee10-21a9-4659-b63b-dc39b6426624,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:d67ac3610b9c32aa5829e17a9de8f682,BulkI
	D:241115011238Z3MKOVQV,BulkQuantity:2,Recheck:0,SF:43|17|19|74|64|66|841|3
	8|25|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 312592daa2e911efa216b1d71e6e1362-20241115
X-User: zhaomengmeng@kylinos.cn
Received: from [192.168.109.86] [(123.53.36.205)] by mailgw.kylinos.cn
	(envelope-from <zhaomengmeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1721579415; Fri, 15 Nov 2024 08:33:10 +0800
Message-ID: <c541c0f7-4b43-4527-9a01-ed57aa0f78b1@kylinos.cn>
Date: Fri, 15 Nov 2024 08:33:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched_ext: Replace hardcoding with macro and minor
 typo fix
To: Tejun Heo <tj@kernel.org>, Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
References: <20241113025908.306936-1-zhaomzhao@126.com>
 <ZzYvf2L3rlmjuKzh@slm.duckdns.org>
From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
In-Reply-To: <ZzYvf2L3rlmjuKzh@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/11/15 01:12, Tejun Heo wrote:
> Hello,
> 
> On Wed, Nov 13, 2024 at 10:59:08AM +0800, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>>
>> 1. replace hardcoding with SCX_KF_UNLOCKED.
>> 2. scx_next_task_picked() has been replaced with siwtch_class().
>> 3. minor typo fixes.
>>
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>> ---
>>  kernel/sched/ext.c             | 6 +++---
>>  tools/sched_ext/scx_qmap.bpf.c | 2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 1b1c33f12dd7..832f77d1d318 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -2759,10 +2759,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>>  		 * If the previous sched_class for the current CPU was not SCX,
>>  		 * notify the BPF scheduler that it again has control of the
>>  		 * core. This callback complements ->cpu_release(), which is
>> -		 * emitted in scx_next_task_picked().
>> +		 * emitted in switch_class().
>>  		 */
>>  		if (SCX_HAS_OP(cpu_acquire))
>> -			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
>> +			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq), NULL);
> 
> I think this is actually a bug. David, shouldn't this be SCX_KF_REST?
> 
>>  		rq->scx.cpu_released = false;
>>  	}

Got it.
>> @@ -6096,7 +6096,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>>  		if (cpu != cpu_of(this_rq)) {
>>  			/*
>>  			 * Pairs with smp_store_release() issued by this CPU in
>> -			 * scx_next_task_picked() on the resched path.
>> +			 * switch_class() on the resched path.
>>  			 *
>>  			 * We busy-wait here to guarantee that no other task can
>>  			 * be scheduled on our core before the target CPU has
>> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
>> index ee264947e0c3..f230641929ec 100644
>> --- a/tools/sched_ext/scx_qmap.bpf.c
>> +++ b/tools/sched_ext/scx_qmap.bpf.c
>> @@ -5,7 +5,7 @@
>>   * There are five FIFOs implemented using BPF_MAP_TYPE_QUEUE. A task gets
>>   * assigned to one depending on its compound weight. Each CPU round robins
>>   * through the FIFOs and dispatches more from FIFOs with higher indices - 1 from
>> - * queue0, 2 from queue1, 4 from queue2 and so on.
>> + * queue0, 2 from queue1, 3 from queue2 and so on.
> 
> The number to dispatch is determined by:
> 
>   cpuc->dsp_cnt = 1 << cpuc->dsp_idx;
> 
> I think the existing comment is correct.

You are right, I missed something. Will send a V3


