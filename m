Return-Path: <linux-kernel+bounces-423514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B49DA8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9162B21BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B2B1FCF66;
	Wed, 27 Nov 2024 13:38:50 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF75B1FB;
	Wed, 27 Nov 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714730; cv=none; b=azFnAGt2zHWTxOL+x/wObEAzzQDmloEQ1U7z5IwvYjZix4mlvmS8/BIWiMB4aqlBnNndV+T7k/NnKBAmGL2asBrn0bBvVKg7VcDarxsETnOxskwLlFggRPeuugVjPnBPt2byB6S8Ztm4Y4KuvThWo6cxIFiUTel3aMMArDOkwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714730; c=relaxed/simple;
	bh=MrYihTpw+6Nw3uevt6KSEV8nm7+0I3/GUhbAKcAZz5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sipKPQv7q1YTVDR/OZMdXTw9g3yZaIuWxTkkEPJaMy2LHCHZbtcW2mCo+HnptO0em//TcE7W+QsaH8deXgDKOvhBqYvUWveZeZN0ddqub9f1cvyoG7xOWZH5CA14mOVDfqyQGnGELNjHPD0o95b2vOc/7BIG62C4KbctH24tyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id F2247B4B1EF8;
	Wed, 27 Nov 2024 14:38:41 +0100 (CET)
Message-ID: <dd060a05-9428-4af8-85b1-b6baa756490f@freeshell.de>
Date: Wed, 27 Nov 2024 05:38:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] riscv: dts: starfive: jh7110-pine64-star64: enable
 usb0 host function
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Henry Bell <dmoo_dv@protonmail.com>
Cc: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241126073836.17208-1-e@freeshell.de>
 <20241126073836.17208-2-e@freeshell.de>
 <CAJM55Z8---o6_ZxeyUu_M74LA_zKfeksBmRGFkm2C66hRJbPug@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAJM55Z8---o6_ZxeyUu_M74LA_zKfeksBmRGFkm2C66hRJbPug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/27/24 05:23, Emil Renner Berthing wrote:
> E Shattow wrote:
>> Pine64 Star64 set JH7110 on-chip USB host mode and vbus pin assignment
> Here I'd like it explained that the Star64 board routes 1 of the 4 USB-A ports
> to USB0 on the SoC rather than to the USB 3.0 <-> PCIe chip.
>
> (Confusing for users that 1 of the 4 similar ports only does USB 2.0, but
> that's too late to change and not relevant here)
>
> With that fixed:
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>


There is no (VL805) USB 3.0 <-> PCIe chip on Star64;  All 4 USB-A ports 
route to USB0 of the SoC. What does not exist I did not write about in 
the cover letter. I will expand the description in the commit message. 
Thank you!  -E


>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>   .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
>> index fe4a490ecc61..b764d4d92fd9 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
>> @@ -80,7 +80,23 @@ &spi0 {
>>   	status = "okay";
>>   };
>>
>> +&sysgpio {
>> +	usb0_pins: usb0-0 {
>> +		vbus-pins {
>> +			pinmux = <GPIOMUX(25,  GPOUT_SYS_USB_DRIVE_VBUS,
>> +					       GPOEN_ENABLE,
>> +					       GPI_NONE)>;
>> +			bias-disable;
>> +			input-disable;
>> +			input-schmitt-disable;
>> +			slew-rate = <0>;
>> +		};
>> +	};
>> +};
>> +
>>   &usb0 {
>> -	dr_mode = "peripheral";
>> +	dr_mode = "host";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb0_pins>;
>>   	status = "okay";
>>   };
>> --
>> 2.45.2
>>

