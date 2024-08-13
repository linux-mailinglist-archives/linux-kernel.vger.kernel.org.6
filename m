Return-Path: <linux-kernel+bounces-285124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F49509A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83291C20D95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0E1A0AEC;
	Tue, 13 Aug 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Lo1epB0q"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4351A0709
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564734; cv=none; b=JMmSHZRvfFaaRR7Sl0Fj7+qdd+/fG/p9r5cJ7Fse/QrgURyEqd7Cxh1i0LQCfDhIK0vMv8Lqv2bugAK778r+K/0FMju0lZwQ+wpA9k2h/OrGuU4NQyek6wJcxQ6A+0m7NuGPFdw2zmlx4Iy9envelVQAyUlgig/CL7L/ZKARK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564734; c=relaxed/simple;
	bh=1Ckxv8jSdMBTiunwLquhCJV5YIgmV+FyGFpIc/FlWGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxIA0pMnRNaN8JP2bGErKrQAH2Uuo9TLAOtUliR9AZ4L/ATouoHGfAfMM8272Xefir92FZJHm8fSFp4EB2QSohc7desl836kOYbDJ4EVgzLL0qVm0tvp5W/Qs1crTsEzjy31sq9Hmms4uhYdp2GTViWswwMr49CR1jlNmCEKF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Lo1epB0q; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47DFvmUM3635396
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 13 Aug 2024 08:57:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47DFvmUM3635396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723564670;
	bh=WrWmR8iN2SHSshxTBWTkTkIA2ERUPQI/IO5pWX3LmBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lo1epB0quexQBLfl35JRk1c1PdZ0mdhbgH8C+vjWV7DIPsPrS6DMAI+AcZZP0PfJy
	 jXhoT/p3LLRC53qF78C8ti5Xcs3+exKMKHcXUETsq9GsmsNjOFbtq8LuHo9DBDeLmu
	 W1xb6L7u5G3oW7J9pn5kpqOag2lDhAW6ldsOilHP4jW0ufFElQE/km7o8j6H4YTyob
	 fiYBRKmfkNpzp2Pyaz4NNkVlRkAjFpNVx7UsbEZsZ2s51ad8Q6UhQ90ORdPGo9Kb64
	 7RNBGE6bjg+IcRTAHs63/6onTPtq30/kUld3Abh5MOowTpG40opWIRDR8t3/NTCRY2
	 BXgQ5HgsdZxKQ==
Message-ID: <81c3e14a-59a4-4aae-a0e3-c415f4c294be@zytor.com>
Date: Tue, 13 Aug 2024 08:57:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] x86/fred: Enable FRED right after
 init_mem_mapping()
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com,
        nik.borisov@suse.com, houwenlong.hwl@antgroup.com
References: <20240709154048.3543361-1-xin@zytor.com>
 <20240709154048.3543361-4-xin@zytor.com> <874j7or3q8.ffs@tglx>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <874j7or3q8.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/2024 5:45 AM, Thomas Gleixner wrote:
> On Tue, Jul 09 2024 at 08:40, Xin Li wrote:
> 
> I'm really unhappy about sprinkling all these FRED conditionals all over
> the place:

Sigh, for the reason of a bad taste...


>>   	init_mem_mapping();
>>   
>> -	idt_setup_early_pf();
>> +	/*
>> +	 * init_mem_mapping() uses early IDT to setup memory mappings, thus FRED
>> +	 * can't be enabled earlier than that, unless FRED adds support to setup
>> +	 * memory mappings.
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
>> +		cpu_init_fred_exceptions();
>> +	else
>> +		idt_setup_early_pf();
>    
>> @@ -248,6 +249,11 @@ static void notrace start_secondary(void *unused)
>>   
>>   	cpu_init_exception_handling();
>>   
>> +	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
>> +		cpu_init_fred_exceptions();
>> +		cpu_init_fred_rsps();
>> +	}
> 
>>   	/* Init cpu_entry_area before IST entries are set up */
>>   	setup_cpu_entry_areas();
>>   
>> +	/* FRED RSPs pointing to memory from CPU entry areas */
>> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
>> +		cpu_init_fred_rsps();
>> +
>>   	/* Init GHCB memory pages when running as an SEV-ES guest */
>>   	sev_es_init_vc_handling();
> 
> This really can be encapsulated and kept in places which need to know
> about FRED already. See below. Can you please validate?

I reviewed your patch, and there is no reason it won't work; my tests
show no problem with it.

Thanks!
     Xin


> ---
> From: "Xin Li (Intel)" <xin@zytor.com>
> Subject: x86/fred: Enable FRED right after init_mem_mapping()
> Date: Tue, 09 Jul 2024 08:40:48 -0700
> 
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> On 64-bit init_mem_mapping() relies on the minimal page fault handler
> provided by the early IDT mechanism. The real page fault handler is
> installed right afterwards into the IDT.
> 
> This is problematic on CPUs which have X86_FEATURE_FRED set because the
> real page fault handler retrieves the faulting address from the FRED
> exception stack frame and not from CR2, but that does obviously not work
> when FRED is not yet enabled in the CPU.
> 
> To prevent this enable FRED right after init_mem_mapping() without
> interrupt stacks. Those are enabled later in trap_init() after the CPU
> entry area is set up.
> 
> [ tglx: Encapsulate the FRED details ]
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20240709154048.3543361-4-xin@zytor.com
> ---
>   arch/x86/include/asm/processor.h |    3 ++-
>   arch/x86/kernel/cpu/common.c     |   15 +++++++++++++--
>   arch/x86/kernel/setup.c          |    7 ++++++-
>   arch/x86/kernel/smpboot.c        |    2 +-
>   arch/x86/kernel/traps.c          |    2 +-
>   5 files changed, 23 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -582,7 +582,8 @@ extern void switch_gdt_and_percpu_base(i
>   extern void load_direct_gdt(int);
>   extern void load_fixmap_gdt(int);
>   extern void cpu_init(void);
> -extern void cpu_init_exception_handling(void);
> +extern void cpu_init_exception_handling(bool boot_cpu);
> +extern void cpu_init_replace_early_idt(void);
>   extern void cr4_init(void);
>   
>   extern void set_task_blockstep(struct task_struct *task, bool on);
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2176,7 +2176,7 @@ static inline void tss_setup_io_bitmap(s
>    * Setup everything needed to handle exceptions from the IDT, including the IST
>    * exceptions which use paranoid_entry().
>    */
> -void cpu_init_exception_handling(void)
> +void cpu_init_exception_handling(bool boot_cpu)
>   {
>   	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
>   	int cpu = raw_smp_processor_id();
> @@ -2196,13 +2196,24 @@ void cpu_init_exception_handling(void)
>   	setup_ghcb();
>   
>   	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> -		cpu_init_fred_exceptions();
> +		/* The boot CPU has enabled FRED during early boot */
> +		if (!boot_cpu)
> +			cpu_init_fred_exceptions();
> +
>   		cpu_init_fred_rsps();
>   	} else {
>   		load_current_idt();
>   	}
>   }
>   
> +void __init cpu_init_replace_early_idt(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		cpu_init_fred_exceptions();
> +	else
> +		idt_setup_early_pf();
> +}
> +
>   /*
>    * cpu_init() initializes state that is per-CPU. Some data is already
>    * initialized (naturally) in the bootstrap process, such as the GDT.  We
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1039,7 +1039,12 @@ void __init setup_arch(char **cmdline_p)
>   
>   	init_mem_mapping();
>   
> -	idt_setup_early_pf();
> +	/*
> +	 * init_mem_mapping() relies on the early IDT page fault handling.
> +	 * Now either enable FRED or install the real page fault handler
> +	 * for 64-bit in the IDT.
> +	 */
> +	cpu_init_replace_early_idt();
>   
>   	/*
>   	 * Update mmu_cr4_features (and, indirectly, trampoline_cr4_features)
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -246,7 +246,7 @@ static void notrace start_secondary(void
>   		__flush_tlb_all();
>   	}
>   
> -	cpu_init_exception_handling();
> +	cpu_init_exception_handling(false);
>   
>   	/*
>   	 * Load the microcode before reaching the AP alive synchronization
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1411,7 +1411,7 @@ void __init trap_init(void)
>   	sev_es_init_vc_handling();
>   
>   	/* Initialize TSS before setting up traps so ISTs work */
> -	cpu_init_exception_handling();
> +	cpu_init_exception_handling(true);
>   
>   	/* Setup traps as cpu_init() might #GP */
>   	if (!cpu_feature_enabled(X86_FEATURE_FRED))
> 


