Return-Path: <linux-kernel+bounces-430074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA1A9E2C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E319165FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C951F8910;
	Tue,  3 Dec 2024 19:47:59 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59174A29
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255279; cv=none; b=rzUWpwYBI7otO5cy+/52ohowgZen3veW0keFCsZvTVPMkeTVyIIQXv9Sxq0dmczqOAwXdIxh2QqtwqP0wPPL/4RwESHJbRU9AHft1W/4JFClGBJwBOMA/dCdNbqN2d+JCWEjTJHpBHNEINS/Dtkl1S91YwwmMcLLOLe1Kbk0WGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255279; c=relaxed/simple;
	bh=Jl+ARwM/4zhbP6etTAiiW0JrOka4S5cSQMzaevDYD3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaPt1fkJdJPJWzEgtBwfDwFCu5HjQsuSJcdACXqNIPURAJXkinHmtC1PjMjFUCqajS1+AQaC7RJiu8tL6XyBSRpnhma/biJQCemFT+i0v5plNBgwSALhSLdAwfrbeXqlx+VkZ7xbaPA6ZRjaNN4bmNAwFmFg7UKkB4FP3kHZhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rmD2tq1z9stR;
	Tue,  3 Dec 2024 20:47:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjRWoB7pfHPC; Tue,  3 Dec 2024 20:47:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rmD1yqcz9stQ;
	Tue,  3 Dec 2024 20:47:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 362878B767;
	Tue,  3 Dec 2024 20:47:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nA_6e8aHGeAM; Tue,  3 Dec 2024 20:47:56 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A79C08B763;
	Tue,  3 Dec 2024 20:47:55 +0100 (CET)
Message-ID: <f3fb20e0-516b-4b7a-a6e2-14721c078fd1@csgroup.eu>
Date: Tue, 3 Dec 2024 20:47:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc: copy preempt.h into arch/include/asm
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-2-sshegde@linux.ibm.com>
 <b5c152a3-d459-4744-84ec-846153de1652@csgroup.eu>
 <026ad776-a889-4213-8e0e-1da9065dc5ef@linux.ibm.com>
 <3de6bf25-fb3c-49a9-b06b-5e2e527ec90c@csgroup.eu>
 <8715eb95-e142-4b42-83d1-7e4cc2fa8650@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <8715eb95-e142-4b42-83d1-7e4cc2fa8650@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/12/2024 à 15:00, Shrikanth Hegde a écrit :
> 
> 
> On 12/2/24 23:47, Christophe Leroy wrote:
>>
>>
>> Le 02/12/2024 à 15:05, Shrikanth Hegde a écrit :
>>>
>>>
>>> On 11/27/24 12:07, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>>>>> PowerPC uses asm-generic preempt definitions as of now.
>>>>> Copy that into arch/asm so that arch specific changes can be done.
>>>>> This would help the next patch for enabling dynamic preemption.
>>>>
>>>
>>> The reason I want the content instead was to allow future patches 
>>> where I thought of making preempt count per paca for ppc64 atleast. 
>>> generic code assumes it is per thread. If this change is to be done 
>>> at that point, that is fair too. I am okay with it.
>>
>> I think it is better to keep series minimal and consistent. If you 
>> have a futur plan, no problem, keep it future and do everything at 
>> once unless it is heavy and better done in two steps.
>>
>> As we say in French, a lot of water will have flowed under the bridge 
>> by then.
>>
>> I'm sure there will be a lot of discussion when you do that and maybe 
>> at the end you will end up with something completely different than 
>> what you have in mind at the moment.
>>
> 
> ok.
> 
>>>
>>>
>>>> Instead of copying all the content of asm-generic version, can you 
>>>> just create a receptacle for your new macros, that will include asm- 
>>>> generic/ preempt.h ?
>>>>
>>>> Look at arch/powerpc/include/asm/percpu.h for exemple.
>>>>
>>>
>>> You mean something like below right?
>>>
>>>
>>> #ifndef __ASM_POWERPC_PREEMPT_H
>>> #define __ASM_POWERPC_PREEMPT_H
>>>
>>> #include <asm-generic/preempt.h>
>>>
>>> #if defined(CONFIG_PREEMPT_DYNAMIC) && 
>>> defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>>> DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>>> #endif
>>>
>>> #endif /* __ASM_POWERPC_PREEMPT_H */
>>
>> Yes exactly.
>>
>>
> 
> Should I send v2 with this and using DYNAMIC_KEY?


Yes you can do that, but I guess it is not urgent as it requires the 
lazy patches to be merged first and spend some time in linux-next ?

Christophe

