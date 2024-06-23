Return-Path: <linux-kernel+bounces-225965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D246913874
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC4283BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859B3D0D0;
	Sun, 23 Jun 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM4PkO+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9227453;
	Sun, 23 Jun 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126518; cv=none; b=Oc/fDrIM5RdjcykD4KmEphVXh6iQeTnSeZaQlEyBm/XOu0EPv0rpV/SPIB07FPPWmKYqNChdB11S8vuv1pRwwHGrMQNI0RtM9gbjvi09TxMORVANW9DU/ORF9RboezOWyUXd95WTH51MPRtvTIKztjAmHKKyCl+EB/HNriMm94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126518; c=relaxed/simple;
	bh=sxWC9NfFdX4cIViFqrOB5DHPMjVzWToQcWPQADncEsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKId/uhfpMQj8viL6WvwKER0GNOXqioHHYj4o4zrF/pvUeGmW8ToAWADzZesqTmcfpPswlzQgrW+1QFv3TbIM/qZfuKm9JZ6ftxNFHTmGRzt9r7MSo+1ChoBPNrvIlhvkQQT34bRWRE0KK6yfULzMOQ4jyti8D4iNdJr/aE8ggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM4PkO+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EA4C2BD10;
	Sun, 23 Jun 2024 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719126517;
	bh=sxWC9NfFdX4cIViFqrOB5DHPMjVzWToQcWPQADncEsA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RM4PkO+82ssgoMbdBGSXiBQdATN5hQW+nQKUaQx9V45NOb5v3Cjujh3zmpxxvBjjz
	 gpLD1fCTnzwzSX1aVg27zQocwV6OkWVBre2kormJpLwIfcPE25GkuRVSG4RU5Ca3ze
	 l5RojES8UWjYUOsaczxXXt46jTZXZtQ14TPhxhuH9mg/tLOKnMGMbEjz3kqpTvUzUn
	 Mph4tD2Uww9kPHeXZDXeJ9aP38Lu+d18hxijeqkVZZWQ/H3W4VqWuVk556w68a/oDn
	 9GFYupsLcrZdXXd4fwNKtgv4lS/YWDgdbQKFG59QMAQ6vgN5x/WIZrKq/BGKWYu5fU
	 Li1JAUQ2b4JRg==
Message-ID: <268a722a-c2e8-42fe-9cae-104e3f082a0a@kernel.org>
Date: Sun, 23 Jun 2024 09:08:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,imx-audio-sgtl5000: Convert to
 dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240622182200.245339-1-animeshagarwal28@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240622182200.245339-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/06/2024 20:21, Animesh Agarwal wrote:
> Convert the imx-audio-sgtl bindings to DT schema. Make bindings complete
> by adding audio-cpu property.

On what basis? Who needs or uses audio-cpu? Driver? DTS? Both? If only
DTS, then is it needed? Maybe not?

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../sound/fsl,imx-audio-sgtl5000.yaml         | 108 ++++++++++++++++++
>  .../bindings/sound/imx-audio-sgtl5000.txt     |  56 ---------
>  2 files changed, 108 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml
> new file mode 100644
> index 000000000000..906dcecb73b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,imx-audio-sgtl5000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX audio complex with SGTL5000 codec
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx25-pdk-sgtl5000
> +              - fsl,imx51-babbage-sgtl5000
> +              - fsl,imx53-m53evk-sgtl5000
> +              - tq,imx53-mba53-sgtl5000
> +              - fsl,imx53-cpuvo-sgtl5000
> +              - fsl,imx53-qsb-sgtl5000
> +              - karo,tx53-audio-sgtl5000

Keep list ordered alphabetically.

> +              - fsl,imx53-voipac-sgtl5000
> +              - fsl,imx6q-ba16-sgtl5000
> +              - fsl,imx6q-ventana-sgtl5000
> +              - fsl,imx-sgtl5000
> +              - fsl,imx6-armadeus-sgtl5000
> +              - fsl,imx6dl-nit6xlite-sgtl5000
> +              - fsl,imx6q-nitrogen6_max-sgtl5000
> +              - fsl,imx6q-nitrogen6_som2-sgtl5000
> +              - fsl,imx6q-nitrogen6x-sgtl5000
> +              - fsl,imx6-rex-sgtl5000
> +              - fsl,imx6q-sabrelite-sgtl5000
> +              - fsl,imx6-wandboard-sgtl5000

None of these were in the old binding and commit msg mentions only
audio-cpu. From where do you get these?


> +          - const: fsl,imx-audio-sgtl5000
> +      - const: fsl,imx-audio-sgtl5000
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The user-visible name of this sound complex.
> +
> +  audio-cpu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of an CPU DAI controller
> +
> +  ssi-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the i.MX SSI controller.
> +
> +  audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the SGTL5000 audio codec.
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      A list of the connections between audio components. Each entry is a pair
> +      of strings, the first being the connection's sink, the second being the
> +      connection's source. Valid names could be:
> +
> +      Power supplies:
> +        * Mic Bias
> +
> +      SGTL5000 pins:
> +        * MIC_IN
> +        * LINE_IN
> +        * HP_OUT
> +        * LINE_OUT
> +
> +      Board connectors:
> +        * Mic Jack
> +        * Line In Jack
> +        * Headphone Jack
> +        * Line Out Jack
> +        * Ext Spk
> +
> +  mux-int-port:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The internal port of the i.MX audio muxer (AUDMUX).
> +    enum: [1, 2]

default:

> +
> +  mux-ext-port:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The external port of the i.MX audio muxer.
> +    enum: [3, 4, 5, 6]

defaukt:

> +
> +required:
> +  - compatible
> +  - model

Several other properties were required. Why changing this? Please
explain in commit msg all changes done to the binding comparing to pure
conversion.


Best regards,
Krzysztof


