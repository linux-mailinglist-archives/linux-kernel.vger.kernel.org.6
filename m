Return-Path: <linux-kernel+bounces-284361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496BF950032
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3E51C22ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CB195F3A;
	Tue, 13 Aug 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUxYqMxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21717CA0A;
	Tue, 13 Aug 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538542; cv=none; b=YOwCOuAxlw9YvTJ1yhL4uQCpheQ7UtPeKBhdIhmZ+kW0U8RU7DrbScu0I0CZTB602k+DwjLcGjOnlk0QNAVjlffdgqRQcGx37Y/Q0KWRb9zIhYMg/6/uVaeFlTPp2vT6gHuwCHcxx5+WoP76F5N75MBrRGRueK/LBxoDveJfKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538542; c=relaxed/simple;
	bh=cmBNhwLcmcbf8rZqlKMIjSvUsYcFWzgiMUxZqih0KBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HsoAcWB0A7NdaXbEBgcnpM+ho0YH8+9egjfLIdp9PYGVboyNdAU6edNFyacPTmqEiOZczvXrK6oD6uNM8vlD8PNUjf34aleZg0r81jEO7Cyf4JiHd7TtT8vXiUwaFv7Cl5FykIVZsStJjRFLqWfesBs5Lf0MozyDgZQ9us8ZRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUxYqMxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591F9C4AF10;
	Tue, 13 Aug 2024 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723538542;
	bh=cmBNhwLcmcbf8rZqlKMIjSvUsYcFWzgiMUxZqih0KBY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fUxYqMxyrFka/lkJZ29kvDwRYdCr5xdqYPxwCeop9NKC2Lhd5FAuxZJzh/PHpBK0l
	 5OoxKBjROBsyg7n5LMOr1D9NykqL5IwGg2qJp0Oong3YyiKcrO6jK0wjbJI6t3D/Yh
	 huFMK2EYhXEPvJRm9HTs1BF2EiLM+ZOa6DKSJXwP/fwydO+8Moir2vVFM2cN9wCgWV
	 ahHZVSj/oTEi0qC45NDqiZ4uQ+ADLXfvnFnskYy2FxNvQMcE1Pb1ISVbYXueGTo77K
	 lScrhd886ujb9JjTj1EePsgYTVyQ/UdCD4pDtnJNMEqtPEPhk0xwBYDrFucE2bjwWT
	 6wNnKt/B0Zzlg==
Message-ID: <9cc3ef01-6f95-4ce2-9e3d-cc679b50feb6@kernel.org>
Date: Tue, 13 Aug 2024 10:42:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
To: Kevin Chen <kevin_chen@aspeedtech.com>, tglx@linutronix.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-2-kevin_chen@aspeedtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240813074338.969883-2-kevin_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2024 09:43, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) combines 32 interrupt
> sources into 1 interrupt into GIC from CPU die to CPU die.
> The INTC design contains soc0_intc and soc1_intc module doing hand shake
> between CPU die and IO die INTC.
> 
> In soc0_intc11, each bit represent 1 GIC_SPI interrupt from soc1_intcX.
> In soc1_intcX, each bit represent 1 device interrupt in IO die.
> 
> By soc1_intcX in IO die, AST27XX INTC combines 32 interrupt sources to
> 1 interrupt source in soc0_intc11 in CPU die, which achieve the
> interrupt passing between the different die in AST27XX.
> ---

This was never tested. Please do not send untested code.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Limited review follows due to lack of basic testing.

>  .../aspeed,ast2700-intc.yaml                  | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> new file mode 100644
> index 000000000000..93d7141bf9f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Interrupt Controller driver

Drop driver, describe hardware. Aspeed or some specific SoC?

> +
> +description:
> +  These bindings are for the Aspeed interrupt controller. The AST2700

Drop first sentence. Pointless.

> +  SoC families include a legacy register layout before a re-designed
> +  layout, but the bindings do not prescribe the use of one or the other.

Entire description is pointless - you do not say anything valuable here.
Describe this hardware instead.


> +
> +maintainers:
> +  - Kevin Chen <kevin_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop

> +      - items:

Drop

> +        - enum:
> +          - aspeed,ast2700-intc-ic
> +          - aspeed,ast2700-intc-icv2
> +        description: |
> +          Use "aspeed,ast2700-intc-ic" for soc1 INTC in IO die
> +          Use "aspeed,ast2700-intc-icv2" for soc0 INTC in CPU die

Use consistent naming. Isn't your other block called 0 and 1? Why using
different namings?

> +
> +  interrupt-controller: true
> +
> +  interrupts-extended:

interrupts instead.

> +    minItems: 1
> +    maxItems: 3
> +    description:
> +      Specifies which contexts are connected to the INTC, with "-1" specifying
> +      that a context is not present. Each node pointed to should be a
> +      aspeed,ast2700-intc-ic or aspeed,ast2700-intc-icv2 nodes which are pointed
> +      to gic node.

Don't repeat constraints in free form text. Describe items instead.


> +
> +  "#address-cells":
> +    const: 2

Blank line

> +  "#size-cells":
> +    const: 2
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      The first cell cell is the interrupt source IRQ number, and the second cell
> +      is the trigger type as defined in interrupt.txt in this directory.
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      The first cell cell is the interrupt enable register, and the second cell
> +      is the status register.

List and describe the items instead.

> +
> +  ranges: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 10
> +    description: |
> +      Interrupt source of the CPU interrupts. In soc0_intc in CPU die INTC each bit
> +      represent soc1_intc interrupt source. soc0_intc take care 10 interrupt source
> +      from soc1_intc0~5 and ltpi0/1_soc1_intc0/1.

No, you cannot have both. That's total mess. Anyway, standard comment
applies - list and describe items.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +example:
> +  - |
> +    soc0_intc: interrupt-controller@12100000 {

Drop label

> +      compatible = "simple-mfd";

No, it's not. Drop. Look how other bindings do it.

> +      reg = <0 0x12100000 0 0x4000>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;

Read DTS coding style.

> +
> +      soc0_intc11: interrupt-controller@1b00 {

Drop label

> +        compatible = "aspeed,ast2700-intc-icv2";
> +        interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +        reg = <0x0 0x1b00 0x0 0x10>;

DTS coding style

> +      };
> +    };
> +
> +  - |
> +    soc1_intc: interrupt-controller@14c18000 {
> +      compatible = "simple-mfd";
> +      reg = <0 0x14c18000 0 0x400>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
> +
> +      soc1_intc0: interrupt-controller@100 {
> +       compatible = "aspeed,ast2700-intc-ic";

Drop this example, almost no differences.

Best regards,
Krzysztof


