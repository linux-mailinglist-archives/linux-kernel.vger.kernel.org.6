Return-Path: <linux-kernel+bounces-530105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53F3A42F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCA188C4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D01DDA35;
	Mon, 24 Feb 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGg+zl5w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E872571B2;
	Mon, 24 Feb 2025 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432512; cv=none; b=OMtIxIgOYQpKmFTK9mIBrDa/sPk+mYwEr+i5axAEFa6ZNSvYS6klZjp/B01JvRZCVgdYHhPsZFBllQToB4QKAXRDZosn2dEai5C+Biq9VTwOuAPaYaZkU7GwBJHsYdtjCbjjC2fNQFSlJIdB4i354/VdMECAXDLgAB7Loa8u5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432512; c=relaxed/simple;
	bh=5vFlbGbmL33Vsp34b7HJu8E3SuCqLrHQhEH3L3HCMYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzFS9Tu7oeCY1SmBHP8Os4AasoKVSuCdX7wUwtYngqNvmZjn9eIPnMVZP/eNT+/T5HaWSFWU7NGBND6MkIv+yCv4z3MgavrBBiBFDiYZWjeYwfOEvBxlY9UObjjqqksVIf1CY8kJ6wYWPg2KgjeMQj/UV3GT393nZi6ylyxoJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGg+zl5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA164C4CED6;
	Mon, 24 Feb 2025 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740432512;
	bh=5vFlbGbmL33Vsp34b7HJu8E3SuCqLrHQhEH3L3HCMYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGg+zl5w/17Nl5M0v45HIg5YnqFhDHf7+SdeFh9m6pJiw0fSlF8td8NHy0IhV2I1I
	 PKvcgu5jMM+9d3zX6OcZ71ZLR1+V3OY5x+9uL/q+xhtHf5cjE83cN7U5ElLv1sQgIY
	 t7/eHKa/s1Nuz1bX0hjAJwB8uPi4XunjOh+zKtqvNw7mQXJx7hay5BlR9InRN1kK4y
	 A6o/sB3Cm7ZPqrE55olZhq7Aqsaie/sumjXa0P+uOT6yTjGP8RoMY+Whyyx32G9Q/F
	 i+GU9gZRhdJNxhQDvZoxeJNSfCvMW6DM9ipViklweQ6cGBfN5d5c0SkiwGZQGpZWJf
	 reS9TYVPlU3yA==
Date: Mon, 24 Feb 2025 15:28:30 -0600
From: Rob Herring <robh@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-sound@vger.kernel.org,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: xlnx,audio-formatter: Convert
 to json-schema
Message-ID: <20250224212830.GA4107125-robh@kernel.org>
References: <20250224182548.2715896-1-vincenzo.frascino@arm.com>
 <20250224182548.2715896-3-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182548.2715896-3-vincenzo.frascino@arm.com>

On Mon, Feb 24, 2025 at 06:25:46PM +0000, Vincenzo Frascino wrote:
> Convert the Xilinx Audio Formatter 1.0  device tree binding documentation
> to json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
>  .../bindings/sound/xlnx,audio-formatter.yaml  | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
> deleted file mode 100644
> index cbc93c8f4963..000000000000
> --- a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Device-Tree bindings for Xilinx PL audio formatter
> -
> -The IP core supports DMA, data formatting(AES<->PCM conversion)
> -of audio samples.
> -
> -Required properties:
> - - compatible: "xlnx,audio-formatter-1.0"
> - - interrupt-names: Names specified to list of interrupts in same
> -		    order mentioned under "interrupts".
> -		    List of supported interrupt names are:
> -		    "irq_mm2s" : interrupt from MM2S block
> -		    "irq_s2mm" : interrupt from S2MM block
> - - interrupts-parent: Phandle for interrupt controller.
> - - interrupts: List of Interrupt numbers.
> - - reg: Base address and size of the IP core instance.
> - - clock-names: List of input clocks.
> -   Required elements: "s_axi_lite_aclk", "aud_mclk"
> - - clocks: Input clock specifier. Refer to common clock bindings.
> -
> -Example:
> -	audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
> -		compatible = "xlnx,audio-formatter-1.0";
> -		interrupt-names = "irq_mm2s", "irq_s2mm";
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 104 4>, <0 105 4>;
> -		reg = <0x0 0x80010000 0x0 0x1000>;
> -		clock-names = "s_axi_lite_aclk", "aud_mclk";
> -		clocks = <&clk 71>, <&clk_wiz_1 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> new file mode 100644
> index 000000000000..a83af71401aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx PL audio formatter
> +
> +description: |

Don't need '|'

> +  The IP core supports DMA, data formatting(AES<->PCM conversion)
> +  of audio samples.
> +
> +maintainers:
> +  - Vincenzo Frascino <vincenzo.frascino@arm.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,audio-formatter-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: irq_mm2s
> +      - const: irq_s2mm
> +    description: |
> +      Names specified to list of interrupts in same order mentioned under
> +      "interrupts". List of supported interrupt names are:
> +      - "irq_mm2s" : interrupt from MM2S block
> +      - "irq_s2mm" : interrupt from S2MM block

Don't repeat constraints in prose and don't describe how common 
properties work. IOW, drop the description completely.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

If you want to describe each interrupt, then here put:

minItems: 1
items:
  - description: describe 1st interrupt...
  - description: ...

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: s_axi_lite_aclk
> +      - const: aud_mclk
> +    description: |
> +      List of input clocks.

Drop

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Input clock specifier. Refer to common clock bindings.

Drop

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-names
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
> +      compatible = "xlnx,audio-formatter-1.0";
> +      interrupt-names = "irq_mm2s", "irq_s2mm";
> +      interrupt-parent = <&gic>;
> +      interrupts = <0 104 4>, <0 105 4>;
> +      reg = <0x80010000 0x1000>;
> +      clock-names = "s_axi_lite_aclk", "aud_mclk";
> +      clocks = <&clk 71>, <&clk_wiz_1 0>;
> +    };
> +...
> -- 
> 2.43.0
> 

