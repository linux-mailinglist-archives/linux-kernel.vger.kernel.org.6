Return-Path: <linux-kernel+bounces-383410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EC9B1B60
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0FC1F21B23
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286F1D63EF;
	Sat, 26 Oct 2024 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p9DVX9Gz"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDA176FCE
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729985340; cv=none; b=Mzg7AQifLch0QcfSKW+j4sadneh9r049xtZ2AoIbQ5uPs8Vof8XR/p7dHEeKI03avbIRj1YfHCln/sKJxqIIVbrPgCttrRN9tGw1IXWxiKJUVEh0exYMwlI2GlmBvHSfIUVNFu/CCQn9TAVmm0sS/2N9NnrNC01LSEc3Ndn7Kjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729985340; c=relaxed/simple;
	bh=4ajy+jDkpJzqcz9ToVxTDGB8p67ZKR+E/3WLvnq+goA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxYPUPU/gJXBK5q20QRGuOjaKvG+rHXSay3bF7Gp9FIHNVAy4ithurVROOGEghBkXDCabYpQeAJgMNwzm4LBGEye8o2oOzmlE3TXVHBOBOGSVyZ1mBSUB8JukqEjmCJVEsKtozrBcM78ulrneu4OWcG3pNLNW182YhNHcrctjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=p9DVX9Gz; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49QNS4K83061234
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 26 Oct 2024 16:28:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49QNS4K83061234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729985286;
	bh=dM9baLIs26UfGf674PAHCHiB9qWFiSMBSil4WxebK1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9DVX9GzCEOgOrP5ClJqb3mz0rWGhm0mwJZRGH4u0Ev1auhQg4VE/wjq4LAazoL6r
	 k1Twpockt1ZhmzEU3aYawouj/LhOvPC8pngTS7IpIyikczEARjJzjYRPYr1ekWBnQE
	 Ru8zudIi2QjsCByZHgi55nEcDbqoA3an3ugL/8WiQ+jugI/kgxnfB/wZGCDuobrxKo
	 294MtSWwERoRcmonf2vVeIE5IRVZXvGGkixYtxbCuZsp1zoPjwhnlXUmG84KcgybGX
	 0t5FY3LoEbLNQ+FkqTFTQZMZ2zWrCDeZvfChuaOU0HF6KpONpF1W2w1Nh6q31qCLzi
	 CiEr149eEF0JA==
Message-ID: <77294ea6-480b-456e-8102-6c36ed4b7b96@zytor.com>
Date: Sat, 26 Oct 2024 16:28:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20241007083345.47215-1-ubizjak@gmail.com>
 <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com>
 <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com>
 <12E72F30-EF1D-4A1B-9D71-3A7FD5AF343C@zytor.com>
 <CAFULd4a5+er=7xk+oXOtOsJVUqg86ZWxxvX7jdtOEBcMX60fKg@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAFULd4a5+er=7xk+oXOtOsJVUqg86ZWxxvX7jdtOEBcMX60fKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/24 14:01, Uros Bizjak wrote:
>>
>> What does ASM_CALL_CONSTRAINT actually do *in the kernel*, *for x86*? There isn't a redzone in the kernel, and there *can't* be, because asynchronous events can clobber data below the stack pointer at any time.
> 
> The reason for ASM_CALL_CONSTRAINT is explained in arch/x86/include/asm/asm.h:
> 
> --q--
> /*
>   * This output constraint should be used for any inline asm which has a "call"
>   * instruction.  Otherwise the asm may be inserted before the frame pointer
>   * gets set up by the containing function.  If you forget to do this, objtool
>   * may print a "call without frame pointer save/setup" warning.
>   */
> register unsigned long current_stack_pointer asm(_ASM_SP);
> #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
> --/q--
> 
> __alternative_atomic64() macro always uses CALL instruction and one of
> alternatives in __arch_{,try_}cmpxchg64_emu() uses CALL as well, so
> according to the above comment, they all qualify for
> ASM_CALL_CONSTRAINT. This constraint is added to the mentioned macros
> in the proposed series [1].
> 
> [1] https://lore.kernel.org/lkml/20241024180612.162045-1-ubizjak@gmail.com/
>

Ugh. I am not criticizing the usage here, but the construct is 
bleacherous, because it converts what is properly an input constraint 
into an inout constraint, which wouldn't be a big deal except for the 
slight fact that older compilers don't allow asm goto to have output 
constraints.

By any sane definition, the constraint should actually be an input 
constraint on the frame pointer itself; something like:

#define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))

... except that "r" really should be a %rbp constraint, but %rbp doesn't 
seem to have a constraint letter. At least gcc 14.2 seems to do the 
right thing anyway, though: __builtin_frame_address(0) seems to force a 
frame pointer to have been created (even with -fomit-frame-pointer 
specified, and in a leaf function), and the value is always passed in 
%rbp (because why on Earth would it do it differently, when it is 
sitting right there?)

	-hpa





