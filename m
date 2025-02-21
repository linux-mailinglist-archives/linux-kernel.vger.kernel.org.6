Return-Path: <linux-kernel+bounces-525687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71575A3F335
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4139A3BDDC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59853208997;
	Fri, 21 Feb 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUFSqDSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F12080D5;
	Fri, 21 Feb 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138148; cv=none; b=j5Kdgewsmta1xdt6rkmRepYFoJARLg62uaXz1dcE3CAU5s5r3xUOziBaE583QXOtxIAYBTNL+gwk91A6z8J6MGcfZeE8zhrFXJ9PZJcF0Jh/wRjnC8Cscn1HGFrJmJ/e731rg3xTURPaC7COH2epW26lPkt/NyH2sZ5dDTEzBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138148; c=relaxed/simple;
	bh=mEM56gOe1RUhzRvrGiRYe0IGW6VYqKO+9eumbJbLHJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9sCPWRzHLv0FTmXI2aGuzKKa8uQZmRxIBKc6zjzmGEwozaDN0vHHUTDuPJS2fWYwr0ZEeUi8GodDOQSA8PvzQv/w8oTwP0mxPMMuvvLs0T1gfUgKDEuehIJEDNzltlrpwpnwPNF/Uwu6mz4+hxbPDcOpU6xS8T02mf8qDR88NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUFSqDSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AA3C4CED6;
	Fri, 21 Feb 2025 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740138148;
	bh=mEM56gOe1RUhzRvrGiRYe0IGW6VYqKO+9eumbJbLHJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eUFSqDSD+1wrIC1whrcC2n2Q277DBn/FacpI8Q3Q3hIZfQuk7ztGxevepO/z6hi11
	 ot7tFICYPgEZB/TlpJ7xP0t5kbqBCx8OQPHurtrDc/vVQWHKLpjuzDdVsNpO0E2K6v
	 SVYREiiOoYJcO+rt5vtvID0ae2CRb5+KvSZ+cdCl857pZjdENUwtOElhzeNy1ShJDo
	 LrB+qrnan1dV92uN/I76wqkjHkza/GOEqHTma1KX1gEk/c5VLXOnsYnRt5vKGVsiVI
	 Goel35HBYaVVdvuphRQtBt+Gk3lmjG8k8qgZG8IHXUwP2OPPKcDxoIdZYDqLH0Xyzp
	 R8k0p1crwcGPA==
Message-ID: <5f88cdbe-f396-49c6-bb48-f50cbbb21caf@kernel.org>
Date: Fri, 21 Feb 2025 12:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
To: Peter Chen <peter.chen@cixtech.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 "Fugang . duan" <fugang.duan@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
 <20250220084020.628704-7-peter.chen@cixtech.com>
 <4add2867-8c09-454a-b3e2-b4baaeccfd44@app.fastmail.com>
 <Z7cga0L6UYmPXoFw@nchen-desktop>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z7cga0L6UYmPXoFw@nchen-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2025 13:30, Peter Chen wrote:
>>
>>> +
>>> +       aliases {
>>> +               serial2 = &uart2;
>>> +       };
>>
>> Please put the aliases in the .dts file, not the chip specific
>> .dtsi file, as each board typically wires these up differently.
>>
>> Note that the 'serial2' alias names are meant to correspond
>> to whatever label you find on the board, not the internal
>> numbering inside of the chip they are wired up to. Usually
>> these start with 'serial0' for the first one that is enabled.
> 
> In fact, we would like to alias the SoC UART controller index here,
> and amba-pl011.c will try to get it, see function pl011_probe_dt_alias.
> It is initial dtsi file, so I only add console one which needs
> to align the bootargs passed by UEFI.


Your "in fact" is not really related to the problem described. If you
put it in the correct place, drivers will work just as fine.

> 
>>
>>> +               CPU0: cpu0@0 {
>>> +                       compatible = "arm,armv8";
>>> +                       enable-method = "psci";
>>
>> This should list the actual identifier of the CPU core, not
>> just "arm,armv8" which is the generic string used in the
>> models for emulators that don't try to model a particular
>> core.
> 
> Will change big core to 'compatible = "arm,cortex-a720";'
> and LITTLE core to 'compatible = "arm,cortex-a520";'
> 
>>
>>> +       memory@80000000 {
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               device_type = "memory";
>>> +               reg = <0x00000000 0x80000000 0x1 0x00000000>;
>>> +       };
>>
>> The memory size is not part of the SoC either, unless the only
>> way to use this SoC is with on-chip eDRAM or similar.
>>
>> Normally this gets filled by the bootloader based on how
>> much RAM gets detected.
> 
> Will move it to dts file.
> 
>>
>>> +               linux,cma {
>>> +                       compatible = "shared-dma-pool";
>>> +                       reusable;
>>> +                       size = <0x0 0x28000000>;
>>> +                       linux,cma-default;
>>> +               };
>>
>> Same here, this is a setting from the firmware, not the
>> SoC.
> 
> Will move it to dts file since our firmware has already released,
> and it needs to support different kernels.
> 
>>
>>> +       sky1_fixed_clocks: fixed-clocks {
>>> +               uartclk: uartclk {
>>> +                       compatible = "fixed-clock";
>>> +                       #clock-cells = <0>;
>>> +                       clock-frequency = <100000000>;
>>> +                       clock-output-names = "uartclk";
>>
>>> +               uart_apb_pclk: uart_apb_pclk {
>>> +                       compatible = "fixed-clock";
>>> +                       #clock-cells = <0>;
>>> +                       clock-frequency = <200000000>;
>>> +                       clock-output-names = "apb_pclk";
>>
>>
>> Clock names don't need "clk" in them, and there should
>> be no underscore -- use '-' instead of '_' when separating
>> strings in DT.
> 
> Will change to:
> uart_apb: clock-uart-apb {

No, instead explain why this is part of SoC - or what are you missing
here - and use preferred naming.

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1



Best regards,
Krzysztof

