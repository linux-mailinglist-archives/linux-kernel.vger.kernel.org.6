Return-Path: <linux-kernel+bounces-316946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94A96D764
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD171F249EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213EB199E98;
	Thu,  5 Sep 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk0HSakt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B109198A32;
	Thu,  5 Sep 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536515; cv=none; b=CaX8b4K9bGi6kT9VrlseBP3acK46Q8N2ES1XY3meuD9YBrm7sdxs7Qy7P3h+nAxVcqCPcncdjUSMApaL6vfLLUSozEd83xZ2IHb+24gTdAxScnx3LlsU1/t1ckuUolEgJGIQYY42LbVaX7SL/6aNScbwgIL9gD05ZLFZwyZPJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536515; c=relaxed/simple;
	bh=whC8oFjDeU0z3jTHSXF6J/6/ruW8p/D0AKXeqjkcKAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeUagLjYWpgguJ6IreGTx7AzNfazWCCJvpINqXdp7iTWVdRyoBRara5gT25AN8pulnkCxetWTZSjIJ9SDgrNL+YCdYTK6OBY8qBtH6DdSZUmykTKSia5loYwZB8HDSXkHaTtS6l84iX2geMzSiPLsKU6ZX3NyY/CjMm54CpyVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk0HSakt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4D7C4CEC3;
	Thu,  5 Sep 2024 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725536514;
	bh=whC8oFjDeU0z3jTHSXF6J/6/ruW8p/D0AKXeqjkcKAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fk0HSakttNfBUkIqb3Tq0b2kC+FHx5uZpThCtscKAgz0A0NNfMqfUb9xMdPfs7ciX
	 5NkzrAsvVC2gnqoIVcdGq4cz0zMBAdROko1tY8jCQJP/KHsgBa5MvE+uYxhI8GxSM1
	 ySk54FbNgkbpSRCYxL0xAx9//Uh3bcQn6uWWebpQtlycAN0Q3v8aAa+xIMl2OU8qec
	 0k5FsOvyBc6VKBogiK9+quh4kta1cwzbhwRdd3r1k2FbzlSviTYnYI6W4XCZuj/UGi
	 C6wgEX9JRYJafDTsdtzOnziblfb/AhUFkkJcp61NA4jvRvd52yAHak5vzvYlh9NDTV
	 1GfOR1dfPciPg==
Message-ID: <4f2ec575-4c2c-49d5-b1c0-85d5b6ce9f2e@kernel.org>
Date: Thu, 5 Sep 2024 13:41:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-2-msp@baylibre.com>
 <f0f60af7-8561-433a-a027-811015fc5e16@kernel.org>
 <ti4ffymrixcpptlrn3o5bytoyc4w5oovdrzgu442ychai2fjet@wtdhrmwrozee>
 <44feed5a-95a7-4baa-b17e-514c0f50dae6@kernel.org>
 <sf2pklbnlkpgnkemv3wevldpj55kk2xqh4fabbmkcbh2tvnbzr@gg3gxgztq6pt>
 <d2eb4faf-c723-453b-a9d8-68693c96fb42@kernel.org>
 <fa11631e-48f9-4e95-95c4-20b77cb0a1be@kernel.org>
 <h4kapqs5vpparh5b3tter54fbnxubq6gpnb4yrqjdio66tj37w@l3xzum2bq5sz>
 <58f5f778-9f0a-4a05-8c33-949f3b3d1f49@kernel.org>
 <sisw3whyzr7itjtuznvt5t6cbmfxzop5c4nfrxwpxjil6rxqzc@cfnb5panavxe>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <sisw3whyzr7itjtuznvt5t6cbmfxzop5c4nfrxwpxjil6rxqzc@cfnb5panavxe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 13:17, Markus Schneider-Pargmann wrote:
> On Thu, Sep 05, 2024 at 12:41:05PM GMT, Krzysztof Kozlowski wrote:
>> On 05/09/2024 11:49, Markus Schneider-Pargmann wrote:
>>> On Thu, Sep 05, 2024 at 11:25:48AM GMT, Krzysztof Kozlowski wrote:
>>>> On 05/09/2024 11:15, Krzysztof Kozlowski wrote:
>>>>> On 05/09/2024 11:08, Markus Schneider-Pargmann wrote:
>>>>>> On Tue, Aug 06, 2024 at 10:03:00AM GMT, Krzysztof Kozlowski wrote:
>>>>>>> On 06/08/2024 09:11, Markus Schneider-Pargmann wrote:
>>>>>>>> Hi Krzysztof,
>>>>>>>>
>>>>>>>> On Tue, Aug 06, 2024 at 08:18:01AM GMT, Krzysztof Kozlowski wrote:
>>>>>>>>> On 29/07/2024 10:00, Markus Schneider-Pargmann wrote:
>>>>>>>>>> Partial-IO is a very low power mode in which nearly everything is
>>>>>>>>>> powered off. Only pins of a few hardware units are kept sensitive and
>>>>>>>>>> are capable to wakeup the SoC. The device nodes are marked as
>>>>>>>>>> 'wakeup-source' but so are a lot of other device nodes as well that are
>>>>>>>>>> not able to do a wakeup from Partial-IO. This creates the need to
>>>>>>>>>> describe the device nodes that are capable of wakeup from Partial-IO.
>>>>>>>>>>
>>>>>>>>>> This patch adds a property with a list of these nodes defining which
>>>>>>>>>> devices can be used as wakeup sources in Partial-IO.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> <form letter>
>>>>>>>>> This is a friendly reminder during the review process.
>>>>>>>>>
>>>>>>>>> It seems my or other reviewer's previous comments were not fully
>>>>>>>>> addressed. Maybe the feedback got lost between the quotes, maybe you
>>>>>>>>> just forgot to apply it. Please go back to the previous discussion and
>>>>>>>>> either implement all requested changes or keep discussing them.
>>>>>>>>>
>>>>>>>>> Thank you.
>>>>>>>>> </form letter>
>>>>>>>>
>>>>>>>> I tried to address your comment from last version by explaining more
>>>>>>>> thoroughly what the binding is for as it seemed that my previous
>>>>>>>> explanation wasn't really good.
>>>>>>>>
>>>>>>>> You are suggesting to use 'wakeup-source' exclusively. Unfortunately
>>>>>>>> wakeup-source is a boolean property which covers two states. I have at
>>>>>>>> least three states I need to describe:
>>>>>>>>
>>>>>>>>  - wakeup-source for suspend to memory and other low power modes
>>>>>>>>  - wakeup-source for Partial-IO
>>>>>>>>  - no wakeup-source
>>>>>>>
>>>>>>> Maybe we need generic property or maybe custom TI would be fine, but in
>>>>>>> any case - whether device is wakeup and what sort of wakeup it is, is a
>>>>>>> property of the device.
>>>>>>
>>>>>> To continue on this, I currently only know of this Partial-IO mode that
>>>>>> would require a special flag like this. So I think a custom TI property
>>>>>> would work. For example a bool property like
>>>>>>
>>>>>>   ti,partial-io-wakeup-source;
>>>>>>
>>>>>> in the device nodes for which it is relevant? This would be in addition
>>>>>> to the 'wakeup-source' property.
>>>>>
>>>>> Rather oneOf. I don't think having two properties in a node brings any
>>>>> more information.
>>>>>
>>>>> I would suggest finding one more user of this and making the
>>>>> wakeup-source an enum - either string or integer with defines in a header.
>>>>
>>>> I am going through this thread again to write something in DT BoF but
>>>> this is confusing:
>>>>
>>>> "Partial-IO is a very low power mode"
>>>> "not able to do a wakeup from Partial-IO."
>>>> "wakeup-source for Partial-IO"
>>>>
>>>> Are you waking up from Partial-IO or are you waking up into Partial-IO?
>>>>
>>>> And why the devices which are configured as wakeup-source cannot wake up
>>>> from or for Partial-IO?
>>>
>>> Sorry if this is confusing. Let me try again.
>>>
>>> Partial-IO is a very low power mode. Only a small IO unit is switched on
>>> to be sensitive on a small set of pins for any IO activity. The rest of
>>> the SoC is powered off, including DDR. Any activity on these pins
>>> switches on the power for the remaining SoC. This leads to a fresh boot,
>>> not a resume of any kind. On am62 the pins that are sensitive and
>>> therefore wakeup-source from this Partial-IO mode, are the pins of a few
>>> CAN and UARTs from the MCU and Wkup section of the SoC.
>>>
>>> These CAN and UART wakeup-sources are also wakeup-sources for other low
>>> power suspend to ram modes. But wakeup-sources for suspend to ram modes
>>> are typically not a wakeup-source for Partial-IO as they are not powered
>>> in Partial-IO.
>>>
>>> I hope this explains it better.
>>
>> Yeah, it's kind of obvious now that just use wakeup-source. Your
>> hardware does not have two different methods of waking up. System is
>> sleeping - either S2R or partial-IO or whatever - and you want it to be
>> woken up.
>>
>> Entire property is unnecessary... and as I said before - you added it
>> only for your driver. If same feedback is repeated and repeated, there
>> is something in it...
> 
> It's not obvious for me. Maybe you can elaborate a bit.
> 
> The hardware has a different set of wakeup sources depending on the
> power mode it is in and I would like to describe these different sets of
> wakeup sources in the devicetree as for me this is a hardware property,
> not a driver thing.

I stated the argument to which you did not respond: it will not matter
for the device whether this is wakeup-source = S2R or wakeup-source =
TI-Partial-IO or whatever.

Each device is or is not wakeup source.

And just because your device has some registers or some configuration
does not mean this property is suitable for DT.

Best regards,
Krzysztof


