Return-Path: <linux-kernel+bounces-304236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F69961C63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1ED1C2306E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132D85628;
	Wed, 28 Aug 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="esct0Fnu"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475AF74BF5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813547; cv=none; b=Yoi+YateglppWWKEj1axSniIaHjSi0Muj2geIX5TBiXioj7fvz7FpTgL2NW+Hg2zxJ7jjfUR6YNn+me2+gU3JRhq6IpO4MbwM9TvyQkseBK/bg523yvZ23LCh+OAz4E1Rv4CH23qbCotViPvIo+jdunCUg7P7lToSDWnwQT0qVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813547; c=relaxed/simple;
	bh=QH/U0T0S+OykIaEKNEgARYGjHpNkggejSuL/0AS5MDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri7ECHc/WubYp31rYVdjrImdU0NPsQy9743BAChOUrUKgf76DCDAcPsxeV766kvAcFgJ1gq3z9n83YeBzgzygrQr/Lhy0/NIJbLIpb3lkQN1dpTwRQlr8f/uXJqqTZ/zOfLG+AU2ax5x6+curAHRrRPN4I7o4PFO18qjklg/tf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=esct0Fnu; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724813543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YJ9ISFrNt8m2AE/nS+MyHzTKAmFX+EVR9ggi1KBh0k=;
	b=esct0FnuWElYLDxV50gw7jCZwxHolyge3khbcF1uP/TUVC82Bqk1W9aos61eTTqlje71nX
	VW0CFT6UhqI91v07dG0TYDPa+DExTAXWzMN3Iy6xgz+WdkAO27meNlt1AOi0I902qUKtWQ
	6sIoQ848DCvybjtYfXiFajNqltm7hGk=
Date: Wed, 28 Aug 2024 10:51:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
 robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
 <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for the reply.
On 2024/8/27 21:37, Andy Shevchenko wrote:
> On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
>> On 2024/8/26 18:40, Andy Shevchenko wrote:
>>> On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
>>>> On 2024/8/23 21:48, Andy Shevchenko wrote:
>>>>> On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
> ...
>
>>>>>> -extern struct bus_type amba_bustype;
>>>>>> +extern const struct bus_type amba_bustype;
>>>>> Can we actually hide this from the outside, i.e. make it static in the C file,
>>>>> and introduce the dev_is_amba() helper instead?
>>>>>
>>>>> P.S. You may look at the PNP bus case (some of the latest patches there)
>>>> I found it problematic in the process of making changes.
>>>>
>>>> There have some usage of amba_bustype outside the AMBA code ,i.e:
>>>> https://elixir.bootlin.com/linux/v6.10.4/source/drivers/iommu/iommu.c#L155
>>>>
>>>> So, If we make the amba_bustype inside the AMBA code, the outside cannot
>>>> access.
>>> Yes, that's the idea.
>>>
>>>> If only internal access is allowed, it will compile and report an error, how
>>>> should I modify it next, and any suggestions?
> (1) vvv
>
>>> Make it patch series:
>>> 1) patch that introduces exported function called dev_is_amba() (1 patch)
Done.
>>> 2) convert user-by-user (N patches)

I've no idea about how to modify, such as in iommu.c:

staticconststructbus_type 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/bus_type>*constiommu_buses 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/iommu_buses>[]={
&platform_bus_type 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/platform_bus_type>,
#ifdef CONFIG_PCI 
<https://elixir.bootlin.com/linux/v6.10.4/K/ident/CONFIG_PCI>
&pci_bus_type 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/pci_bus_type>,
#endif
#ifdef CONFIG_ARM_AMBA 
<https://elixir.bootlin.com/linux/v6.10.4/K/ident/CONFIG_ARM_AMBA>
&amba_bustype 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/amba_bustype>, Or in 
arch/arm/mach-highbank/highbank.c#L150 bus_register_notifier 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/bus_register_notifier>(&amba_bustype 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/amba_bustype>,&highbank_amba_nb 
<https://elixir.bootlin.com/linux/v6.10.4/C/ident/highbank_amba_nb>);

>>> 3) hide the bus type and make it constant.

Done.

Move the 'extern struct' to drivers/amba/bus.c introduce some 
compilation errors.

> (1) ^^^
>
>> Here[1] have many use of  amba_bustype directly outside the drivers/amba
> Yes.
>
>> When I try to hide the amba_bustype by move the extern from
>> include/linux/amba to drivers/amba,
>>
>> we find some errors: "error: use of undeclared identifier amba_bustype".
> Yes, that's why I put (1) to how solve this as we usually do in the Linux
> kernel.
>
I check the pnp_bus_type code, it did'nt use it the non-PNP code.

So I thought I should add a patch for dev_is_amba as your suggested and 
just leave it intact and submit it together.

-- 
Thanks,
   Kunwu.Chan


