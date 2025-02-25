Return-Path: <linux-kernel+bounces-531434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD0A44086
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C719441200
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C671269899;
	Tue, 25 Feb 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL071skN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B826982F;
	Tue, 25 Feb 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489235; cv=none; b=GyhQtwJevVDULCJGDSKTBSbTLBlD0tYzxPEcjROkzoastOPmX/lLziPGbFY4MMJhFowQZUr4nZAL72T5srwI72CP4d4CnBzNjFp9f9NUafC0V7a5dzKdwSDI1qQgc7IyPGC0Eqox/Jl4/hDdkjttqlUXVNwl05Q3q4QJhOqH6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489235; c=relaxed/simple;
	bh=DGNBCAm2Bb+g82225Nn5nxVsAmT5j6wYmXnlyqkoNZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mIR6u9xaw5PYzx0s7icEUQVVaZ8m05d8gm2tv97JrWXTER/FJx+ee+0WDjN2ZqGYtNG7At129wI1GRccsoOcykaAbiC8tZtfb70FxSh1okn/hFxHBRCKbXapnrGPgEACPGDdiZwMj6VV6/rYnwY8UY2QysRe0GzU4fscuKMvn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL071skN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE82C4CEDD;
	Tue, 25 Feb 2025 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740489234;
	bh=DGNBCAm2Bb+g82225Nn5nxVsAmT5j6wYmXnlyqkoNZk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PL071skNzUMHIjpJ4IgSnCe6G1rGpbFGvVtBnLiV8bUuMOHEAVafTbHGUy9/1YsD4
	 jc3990mUZnfv0Be5thjANFysWpneqy7gM2SEDYNRuMvw0beBOxRosL6YDKhk9d8Tna
	 KEudHQln+jDL82X6QqnUV+dlNwf/JmYfXwb4BSEeKvdXAvJbAQz8wsLGUsohlw20hg
	 u3+DWJB5T2/HHoyD5+Gxt5vyzwKpJMT0pQxqoESiLPzXeK2DpBBTo0yCI2cOdtzmPO
	 uAH6EdHW2fig+x2JmoiVnCAoh+ZMj+Q4zUl6V/cUACoYEmvo/bWxmoi2FUqH5xNbGq
	 wn68QzeOHC+gg==
Message-ID: <c4727195-757a-4624-8580-78e5c32e9290@kernel.org>
Date: Tue, 25 Feb 2025 14:13:48 +0100
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB75411AE082C9630314966F2AF2C32@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 10:49, Ryan Chen wrote:
>>>> Subject: Re: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1
>>>> clock define
>>>>
>>>> On 24/02/2025 10:55, Ryan Chen wrote:
>>>>> -remove redundant SOC0_CLK_UART_DIV13:
>>>>> SOC0_CLK_UART_DIV13 is not use at clk-ast2700.c, the clock source
>>>>> tree is uart clk src -> uart_div_table -> uart clk.
>>>>>
>>>>> -Change SOC0_CLK_HPLL_DIV_AHB to SOC0_CLK_AHBMUX:
>>>>> modify clock tree implement.
>>>>> older CLK_AHB use mpll_div_ahb/hpll_div_ahb to be ahb clock source.
>>>>> mpll->mpll_div_ahb
>>>>>                   -> clk_ahb
>>>>> hpll->hpll_div_ahb
>>>>
>>>>
>>>> I can barely understand it and from the pieces I got, it does not
>>>> explain need for ABI break.
>>>>
>>>
>>> #1. SCU0_CLK_UART_DIV13 is redundant, it does not impact ABI break
>>
>> You did not explain how it does not impact. Clock was exported, there was a
>> user and now there is no clock. User stops working. ABI break.
>>
> 
> Sorry, SCU0_CLK_UART_DIV13 was defined, but was never referenced in any upstream device trees.


That's incomplete definition of ABI

> Since there is no in-tree usage of `SCU0_CLK_UART_DIV13`, its removal does not cause an ABI break.


You ignored out of tree users. Please read carefully ABI docs.


> 
>>> #2. Change SOC0_CLK_HPLL_DIV_AHB to SOC0_CLK_AHBMUX Older
>> implement
>>> where `mpll_div_ahb` and `hpll_div_ahb` were **hardcoded dividers** for
>> AHB.
>>> In **the new approach (v8)**, I refactored the clock tree to clock tree.
>>
>> I still cannot parse sentences like "refactoring A to A". It's meaningless to me.
>>
>>> It should be ABI-safe change
>>
>> No, you do not understand the ABI. You removed a clock ID, that's the ABI
>> change.
>>
>> Otherwise explain how this is not changing ABI.
>>
>>
>>>
>>> Or you want to keep original SOC0_CLK_HPLL_DIV_AHB define and then add
>> SOC0_CLK_AHBMUX.
>>> To be 1st patch, then 2n patch remove redundant
>> SOC0_CLK_HPLL_DIV_AHB?
>>
>> If you break the ABI you need to clearly explain why. We have long
>> conversations and you still did not say why.
>>
> Sorry, my point will be following steps to avoid potential ABI issues, 
> I can modify the patch series as follows:
> 1. **Patch 1:** Add `SOC0_CLK_AHBMUX` without removing `SOC0_CLK_HPLL_DIV_AHB`.
> 2. **Patch 2:** Finally remove `SOC0_CLK_HPLL_DIV_AHB`.


I do not understand what changed here. You remove exported clock which
is ABI, so how is this answering my question.

You keep dodging my questions. Here I asked "why". I do not see any
answer why.

Best regards,
Krzysztof

