Return-Path: <linux-kernel+bounces-304396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759C3961F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99451F258EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38394158557;
	Wed, 28 Aug 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk3TKGhL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2C49641;
	Wed, 28 Aug 2024 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825895; cv=none; b=KHxp/oeU8cR7akWoTt3YQ8aOxvqcVgNZLzfVnEgp9OXCq1MDuCEF3rko8YNqWBeGV41nbAie/1OO2d6gfBVFz5qW1aLkWLgD7lmDFsCwQcyk9HJqR6eQv0Iq93T6mYTSwzrzBfF1wOdzEtddvZyNfRHN7lFACNRAqIxEba50PoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825895; c=relaxed/simple;
	bh=meA8IZtU4hNTJg9VW1FHygfSFUokgpJo2faCYtQ/YtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMTr0WeVGarhh2AXzF1TMlmj+riQ4cNbySpZ7fwgx8IlSsmX4AEtL6Boe2ZwGD8Hbw91rAugHLx6x0pJWOfLHDbCuDzbij34LzqORsl3UNzQ9ByR7s7ls71O3CoYaOGY4qxWr4cowsmZqKNs5dhUEBz7ap60Il2UsP4iBQ7ThWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk3TKGhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BC5C4AF1B;
	Wed, 28 Aug 2024 06:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825895;
	bh=meA8IZtU4hNTJg9VW1FHygfSFUokgpJo2faCYtQ/YtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bk3TKGhLxGj4tvurT3JaxJzwDncf8PFPAgZjnjRLr3Uww4fm94D5ONW9ltdeSfOGZ
	 9od8Qbdv4ALeHATy6Sx2Tqvk9AyaUCNfMOaFCNkc1HkoCe5sXiW0cFFm5TkRExQ1iR
	 zDZrIjquVTMd79J9cGT0STMUQWavO6edliliADDdv87SbqV2By9VP1+6SpgVAuwEjo
	 VTOqV7EEkU2Ei1FHUPIJlKXV0mKd9wd0R5pcxQhvUXJ3mkd/NGe/5ZyoJuN7RkRx7c
	 yfkv4x9eZygDVhKuA6A5/mTO2HaPVCkXkUc7hsm2Bxg6bVxwPnW/1/OEW1NopomKHz
	 VFuttEyTJ+K5Q==
Date: Wed, 28 Aug 2024 08:18:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: Add dt bindings definition file for
 imx28 saif
Message-ID: <mzlrm7zkzuue4xsxehz32ffiesigy2dzbos2osirzfoi525q6q@7klbgtmht74a>
References: <20240827180528.2315563-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827180528.2315563-1-lukma@denx.de>

On Tue, Aug 27, 2024 at 08:05:28PM +0200, Lukasz Majewski wrote:
> This file allows correct check of DTS node for imx287 based
> "fsl,imx28-saif" compatible device.
> 
> It corresponds to Documentation/devicetree/bindings/fsl,imx28-saif
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  .../devicetree/bindings/sound/fsl,saif.yaml   | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)

There is a binding. Please perform conversion from TXT to DT schema,
mentioning in commit msg any changes from pure conversion (e.g. new
properties to match DTS).

Few more comments below.

>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,saif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,saif.yaml b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
> new file mode 100644
> index 000000000000..747faa411a50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,saif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MXS Serial Audio Interface (SAIF)
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The SAIF is based on I2S module that is used to communicate with audio codecs,
> +  but only with half-duplex manner (i.e. it can either transmit or receive PCM
> +  audio).
> +
> +properties:
> +  compatible:
> +    const: fsl,imx28-saif
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  assigned-clock-parents: true
> +  assigned-clock-rates: true
> +  assigned-clocks: true

These three should be dropped, redundant.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> +
> +  clocks:
> +    maxItems: 1
> +
> +  fsl,saif-master:
> +    description: Indicate that saif is a slave and its phandle points to master
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - dmas
> +  - dma-names
> +  - "#sound-dai-cells"

Keep the same order as in "properties:" block.

and here allOf: with $ref to dai-common.yaml

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    saif0: saif@80042000 {
> +        #sound-dai-cells = <0>;
> +        compatible = "fsl,imx28-saif";
> +        reg = <0x80042000 2000>;
> +        interrupts = <59>;
> +        clocks = <&clks 53>;
> +        dmas = <&dma_apbx 4>;
> +        dma-names = "rx-tx";
> +    };
> +  - |
> +    saif1: saif@80046000 {

Just one example, could be this one as more complete.

> +        #sound-dai-cells = <0>;

Keep it after "reg" (compatible and reg are always first).

Best regards,
Krzysztof


