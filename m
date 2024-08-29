Return-Path: <linux-kernel+bounces-306255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA33D963BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BD2B24E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6890616B754;
	Thu, 29 Aug 2024 06:50:10 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93326166F17
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914210; cv=none; b=NMSWFxlCEFMsMxIA2FQX+gA9NEqAR8U7On7gCKoJ9uG9HlWyWgc0RULlRmShP5YJNkl6qe7GpjKdvCFIm2m0DKrf3LEZUaXMpCkkTHLT15NEh6V/85j0MJjVXDEkh7e3fFvzElwUisXVKwa9lL321PaPUayOYD80IMYcJMUAM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914210; c=relaxed/simple;
	bh=N5JZjMtK5TXaOOn7DyVDi2kmIviChZXYwLFexwfqEhU=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qrO2ELPH0yOwik2+yqNHJL3dz8hH/OhNe79AkIPlSIkv/65bKdaMMBbsk+fcf8fzBD0aSPgoDPW2GTg4GCbrEWvPoy9c9cpa79aXZ1RiLL+ZAUvwAOf2vLfX4nU7cI+5jNaa9DZsDn02x6x2SVKazbhGaxeiAQRxMw1LDMfRFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvX222nB8zyQkp;
	Thu, 29 Aug 2024 14:49:14 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id E8EC01401F2;
	Thu, 29 Aug 2024 14:50:03 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 29 Aug 2024 14:50:02 +0800
CC: <yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<mingo@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<mpe@ellerman.id.au>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<sudeep.holla@arm.com>, <will@kernel.org>, <catalin.marinas@arm.com>,
	<linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH v5 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
To: Pierre Gondois <pierre.gondois@arm.com>
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-5-yangyicong@huawei.com>
 <4024c9be-aae9-4248-ab73-813c3c5d790b@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b53badc6-d020-9683-4365-fb49a269caa4@huawei.com>
Date: Thu, 29 Aug 2024 14:50:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4024c9be-aae9-4248-ab73-813c3c5d790b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/8/27 23:40, Pierre Gondois wrote:
> Hello Yicong,
> 
> Is it necessary to have an explicit dependency over SMP for arm64 ? Cf.
>   commit 4b3dc9679cf7 ("arm64: force CONFIG_SMP=y and remove redundant #ifdefs")

Thanks for the information. Then it's redundant to depend on CONFIG_SMP. Will drop it.

> 
> Regards,
> Pierre
> 
> On 8/6/24 10:53, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Enable HOTPLUG_SMT for SMT control.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   arch/arm64/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a2f8ff354ca6..bd3bc2f5e0ec 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -238,6 +238,7 @@ config ARM64
>>       select HAVE_KRETPROBES
>>       select HAVE_GENERIC_VDSO
>>       select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>> +    select HOTPLUG_SMT if (SMP && HOTPLUG_CPU)
>>       select IRQ_DOMAIN
>>       select IRQ_FORCED_THREADING
>>       select KASAN_VMALLOC if KASAN
> 
> .

