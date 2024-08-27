Return-Path: <linux-kernel+bounces-303151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82091960822
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381A41F22F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F819EEAF;
	Tue, 27 Aug 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMj3nYW/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993019D06D;
	Tue, 27 Aug 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756732; cv=none; b=ZrMIJi0YQMBOWOSJ5hUYmRzwkgi5R9PQuwur48aso9udwcH76AjeaKEzftG1Wx2If0pQeCXnijpXLkiudGcrlg8XQYqMFjhxtMX/d4EShlo5EH0pcVJJCMca4ABkrzXxmGddOET00R0W2kM7PbyltJ5JpImLD4XpPIYt95Z11DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756732; c=relaxed/simple;
	bh=hly+/bpjnJUrPx4YHicLOBFxXFUW7UOArHtHR1exMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4fim9v6sARqL2QU1+TcWsAsJm2OeJztQa3aV2t7gyqMxB6UTUUQXXW/zNUwkoU00FoOyKyMxs3JuW0dKTHXlVpweUNPyctLQIkiNW9cTwGTfPea0bxSr9Crlrd5OYwPoR3IE+XBATNKkvFPL7YHBSLsCQeKbySJGi/w0qqFq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMj3nYW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FA5C8B7A0;
	Tue, 27 Aug 2024 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724756732;
	bh=hly+/bpjnJUrPx4YHicLOBFxXFUW7UOArHtHR1exMEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMj3nYW/N9iHEi7g83bTk9HnUnyHhMaKFbGHXemftcOo9AnWK2u5HJSyMOVZWvduU
	 57IBaUduxvYKyw/OGYHm3ixJEL3LBpsWUQFrhwjLmwFntAIR8yVHo9Y/wLrgvcQt8v
	 ink6aId3Di1S9aIa2Rw/lsIZngkFtxR2jc7qMZLaUSmVdM1P4dLRQk6nULk/MqGomZ
	 5e1U86+nG4Vs7IQWcRApAHKPj5wy/Bp4fDELedSS8vS9pWAEJ7+inJWMK56rk6Ptj6
	 +RjhmUwuR+PSdT/NHp4PMkPtUwFcSERisz3I2OZIQPvi1jQ+uA6HFzn9EUqbcLWWVV
	 +ojTHXMnRRDPw==
Date: Tue, 27 Aug 2024 13:05:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: nikita.shubin@maquefel.me
Cc: David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: cirrus,cs4271: Convert to dtschema
Message-ID: <d2z3i5lkjx3uqtp436pbwb57rlp2zqdxzpto2es5sanslw7m2e@rfpicq4wezgq>
References: <20240827-cs4271-yaml-v2-1-20b639bd2a0a@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827-cs4271-yaml-v2-1-20b639bd2a0a@maquefel.me>

On Tue, Aug 27, 2024 at 12:49:18PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Convert the Cirrus Logic CS4271 audio CODEC bindings to DT schema.
> 
> Add missing spi-cpha, spi-cpol, '#sound-dai-cells' and port, as they
> are already being used in the DTS and the driver for this device.
> 
> Based on Animesh Agarwal cs42xx8 conversion patch.
> 
> Keep the original 'reset-gpio' used in bindings,
> instead of 'reset-gpios' used in cs42xx8.
> 
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Link: https://lore.kernel.org/all/20240715-ep93xx-v11-0-4e924efda795@maquefel.me
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> This is complementary patch to ep93xx DT conversion series.
> 
> Based on "ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema" patch.
> 
> Krzysztof, thank you very much for quick review!
> ---
> Changes in v2:
> Krzysztof Kozlowski:
> - fix SoB above link
> - replace 'driver' with 'device'
> - mention properties not present in original bindings
> - mention using 'gpio-reset' instead of 'gpios-reset'
> - dropped unused label
> - use defines for gpio bindings
> - newline at end of file
> - Link to v1: https://lore.kernel.org/r/20240826-cs4271-yaml-v1-1-dad3f0b041ef@maquefel.me
> ---
>  .../devicetree/bindings/sound/cirrus,cs4271.yaml   | 101 +++++++++++++++++++++
>  Documentation/devicetree/bindings/sound/cs4271.txt |  57 ------------
>  2 files changed, 101 insertions(+), 57 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
> new file mode 100644
> index 000000000000..cc5b48ceafa4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs4271.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,cs4271.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS4271 audio CODEC
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +description:
> +  The CS4271 is a stereo audio codec. This device supports both the I2C
> +  and the SPI bus.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: cirrus,cs4271
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  reset-gpio:

I wasn't clear... reset-gpios and mention that you switched to
non-deprecated gpios suffix.

> +    description:
> +      This pin will be deasserted before communication to the codec starts.
> +    maxItems: 1
> +
> +  va-supply:
> +    description: Analog power supply.
> +
> +  vd-supply:
> +    description: Digital power supply.
> +
> +  vl-supply:
> +    description: Serial Control Port power supply.
> +
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +  cirrus,amuteb-eq-bmutec:
> +    description:
> +      When given, the Codec's AMUTEB=BMUTEC flag is enabled.
> +    type: boolean
> +
> +  cirrus,enable-soft-reset:
> +    description: |
> +      The CS4271 requires its LRCLK and MCLK to be stable before its RESET
> +      line is de-asserted. That also means that clocks cannot be changed
> +      without putting the chip back into hardware reset, which also requires
> +      a complete re-initialization of all registers.
> +
> +      One (undocumented) workaround is to assert and de-assert the PDN bit
> +      in the MODE2 register. This workaround can be enabled with this DT
> +      property.
> +
> +      Note that this is not needed in case the clocks are stable
> +      throughout the entire runtime of the codec.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        cs4271@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

audio-codec or codec

Best regards,
Krzysztof


