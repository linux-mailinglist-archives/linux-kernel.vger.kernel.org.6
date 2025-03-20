Return-Path: <linux-kernel+bounces-569380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A7A6A214
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D0B3A367D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676E21481E;
	Thu, 20 Mar 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK8MGuqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFBD2FB;
	Thu, 20 Mar 2025 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461617; cv=none; b=edVJAVwMPO7Wkkms6KLWsjQ6ygc8MvFUYfNz/BaG22JwNdsS/slwsi70Lx/aqK+yoVtIhdKoviUiDb/MgKib4qmuyvmq5PwXneXqWytlL36mUGncRmwgbTmDcB0ynPr7juPeFM5oaN71DuNNO6eZyLHcrOs4QboX4swb11HenHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461617; c=relaxed/simple;
	bh=pfQ50DScHy5B2hGnA/xfElhuDtGGC1uqaV5CxJ3vKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shRhtJ2Wz42bWkjY02C+ImSuz+KuV/uV3h8cV41D1LKySQav6YfRBD/Fkv19G47YztjxQ1qr17z5S3HmQJZ3Wcloo+Rnk9yLmLwmaydZcZICl8JOU1URFiJhzgGq6j35otUplyIwj8LnQUSYE8vNWL+ce+dKNHPwfN05tejpLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK8MGuqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0D0C4CEDD;
	Thu, 20 Mar 2025 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742461616;
	bh=pfQ50DScHy5B2hGnA/xfElhuDtGGC1uqaV5CxJ3vKgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK8MGuqUeyd5bwCQSPsxOFNGfg/DLAGcO/YG8RTKbVY4pCMGLLvlwDmCVj88SKLkr
	 SLv0ZjGu/pHxMW0vQyHogtyIo6Q4cU4wTbB/nvljDfOwJhXqyRyW1/YaOKpE+YF3cw
	 /2e+mdquudcqcdnmkuGTw/cxIdMXG84kf5CjLGhXwQv5wci3F4WJBDeFol2B7D4USs
	 mvbLvuJ/eJa/1JJ9MucQlzGo2UAXmKH2Ygk15kuZiceYbc+oQiQms88wBO7eJoU7b4
	 GNeOlvS5K4rjl2ls3SiIcdJjWy4l8Zkz09rQj1MIVqhR0tqy6578R1H1wRtnqpKZsA
	 gY+rXi4CrmvAw==
Date: Thu, 20 Mar 2025 10:06:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Message-ID: <20250320-unbiased-cooperative-coyote-e7e255@krzk-bin>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
 <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>

On Thu, Mar 20, 2025 at 02:53:54PM +0800, Alexis Czezar Torreno wrote:
> Add documentation for devicetree bindings for ADP5055. The device consists
> of 3 buck regulators able to connect to high input voltages of up to 18V
> with no preregulators.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters


> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> ---
>  .../bindings/regulator/adi,adp5055-regulator.yaml  | 161 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 167 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..fc8f1e61ba321f8b4c6f8c1e3d0e91d570fb4953
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,adp5055-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADP5055 Triple Buck Regulator
> +
> +maintainers:
> +  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> +
> +description: |
> +  The ADP5055 combines three high performance buck regulators.
> +  The device enables direct connection to high input voltages
> +  up to 18 V with no preregulators.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adp5055.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adp5055
> +
> +  reg:
> +    enum:
> +      - 0x70
> +      - 0x71
> +
> +  adi,tset-us:
> +    description:
> +      Setting time used by the device. This is changed via soldering
> +      specific resistor values on the CFG2 pin.
> +    enum: [2600, 20800]
> +    default: 2600
> +
> +  adi,hw-en-array-gpios:

Drop prefix, drop "array" and this probably will be changed anyway.

> +    description:
> +      Asserted during driver probe. Each array entry acts as the

s/Asserted during driver probe.//
If driver moves this code to other place, does it mean bindings are
wrong?

> +      hardware enable for channels 0-2. Should be marked 0 for active

What does it mean "0" for active low? No, active low has its own flag.

Use proper flags and implement it properly in the driver.

What is hardware enable and software enable? Is it enable-gpios per
regulator? Then why this isn't in the regulator node, just like we
expect for all regulator bindings?


> +      low. Requires all three channels to be initialized. Not adding
> +      the property turns the system to a software only enable mode.
> +    minItems: 3
> +    maxItems: 3
> +
> +  adi,ocp-blanking:
> +    description:
> +      If present, the over current protection
> +      blanking (OCP) for all channels is on.

Don't
wrap
at
random
places, plese.

> +    type: boolean
> +
> +  adi,delay-power-good:
> +    description:
> +      Configures delay timer of the power good (PWRGD) pin.
> +      Delay is based on Tset which can be 2.6 ms or 20.8 ms.
> +    type: boolean
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@([0-2])$":

This is a mess... never tested and makes no sense. Either this is a
regulator or a channel. Looks like regulator, but you called it a
channel. If regulator, then missing ref to regulator schema.

> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number representing each buck converter.
> +        maximum: 2
> +
> +      adi,dvs-limit-upper-microvolt:
> +        description:
> +          Configure the allowable upper side limit of the
> +          voltage output of each channel in microvolt.
> +          Voltages are in 12mV steps, value is autoadjusted.
> +          Vout_high = Vout + DVS_upper_limit.

And how do you configure vout?

> +        minimum: 12000
> +        maximum: 192000
> +        default: 192000
> +
> +      adi,dvs-limit-lower-microvolt:
> +        description:
> +          Configure the allowable lower side limit of the
> +          voltage output of each channel in microvolt.
> +          Voltages are in 12mV steps, value is autoadjusted.
> +          Vout_low = Vout + DVS_lower_limit.
> +        minimum: -190500
> +        maximum: -10500
> +        default: -190500
> +
> +      adi,fast-transient:
> +        description:
> +          Configures the fast transient sensitivity for each channel.
> +          "none"    - No fast transient.
> +          "3G_1.5%" - 1.5% window with 3*350uA/V
> +          "5G_1.5%" - 1.5% window with 5*350uA/V
> +          "5G_2.5%" - 2.5% window with 5*350uA/V
> +        enum: [none, 3G_1.5%, 5G_1.5%, 5G_2.5%]
> +        default: 5G_2.5%
> +
> +      adi,mask-power-good:
> +        description:
> +          If present, masks individual channels to the external
> +          PWRGD hardware pin.
> +        type: boolean
> +
> +    required:
> +      - regulator-name
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        regulator@70 {
> +            compatible = "adi,adp5055";
> +            reg = <0x70>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            adi,tset-us = <2600>;
> +            adi,hw-en-array-gpios = <&gpio 17 0>,
> +                                    <&gpio 18 0>,
> +                                    <&gpio 19 0>;

No, use proper defines and proper flags.

> +
> +            adi,ocp-blanking;
> +            adi,delay-power-good;
> +
> +            DCDC0 {

Your schema said something else. Test your patches before sending, not
through our systems.

Best regards,
Krzysztof


