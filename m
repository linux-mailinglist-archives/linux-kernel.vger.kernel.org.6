Return-Path: <linux-kernel+bounces-283400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FEC94F1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B7D1F21010
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBE18732F;
	Mon, 12 Aug 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoD2mQnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A58186E29;
	Mon, 12 Aug 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477598; cv=none; b=NI/GMUtQQ7Gop08zpVGpxtl1l/36SrMlBLXVnxfNX6YrIUcrS8kBxgFgSwS1/207h/zCoEIpy4X8qz1bpSggrKqSN8Obi3VwJh1HkiqC0nru76uocN3KvNlK9/8+Z+IMGwXuAlmz4ZTumNZ6EvgkUtJEdS5UjwkUdqR1cUsfUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477598; c=relaxed/simple;
	bh=LVd9TGyp4d0U2ismMK0yyPmFgRWGEjHc5jVuSmjiEm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8FEj/ow+zOrG5ItwV6Zk3CpZAYPwBBxe3UXYkoBFwcFB4F3185HBosz/QD7Xk9kmExjVHFcTU+Pfj5x5BxhMDYN4JDSDPK5Gvzm6aw/8IZQgEyaKPi222A09C9YEZY308TtiUbmd568NjPN70YTWqSTy9IKkHPjo2TQkAqEzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoD2mQnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4695C32782;
	Mon, 12 Aug 2024 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477598;
	bh=LVd9TGyp4d0U2ismMK0yyPmFgRWGEjHc5jVuSmjiEm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoD2mQntD+Qh4IZ33zQCH33TBS1+jhJwVOkFTC88ccqNz+vbk4a1qjR8tpAs/JNM1
	 7+HVG6jxEkR5wxBW+sQnje5OJaZH7+k9smfyYW+MvJgsT8c17jVx9ASl3xvjqbS6VC
	 Lb70vfVA5PTDiul77Pntd8ZBwnRLESZMLsPN8RthDnz74nCCG77hl9CcTybBrPPOU2
	 yWeB0y7ZEaf+IZ3KAcQgNsL55sv6zenhpaMqbgjhn3mkmnsELCDR9vw8ZNG4SbSMbe
	 9dANZQy2FTlXAgEW5aKzumFK4bLZ9P1pXq40FkMqmcsAdBRy/cdBuaQ5nD8LMBHcxi
	 2aF3RXB2gTDpw==
Date: Mon, 12 Aug 2024 09:46:33 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: vkoul@kernel.org, kishon@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Message-ID: <20240812154633.GB593866-robh@kernel.org>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
 <20240812120529.3564390-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812120529.3564390-3-christian.bruel@foss.st.com>

On Mon, Aug 12, 2024 at 02:05:26PM +0200, Christian Bruel wrote:
> Document the bindings for STM32 COMBOPHY interface, used to support
> the PCIe and USB3 stm32mp25 drivers.
> Following entries can be used to tune caracterisation parameters
>  - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
> to tune the impedance and voltage swing using discrete simulation results
>  - st, phy_rx0_eq register to set the internal rx equalizer filter value.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/phy/st,stm32-combophy.yaml       | 178 ++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> new file mode 100644
> index 0000000000000..6a53ab834b2a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/st,stm32-combophy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32MP25 USB3/PCIe COMBOPHY
> +
> +maintainers:
> +  - Christian Bruel <christian.bruel@foss.st.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Single lane PHY shared (exclusive) between the USB3 and PCIe controllers.
> +  Supports 5Gbit/s for USB3 and PCIe gen2 or 2.5Gbit/s for PCIe gen1.
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-combophy
> +
> +  reg:
> +    maxItems: 1
> +
> +  st,syscfg:

Order is standard properties first, vendor properties second. 

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Phandle to the SYSCON entry required for configuring PCIe
> +      or USB3.

You need constraints on the size of the phandle-array or perhaps this 
should be just 'phandle'.

> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      The cells contain the following arguments.
> +
> +      - description: The PHY type
> +          enum:
> +            - PHY_TYPE_USB3
> +            - PHY_TYPE_PCIE
> +
> +  clocks:
> +    anyOf:

Should be 'items'

> +      - description: apb-clk Bus clock mandatory to access registers.
> +      - description: ker-clk Internal RCC reference clock for USB3 or PCIe
> +      - description: pad-clk Optional on board clock input for PCIe only. Typically an
> +                     external 100Mhz oscillator wired on dedicated CLKIN pad. Used as reference
> +                     clock input instead of the ker-clk
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: apb-clk
> +          - const: ker-clk
> +
> +      - items:
> +          - const: apb-clk
> +          - const: ker-clk
> +          - const: pad-clk

Don't need oneOf here. Just add 'minItems: 2' on the 2nd entry.

'-clk' is also redundant. Drop.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: phy-rst
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  st,ssc-on:
> +    type: boolean
> +    description:
> +      A boolean property whose presence indicates that the SSC for common clock
> +      needs to be set.
> +
> +  st,rx_equalizer:

s/_/-/

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0

That's already the minimum. Drop.

> +    maximum: 7
> +    default: 2
> +    description:
> +      A 3 bit value describing internal filter settings for the RX equalizer.

How does one decide what value to use?

> +
> +  st,output-micro-ohms:
> +    minimum: 3999000
> +    maximum: 6090000
> +    default: 4968000
> +    description:
> +      A value property to tune the Single Ended Output Impedance, simulations results
> +      at 25C for a VDDP=0.8V. The hardware accepts discrete values in this range.
> +
> +  st,output-vswing-microvolt:
> +    minimum: 442000
> +    maximum: 803000
> +    default: 803000
> +    description:
> +      A value property in microvolt to tune the Single Ended Output Voltage Swing to change the
> +      Vlo, Vhi for a VDDP = 0.8V. The hardware accepts discrete values in this range.
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +    description: interrupt used for wakeup
> +
> +  access-controllers:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - st,syscfg
> +  - '#phy-cells'
> +  - resets
> +  - reset-names
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      required:
> +        - wakeup-source
> +    then:
> +      anyOf:
> +        - required: [interrupts]
> +        - required: [interrupts-extended]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // Example 1: COMBOPHY configured to use internal reference clock
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +    combophy_internal: phy@480c0000 {
> +        compatible = "st,stm32mp25-combophy";
> +        reg = <0x480c0000 0x1000>;
> +        #phy-cells = <1>;
> +        clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>;
> +        clock-names = "apb-clk", "ker-clk";
> +        resets = <&rcc USB3PCIEPHY_R>;
> +        reset-names = "phy-rst";
> +        st,syscfg = <&syscfg>;
> +        access-controllers = <&rifsc 67>;
> +        power-domains = <&CLUSTER_PD>;
> +        wakeup-source;
> +        interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
> +    };
> +
> +  - |
> +    // Example 2: COMBOPHY configured to use extrenal 100MHz reference clock
> +    // on CLKIN pad for PCIe
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +    clocks {
> +        pad_clk: pad-clk {
> +            #clock-cells = <0>;
> +            compatible = "fixed-clock";
> +            clock-frequency = <100000000>;
> +        };
> +    };

Drop. Providers aren't relevant to this binding.

Though just 1 optional clock doesn't justify a whole other example. So 
drop one of the examples.

> +
> +    combophy_pad: phy@480c0000 {
> +        compatible = "st,stm32mp25-combophy";
> +        reg = <0x480c0000 0x1000>;
> +        #phy-cells = <1>;
> +        clocks = <&rcc CK_BUS_USB3PCIEPHY>, <&rcc CK_KER_USB3PCIEPHY>, <&pad_clk>;
> +        clock-names = "apb-clk", "ker-clk", "pad-clk";
> +        resets = <&rcc USB3PCIEPHY_R>;
> +        reset-names = "phy-rst";
> +        st,syscfg = <&syscfg>;
> +        access-controllers = <&rifsc 67>;
> +        power-domains = <&CLUSTER_PD>;
> +        wakeup-source;
> +        interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
> +    };
> +...
> -- 
> 2.34.1
> 

