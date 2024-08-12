Return-Path: <linux-kernel+bounces-282766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572994E858
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771FE1C21434
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D5166F30;
	Mon, 12 Aug 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv7dcZko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D641876;
	Mon, 12 Aug 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450573; cv=none; b=cGX5GGt9o0yYZbMZCMl8URoj2y2z2LV4vt0yiJOEU1dfcBzyzZXXAFJg3pNoy6Qk1txY/bqp41SoY1VeFVdlasZBjuViJYc8FK4elzBlDfouo28flTRAfqYqCtg0OwwgvTXYOLW2sxIPf8crmU3JkJPsgVevif+opd/8m/uJ3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450573; c=relaxed/simple;
	bh=O/R5aFzzV3/ZwXlJb8xWnPgQKFIQzc9UUgmBLzyTBM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XUnj8vzh8PsDm/6Ph7hJvCro0Q+jXsZxK9ObUnKaNhR4zheTdHgedUdPDOdGp+IOAqxRRSKG3VhVlQOcwlYSdoA4YWgrkQm2zDAYYa80uRNmg9j0MbZ0pk0fjWwzR0BvUQzcMx6/+fa7vfIiHzKtgE+/Losn5m6YqwU1aml5bbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv7dcZko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC588C4AF0C;
	Mon, 12 Aug 2024 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723450573;
	bh=O/R5aFzzV3/ZwXlJb8xWnPgQKFIQzc9UUgmBLzyTBM4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Zv7dcZkog2Wj+jgh/IhZmrLzbdlhQv8kmL3prhF1LdusWQCaBSYbOLIMChpKAJTGA
	 I5EovPdN4AN7jWWxbYXRmyqSu57qxSZ1F0ojaQ30QRPD8RtmzTHj7qiYuPAktOTSeo
	 AcX9usPVAFBKV72NuUZR2ii45vsnUtjsuc+MrIhil8+r1jFA+yyzuyTDLu+MmJjFlN
	 k1WnFBbhUCCzvwH0NA/PqPHtmQ+CTZ1G7ZDe3aZHNwBxaERHuBKbJWGz5e+uv//9gh
	 EjJW7QL/qmiEpR5SSCCLXs2fynxLJFLrZSixU10gZ62k7ooWP2iecBhRh0r2CkftXR
	 s2Gn6iR1usy8g==
Message-ID: <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
Date: Mon, 12 Aug 2024 10:16:05 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/08/2024 09:26, Ryan Chen wrote:
>> Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
>>
>>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
>>> bindings
>>>
>>> On 09/08/2024 07:47, Ryan Chen wrote:
>>>>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
>>>>> bindings
>>>>>
>>>>> Le 08/08/2024 à 09:59, Ryan Chen a écrit :
>>>>>> Add dt bindings for AST2700 clock controller
>>>>>>
>>>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>>>>> ---
>>>>>>   .../dt-bindings/clock/aspeed,ast2700-clk.h    | 175
>>>>> ++++++++++++++++++
>>>>>>   1 file changed, 175 insertions(+)
>>>>>>   create mode 100644
>>>>>> include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>>
>>>>>> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>> b/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..facf72352c3e
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
>>>>>> @@ -0,0 +1,175 @@
>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>> +/*
>>>>>> + * Device Tree binding constants for AST2700 clock controller.
>>>>>> + *
>>>>>> + * Copyright (c) 2024 Aspeed Technology Inc.
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef __DT_BINDINGS_CLOCK_AST2700_H #define
>>>>>> +__DT_BINDINGS_CLOCK_AST2700_H
>>>>>> +
>>>>>> +/* SOC0 clk-gate */
>>>>>> +#define SCU0_CLK_GATE_MCLK (0)
>>>>>> +#define SCU0_CLK_GATE_ECLK (1)
>>>>>> +#define SCU0_CLK_GATE_2DCLK        (2)
>>>>>> +#define SCU0_CLK_GATE_VCLK (3)
>>>>>> +#define SCU0_CLK_GATE_BCLK (4)
>>>>>> +#define SCU0_CLK_GATE_VGA0CLK      (5)
>>>>>> +#define SCU0_CLK_GATE_REFCLK       (6)
>>>>>> +#define SCU0_CLK_GATE_PORTBUSB2CLK (7) #define
>>> SCU0_CLK_GATE_RSV8
>>>>>> +(8)
>>>>>> +#define SCU0_CLK_GATE_UHCICLK      (9)
>>>>>> +#define SCU0_CLK_GATE_VGA1CLK      (10)
>>>>>> +#define SCU0_CLK_GATE_DDRPHYCLK    (11)
>>>>>> +#define SCU0_CLK_GATE_E2M0CLK      (12)
>>>>>> +#define SCU0_CLK_GATE_HACCLK       (13)
>>>>>> +#define SCU0_CLK_GATE_PORTAUSB2CLK (14)
>>>>>> +#define SCU0_CLK_GATE_UART4CLK     (15)
>>>>>> +#define SCU0_CLK_GATE_SLICLK       (16)
>>>>>> +#define SCU0_CLK_GATE_DACCLK       (17)
>>>>>> +#define SCU0_CLK_GATE_DP   (18)
>>>>>> +#define SCU0_CLK_GATE_E2M1CLK      (19)
>>>>>> +#define SCU0_CLK_GATE_CRT0CLK      (20)
>>>>>> +#define SCU0_CLK_GATE_CRT1CLK      (21)
>>>>>> +#define SCU0_CLK_GATE_VLCLK        (22)
>>>>>> +#define SCU0_CLK_GATE_ECDSACLK     (23)
>>>>>> +#define SCU0_CLK_GATE_RSACLK       (24)
>>>>>> +#define SCU0_CLK_GATE_RVAS0CLK     (25)
>>>>>> +#define SCU0_CLK_GATE_UFSCLK       (26)
>>>>>> +#define SCU0_CLK_GATE_EMMCCLK      (27)
>>>>>> +#define SCU0_CLK_GATE_RVAS1CLK     (28)
>>>>>> +/* reserved 29 ~ 31*/
>>>
>>> No, you cannot reserve IDs. They are always continous.
>> I think for mis-understood.
>> I will remove the comment.
>> And keep it is continuous. Thanks.
>>>
>>>>>> +#define SCU0_CLK_GATE_NUM  (SCU0_CLK_GATE_RVAS1CLK + 1)
>>>
>>> No, not a binding.
>>
> I will modify by following.
> 
> #define SCU0_CLK_GATE_RVAS1CLK  (28)
> #define SCU0_CLK_GATE_NUM       (SCU0_CLK_GATE_RVAS1CLK + 1) 

Nothing changed. Still not a binding. Why do you send the same and
expect different result? Drop.

Address feedback sent to you from previous versions of the patchset.
There was never a reply.

Best regards,
Krzysztof


