Return-Path: <linux-kernel+bounces-282788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181294E8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B52B229E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D216BE07;
	Mon, 12 Aug 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORGNLGhh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196094D599;
	Mon, 12 Aug 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451441; cv=none; b=l9xirbam3EqNVbSyVTGbLQuiER2OlKKRYXD2FjEjrkVgUJHKl/VqsndE3NlaXRJ98vvqrd/vWe9CuUqZtmjR8F+Lt3iTuGAWBY3PB6/oJj/0iBcAxHickygkx9iTgM8u2Gx+yobneCvWFY+IJtM9bhfmfihOBTgvukumwt88GK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451441; c=relaxed/simple;
	bh=poqgoFKKEvgwQ0Gt4Hn8ttFfzKcgAB9OSMPixsYVqxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p775+tyC+TyFp4xsr2018DRdFxFKS+mjPO/NaqHSlXHS42JosV9010JwTlSLbLnN41tK6FRn5R9a115W6qt/pEKa/ORLjfux78cj1MvQzdj+m1HXqNF/uG7MXG7jx43Bphx47w7Tgv9LKPS0mi0+dW3zBhr7IMXIw5anVwFRoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORGNLGhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60929C32782;
	Mon, 12 Aug 2024 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723451440;
	bh=poqgoFKKEvgwQ0Gt4Hn8ttFfzKcgAB9OSMPixsYVqxE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ORGNLGhhtAsDC/yCH83C7aryhhv70RR3mopFAoK1m8lcJK/jcNaBAk0XkxQGZZbMb
	 Ny3JN+G+ZojAxS0rK9pc9gDZ/bG4SQ2MrDoZxM+4kBT3uw59x9QO8T28d7klQp+Ojt
	 0s47+8Hm7jb8sAyBHhf/2WaWNDmqPYZ3qfWcc6q8c98+IXQ5i5iX8ldNvP+UDkwxa0
	 dCIiATtVpx9FCAlJLAHofsp8r46CwZAACd2oRxopFDPYEe2dl4dUfiOpeidyex6X2j
	 VjVP0yoqedyv2dAVIflnlAtSxAh6U/GInFrtIt1ByBi1X2Ji2/6zUvjlRGu7764dng
	 JfOP0XLk0JW4g==
Message-ID: <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
Date: Mon, 12 Aug 2024 10:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
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
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
 <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/08/2024 10:22, Ryan Chen wrote:
>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
>>
>> On 12/08/2024 09:26, Ryan Chen wrote:
>>>> Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
>>>> bindings
>>>>
>>>>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
>>>>> bindings
>>>>>
>>>>> On 09/08/2024 07:47, Ryan Chen wrote:
>>>>>>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
>>>>>>> bindings
>>>>>>>
>>>>>>> Le 08/08/2024 à 09:59, Ryan Chen a écrit :
>>>>>>>> Add dt bindings for AST2700 clock controller
>>>>>>>>
>>>>>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>>>>>>> ---
>>>>>>>>   .../dt-bindings/clock/aspeed,ast2700-clk.h    | 175
>>>>>>> ++++++++++++++++++
>>>>>>>>   1 file changed, 175 insertions(+)
>>>>>>>>   create mode 100644
>>>>>>>> include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>>>>
>>>>>>>> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>>>> b/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..facf72352c3e
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>>>> @@ -0,0 +1,175 @@
>>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>>>> +/*
>>>>>>>> + * Device Tree binding constants for AST2700 clock controller.
>>>>>>>> + *
>>>>>>>> + * Copyright (c) 2024 Aspeed Technology Inc.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#ifndef __DT_BINDINGS_CLOCK_AST2700_H #define
>>>>>>>> +__DT_BINDINGS_CLOCK_AST2700_H
>>>>>>>> +
>>>>>>>> +/* SOC0 clk-gate */
>>>>>>>> +#define SCU0_CLK_GATE_MCLK (0)
>>>>>>>> +#define SCU0_CLK_GATE_ECLK (1)
>>>>>>>> +#define SCU0_CLK_GATE_2DCLK        (2)
>>>>>>>> +#define SCU0_CLK_GATE_VCLK (3)
>>>>>>>> +#define SCU0_CLK_GATE_BCLK (4)
>>>>>>>> +#define SCU0_CLK_GATE_VGA0CLK      (5)
>>>>>>>> +#define SCU0_CLK_GATE_REFCLK       (6)
>>>>>>>> +#define SCU0_CLK_GATE_PORTBUSB2CLK (7) #define
>>>>> SCU0_CLK_GATE_RSV8
>>>>>>>> +(8)
>>>>>>>> +#define SCU0_CLK_GATE_UHCICLK      (9)
>>>>>>>> +#define SCU0_CLK_GATE_VGA1CLK      (10)
>>>>>>>> +#define SCU0_CLK_GATE_DDRPHYCLK    (11)
>>>>>>>> +#define SCU0_CLK_GATE_E2M0CLK      (12)
>>>>>>>> +#define SCU0_CLK_GATE_HACCLK       (13)
>>>>>>>> +#define SCU0_CLK_GATE_PORTAUSB2CLK (14)
>>>>>>>> +#define SCU0_CLK_GATE_UART4CLK     (15)
>>>>>>>> +#define SCU0_CLK_GATE_SLICLK       (16)
>>>>>>>> +#define SCU0_CLK_GATE_DACCLK       (17)
>>>>>>>> +#define SCU0_CLK_GATE_DP   (18)
>>>>>>>> +#define SCU0_CLK_GATE_E2M1CLK      (19)
>>>>>>>> +#define SCU0_CLK_GATE_CRT0CLK      (20)
>>>>>>>> +#define SCU0_CLK_GATE_CRT1CLK      (21)
>>>>>>>> +#define SCU0_CLK_GATE_VLCLK        (22)
>>>>>>>> +#define SCU0_CLK_GATE_ECDSACLK     (23)
>>>>>>>> +#define SCU0_CLK_GATE_RSACLK       (24)
>>>>>>>> +#define SCU0_CLK_GATE_RVAS0CLK     (25)
>>>>>>>> +#define SCU0_CLK_GATE_UFSCLK       (26)
>>>>>>>> +#define SCU0_CLK_GATE_EMMCCLK      (27)
>>>>>>>> +#define SCU0_CLK_GATE_RVAS1CLK     (28)
>>>>>>>> +/* reserved 29 ~ 31*/
>>>>>
>>>>> No, you cannot reserve IDs. They are always continous.
>>>> I think for mis-understood.
>>>> I will remove the comment.
>>>> And keep it is continuous. Thanks.
>>>>>
>>>>>>>> +#define SCU0_CLK_GATE_NUM  (SCU0_CLK_GATE_RVAS1CLK + 1)
>>>>>
>>>>> No, not a binding.
>>>>
>>> I will modify by following.
>>>
>>> #define SCU0_CLK_GATE_RVAS1CLK  (28)
>>> #define SCU0_CLK_GATE_NUM       (SCU0_CLK_GATE_RVAS1CLK + 1)
>>
>> Nothing changed. Still not a binding. Why do you send the same and expect
>> different result? Drop.
>>
>> Address feedback sent to you from previous versions of the patchset.
>> There was never a reply.
> Sorry, mis-understood.
> Since you think "#define SCU0_CLK_GATE_NUM" not a binding.
> Do you mean I should #define SCU0_CLK_GATE_NUM in clk driver, not in binding header, am I right?

What did I write in the first Aspeed 2700 patch? So you are not going to
respond there? Are you going to implement entire feedback received in
the first version of the patchset?

Drop from the header. I am not saying you need to define it in the
driver, because maybe it is pointless anyway.

Best regards,
Krzysztof


