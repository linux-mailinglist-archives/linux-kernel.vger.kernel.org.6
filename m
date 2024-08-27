Return-Path: <linux-kernel+bounces-303347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D88960B09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4490928447C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16E19F49A;
	Tue, 27 Aug 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw9Q527O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D11BD4F2;
	Tue, 27 Aug 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762912; cv=none; b=exEh+g6w38dkub5O/xGVDOtiqnDFM06IM+TNm4KH+yX3VBuktexJ+r1Smxb+eAdCPMe5KvmaNG9HatI79w8SmdctdsKYfbG5oaBq8CxRXR7lCs1a2Rl/gVWwK7ejxeJeckdrey6hP2Y0IW4USJJx82EYH+Hqw5gVArCra/D5uLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762912; c=relaxed/simple;
	bh=g/hqEC7ZyuL4IqUrKsBwU6+lHHVgteFNIUEWYPF6vpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RL/nDqPZ80xr22SdgYkVwEghMxtjm8LMvGFMgmIAfQ7zgYA4izgDswNDMmyqSkJ0IvMfIgRwtKrcthvLgIk2DF4yv0wE4mCi0vA3yWmZLwXw1ne343mjEgf52PlCo/Wv0RJrZV3ckHtkNFbXbp7MWM1CsObHU9Kh1jruIb/j9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw9Q527O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F669C61049;
	Tue, 27 Aug 2024 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724762911;
	bh=g/hqEC7ZyuL4IqUrKsBwU6+lHHVgteFNIUEWYPF6vpA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cw9Q527O6dWO02WhjWD66sK6ngmX0c/HxLElI+B2h+kCW1VYm3lgFt/xoJmpb4G37
	 6k/HRWnhJ8OG6JommIzNQUtqb7W8oUt+OVS2r/1q1gs2fHR609f7hywbUeZiXPCvAh
	 FQ9yhe3Uybh+hvuVT4YXBxt65dTc3dBObnj9RcQ82VCjYPXT8DaHVRfB0TMEElTrsW
	 kFCGxztp4dZjsNJB9s60rbETHNooyyHoBRhxhThyw8fEdUEtZHUEfu8nz1NnWBHyW6
	 9IuoBNX2mXBi5oHSZNyFCNd67aVTpe9ALAGzTfnb4sMmNzEI9xmaWdMCjPSYUHzM8B
	 Hs12sQUB5Ou9A==
Message-ID: <5fbc815f-d52e-437d-bdc3-c61f365e9d1c@kernel.org>
Date: Tue, 27 Aug 2024 14:48:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
To: Varshini.Rajendran@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070934.1991467-1-varshini.rajendran@microchip.com>
 <7031d811-2bb2-4325-996c-a6de766925db@kernel.org>
 <bf77fe95-0982-4605-a493-25c889e81639@microchip.com>
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
In-Reply-To: <bf77fe95-0982-4605-a493-25c889e81639@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2024 11:50, Varshini.Rajendran@microchip.com wrote:
> Hi Krzysztof,
> 
> Apologies for the delay in response.
> 
> On 31/07/24 2:00 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 29/07/2024 09:09, Varshini Rajendran wrote:
>>> Add device tree file for SAM9X7 SoC family.
>>>
>>> Co-developed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>
>> ...
>>
>>> +
>>> +             can1: can@f8004000 {
>>> +                     compatible = "bosch,m_can";
>>> +                     reg = <0xf8004000 0x100>, <0x300000 0xbc00>;
>>> +                     reg-names = "m_can", "message_ram";
>>> +                     interrupts = <30 IRQ_TYPE_LEVEL_HIGH 0>,
>>> +                                  <69 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +                     interrupt-names = "int0", "int1";
>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 30>, <&pmc PMC_TYPE_GCK 30>;
>>> +                     clock-names = "hclk", "cclk";
>>> +                     assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_GCK 30>;
>>> +                     assigned-clock-rates = <480000000>, <40000000>;
>>> +                     assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>>> +                     bosch,mram-cfg = <0x7800 0 0 64 0 0 32 32>;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             tcb: timer@f8008000 {
>>> +                     compatible = "microchip,sam9x7-tcb","atmel,sama5d2-tcb", "simple-mfd", "syscon";
>>
>> Why this is simple-mfd without children?
> 
> The tcb node will have each TC (Timer Counter) Block as a child when it 
> is configured to be used as either one of the following modes Timer or 
> Counter / Capture / PWM.

And where are these children? What does it mean "will have", in context
when? DTS is static, if you do not have here children then this is not a
simple-mfd.

Best regards,
Krzysztof


