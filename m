Return-Path: <linux-kernel+bounces-532590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB3A44F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E49817AC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9862135A6;
	Tue, 25 Feb 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgOvUj1f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303320CCD3;
	Tue, 25 Feb 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521696; cv=none; b=IQ/C0Uyr+B449UI9z944z+WRE0okNiNeuJAlxGb7RDQcSms0A4dz6FLzbCrMd5wj3hqBUvB68B6curg1W4gIkXSwM2AplcIWFQ280JohJ4SH/xiN0pP7zRQ0PzZm8uH/4KvgR1ZqeHziIOkf4Wq8aVc5m0OEyQj9sCQcvsry9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521696; c=relaxed/simple;
	bh=1wSYnkvLU4Ewu+IAhRy6LxphPTsLBZjldaLcpna5508=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwXCXK8O7tgh/WkpVD6qFxWUglR0rqSLQSY/AQQl9Clmi013Y1tEtFnqce+QA+itwnpBRq/eh6p0AbIgADp75TrwimjtdY1ZGzBOFSMsmGCrOK2uG39qc0QdeLdE+uFaKlAJhqbSqEKma/8Z0eSrF8uciWc8Os1riOA5+P5RFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgOvUj1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A33C4CEDD;
	Tue, 25 Feb 2025 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740521696;
	bh=1wSYnkvLU4Ewu+IAhRy6LxphPTsLBZjldaLcpna5508=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgOvUj1fm1rWMKSKnrtJA4vFNzbMDcESgPaMdwDm3PXTUyrdrIe6jY/1nF55nYcJp
	 rn3bxYIJHFJNOVE3CIerQwdsPmT4hD2QyX/s/9HSzW+XlE0x0d2xaOI5b9uvAQyGng
	 au4xGStPqOHhuYOe9mqT5XdYpq1nh65xvEp3Z0zI94s5Brc01Wcqgt0zsf+uRR6jtL
	 ZvYGSl9hvDrddeHQCtDL9mHLO51gnFs7Nn6GXvf1PCvaxJ3Bew/FSLBq8q6pnD+FF6
	 vMcmbRlkc3+7gxhK3zEp9bKucGWY7jhP9+dDgjSVBe7EGG8hJM4bsEuOu5NkEYy+8V
	 rEuu4pSjd/FKg==
Date: Tue, 25 Feb 2025 16:14:54 -0600
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
Subject: Re: [PATCH v5 2/4] ASoC: dt-bindings: xlnx,audio-formatter: Convert
 to json-schema
Message-ID: <20250225221454.GA3224894-robh@kernel.org>
References: <20250225190746.541587-1-vincenzo.frascino@arm.com>
 <20250225190746.541587-3-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225190746.541587-3-vincenzo.frascino@arm.com>

On Tue, Feb 25, 2025 at 07:07:44PM +0000, Vincenzo Frascino wrote:
> Convert the Xilinx Audio Formatter 1.0  device tree binding documentation
> to json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
>  .../bindings/sound/xlnx,audio-formatter.yaml  | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 29 deletions(-)
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
> index 000000000000..af892a9abdc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx PL audio formatter
> +
> +description:
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
> +      "interrupts".

Drop description.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: interrupt from MM2S block
> +      - description: interrupt from S2MM block
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: s_axi_lite_aclk
> +      - const: aud_mclk
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: clock for the axi data stream
> +      - description: clock for the MEMS microphone data stream
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
> +    audio_formatter@80010000 {
> +      compatible = "xlnx,audio-formatter-1.0";
> +      reg = <0x80010000 0x1000>;
> +      interrupt-names = "irq_mm2s", "irq_s2mm";
> +      interrupt-parent = <&gic>;
> +      interrupts = <0 104 4>, <0 105 4>;
> +      clock-names = "s_axi_lite_aclk", "aud_mclk";
> +      clocks = <&clk 71>, <&clk_wiz_1 0>;
> +    };
> +...
> -- 
> 2.43.0
> 

