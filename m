Return-Path: <linux-kernel+bounces-435052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84199E6EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2031697FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82FD207DE3;
	Fri,  6 Dec 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0EpTmWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E920765A;
	Fri,  6 Dec 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490259; cv=none; b=nc7T76xIaQ1oMOanMRi2gG5z6Hy+hotBdM2djsR0MmmdzWYHdKTsDjy+pKI0/+L+HvpVTHM0rsm6MNG0OqAyARYnP4VdtLB4KbGB+pFeUlvrPHIc2jEtxwuw37CyHdhVLz9Cv1IVKqEvSlo/X0oKNRslPIUHdKBFgX7GC6rWZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490259; c=relaxed/simple;
	bh=VLfoQRnwWe0Rvqit/Z+Tb+RfEtPz3Jei9eCUy65SVAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmdoPf5mAQzuhtIBlQUTqBdUWdII9NDedAfOi2CLBWGC6stl07YKvM50Rod4fwhLwc/N0XbIdXmRTFRwChES9n34qc4PTDkyk60PVuZzP0zZLbyu+wCPNQlVeDqKvKrAaundwmOxG3EqujTX+hTXI7O0ZUPvQC4DfnAAjCugt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0EpTmWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B17C4CEE0;
	Fri,  6 Dec 2024 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490258;
	bh=VLfoQRnwWe0Rvqit/Z+Tb+RfEtPz3Jei9eCUy65SVAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0EpTmWLThG3R0PlwzAt7twm24nccovDnKlaPEcQS420UMIwrtO8xHxpRVxkymzH9
	 KH5TnQgF9SxF7RhZwz83d0UAZ7VrV6Mn2zCla7AcoZyDrKudTYbv5rqby013bXNGJo
	 f2lhAIDa8OwmIDCnwMLAPYGwWDFVA082tVGOO3ohR/GMKagavcsPEtMIJy80BcI5K5
	 pWjAoeR6vrve6+NdEWNQTKH+KPSJfEK2TmrH28pTH4f4KrY7SKWxtu4Ufk0dRGBCGq
	 TjtVm+G6AsBDUc0t8I2hBdKMw8+O31HQ9RfqgrWcXdX40FfDIJ9wWyM/pX1WP/Z+/5
	 0lHK18/yeAvAA==
Date: Fri, 6 Dec 2024 14:04:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 15/20] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
Message-ID: <gbymcmoya7dfmedq4nkopqpswh63d2ujxl2elc2x7x325b75bu@anp36sdya43v>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
 <20241205111939.1796244-16-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205111939.1796244-16-dario.binacchi@amarulasolutions.com>

On Thu, Dec 05, 2024 at 12:17:50PM +0100, Dario Binacchi wrote:
> The patch adds the DT bindings for enabling and tuning spread spectrum
> clocking generation.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v4)
> 
> Changes in v4:
> - Drop "fsl,ssc-clocks" property. The other added properties now refer
>   to the clock list.
> - Updated minItems and maxItems of
>   - clocks
>   - clock-names
>   - fsl,ssc-modfreq-hz
>   - fsl,ssc-modrate-percent
>   - fsl,ssc-modmethod
> - Updated the dts examples
> 
> Changes in v3:
> - Added in v3
> - The dt-bindings have been moved from fsl,imx8m-anatop.yaml to
>   imx8m-clock.yaml. The anatop device (fsl,imx8m-anatop.yaml) is
>   indeed more or less a syscon, so it represents a memory area
>   accessible by ccm (imx8m-clock.yaml) to setup the PLLs.
> 
> Changes in v2:
> - Add "allOf:" and place it after "required:" block, like in the
>   example schema.
> - Move the properties definition to the top-level.
> - Drop unit types as requested by the "make dt_binding_check" command.
> 
>  .../bindings/clock/imx8m-clock.yaml           | 77 +++++++++++++++++--
>  1 file changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> index c643d4a81478..83036f6d2274 100644
> --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> @@ -29,12 +29,12 @@ properties:
>      maxItems: 2
>  
>    clocks:
> -    minItems: 6
> -    maxItems: 7
> +    minItems: 7
> +    maxItems: 10

ABI break without mentioning, without any explanation in the commit msg.

>  
>    clock-names:
> -    minItems: 6
> -    maxItems: 7
> +    minItems: 7
> +    maxItems: 10
>  
>    '#clock-cells':
>      const: 1
> @@ -43,6 +43,34 @@ properties:
>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
>        for the full list of i.MX8M clock IDs.
>  
> +  fsl,ssc-modfreq-hz:
> +    description:
> +      The values of modulation frequency (Hz unit) for each clock
> +      supporting spread spectrum.
> +    minItems: 7
> +    maxItems: 10

Why all cloks receive now spread spectrum? I had impression - and all
your previous versions were doing this - that you have only three or
four clocks with SSC.

Do existing clocks 1-6 support SSC?

> +
> +  fsl,ssc-modrate-percent:
> +    description:
> +      The percentage values of modulation rate for each clock
> +      supporting spread spectrum.
> +    minItems: 7
> +    maxItems: 10
> +
> +  fsl,ssc-modmethod:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      The modulation techniques for each clock supporting spread
> +      spectrum.
> +    minItems: 7
> +    maxItems: 10
> +    items:
> +      enum:
> +        - ""

Drop "", not sure why do you need it.

> +        - down-spread
> +        - up-spread
> +        - center-spread
> +
>  required:
>    - compatible
>    - reg
> @@ -76,6 +104,10 @@ allOf:
>              - const: clk_ext2
>              - const: clk_ext3
>              - const: clk_ext4
> +        fsl,ssc-modfreq-hz: false
> +        fsl,ssc-modrate-percent: false
> +        fsl,ssc-modmethod: false
> +
>      else:
>        properties:
>          clocks:
> @@ -86,6 +118,10 @@ allOf:
>              - description: ext2 clock input
>              - description: ext3 clock input
>              - description: ext4 clock input
> +            - description: audio1 PLL input
> +            - description: audio2 PLL input
> +            - description: dram PLL input
> +            - description: video PLL input

Also ABI break....

Best regards,
Krzysztof


