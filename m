Return-Path: <linux-kernel+bounces-288040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCE953202
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398D81C2550F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1891A00D2;
	Thu, 15 Aug 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jotzu189"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFC1714DD;
	Thu, 15 Aug 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730447; cv=none; b=BQ7Ar0islmmw7f4nMBnNN5ITi0xcZ0Pb/rwy1TKjPqPM40s81c/4COiAsV4EcFv4gr23ausj+NwbYeIlgAmz5FThgxj7zLILqWUF7vRD2txFv7MrIHxTO1vgHCDNfk9qwVCeqEfBtjUVFzD0YMKpgWjW7+FgAbZVhf3T6Xh84sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730447; c=relaxed/simple;
	bh=avF0waIXW3oC4mIuE5GszUpK9JDdRDAPcduvKDcqL1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwd4RaXMFdW0T0HCo9CK/cWYmR3K/2+GDt95pPPdQjes1ur9opk0zS+YWwVwpmUSgA5v3cyiyBhiMT65wxxAQlZiDchm4VZHyXybNaN8Ij1SEcII9uOijcjeniSH0DM3wM4eTYOAwvKw7vMx8BLqhh3aYYx7iVXoLJEwiFAPK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jotzu189; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2D0C4AF0A;
	Thu, 15 Aug 2024 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730446;
	bh=avF0waIXW3oC4mIuE5GszUpK9JDdRDAPcduvKDcqL1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jotzu189DFg3Ku337TsDCr+jWl+GUrLFCDft2tSMT9nnQKmdRgxMHaLzJEWG1vC3S
	 Lpi2sKWalgyofAY84rMlCi+2siVaM1XEDUe0a/flyQFhJtaPdtt4lzTPkSKND7rOBM
	 xpRCcC7rxcIkvlkRjGE1GIIFF2VKM2V0plJ+4OX09jBl/cy+7ckqhbOjEP+4B7kXlV
	 X1i64qZeZe+l9FhR0CY/arvYwnYStmFF0RM+NNlzkC7TYaRzqjSU+2h6b4NrccCK34
	 KNSTx6qApm3i5dHhcnv+AWAnIykCJpsrXDfpqJoz4gV+bNuWRKwrF43ysDEtv16j5O
	 zAg61xHH5xCww==
Date: Thu, 15 Aug 2024 08:00:46 -0600
From: Rob Herring <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <20240815140046.GA1603296-robh@kernel.org>
References: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP>

On Thu, Aug 15, 2024 at 12:26:29PM +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> filename to match the compatible of the only in-tree user, SC2731.
> Change #interrupt-cells value to 1, as according to [1] that is the
> correct value.
> 
> [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Depends on:
>   - eFuse YAML conversion: https://lore.kernel.org/lkml/9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com/
>   - RTC YAML conversion: https://lore.kernel.org/lkml/ZrBzmQI0IAL7LI3e@standask-GA-A55M-S2HP/

These either have to be sent as 1 series for 1 maintainer to apply (Lee) 
or you'll have to wait a cycle for the dependencies.

> 
>  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 124 ++++++++++++++++++
>  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ------
>  2 files changed, 124 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> new file mode 100644
> index 000000000000..59df02e1e53b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sprd,sc2731.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SC27xx PMIC
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description: |
> +  Spreadtrum PMICs belonging to the SC27xx series integrate all mobile handset
> +  power management, audio codec, battery management and user interface support
> +  functions in a single chip. They have 6 major functional blocks:
> +    - DCDCs to support CPU, memory
> +    - LDOs to support both internal and external requirements
> +    - Battery management system, such as charger, fuel gauge
> +    - Audio codec
> +    - User interface functions, such as indicator, flash LED and so on
> +    - IC level interface, such as power on/off control, RTC, typec and so on
> +
> +properties:
> +  $nodename:
> +    pattern: '^pmic@[0-9a-f]+$'
> +
> +  compatible:
> +    enum:
> +      - sprd,sc2720
> +      - sprd,sc2721
> +      - sprd,sc2723
> +      - sprd,sc2730
> +      - sprd,sc2731
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +  spi-max-frequency: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
> +
> +patternProperties:
> +  "^adc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/iio/adc/sprd,sc2720-adc.yaml#
> +
> +  "^charger@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/power/supply/sc2731-charger.yaml#
> +
> +  "^efuse@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
> +
> +  "^fuel-gauge@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/power/supply/sc27xx-fg.yaml#
> +
> +  "^gpio@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/gpio/sprd,gpio-eic.yaml#
> +
> +  "^led-controller@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/leds/sprd,sc2731-bltc.yaml#
> +
> +  "^rtc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/rtc/sprd,sc2731-rtc.yaml#
> +
> +  "^vibrator@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/input/sprd,sc27xx-vibrator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - spi-max-frequency
> +  - '#address-cells'
> +  - '#interrupt-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@0 {
> +        compatible = "sprd,sc2731";
> +        reg = <0>;
> +        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        spi-max-frequency = <26000000>;
> +        #address-cells = <1>;
> +        #interrupt-cells = <1>;
> +        #size-cells = <0>;

The preference is one complete example here and drop any partial 
examples of the child nodes in the child node schemas.

> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> deleted file mode 100644
> index 21b9a897fca5..000000000000
> --- a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Spreadtrum SC27xx Power Management Integrated Circuit (PMIC)
> -
> -The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730
> -and SC2731. The Spreadtrum PMIC belonging to SC27xx series integrates all
> -mobile handset power management, audio codec, battery management and user
> -interface support function in a single chip. It has 6 major functional
> -blocks:
> -- DCDCs to support CPU, memory.
> -- LDOs to support both internal and external requirement.
> -- Battery management system, such as charger, fuel gauge.
> -- Audio codec.
> -- User interface function, such as indicator, flash LED and so on.
> -- IC level interface, such as power on/off control, RTC and typec and so on.
> -
> -Required properties:
> -- compatible: Should be one of the following:
> -	"sprd,sc2720"
> -	"sprd,sc2721"
> -	"sprd,sc2723"
> -	"sprd,sc2730"
> -	"sprd,sc2731"
> -- reg: The address of the device chip select, should be 0.
> -- spi-max-frequency: Typically set to 26000000.
> -- interrupts: The interrupt line the device is connected to.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -- #interrupt-cells: The number of cells to describe an PMIC IRQ, must be 2.
> -- #address-cells: Child device offset number of cells, must be 1.
> -- #size-cells: Child device size number of cells, must be 0.
> -
> -Example:
> -pmic@0 {
> -	compatible = "sprd,sc2731";
> -	reg = <0>;
> -	spi-max-frequency = <26000000>;
> -	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-controller;
> -	#interrupt-cells = <2>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -};
> -- 
> 2.34.1
> 

