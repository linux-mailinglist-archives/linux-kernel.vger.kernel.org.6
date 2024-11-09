Return-Path: <linux-kernel+bounces-402758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC359C2BA3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E021F21FE5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3514EC51;
	Sat,  9 Nov 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDN6T66X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F732C8B;
	Sat,  9 Nov 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731147617; cv=none; b=CT2wJWMlzBF4zvUjscaFwnwkxE4e1xGXszQfr4oDTpHJhymkpc4MZ51sYY5BJT2JM9t/pmvajpxciRMaeKzM6NltGRuMOIRbFrvTW9bkPEtzy6qSr/oYtXstHK7rM8J2QmA74x/+SJEE5gOYxo7c1P7NN7pnjxjL1wHPH1iHE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731147617; c=relaxed/simple;
	bh=agKOkXJQEG8M4fQeeL8fKTNuJmqtiO3UmIawpAMJ+dU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fTuqvv6xB8U+C+JXVTY6wBXY1z4XIZ7YaeVXgWomEMloCiz7BdVaBHw1CoHmvzEBwGZD5mPmgdQ86jorZHPQnro3GKcZPNfILZAMTZH13XWaT7Cenzb4QYAE3DGcvZJiJmneme/nbURrhPrhJ4axP0ffw0i7IS5vnDEAIg+ta48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDN6T66X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279EC4CECE;
	Sat,  9 Nov 2024 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731147617;
	bh=agKOkXJQEG8M4fQeeL8fKTNuJmqtiO3UmIawpAMJ+dU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TDN6T66Xv4qvfHUYHB21h0ffTK04u4xrUDdMDdmjhkWom98bnKuCECdyl8AcarvdK
	 sGzogOu6SyIvYHQmCtj2Q2xRM2cfdwdNR45qJpjligzAXck+ytDU3WcxAuN+C390DQ
	 ZPzP7Brei7criwV2kLjAnqrsrtzZXhLoQPPCvM8h77i948VZxeNurNRmLLSX4Ak43e
	 ha37MCmWXwA7bUcMiO4jQLefll4sBXF2zjW/mHm70oMnha0BLYj4RjAHEgHHDqNtQs
	 X6WK+REQPC/tNK3RpJ0uWKnhQlenYg6/pY7lKU8CmNd6V1FohmPO/BBq0OakCVpPQt
	 004aTpinKDvjg==
Message-ID: <9f6b243b-0642-41db-85ed-d020bfa3e6e2@kernel.org>
Date: Sat, 9 Nov 2024 11:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peng Fan <peng.fan@nxp.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
 Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
 <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
 <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
 <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org>
 <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <8c310eca-d695-418c-82cb-a89351d83887@kernel.org>
 <PAXPR04MB8459B6F8D5C623D19CCF6B39885E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc02327b-dea8-48c9-b036-4a0eda0c4cb9@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <bc02327b-dea8-48c9-b036-4a0eda0c4cb9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2024 11:05, Krzysztof Kozlowski wrote:
> On 09/11/2024 01:37, Peng Fan wrote:
>>> Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support
>>> spread spectrum clocking
>>>
>>> On 08/11/2024 13:50, Peng Fan wrote:
>>>>> Subject: Re: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock:
>>> support
>>>>> spread spectrum clocking
>>>>>
>>>>> On 07/11/2024 15:57, Dario Binacchi wrote:
>>>>>>     clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
>>>>>>                   <&clk_ext3>, <&clk_ext4>;
>>>>>>     clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
>>>>>>                              "clk_ext3", "clk_ext4";
>>>>>>     assigned-clocks = <&clk IMX8MN_CLK_A53_SRC>,
>>>>>>                                   <&clk IMX8MN_CLK_A53_CORE>,
>>>>>>                                   <&clk IMX8MN_CLK_NOC>,
>>>>>>                                   <&clk IMX8MN_CLK_AUDIO_AHB>,
>>>>>>                                   <&clk IMX8MN_CLK_IPG_AUDIO_ROOT>,
>>>>>>                                   <&clk IMX8MN_SYS_PLL3>,
>>>>>>                                   <&clk IMX8MN_AUDIO_PLL1>,
>>>>>>                                   <&clk IMX8MN_AUDIO_PLL2>;
>>>>>>     assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_800M>,
>>>>>>                                              <&clk IMX8MN_ARM_PLL_OUT>,
>>>>>>                                              <&clk IMX8MN_SYS_PLL3_OUT>,
>>>>>>                                              <&clk IMX8MN_SYS_PLL1_800M>;
>>>>>>     assigned-clock-rates = <0>, <0>, <0>,
>>>>>>                                          <400000000>,
>>>>>>                                          <400000000>,
>>>>>>                                          <600000000>,
>>>>>>                                          <393216000>,
>>>>>>                                          <361267200>; };
>>>>>>
>>>>>> The spread spectrum is not configurable on these clocks or, more
>>>>>> generally, may not be configurable (only 4 PLLs have this
>>> capability).
>>>>>> Therefore, I need the "fsl,ssc-clocks"
>>>>>
>>>>> No. That's not true. You do not need it.
>>>>>
>>>>
>>>> i.MX8M clock hardware is similar as:
>>>>
>>>> OSC->ANATOP->CCM
>>>>
>>>> ANATOP will produce PLLs.
>>>> CCM use PLLs as input source.
>>>>
>>>> Currently there is no dedicated ANATOP driver in linux.
>>>> The CCM linux driver will parse the ANATOP node and register clk_hw
>>>> for the PLLs.
>>>
>>> I do not know what is CCM and how does it fit here. What's more, I
>>> don't get driver context here. We talk about bindings.
>>
>>
>> CCM: Clock Control Module, it accepts PLL from anatop as inputs,
>> and outputs clocks to various modules, I2C, CAN, NET, SAI and ...
>>
>>>
>>>
>>>>
>>>>
>>>>> First, the clock inputs for this device are listed in clocks *only*.
>>>>> What is no there, is not an input to the device. Including also Linux
>>>>> aspect (missing devlinks etc). Therefore how can you configure
>>> spread
>>>>> spectrum on clocks which are not connected to this device?
>>>>
>>>> I not understand this well, you mean
>>>> add clocks = <xx CLK_IMX8MM_VIDEO_PLL> in the ccm dtb node?
>>>
>>> Yes. Let me re-iterate and please respond to this exactly comment
>>> instead of ignoring it.
>>>
>>> How a device can care about spread spectrum of a clock which is not
>>> supplied to this device?
>>
>> I hope we are on same page of what spread spectrum means.
>> spread spectrum of a clock is the clock could produce freq in a range,
>> saying [500MHz - 100KHz, 500MHz + 100KHz]. software only need
>> to configure the middle frequency and choose the up/down border
>> range(100KHz here) and enable spread spectrum. 
>>
>> device: I suppose you mean the Clock Control Module(CCM) here.
> 
> I mean the device we discuss here, in this binding. Whatever this device
> is. CCM or CCX
> 
>> CCM does not care, it just accepts the PLL as input, and output
> 
> Takes PLL as input but you refuse to add it as clocks? Are you really
> responding to my question?
> 
> I asked how can you set spread spectrum on clock which you do not
> receive. Why you do not receive? Because you refuse to add it to clocks
> even though I speak about this since months.
> 
>> divided clock to various IPs(Video here). The video IPs care about
>> the spread spectrum of the clock.
> 
> So which device do we talk about? I am not a NXP clock developer and I
> care zero about NXP, so keep it simple. We discuss this one specific
> binding for specific device which is called "imx8m-clock" - see subject
> prefix.
> 
>>
>> The clock hardware path is as below:
>>
>> OSC(24M) --> Anatop(produce PLL with spread spectrum) ->
>> Clock Control Module(output clock to modules) -> Video IP
>>
>> From hardware perspective, Clock Control Module does not
>> care spread spectrum. Video IP cares spread spectrum.
>>
>>
>>>
>>> Why would you care about spread spectrum of some clock which is not
>>> coming to this device?
>>
>> device, I suppose you mean clock control module(CCM). 
>>
>> There is no 'clocks = <&ccm CLK_IMX8M_VIDEO_PLL>' under ccm node.
>> Because in current design, ccm is taken as producer of
>> CLK_IMX8M_VIDEO_PLL, not consumer. 
> 
> I don't understand now even more. Or I understand even less now. Why
> binding references its own clocks via phandle? This makes no sense at
> all, except of course assigned clocks, but that's because we have one
> property for multiple cases.

And BTW if that was the point then the example is confusing because the
&clk phandle is not the device node in the example but it should.
Neither description says which device's clocks are these.

This is expressed very poorly in the binding, look:
"Phandles of the PLL" - it clearly suggests some other clocks, not its
own, that's so obvious I did not even think of asking. Patchset goes
slow also because of poor explanation, lack of diagrams and expecting me
to remember your clock hierarchy.

Best regards,
Krzysztof


