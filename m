Return-Path: <linux-kernel+bounces-311639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B16968B71
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E885A1C229EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC11A2639;
	Mon,  2 Sep 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWuDi0lf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5141CB512;
	Mon,  2 Sep 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292827; cv=none; b=qMvVWHXZJiNglpPI2ekg/dN+zlfs/Ijd+GTZoJSAlsZ4vaK6AsVFzqTWxMG/oISHJc5agVFR0H9J5OpYriIiLWIsdCi60W+35m3zdC3qUkKsh2RO6zcYG/+QPIBtomjz9+Gdl4SOZgd6L6W6V90D7FCLw2VykSjrK5+ehgoAYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292827; c=relaxed/simple;
	bh=rmax+sHluXuQRSV9il3QO6Srk5sL18Fdd6bxpT9Ycew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPtXcuVqzxu+GawDTCsOY67LmtE09pp6i0eXabgOFK0xDY/zqeLzXszUeYXhyCE1Lr6DKWCN37qdmSWKDUfWoUZF5GiRYT10w8y7lQmS8tonHEJSMnkJHyNiz2hy7rLdLRt+aJy/6orDfSEDrJgqTBFulcd3l0q8BfgWnkC7JxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWuDi0lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0517BC4CEC2;
	Mon,  2 Sep 2024 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725292826;
	bh=rmax+sHluXuQRSV9il3QO6Srk5sL18Fdd6bxpT9Ycew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qWuDi0lfzCOdMYJ5vEWmLa0H1lN3sbwccxQ75HP6/Bt3tb0BhbjY/yjDuiMdXzwjr
	 uAVIgnhFPCXPTxdHO3vxpob1GfdY06WdIrOfcX9KxadM56aA3t4BHHhng1MiK8vzu1
	 lGdLfluP/S7utQy7vOukgZmgd8m74zHDvJXsNQbojEYORIJ1bm/vW0BmGaZaU0z9Yg
	 bmBADaeHbQASsBLRdS7PQHw1B5xuYHHcnlDcv5Hu6PaCqbKizenDgPL9Hc1CPblKpo
	 bmcBQmBw9yHA+xunUxcWSA5zo9h+ibnNjEsXPNVNidFxjw5IfCr5lWkSIWuiNxc2Fo
	 y+Ggs+L/wq/3Q==
Message-ID: <470a9ca2-93b6-44e3-865c-9d425f4df8dc@kernel.org>
Date: Mon, 2 Sep 2024 18:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ARM: at91: Document Microchip SAMA7D65
 Curiosity
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Dharma Balasubiramani <dharma.b@microchip.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Romain Sioen <romain.sioen@microchip.com>,
 Ryan Wanner <Ryan.Wanner@microchip.com>,
 Varshini Rajendran <Varshini.Rajendran@microchip.com>
References: <20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com>
 <eb96bcf2-8bcd-4801-b381-96583d733b87@kernel.org>
 <7a4160cf-d170-4bbd-a4bc-da69c2c43d55@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7a4160cf-d170-4bbd-a4bc-da69c2c43d55@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 17:10, Nicolas Ferre wrote:
> On 31/08/2024 at 15:38, Krzysztof Kozlowski wrote:
>> On 29/08/2024 11:57, Dharma Balasubiramani wrote:
>>> From: Romain Sioen <romain.sioen@microchip.com>
>>>
>>> Document device tree binding of the Microchip SAMA7D65 Curiosity board.
>>>
>>> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>>> index 82f37328cc69..8e897680d43a 100644
>>> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>>> @@ -174,6 +174,13 @@ properties:
>>>             - const: atmel,sama5d4
>>>             - const: atmel,sama5
>>>
>>> +      - description: Microchip SAMA7D65 Curiosity Board
>>> +        items:
>>> +          - const: microchip,sama7d65-curiosity
>>> +          - const: microchip,sama7d65
>>> +          - const: microchip,sama7d6
>>> +          - const: microchip,sama7
>>> +
>>
>> No. This must go with the DTS.
>>
>> It's second patch you sent entirely split from the rest. That's not how
>> upstreaming of DTS and drivers work.
> 
> Krzystof,
> 
> We have been upstreaming sam9x75 SoC and now are trying with sama7d65 
> SoC using a different approach.
> 
> It was mentioned to us to reduce the number of patches sent in a series, 
> convert the remaining DT bindings from txt to yaml (we had quite a few), 
> avoid generating new errors from the DT bot when sending new .dtsi/dts 
> files... So we're trying to comply to these (valid) requirements... But 
> well, it's not easy and I would like to emphasize that we are doing our 
> best to address most of the (sometimes contradictory) challenges.

I understand.

> 
> So now, we're trying to be very minimal in what we're sending. Address 
> peripherals incrementally with trying to generate as few DT check errors 
> as possible. Trying this, we're facing chicken and eggs problems: How to 

That's fine.

> comply to a binding that is not yet accepted? How to organize 
> introduction of a new SoC with a limited number of patch in a series? 
> How to convert bindings to yaml and still be able to add new SoCs?

Before I answer to above, let me just clarify that patch here is not
related to this problem. You are not converting bindings here, you are
not fixing dtbs_check errors.

At least as far as I understood.

This is binding for new board (new DTS). All of such bindings should
come with the board DTS. Especially that they will physically go via
same branch of maintainer's tree. That's why combing this bindings patch
with DTS patch does not result in any new warning.

Now if you ask about organizing patches, then guideline from me:
1. Send device bindings with device driver changes to respective
maintainers. Each is separate patchset.
2. Another patchset: Send bindings going through SoC maintainer with new
DTSI and DTS. Provide link lore link to the bindings, if feasible.

> Be sure that we have been coordinating internally to be ready and send 
> these patch series together. We're a team and are splitting the 
> workload, I believe that it should be possible.
> I feel that upstreaming a SoC is becoming overly difficult, and I added 
> quite a few to Mainline throughout the years.
> 
> Can you please let us post this minimal set of patch series, give you 
> the needed information and cross-reference links, but also understand 
> that we're adding pieces of a big puzzle that would require a bit of 
> flexibility?

Sure, I am flexible here. But you posted:
1. Device bindings separate from the drivers, which is just wrong and it
does not bring you anywhere. It only creates confusion and additional
effort for maintainers, because they need to review separate bindings
from drivers.

2. DTS board bindings without DTS. There is no single explanation for
this, no benefit, no reason to do that way.

Best regards,
Krzysztof


