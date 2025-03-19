Return-Path: <linux-kernel+bounces-567379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9AA68547
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC7165523
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED01DE8B8;
	Wed, 19 Mar 2025 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FByVMV3p"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB94E552
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366889; cv=none; b=kq00lbLrI1DKMgFtro9jhsXW/BMAopUrhkQj68Bwq3oJ/Rvh80DFP+WWofN2J4lJJMtCeuKaP8A9VMIG7MPgbFwYEi0DIpkvt/w4hDNs+60Mx1L1lR8+YlK/JaQz9N0aUTQSlqEYC+ggRthgdEGw0Rw6WYb2KBnbRLDRFQC6iO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366889; c=relaxed/simple;
	bh=ZL9d0TPFiTuCK3GMVeoEzec8w54xMz19V7ROiHnIS8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9YOs2MULwLHYF9rZU1XfsFXxcYpzWEiLOqLgFxKIcOAr5WSyfpfqHHc0BKAu1DzH38VfwwY7Y8R/BkKy7FUnk14xneZqgwV59ORbbxwKLeXq2CpY6Jwyo5auHwv0xrgadqICN8kRc1gpyW4mVTa+79DLvrQNcHsTkrJtNW+Ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FByVMV3p; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52J6lW8v1383973
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Mar 2025 23:47:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52J6lW8v1383973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742366854;
	bh=a8prDsYFWwURkufllV2aqN2xYnkACpweRgK358UdotI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FByVMV3pdSyajg9aJSD/yLU1CEufI65K2naHAMBpvudWItEUS6Jjywjs3eKTfn1gP
	 wyl0yWZf6pj2FYQitwJbikOpJCEVp/bSCKJVk755y1OVMVnMvVLUXUjRfDsXlQ7V54
	 Xcq2oec96VJNmUHL+fscZu/xETwNr4c21IzPmsVZ4iZF75rcFhGnnfmnHfmDEmttPr
	 m6oGsiqASIE3Nclog1vDsnjVhxF4CN/z/Y5qahnljRXS6Z+2meL/7OaYdtX4XaTNci
	 OmR6OcZHTw9mk6qoD8xoVZsksN0lIpw2Z6744t+vNlQvUn2ih0x85MfZsAHWmAupxI
	 oy1ms0gfV9/2g==
Message-ID: <7b0484d2-3608-4243-b3ae-2b49e2a32331@zytor.com>
Date: Tue, 18 Mar 2025 23:47:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 1/3] x86/fred: Allow variable-sized event frame
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org
References: <20250318071947.907364-1-xin@zytor.com>
 <20250318071947.907364-2-xin@zytor.com>
 <CAMzpN2iOGKLN99MC6zgzLumysnR5q-M-jZ3y14cp5TYCW1mQWg@mail.gmail.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <CAMzpN2iOGKLN99MC6zgzLumysnR5q-M-jZ3y14cp5TYCW1mQWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/2025 6:53 AM, Brian Gerst wrote:
>> -#define INIT_THREAD_INFO(tsk)                  \
>> -{                                              \
>> -       .flags          = 0,                    \
>> +#define INIT_THREAD_INFO(tsk)                                          \
>> +{                                                                      \
>> +       .flags          = 0,                                            \
>> +       .user_pt_regs   = (struct pt_regs *)TOP_OF_INIT_STACK - 1,      \
> 
> Use __top_init_kernel_stack here.

Will do.

> 
>>   }
>>
>>   #else /* !__ASSEMBLER__ */
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index 91f6ff618852..58c1cd4ca60a 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -108,6 +108,28 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>>          return 0;
>>   }
>>
>> +/*
>> + * Initialize thread_info.user_pt_regs for IDT event delivery.
>> + *
>> + * For IDT user level event delivery, a pt_regs structure is pushed by both
>> + * hardware and software and always resides at a fixed offset from top of
>> + * current task kernel stack, thus thread_info.user_pt_regs is a per-task
>> + * constant and NEVER changes after initialization.
>> + *
>> + * While for FRED user level event delivery, user_pt_regs is updated in
>> + * fred_entry_from_user() immediately after user level event delivery.
>> + *
>> + * Note: thread_info.user_pt_regs of the init task is initialized at build
>> + * time.
>> + */
>> +void arch_init_user_pt_regs(struct task_struct *tsk)
>> +{
>> +       unsigned long top_of_stack = (unsigned long)task_stack_page(tsk) + THREAD_SIZE;
>> +
>> +       top_of_stack -= TOP_OF_KERNEL_STACK_PADDING;
>> +       tsk->thread_info.user_pt_regs = (struct pt_regs *)top_of_stack - 1;
>> +}
> 
> Can this be put into arch_dup_task_struct() instead of creating another hook?

I wanted to do it at the beginning but task stack is no longer part of
the task_struct on x86.  Make sense?

Thanks!
     Xin

