Return-Path: <linuxppc-dev+bounces-6701-lists+linuxppc-dev=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linuxppc-dev@lfdr.de
Delivered-To: lists+linuxppc-dev@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D31A4E49C
	for <lists+linuxppc-dev@lfdr.de>; Tue,  4 Mar 2025 17:01:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6gQM05Y4z3bn1;
	Wed,  5 Mar 2025 03:00:59 +1100 (AEDT)
X-Original-To: linuxppc-dev@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=160.75.25.116 arc.chain=subspace.kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741104058;
	cv=pass; b=D4b/1VsEnltW8aSu/QwGkiB6zVyLbO5Cq8cGPnegNp/5EUK4FbmBzLIM83ID09oHiP4ZIGywhPSH3GtBVWYm3xVZOmqykwwQ/NyHtZZvhTyqwgOksMJjQ4WW2EVoLJWgVRHHfAnTdAGyJ4gyfQFBLkYoaOBxOaI6spU09v4Nygg3hJpaMRe+u3ASiyNS0he5ttXcQ3IgTS/BOBYIWR+hdLyczw7qU2u2k850L4/pl2iHoJfs0ziVglfeOqNluCzZfOpQ+1MDbpszXN7f3oaGAoCOimQBLddvvKPJ6KRGVJkgT7xpBlg0Fd3qsprqNdjZV22sNPPkWC7eW3ioLvaTpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741104058; c=relaxed/relaxed;
	bh=w4SBa9yC7XMiHqkPnEAYuhNs4OVKvUn63r+47d6m9cE=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fI94z20UzgFgjDVhgQlRnaRcSVvF0nZ5ZNkZ3nL4lG192/hFRG5SAAVEVX4FHb2TKAg46it4XJCuxabvp3p4O/1dSJWvgDNg2zsGPO0qlfkp/tQhAGihOMdp0p6De0VeKO5bIkpxTzFXi/pkStev74Exw2oAcVStPEQGihxy7Csm33zddnJ8r21JMttL86QqnddckYgKienUqo7X61C5ZM2LIj6sqiOwEVPFHFnOHAZreB7l+kUOVdnIH9UBqCqaPEBgAjd4iHkzJ++5YRe5IUNxJVovxeWrykYopkTW7Zho+A5s9VmXzuzxdi/QG9I4ZcDnuBMjM+FlA65h4N86VQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6gQK1mSqz3bn0
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 03:00:57 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id DDD9A40F1CE1
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 19:00:24 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gP903GfzG1v1
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 18:59:57 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9E10342728; Tue,  4 Mar 2025 18:59:49 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541834-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id A76D241D90
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:39:35 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 7B2232DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:39:35 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88381894FEF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9422135A2;
	Mon,  3 Mar 2025 13:39:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EA212FAD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009144; cv=none; b=LWuCVxzqWOucoVk6HHdJZK6IDpXs8+KNeNQxmYL0RvR54FDIqL9DMJS29+Y0VaDIAfFR+PgffhitvQZj72fyvVHYesu5CiW1cs2myZaRzr3YG93aVVlG2cKJHL8QlzRn/m6i9xDookEMCoBCAnVixYrTp+SWiVTr9ypea4Z6xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009144; c=relaxed/simple;
	bh=Ci4/aSDOpvJg0F7ZQnSv3OCD5rXfkN+3nGg+X1Ri0Eg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pmMwFPN8tz+Gws/YG0DRgFpmEKPzV6lE4F0qfpb6P9rhWcVqboysyy2KqhUfcSWQ2S5rKVlHF/tkhRnLGUOyl1ZyiurQdEk/vnqgSo3Kji90U5n+mlxCYo9TLiHlttjP0l45Q0Qvo79WsTfRdeC44LhkzgK79AOUjQqFFHCtEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z60D32kYsz1ltbN;
	Mon,  3 Mar 2025 21:34:43 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E45D18001B;
	Mon,  3 Mar 2025 21:38:53 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 21:38:52 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Sudeep Holla <sudeep.holla@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-2-yangyicong@huawei.com> <Z8G__C7n4zwje2MW@bogus>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d93e890c-739e-bd1d-8b28-b83d96ec55c0@huawei.com>
Date: Mon, 3 Mar 2025 21:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
In-Reply-To: <Z8G__C7n4zwje2MW@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gP903GfzG1v1
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708797.96785@gXxLmbHYraFPUNusy8TDTw
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-1.1 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 2025/2/28 21:54, Sudeep Holla wrote:
> On Tue, Feb 18, 2025 at 10:10:15PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently if architectures want to support HOTPLUG_SMT they need to
>> provide a topology_is_primary_thread() telling the framework which
>> thread in the SMT cannot offline. However arm64 doesn't have a
>> restriction on which thread in the SMT cannot offline, a simplest
>> choice is that just make 1st thread as the "primary" thread. So
>> just make this as the default implementation in the framework and
>> let architectures like x86 that have special primary thread to
>> override this function (which they've already done).
>>
>> There's no need to provide a stub function if !CONFIG_SMP or
>> !CONFIG_HOTPLUG_SMT. In such case the testing CPU is already
>> the 1st CPU in the SMT so it's always the primary thread.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>> Pre questioned in v9 [1] whether this works on architectures not using
>> CONFIG_GENERIC_ARCH_TOPOLOGY, See [2] for demonstration hacking on LoongArch
>> VM and this also works. Architectures should use this on their own situation.
>> [1] https://lore.kernel.org/linux-arm-kernel/427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com/
>> [2] https://lore.kernel.org/linux-arm-kernel/a5690fee-3019-f26c-8bad-1d95e388e877@huawei.com/
>>
>>  arch/powerpc/include/asm/topology.h |  1 +
>>  arch/x86/include/asm/topology.h     |  2 +-
>>  include/linux/topology.h            | 22 ++++++++++++++++++++++
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index 16bacfe8c7a2..da15b5efe807 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -152,6 +152,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>>  {
>>  	return cpu == cpu_first_thread_sibling(cpu);
>>  }
>> +#define topology_is_primary_thread topology_is_primary_thread
>>  
>>  static inline bool topology_smt_thread_allowed(unsigned int cpu)
>>  {
>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
>> index ec134b719144..6c79ee7c0957 100644
>> --- a/arch/x86/include/asm/topology.h
>> +++ b/arch/x86/include/asm/topology.h
>> @@ -229,11 +229,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
>>  {
>>  	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
>>  }
>> +#define topology_is_primary_thread topology_is_primary_thread
>>  
>>  #else /* CONFIG_SMP */
>>  static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
>>  static inline int topology_max_smt_threads(void) { return 1; }
>> -static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
>>  static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
>>  #endif /* !CONFIG_SMP */
>>  
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index 52f5850730b3..b3aba443c4eb 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -240,6 +240,28 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>>  }
>>  #endif
>>  
>> +#ifndef topology_is_primary_thread
>> +
>> +#define topology_is_primary_thread topology_is_primary_thread
>> +
>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>> +{
>> +	/*
>> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
> 
> I may be misunderstanding the term "SMT hotplug" above. For me it is
> comparable with logical CPU hotplug, so the above statement may be
> misleading. IIUC, what you mean above is if SMT is disabled, the
> primary thread will always remain enabled/active. Does that make sense
> or am I missing something ?
> 

I just the borrow the term from kconfig HOTPLUG_SMT here, but here the statement
only involves the disable part, so maybe it'll be more accurate to use "SMT
disable" rather than "SMT hotplug" here?

Thanks.



