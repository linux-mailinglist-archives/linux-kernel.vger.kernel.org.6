Return-Path: <linux-kernel+bounces-304892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B700962654
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939A71F23C77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97180171E5F;
	Wed, 28 Aug 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPhL52AF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04515B12F;
	Wed, 28 Aug 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845799; cv=none; b=K/RIOdatZ3rSatLBe/aT/5y3iI2QMIaQwP8yTswFV1xJlVQunpdJtzTxfAzmz1AEqTg6osHtMmbD8lEoHAt6Q+aCDIeHqAyC+rwZFEfApQtlbhoD2D+hlyjyGMq3j4Y7v5neQlzBK+3NFpsbpD7uPa9nr2JzOJZUQn3v2InVKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845799; c=relaxed/simple;
	bh=Rmg15xcrDSp/rS54nFzfPvGUre02UCMRZ4kZHLoLxMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DUowa8UEaGe25P0C3IGmqDE+DIKL7+frIaiV9ZQJkNx8DmsvttJFff2Jf9k15RxxzvyNsLCvOhQ5cN0MkIK51f1Z/Ot1g75ohf8/mLK0kMumC8ktQwq5bxnVE2RTW+/WeRXarImkBINgoqiP63P1L2Hh7+knhd/dMejg6+D97gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPhL52AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ADAC98EC3;
	Wed, 28 Aug 2024 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724845799;
	bh=Rmg15xcrDSp/rS54nFzfPvGUre02UCMRZ4kZHLoLxMw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rPhL52AFcFVJ8bqp8jCbLeuNE2JLek2l9kSCxYYmGHoXF96QFoPQNPt4pD4+FkKBk
	 oiVFk8R2tSxj4GPoMCtpAtMP44II6JMTAHkIMkp1bR8j1Mv0xVisikw+ghA2rDP3w9
	 bmdwhREEOYuDcJZcGSdrhvwgPiDjclwzv1HlTiFKQRYCSpcfKey9Z5CzJ1hyC335eD
	 NO+5fd2Rhlrh5tKv/s9DfD1F7n2yZ7FSJn+8GYWnf1P1O2ZAlb+yoaLGkvhwfgl9mp
	 H3I9sq/fbZcj0DMHUDz15PLuRc9aHOJIs+dliYres+QDfAVSE4KgvtpeySzZf8iiKd
	 EDVKhpNXKrA/w==
Message-ID: <fe4c8c72-1f7b-4274-a910-4ad803487951@kernel.org>
Date: Wed, 28 Aug 2024 13:49:54 +0200
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
 <5fbc815f-d52e-437d-bdc3-c61f365e9d1c@kernel.org>
 <a36c4d23-e2fe-4bf5-a262-5eb9828e6e7a@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <a36c4d23-e2fe-4bf5-a262-5eb9828e6e7a@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2024 10:25, Varshini.Rajendran@microchip.com wrote:
> On 27/08/24 6:18 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 27/08/2024 11:50, Varshini.Rajendran@microchip.com wrote:
>>> Hi Krzysztof,
>>>
>>> Apologies for the delay in response.
>>>
>>> On 31/07/24 2:00 pm, Krzysztof Kozlowski wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 29/07/2024 09:09, Varshini Rajendran wrote:
>>>>> Add device tree file for SAM9X7 SoC family.
>>>>>
>>>>> Co-developed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +             can1: can@f8004000 {
>>>>> +                     compatible = "bosch,m_can";
>>>>> +                     reg = <0xf8004000 0x100>, <0x300000 0xbc00>;
>>>>> +                     reg-names = "m_can", "message_ram";
>>>>> +                     interrupts = <30 IRQ_TYPE_LEVEL_HIGH 0>,
>>>>> +                                  <69 IRQ_TYPE_LEVEL_HIGH 0>;
>>>>> +                     interrupt-names = "int0", "int1";
>>>>> +                     clocks = <&pmc PMC_TYPE_PERIPHERAL 30>, <&pmc PMC_TYPE_GCK 30>;
>>>>> +                     clock-names = "hclk", "cclk";
>>>>> +                     assigned-clocks = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_GCK 30>;
>>>>> +                     assigned-clock-rates = <480000000>, <40000000>;
>>>>> +                     assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_UTMI>, <&pmc PMC_TYPE_CORE PMC_UTMI>;
>>>>> +                     bosch,mram-cfg = <0x7800 0 0 64 0 0 32 32>;
>>>>> +                     status = "disabled";
>>>>> +             };
>>>>> +
>>>>> +             tcb: timer@f8008000 {
>>>>> +                     compatible = "microchip,sam9x7-tcb","atmel,sama5d2-tcb", "simple-mfd", "syscon";
>>>>
>>>> Why this is simple-mfd without children?
>>>
>>> The tcb node will have each TC (Timer Counter) Block as a child when it
>>> is configured to be used as either one of the following modes Timer or
>>> Counter / Capture / PWM.
>>
>> And where are these children? What does it mean "will have", in context
>> when? DTS is static, if you do not have here children then this is not a
>> simple-mfd.
>>
> I understand your concern. But the thing is that, each tc block is 
> configured as a child and it can be configured in 3 different modes with 
> different compatibles. In the current dts (i.e., sam9x75_curiosity 
> board) we don't have a use case for the tcb, hence there are no child 
> nodes defined. But there are instances where it can be defined in the 
> dts, say for a custom board using sam9x7 SoC. In that case the 

Where are these instances? Can you point me to DTS?

> simple-mfd usage is justified, if I am not wrong. If this justification 
> doesn't suffice, then declaring child nodes with one mode as default 

If I understand correctly: some out of tree, non-upstream project wants
this. Sorry, but out of tree does not matter. So it is not a correct
justification.

With such argument you could claim that everything needs simple-mfd
because some broken out-of-tree code adds there children.

> which can be overridden in the dts and kept disabled in the dtsi should 
> be the other plausible way. Please let me know your suggestions.

No clue, please post complete binding and complete DTS so we can review
these.

Best regards,
Krzysztof


