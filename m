Return-Path: <linux-kernel+bounces-219017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9990C8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5A1F22261
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D220E65A;
	Tue, 18 Jun 2024 10:02:39 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684A20E653
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704958; cv=none; b=QpBsA34kq96lJGRP+VWB2EdG82IMSjn+n4Aw41iMSf7BqMH9NmBsKfwGvXV4hu54LaUaSOLAYlaNd++R7DAISxKUXhE83sn/ZR5G6HRpFmFHy3246hmGxTUDZIAh7rI/4I7Cebf3vK0jYKkzzRKFZS5uI6FR/+zfUlB+w2dj8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704958; c=relaxed/simple;
	bh=5/C+qOAXKFkLykqinalo3w8+p9exKNaayAClbioRHCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNFmMDaL4rqTk1ljGGOKuIznt+x6HNvrOl5hH1hOEVEhfdNHjTHetFDmGw3vW1nNq16PQekgWKQhfth2KAtF/dmmqryTWmXP52hDJCFe/W43N5vBxr9lXshMAEznS6rdO8w0GwWf+A0HgqX7UugHjEPNq4UsqkLlRn1O284ROso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06519C0003;
	Tue, 18 Jun 2024 10:02:34 +0000 (UTC)
Message-ID: <7181600f-21cd-469f-a99d-d6e8a75f9b3d@ghiti.fr>
Date: Tue, 18 Jun 2024 12:02:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
Content-Language: en-US
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725070549.89810-1-luxu.kernel@bytedance.com>
 <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
 <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
 <CAPYmKFvqpe48zaLKrTz085cJcO9fwL+BtHujU4p48onR1Nodfw@mail.gmail.com>
 <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr>
 <CAPYmKFuLap8SZrcgGM36G85TYshuhMhMA1WUHt1A_VkD9JiTqQ@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAPYmKFuLap8SZrcgGM36G85TYshuhMhMA1WUHt1A_VkD9JiTqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 18/06/2024 12:00, Xu Lu wrote:
> Hi Alex,
>
> I will send a new version later today.


Great, thanks, I'll make sure it lands in -fixes.

Sorry it did not get merged sooner.

Thanks,

Alex


>
> Thanks,
>
> Xu Lu
>
> On Tue, Jun 18, 2024 at 5:45 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Xu Lu,
>>
>> On 24/08/2023 14:08, Xu Lu wrote:
>>> On Wed, Aug 9, 2023 at 2:58 PM 旭路 <luxu.kernel@bytedance.com> wrote:
>>>> On Wed, Aug 9, 2023 at 2:05 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>>>> On Tue, 25 Jul 2023 00:05:49 PDT (-0700), luxu.kernel@bytedance.com wrote:
>>>>>> When arch_local_irq_restore() is called with flags indicating irqs
>>>>>> disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
>>>>>> implementation based on csr_set() function only sets SR_IE bit of
>>>>>> CSR_STATUS when SR_IE bit of flags is high and does nothing when
>>>>>> SR_IE bit of flags is low.
>>>>>>
>>>>>> This commit supplies csr clear operation when calling irq restore
>>>>>> function with flags indicating irq disabled.
>>>>>>
>>>>>> Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
>>>>>> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
>>>>>> ---
>>>>>>    arch/riscv/include/asm/irqflags.h | 5 ++++-
>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
>>>>>> index 08d4d6a5b7e9..7c31fc3c3559 100644
>>>>>> --- a/arch/riscv/include/asm/irqflags.h
>>>>>> +++ b/arch/riscv/include/asm/irqflags.h
>>>>>> @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
>>>>>>    /* set interrupt enabled status */
>>>>>>    static inline void arch_local_irq_restore(unsigned long flags)
>>>>>>    {
>>>>>> -     csr_set(CSR_STATUS, flags & SR_IE);
>>>>>> +     if (flags & SR_IE)
>>>>>> +             csr_set(CSR_STATUS, SR_IE);
>>>>>> +     else
>>>>>> +             csr_clear(CSR_STATUS, SR_IE);
>>>>> Unless I'm missing something, the original version is correct:
>>>>> local_irq_restore() must be paired with a local_irq_save(), so we can
>>>>> only get here with interrupts disabled.
>>>> Yes, it is correct if local_irq_save() is called when irq is enabled before.
>>>> The flags returned will be SR_IE. And it is safe to call local_irq_restore()
>>>> with flag SR_IE in any case.
>>>>
>>>> However, if local_irq_save() is called when irq is disabled. The SR_IE bit of
>>>> flag returned is clear. If some code between local_irq_save() and
>>>> local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STATUS
>>>> back to 1, then local_irq_restore() can not restore irq status back to disabled.
>>>>
>>>> Here is an example in existing driver (may not belong to riscv arch) in
>>>> drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c. The pseudo code
>>>> behaves like:
>>>>
>>>> int rtl8723e_hw_init(struct ieee80211_hw *hw)
>>>> {
>>>>        int err;
>>>>        unsigned long flags;
>>>>        ...
>>>>        local_irq_save_flags(flags);
>>>>        local_irq_enable();
>>>>        ...
>>>>        local_irq_restore(flags);
>>>>        ...
>>>>        return err;
>>>> }
>>>>
>>>>
>>>>>>    }
>>>>>>
>>>>>>    #endif /* _ASM_RISCV_IRQFLAGS_H */
>>> A gentle ping.
>>
>> This got lost but this is still correct and needed.
>>
>> Do you think you can respin a new version? Otherwise, I'll do it and
>> keep you SoB.
>>
>> Thanks,
>>
>> Alex
>>
>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

