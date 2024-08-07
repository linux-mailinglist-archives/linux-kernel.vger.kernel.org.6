Return-Path: <linux-kernel+bounces-278198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5094AD54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D951C218C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309512AAC6;
	Wed,  7 Aug 2024 15:47:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0884D0F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045674; cv=none; b=bZsedtc+YXFR2LsWewpMmZbJZAi6Q5yu+V6/0GYBdk3YoYBWLWtcXDPG4BA74H/TlVvMHr47R0BRQeuFMRFhiLid6DUVOlNFN+9uYuoljuU9Zzajp0+7yray1w1K3VaaOribfFrbOMOcM2bzzYtUzwndJxB8E0Penay51ZB6ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045674; c=relaxed/simple;
	bh=meeucUYBGF8itIkHjnDP0LDYCuH5M/KgzmcxkjaG12o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sbd45lx78dwJb/1SCklzwA6XdFZEu52yb+xxEgM6xEKFFmxh9q+iO/ZnjXf6CvfM7e9VznWqSdZSnwyVo0Kc2EqSQG4aC52BmstybVRVRyaHVv1r3R4THTkZQSqNtOWvcQQMXErTJQI3KywlwEC4RcoJlXwV9PP+h72EypTMsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WfF0D5J6RzpT3r;
	Wed,  7 Aug 2024 23:46:36 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 296D8180AE3;
	Wed,  7 Aug 2024 23:47:47 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 23:47:46 +0800
Message-ID: <53d8c725-7854-4cbc-b2b4-0dcded328617@huawei.com>
Date: Wed, 7 Aug 2024 23:47:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Harith George <mail2hgg@gmail.com>, Linus
 Walleij <linus.walleij@linaro.org>, Russell King
	<rmk+kernel@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	<harith.g@alifsemi.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
 <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
 <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
 <a65d0b09-466d-415f-9bd0-cbc5ff3539e7@gmail.com>
 <2083af75-e2d8-42b9-8fa6-f5b7496671bd@app.fastmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <2083af75-e2d8-42b9-8fa6-f5b7496671bd@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

OK, i will test these version soon.

On 2024/8/7 23:41, Arnd Bergmann wrote:
> On Wed, Aug 7, 2024, at 17:36, Harith George wrote:
>> On 07-08-2024 20:52, liuyuntao (F) wrote:
>>> Thanks, I reproduce the link error with toolchain
>>> gcc version 9.3.0
>>> GNU ld (GNU Binutils) 2.33.1
>>>
>>> with same gcc version, just upgrading ld version to 2.36.1, it does not
>>> segfault and build completes. there should be bugs in low version of ld,
>>> and the ".reloc  .text, R_ARM_NONE, ." triggers that.
>>>
>> Thanks for confirming.
>>
>> I guess we need to add something like
>> #if !CONFIG_CC_IS_GCC || CONFIG_LD_VERSION >= 23600
>> around the entry-armv.S changes and maybe select
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION in arch/arm/Kconfig only if the same
>> conditions are met ??
> 
> I think it makes most sense to have a minimum LD
> version as a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION.
> Are you sure that 2.36 is the first one that works, and it's
> not just 2.33 specifically that is broken?
> 
> If so, we could use
> 
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -117,7 +117,7 @@ config ARM
>          select HAVE_KERNEL_XZ
>          select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M && !CPU_32v3
>          select HAVE_KRETPROBES if HAVE_KPROBES
> -       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
>          select HAVE_MOD_ARCH_SPECIFIC
>          select HAVE_NMI
>          select HAVE_OPTPROBES if !THUMB2_KERNEL
> 
> 
> binutils only takes a few seconds to build from source, so
> you could just try all version from 2.25 (the oldest supported)
> to 2.36) to see which ones work.
> 
>         Arnd

