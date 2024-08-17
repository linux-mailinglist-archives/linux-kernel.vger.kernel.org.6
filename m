Return-Path: <linux-kernel+bounces-290794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D529558BE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27BC1C20C8A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560012C54D;
	Sat, 17 Aug 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FW3hjrWY"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A52107
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909555; cv=none; b=LkxEziQs8hmvJR2f4ttt9b+c3TEyu0ypEji9lKaAtBmtdIoJ367Bh2MVnIRClYu+EBLSan6nHcq5VQxzfVP+fQbDfoD/PHM6DOR08RFX2cte+XayplEqBxEFTY5YoF5/J1Cra8nxAIltvuQ57V9BuC/LSpQKYjdKlOZtSn3MAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909555; c=relaxed/simple;
	bh=OGL62sB61emjnqbxIJmLloDZuR4baw1Q9bvuaSpytS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wbjabm2sBgYHgW9A0sKh8llzkV+6jep625zi0Qg69PVsmr1k4XXuCNRr86e22GDPBNjydTxu2b/idpilkA6a8CH1KunCQK8QpEKkc7/uhEoKpJbAXdOIdQc5B+Qxd/FAP/DjrEiIbB0av+Y29IuH8NQYioKL5SYn0CxHHhX9uCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FW3hjrWY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47HFitWQ4187346
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Aug 2024 08:44:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47HFitWQ4187346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723909497;
	bh=TmC4Ju3hvlDQzhjXGLimT3wqkboBWiuJZaYmGcB8Xf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FW3hjrWYa+nmYAPJpAVIlEH9OXwnCzVQzpEAj2jIIW70EXY93zo/YoeDF8HZKL+1l
	 TEUv+snd/4DoC2xu/Eu56htAA3Ls0efVOHvJkQp2CxBT4Vs3rbMtSPQPwYmhLACopG
	 i2iDgEEYpTvkp7neu9CBkb/cQf7Xu+OERSiFPn1bDTLBtJdHOpCQLRlSWU2h34znTJ
	 FLow+lFGdqQd0jp5B/+16NPgeRj4Pl98ww6KNJrynYRIhtVzGsf8H/VT+zHL80E8Az
	 0a6Z88Ki3egq968sy3BBxusB5MoGAvkHsYDD2jieIRPB4rkjGwYERDBsi46ntngn5Y
	 AB8AQOfH+ZBsA==
Message-ID: <451f9224-f0de-43c5-b178-2bb4281e5ad2@zytor.com>
Date: Sat, 17 Aug 2024 08:44:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
To: Borislav Petkov <bp@alien8.de>, Andrew Cooper
 <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org, seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
 <20240817144316.GAZsC3BOm7anUPdJGe@fat_crate.local>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240817144316.GAZsC3BOm7anUPdJGe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/2024 7:43 AM, Borislav Petkov wrote:
> On Sat, Aug 17, 2024 at 05:23:07PM +0300, Borislav Petkov wrote:
>>> static __always_inline void wrmsr(u32 msr, u64 val)
>>> {
>>> 	asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS,
>>> 					 "call asm_xen_write_msr", X86_FEATURE_XENPV)
>>> 		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>>> 		     : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
>>> 		     "D" (msr), "S" (val));
>>> }
>>>
>>>
>>> As the CALL instruction is 5-byte long, and we need to pad nop for both
>>> WRMSR and WRMSRNS, what about not using segment prefix at all?
>>
>> The alternatives macros can handle arbitrary insn sizes - no need for any padding.
> 
> What you cannot do is have a CALL insn in only one of the alternative
> insn groups because the compiler is free to clobber callee regs and
> those might be live where you place the alternative and thus will have
> a nice lovely corruption.

Yeah, asm_xen_write_msr() is a wrapper function to xen_write_msr() which
saves/restores those regs.

My first draft patch calls xen_write_msr() directly and works fine.  But
hpa said the same thing as you said.

Thanks!
     Xin


