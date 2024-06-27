Return-Path: <linux-kernel+bounces-232943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E291B04B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245B11F21572
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4919DF59;
	Thu, 27 Jun 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjZyqjio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304061BF58;
	Thu, 27 Jun 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519776; cv=none; b=ncJMz3rkPGOKHJDi5vdLbEC2YZyCdrJPl0ZGPTIvN+HIfUUbS+P0nfhvseAIwn3InUg2TMQ9EXJezNIfEFn+Z6d0f/W9cR9rt6cL0obeISkUCroIF8xdW08gPBamMKwyr3hhb5TydmRImIMjkCofwF9tuCaoUcFo5H2vcs+lnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519776; c=relaxed/simple;
	bh=giiTTsdZUF21D4ghdF2Pg3NLw3WIQrmPlZao298+PdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIvAdLFUG0J93DzIr1Cvu7cs/DJgFkGNOF7g+V9FP4NOqIE+RmTSqIO1YOzCNzNMNNnka6sqgEkBHMYwYY20vgmkZGtvioypZwfOCa3oIWn68x55yZ076tQV3Iuq3zj7Ija89Y/IVbNwomFuIDBTWLbj/R7iZy2XpteHYj5vwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjZyqjio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BCDC2BBFC;
	Thu, 27 Jun 2024 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719519775;
	bh=giiTTsdZUF21D4ghdF2Pg3NLw3WIQrmPlZao298+PdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjZyqjioiEsEy7FlMM01W/axEp0kj0UdS+5c9uAaNglsHmGiHF2IXpacuVUztuwpJ
	 DeGYGNDpk/nyjkcs3dL7TlxARf1YQp0UWoMqcTvuRbnLVAPfGgzZAjYf7YI9AVYHAO
	 6sLvMauP8nGbv7wDnCx7ACQHYHpBX5urXHmvFV3ey+ux0NCt2dKPwsQ0z8vsBJmid8
	 JgjmJ5mBB911oZSmdhY9U3+4zkdCvet85AvK3vMOQh1Ot+UH4f6a8OHS2eMDZRJYHS
	 CMZ0mgS50odSKWF8KfUB5/13j8joPG2thoBpvYKyBd2auzAOpNVOVygZzp89Bx15Qg
	 213RFUO8RuMZg==
Date: Thu, 27 Jun 2024 14:22:54 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: clock: qoriq-clock: convert to yaml
 format
Message-ID: <20240627202254.GA454755-robh@kernel.org>
References: <20240617181410.921090-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617181410.921090-1-Frank.Li@nxp.com>

On Mon, Jun 17, 2024 at 02:14:09PM -0400, Frank Li wrote:
> Convert qoria-clock DT binding to yaml format. Split to two files
> qoriq-clock.yaml and qoriq-clock-legancy.yaml.
> 
> Addtional change:
> - Remove clock consumer part in example
> - Fixed example dts error
> - Deprecated legancy node
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../clock/fsl,qoriq-clock-legacy.yaml         |  84 +++++++
>  .../bindings/clock/fsl,qoriq-clock.yaml       | 203 +++++++++++++++++
>  .../devicetree/bindings/clock/qoriq-clock.txt | 212 ------------------
>  3 files changed, 287 insertions(+), 212 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/qoriq-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
> new file mode 100644
> index 0000000000000..97b96a1a58254
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,qoriq-clock-legacy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Legacy Clock Block on Freescale QorIQ Platforms
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +  These nodes are deprecated.  Kernels should continue to support
> +  device trees with these nodes, but new device trees should not use them.
> +
> +  Most of the bindings are from the common clock binding[1].
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,qoriq-core-pll-1.0
> +      - fsl,qoriq-core-pll-2.0
> +      - fsl,qoriq-core-mux-1.0
> +      - fsl,qoriq-core-mux-2.0
> +      - fsl,qoriq-sysclk-1.0
> +      - fsl,qoriq-sysclk-2.0
> +      - fsl,qoriq-platform-pll-1.0
> +      - fsl,qoriq-platform-pll-2.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 8
> +
> +  '#clock-cells':
> +    minimum: 0
> +    maximum: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,qoriq-sysclk-1.0
> +              - fsl,qoriq-sysclk-2.0
> +    then:
> +      properties:
> +        '#clock-cells':
> +          const: 0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,qoriq-core-pll-1.0
> +              - fsl,qoriq-core-pll-2.0
> +    then:
> +      properties:
> +        '#clock-cells':
> +          const: 1
> +          description: |
> +            * 0 - equal to the PLL frequency
> +            * 1 - equal to the PLL frequency divided by 2
> +            * 2 - equal to the PLL frequency divided by 4
> +
> diff --git a/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
> new file mode 100644
> index 0000000000000..d641756b04635
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,qoriq-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock Block on Freescale QorIQ Platforms
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +

Just 1 blank line

> +description: |
> +

drop blank line

> +  Freescale QorIQ chips take primary clocking input from the external
> +  SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> +  multiple phase locked loops (PLL) to create a variety of frequencies
> +  which can then be passed to a variety of internal logic, including
> +  cores and peripheral IP blocks.
> +  Please refer to the Reference Manual for details.
> +
> +  All references to "1.0" and "2.0" refer to the QorIQ chassis version to
> +  which the chip complies.
> +
> +  Chassis Version    Example Chips
> +  ---------------    -------------
> +       1.0      p4080, p5020, p5040
> +       2.0      t4240, b4860
> +
> +  Clock Provider
> +
> +  The clockgen node should act as a clock provider, though in older device
> +  trees the children of the clockgen node are the clock providers.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,p2041-clockgen
> +          - fsl,p3041-clockgen
> +          - fsl,p4080-clockgen
> +          - fsl,p5020-clockgen
> +          - fsl,p5040-clockgen
> +          - fsl,t1023-clockgen
> +          - fsl,t1024-clockgen
> +          - fsl,t1040-clockgen
> +          - fsl,t1042-clockgen
> +          - fsl,t2080-clockgen
> +          - fsl,t2081-clockgen
> +          - fsl,t4240-clockgen
> +          - fsl,b4420-clockgen
> +          - fsl,b4860-clockgen

> +          - fsl,ls1012a-clockgen
> +          - fsl,ls1021a-clockgen
> +          - fsl,ls1028a-clockgen
> +          - fsl,ls1043a-clockgen
> +          - fsl,ls1046a-clockgen
> +          - fsl,ls1088a-clockgen
> +          - fsl,ls2080a-clockgen
> +          - fsl,lx2160a-clockgen

It doesn't look to me like these platforms use this binding.

> +      - enum:
> +          - fsl,qoriq-clockgen-1.0
> +          - fsl,qoriq-clockgen-2.0

This allows invalid combinations. You need 2 entries splitting 1.0 and 
2.0.

> +    minItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  '#clock-cells':
> +    const: 2
> +    description: |
> +      The first cell of the clock specifier is the clock type, and the
> +      second cell is the clock index for the specified type.
> +
> +        Type#  Name       Index Cell
> +        0  sysclk          must be 0
> +        1  cmux            index (n in CLKCnCSR)
> +        2  hwaccel         index (n in CLKCGnHWACSR)
> +        3  fman            0 for fm1, 1 for fm2
> +        4  platform pll    n=pll/(n+1). For example, when n=1,
> +                          that means output_freq=PLL_freq/2.
> +        5  coreclk         must be 0
> +
> +  clock-frequency:
> +    description: Input system clock frequency (SYSCLK)
> +
> +  clocks:
> +    items:
> +      - description:
> +          sysclk may be provided as an input clock.  Either clock-frequency
> +          or clocks must be provided.
> +      - description:
> +          A second input clock, called "coreclk", may be provided if
> +          core PLLs are based on a different input clock from the
> +          platform PLL.
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: coreclk
> +
> +patternProperties:
> +  '^mux[0-9]@[a-f0-9]+$':
> +    deprecated: true
> +    $ref: fsl,qoriq-clock-legacy.yaml
> +
> +  '^sysclk+$':

This means 'sysclkkkkkkkkkk' is valid.

> +    deprecated: true
> +    $ref: fsl,qoriq-clock-legacy.yaml
> +
> +  '^pll[0-9]@[a-f0-9]+$':
> +    deprecated: true
> +    $ref: fsl,qoriq-clock-legacy.yaml
> +
> +  '^platform\-pll@[a-f0-9]+$':
> +    deprecated: true
> +    $ref: fsl,qoriq-clock-legacy.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* clock provider example */
> +    global-utilities@e1000 {
> +        compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +        reg = <0xe1000 0x1000>;
> +        clock-frequency = <133333333>;
> +        #clock-cells = <2>;
> +    };
> +
> +  - |
> +    /* Legacy example */
> +    global-utilities@e1000 {
> +        compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +        reg = <0xe1000 0x1000>;
> +        ranges = <0x0 0xe1000 0x1000>;
> +        clock-frequency = <133333333>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        #clock-cells = <2>;
> +
> +        sysclk: sysclk {
> +            compatible = "fsl,qoriq-sysclk-1.0";
> +            clock-output-names = "sysclk";
> +            #clock-cells = <0>;
> +        };
> +
> +        pll0: pll0@800 {
> +            compatible = "fsl,qoriq-core-pll-1.0";
> +            reg = <0x800 0x4>;
> +            #clock-cells = <1>;
> +            clocks = <&sysclk>;
> +            clock-output-names = "pll0", "pll0-div2";
> +        };
> +
> +        pll1: pll1@820 {
> +            compatible = "fsl,qoriq-core-pll-1.0";
> +            reg = <0x820 0x4>;
> +            #clock-cells = <1>;
> +            clocks = <&sysclk>;
> +            clock-output-names = "pll1", "pll1-div2";
> +        };
> +
> +        mux0: mux0@0 {
> +            compatible = "fsl,qoriq-core-mux-1.0";
> +            reg = <0x0 0x4>;
> +            #clock-cells = <0>;
> +            clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +            clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> +            clock-output-names = "cmux0";
> +        };
> +
> +        mux1: mux1@20 {
> +            compatible = "fsl,qoriq-core-mux-1.0";
> +            reg = <0x20 0x4>;
> +            #clock-cells = <0>;
> +            clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +            clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> +            clock-output-names = "cmux1";
> +        };
> +
> +        platform-pll@c00 {
> +            #clock-cells = <1>;
> +            reg = <0xc00 0x4>;
> +            compatible = "fsl,qoriq-platform-pll-1.0";
> +            clocks = <&sysclk>;
> +            clock-output-names = "platform-pll", "platform-pll-div2";
> +        };
> +    };

