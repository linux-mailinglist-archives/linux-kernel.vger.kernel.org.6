Return-Path: <linux-kernel+bounces-399707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2124D9C0330
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D964E28604C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEE1F1303;
	Thu,  7 Nov 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8tB6yZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAB1EE024;
	Thu,  7 Nov 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977356; cv=none; b=K4pyyE8yS60iTjhuc9GIlp0ygUEoDPysZMXpio4SOCWkOW9IxITrYcYs3mfErrC8RLiGmNJ2fjl2daE3zDMdVSUtCmpdo4N6zXcOaSQlM9zdydo/UuOw3gG0BTWudop/0z/uehG0AII+GMK/uWkDJ5To2W3h0LFlPTqo82SN73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977356; c=relaxed/simple;
	bh=XPXzTBydfU0tNU9z2BgGa6DkHPQcDioWlU+fnXhanAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y359MTRV2GDhKtcQwx/2p15ovNIb1NNCghdDes/J9oO7r8J+HoP1G5UvUj1fyOwRG/2vA39fmT0FVa7SxVs/5XeLcLzu443QB1vl6uDk/CfzTilaTnmPvp6WnDJkycts9umbtZCkD86bw/kUgacyv8HsvIRqHP6fqrhG7gUrHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8tB6yZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1BDC4CED0;
	Thu,  7 Nov 2024 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730977355;
	bh=XPXzTBydfU0tNU9z2BgGa6DkHPQcDioWlU+fnXhanAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8tB6yZ258syUr1ek0tZTtb+RurPUY+6mR2sE7oxFqCjYJtywTKHCgYnfD0eYt8mw
	 GqgjRReTXPy3/m+SWUedidkbZRT/BYIdtaPeVo5wuHSmpg6uJmoPzOIKIEMr4PXB8x
	 iKFoboncs9qeaL1Nxe7dlszu8WyV5hsUPztKea8g9rCpeXKjiVW4VZe1ETnAEdTKQH
	 SeFG4JLYW3UVvFJtZUOTxdTEuPKu8NeqgXhznJDriEYHqgrN+etpVmaXuulaBpjPQB
	 pzOH3d/HDqzIkLOg1Q+xQDUI4BnKgzIxC4tkDSx+4MhrjBQmxywSAE+nnCaLiQDRce
	 r5GgHUzJIyYOQ==
Date: Thu, 7 Nov 2024 12:02:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: add stm32mp25 support for i2s
Message-ID: <ynddlgloyliun6eiiep2ry6l5h2uqu7ujkusrptpqe74nvan7t@j44ltlokati3>
References: <20241106152528.939232-1-olivier.moysan@foss.st.com>
 <20241106152528.939232-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106152528.939232-2-olivier.moysan@foss.st.com>

On Wed, Nov 06, 2024 at 04:25:27PM +0100, Olivier Moysan wrote:
> Add STM32MP25 support for STM32 I2S peripheral,
> through "st,stm32mp25-i2s" compatible.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/sound/st,stm32-i2s.yaml          | 60 +++++++++++++++----
>  1 file changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> index 8978f6bd63e5..8f08f1f28a1b 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> @@ -13,13 +13,11 @@ description:
>    The SPI/I2S block supports I2S/PCM protocols when configured on I2S mode.
>    Only some SPI instances support I2S.
>  
> -allOf:
> -  - $ref: dai-common.yaml#
> -
>  properties:
>    compatible:
>      enum:
>        - st,stm32h7-i2s
> +      - st,stm32mp25-i2s
>  
>    "#sound-dai-cells":
>      const: 0
> @@ -28,18 +26,12 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: clock feeding the peripheral bus interface.
> -      - description: clock feeding the internal clock generator.
> -      - description: I2S parent clock for sampling rates multiple of 8kHz.
> -      - description: I2S parent clock for sampling rates multiple of 11.025kHz.
> +    minItems: 2

Keep old list and just add minItms here

> +    maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: pclk
> -      - const: i2sclk
> -      - const: x8k
> -      - const: x11k
> +    minItems: 2

Ditto

> +    maxItems: 4
>  
>    interrupts:
>      maxItems: 1
> @@ -79,6 +71,48 @@ required:
>    - dmas
>    - dma-names
>  
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32h7-i2s
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: clock feeding the peripheral bus interface.
> +            - description: clock feeding the internal clock generator.
> +            - description: I2S parent clock for sampling rates multiple of 8kHz.
> +            - description: I2S parent clock for sampling rates multiple of 11.025kHz.

Instead: minItems: 4

> +
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: i2sclk
> +            - const: x8k
> +            - const: x11k

ditto

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp25-i2s
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: clock feeding the peripheral bus interface.
> +            - description: clock feeding the internal clock generator.

instead: maxItems: 2

> +
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: i2sclk

ditto

Thanks to this you keep the lists synchronized between variants - they
share the items.

Best regards,
Krzysztof


