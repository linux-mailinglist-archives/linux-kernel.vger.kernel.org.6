Return-Path: <linux-kernel+bounces-277332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA0949F60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9396C1C23272
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327619752C;
	Wed,  7 Aug 2024 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1TKo++0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A16BFA3;
	Wed,  7 Aug 2024 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009774; cv=none; b=m2AclW8Icqvw+qODt4C90jn7sqLcTyw5/so+AFOGkjbRxytR9nednn/MI8SevbxRCw0oLWRG89ISwFlum3NhCSCaRJVN6yhY7r9MipzrI/A3neu5E+ORO3aCCYkvK4nGVpbUE9adIFvNXXjgC6y4nS2QchiuEnGv+gTTXzPh+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009774; c=relaxed/simple;
	bh=NfrOBcjO/1edtJr1f92xqBL5hzAd7ZcuUUv/ggnDR9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8ihSW43EZVb19NelqRicd6Yr4pO7cdgT8e25ixtzuZlxfEFXPWdi4MMkGgIBupfGsUlSeLcBRLgCpixBzOEeprytzKSpPo/GRFlL8SAC2Tq2aVuKLSwmj0qkfmqaFQ/pJX6g5HH8M+98neVLjIqH2YXLoElINrgRX9nFuSHS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1TKo++0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E926C32782;
	Wed,  7 Aug 2024 05:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723009774;
	bh=NfrOBcjO/1edtJr1f92xqBL5hzAd7ZcuUUv/ggnDR9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m1TKo++0oG4AuvFgbcX7Zd8lsvYZaSD5VQREoYuRyBL9UOmMw8NaTjxEXZ8E6Mxp/
	 M23nhWPGk+9QsPjZWRZWVq0pSveUuu8MCFTHwEZr41luoWO28Zgawm7f1UyJDUjT3Z
	 VeG1qrEi3eHrQlCSaQmkEAZ175EHtvzSdbTeO1PWy7p/S2wZ4vabV/KLy2ZZyer6Ze
	 Gd1eAZN4zSd7REZJDZTZQqSbgwX1ZdDHMrPdKBYBDXCSELrxovpExoA2Jzwxmacgz5
	 JjbfP45q3uuwOOibgDaewyPgAYamRzyr3+Bksk53uK0FC46DxVJpbS/SxnWOrgeqqQ
	 cm5/vnS8qjzoA==
Message-ID: <03b8a48c-e97e-4d7b-8378-66cc55ed56f7@kernel.org>
Date: Wed, 7 Aug 2024 07:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: rockchip: Add dt-binding header for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Sugar Zhang <sugar.zhang@rock-chips.com>
References: <20240802214053.433493-1-detlev.casanova@collabora.com>
 <20240802214053.433493-3-detlev.casanova@collabora.com>
 <1600ee06-ac19-436f-8229-1bb44b29c683@kernel.org>
 <2949191.e9J7NaK4W3@trenzalore>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2949191.e9J7NaK4W3@trenzalore>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 17:23, Detlev Casanova wrote:
> On Sunday, 4 August 2024 05:53:57 EDT Krzysztof Kozlowski wrote:
>> On 02/08/2024 23:35, Detlev Casanova wrote:
>>> From: Elaine Zhang <zhangqing@rock-chips.com>
>>>
>>> Add the dt-bindings header for the rk3576, that gets shared between
>>> the clock controller and the clock references in the dts.
>>>
>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
>>> [rebased, separate clocks and resets]
>>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patche
>> s.html#i-for-patch-submitters
>>> ---
>>>
>>>  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 589 ++++++++++++++++++
>>>  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 484 ++++++++++++++
>>>  2 files changed, 1073 insertions(+)
>>>  create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
>>>  create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h
>>
>> These are bindings. Must be squashed with previous patch.
> 
> Ok, so you'd rather have a commit for reset definitions (dt-bindings: reset: 
> Add rk3576 reset definitions) and another one for clock definitions + 
> Documentation (dt-bindings: clock: Add rk3576 clock definitions and 
> documentation) ?
> 
>>> diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h
>>> b/include/dt-bindings/clock/rockchip,rk3576-cru.h new file mode 100644
>>> index 0000000000000..14b54543d1a11
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
>>> @@ -0,0 +1,589 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>
>> Weird license. Why not using recommended one?
> 
> Oh right, I suppose "GPL-2.0 OR MIT" is better ? At least that is what I see 
> for rk3588. include/dt-bindings/clock/rockchip,rv1126-cru.h uses "GPL-2.0+ OR 
> MIT" though.
> 
>>> +/*
>>> + * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
>>> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
>>> +#define _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
>>> +
>>> +/* cru-clocks indices */
>>> +
>>> +/* cru plls */
>>> +#define PLL_BPLL			1
>>> +#define PLL_LPLL			3
>>> +#define PLL_VPLL			4
>>> +#define PLL_AUPLL			5
>>> +#define PLL_CPLL			6
>>> +#define PLL_GPLL			7
>>> +#define PLL_PPLL			9
>>
>> Nope, indices start from 1 and are incremented continuously.
> 
> Why start at 1 ? RK3588 starts at 0 for clocks and resets

Or 0, even better, sure.

Best regards,
Krzysztof


