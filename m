Return-Path: <linux-kernel+bounces-318757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D296F2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A08B1C2126E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785E1CB307;
	Fri,  6 Sep 2024 11:19:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040541C9EC2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621547; cv=none; b=rbrSDd5JmuIfapEgcC3PP/GRg+8LP2havDcNteLbXt3X8xZJwfMfBgtvcpon9UJ+0aCQg0peoLFfJ1KWAVRNo3Ufpv8xjans3kWWFePco42PbyFORfIZJaipGsT52QHFh+9fh5P1jr8hkCkW2cLVwAlS9EQgYxQEe0Vq81IrcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621547; c=relaxed/simple;
	bh=iQbJlnuk1y+iKHhziZAAOCFXKKkrGqLQ34/q7llcj5k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X4x9uO5lDXw6H+J8zrdK4nh1QmLxKNOTCd2aQSlJfNt32+br4KHjEvn7/k4m2qglMBC1IpBpuOtCQ7JCZiVSpW2awua+J7RbE5VQ58/Cor6hMyp9Y8LAXcBb5jhdEu2aOJdPnQDVuwY521FaQaD0mnlHx3JZo8ljfKPg+mKVbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0YYb25PGz1HJCR;
	Fri,  6 Sep 2024 19:15:31 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
	by mail.maildlp.com (Postfix) with ESMTPS id F2D731A0188;
	Fri,  6 Sep 2024 19:19:00 +0800 (CST)
Received: from [10.67.121.162] (10.67.121.162) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 19:19:00 +0800
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
 <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
 <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>
 <Ztri2xyzjaB7k387@J2N7QTR9R3>
From: "tiantao (H)" <tiantao6@hisilicon.com>
Message-ID: <f0bda766-1a3a-ba4d-7988-03fcbf888c63@hisilicon.com>
Date: Fri, 6 Sep 2024 19:18:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Ztri2xyzjaB7k387@J2N7QTR9R3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100009.china.huawei.com (7.202.181.223)


在 2024/9/6 19:09, Mark Rutland 写道:
> On Fri, Sep 06, 2024 at 06:58:19PM +0800, tiantao (H) wrote:
>> 在 2024/9/6 17:44, Mark Rutland 写道:
>>> On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
>>>> When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
>>>> full name of the Not-aligned access. nAA bit has two values:
>>>> 0b0 Unaligned accesses by the specified instructions generate an
>>>> Alignment fault.
>>>> 0b1 Unaligned accesses by the specified instructions do not generate
>>>> an Alignment fault.
>>>>
>>>> this patch sets the nAA bit to 1,The following instructions will not
>>>> generate an Alignment fault if all bytes being accessed are not within
>>>> a single 16-byte quantity:
>>>> • LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
>>>> LDLARH.
>>>> • STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH
>>>>
>>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>> What is going to depend on this? Nothing in the kernel depends on being
>>> able to make unaligned accesses with these instructions, and (since you
>>> haven't added a HWCAP), userspace has no idea that these accesses won't
>>> generate an alignment fault.
>>>
>>> Mark.
>> I've come across a situation where the simplified code is as follows:
>>
>>   long  address = (long) mmap(NULL,1024*1024*2,PROT_READ|PROT_WRITE,
>> MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
>>
>> long new_address = address + 9;
>>
>>   long *p = (long*) new_address;
>>   long v = -1;
>>
>>   __atomic_store(p, &v, __ATOMIC_RELEASE);
>>
>> coredump occurs after executing __atomic_store, but the user code can't be
>> changed,
> Where is that code and why can't it be changed? That code has never
> worked and would always have generated a coredump, and even with this
> patch it cannot work on hardware without LSE2.
>   
This code works fine on x86 platforms and does not coredump.
>> so I'm trying to enable NAA to solve this problem.
> AFAICT that's making a kernel change to paper over a userspace bug.
> As-is I don't think that's a good justification for changing nAA.
>
> Mark.
armv8.4 support nAA as a feature that should be enabled in the kernel?
>>>> ---
>>>>    arch/arm64/Kconfig              | 10 ++++++++++
>>>>    arch/arm64/include/asm/sysreg.h |  1 +
>>>>    arch/arm64/kernel/cpufeature.c  | 18 ++++++++++++++++++
>>>>    arch/arm64/tools/cpucaps        |  1 +
>>>>    4 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index 77d7ef0b16c2..7afe73ebcd79 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -2023,6 +2023,16 @@ config ARM64_TLB_RANGE
>>>>    	  The feature introduces new assembly instructions, and they were
>>>>    	  support when binutils >= 2.30.
>>>> +config ARM64_LSE2_NAA
>>>> +	bool "Enable support for not-aligned access"
>>>> +	depends on AS_HAS_ARMV8_4
>>>> +	help
>>>> +	 LSE2 is an extension to the original LSE (Large System Extensions) feature,
>>>> +	 introduced in ARMv8.4.
>>>> +
>>>> +	 Enable this feature will not generate an Alignment fault if all bytes being
>>>> +	 accessed are not within a single 16-byte quantity.
>>>> +
>>>>    endmenu # "ARMv8.4 architectural features"
>>>>    menu "ARMv8.5 architectural features"
>>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>>> index 8cced8aa75a9..42e3a1959aa8 100644
>>>> --- a/arch/arm64/include/asm/sysreg.h
>>>> +++ b/arch/arm64/include/asm/sysreg.h
>>>> @@ -854,6 +854,7 @@
>>>>    #define SCTLR_ELx_ENDB	 (BIT(13))
>>>>    #define SCTLR_ELx_I	 (BIT(12))
>>>>    #define SCTLR_ELx_EOS	 (BIT(11))
>>>> +#define SCTLR_ELx_nAA    (BIT(6))
>>>>    #define SCTLR_ELx_SA	 (BIT(3))
>>>>    #define SCTLR_ELx_C	 (BIT(2))
>>>>    #define SCTLR_ELx_A	 (BIT(1))
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index 646ecd3069fd..558869a7c7f0 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>> @@ -2299,6 +2299,14 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>>>>    }
>>>>    #endif /* CONFIG_ARM64_MTE */
>>>> +#ifdef CONFIG_ARM64_LSE2_NAA
>>>> +static void cpu_enable_lse2(const struct arm64_cpu_capabilities *__unused)
>>>> +{
>>>> +	sysreg_clear_set(sctlr_el2, SCTLR_ELx_nAA, SCTLR_ELx_nAA);
>>>> +	isb();
>>>> +}
>>>> +#endif
>>>> +
>>>>    static void user_feature_fixup(void)
>>>>    {
>>>>    	if (cpus_have_cap(ARM64_WORKAROUND_2658417)) {
>>>> @@ -2427,6 +2435,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>>>    		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, ATOMIC, IMP)
>>>>    	},
>>>>    #endif /* CONFIG_ARM64_LSE_ATOMICS */
>>>> +#ifdef CONFIG_ARM64_LSE2_NAA
>>>> +	{
>>>> +		.desc = "Support for not-aligned access",
>>>> +		.capability = ARM64_HAS_LSE2,
>>>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>>>> +		.matches = has_cpuid_feature,
>>>> +		.cpu_enable = cpu_enable_lse2,
>>>> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, AT, IMP)
>>>> +	},
>>>> +#endif
>>>>    	{
>>>>    		.desc = "Virtualization Host Extensions",
>>>>    		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>>>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>>>> index ac3429d892b9..0c7c0a293574 100644
>>>> --- a/arch/arm64/tools/cpucaps
>>>> +++ b/arch/arm64/tools/cpucaps
>>>> @@ -41,6 +41,7 @@ HAS_HCX
>>>>    HAS_LDAPR
>>>>    HAS_LPA2
>>>>    HAS_LSE_ATOMICS
>>>> +HAS_LSE2
>>>>    HAS_MOPS
>>>>    HAS_NESTED_VIRT
>>>>    HAS_PAN
>>>> -- 
>>>> 2.33.0
>>>>
>>>>
>>> .
>>>
> .
>

