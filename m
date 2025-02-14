Return-Path: <linux-kernel+bounces-514473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82809A35778
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0381D188FAE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C52204C0B;
	Fri, 14 Feb 2025 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nVl/hWn4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C441519A9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516258; cv=none; b=ZwXJ0wOwBprdkS3hOmoIeCDNko7hAK27isYm/GK9IO/Rc9oni9vRKtc5SjNa7OsyHTZZwPm5ZMROJyP5WzGKw74k06xbBYaEhMCk2BwkjHWlFPbZ+4ZCRxO7cWHmiZS4oUMEiC6Yi1juntcyYIq8ehm8jQyxhtRhOZ3bYGgJnKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516258; c=relaxed/simple;
	bh=F3DeRREWaDKewB9nP6A8KX/RxyNmGIRa52bFNX6oUM4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J9M203drO2ek4djKhOKT+G/b9MtAlVvIrnatgguKH0yIfMpf5tRtuOHZZB8HUpic6MoCE4kN6JIbyirJ29/RZOGQ68DQJuCGCgiCjA+PtbmRcc/Zk/kG6gKyI7D5QkOgjbaRF2tkigKYSrjYZBzszgIeQ4iTCUHu63ds/r8xmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nVl/hWn4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51E6ungf3794133
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 13 Feb 2025 22:56:49 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51E6ungf3794133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739516210;
	bh=s7ndVm0IktdKspCCJUNaWZgehFbMV7UkVQkSy1sKkKU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nVl/hWn4OmdEBtANqtqhy4Gsrt//3VoU8I6OIFl/ci+iqLUKUtvLkSbp6El0jOckQ
	 yHLI8Bf3dJ4ZQ7tkbmt9NYc2fuOLfmA4G+arfhufe0BcNvt9t8y3AsIOOF4hUbOroV
	 sloseJVBaGjNnsDcw9IDRZlDwZq+1J73rqPFZeeZhw8mmPHzuW7NykZmkNaBL5tVYc
	 84SlzOG9Icg6+T9of0pQcvyxlYh1wParj6d/pVoUYr5jUf2Ht32Bzn5tcn83mGOrWf
	 xbQn+zX3zgo5V1mjDLvImBnYzdoNN02WfIC9o7JqXNeGoCqprzjzzNdTJST3lyt526
	 7Q8BU7yCBxImQ==
Message-ID: <36970ddb-c0d8-43e4-a94e-0d9ea3d55ced@zytor.com>
Date: Thu, 13 Feb 2025 22:56:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] x86/ia32: Leave NULL selector values 0~3 as is
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        andrew.cooper3@citrix.com, brgerst@gmail.com, ebiederm@xmission.com
References: <20241126184529.1607334-1-xin@zytor.com>
 <fa3d0093-818d-4592-8415-3c2e287cc3e6@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <fa3d0093-818d-4592-8415-3c2e287cc3e6@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2024 10:44 AM, Xin Li wrote:
> On 11/26/2024 10:45 AM, Xin Li (Intel) wrote:
>> The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
>> and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
>> GDT, selector values 0~3 all point to the NULL descriptor, thus values
>> 0, 1, 2 and 3 are all valid NULL selector values.
>>
>> When a NULL selector value is to be loaded into a segment register,
>> reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
>> DS segment registers if any of them is found to have any nonzero NULL
>> selector value.  The two operations offset each other to actually effect
>> a nop.
>>
>> Besides, zeroing of RPL in NULL selector values is an information leak
>> in pre-FRED systems as userspace can spot any interrupt/exception by
>> loading a nonzero NULL selector, and waiting for it to become zero.
>> But there is nothing software can do to prevent it before FRED.
>>
>> ERETU, the only legit instruction to return to userspace from kernel
>> under FRED, by design does NOT zero any segment register to avoid this
>> problem behavior.
>>
>> As such, leave NULL selector values 0~3 as is.
> 
> Hi Andrew,
> 
> Do you have any more comments?

Hi Andrew,

Are you okay to give a review-by to this patch?

Thanks!
     Xin

>>
>> Do the same on 32-bit kernel as well.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>
>> Changes since v3:
>> * Rename usrseg() to fixup_rpl() to match its intent (Andrew Cooper).
>> * A few comment improvements (Andrew Cooper).
>>
>> Changes since v2:
>> * No, don't zero non-zero NULL selector values, essentially revert
>>    to v1 (Andrew Cooper).
>>
>> Changes since v1:
>> * Normalize non-zero NULL selector values to 0 (Eric W. Biederman).
>> * Apply the same normalization logic in a 32bit kernel (Eric W.
>>    Biederman).
>> ---
>>   arch/x86/kernel/signal_32.c | 62 +++++++++++++++++++++++++------------
>>   1 file changed, 43 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
>> index ef654530bf5a..1e275268d256 100644
>> --- a/arch/x86/kernel/signal_32.c
>> +++ b/arch/x86/kernel/signal_32.c
>> @@ -33,25 +33,55 @@
>>   #include <asm/smap.h>
>>   #include <asm/gsseg.h>
>> +/*
>> + * The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
>> + * and 1 of a segment selector, i.e., the RPL bits, are NOT used to 
>> index
>> + * GDT, selector values 0~3 all point to the NULL descriptor, thus 
>> values
>> + * 0, 1, 2 and 3 are all valid NULL selector values.
>> + *
>> + * However IRET zeros ES, FS, GS, and DS segment registers if any of 
>> them
>> + * is found to have any nonzero NULL selector value, which can be 
>> used by
>> + * userspace in pre-FRED systems to spot any interrupt/exception by 
>> loading
>> + * a nonzero NULL selector and waiting for it to become zero.  Before 
>> FRED
>> + * there is nothing software can do to prevent such an information leak.
>> + *
>> + * ERETU, the only legit instruction to return to userspace from kernel
>> + * under FRED, by design does NOT zero any segment register to avoid 
>> this
>> + * problem behavior.
>> + *
>> + * As such, leave NULL selector values 0~3 as is.
>> + */
>> +static inline u16 fixup_rpl(u16 sel)
>> +{
>> +    return sel <= 3 ? sel : sel | 3;
>> +}
>> +
>>   #ifdef CONFIG_IA32_EMULATION
>>   #include <asm/unistd_32_ia32.h>
>>   static inline void reload_segments(struct sigcontext_32 *sc)
>>   {
>> -    unsigned int cur;
>> +    u16 cur;
>> +    /*
>> +     * Reload fs and gs if they have changed in the signal
>> +     * handler.  This does not handle long fs/gs base changes in
>> +     * the handler, but does not clobber them at least in the
>> +     * normal case.
>> +     */
>>       savesegment(gs, cur);
>> -    if ((sc->gs | 0x03) != cur)
>> -        load_gs_index(sc->gs | 0x03);
>> +    if (fixup_rpl(sc->gs) != cur)
>> +        load_gs_index(fixup_rpl(sc->gs));
>>       savesegment(fs, cur);
>> -    if ((sc->fs | 0x03) != cur)
>> -        loadsegment(fs, sc->fs | 0x03);
>> +    if (fixup_rpl(sc->fs) != cur)
>> +        loadsegment(fs, fixup_rpl(sc->fs));
>> +
>>       savesegment(ds, cur);
>> -    if ((sc->ds | 0x03) != cur)
>> -        loadsegment(ds, sc->ds | 0x03);
>> +    if (fixup_rpl(sc->ds) != cur)
>> +        loadsegment(ds, fixup_rpl(sc->ds));
>>       savesegment(es, cur);
>> -    if ((sc->es | 0x03) != cur)
>> -        loadsegment(es, sc->es | 0x03);
>> +    if (fixup_rpl(sc->es) != cur)
>> +        loadsegment(es, fixup_rpl(sc->es));
>>   }
>>   #define sigset32_t            compat_sigset_t
>> @@ -105,18 +135,12 @@ static bool ia32_restore_sigcontext(struct 
>> pt_regs *regs,
>>       regs->orig_ax = -1;
>>   #ifdef CONFIG_IA32_EMULATION
>> -    /*
>> -     * Reload fs and gs if they have changed in the signal
>> -     * handler.  This does not handle long fs/gs base changes in
>> -     * the handler, but does not clobber them at least in the
>> -     * normal case.
>> -     */
>>       reload_segments(&sc);
>>   #else
>> -    loadsegment(gs, sc.gs);
>> -    regs->fs = sc.fs;
>> -    regs->es = sc.es;
>> -    regs->ds = sc.ds;
>> +    loadsegment(gs, fixup_rpl(sc.gs));
>> +    regs->fs = fixup_rpl(sc.fs);
>> +    regs->es = fixup_rpl(sc.es);
>> +    regs->ds = fixup_rpl(sc.ds);
>>   #endif
>>       return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
>>
>> base-commit: 6ff908de1eafb53f31db75d929b7566a87847d2d
> 
> 


