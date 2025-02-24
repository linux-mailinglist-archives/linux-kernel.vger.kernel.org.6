Return-Path: <linux-kernel+bounces-528985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE761A41E96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEEF1675C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B82192F5;
	Mon, 24 Feb 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHpYXV6+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000B2571A0;
	Mon, 24 Feb 2025 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398871; cv=none; b=M70stGEgITbQWttL1ANF7NVTdV/LeTe8xdBh4Cei229C3I5DyoO5E+I3BEQYP3MrCsHzmwQjx4Z5o/pZPjR2d74f+R6UxgvNpj0CMYvf3GuDRSVGVpPJGgji7ElofS1ZAIo+p6IDajJlchI7e25CiHqGkQDj1Jtj8AzyDKrTGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398871; c=relaxed/simple;
	bh=ROIFuQUAjanRIwif6W4QK8e5P4N/acwvRXpzO4jIs1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJjywCR+VOMaJi2nXSy8jpP2pIZCNtrH+Y/YBewrUTLkMLByCzKWqhGorRGVhcJmHCSNEbu4cbei/V7usWCR23ozeJl6vHKqJHJycfxo6ltrSHLk/niqBneg+FfGAx65PYYGSgWr9zREVJJqRU5akVzvL14z4jp6ft3+ZBcMAwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHpYXV6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3E2C4CEE6;
	Mon, 24 Feb 2025 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398870;
	bh=ROIFuQUAjanRIwif6W4QK8e5P4N/acwvRXpzO4jIs1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bHpYXV6+erqoGUMEMjSB1qxTN49g7TgYwhhrU7XyQbt+kQvaLHebVIzLeD3xjpxax
	 NpiRqD6kbEr33vG1HvuJtisO4PwoPoZNfUN8EDJYVeX28wemBZkJVmfknin521RoT+
	 32pJUieWfr57g93yx76n5/bAUwLmPzzv9J0nEgmoCe8j3qDZolDnln9h13hvoCZjZO
	 Oj1JZwJULLogD8jcC52pzTuC4FP6jpLt4A8JSvL6yOXIzcUOa7rbMSFYwjxlxaiA4K
	 tM39PlmMkpiYGrJIlCkdEgADeQnxDkHre0JdM0O0oaDiQ6VbbYbmClZN86fTT6DE7d
	 uClr2+OAlQolQ==
Message-ID: <24003082-d1ca-43c6-ae96-3705e0f964f0@kernel.org>
Date: Mon, 24 Feb 2025 13:07:45 +0100
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
 <0bd5af6c-979b-4403-b1e7-5847979a8780@kernel.org>
 <Z7xMeub9i74a_19g@nchen-desktop>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <Z7xMeub9i74a_19g@nchen-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2025 11:39, Peter Chen wrote:
>>>>>>
>>>>>>> +       sky1_fixed_clocks: fixed-clocks {
>>>>>>> +               uartclk: uartclk {
>>>>>>> +                       compatible = "fixed-clock";
>>>>>>> +                       #clock-cells = <0>;
>>>>>>> +                       clock-frequency = <100000000>;
>>>>>>> +                       clock-output-names = "uartclk";
>>>>>>
>>>>>>> +               uart_apb_pclk: uart_apb_pclk {
>>>>>>> +                       compatible = "fixed-clock";
>>>>>>> +                       #clock-cells = <0>;
>>>>>>> +                       clock-frequency = <200000000>;
>>>>>>> +                       clock-output-names = "apb_pclk";
>>>>>>
>>>>>>
>>>>>> Clock names don't need "clk" in them, and there should
>>>>>> be no underscore -- use '-' instead of '_' when separating
>>>>>> strings in DT.
>>>>>
>>>>> Will change to:
>>>>> uart_apb: clock-uart-apb {
>>>>
>>>> No, instead explain why this is part of SoC - or what are you missing
>>>> here - and use preferred naming.
>>>
>>> It is in SoC part, APB clock uses to visit register, and the function
>>> amba_get_enable_pclk at file drivers/amba/bus.c needs it during uart
>>> device probes. It uses common Arm uart pl011 IP, the binding doc
>>> described at: Documentation/devicetree/bindings/serial/pl011.yaml
>>
>> So you added fake clock? Everything you wrote is not the reason to add
>> such clock.
> 
> Not a fake clock, it is the real clocks, but depends on firmware open
> their parents and configure their rate. It could let others do their

In one place you speak about UART, which is the consumer and not
relevant. Here you mention it is real clock. That's all confusing, so to
clarify:

We talk about clock which is generated/output by something. Something
which controls way it is generated is clock controller. Either you have
here crystal or have here clock controller. If first, fixed clock is for
that. If second, you need proper clock controller binding. You can add
stubs for missing pieces, but this requires explanation and TODO/FIXME
comment.




> upstream work based on workable console.
> 
> Which option you would like to accept?

You did not describe the hardware, so I have no clue what is there.

Best regards,
Krzysztof

