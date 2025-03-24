Return-Path: <linux-kernel+bounces-573263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1DBA6D4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DB1188DB1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D7B250C0F;
	Mon, 24 Mar 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHV52Z5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA418D65E;
	Mon, 24 Mar 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801002; cv=none; b=oWFiibHdnHyxxs5sK6k0U+WPM6qNvOLf6mbZVK9ja6UwCzpqsqm8aq+yfvV2BFxWxymblSQTAuJogkD/jUMYWOesMVO3RlkoVU8QdSaN0Vb/fn/T1PbDEZ1zS1OBqCGdGLlkNf09P2ladapzmOyGY2e2spKHX72owcLZ9Fu7Slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801002; c=relaxed/simple;
	bh=rpacFajQmnF5jVC9M6bEwsXc0x3PG4bR6WjOaYeWR3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQM/+TZm9YRCQ/8VFgD2Cu8Yi9R8IpND5iIg7LAaP6Ss+DhpTOcH0LGlkXsrkV5Mu7+B+GenKz1jDZc7cqvJTMCFlr2a8hApALnEVwuWNtcbN3Hkhjr/2XiwpQbGNaasX9Fw+JhJUfr/4oaB9pW4eOOV3pEKkIEXG7QCcakUSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHV52Z5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68FBC4CEE4;
	Mon, 24 Mar 2025 07:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742801001;
	bh=rpacFajQmnF5jVC9M6bEwsXc0x3PG4bR6WjOaYeWR3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WHV52Z5mueIEeKyjSCQE5yZvtpoepiA3LImk9pMIVARR6WRmQbCssqenJl+KtfIDL
	 e1WnKlpcLFOf9/PdXvXn5ukLUjrIgdtePi6q5jxxFpiBTe+bmLsJXuWF9+DOGXpAeE
	 85owSCBYk7xB9N3/LNfBaBajRoVcBurb6RP5PRJzgSX7V4IPk71xEdkQZ5ICtbcSd0
	 uhUbXJYw3pXc7zWAMOrzKkDDKKxIgKZNep9ql05q67ymmu391YMzQYvLi19jwrs2z0
	 u7aJsHYoQhLrcvYxOMqLcglQfPRRy25E0W9sz9Uram1aDm1hNFpi78yJ7/l/PauQgw
	 ZAEFgr3Uz9IDw==
Message-ID: <a2397c92-2884-4f4d-b036-808208892af5@kernel.org>
Date: Mon, 24 Mar 2025 08:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: bist: Add BIST dt-binding for TI
 K3 devices
To: Neha Malcom Francis <n-francis@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, u-kumar1@ti.com
References: <20241128140825.263216-1-n-francis@ti.com>
 <20241128140825.263216-2-n-francis@ti.com>
 <ho7ktcnbtl7mvamfthqho23co2fc4z7bgjha7pu4wivxm6ndhu@tfbpveonhckz>
 <837d329b-bcdd-4c3b-b508-e916b110ce25@ti.com>
 <e57dfc3e-b702-4803-b776-20c6dbd98fef@kernel.org>
 <8e58b093-1c64-45b9-a9d3-9835a3bbc4fd@ti.com>
 <1da4e402-62f3-4bad-9129-1f5a08148987@kernel.org>
 <f39d80fc-3600-4c2c-b09c-980288f86fa2@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f39d80fc-3600-4c2c-b09c-980288f86fa2@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 10:02, Neha Malcom Francis wrote:
> Hi Krzysztof,
> 
> On 19/03/25 13:16, Krzysztof Kozlowski wrote:
>> On 13/03/2025 12:14, Neha Malcom Francis wrote:
>>> Hi Krzysztof
>>>
>>> On 29/11/24 14:45, Krzysztof Kozlowski wrote:
>>>> On 29/11/2024 08:43, Neha Malcom Francis wrote:
>>>>>>> +
>>>>>>> +  power-domains:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  ti,bist-instance:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    description:
>>>>>>> +      the BIST instance in the SoC represented as an integer
>>>>>>
>>>>>> No instance indices are allowed. Drop.
>>>>>>
>>>>>
>>>>> Question on this, this is not a property that is driven by software but rather 
>>>>> indicates which register sequences have to be picked up for triggering this test 
>>>>> from this instance. So I don't see how I can workaround this without getting 
>>>>> this number. Or maybe call it ID rather than instance?
>>>>
>>>> I don't understand how the device operates, so what is exactly behind
>>>> some sequences of registers for triggering this test. You described
>>>> property as index or ID of one instance of the block. That's not what we
>>>> want in the binding. That's said maybe other, different hardware
>>>> characteristic is behind, who knows. Or maybe it's about callers... or
>>>> maybe that's not hardware property at all, but runtime OS, who knows.
>>>>
>>>
>>> Sorry for such a late reply, but I was hoping to get more details on
>>> this "ID" and never got back to the thread...
>>>
>>> The best way I can describe is this device (BIST) runs a safety
>>> diagnostic test on a bunch of processors/blocks (let's call them
>>> targets). There's a mapping between the instance of this device and the
>>> targets it will run the test. This ID was essentially letting the BIST
>>> driver know which are these targets.
>>
>>
>> So you want to configure some target? Then this is your property. If you
>> want to configure 'foo' difference in DT, you do not write 'bar'...
>>
> 
> So the difficulty in doing this is, what I mentioned in the earlier
> email just copying it over again:
> 
> "Yet another way would be the BIST points out the targets it controls via
> their phandles in its node... but this approach would trigger the probe

No, it would not. Which part of OF kernel code causes probe ordering
(device links) if some random phandle appears?

> of these targets before the test runs on them. And in hardware, the test
> must run only one before the device is used, else we see indefinite
> behavior."
> 
> Property that has a list of strings (targets) instead of phandles maybe?
> Would that be acceptable?



Best regards,
Krzysztof

