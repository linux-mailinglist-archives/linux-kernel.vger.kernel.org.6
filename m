Return-Path: <linux-kernel+bounces-565518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60966A66A08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA21189CE74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38C1990C7;
	Tue, 18 Mar 2025 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FPdExM78"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351145C14
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277641; cv=none; b=A9PMlujoimkqlSPfE4NNNe77lP5CgBRTY/DwFuomH6JNOZsks2V4gG6l9/6sn8Pj7BcyjQPYCnfPRqkNtyOXbytSB2MyCTBfGxcflSBl4vAXZgqoZS1qNboOhhbTGXuWLF04KRUKuPIIQYwqzPT3Awa+7Dz1UE8ulj9mY6vKVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277641; c=relaxed/simple;
	bh=GJZU2JfjJkhbfPSnWW6RYhKd6jDdAkQuJPAiVZ1hMTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqKwpdgmAcARCshJr/7aPoHiFLYsdAOmzJ8Dr+ieWLHkpNKFAQSFefpjTpe2Su9NqAw65v73e0Gntj+Fb4SB6/lIG/y2u2K8NnfBrE1zJqFV4l7vycRMqMEvw2uUFmTKH1u/ygAtNFpRDAFxxOWJ4WWY+pksWVwE7FYfNVCs+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FPdExM78; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I5xxOu878721
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Mar 2025 23:00:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I5xxOu878721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742277601;
	bh=O8LhtR942QcwHpisKgyyhxGFSEpX0G1Z/2lUU2Sckls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FPdExM784Kgb+WStuZCkdv7L/AJewDHAM56qlVypx5DSLAcuabdA8DSe2wQ9tLgAC
	 wmZbaAOVXtWFQhhx9o4/Py4IqIEsC5twdw3SykDYPbSQV3rTJCB+6b5aRVZUIZjdMr
	 SKh4mJYlu0LkjcKFYUUPFeMi6WwWh0Xx5l3w2Md39aqXr4W+xMvkIxzqFpDY6jNMfQ
	 AbM9RvXK3+TVD2U3ziLh40/Qv/RNjPScjQf0uMFte201v5WblJEk/EYjvAtTP0aUVs
	 zpqQgEOEve+VQFfUDb4vEs2eCYwX4YZXJmTnJuidVXKaVq0eq4Zz928f7VCu8s2MFI
	 1jT5bsUozGN+g==
Message-ID: <036d36f3-34b0-41b2-be5b-59bd3338e806@zytor.com>
Date: Mon, 17 Mar 2025 22:59:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "H . Peter Anvin"
 <hpa@zytor.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-5-mingo@kernel.org>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250317221824.3738853-5-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/2025 3:18 PM, Ingo Molnar wrote:
> Convert all uses of 'unsigned int' to 'u32' in <asm/cpuid/api.h>.
> 
> This is how a lot of the call sites are doing it, and the two
> types are equivalent in the C sense - but 'u32' better expresses
> that these are expressions of an immutable hardware ABI.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Ahmed S. Darwish <darwi@linutronix.de>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: x86-cpuid@lists.linux.dev
> Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
> ---
>   arch/x86/include/asm/cpuid/api.h | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
> index f26926ba5289..356db1894588 100644
> --- a/arch/x86/include/asm/cpuid/api.h
> +++ b/arch/x86/include/asm/cpuid/api.h
> @@ -22,8 +22,8 @@ static inline bool have_cpuid_p(void)
>   }
>   #endif
>   
> -static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
> -				unsigned int *ecx, unsigned int *edx)
> +static inline void native_cpuid(u32 *eax, u32 *ebx,
> +				u32 *ecx, u32 *edx)
>   {
>   	/* ecx is often an input as well as an output. */
>   	asm volatile("cpuid"
> @@ -36,9 +36,9 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
>   }
>   
>   #define NATIVE_CPUID_REG(reg)					\
> -static inline unsigned int native_cpuid_##reg(unsigned int op)	\
> +static inline u32 native_cpuid_##reg(u32 op)	\
>   {								\
> -	unsigned int eax = op, ebx, ecx = 0, edx;		\
> +	u32 eax = op, ebx, ecx = 0, edx;		\
>   								\
>   	native_cpuid(&eax, &ebx, &ecx, &edx);			\
>   								\
> @@ -65,9 +65,9 @@ NATIVE_CPUID_REG(edx)
>    * Clear ECX since some CPUs (Cyrix MII) do not set or clear ECX
>    * resulting in stale register contents being returned.
>    */
> -static inline void cpuid(unsigned int op,
> -			 unsigned int *eax, unsigned int *ebx,
> -			 unsigned int *ecx, unsigned int *edx)
> +static inline void cpuid(u32 op,
> +			 u32 *eax, u32 *ebx,
> +			 u32 *ecx, u32 *edx)
>   {
>   	*eax = op;
>   	*ecx = 0;
> @@ -75,9 +75,9 @@ static inline void cpuid(unsigned int op,
>   }
>   
>   /* Some CPUID calls want 'count' to be placed in ECX */
> -static inline void cpuid_count(unsigned int op, int count,
> -			       unsigned int *eax, unsigned int *ebx,
> -			       unsigned int *ecx, unsigned int *edx)
> +static inline void cpuid_count(u32 op, int count,
> +			       u32 *eax, u32 *ebx,
> +			       u32 *ecx, u32 *edx)
>   {
>   	*eax = op;
>   	*ecx = count;
> @@ -88,43 +88,43 @@ static inline void cpuid_count(unsigned int op, int count,
>    * CPUID functions returning a single datum:
>    */
>   
> -static inline unsigned int cpuid_eax(unsigned int op)
> +static inline u32 cpuid_eax(u32 op)
>   {
> -	unsigned int eax, ebx, ecx, edx;
> +	u32 eax, ebx, ecx, edx;
>   
>   	cpuid(op, &eax, &ebx, &ecx, &edx);
>   
>   	return eax;
>   }
>   
> -static inline unsigned int cpuid_ebx(unsigned int op)
> +static inline u32 cpuid_ebx(u32 op)
>   {
> -	unsigned int eax, ebx, ecx, edx;
> +	u32 eax, ebx, ecx, edx;
>   
>   	cpuid(op, &eax, &ebx, &ecx, &edx);
>   
>   	return ebx;
>   }
>   
> -static inline unsigned int cpuid_ecx(unsigned int op)
> +static inline u32 cpuid_ecx(u32 op)
>   {
> -	unsigned int eax, ebx, ecx, edx;
> +	u32 eax, ebx, ecx, edx;
>   
>   	cpuid(op, &eax, &ebx, &ecx, &edx);
>   
>   	return ecx;
>   }
>   
> -static inline unsigned int cpuid_edx(unsigned int op)
> +static inline u32 cpuid_edx(u32 op)
>   {
> -	unsigned int eax, ebx, ecx, edx;
> +	u32 eax, ebx, ecx, edx;
>   
>   	cpuid(op, &eax, &ebx, &ecx, &edx);
>   
>   	return edx;
>   }
>   
> -static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
> +static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
>   {
>   	regs[CPUID_EAX] = leaf;
>   	regs[CPUID_ECX] = subleaf;
> @@ -141,7 +141,7 @@ static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *re
>   	__cpuid_read(leaf, 0, (u32 *)(regs));		\
>   }
>   
> -static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
> +static inline void __cpuid_read_reg(u32 leaf, u32 subleaf,
>   				    enum cpuid_regs_idx regidx, u32 *reg)
>   {
>   	u32 regs[4];

A nice move to set the standard.

When refactoring the MSR code, I also converted all unsigned int to u32.

Reviewed-by: Xin Li (Intel) <xin@zytor.com>


