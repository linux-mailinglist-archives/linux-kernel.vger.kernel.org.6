Return-Path: <linux-kernel+bounces-510628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B0A31FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184E2188BAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6FA204581;
	Wed, 12 Feb 2025 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ligrOa55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC039204097;
	Wed, 12 Feb 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344529; cv=none; b=QV8Lmh5WWZZIYLXmPXfWkeryJi4rMHnHKC5kq9oyQWDtGffgZwyC3b9+5wfkaj79gVQ0VJmxNw9ZOcTjOQZR83Dh5gPhcD9q2RL1lJuCs5vqqq8DjMHRn+7GjSXmdx5ax2Tu5qodSBOyfDYkufGTvFL/VIFcqkP9+h1GHiGuofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344529; c=relaxed/simple;
	bh=V66YCvC0FuwsQ3Tm8P1Y43IROGLiDwhKoiqjaV3vOeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhwv4403ud+xDuPOYWoynW2IeDSL+j2xBFy7Mrzy3e5joiPuDl/EOgr6aoYBcHyTDEGVeUijQmrmXTRlnqmG+c1xOwLcbEgHbq5fnAXZJ9lKpp+cIsxXuZRUzpsKUj2zOkGkW4edKLJS0BYwHxHVieTNlWSrOfpRw54SP9/JaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ligrOa55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5C5C4CEDF;
	Wed, 12 Feb 2025 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739344528;
	bh=V66YCvC0FuwsQ3Tm8P1Y43IROGLiDwhKoiqjaV3vOeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ligrOa55dlzfdnDNNi2tX2QeAofE/o4XhppmFpY7n4ksubSdNSb60y7Bv6fuhL42G
	 uKARlCvUJFO1cT6RY9+AvvtLe5EDhgYZFeOvnmrXPMp/49YIKZ5uHAE/twE56SpwLh
	 55crwSbwXweCl07jG+fHp2plhJe3umU1DSp1JC+88dBg/NIDszVLXgRHmXyq2Y4WR/
	 2NQIMtvvEKuR8m+D9TQYZ4dLkvrOTNK9Yc5sNXfnp0FxALkKTbzmxbV3BC0qj0Ctn3
	 s1Pj8lhSdOb+agDfHyayP96xBWZVhNQJM8yEjna46SC+2ml/6QU5lfYoYRdxEyHQJk
	 hEJt7Sfw2gwaw==
Date: Wed, 12 Feb 2025 08:15:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikola Jelic <nikola.jelic83@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rwalton@cmlmicro.com
Subject: Re: [PATCH V3 1/2] ASoC: dt-bindings: Add cmx655 codec
Message-ID: <20250212-gabby-aardwolf-of-chivalry-a7fda2@krzk-bin>
References: <20250210222903.88282-1-nikola.jelic83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210222903.88282-1-nikola.jelic83@gmail.com>

On Mon, Feb 10, 2025 at 11:28:46PM +0100, Nikola Jelic wrote:
> Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>
> 

Nothing improved here. Respond to previous comments or implement them.

Some things got better in this patch, thank you. Other did not. Maybe
there is misunderstanding about my comments, but you never replied to
them, so I would assume you will be implementing them fully. If
something is unclear, ask responding inline.


> ---
> V2 -> V3: fixed dt_binding_check + yamllint warnings
> V1 -> V2: removed the txt file, fixed review remarks
> ---
>  .../bindings/sound/cml,cmx655d.yaml           | 78 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
> new file mode 100644
> index 000000000000..1648f606bf48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cml,cmx655d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CML Micro CMX655D codec
> +
> +maintainers:
> +  - Richard Walton <rwalton@cmlmicro.com>
> +  - Nikola Jelic <nikola.jelic83@gmail.com>
> +
> +description:
> +  The CMX655D is an ultra-low power voice codec.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cml,cmx655d
> +
> +  reg:
> +    description: Local bus address

Drop, why did this appear?

> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    description: The first cell indicating the audio interface

Drop, redundant. It wasn't here before and I did not ask for this, so why?

> +    const: 0
> +
> +  reset-gpios:
> +    description: GPIO used for codec reset, negative logic
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Interrupt for the CMX655D IRQ line

Drop

> +    maxItems: 1
> +
> +  interrupt-names:
> +    description: Interrupt name for the CMX655D IRQ line

Nothing improved. Maybe there was some misunderstanding. I asked to look
at other bindings doing this. Where do you see syntax like that for
interrupt-names? What syntax do you see for interrupt-names?

> +    maxItems: 1
> +
> +  cml,classd-oc-reset-attempts:
> +    description: Maximum number of times to reset CMX655 class-D
> +      following a overcurrent event.
> +      >10000 = disable limit.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 10001
> +    default: 5

Still no answer why this is board configurable.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        status = "okay";

Another ignored comment.

> +        audio-codec@54 {
> +            compatible = "cml,cmx655d";
> +            #sound-dai-cells = <0>;
> +            reg = <0x54>;

Another...


Best regards,
Krzysztof


