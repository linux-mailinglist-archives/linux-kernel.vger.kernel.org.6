Return-Path: <linux-kernel+bounces-568667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6DA69923
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143BE420291
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB11211A21;
	Wed, 19 Mar 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJcjSaFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AC2135DE;
	Wed, 19 Mar 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412199; cv=none; b=KGdcJpa3t1jPdjk4QhStqW02whISzf8Iab4nYq1ayohljF373NYn9t3i7G7KO11Fb3b5dNeXozuYg1A+nQ8Km40TQTNyUlLQl21oj6PLOo6yWV3CtoXAFYXreLLvCVDwXnbpwIIYKeRhPAKxlCHOgO4kij/4nkf3igOpA4YfoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412199; c=relaxed/simple;
	bh=r/XHbPpCDJg8LK6akBmJpvgVHJpTE1lx9iFi1+FW9MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG2cG4LhNkODpK6SzTWxhSwz7/snbAe8OONPEuRg2vynHC2+sR/0Zq4g0T/DL+sV9lzjJ6BHHt5lya1ZSa4lpcWf/r1mAgHb99zqtWv0zyQsy+b+vU/prvRjKthQjKIl2hVr8e96J3M1h/RYs6jOie3Fs2wLrOnzYP4HcJiXAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJcjSaFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD5FC4CEE9;
	Wed, 19 Mar 2025 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742412199;
	bh=r/XHbPpCDJg8LK6akBmJpvgVHJpTE1lx9iFi1+FW9MU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DJcjSaFg1WzjsfwN3S18h/TNsv+xT7Mfh/G3Ev/9JixtH5vs/cqkDaL5bIq0bSPp8
	 CVGw9HXbJNMdxd0hCCo41zii/BvmkX9CbQ8tKJ1revkGZxxa/VlFf4P25TYt+xiJob
	 4mI9hyx1WBLYCFfuv276gPhY3WqUZz5twwHydHId59OIiv1SLO6v1b6s207i2iKVvL
	 roAKJa9XUgMVWf3hMsavNsfosOoQDpwdFOfw5kWZV1yWG2gnhyc6Fzvhvya0yEzahb
	 nXziJePKSbeQQAjtDLL/yMzmb1OsTUzF1+VJtBTfa8ygzxaZ7455C7bccnu4BoCp4Z
	 n2Zf1cERFJOlA==
Message-ID: <b75a5c14-f399-45e2-80f3-923e7afe78ab@kernel.org>
Date: Wed, 19 Mar 2025 20:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add Initial device tree for AMD
 Onyx Platform
To: Rajaganesh Rathinasabapathi <rrathina@amd.com>,
 Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>,
 devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
 andrew@codeconstruct.com.au
Cc: robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, jothayot@amd.com,
 Supreeth Venkatesh <supreeth.venkatesh@amd.com>
References: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318174730.1921983-2-Rajaganesh.Rathinasabapathi@amd.com>
 <af75c352-0010-4c58-b8bc-ac0d02337d1a@kernel.org>
 <8c7be61d-d5e4-4f7f-a995-06cf856a84ae@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <8c7be61d-d5e4-4f7f-a995-06cf856a84ae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 17:41, Rajaganesh Rathinasabapathi wrote:
> On 3/18/25 23:44, Krzysztof Kozlowski wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On 18/03/2025 18:47, Rajaganesh Rathinasabapathi wrote:
>>> Add initial device tree and makefile updates for
>>> AMD Onyx platform.
>>>
>>> AMD Onyx platform is an AMD customer reference board with an Aspeed
>>> ast2600 BMC manufactured by AMD.
>>> It describes I2C devices, UARTs, MAC, FMC, etc.
>>> present on AMD Onyx platform.
>>>
>>> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>>> Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
>>> ---
>>> Changes since v1:
>>> * Incorporate review comments
>>
>> Which ones? I do not see my comments addressed and if you do not list
>> them, I treat it as a clear sign you do not care.
>>
> 
> Understood, will list them in next patch submission.
>>> * Update commit message
>>> * Remove vmalloc and earlyprintk
>>>
>>> Changes since v2:
>>> * Address review comments
>>
>> Which ones? This has to be specific
>>
> Got it, will add details and fix in next patch.
> 
>>> * Fix checkpatch warnings
>>> * Remove bootargs
>>>
>>> Changes since v3:
>>> * Fix stdout-path
>>> * Change commit summary
>>> ---
>>>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>>  .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 102 ++++++++++++++++++
>>>  2 files changed, 103 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>>> index 2e5f4833a073..1e6a130377b8 100644
>>> --- a/arch/arm/boot/dts/aspeed/Makefile
>>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>>> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>       aspeed-ast2600-evb.dtb \
>>>       aspeed-bmc-amd-daytonax.dtb \
>>>       aspeed-bmc-amd-ethanolx.dtb \
>>> +     aspeed-bmc-amd-onyx.dtb \
>>>       aspeed-bmc-ampere-mtjade.dtb \
>>>       aspeed-bmc-ampere-mtjefferson.dtb \
>>>       aspeed-bmc-ampere-mtmitchell.dtb \
>>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>> new file mode 100644
>>> index 000000000000..32509a651183
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>> @@ -0,0 +1,102 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +// Copyright (c) 2021 - 2024 AMD Inc.
>>> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "aspeed-g6.dtsi"
>>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>>> +
>>> +/ {
>>> +     model = "AMD Onyx BMC";
>>> +     compatible = "amd,onyx-bmc", "aspeed,ast2600";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart1;
>>> +             serial4 = &uart5;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial4:115200n8";
>>> +     };
>>> +
>>> +     memory@80000000 {
>>> +             device_type = "memory";
>>> +             reg = <0x80000000 0x80000000>;
>>> +     };
>>> +
>>> +};
>> How did you address comment here from v1 which was responded with "ACK"?
>>
>> What else what exactly fixed and what not?
>>
>> Best regards,
>> Krzysztof
> 
> Thanks for the comments.
> I will add 'Acked-by' and in next patch submission. 
> 


What? Where did you get it from? Are you sure you understand submitting
patches document regarding this section?

Read the comment given on v1 instead of some random actions.

Best regards,
Krzysztof

