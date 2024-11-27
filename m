Return-Path: <linux-kernel+bounces-423424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7D9DA735
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3920D2812C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF371F9AA7;
	Wed, 27 Nov 2024 11:52:27 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839131F9ECF;
	Wed, 27 Nov 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708347; cv=none; b=ljgIzKdbsrjblYLbiEbVMRehGvvfunTtIMdepxVDp/ZzlsmJM/+MokIS7l+e+rMqpQrgYCPtdI2WdWdKnxdkcrAMgN/X8G5rAk9eWEOo7dZN+GVy6vj28xfMeeu56jYkLB58lYkUikTzK/NIhg336qjSLjtt1Huttp+1P45ZYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708347; c=relaxed/simple;
	bh=IA6S/2VA05D0vj0jFtDpwXuX+ITrR/ip+5whJsfmfpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZ/Nw03rP6/TOm9bA17iamEo2yNpZW+gNwEozzQSQZY3TBHTqT/PVWrc7lEk9BqgyMXApO4eCKd+QPYEGKMVvCZF/0PsY32ORzRMqLd3VgqZwXNCdWI98NQJROpNbhbVq9W2esh4RkV/E4hRH0MVTehbAn1Tpc6sqlOQjezF4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id A923CB4B1BB1;
	Wed, 27 Nov 2024 12:52:12 +0100 (CET)
Message-ID: <eb06c8e0-ebda-47b9-94f6-6e6eca21097d@freeshell.de>
Date: Wed, 27 Nov 2024 03:52:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable
 usb0 host function
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, minda.chen@starfivetech.com,
 hal.feng@starfivetech.com
References: <20241126075740.17419-1-e@freeshell.de>
 <CAJM55Z9wWCaS+FxZ=Gg_RfXXafNEJZC1zHZoPWQ2Y9QYDf9OyA@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAJM55Z9wWCaS+FxZ=Gg_RfXXafNEJZC1zHZoPWQ2Y9QYDf9OyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Emil, thanks for taking time to review!

Added CC: Minda Chen, Hal Feng

Please Minda and Hal can you follow-up on Emil's comments as well?

On 11/27/24 03:00, Emil Renner Berthing wrote:
> E Shattow wrote:
>> Enable host mode JH7110 on-chip USB for Milk-V Mars by setting host mode
>> and connect vbus pinctrl.
>>
>> This functionality depends on setting the USB over-current register to
>> disable at bootloader phase, for example U-Boot:
>> https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/
> Hi E,
>
> Ideally the JH7110 pinctrl driver would be updated, so Linux can do this itself
> and doesn't need to rely on u-boot doing it. I already asked for this here:
>
> https://lore.kernel.org/all/CAJM55Z-+Cxdebcn4MLXfQdOVhx4c2SQ+zMH8cjn-Yq35xO8g0A@mail.gmail.com/

Yes, I agree, and Linux is not the only consumer of devicetree. I would 
like USB function to work for users of Linux and U-Boot on these boards 
by copying what the vendor Board Support Package does what is shipped 
with the products. If it is more in-depth than this I will defer to Hal 
or Minda.


For some wider context, upstream U-Boot is about to adopt the 
dt-rebasing via Hal's OF_UPSTREAM for JH7110 boards series and then also 
there is a patch set from Minda Chen to add the on-chip JH7110 USB 
support to U-Boot, and so then and there it will depend on these dts 
changes. If you have Milk-V Mars then already there are three of four 
USB-A receptacle ports which are functional on PCIe-connected VL805 USB 
chipset.

>
>> If the over-current register is not prepared for us then the result is no
>> change in functional outcome with this patch applied; there is an error
>> visible to the user and this additional usb configuration fails (same as
>> it is now). On Milk-V Mars with four USB-A ports this applies to one of the
>> ports and the remaining three VL805-connected ports via PCIe are not changed.
> Thanks for the patches. I don't quite understand when you write "no change in
> functional outcome with this patch applied". The USB-C port is already
> configured as a peripheral, and I just tried setting up an ethernet gadget on
> my VF2 running 6.12 and that works quite well. Does it not work on the Milk-V
> Mars board? If it does then these patches would break that functionality.
>
> Here is the script I used for that:
> https://paste.c-net.org/BravoLonely
>
> At the very least you'll need to explain in the commit message itself why
> changing the USB-C port from peripheral mode to host mode is OK. But ideally
> maybe you could make it work in OTG mode, so userspace can choose how they want
> to use the port. The same goes for the PINE64 board too.
>
> /Emil

USB-C port on Mars is not wired for data here, that is only true for 
VisionFive2. If the user wants to use their USB-A receptacle as OTG port 
I will not object to a future improvement, but here we want the basic 
expectations of users covered that they should have four working USB-A 
receptacle ports in U-Boot (and possibly in Linux, depending on the 
overcurrent register wherever it is set). This is what I am meaning, 
there may be somebody using a male-male USB-A USB-A cable for OTG but 
more likely is that people just want to plug in USB peripherals to host 
ports and use their mouse / keyboard / flash memory, I think.


There is no USB-C port on Star64.

>
>> Changes since v4:
>>   - Rebase on latest master
>>
>> Changes since v3:
>>   - Rebase on linux-next/master
>>   - use tabs for code indent
>>
>> Changes since v2:
>>   - Rebase on 6.12
>>
>> E Shattow (1):
>>    riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
>>
>>   .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> --
>> 2.45.2
>>
Thanks again Emil.  -E


