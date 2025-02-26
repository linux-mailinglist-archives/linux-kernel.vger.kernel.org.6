Return-Path: <linux-kernel+bounces-533460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3216BA45AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460B4188BAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A524E01C;
	Wed, 26 Feb 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN3KXRqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB342459E7;
	Wed, 26 Feb 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563535; cv=none; b=fumz/NhatZGQ705ir64mj36ipIUVLqgme/LN86QNjfnfUUxjG9jkM9ICdPGJkgzgnSH14wDDrCjQH4G8f6EjcRt4lMRJ9k+2xH/Sk3O2ILijRz2PdsBt1+hpNz1+SvXEVrS50ss0lmiPpNeru9e3Uxdt8PKbZPRqOfa/be38XI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563535; c=relaxed/simple;
	bh=5T09s0qVcBTtGUjTDTgqWOKvvI0OpaBOAa+991mZ0V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CS8o/xa3HR6/UH8HmYXayh03UeKoUWll1swktti4ijofXUwDwg0ZTo4Mh94srha1YQWyVvhH6lBFvJYqR6qAgo9Kj1vQrsre8efwcK5yzYuCqMq7vP1BlP8MMgmkS6dhVC/Ql7MCxInE0rkVP+jL15K/RcEIQwrr7ZR8ukcIquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN3KXRqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F6AC4CEE2;
	Wed, 26 Feb 2025 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740563534;
	bh=5T09s0qVcBTtGUjTDTgqWOKvvI0OpaBOAa+991mZ0V4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JN3KXRqN2TW/Zc8xmUpno3ptEuwvCWcb2uAJR8DhiQ8xt/qNFdT0uPnxWz6Vb9UkP
	 VmJerQeeldcqglmsec0+F424FbTFaKRW7ZBlQMH1Y4Qv3BP7KEbajnRwF79oM66odv
	 3Z1D5TrNIfpyHhYlxpWZsHe6mDQwmqZjnKMclY7dgCwuO/OprW/yS+GktN160Hum1v
	 bNbnl+kp07MzuK3D38hRFGmlS1hKMaAJh46WOwlrHJit8i8GlPk++pzDM92NKoBSVo
	 fnf0+MsU8WPh+N+8Wbr4AX1FdLjQzn30n0KSVe6HgnNfSRsW9/HNYlLDCd7pRIwkY+
	 HhSxAZOEzh93w==
Message-ID: <1175a8d2-65ac-439e-94b8-cf7af8db37b3@kernel.org>
Date: Wed, 26 Feb 2025 10:52:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
 <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
 <f810b8a2-4261-4b68-b59b-4efa0219b5db@kernel.org>
 <OS8PR06MB7541D685A626D300AC730A5BF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <2b64a9d7-7048-4842-9cc1-fe23f5abdd00@kernel.org>
 <OS8PR06MB75411AE082C9630314966F2AF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <c4727195-757a-4624-8580-78e5c32e9290@kernel.org>
 <OS8PR06MB7541615D536BC1D44FF6D18DF2C22@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB7541615D536BC1D44FF6D18DF2C22@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2025 06:10, Ryan Chen wrote:
>> Subject: Re: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
>> define
>>
>> On 25/02/2025 10:49, Ryan Chen wrote:
>>>>>> Subject: Re: [PATCH v9 1/3] dt-binding: clock: ast2700: modify
>>>>>> soc0/1 clock define
>>>>>>
>>>>>> On 24/02/2025 10:55, Ryan Chen wrote:
>>>>>>> -remove redundant SOC0_CLK_UART_DIV13:
>>>>>>> SOC0_CLK_UART_DIV13 is not use at clk-ast2700.c, the clock source
>>>>>>> tree is uart clk src -> uart_div_table -> uart clk.
>>>>>>>
>>>>>>> -Change SOC0_CLK_HPLL_DIV_AHB to SOC0_CLK_AHBMUX:
>>>>>>> modify clock tree implement.
>>>>>>> older CLK_AHB use mpll_div_ahb/hpll_div_ahb to be ahb clock source.
>>>>>>> mpll->mpll_div_ahb
>>>>>>>                   -> clk_ahb
>>>>>>> hpll->hpll_div_ahb
>>>>>>
>>>>>>
>>>>>> I can barely understand it and from the pieces I got, it does not
>>>>>> explain need for ABI break.
>>>>>>
>>>>>
>>>>> #1. SCU0_CLK_UART_DIV13 is redundant, it does not impact ABI break
>>>>
>>>> You did not explain how it does not impact. Clock was exported, there
>>>> was a user and now there is no clock. User stops working. ABI break.
>>>>
>>>
>>> Sorry, SCU0_CLK_UART_DIV13 was defined, but was never referenced in any
>> upstream device trees.
>>
>>
>> That's incomplete definition of ABI
>>
>>> Since there is no in-tree usage of `SCU0_CLK_UART_DIV13`, its removal does
>> not cause an ABI break.
>>
>>
>> You ignored out of tree users. Please read carefully ABI docs.
>>
>>
>>>
>>>>> #2. Change SOC0_CLK_HPLL_DIV_AHB to SOC0_CLK_AHBMUX Older
>>>> implement
>>>>> where `mpll_div_ahb` and `hpll_div_ahb` were **hardcoded dividers**
>>>>> for
>>>> AHB.
>>>>> In **the new approach (v8)**, I refactored the clock tree to clock tree.
>>>>
>>>> I still cannot parse sentences like "refactoring A to A". It's meaningless to
>> me.
>>>>
>>>>> It should be ABI-safe change
>>>>
>>>> No, you do not understand the ABI. You removed a clock ID, that's the
>>>> ABI change.
>>>>
>>>> Otherwise explain how this is not changing ABI.
>>>>
>>>>
>>>>>
>>>>> Or you want to keep original SOC0_CLK_HPLL_DIV_AHB define and then
>>>>> add
>>>> SOC0_CLK_AHBMUX.
>>>>> To be 1st patch, then 2n patch remove redundant
>>>> SOC0_CLK_HPLL_DIV_AHB?
>>>>
>>>> If you break the ABI you need to clearly explain why. We have long
>>>> conversations and you still did not say why.
>>>>
>>> Sorry, my point will be following steps to avoid potential ABI issues,
>>> I can modify the patch series as follows:
>>> 1. **Patch 1:** Add `SOC0_CLK_AHBMUX` without removing
>> `SOC0_CLK_HPLL_DIV_AHB`.
>>> 2. **Patch 2:** Finally remove `SOC0_CLK_HPLL_DIV_AHB`.
>>
>>
>> I do not understand what changed here. You remove exported clock which is
>> ABI, so how is this answering my question.
>>
>> You keep dodging my questions. Here I asked "why". I do not see any answer
>> why.
> 
> Apology, I can't catch your point. But I still need your guideline.
> 
> **Regarding `SCU0_CLK_UART_DIV13`:**
>    - This clock ID was originally defined but was never used in any in-tree device trees. (i2c-ast2700.c v1 ~ v9)
>    - So there should not have ABI-break am I correct?


No, because there are other users of bindings. All forks, out of tree
DTS, other projects etc. You defined ABI for them.

> 
> **Regarding `SOC0_CLK_HPLL_DIV_AHB` → `SOC0_CLK_AHBMUX`:**
>    - The previous implementation used dividers (`mpll_div_ahb`, `hpll_div_ahb`) for AHB clock selection. (i2c-ast2700.c v1 ~ v8)
> mpll->mpll_div_ahb
>                   -> clk_ahb
> hpll->hpll_div_ahb
>    - The new approach use `SOC0_CLK_AHBMUX`, which AHB clock sources via a mux. (i2c-ast2700.c v9)
> mpll->
>       ahb_mux -> div_table -> clk_ahb
> hpll->

Your formatting is one of the problems I have troubles understanding it.
Above is not wrapped or wrapped oddly. You keep using bold * but double
**, which is not a standard markup. Please switch to standard mailing
list formatting - proper wrapping, only text mode and use client which
actually can parse and create that.

What I don't understand is how clocks could change in hardware. You
described implementation, but the clock IDS do not describe
implementation but the the mapping to real hardware clocks. So how
SOC0_CLK_HPLL_DIV_AHB clock disappeared from hardware?


>    - And since i2c-ast2700.c (v8) is not applied, so there should also no one use this ABI. Am I correct?

If binding was not applied, then what are you changing here?

Does it mean header described clock which was in the hardware but its
handling was not yet implemented in the driver?


> 
> If this is not acceptable, my next patch will keep SCU0_CLK_UART_DIV13/SCU0_CLK_HPLL_DIV_AHB define.

Maybe my last message was not clear, so: you need to explain why you are
breaking ABI and/or explain the ABI impact in the commit msg.

> But add new SCU0_CLK_AHBMUX define for avoid your point ABI break. Is this acceptable?  


Best regards,
Krzysztof

