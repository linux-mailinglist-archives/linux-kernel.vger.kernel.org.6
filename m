Return-Path: <linux-kernel+bounces-528586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF11A41961
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE73A4F65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CA3245039;
	Mon, 24 Feb 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhmrJpQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FF24501D;
	Mon, 24 Feb 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390092; cv=none; b=Aw5VjGvRY8IPaO7GCOlncx4/aAShxdfBsHCqnjOQHJBmacn2h8dRA0XsoJbCnsdS2v2zxkJisCV93qlzWG+6XBdRNqxRXV+DyvitRtcl62RVlz29J00o2UBELJIB5GtOJiCQTr6FTUPeR6CHpEqzzribRWMWPYiKlfm5JPXOauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390092; c=relaxed/simple;
	bh=K/BMaw7yksUW7asTY2fGFkaWht/cMbjJx1rTVr0UTP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMAgIMRP33L/wZ8kNxxELQO4sNH/nja7SNwkyaeOvSOmIKc28EJk663Ocr846d8w8Dj/XQwbuLLol6NYeg3nTuBDiuNnJVajSkPtXuDGLMEpiVDXgq+X/LszTbJnxSdU9EnIlRkTODZtI+iiq6xYKujghQ3OfyOzN1D8XXEb6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhmrJpQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1968C4CED6;
	Mon, 24 Feb 2025 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740390092;
	bh=K/BMaw7yksUW7asTY2fGFkaWht/cMbjJx1rTVr0UTP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KhmrJpQSqlbJvrog1f0QHlNyHDozd/5pew3gkhjaMJTlYGT1dzBQcpDRw+2p9FIy9
	 2s4YAtUkyEQJrSerisG7+sH5UJ5wmVt/YtRfMXCeDxnsbIZlxEhJIQstInwuBc4ZTP
	 v39bYkIaCO5hlX+4DgPv7tai36HwjkdHD6KsIgCNtRYsBCBWlqomWp45rP2SgXrlun
	 YG93mEu7sejdgpEfeiIyOL2ksJZ5oqdKEAhoF+2GWD5Q4RiQykZ1coUhVJjfYma2B3
	 NAYFriOCgVbjb3vzDNgGd2Ok0qMWCn6n3pudTyyFypOrY33ewo6We+XzuVMAYtnq9i
	 Imqk3pdx9QcrA==
Message-ID: <fa49d52f-0a55-4bce-8742-5b4f018c170c@kernel.org>
Date: Mon, 24 Feb 2025 10:41:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add rk3562 cru bindings
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241224092310.3814460-1-kever.yang@rock-chips.com>
 <krrqtjllx6akrurefbtuhgxw6bwmkiro5rtvdexoevjyufm2uz@r5biw7kbttyr>
 <23c84fd5-83f4-46b3-a247-56e4a2c06d1d@rock-chips.com>
 <3234236.fEcJ0Lxnt5@diego>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <3234236.fEcJ0Lxnt5@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/02/2025 10:05, Heiko Stübner wrote:
> Am Montag, 24. Februar 2025, 09:52:12 MEZ schrieb Kever Yang:
>> Hi Krzysztof,
>>
>> On 2024/12/27 16:25, Krzysztof Kozlowski wrote:
>>> On Tue, Dec 24, 2024 at 05:23:08PM +0800, Kever Yang wrote:
>>>> Document the device tree bindings of the rockchip rk3562 SoC
>>>> clock and reset unit.
>>>>
>>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>>>> ---
>>> A nit, subject: drop second/last, redundant "bindings". The
>>> "dt-bindings" prefix is already stating that these are bindings.
>>> See also:
>>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>>>
>>>
>>> s/rk3562/Rocchip RK3562/
>>> or whatever your proper name is (and use proper capitalized parts of
>>> products)
>> Will update.
>>>
>>>> +properties:
>>>> +  compatible:
>>>> +    const: rockchip,rk3562-cru
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#clock-cells":
>>>> +    const: 1
>>>> +
>>>> +  "#reset-cells":
>>>> +    const: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 2
>>>
>>> Why clocks are not required?
>> The cru is the clock-controller, which is always on module in SoC,
>> so we don't need to enable "clock" for this clock-controller.
> 
> hmm, shouldn't clocks be
> 
>   clocks:
>     minItems: 1
>     maxItems: 2
> 
> The CRU _needs_ the xin24m because that is the main oscillator
> supplying everything, but _can_ work work without xin32k .
> 
> Sidenote: itseems we're doing this wrong on rk3588


Kever responded to a review 2 months ago. None of these emails are in my
inbox anymore. All context is gone as well.

No, I expect the comments to be applied full in such case. This is a bit
ridicilous  that now I need to look for that email somwhere to check
whether implementation follows received response. Response after 2 months!



> 
> Heiko
> 
> 


Best regards,
Krzysztof

