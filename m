Return-Path: <linux-kernel+bounces-548358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873DA543DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606B83A6855
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0CD17C98;
	Thu,  6 Mar 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIQkT5GY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F9184E;
	Thu,  6 Mar 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246985; cv=none; b=enTBCuLHn4H4zdBCSxiGZJvDeAdN6COcdiFvWOCcFzcwaUazjMq6+rChFysZaQQwUsHzu41o/ErlazeOEmaiWhQ7h6WEhuxC+1Gb5h/oW0IZ+jtTLbn1Atyy+CYD/A1980DZX2BdbYAuTwztVYBC8XaSOmUAfkAqEtkbo8B7+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246985; c=relaxed/simple;
	bh=VCgbyCzqfls1y5Bd7zorPMjDYWw8WmCCGOmt74/Sv/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIA3hCVYnCuQZgB4ufOmXInfl9FLOMJ+PyZX/RYA1JAKKn4L5dD4kYDxb0o2saXaD6dqELdyc/BQdrv3E9h2/8SCrxfiUO2BCWayGjZfIdBJInZ3hTMBHZIKZe6jwGu1ciuIgx91BZfUPML2SNLQAhWSJLL2YCO224dSnCmngXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIQkT5GY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CB9C4CEE0;
	Thu,  6 Mar 2025 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741246985;
	bh=VCgbyCzqfls1y5Bd7zorPMjDYWw8WmCCGOmt74/Sv/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oIQkT5GYdjTm856f2+s4bNtGI2PyU8lQCFOICAeutx+q4rjfuoU7MCD4r9Pdsz8s+
	 dVt1JCnCVK+zgMDpUhWoWe7HcDYea3GQL6Mx4D7QjMWXlrXNMJk3iXPnvep/g02w4c
	 V4KooCVrAt/skqiniHAN5uee6IV+cEDMgxjWyzvXrrEkcJnrn2GFs2Fw/UlchHYmER
	 NhGriQYQBGETg4rl3CucIYOT/SMq0ZXFz+CJlSI2zyS+NM4xEh3LGlnP/LApHwD+nd
	 bJGNU24o7IrHodjMVfRrD3t8/SZA/2qHO9WTnQBNUKso5YGmWTQ5Q42mOUt0UcE9Bc
	 w+WcwuBRZug0A==
Message-ID: <ffd6287c-cbfd-4ba8-9332-45bad4e60583@kernel.org>
Date: Thu, 6 Mar 2025 08:42:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] ASoC: dt-bindings: add schema for rockchip SAI
 controllers
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
 <20250305-rk3576-sai-v1-3-64e6cf863e9a@collabora.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250305-rk3576-sai-v1-3-64e6cf863e9a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2025 22:24, Nicolas Frattaroli wrote:
> Rockchip introduced a new audio controller called the "Serial Audio
> Interface", or "SAI" for short, on some of their newer SoCs. In
> particular, this controller is used several times on the RK3576 SoC.
> 
> Add a schema for it, with only an RK3576 compatible for now. Other SoCs
> may follow as mainline support for them lands.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../devicetree/bindings/sound/rockchip,sai.yaml    | 151 +++++++++++++++++++++

Filename based on compatible.

>  MAINTAINERS                                        |   6 +
>  2 files changed, 157 insertions(+)
> 

...

> +
> +  dma-names:
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - const: tx
> +      - const: rx
> +      - items:
> +          - const: tx
> +          - const: rx

Why all combinations are possible?

> +
> +  clocks:
> +    items:
> +      - description: master audio clock
> +      - description: AHB clock driving the interface
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +      - const: hclk
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +    description: resets for the mclk domain and ahb domain

List the items instead with description and minItems: 1.

> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: m
> +      - const: h
> +
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  rockchip,sai-rx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Defines the mapping of the controller's SDI ports to actual input lanes,
> +      as well as the number of input lanes.
> +      rockchip,sai-rx-route = <3> would mean sdi3 is receiving from data0, and
> +      that there is only one receiving lane.
> +      This property's absence is to be understood as only one receiving lane
> +      being used if the controller has capture capabilities.
> +    maxItems: 4
> +    items:
> +      enum: [0, 1, 2, 3]
> +
> +  rockchip,sai-tx-route:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Defines the mapping of the controller's SDO ports to actual output lanes,
> +      as well as the number of output lanes.
> +      rockchip,sai-tx-route = <3> would mean sdo3 is sending to data0, and

I understand this is only example because = <3> would not be allowed
(test it).

> +      that there is only one transmitting lane.
> +      This property's absence is to be understood as only one transmitting lane
> +      being used if the controller has playback capabilities.
> +    maxItems: 4
> +    items:
> +      enum: [0, 1, 2, 3]
> +
> +  rockchip,always-on:
> +    type: boolean
> +    description:
> +      The hardware requires this controller to remain turned on.

How hardware requires this? You rather miss proper PM domain handling or
some other resources.

> +
> +

Just one blank line.

> +required:
> +  - compatible
> +  - reg
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - clock-names
> +  - "#sound-dai-cells"
> +
> +unevaluatedProperties: false



Best regards,
Krzysztof

