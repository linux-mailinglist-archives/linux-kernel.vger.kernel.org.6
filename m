Return-Path: <linux-kernel+bounces-318720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B401696F20A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432B91F253C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5CA1CB127;
	Fri,  6 Sep 2024 10:58:46 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A31CB123
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620326; cv=none; b=eR7gvXWkD7mzKK0IRdDcztMGN9TcIIuSzWbZP2u7g1Y0n1UJo9hrVrjafixwnX+JbSlTd1LzpCoK8/1ruuGOmd1IqWBfwe1Vv5Birg6cZMuF8CsXknrP8WJ90tjlOoiZmuIxNGaWps30Gx+VWEWmk85wMxuOolw/oT1ywrWkXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620326; c=relaxed/simple;
	bh=Zq57PBpzZysmGRGS9HwVPjJKKdOONLleCMhwEaKJLEc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ewn3MR9+GO6izP2kPAz4XyAxFrnGubgyZGXKgiWBj/jLlv0NS/r0MuPNH4LZuSQn4bpMx1064aKGYBd/nfILJHcyziu/hJt7njYItNNb7GrlEGcf2QIw8yxDhpA511Fih95sF0bAfJHQrcWIrNMqkfb97fkdMyVltq8n9JVjDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X0Y8t1Gwvz1P9J7;
	Fri,  6 Sep 2024 18:57:34 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
	by mail.maildlp.com (Postfix) with ESMTPS id 37BD614011A;
	Fri,  6 Sep 2024 18:58:34 +0800 (CST)
Received: from [10.67.121.162] (10.67.121.162) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 18:58:33 +0800
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
 <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
From: "tiantao (H)" <tiantao6@hisilicon.com>
Message-ID: <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>
Date: Fri, 6 Sep 2024 18:58:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100009.china.huawei.com (7.202.181.223)


在 2024/9/6 17:44, Mark Rutland 写道:
> On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
>> When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
>> full name of the Not-aligned access. nAA bit has two values:
>> 0b0 Unaligned accesses by the specified instructions generate an
>> Alignment fault.
>> 0b1 Unaligned accesses by the specified instructions do not generate
>> an Alignment fault.
>>
>> this patch sets the nAA bit to 1,The following instructions will not
>> generate an Alignment fault if all bytes being accessed are not within
>> a single 16-byte quantity:
>> • LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
>> LDLARH.
>> • STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> What is going to depend on this? Nothing in the kernel depends on being
> able to make unaligned accesses with these instructions, and (since you
> haven't added a HWCAP), userspace has no idea that these accesses won't
> generate an alignment fault.
>
> Mark.

I've come across a situation where the simplified code is as follows:

  long  address = (long) mmap(NULL,1024*1024*2,PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS,-1,0);

long new_address = address + 9;

  long *p = (long*) new_address;
  long v = -1;

  __atomic_store(p, &v, __ATOMIC_RELEASE);


coredump occurs after executing __atomic_store, but the user code can't 
be changed,

so I'm trying to enable NAA to solve this problem.

>> ---
>>   arch/arm64/Kconfig              | 10 ++++++++++
>>   arch/arm64/include/asm/sysreg.h |  1 +
>>   arch/arm64/kernel/cpufeature.c  | 18 ++++++++++++++++++
>>   arch/arm64/tools/cpucaps        |  1 +
>>   4 files changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 77d7ef0b16c2..7afe73ebcd79 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2023,6 +2023,16 @@ config ARM64_TLB_RANGE
>>   	  The feature introduces new assembly instructions, and they were
>>   	  support when binutils >= 2.30.
>>   
>> +config ARM64_LSE2_NAA
>> +	bool "Enable support for not-aligned access"
>> +	depends on AS_HAS_ARMV8_4
>> +	help
>> +	 LSE2 is an extension to the original LSE (Large System Extensions) feature,
>> +	 introduced in ARMv8.4.
>> +
>> +	 Enable this feature will not generate an Alignment fault if all bytes being
>> +	 accessed are not within a single 16-byte quantity.
>> +
>>   endmenu # "ARMv8.4 architectural features"
>>   
>>   menu "ARMv8.5 architectural features"
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 8cced8aa75a9..42e3a1959aa8 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -854,6 +854,7 @@
>>   #define SCTLR_ELx_ENDB	 (BIT(13))
>>   #define SCTLR_ELx_I	 (BIT(12))
>>   #define SCTLR_ELx_EOS	 (BIT(11))
>> +#define SCTLR_ELx_nAA    (BIT(6))
>>   #define SCTLR_ELx_SA	 (BIT(3))
>>   #define SCTLR_ELx_C	 (BIT(2))
>>   #define SCTLR_ELx_A	 (BIT(1))
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 646ecd3069fd..558869a7c7f0 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2299,6 +2299,14 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>>   }
>>   #endif /* CONFIG_ARM64_MTE */
>>   
>> +#ifdef CONFIG_ARM64_LSE2_NAA
>> +static void cpu_enable_lse2(const struct arm64_cpu_capabilities *__unused)
>> +{
>> +	sysreg_clear_set(sctlr_el2, SCTLR_ELx_nAA, SCTLR_ELx_nAA);
>> +	isb();
>> +}
>> +#endif
>> +
>>   static void user_feature_fixup(void)
>>   {
>>   	if (cpus_have_cap(ARM64_WORKAROUND_2658417)) {
>> @@ -2427,6 +2435,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>   		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, ATOMIC, IMP)
>>   	},
>>   #endif /* CONFIG_ARM64_LSE_ATOMICS */
>> +#ifdef CONFIG_ARM64_LSE2_NAA
>> +	{
>> +		.desc = "Support for not-aligned access",
>> +		.capability = ARM64_HAS_LSE2,
>> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
>> +		.matches = has_cpuid_feature,
>> +		.cpu_enable = cpu_enable_lse2,
>> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, AT, IMP)
>> +	},
>> +#endif
>>   	{
>>   		.desc = "Virtualization Host Extensions",
>>   		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>> index ac3429d892b9..0c7c0a293574 100644
>> --- a/arch/arm64/tools/cpucaps
>> +++ b/arch/arm64/tools/cpucaps
>> @@ -41,6 +41,7 @@ HAS_HCX
>>   HAS_LDAPR
>>   HAS_LPA2
>>   HAS_LSE_ATOMICS
>> +HAS_LSE2
>>   HAS_MOPS
>>   HAS_NESTED_VIRT
>>   HAS_PAN
>> -- 
>> 2.33.0
>>
>>
> .
>

