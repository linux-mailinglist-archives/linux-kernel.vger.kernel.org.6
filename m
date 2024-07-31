Return-Path: <linux-kernel+bounces-268815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502019429C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DED1C2164C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E141A8C05;
	Wed, 31 Jul 2024 08:57:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6801A8C1A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416235; cv=none; b=IIF1lbLabVkSOW8JzFSkKP4HfAEfpfN/juJGAVmZ7rPmk+jY/3K4keR7+JuwWxz7Wchab2mjHMzMIVrYOXqe39JBaa5PaEZSohRTV1+uKjQdE8w4fljBsiJbm+yLt/vuPw4EP+ooFCH3egK+AgTa55HkT8JR9kFlzr0S8tJwXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416235; c=relaxed/simple;
	bh=7JzhHP12AlJcj/YTBjfIbaHpasFJxoFHlwP5A04TvK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tqSPkT8PMMEl7Aw8SZMjRKA1d4eaF63H7b/kbxv3BWaltnhkV+ZodIeyQSIulvqCIHqwGPsbfZ6bi60YNcnNmOJhC/3m2VMNyUgkT5FxnbWhYg8Xt5YuG9kgal+z9hpcdyLmHltnYU7qkAQ09MlVbVmGatpfiIvJZYMkFBQby+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYmBw0klZzgYlm;
	Wed, 31 Jul 2024 16:55:20 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ADE01400DD;
	Wed, 31 Jul 2024 16:57:10 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 16:57:09 +0800
Message-ID: <f7373ce1-7e7e-6697-cb7f-2f37dc53e60e@huawei.com>
Date: Wed, 31 Jul 2024 16:57:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND 0/2] ARM: Switch over to GENERIC_CPU_DEVICES
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>, <ardb@kernel.org>,
	<gregkh@linuxfoundation.org>, <deller@gmx.de>, <javierm@redhat.com>,
	<bhe@redhat.com>, <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240702075742.945768-1-ruanjinjie@huawei.com>
 <1309c436-4e7f-89a3-3b33-abddaaac410c@huawei.com>
 <Zqn1hVHUdsDjhtT8@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zqn1hVHUdsDjhtT8@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/31 16:27, Russell King (Oracle) wrote:
> On Wed, Jul 31, 2024 at 09:52:07AM +0800, Jinjie Ruan wrote:
>> On 2024/7/2 15:57, Jinjie Ruan wrote:
>>> Currently, almost all architectures have switched to GENERIC_CPU_DEVICES,
>>> except for arm32. Also switch over to GENERIC_CPU_DEVICES, which can also
>>> make the code more concise.
>>>
>>> Jinjie Ruan (2):
>>>   ARM: Switch over to GENERIC_CPU_DEVICES using arch_register_cpu()
>>>   ARM: Convert to arch_cpu_is_hotpluggable()
>>>
>>>  arch/arm/Kconfig           |  1 +
>>>  arch/arm/include/asm/cpu.h |  1 -
>>>  arch/arm/kernel/setup.c    | 14 ++------------
>>>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> I think it's fine, but it needs to end up in the patch system to be
> applied. Thanks.

Hi, Russell

Thank you very much! I'll push it in rmk's patch tracker sooner.

> 

