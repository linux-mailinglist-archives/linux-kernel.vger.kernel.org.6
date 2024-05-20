Return-Path: <linux-kernel+bounces-183958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A192A8CA094
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C82D1F217A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90713792E;
	Mon, 20 May 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVIH+1ZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B220EB;
	Mon, 20 May 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221764; cv=none; b=HTgXyoKnLjiXP0wncfNH2Z38PwR6gFzss/KqR6+Ylg6/89RmLDxyXClCn+85MNJRKZI35brYl54JCa3DTFgwJ4fSFkvxo9NEFgmLJ/xHXQ1OLXOADeTpXpwiF1kpUp2uGhj0dd82736EVLglfecOc9WLM28E5Dek4op8dpf0yDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221764; c=relaxed/simple;
	bh=UOi1n2UYMr/FQbVKWQcyqklCKnrURV8Jm+y0d+1xmXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOoMKyPAPg8a9VgiMjSnQwnyV1daJ3KvI5CZdHuiEiDhSTF0B9vrXyvmQalUbIB06SC+VbPxjZQQkWBzLUfpBPkwJRRDHoRdeVWMNYSbxdMrPcJyH12LTa2m88jNXEgRH+kp3PGlx70HWhWwu184yvF2Onoi9d9jqjPb7OcW8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVIH+1ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BCFC2BD10;
	Mon, 20 May 2024 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716221763;
	bh=UOi1n2UYMr/FQbVKWQcyqklCKnrURV8Jm+y0d+1xmXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVIH+1ZKPc7nCIgzITvynSYYWTuhtNjvapabvfzI39kdCUv/cP4aImgHpSanyEI85
	 fc0TB8ke+DtxyB2CtlKbVnrDZ+ddR8fPUrDgiu1uANtDlzM7XYr/LabR/5B7Owbk9B
	 4hWwZd/6EdR6d5bT8cObim94znIZbhwjsgTCCHrNHbap8pX+INKZ4MMCPgO7PIan7o
	 hDxrSRyQfKhn+fdEOfUX72EyR2VWY0B4ikj9one8DIBkv4VQ6jLc7h/YSffPOXtIrt
	 0+kuwP0OcIO4tSATpnsSyiEcc58emRDd1LfmGCTInzD7GPHZ57rqhnUe52uXrVT0eP
	 VBwc46NopDv5A==
Date: Mon, 20 May 2024 11:16:02 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible
 string for i.MX95
Message-ID: <20240520161602.GA733483-robh@kernel.org>
References: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
 <1715656329-8061-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715656329-8061-2-git-send-email-shengjiu.wang@nxp.com>

On Tue, May 14, 2024 at 11:12:08AM +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.
> 
> The difference between each platform is in below table.
> 
> +---------+--------+----------+--------+
> |  SOC	  |  PHY   | eARC/ARC | SPDIF  |
> +---------+--------+----------+--------+
> | i.MX8MP |  V1    |  Yes     |  Yes   |
> +---------+--------+----------+--------+
> | i.MX93  |  N/A   |  N/A     |  Yes   |
> +---------+--------+----------+--------+
> | i.MX95  |  V2    |  N/A     |  Yes   |
> +---------+--------+----------+--------+
> 
> On i.MX95, there are two PLL clock sources, they are the parent
> clocks of the XCVR root clock. one is for 8kHz series rates, named
> as 'pll8k', another one is for 11kHz series rates, named as 'pll11k'.
> They are optional clocks, if there are such clocks, then the driver
> can switch between them to support more accurate sample rates.
> 
> As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4'
> for clocks and clock-names properties.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 55 +++++++++++++++----
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> index 0eb0c1ba8710..70bcde33e986 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> @@ -22,6 +22,7 @@ properties:
>      enum:
>        - fsl,imx8mp-xcvr
>        - fsl,imx93-xcvr
> +      - fsl,imx95-xcvr
>  
>    reg:
>      items:
> @@ -44,18 +45,12 @@ properties:
>      minItems: 1
>  
>    clocks:
> -    items:
> -      - description: Peripheral clock
> -      - description: PHY clock
> -      - description: SPBA clock
> -      - description: PLL clock

Leave these here and add pll8k and pll11k.

> +    minItems: 4

Keep this.

> +    maxItems: 6
>  
>    clock-names:
> -    items:
> -      - const: ipg
> -      - const: phy
> -      - const: spba
> -      - const: pll_ipg
> +    minItems: 4
> +    maxItems: 6

Same here.

>  
>    dmas:
>      items:
> @@ -97,6 +92,46 @@ allOf:
>        properties:
>          interrupts:
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx95-xcvr
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Peripheral clock
> +            - description: PHY clock
> +            - description: SPBA clock
> +            - description: PLL clock
> +            - description: PLL clock source for 8kHz series
> +            - description: PLL clock source for 11kHz series
> +          minItems: 4
> +        clock-names:
> +          items:
> +            - const: ipg
> +            - const: phy
> +            - const: spba
> +            - const: pll_ipg
> +            - const: pll8k
> +            - const: pll11k
> +          minItems: 4

Drop all this.

> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Peripheral clock
> +            - description: PHY clock
> +            - description: SPBA clock
> +            - description: PLL clock
> +        clock-names:
> +          items:
> +            - const: ipg
> +            - const: phy
> +            - const: spba
> +            - const: pll_ipg

And for this case, you just need 'maxItems: 4'.

Rob

