Return-Path: <linux-kernel+bounces-530113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A961A42F38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F3218928A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CA469D;
	Mon, 24 Feb 2025 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqj/vsks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DA1C8621;
	Mon, 24 Feb 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432811; cv=none; b=brZqsQO0YC7F/LxtjZEo7b5b9psxDc/OmzjrmnarpVdKoV1Ecq2GpWfIo1cO+tJigQBu2HM0gaYf82pILneCy/p51eAFwJthFAvmioVTO8qcPce1jt1H5CgmonGjjfeC/Fa7IAY9XyO4dTiCa7EwjukW2FoDimlhvN+YaM+W3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432811; c=relaxed/simple;
	bh=9HjqOTzB0ZWkUjJj4bfaVy2BMPhz6StSpstkHw9pnOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOMpTvhdjsDV9jPI5qBO/ie3OcDoxMUcEIamAc+bSDvWfGUh7R8eIblAq+EsnLq44D2KCP7WbkFsTRaXzKIrdDcJGRiAdAjGwKJYw+oq9M7XAMNcgJjwclBRtyJekG60+klvD0imzwDwlaV4RdW9W8+jSHoq27U+5bG/DEqJS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqj/vsks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3948DC4CED6;
	Mon, 24 Feb 2025 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740432810;
	bh=9HjqOTzB0ZWkUjJj4bfaVy2BMPhz6StSpstkHw9pnOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uqj/vsksO6F0MSH5GCmObkOaFAgMuMpG0CJzdilCS7OqQ0aMwPONo1h/VdTGr4noZ
	 BfpV2XTAmHDlZrQD5fCT3CAYYEO2iAvWixYIMBd69m/lYVaz8pDvuqFqSwhbLeTcPT
	 zJFaGS0qvnmPrD2E8nt/YZgpzA09+HFajAIt6EKNsEQXbis+y/M50RNd/zryEhCcRV
	 TD2On5Irsd/UDDTS6wHx9jU7LHys3S5BcEr2OrrfmUMN9lpF79Yxwplu3d7Mnd6js2
	 A29SqD9ZSQ77j0CXZIvvwBufM/ySZGvzIeLfE5Dqu73YYGGYVmwLLZNU5+2vl0L5v5
	 w0IYEK/w2zgyA==
Date: Mon, 24 Feb 2025 15:33:28 -0600
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
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: xlnx,spdif: Convert to
 json-schema
Message-ID: <20250224213328.GB4107125-robh@kernel.org>
References: <20250224182548.2715896-1-vincenzo.frascino@arm.com>
 <20250224182548.2715896-4-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182548.2715896-4-vincenzo.frascino@arm.com>

On Mon, Feb 24, 2025 at 06:25:47PM +0000, Vincenzo Frascino wrote:
> Convert the Xilinx SPDIF 2.0 device tree binding documentation to
> json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 ------
>  .../devicetree/bindings/sound/xlnx,spdif.yaml | 85 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
> deleted file mode 100644
> index 15c2d64d247c..000000000000
> --- a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Device-Tree bindings for Xilinx SPDIF IP
> -
> -The IP supports playback and capture of SPDIF audio
> -
> -Required properties:
> - - compatible: "xlnx,spdif-2.0"
> - - clock-names: List of input clocks.
> -   Required elements: "s_axi_aclk", "aud_clk_i"
> - - clocks: Input clock specifier. Refer to common clock bindings.
> - - reg: Base address and address length of the IP core instance.
> - - interrupts-parent: Phandle for interrupt controller.
> - - interrupts: List of Interrupt numbers.
> - - xlnx,spdif-mode: 0 :- receiver mode
> -		    1 :- transmitter mode
> - - xlnx,aud_clk_i: input audio clock value.
> -
> -Example:
> -	spdif_0: spdif@80010000 {
> -		clock-names = "aud_clk_i", "s_axi_aclk";
> -		clocks = <&misc_clk_0>, <&clk 71>;
> -		compatible = "xlnx,spdif-2.0";
> -		interrupt-names = "spdif_interrupt";
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 91 4>;
> -		reg = <0x0 0x80010000 0x0 0x10000>;
> -		xlnx,spdif-mode = <1>;
> -		xlnx,aud_clk_i = <49152913>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> new file mode 100644
> index 000000000000..ad0b40a12c2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,spdif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx SPDIF IP
> +
> +description:
> +  The IP supports playback and capture of SPDIF audio.
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
> +      - xlnx,spdif-2.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: spdif_interrupt
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      List of Interrupt numbers.

Drop description.

> +
> +  clock-names:
> +    items:
> +      - const: aud_clk_i
> +      - const: s_axi_aclk
> +    description: |
> +      List of input clocks.

Drop

> +
> +  clocks:
> +    maxItems: 2
> +    description: |
> +      Input clock specifier. Refer to common clock bindings.

Drop

> +
> +  xlnx,spdif-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0
> +      - 1
> +    description: |
> +      0 - receiver
> +      1 - transmitter
> +
> +  xlnx,aud_clk_i:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |

Drop '|'

> +      Input audio clock value.

Is value the frequency? If you know more detail, please add it.

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
> +    spdif_0: spdif@80010000 {

Drop unused labels.

> +      clock-names = "aud_clk_i", "s_axi_aclk";
> +      clocks = <&misc_clk_0>, <&clk 71>;
> +      compatible = "xlnx,spdif-2.0";

'compatible' goes first. Then reg. See 
Documentation/devicetree/bindings/dts-coding-style.rst for more details.

> +      interrupt-names = "spdif_interrupt";
> +      interrupt-parent = <&gic>;
> +      interrupts = <0 91 4>;
> +      reg = <0x80010000 0x10000>;
> +      xlnx,spdif-mode = <1>;
> +      xlnx,aud_clk_i = <49152913>;
> +    };
> +
> +...
> -- 
> 2.43.0
> 

