Return-Path: <linux-kernel+bounces-528359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B865A416DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6991893B27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445E207E08;
	Mon, 24 Feb 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqCplxyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44227453;
	Mon, 24 Feb 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384390; cv=none; b=l/Sk2TYldfbIFkxybcWCVBw02NdrTWH/+IfeSHwc2nx10uSR9EDMdxR093dTlPCuiFJ3I2OBUhcBhi07JJx+IUTzOiSjLkm1a/MbNNTuSt901aA/pxkhtINSKJTlar4/Hw3QoJIuEVKNSU4JqTcdfxQc31I1F1YZsum2/b49RJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384390; c=relaxed/simple;
	bh=L1yCr5hgdRKfqx0DyVyugUBHvCWmuEVLq6atduGS5AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxruB4yihdTLrkGs3+fYJn6hlgrCJhn+D33puomE9j1V4eTN5rl/UkTllFhfEG06oQY2jhUk2pLgE14+V6bG+sWlnLMe632B0T/UgmIDwsAdaeWEGd6/G4qOInax3MvgY9btGZdCnfeCv3E8VSrTtkNtZPrUpPNqAZl/Q3dG8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqCplxyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64615C4CED6;
	Mon, 24 Feb 2025 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384390;
	bh=L1yCr5hgdRKfqx0DyVyugUBHvCWmuEVLq6atduGS5AY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BqCplxyRMmTeGfFSDgEszc4kqjJWQL4nejg7VVTYmMx1Cb3nVH/MsOmzdKDKSyFJr
	 wuLvQZKuLz3jw6GP9RnLSjcGeBPlMhmdReIV0I5v5HZ54T1OA3kAZcCVmPnrcCTZZf
	 gt5Q/RLPBIQ1vKONePGB1PpichU20R22e7KzMiaHB/PUFwneKwBf8pUHG4CzLU3BBj
	 lRsD5RDKs1jJtrtnBeppfWB40/TgDHiEMkBSlP8jrgxj4cb99WOtckqYUUIZJ8lPNP
	 5i6BLMi7TcOs6MGDYmrs0urZmK7Dke7ZdCmnGHqyBDUAosMGnYnXsoqeJcz7ztK7z+
	 G4vznsW3UosZA==
Message-ID: <0bd5af6c-979b-4403-b1e7-5847979a8780@kernel.org>
Date: Mon, 24 Feb 2025 09:06:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
To: Peter Chen <peter.chen@cixtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 krzk+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 "Fugang . duan" <fugang.duan@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-7-peter.chen@cixtech.com>
 <4add2867-8c09-454a-b3e2-b4baaeccfd44@app.fastmail.com>
 <Z7cga0L6UYmPXoFw@nchen-desktop>
 <5f88cdbe-f396-49c6-bb48-f50cbbb21caf@kernel.org>
 <Z7vY5kHfEGzCCuWW@nchen-desktop>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z7vY5kHfEGzCCuWW@nchen-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2025 03:26, Peter Chen wrote:
> On 25-02-21 12:42:23, Krzysztof Kozlowski wrote:
> 
> Hi Krysztof,
> 
> Thanks for your detail reviewing. I am afraid my email client did not
> receive your email for comment for this patch, I reply at this one.
> 
>>> +#include "sky1.dtsi"
>>> +/ {
>>> +	model = "Radxa Orion O6";
>>> +	compatible = "radxa,orion-o6";
> 
>> Never tested.
> 
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check W=1` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>> Maybe you need to update your dtschema and yamllint. Don't rely on
>> distro packages for dtschema and be sure you are using the latest
>> released dtschema.
> 
> I am sorry for that. I just reviewed device driver patch in recent 3-4 years,
> forget doing additional check for dts patch.
> 
>>
>> On 20/02/2025 13:30, Peter Chen wrote:
>>>>
>>>>> +
>>>>> +       aliases {
>>>>> +               serial2 = &uart2;
>>>>> +       };
>>>>
>>>> Please put the aliases in the .dts file, not the chip specific
>>>> .dtsi file, as each board typically wires these up differently.
>>>>
>>>> Note that the 'serial2' alias names are meant to correspond
>>>> to whatever label you find on the board, not the internal
>>>> numbering inside of the chip they are wired up to. Usually
>>>> these start with 'serial0' for the first one that is enabled.
>>>
>>> In fact, we would like to alias the SoC UART controller index here,
>>> and amba-pl011.c will try to get it, see function pl011_probe_dt_alias.
>>> It is initial dtsi file, so I only add console one which needs
>>> to align the bootargs passed by UEFI.
>>
>>
>> Your "in fact" is not really related to the problem described. If you
>> put it in the correct place, drivers will work just as fine.
> 
> You also mentioned that in your comments. Yes, indeed the board dts file
> could remap physical controller index as different board serial number,
> but it is not what we would like to do (at least for CIX platforms).
> In our both HW and SW documents, we have fixed our uart usage cases,
> for example, UART2 as AP serial ports. UART0-UART1 as uart application,eg
> bluetooth. Customer will do their design to follow above rules, and
> it avoids each customer writing this alias at their board file.

Follow standard rules, you don't get an exception. That's not a property
of the SoC.

> 
> Meanwhile, fixed uart alias as its physical index is better to

This is not being discussed.

> understand SW/HW relationship. Imaging you are debugging one UART
> bluetooth use case, your application passes "/dev/ttyAMA0" as its
> communication port due to board dts alias, but in board schematic,
> it is connects to SoC uart 1, the person to debug may confuse the
> different mapping at first.
> 
> Also, in kernel device driver, it also uses alias id to its uart
> port index, it could better understand device driver hardware
> behaviours, esp you may dump hardware register to debug, you could
> easy to find related registers if the mapping is the same.

Not related to topic at all.

> 
>>
>>>
>>>>
>>>>> +               CPU0: cpu0@0 {
>>>>> +                       compatible = "arm,armv8";
>>>>> +                       enable-method = "psci";
> 
> Will change Label "CPU0" as "cpu0", and name "cpu0" as "cpu"
> 
>>>>
>>>> This should list the actual identifier of the CPU core, not
>>>> just "arm,armv8" which is the generic string used in the
>>>> models for emulators that don't try to model a particular
>>>> core.
>>>
>>> Will change big core to 'compatible = "arm,cortex-a720";'
>>> and LITTLE core to 'compatible = "arm,cortex-a520";'
>>>
>>>>
>>>>> +       memory@80000000 {
>>>>> +               #address-cells = <2>;
>>>>> +               #size-cells = <2>;
>>>>> +               device_type = "memory";
>>>>> +               reg = <0x00000000 0x80000000 0x1 0x00000000>;
>>>>> +       };
>>>>
>>>> The memory size is not part of the SoC either, unless the only
>>>> way to use this SoC is with on-chip eDRAM or similar.
>>>>
>>>> Normally this gets filled by the bootloader based on how
>>>> much RAM gets detected.
>>>
>>> Will move it to dts file.
>>>
>>>>
>>>>> +               linux,cma {
>>>>> +                       compatible = "shared-dma-pool";
>>>>> +                       reusable;
>>>>> +                       size = <0x0 0x28000000>;
>>>>> +                       linux,cma-default;
>>>>> +               };
>>>>
>>>> Same here, this is a setting from the firmware, not the
>>>> SoC.
>>>
>>> Will move it to dts file since our firmware has already released,
>>> and it needs to support different kernels.
>>>
>>>>
>>>>> +       sky1_fixed_clocks: fixed-clocks {
>>>>> +               uartclk: uartclk {
>>>>> +                       compatible = "fixed-clock";
>>>>> +                       #clock-cells = <0>;
>>>>> +                       clock-frequency = <100000000>;
>>>>> +                       clock-output-names = "uartclk";
>>>>
>>>>> +               uart_apb_pclk: uart_apb_pclk {
>>>>> +                       compatible = "fixed-clock";
>>>>> +                       #clock-cells = <0>;
>>>>> +                       clock-frequency = <200000000>;
>>>>> +                       clock-output-names = "apb_pclk";
>>>>
>>>>
>>>> Clock names don't need "clk" in them, and there should
>>>> be no underscore -- use '-' instead of '_' when separating
>>>> strings in DT.
>>>
>>> Will change to:
>>> uart_apb: clock-uart-apb {
>>
>> No, instead explain why this is part of SoC - or what are you missing
>> here - and use preferred naming.
> 
> It is in SoC part, APB clock uses to visit register, and the function
> amba_get_enable_pclk at file drivers/amba/bus.c needs it during uart
> device probes. It uses common Arm uart pl011 IP, the binding doc
> described at: Documentation/devicetree/bindings/serial/pl011.yaml

So you added fake clock? Everything you wrote is not the reason to add
such clock.

DTS describes hardware, not what your drivers expect.

Drop the clock or add proper hardware description.

> 
> Since it is the initial dts support patch, I do not want to add
> more to avoid reviewing efforts, eg, clock gate, reset, etc.
> That's the reason I use fixed clock here to let basic system
> work, and boots to console.
> 
>>
Best regards,
Krzysztof

