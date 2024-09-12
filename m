Return-Path: <linux-kernel+bounces-326210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88259764FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AA8283EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8800D1917C0;
	Thu, 12 Sep 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bWnth5BO"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1718DF6C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131255; cv=none; b=JIVgsUKuET2U0L9TUU+ymo1IuzAkEzcs3kO8CRqC/A4EeSdBDmdyNe1al9ZNHy96Y5QpORCQV9BI7+f7/p1PYmPtfPvShhJ1KKlf/+tTu/hqPPQ38CEUnJrOGi5EG5gU/NnwoYUg2i10TAht0Lg6GWqoFbjcOw/zDhHau29Uc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131255; c=relaxed/simple;
	bh=YgxuCNGw8QGViDQaaeKu9uuAFrLWXt3P500GeUIS6dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ3TjpcICNyCx6Fg48W3raduj/IVePcw9q6lcCcGVL3lmuMy4yV33yL2MmcpTHiq0ma0fFzX4sMnuV/Lz10qh0br2qTtZrOT9+InkZFYrN9TmxtCfh0tJFu259APy9Hsa9jZQ9Wi3Xi8g5lUnAb4WF4VIRJaJcnSgYIuKpxpoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bWnth5BO; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 48C8rhJS2821823
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 01:53:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 48C8rhJS2821823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1726131225;
	bh=uAlo0fa11vbYTh0Fn50tqOex7EA7rwBb81H3Cfgvge4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bWnth5BOB78L1D7A1SrDOHtl2ZoCN6X2P0Au6DComvfkWSL2bTaKjXsktq+n0weKH
	 WDedM5bAPtQQ6vPKkpeP5reO4aDZjKIfSSBtZ9gxAaDzWT4QNZokIKjLpZJkie7dN1
	 euGVP1CxzOMfYpslUEXsEN2FZdbOVs3Tf8xD9tBZn7DQ33saAUTZ+iZwQNT9OAr8l4
	 AM1yTbJT2VZiG9J2wvQIPWE9TSUKVE9tjKUosZgtU7QqRYr1Q8MR7bQxzM12bgjrl2
	 /0T/LX66riFoSUkiW9XFe4qbs3swSE9SkkP8Nl/1NCmhjo0byGUjTNCyKwxdYz1gWz
	 yN55Togt5hTwA==
Message-ID: <676eb52a-5d9f-4204-9e79-15c1d7dc2b08@zytor.com>
Date: Thu, 12 Sep 2024 01:53:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com
References: <20240911231929.2632698-1-xin@zytor.com>
 <3328e53d-b0f2-4516-a6a6-51ca33642683@intel.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <3328e53d-b0f2-4516-a6a6-51ca33642683@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/2024 5:22 PM, Dave Hansen wrote:
> On 9/11/24 16:19, Xin Li (Intel) wrote:
>> +/*
>> + * The WFE (WAIT_FOR_ENDBRANCH) bit in the augmented CS of FRED stack frame is
>> + * set to 1 in missing-ENDBRANCH #CP exceptions.
> 
> I think there's a bit of relatively irrelevant info in there.  For
> instance, I don't think it's super important to mention that FRED is
> involved and where the WFE bit is in memory.
> 
> FRED's involvement is kinda a no-brainer from the whole X86_FEATURE_FRED
> thing, and if you're reading exception handler code and don't know that
> 'regs' is on the stack, this probably isn't the place to explain that.

I often find myself in a dilemma, should I mention some technical
background which sometimes could also be distracting :(

Based on your feedback, maybe the following is better?

static void ibt_clear_fred_wfe(struct pt_regs *regs)
{
	if (regs->fred_cs.wfe)
		regs->fred_cs.wfe = 0;
}

And we know only FRED hardware will set the WFE bit.

> 
>> + * If the WFE bit is left as 1, the CPU will generate another missing-ENDBRANCH
>> + * #CP because the indirect branch tracker will be set in the WAIT_FOR_ENDBRANCH
>> + * state upon completion of the following ERETS instruction and the CPU will
>> + * restart from the IP that just caused a previous missing-ENDBRANCH #CP.
>> + *
>> + * Clear the WFE bit to avoid dead looping due to the above reason.
>> + */
>> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
>> +{
>> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
>> +		regs->fred_cs.wfe = 0;
>> +}
> 
> Can I suggest a slightly different comment?
> 
> /*
>   * WFE==1 (WAIT_FOR_ENDBRANCH) means that the CPU expects the next ERETS
>   * to jump to an ENDBR instruction. If the ENDBR is missing, the CPU
>   * raises a #CP.
>   *
>   * Clear WFE to avoid that #CP.
>   *
>   * Use this function in a #CP handler to effectively give the next
>   * ERETS a free pass to ignore IBT for a single instruction.
>   */
> 
> I think original comment really needs a "How do I use this?" sentence or
> two.
> 
> A comment at the call site also wouldn't hurt:
> 
>   	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)){
>   		regs->ax = 0;
> +		/* Disable IBT enforcement for one exception return: */
> +		ibt_clear_fred_wfe(regs);
>   		return;
>   	}
> 
> I'm finding it kinda hard to concisely differentiate between the
> "disable IBT at one ERETS" and "disable IBT forever", but I hope this
> sounds good to folks.
> 

My understanding is that a missing-ENDBRANCH #CP is triggered in two
steps:

     1) Upon completion of an indirect call/jmp, or an event return
        instruction, the CPU indirect branch tracker is put in the
        WAIT_FOR_ENDBRANCH state.

     2) As the CPU is in WAIT_FOR_ENDBRANCH state, if the instruction to
        be executed is ENDBR, the CPU indirect branch tracker exits
        WAIT_FOR_ENDBRANCH state, otherwise a #CP is generated.

So this is more of "preserve WAIT_FOR_ENDBRANCH state" or not.

IDT is unable to preserve WAIT_FOR_ENDBRANCH state when returning from
event handling, which as Andrew mentioned is a security hole.



