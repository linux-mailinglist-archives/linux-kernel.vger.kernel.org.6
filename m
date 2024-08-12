Return-Path: <linux-kernel+bounces-282638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB994E6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D23A283170
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD514F9C7;
	Mon, 12 Aug 2024 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6MRHaem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B82599;
	Mon, 12 Aug 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444467; cv=none; b=XUulSstoSniIsQU0xSCoA89G2wOnTcPAF4rKqwAIAgGdD2QWsl1/bqnYgYJv5VRxQCx6hk+FLT6ZotlUtAl8RQk0WQA25bZcdxBRZawOhFqyYOPu3epEpjxu712J3wD5KdXgQfOVVWsOY+bI/3pqV/nmvkYqdYYPgEGzSirGdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444467; c=relaxed/simple;
	bh=h5YunoJ1CgTgC/s+clCigfHNxM4JDy7MRIOS0sYh4LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ge38L6VwoatR6Yu1gZANKG0YBXsE+78KFZT5KwE6OZPL7oJIuEOUB2Sn9A+YaDUGI5ltEEGd1ic4EyBs2Yr4TsS9fxJ6rmRpxStKZaWitpVK/0hIGiv7rHIDFX5S5NiQCr0suVcq9YFaLEpmKmhMzIQN/czWFotcxGzJQTNAsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6MRHaem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46730C32782;
	Mon, 12 Aug 2024 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723444467;
	bh=h5YunoJ1CgTgC/s+clCigfHNxM4JDy7MRIOS0sYh4LA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=l6MRHaemp+DF10nfRA7BH7O7L94UWkgsyqklBo5M5mKjOHMV47PlTNmQ4a3/BwiSU
	 vYcs2SLD2xZKGhiSFGP+RcL10jT8D7pLLeW6XuTzF5ZrLVtQKG58rTLfVKjvI00jiK
	 FENM7K2RKC0KaYSf4tS5FMg5K4ZTvIuBOBYDPD8/H4SMgohh/extPsrz4YbDYg7XEV
	 4imzo+cPbyOg7foAgS+cOA6C6ETLl8EHc9UXmVbqU+FggMS+7FRqHVp2kzkflFdYEJ
	 GYcxZtFlgko3TwtLEEbuX/Z7qSMbJ+dosZSrGQYa/hEm8wi6ILWPDxuQi10XX8xVks
	 JxBVu5Omx1WcA==
Message-ID: <a70e619e-daae-4a1d-a854-14356482892e@kernel.org>
Date: Mon, 12 Aug 2024 08:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
To: Ryan Chen <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB754103B3285153723708931EF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB754103B3285153723708931EF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/08/2024 08:26, Ryan Chen wrote:
>> Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
>>
>>> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
>>>
>>> On 09/08/2024 07:55, Ryan Chen wrote:
>>>>> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
>>>>> AST2700
>>>>>
>>>>> On 08/08/2024 09:59, Ryan Chen wrote:
>>>>>> Add compatible support for AST2700 clk, reset, pinctrl, silicon-id
>>>>>> and example for AST2700 scu.
>>>>>>
>>>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>>>>> ---
>>>>>>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31
>>>>> +++++++++++++++++--
>>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>>> index 86ee69c0f45b..c0965f08ae8c 100644
>>>>>> ---
>>>>>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
>>>>>> +++
>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yam
>>>>>> +++ l
>>>>>> @@ -21,6 +21,8 @@ properties:
>>>>>>            - aspeed,ast2400-scu
>>>>>>            - aspeed,ast2500-scu
>>>>>>            - aspeed,ast2600-scu
>>>>>> +          - aspeed,ast2700-scu0
>>>>>> +          - aspeed,ast2700-scu1
>>>>>
>>>>> What are the differences between these two?
>>>>
>>>> The next [PATCH 4/4] is scu driver that include ast2700-scu0 and
>>>> ast2700-scu1 CLK_OF_DECLARE_DRIVER(ast2700_soc0,
>>>> "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
>>>> CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1",
>>>> ast2700_soc1_clk_init);
>>>
>>> What are hardware differences? Entirely different devices?
>>
>> AST2700 have two soc die connected each other.
>> Each soc die have it own scu, so the naming is ast2700-scu0 for soc0, another
>> is ast2700-scu1 for soc1.
>>
>>>
>>>> So I add these two.
>>>>
>>>>>
>>>>>>        - const: syscon
>>>>>>        - const: simple-mfd
>>>>>>
>>>>>> @@ -30,10 +32,12 @@ properties:
>>>>>>    ranges: true
>>>>>>
>>>>>>    '#address-cells':
>>>>>> -    const: 1
>>>>>> +    minimum: 1
>>>>>> +    maximum: 2
>>>>>>
>>>>>>    '#size-cells':
>>>>>> -    const: 1
>>>>>> +    minimum: 1
>>>>>> +    maximum: 2
>>>>>>
>>>>>>    '#clock-cells':
>>>>>>      const: 1
>>>>>> @@ -56,6 +60,8 @@ patternProperties:
>>>>>>              - aspeed,ast2400-pinctrl
>>>>>>              - aspeed,ast2500-pinctrl
>>>>>>              - aspeed,ast2600-pinctrl
>>>>>> +            - aspeed,ast2700-soc0-pinctrl
>>>>>> +            - aspeed,ast2700-soc1-pinctrl
>>>>>>
>>>>>>      required:
>>>>>>        - compatible
>>>>>> @@ -76,6 +82,7 @@ patternProperties:
>>>>>>                - aspeed,ast2400-silicon-id
>>>>>>                - aspeed,ast2500-silicon-id
>>>>>>                - aspeed,ast2600-silicon-id
>>>>>> +              - aspeed,ast2700-silicon-id
>>>>>>            - const: aspeed,silicon-id
>>>>>>
>>>>>>        reg:
>>>>>> @@ -115,4 +122,24 @@ examples:
>>>>>>              reg = <0x7c 0x4>, <0x150 0x8>;
>>>>>>          };
>>>>>>      };
>>>>>> +  - |
>>>>>> +    soc0 {
>>>>>> +        #address-cells = <2>;
>>>>>> +        #size-cells = <2>;
>>>>>
>>>>> That's the same example as previous, right? The drop, no need.
>>>>
>>>> AST2700 is 64bits address mode platform, that the reason.
>>>> So I add example for 64bits platform descript in dtsi I have to add
>>>> soc0 to be address-cells and size-cells to be <2> Then I can define
>>>> the register to be 64bits address and size.
>>>
>>> That's trivial. Drop.
>> Do you mean, I don’t need add example for ast2700-scu0?
>>
>> Or delete #address-cells = <2>;  #size-cells = <2>; If I remove it will make
>> dt_binding_check fail.
>>>
> Hello Krzysztof
> 
> Use dt_binding_check, it need #address-cells = <2>;  #size-cells = <2> for 64 bit address description.
> Or I don't need example?

Drop example. It's basically the same as existing one.

Best regards,
Krzysztof


