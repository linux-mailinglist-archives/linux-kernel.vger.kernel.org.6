Return-Path: <linux-kernel+bounces-177785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0A8C449A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317B9B2220B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A615445C;
	Mon, 13 May 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+xo1SsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BA154427;
	Mon, 13 May 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615516; cv=none; b=VDDRzd1PEfdU8Zak/hDmRhxw06D4wWcF05Wm0znB/quyxyBjsghdYQQu3wEeRWnK/9v9vYDMB26OD8Obq82dILynEmzNRPMjv1aGh/MWacCu4zCmpveZp+pNJMIqoF1lCpVryv8KCgtuwxt5qb/gBao/i8yRvC7FrNTSNJYy4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615516; c=relaxed/simple;
	bh=8dI/ebZzuVSd46EGsZIVX9qJ10BBglNLC/rRfmEYLmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpcYDoMo5duitDW/30wLvA0lwUaVfFb9bxHJ5cndJldlgboIZY3i0gVBbFoFCvWychsdD6RegTujWjWHZRUMZrSLxHXxbXR7EZcLAQE02icH/3ZWClJAyihq93wfMar1qDswxPsq93qZJlWiUXGKlOTEmrYcOE1jOxfKC3SWZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+xo1SsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A7C32782;
	Mon, 13 May 2024 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715615516;
	bh=8dI/ebZzuVSd46EGsZIVX9qJ10BBglNLC/rRfmEYLmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+xo1SsWE/bSPQ0qhDZl3DvC1o7yOyMUTU4WGKMMw/FO3pnCWbrlZFDwuuSn/ixji
	 6O3XNwURKgOK0PBto6YvTInxCrvKfGp/2xLQDW+v1GAGT1xKCaq65/rwV8Uz7sTeLa
	 Vs5Dpq9IL4kJzdber7Jfw8Sac8q/QVcTlGfy6n187TxwvfueliPoI8iEU6UjKTmN46
	 4gcrFZ+OdtkjKShI5LVXWQq/kWVUSp2bDJhbLv4QW27GaeLo5MRskrNd4f4plkFS58
	 z19rNBamJbmlCiwWn/MCfEgCxSB97G08ctY6DbU9wiLPCnL1qetM+/+/nxU8YTGYZg
	 js9ynnN9rBvNQ==
Date: Mon, 13 May 2024 10:51:54 -0500
From: Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v24 1/4] dt-bindings: reset: npcm: add clock properties
Message-ID: <20240513155154.GA2595523-robh@kernel.org>
References: <20240509192411.2432066-1-tmaimon77@gmail.com>
 <20240509192411.2432066-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509192411.2432066-2-tmaimon77@gmail.com>

On Thu, May 09, 2024 at 10:24:08PM +0300, Tomer Maimon wrote:
> Adding 25MHz reference clock and clock-cell properties to NPCM reset
> document due to the registration of the npcm8xx clock auxiliary bus device
> in the NPCM reset driver
> 
> The NPCM8xx clock auxiliary bus device has been registered in the NPCM
> reset driver because the reset and the clock share the same register
> region.

auxiliary bus is a Linux concept. The reasoning for this should be the 
reset block also provides clocks.


> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/reset/nuvoton,npcm750-reset.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> index d82e65e37cc0..18db4de13098 100644
> --- a/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm750-reset.yaml
> @@ -21,6 +21,13 @@ properties:
>    '#reset-cells':
>      const: 2
>  
> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: specify external 25MHz referance clock.

s/referance/reference/

> +
>    nuvoton,sysgcr:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: a phandle to access GCR registers.
> @@ -39,6 +46,17 @@ required:
>    - '#reset-cells'
>    - nuvoton,sysgcr
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - nuvoton,npcm845-reset
> +then:
> +  required:
> +    - '#clock-cells'
> +    - clocks

New required properties are an ABI break. Please justify why that's okay 
for this platform in the commit message (assuming that it is).

Rob

