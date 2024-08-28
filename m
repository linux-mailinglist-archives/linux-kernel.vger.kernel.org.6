Return-Path: <linux-kernel+bounces-304633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE980962301
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201651C22116
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FDC15E5C0;
	Wed, 28 Aug 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frlLQMiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2C15C14F;
	Wed, 28 Aug 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836122; cv=none; b=csmbj8eF0k1GRFupOJfbLnpbtQZ3RgKaJBor4blRHnt884vFzr3uEOQKWABNL1WWGR4H3u8C3m3fQcYw6MCl7Vf7jPfXDIKNsiHJ6f87gjnnsB7DSPERj5ETDNDY+LyEOo2WFWeR+TIDnyhan+VYQJQNXy0YHrpOXtJPA5eHU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836122; c=relaxed/simple;
	bh=T9+UPkiHdOSPmSX/60spyttQMin9/8OW+10mi+SdMFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzgLmnSoswSvL7vQjGQQLU41spo4mZBU1t4uIByzww+CpgDd5NU7md/rohw3nG5DCqj8sLTUH1qLZ8iUiVQE8C4/8HeYnAV/FxnRUgVxR/eLpCjORCxo5ujrBy/3TG4AE+HA181TTgdKu3Z4qLRxdj8X+u9xds/gMmhTTYsyP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frlLQMiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF946C8403B;
	Wed, 28 Aug 2024 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724836121;
	bh=T9+UPkiHdOSPmSX/60spyttQMin9/8OW+10mi+SdMFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=frlLQMiWouw88VzoZNjJZV2KjpobUVwczNzvsO56jI8Im8umluEi/+GyFzYwkm4wJ
	 xG7Sc+4fw+JuRxqHNftuJ12rrEWHkhsyg+/ht+WmmLLQ31+F0rYQcR9gCW6nTC4ywT
	 HAKHMxLJnO+EtwtDt1CohL42Fk2UNriNvQ05Hodk2uAOpZk01Ns7e9bLTJ31GzBiEg
	 Wxo4igQk+XVGWVAE8kib9dRbr5MPZaDeGeGjb1ax1h/44H+YTw1llVioPpdB92VkGk
	 01jQwgWkdIVMter6fL5ByFiBd+MweXaa7jQT9va4d/oVIwd4XqXzAtoDEtsZuOvvcN
	 ket4RQAPtwODQ==
Message-ID: <9180e80b-f464-4a84-8c58-35383beec637@kernel.org>
Date: Wed, 28 Aug 2024 11:08:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] arm64: dts: apple: add "brcm,bcm4329-fmac"
 fallback compatible
To: Jacobe Zang <jacobe.zang@wesion.com>, marcan@marcan.st,
 sven@svenpeter.dev, alyssa@rosenzweig.io, robh@kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org
Cc: linux-rockchip@lists.infradead.org, dsimic@manjaro.org,
 conor+dt@kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, nick@khadas.com
References: <20240828033953.967649-1-jacobe.zang@wesion.com>
 <20240828033953.967649-3-jacobe.zang@wesion.com>
 <22aaf58a-da71-44c7-acd7-f3e70b91cdfd@kernel.org>
 <c5047173-d569-42d4-9676-4679100da118@wesion.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c5047173-d569-42d4-9676-4679100da118@wesion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2024 08:13, Jacobe Zang wrote:
> 
> 
> On 2024/8/28 13:56, Krzysztof Kozlowski wrote:
>> On 28/08/2024 05:39, Jacobe Zang wrote:
>>> Broadcom driver need to check "brcm,bcm4329-fmac" compatible. Before
>>
>> What for?
>>
> 
> It matches the changes in the other series that I sent.

Commit msg did not explain this at all. Anyway, then bindings should
provide proper rationale without referring to "driver" as the reason.

> 
>>> PCIe devices used PCI ID as base compabile so add it as fallback
>>> compatible to pass the check.
>>>
>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>> ---
>>>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 2 +-
>>>   arch/arm64/boot/dts/apple/t8112-j413.dts  | 2 +-
>>>   arch/arm64/boot/dts/apple/t8112-j493.dts  | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>>> index 5988a4eb6efaa..4b021626d4692 100644
>>> --- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>>> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>>> @@ -72,7 +72,7 @@ hpm1: usb-pd@3f {
>>>   &port00 {
>>>   	bus-range = <1 1>;
>>>   	wifi0: network@0,0 {
>>> -		compatible = "pci14e4,4425";
>>> +		compatible = "pci14e4,4425", "brcm,bcm4329-fmac";
>>
>> So devices are not compatible, but your argument is that driver needs to
>> do something here? That's not enough.
>>
> Before this change, the check of "brcm,bcm4329-fmac" compatible is set 
> at the end of probe function for SDIO devices which need IRQ. But after 
> this change I set it to the top as the first check. So I add this 
> fallback compatible to the Apple's DTS.

You are not listening, I think, and still keep talking about driver. It
has nothing to do. Fix your driver.

> 
> Oh..I got what you mean. Maybe my commit message is not clearly. It is 
> no need to mention driver in it. Because the intent of adding the 
> "brcm,bcm4329-fmac" compatible is to conform to the bindings.

Explain the hardware, not the driver. DTS represents hardware, not drivers.

Best regards,
Krzysztof


