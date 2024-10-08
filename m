Return-Path: <linux-kernel+bounces-354787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE6994295
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC33293843
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598F1DE4F4;
	Tue,  8 Oct 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adDnCqNc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6141DD54F;
	Tue,  8 Oct 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375637; cv=none; b=TU3ljBtI5ft3FhYCHFAEFaX/rGAdt8c5KX9raR2RHz2JyZsWmmVX83TUYlp2mejHtnsXo9YfOKNbvcNuzqht34pfsA1CVw/gev1VHI6iGEwePyEmB3mIVdyvgscW+0z3KP6LTV8Fw5a35+6HTHt8VypXphihvBmlIFdmPRJj4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375637; c=relaxed/simple;
	bh=xCCK6RUOuxARbyEGhETA3FiKI88jMUI0oByK8lc/T6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZa+j23biGux5NJcqFAGo14AFKozy3+kT+kNlCLJQOYv9ZbYQl1YF86VzB2QP0Ma0yrnZYBHSOHpSO2QCxl1dOnJjDXJZ9F/oSJp0KQWb0j6HtW9spjUvZenF9xnxLoFIZnxj4j1bw4d0DeB7VO1SSHkblzOSr3HQK/vShCI+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adDnCqNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239D3C4CEC7;
	Tue,  8 Oct 2024 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728375637;
	bh=xCCK6RUOuxARbyEGhETA3FiKI88jMUI0oByK8lc/T6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=adDnCqNcZGwjB6MO8+9wRFVHl/JvqhqZJ7QEPucNZEqfqi7JV+kOP9Fiy09DUY/eg
	 eXVn+sNyGOaRuvoUyLQzVmfRy4CoJHNY18PYGgyclHxYbccewhTk7FgjpfRxpYcglc
	 7zA2CS/JMqobi+UlOf7MWZVM4/6MlC7+gy5v6ulehOV1yuY/3HInPCzZlGMSwd51ZO
	 oJqoDyrNH1enX2ILtDZJ7CVenu/5Fc+vYm2wJAHKnLlLiSna/1FrhIvhbb2s7K/di5
	 aBle26gb6A3tIyArC4x9W3ZwzHJbeyAqthzNrmfYSgc/4o4Q0Q5ez/QzKqnpfFJQ7X
	 JzQ3rsFMkXGIQ==
Message-ID: <7bce31c0-8c74-4d65-812f-01951a0d75d1@kernel.org>
Date: Tue, 8 Oct 2024 10:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: clock: imx8m-anatop: support spread
 spectrum clocking
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
 <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com>
 <566859c1-a397-4465-987e-0682b07a703e@kernel.org>
 <CABGWkvqqg-PGAZTCz=MMLRx5F93jaN_=z8zJt1sDd3PHXd80PQ@mail.gmail.com>
 <6c3e6071-822f-4230-b76b-276330de07ef@kernel.org>
 <CABGWkvrU507BHoP94Y7fEyFr=chuuy3o=oBHtuWRvwTw3GnxXw@mail.gmail.com>
 <82db5037-bbd3-4005-bde9-02df1bf4c475@kernel.org>
 <CABGWkvqXZ+YAvo-AtUy+Ftdu0xxXKuhOwcSTwO5Fv6D3yzttNg@mail.gmail.com>
 <b847ccb1-1eb8-4119-8612-212804cb50d8@kernel.org>
 <CABGWkvqkmo9O-O1taR651W4xo=yqar=p71e0LKqRte2CGZ2Z8w@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CABGWkvqkmo9O-O1taR651W4xo=yqar=p71e0LKqRte2CGZ2Z8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2024 17:02, Dario Binacchi wrote:
> On Sun, Oct 6, 2024 at 3:13 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 05/10/2024 10:57, Dario Binacchi wrote:
>>> On Thu, Oct 3, 2024 at 12:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 01/10/2024 08:29, Dario Binacchi wrote:
>>>>> On Mon, Sep 30, 2024 at 8:45 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>
>>>>>> On 29/09/2024 22:00, Dario Binacchi wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> +  properties:
>>>>>>>>> +    compatible:
>>>>>>>>> +      contains:
>>>>>>>>> +        enum:
>>>>>>>>> +          - fsl,imx8mm-anatop
>>>>>>>>> +
>>>>>>>>> +then:
>>>>>>>>> +  properties:
>>>>>>>>> +    fsl,ssc-clocks:
>>>>>>>>
>>>>>>>> Nope. Properties must be defined in top-level.
>>>>>>>>
>>>>>>>>> +      $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>>>>> +      description:
>>>>>>>>> +        The phandles to the PLLs with spread spectrum clock generation
>>>>>>>>> +        hardware capability.
>>>>>>>>
>>>>>>>> These should be clocks.
>>>>>>>
>>>>>>> Sorry, but I can't understand what you're asking me.
>>>>>>> Could you kindly explain it to me in more detail?
>>>>>>
>>>>>> You added new property instead of using existing one for this purpose:
>>>>>> 'clocks'.
>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> I added this new property specifically for managing spread-spectrum.
>>>>> Indeed, not all clocks/PLLs
>>>>> managed by the node/peripheral support spread-spectrum, and the added
>>>>> properties specify
>>>>> parameters for enabling and tuning SSC for each individual PLL based
>>>>> on the index of each list.
>>>>> If I were to use the 'clocks' property and add a clock to this list
>>>>> that does not support SSC, IMHO
>>>>> the pairings would be less clear.
>>>>
>>>> You duplicate property with argument "pairings shall match". Well, I am
>>>> not happy with the duplication. Clocks have specific order, thus it is
>>>> explicit which one needs tuning. Your other properties can match them as
>>>> well, just index from clocks is offset...
>>>
>>> Just to check if I understood correctly what you are suggesting before
>>> submitting version 3 of the patch.
>>> Something, for example, like:
>>>
>>> clocks = <&clk, IMX8MP_AUDIO_PLL1>,  <&clk, IMX8MP_AUDIO_PLL2>, <&clk
>>> IMX8MP_VIDEO_PLL1>;
>>> fsl,ssc-modfreq-hz = <0, 3517>, <2, 6818>;
>>
>> Hm, what is 0? If clock index, then no, it's redundant. The first item
>> in cannot point to other clock.
>>
>> Also, what exactly are you setting here
> 
> I am enabling and configuring the spread spectrum.
> 
> Normal clock: Without spread spectrum, the clock signal has a fixed and
> repetitive frequency (e.g., 100 MHz). This frequency generates an
> electromagnetic
> signal concentrated on a single frequency, and if strong enough, it can disturb
> other devices.
> 
> Spread spectrum:  With spread spectrum, the clock frequency is
> slightly "modulated,"
> meaning it oscillates around a central value. For example, if the base
> frequency is 100 MHz,
> the clock might vary between 99.5 MHz and 100.5 MHz in a cyclic manner. This
> small variation spreads the energy over a wider range of frequencies
> (from 99.5 to 100.5 MHz),
> reducing the intensity of the signal at any one frequency.

Sure, so each board will come with its own, different values and you
will not put into the SoC DTSI?

Where is the DTS? I received only this patch.

> 
>> and why assigned-clock-rates are
>> not working?
> 
> The traditional clock properties, such as clocks,
> assigned-clocks-rates, etc retain their usual
> meaning even when spread spectrum is applied. However, to implement
> the spread spectrum
> mechanism in a circuit with a PLL (Phase-Locked Loop), additional
> specific parameters are
> introduced to properly configure the frequency modulation:
> 
>  - Modulation frequency: i. e. fsl,ssc-modfreq-hz
>  - Modulation rate: i.e.  fsl,ssc-modrate-percent
>  - Modulation type:  i. e. fsl,ssc-modmethod (center-spread, down-spread)
> 
> Additionally, it should be noted that not all anatop PLLs are equipped
> with circuitry for spread
> spectrum, but only a small subset of them. This is the reason why I
> introduced the property
> "fsl, ssc-clocks".
> 
> This is another commit [1] on enabling spread spectrum that I
> implemented some time ago for
> the am335x. The most evident difference is that in that case the node
> was a clock node and not
> a clock controller, as in the case of anatop. The parameters are also
> not exactly the same, but
> that depends on the platform.
> 
> [1] 4a8bc2644ef0cbf8e ("dt-bindings: ti: dpll: add spread spectrum support")


OK, I still do not know what "0" was, but the items are fixed, so you
know exactly which clock you are configuring here.

Best regards,
Krzysztof


