Return-Path: <linux-kernel+bounces-400477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766DD9C0E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B21C229C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E35217330;
	Thu,  7 Nov 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mgx4Qmh8"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704C215033
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005721; cv=none; b=O1WQK6UXxe1pmoNMyQAtuqL14NFE9/0DiTfTtCfazjmEQ2ev8CWROuE5b7X4B8KVVzpC7bqdEwqb6dnfnkkgFk6BiSLl+0kcGCI6s3Hr/yMARLYu390Eupww76oneK35Hl5vevMCeEcmRdzVd0NZ+1Vo3AhoZl1NVRagykluldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005721; c=relaxed/simple;
	bh=4U39fzIcs8P5XDnNVHD8NIWWxFQkVupb0Soi/dDdLiE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZpWoDUrA0fvsaNESzWSYLRGLFnMzIfcMsNoE797DsNycQareW8rYa/zan0TnoKUxqs9/M8hyEV5KFR4YdkXVNgWG+H+WupGbj0KKbwx1ka653dK/s4w25EJ2G9CSxcFJUR5W9RTQOHDAVPd4eEljKfB3UZi+rBcceKqOh6cI8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mgx4Qmh8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A7IsNqo1264697
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 7 Nov 2024 10:54:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A7IsNqo1264697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731005665;
	bh=k6nTHCVMqZEVcSD8rZFi+NwZV+snJT8E9kBS9xynlKU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mgx4Qmh8lvqcmmE+INd4apCE+u/Aa7Dy7kqqNtC/Nu7vgXJxh/miV+1b8lEg2/Hc2
	 EZGwnFXbRZDQ6UYWlV3xlck38CwiU8YY5YshAQDUpaNb0hZ+z6CcIchwvlpH+pb/uc
	 LgJNf4yueja1sfwKO/dMQ/XDzEPEXpNg8W2PgIOu/lAec7LpSJIFylFc/di/3YATvk
	 9PMEltZ4GZ0B8Xo3hoyfJ08FCGhiS1hHBdpkVGwnpO6N7+H9mqXS2/aJ5lJb+frRut
	 wRFDeRAfCOaaKImZIeW5p1QrGK617aFehUBJ19TsbKeSIrric3Fh5AWA7HQWBCa0Kl
	 fzUILTv2VWgOw==
Message-ID: <49b6c23b-dfd8-4874-bd6e-998dd039ed1a@zytor.com>
Date: Thu, 7 Nov 2024 10:54:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com
References: <20240916181000.416513-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240916181000.416513-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/2024 11:10 AM, Xin Li (Intel) wrote:
> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
> 
> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
> is left set, because the CPU IBT will be set in the WFE state upon
> completion of the following ERETS instruction and then the CPU will
> resume from the instruction that just caused the previous #CP.
> 
> Clear WFE to avoid dead looping in missing-ENDBRANCH #CPs.
> 
> Describe the IBT story in the comment of ibt_clear_fred_wfe() using
> Andrew Cooper's write-up.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
> 
> Changes since v1:
> * Rewrite the comment of ibt_clear_fred_wfe() using Andrew Cooper's
>    write-up (Andrew Cooper).
> * Unconditionally clear WFE in missing-ENDBRANCH #CPs (Peter Zijlstra).
> * Don't check X86_FEATURE_FRED in ibt_clear_fred_wfe() (Dave Hansen &
>    Andrew Cooper).
> ---
>   arch/x86/kernel/cet.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index d2c732a34e5d..d2cf6ee0d9a0 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -81,6 +81,36 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
>   
>   static __ro_after_init bool ibt_fatal = true;
>   
> +/*
> + * By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
> + *
> + * But, in original CET under IDT delivery, any transfer for
> + * interrupt/exception/etc that does not change privilege will clobber the
> + * WFE state because MSR_{U,S}_CET.WFE is intentionally set by microcode so
> + * as to expect to find an ENDBR at the interrupt/exception/syscall entrypoint.
> + *
> + * In practice, this means interrupts and exceptions hitting the kernel, or
> + * user interrupts, lose the WFE state of the interrupted context.  And
> + * yes, this means that a well timed interrupt (to the precise instruction
> + * boundary) will let an attacker sneak a bad function pointer past the
> + * CET-IBT enforcement.
> + *
> + * In FRED, the WFE state of the interrupted context (even if it is the
> + * same privilege) is preserved and restored, in order to close this hole.
> + *
> + * Therefore, the missing-ENDBRANCH #CP handler needs to clear WFE to avoid
> + * dead looping, now that FRED is causing the state not to get lost.  Otherwise
> + * if the WFE bit is left set in an intentional ibt selftest or when !ibt_fatal,
> + * the CPU will generate another missing-ENDBRANCH #CP because the IBT will be
> + * set in the WFE state upon completion of the following ERETS instruction and
> + * then the CPU will resume from the instruction that just caused the previous
> + * missing-ENDBRANCH #CP.
> + */
> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
> +{
> +	regs->fred_cs.wfe = 0;
> +}
> +
>   static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
>   {
>   	if ((error_code & CP_EC) != CP_ENDBR) {
> @@ -88,6 +118,8 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
>   		return;
>   	}
>   
> +	ibt_clear_fred_wfe(regs);
> +
>   	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
>   		regs->ax = 0;
>   		return;
> 
> base-commit: fe85ee391966c4cf3bfe1c405314e894c951f521


Andrew,

can you please take another look?

If there is no obvious problem, please give it a review-by?

Thanks!
     Xin



