Return-Path: <linux-kernel+bounces-571384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF1A6BC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5752D189AE7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872831C3BE9;
	Fri, 21 Mar 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khWlefwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30078F51;
	Fri, 21 Mar 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565723; cv=none; b=Ji0EtrzHQITvBh3VNYnrP2qJoj6AfcmTW78OpWjVXQ+tpMj/iMZ9GVXclQbvxC1WZ89AZZn+RBqqBcX7wBxiiF1xP+ToTukPyKjncEs4QkP+E+AwPA8NoqBU6osvc9JzSlS54tatK8o2dT5BGEyNouFFI67hTO2ndOlLmeeylcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565723; c=relaxed/simple;
	bh=Qwd1OjDeGAqCbYwL7o5MutzvzBIW/CFy3NKOIVcCn8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfbFNic+qvVekq48XuDAn4RTKQaWq3RVINLNNbhJdURiFJfwiY9WpX7dFAS7rqVow8qAchXBeq0pqUwgdLqVNyHjFh5trCa3bdO8Ayy0vxINsP8ThCkO6eOSoVlsijeNIdMLg2T+LNEg23UyhreKZcpRM2ePzi1mCG+SsrU0fb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khWlefwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4F3C4CEE3;
	Fri, 21 Mar 2025 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742565723;
	bh=Qwd1OjDeGAqCbYwL7o5MutzvzBIW/CFy3NKOIVcCn8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khWlefwOsoylPZURq7kqnVa8gnSh4gGlyyrQTxNpmwR0ypkBHylbIa4SNkDc0FVjS
	 tjup6w5tzsaTvdgc/pNsqBEBjocLL8IB/TM21LEsanaFN2nogKRUlZLn6qdqmGCkNG
	 erJckZQShNBg9ySGpuVGTIYr6btTyrRSiw9xpeEfEzzghAcX8QbeLphgfstKn7rTkE
	 ssKTN5Iv3L0xH0ZpkOihKSqyNNTc2YxtlUTGVeHjJwBkDggpZgjXsxC1gkhTzqRgkB
	 7KbWBevmapajfIlLhVHbHRsLb70wq2qrqWMg8D4S0lAWfFIO1raAbLZkELe8RKWl3L
	 rvcHqq+vpnJ0A==
Date: Fri, 21 Mar 2025 09:02:00 -0500
From: Rob Herring <robh@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, christophe.kerello@foss.st.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/7] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
Message-ID: <20250321140200.GA3192411-robh@kernel.org>
References: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
 <20250321-upstream_ospi_v6-v6-2-37bbcab43439@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-upstream_ospi_v6-v6-2-37bbcab43439@foss.st.com>

On Fri, Mar 21, 2025 at 10:32:22AM +0100, Patrice Chotard wrote:
> Add bindings for STM32 Octo Memory Manager (OMM) controller.
> 
> OMM manages:
>   - the muxing between 2 OSPI busses and 2 output ports.
>     There are 4 possible muxing configurations:
>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>         output is on port 2
>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>         OSPI2 output is on port 1
>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>   - the split of the memory area shared between the 2 OSPI instances.
>   - chip select selection override.
>   - the time between 2 transactions in multiplexed mode.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  .../memory-controllers/st,stm32mp25-omm.yaml       | 227 +++++++++++++++++++++
>  1 file changed, 227 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2f8fa7569009369ebd077e4c6f4ab409a91838a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
> @@ -0,0 +1,227 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32mp25-omm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32 Octo Memory Manager (OMM)
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +description: |
> +  The STM32 Octo Memory Manager is a low-level interface that enables an
> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
> +  function map) and multiplex of single/dual/quad/octal SPI interfaces over
> +  the same bus. It Supports up to:
> +    - Two single/dual/quad/octal SPI interfaces
> +    - Two ports for pin assignment
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-omm
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    description: |
> +      Reflects the memory layout with four integer values per OSPI instance.

You say 4 here...

> +      Format:
> +      <chip-select> 0 <registers base address> <size>
> +    minItems: 2
> +    maxItems: 2

And 2 here. I'm confused. From the example it doesn't look like you are 
using ranges correctly. If you are parsing it yourself, that's wrong. 
More below.

> +
> +  reg:
> +    items:
> +      - description: OMM registers
> +      - description: OMM memory map area
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: memory_map
> +
> +  memory-region:
> +    description: |
> +      Memory region shared between the 2 OCTOSPI instance.
> +      One or two phandle to a node describing a memory mapped region
> +      depending of child number.
> +    minItems: 1
> +    maxItems: 2
> +
> +  memory-region-names:
> +    description: |

Don't need '|'.

> +      OCTOSPI instance's name to which memory region is associated

That doesn't really tell me anything.

> +    items:
> +      enum: [ospi1, ospi2]
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      enum: [omm, ospi1, ospi2]

Define the order.

> +    minItems: 3
> +    maxItems: 3
> +
> +  resets:
> +    minItems: 3
> +    maxItems: 3
> +
> +  reset-names:
> +    items:
> +      enum: [omm, ospi1, ospi2]

Define the order.

> +    minItems: 3
> +    maxItems: 3
> +
> +  access-controllers:
> +    maxItems: 1
> +
> +  st,syscfg-amcr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      The Address Mapping Control Register (AMCR) is used to split the 256MB
> +      memory map area shared between the 2 OSPI instance. The Octo Memory
> +      Manager sets the AMCR depending of the memory-region configuration.
> +      The memory split bitmask description is:
> +        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
> +        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
> +        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
> +        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
> +        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
> +    items:
> +      - description: phandle to syscfg
> +      - description: register offset within syscfg
> +      - description: register bitmask for memory split
> +
> +  st,omm-req2ack-ns:
> +    description: |

Don't need '|'.

> +      In multiplexed mode (MUXEN = 1), this field defines the time in
> +      nanoseconds between two transactions.
> +    default: 0
> +
> +  st,omm-cssel-ovr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configure the chip select selector override for the 2 OCTOSPIs.
> +      - 0: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS1
> +      - 1: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS1
> +      - 2: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS2
> +      - 3: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS2
> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
> +  st,omm-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
> +      - 0: direct mode
> +      - 1: mux OCTOSPI1 and OCTOSPI2 to port 1
> +      - 2: swapped mode
> +      - 3: mux OCTOSPI1 and OCTOSPI2 to port 2
> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  ^spi@[a-f0-9]+$:
> +    type: object
> +    $ref: /schemas/spi/st,stm32mp25-ospi.yaml#
> +    description: Required spi child node
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - st,syscfg-amcr
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +    ommanager@40500000 {
> +      compatible = "st,stm32mp25-omm";
> +      reg = <0x40500000 0x400>, <0x60000000 0x10000000>;
> +      reg-names = "regs", "memory_map";
> +      ranges = <0 0 0x40430000 0x400>,
> +               <1 0 0x40440000 0x400>;

> +      #address-cells = <2>;
> +      #size-cells = <1>;
> +

> +      spi@40430000 {

ranges is okay, but the unit-address is wrong here. It should be based 
on reg below. So 'spi@0' or 'spi@0,0' since chip select is a distinct 
field. It's up to you, but you need to define the format in the schema.

> +        compatible = "st,stm32mp25-ospi";
> +        reg = <0 0 0x400>;
> +        memory-region = <&mm_ospi1>;
> +        interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&hpdma 2 0x62 0x00003121 0x0>,
> +               <&hpdma 2 0x42 0x00003112 0x0>;
> +        dma-names = "tx", "rx";
> +        clocks = <&scmi_clk CK_SCMI_OSPI1>;
> +        resets = <&scmi_reset RST_SCMI_OSPI1>, <&scmi_reset RST_SCMI_OSPI1DLL>;
> +        access-controllers = <&rifsc 74>;
> +        power-domains = <&CLUSTER_PD>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        st,syscfg-dlyb = <&syscfg 0x1000>;
> +      };
> +
> +      spi@40440000 {

spi@1,0

> +        compatible = "st,stm32mp25-ospi";
> +        reg = <1 0 0x400>;
> +        memory-region = <&mm_ospi1>;
> +        interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&hpdma 3 0x62 0x00003121 0x0>,
> +               <&hpdma 3 0x42 0x00003112 0x0>;
> +        dma-names = "tx", "rx";
> +        clocks = <&scmi_clk CK_KER_OSPI2>;
> +        resets = <&scmi_reset RST_SCMI_OSPI2>, <&scmi_reset RST_SCMI_OSPI1DLL>;
> +        access-controllers = <&rifsc 75>;
> +        power-domains = <&CLUSTER_PD>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        st,syscfg-dlyb = <&syscfg 0x1000>;
> +      };
> +    };
> 
> -- 
> 2.25.1
> 

