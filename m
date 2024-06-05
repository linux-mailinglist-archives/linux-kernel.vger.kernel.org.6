Return-Path: <linux-kernel+bounces-202737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518798FD02D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72972B34E86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB639155CAA;
	Wed,  5 Jun 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Sp2NGaeb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BB2BB1C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595478; cv=none; b=G7ziWbaXAvlxXrBwREfrevCxkZypqREeavTTDj8It5KwPy4fHN4Ba+fjJxoXfEdp7CYMY6IPKWdJaUX9cwB98BTyL2xSLEAa0cUdvtA3l/ThzrAjuw7VOsqOxKsGTbsWz51LqpSz19A2GjVGjfoF+yYlFvWLt+iw4ZAHxykpeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595478; c=relaxed/simple;
	bh=MuK8kuWQ05RP6Psbb3fc1nagS0qRvyKUnO9PP9bFuJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK4lyJwMbS5wD0cEBVyj3TVIaWWcrfgEvU3Jjo/EccX0YvoCC8H0bXL1yN0CVMY6SZ5vN+fWtl4U4IESMC5pmEsSVZ3hXbp4+YLaMQBKFrSesHasJSmu0hZ8FmZR6JCVMteaLgGHq1XzWy/Gyvy+imAtm4py2tiBrJkdOxRa6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Sp2NGaeb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aa957be8234211efbfff99f2466cf0b4-20240605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JYpZKB8QAW8ggxby7kMOqF+pDIxp0qgYSQ23xHr7lHM=;
	b=Sp2NGaebFK7Pp1EGzN+dXB2s1ZQomfwFOGLYr/qVZA/IvBwfK9O4xxDFVMe2A2tSZbYQElLdXNL/9hdM4qideBKJi9il2ZGTM843LNrfAjwEQcIH24Kj1eBG7YDqSOlfMaUrerAXKK+SlmCVl1zdHeX9nw+jxvgi13eIeTZaNMM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:feb67de8-c8e0-4a67-8a1f-aa51dc0bc091,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:1915c084-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa957be8234211efbfff99f2466cf0b4-20240605
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <phil.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2038092486; Wed, 05 Jun 2024 21:51:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jun 2024 21:51:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jun 2024 21:51:08 +0800
From: Phil Chang <phil.chang@mediatek.com>
To: <anna-maria@linutronix.de>
CC: <alix.wu@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
	<frederic@kernel.org>, <jy.ho@mediatek.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<matthias.bgg@gmail.com>, <phil.chang@mediatek.com>, <tglx@linutronix.de>
Subject: Re: [PATCH] hrtimer: check hrtimer with a NULL function
Date: Wed, 5 Jun 2024 21:51:06 +0800
Message-ID: <20240605135106.16065-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <87plsvvgpn.fsf@somnus>
References: <87plsvvgpn.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.629500-8.000000
X-TMASE-MatchedRID: vbSD0OnL8/I4HKI/yaqRm0hwlOfYeSqxgRykyfrH1xlNShtWKzkFv14r
	Z+EaD3uZ2xDStkOROV+KjSD+BEuGCyjrjvzj49diiRSHMuHguxBAq6/y5AEOOhae5J4l8aLzpwO
	Vv9hS1homWOdWIcQ1bRmrh2/8FzyKQReF5Rcm8scXrP0cYcrA2zhaxI2If9ReDZjzHLL3eRY3Bo
	tHDlVWrPA0WF4WJM3ZQhm5m+SJzSb1FVVkgOCqk+0yyL51qL/RyeUl7aCTy8gzs7oxv6pPASrgy
	brSX+LZkxZqoEsW6HDZxSvqBpsQLDbcsMCH+ZLFq1ZJZ2z+SbYhauGyjTkf9avM+zzl/BST3FfO
	Xa5ZTXj8aLTyW2a3YsTEEesDrPniorSG4OrF3ojmAId+2bAQwsDyPNek9e/amyiLZetSf8lBgw5
	G4NYCZDDmMp5UGBhvC24oEZ6SpSk6XEE7Yhw4FiYaQXAhWj/ixEQ4ODpWkCiZKj/pr9IiWM0bxa
	MOP4nwn1FdFl1ht2M=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.629500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	79D5D9248368AD314CA5C9B7DBFD18BD47287B77DC2FE410921A2872ADDF6D0D2000:8
X-MTK: N

>> simillar with timers, check for timer->function == NULL.
>> If the pointer is NULL, discard the request silently.

> Can you please explain, why this change is required?

> The statement "similar to timers" is not a valid explaination as timer
> list timers and hrtimers are two different things. The function pointer
> for timer list timers is explicitly set to NULL in shutdown path to
> prevent unwanted rearming of the timer. For hrtimers there is no
> shutdown function implemented and function is never set to NULL by
> hrtimer code.
>
The timer->function is provided  by caller, which is invaild if fuction is NULL, 
and currently, the hrtime code does not perform any checks to validate this. 
Passing a NULL function can lead to a system panic, with a backtrace likes:
```
   __hrtimer_run_queues+0x1d8/0x3b8
   hrtimer_interrupt+0xdc/0x3a0
   arch_timer_handler_phys+0x54/0x94
   handle_percpu_devid_irq+0xb8/0x308
   handle_domain_irq+0x78/0xec
   gic_handle_irq+0x50/0x10c
   call_on_irq_stack+0x38/0x54
   do_interrupt_handler+0x40/0x98
```
This backtrace does not clearly indicate the source of the invalid usage of hrtimer.

>> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
>> ---
>>  kernel/time/hrtimer.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
>> index 492c14aac642..72d6e7bc9cd9 100644
>> --- a/kernel/time/hrtimer.c
>> +++ b/kernel/time/hrtimer.c
>> @@ -1297,9 +1297,13 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
>>  
>>  	base = lock_hrtimer_base(timer, &flags);
>>  
>> +	if (!timer->function)
>> +		goto out;
>
> When this happens, user of hrtimers do not follow the semantics of
> hrtimers which means this is a bug.
>
Agree, how about BUG_ON here ?
>> +
>>  	if (__hrtimer_start_range_ns(timer, tim, delta_ns, mode, base))
>>  		hrtimer_reprogram(timer, true);
>>  
>> +out:
>>  	unlock_hrtimer_base(timer, &flags);
>>  }
>>  EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
>> @@ -1667,6 +1671,11 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
>>  	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
>>  	fn = timer->function;
>>  
>> +	if (WARN_ON_ONCE(!fn)) {
>> +		/* Should never happen. */
>
> ...same as above...
>
>> +		goto out;
>> +	}
>> +
>>  	/*
>>  	 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
>>  	 * timer is restarted with a period then it becomes an absolute
>> @@ -1710,6 +1719,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
>>  	 * hrtimer_active() cannot observe base->running.timer == NULL &&
>>  	 * timer->state == INACTIVE.
>>  	 */
>> +out:
>>  	raw_write_seqcount_barrier(&base->seq);
>>  
>>  	WARN_ON_ONCE(base->running != timer);
>
>
> Thanks,
>
>	 Anna-Maria

Thank You

