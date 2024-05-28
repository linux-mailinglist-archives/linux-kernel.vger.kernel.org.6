Return-Path: <linux-kernel+bounces-192645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D51788D201C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C92BB21A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C6171670;
	Tue, 28 May 2024 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUCcJuLj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154B16F8E0;
	Tue, 28 May 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909338; cv=none; b=HXdCEzHXxhXa3CMmuSH79SlUqlO5DMaNlZ7YTNaM5sJ6o/hM08XSdmTFxm7L5MwHsnj72W1TglUs7K9xDLj2A3xxaIj7GaO/waEys+VMKuXmhr+4k/rnjkTvHJupgvcvZ0xMPEJveelmO1HaTkUVmnTOKJMUuko9AlCx/4kL10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909338; c=relaxed/simple;
	bh=xpk0Yqw/VN8ddEnECwmM/UpM6KoNoPvI14IHu2eBrJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIyBRhm3TmB621C25NPIypzskWUl7To6lqIXaWZ/s87vG/A9MVxJbSJsO0lR1f4heFd8gmmy06uwmgifOwq7BTws7zX9znVQ0YvmXS7t3MhAlIeGwF2sXxE4wx/R44aM9Z3pNYg+FNlnfqQJgX1SlmLXyYQG6uetpuO+UELKpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUCcJuLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942F9C3277B;
	Tue, 28 May 2024 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716909337;
	bh=xpk0Yqw/VN8ddEnECwmM/UpM6KoNoPvI14IHu2eBrJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUCcJuLjneqe7FsY8PDzBO8l6FMtnMWAfv87RASRNOn7ANCjpyTOCQZHUK1hT0ig2
	 6B8fVVMjnGid5Z1MERtu5+/uuCMrqzvGKzWVgyuK7/U7zOtQH5qc+wywSAG3cokDKX
	 yv20Iz5vrXsx1n19nf9LXAx1T/uoIJA9hWwBrHU19WulFHEsUnTLyUZ1CABB+XaZzC
	 2d/GYyyoaPLkTIkHMFf6WVDQ5y0ScYlfjJbkGlTNXzAJ1+ZnT2F0F+lj2jZ+BYIV8E
	 gBq03xNbxHelWp5K2URHJuTM6b/mG6uRgHfrEUhHnOlx2fS1p1a3sY/0AY5GiTNnjJ
	 wlbxl/nHstHPg==
Date: Tue, 28 May 2024 10:15:36 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible
 string for i.MX95
Message-ID: <20240528151536.GA275498-robh@kernel.org>
References: <1716286416-17621-1-git-send-email-shengjiu.wang@nxp.com>
 <1716286416-17621-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716286416-17621-2-git-send-email-shengjiu.wang@nxp.com>

On Tue, May 21, 2024 at 06:13:35PM +0800, Shengjiu Wang wrote:
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
> As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> clocks and clock-names properties.
> 
> On i.MX95, the 'interrupts' configuration has the same constraint
> as i.MX93.
> 
> Only on i.MX8MP, the 'resets' is required, but for i.MX95 and i.MX93
> there is no such hardware setting.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> index 0eb0c1ba8710..d1dcc27655eb 100644
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
> @@ -49,6 +50,9 @@ properties:
>        - description: PHY clock
>        - description: SPBA clock
>        - description: PLL clock
> +      - description: PLL clock source for 8kHz series
> +      - description: PLL clock source for 11kHz series
> +    minItems: 4
>  
>    clock-names:
>      items:
> @@ -56,6 +60,9 @@ properties:
>        - const: phy
>        - const: spba
>        - const: pll_ipg
> +      - const: pll8k
> +      - const: pll11k
> +    minItems: 4
>  
>    dmas:
>      items:
> @@ -79,15 +86,24 @@ required:
>    - clock-names
>    - dmas
>    - dma-names
> -  - resets
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mp-xcvr
> +    then:
> +      required:
> +        - resets
> +
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - fsl,imx93-xcvr
> +              - fsl,imx95-xcvr
>      then:
>        properties:
>          interrupts:
> @@ -98,6 +114,25 @@ allOf:
>          interrupts:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx95-xcvr
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 6
> +        clock-names:
> +          maxItems: 6

6 is already the max. Drop these and add a 'not' into the if schema (or 
list out the other compatibles).

> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

