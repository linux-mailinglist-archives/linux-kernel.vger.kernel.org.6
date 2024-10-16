Return-Path: <linux-kernel+bounces-368442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40D9A0FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11201F20EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A742141C4;
	Wed, 16 Oct 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUmiJXUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0D212EF9;
	Wed, 16 Oct 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096472; cv=none; b=Xry+gaiubLwsi8FpPxitvQirWpoJJyRg3YfBLFa8eLG7crdrIL6+N9VPtIbkySOID0fDo+ir8a4N9RdrLlm59qt/fSvQJZM6q6KLAIK9rsuoascnyi8THoYiaLs3/ph3as/66DCAA0PsT8x8jf/H4byWbMOM1XXMm9b6LNUSm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096472; c=relaxed/simple;
	bh=X74CUR82Hp13NQGo9Nw3P/9n2781EBJt2T7QAPcjMe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIa9cA/dn4mPPD0YTjONED2woRKAxv7wek9gflVy02ho8HhJUYk6zlAWratLDhb2JyyDKG8Pp5oNE1QJ+rpdYO6wMeVXAsxOAqCNjWKhWiIQoAQN3bbbvYFzmLMbXVyH4pM5zeAc+v4/OKeIXVqhImkYuBw7jZSL3N5z3cFLk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUmiJXUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4CC4CECE;
	Wed, 16 Oct 2024 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729096472;
	bh=X74CUR82Hp13NQGo9Nw3P/9n2781EBJt2T7QAPcjMe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUmiJXUgqYVcRwBwKP++87hayLvsKh+JHQw0YskmMGINgFyFJ4i3PwDUkS/nKzHkr
	 SExhvNHrBsft1uBLclTBBHuJ2IynakzyONMRRpBYueRBMTkQdgbpzNDuL0uGokchK3
	 +lEZoblOhNWQZTO66eoMRr/eF5P8x2Ifb02FGPT86H5z1Ys2U+EjFEPTT2fajipKQO
	 q5WrG1j9o9iFkk1FgVYvFIe9RP7sIIqqqYQ/9akbm8SbuVl9QmM8PotbGlm9Msy4qe
	 p6gbmAI1UtJCn+NpDhna2YCs1MahlVQoqR5ulvDiwf9TEprYQXrs5H0Y0nXRtXAzZo
	 UWTPRCIEQrVdg==
Date: Wed, 16 Oct 2024 11:34:29 -0500
From: Rob Herring <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add CS42L84 codec
Message-ID: <20241016163429.GA1861304-robh@kernel.org>
References: <20241016-cs42l84-v1-0-8d7e9d437d2d@gmail.com>
 <20241016-cs42l84-v1-1-8d7e9d437d2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016-cs42l84-v1-1-8d7e9d437d2d@gmail.com>

On Wed, Oct 16, 2024 at 08:41:00PM +1000, James Calligeros wrote:
> From: Martin Povišer <povik+lin@cutebit.org>
> 
> CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> computer models starting with 2021 Macbook Pros. It is not a publicly
> documented part. To a degree the part is similar to the public CS42L42.
> (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> pretty much the same as L42.)
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                                 |  1 +
>  2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..12bc6dbeeddfaccf9dd00deb2676deac25f28c9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,cs42l84.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS42L84 audio CODEC
> +
> +maintainers:
> +  - povik+lin@cutebit.org

Name too please.

> +
> +description:

Needs a '>' if you want to maintain paragraphs.

> +  The CS42L84 is a headphone jack codec made by Cirrus Logic and embedded
> +  in personal computers sold by Apple. It was first seen in 2021 Macbook Pro
> +  models.
> +
> +  It has stereo DAC for playback, mono ADC for capture, and is somewhat
> +  similar to CS42L42 but with a different regmap.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,cs42l84
> +
> +  reg:
> +    description:
> +      I2C address of the device

Drop. That's every device.

> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Reset pin, asserted to reset the device, deasserted to bring
> +      the device online

Drop. That's every reset-gpios.

> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt for the IRQ output line of the device

Drop.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      jack_codec: codec@4b {
> +          compatible = "cirrus,cs42l84";
> +          reg = <0x4b>;
> +          reset-gpios = <&pinctrl_nub 4 GPIO_ACTIVE_LOW>;
> +          interrupts-extended = <&pinctrl_ap 180 IRQ_TYPE_LEVEL_LOW>;
> +          #sound-dai-cells = <0>;

Not documented.

> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1a2c296446c0724a0c6e70c845e5e5e1e693fd5..f5f85714dc4e8ca9c60b3f6963b2cec1ea33fdd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2132,6 +2132,7 @@ L:	asahi@lists.linux.dev
>  L:	linux-sound@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
> +F:	Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
>  F:	Documentation/devicetree/bindings/sound/apple,*
>  F:	sound/soc/apple/*
>  F:	sound/soc/codecs/cs42l83-i2c.c
> 
> -- 
> 2.47.0
> 

