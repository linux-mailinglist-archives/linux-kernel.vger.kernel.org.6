Return-Path: <linux-kernel+bounces-573310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A2A6D586
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2826F1892A17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E2725C6ED;
	Mon, 24 Mar 2025 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZapVrFg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD11A29A;
	Mon, 24 Mar 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802923; cv=none; b=t9EjIzf/ZQ2KTzZ6j1ldVVoCNVpPz3QNMliJrIjfVzH0psbp9bO/J8toixnOPcQL2X3ya4C8ZuQtg418vsnYnejHD8NrxQfSLSIZPqDa0tAW5cNrHPRoSgxlELTrKOuUPXH4aHQOgAwvBEgJU8+SNeVDB7RMWljCqD2M/d1PTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802923; c=relaxed/simple;
	bh=BtEPrOUA7jH7ej7DW8zxFuc8SNfjlLpTBrBWHKKbiug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7rVWpMNHIgQddwIBwTIICunm5/jtUN/ln6bmn7E5BNwjf/6Ci1w+ZGJROE4kzgrkTLT+7DGsoXboNtBtd6dAJfbwTCwF5dZpZhQeyG1BL5tdAaPl6+1EAWIKsrMebiG+GFK4geYJmT3/DP4sRz701Z07/7XQhWp8ZFKszoQZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZapVrFg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF36CC4CEDD;
	Mon, 24 Mar 2025 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742802922;
	bh=BtEPrOUA7jH7ej7DW8zxFuc8SNfjlLpTBrBWHKKbiug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZapVrFg+M38fXINadcJHtQG46fg8MxNbe8yx/Y/67BY6Qcj45iPZXlBNeyqqTmlyO
	 NHzGi8puYhNeZcZE/czhuFd700zHpdXqbvFKBpkZcSArskC5bh+MwTGT8F6Xawl61i
	 2UKvROHBfMHlc9XD3DmfbDvQA0aB42knal+d3VMRTY89tqP7ZzZjn6H+dyjuITV9+K
	 y0oI/ojyQTfdBAyvkPSv+y9HoE4UzLviffdU4VZ/mGHjxfpOpG7l98BGZ2+pOu7ZFs
	 w9+JqEs3rpGX07vjwYfkITMQooiK1qIEB03dv3yXVjm8Em1XVIaZcZJwqIOz5wiy5b
	 SFKfyUy8eyxVw==
Date: Mon, 24 Mar 2025 08:55:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nikola Jelic <nikola.jelic83@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rwalton@cmlmicro.com
Subject: Re: [PATCH V6 1/2] ASoC: dt-bindings: Add cmx655 codec
Message-ID: <20250324-diligent-robust-guillemot-23fb1c@krzk-bin>
References: <cdbb8176-d109-4a31-9393-5e1ae6767170@kernel.org>
 <20250321222432.8212-1-nikola.jelic83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321222432.8212-1-nikola.jelic83@gmail.com>

On Fri, Mar 21, 2025 at 11:22:47PM +0100, Nikola Jelic wrote:
> The driver is for cmx655d audio codecs from CML Micro. The CMX655D is an

This is not a driver, but binding. Drop the first sentence.

> ultra-low power voice codec targeted at digital voice and sensor
> applications.
> 
> Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>
> 
> ---

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> 2025-01-25 Nikola Jelic <nikola.jelic83@gmail.com> V1
>         * /Documentation/devicetree/bindings/sound/cml,cmx655d.yaml: added the device tree binding
>         * /Documentation/devicetree/bindings/sound/cmx655.txt: added the device tree description file
>         * /Documentation/devicetree/bindings/vendor-prefixes.yaml: added CML Micro, Ltd. to the vendor prefixes


>         * /sound/soc/codecs/Kconfig: added SND_SOC_CMX655D and its dependencies
>         * /sound/soc/codecs/Makefile: added snd-soc-cmx655 and its dependencies
>         * /sound/soc/codecs/cmx655.c: added the main driver file for the codec
>         * /sound/soc/codecs/cmx655.h: added the main header file for the codec
>         * /sound/soc/codecs/cmx655_i2c.c: added the i2c adapter for the codec
>         * /sound/soc/codecs/cmx655_spi.c: added the spi adapter for the codec

How are these related to this patch? Per-patch changelog is supposed to
have only per-patch changes.

...

>  .../bindings/sound/cml,cmx655d.yaml           | 62 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  7 +++
>  3 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
> new file mode 100644
> index 000000000000..577e1d4942c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
> @@ -0,0 +1,62 @@
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

Some ack on taking maintainer duties would be useful.

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
> +    const: cml,cmx655d
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: cmx-irq

The name equal to device name is not really usefull. Drop
interrupt-names from binding and DTS.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
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
> +        audio-codec@54 {
> +            compatible = "cml,cmx655d";
> +            reg = <0x54>;
> +            #sound-dai-cells = <0>;
> +            reset-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +        };
> +

Drop stray blank line.


Best regards,
Krzysztof


