Return-Path: <linux-kernel+bounces-333398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D497C7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBD1C24687
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB1199FA6;
	Thu, 19 Sep 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6F8MEm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FDB3C0C;
	Thu, 19 Sep 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741955; cv=none; b=EBegl/uwnRrR8gOG27sLzbPv5dkLj3/FAYxcecEMtgFF3M/OrjRZQoHy5xIYx1xD/X+zpp6XeEoJCDpsppma3FrYRgfbvp/MhJaQCFy99KNa/w+aMhCvvx2uDChJtQ9tRgeD6RvwtwEVdJsdrcxvaPORdVp/zIeQTfvJ1zR+hbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741955; c=relaxed/simple;
	bh=Sm9wKOBIOkVaiqfIzSIBtet45x+GxQkkZYHds2rEJIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hzu/wGrl46TZIGS13fluVHrDqVlmukaRvBEHVcvhLCNGHyqbSBOnJp0+mjW6hyHYnPBr5uj6vSA5fH5kmyMxIGaQxMkeGiJtSGllktVcemMEwjPLlbl27i7Yk3Q073uXK06tYhV70JeLWOjfykAzKDgWO0EMWaxWXjc2vg43Akc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6F8MEm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45FC4CEC4;
	Thu, 19 Sep 2024 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726741954;
	bh=Sm9wKOBIOkVaiqfIzSIBtet45x+GxQkkZYHds2rEJIw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=q6F8MEm7FqfgPQTHbF1utKOaDnJQoAvXHnOGVSa0VzYoLkPgX893RJq2DJSq77as6
	 haZak+z1PU1XFMDF1GnVNzjRplOzB9+GAQDY3nP1K8owWwZvTU/ub6oLR9yB71q3cy
	 WXKeukLrfVDeBXwiu6yrmusH2dmMlWM7QZrZGbLMmlzR2uzIm5T3ldK3RHaRIYCdfq
	 Nuw9nAVZn6mHlCNED39KwdcUaWVc7yOpc4oRGvKtkCBh4iXznuQ3qUOR3IB1L8OrUt
	 dTdGyKiuCQt16yaPnlcxLF0sXxamfWV7SxNXu7borO/YPFcgYzgNLoVCnjvpIQt1gC
	 jqPiRHV/NnymA==
Message-ID: <3185f620-28be-49b8-85f4-7ff8dd5ffce0@kernel.org>
Date: Thu, 19 Sep 2024 12:32:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
 <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
 <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <f79a48e6-e0ff-453f-98c1-1c5acbe6467d@kernel.org>
 <OS8PR06MB7541FDB6A74119A160B1A57CF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB7541FDB6A74119A160B1A57CF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2024 09:13, Ryan Chen wrote:
>> Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
>>
>> On 19/09/2024 08:05, Ryan Chen wrote:
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>> index 86ee69c0f45b..127a357051cd 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>> @@ -9,6 +9,8 @@ title: Aspeed System Control Unit
>>>>>  description:
>>>>>    The Aspeed System Control Unit manages the global behaviour of
>>>>> the
>>>> SoC,
>>>>>    configuring elements such as clocks, pinmux, and reset.
>>>>> +  In AST2700 SOC which has two soc connection, each soc have its
>>>>> + own scu  register control, ast2700-scu0 for soc0, ast2700-scu1 for
>> soc1.
>>>>>
>>>>>  maintainers:
>>>>>    - Joel Stanley <joel@jms.id.au>
>>>>> @@ -21,6 +23,8 @@ properties:
>>>>>            - aspeed,ast2400-scu
>>>>>            - aspeed,ast2500-scu
>>>>>            - aspeed,ast2600-scu
>>>>> +          - aspeed,ast2700-scu0
>>>>> +          - aspeed,ast2700-scu1
>>>>>        - const: syscon
>>>>>        - const: simple-mfd
>>>>>
>>>>> @@ -30,10 +34,12 @@ properties:
>>>>>    ranges: true
>>>>>
>>>>>    '#address-cells':
>>>>> -    const: 1
>>>>> +    minimum: 1
>>>>> +    maximum: 2
>>>>>
>>>>>    '#size-cells':
>>>>> -    const: 1
>>>>> +    minimum: 1
>>>>> +    maximum: 2
>>>>
>>>> Why do the children have 64 bit addressing?
>>>
>>> AST2700 is 64bit address, so it also.
>>
>> But why do they need it?
>>
> Sorry, I may not understand your point.

I asked why do you think children require 64-bit addressing, instead of
working with existing 32-bit address.

> Since address-cell = <2>, Do you mean size-cell still 1?

No... although that's another point, how bug address size is there? For
the children?

> If yes. I do the dts check it need size-cells=<2>, when I do address-cells = <2>

Well, I talk about bus and children addressing. It's kind of obvious
that changing one property means using different reg...

Best regards,
Krzysztof


