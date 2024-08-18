Return-Path: <linux-kernel+bounces-291104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774EE955D57
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC361F212F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF7145335;
	Sun, 18 Aug 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1t1lls7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82812942A;
	Sun, 18 Aug 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997066; cv=none; b=MAtPK8m/yGz7PIcHoTMcFPkphDanlnVDdHIeUBjyKVFZt5roUoXOg4av9Uv2EHmOBpOab5uJF3gisENlnkxsOxQvcD9Sx5AOG5KpjOYjsri/abz4FkdUqpEUTvQ6opQdEtRZRBvCoeTCGqZHSGBwYbJMGITA/PzuNzUumZdLj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997066; c=relaxed/simple;
	bh=zOh8sLLniupBfxa1ZvD5qt1zclMnT9P4G1dPyjbnZjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBznKCGUA16jIEdI96X8pBNXcBshbj34EHekHQVPyAQGO4Dpn6t5qobibkhVzH3VZP3UUuY7nrLrCZygWVTPSGY7BoaTnxtMGCW/1zUyr8b9caPXHrT3da6B8J6N3Sy9TSDZJ+lgmAHXLldzdlKNsx0MJRbH01cC694vMXwk/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1t1lls7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD504C32786;
	Sun, 18 Aug 2024 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723997066;
	bh=zOh8sLLniupBfxa1ZvD5qt1zclMnT9P4G1dPyjbnZjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1t1lls702regXytE2r0csn0P8XdquKfZFZqW1TtFiWw6klyVviJ395rc8ifokGma
	 WbR/2hGw0+yowaxddFwvYwokfFrqY7V59659EaaHkQNO85ap/S+jI/3W2lHml2w8P6
	 tCVf/m+ZpcOKbm4plSyiLyFcks7j/VY1BU7oEnPt7T+HVenrgp5b+gkbqJJrGtUB6u
	 YwPvk539p/XSwOzfbMZc9iLnce9jONEljnfOyuSxbgafjGs1pWp1lmdhYhZg2vQ1v4
	 skdSlVAmRg0Yft1nFsDdJCLxVXtF8HCcFlWMkwyoMlvCTNGn1XxbyGmknKzxp+7322
	 pGIqzJGy7WFXA==
Date: Sun, 18 Aug 2024 10:04:24 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: vkoul@kernel.org, kishon@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Message-ID: <20240818160424.GA156214-robh@kernel.org>
References: <20240816132058.920870-1-christian.bruel@foss.st.com>
 <20240816132058.920870-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816132058.920870-3-christian.bruel@foss.st.com>

On Fri, Aug 16, 2024 at 03:20:54PM +0200, Christian Bruel wrote:
> Document the bindings for STM32 COMBOPHY interface, used to support
> the PCIe and USB3 stm32mp25 drivers.
> Following entries can be used to tune caracterisation parameters
>  - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
> to tune the impedance and voltage swing using discrete simulation results
>  - st,rx-equalizer register to set the internal rx equalizer filter value.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/phy/st,stm32-combophy.yaml       | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> new file mode 100644
> index 000000000000..c33a843b83a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/st,stm32-combophy.yaml
> @@ -0,0 +1,144 @@
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
> +description:
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
> +    minItems: 2
> +    items:
> +      - description: apb Bus clock mandatory to access registers.
> +      - description: ker Internal RCC reference clock for USB3 or PCIe
> +      - description: pad Optional on board clock input for PCIe only. Typically an
> +                     external 100Mhz oscillator wired on dedicated CLKIN pad. Used as reference
> +                     clock input instead of the ker
> +
> +  clock-names:
> +    minItems: 2
> +    items:
> +      - const: apb
> +      - const: ker
> +      - const: pad
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: phy
> +
> +  power-domains:
> +    maxItems: 1
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
> +  st,syscfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the SYSCON entry required for configuring PCIe
> +      or USB3.
> +
> +  st,ssc-on:
> +    type: boolean
> +    description:
> +      A boolean property whose presence indicates that the SSC for common clock
> +      needs to be set.
> +
> +  st,rx-equalizer:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    default: 2
> +    description:
> +      A 3 bit value to tune the RX fixed equalizer setting for optimal eye compliance
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

Drop this if/then. We should have this somewhere common as it applies to 
all.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

