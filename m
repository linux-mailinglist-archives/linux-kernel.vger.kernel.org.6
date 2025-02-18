Return-Path: <linux-kernel+bounces-520492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A7A3AA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1C188437F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648517A305;
	Tue, 18 Feb 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkAXaaq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA31286287;
	Tue, 18 Feb 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912792; cv=none; b=AxUe8xaFKAiLq5EST0vUxi68ogEDozAiYuBYt/Pe51gzx9Uy3FD+ltAgetBBfwBcan7/hGOopjO9wJkDQzhzX/EsqScJg0YOcKneOxME62SJgGhHmMl3iJHjRe9GuvCGGMK5ZlidmZXKJSzwBkaWmVA21Osm48cx0Bhli/qX5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912792; c=relaxed/simple;
	bh=Ujq/Cshpoqlc2MZdqCW+vNYrNYOrc8GstJJyKD/k94g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1WpzJ46eSRRkMjR5PdcZbnaR0Oow85RM7F6uLKeP0A4MVOmr11unzjkbnAUAxwAzafw7jLjjZl2PRnddQsCyPpaHA8sGw+0HLgNr0h/2FxkiW7wl1MFbErC6bDVc3O3uo0Trzgv5nfAjcntXd4ACtRuxCATPLToboeFhHIzyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkAXaaq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0408C4CEE2;
	Tue, 18 Feb 2025 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739912792;
	bh=Ujq/Cshpoqlc2MZdqCW+vNYrNYOrc8GstJJyKD/k94g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkAXaaq6Q3elK19m1hsg5jF8XinHCcI4Xq0DXqZT/HP2ysEi/6CagVqQqnFdeLaTM
	 Oey2qVKHNrhvDOavzmY0XEuOV2+k1hpEEGVICe7DK8uWP7KDosxhVbf4/V/cnZ2mOS
	 037h+F0+uCJ4vDQHS5dgyNMoE1w+4bT+NOmASyz0hZuQ6PZqKg8Uf5ZjCqXA3tt+5S
	 yxyi4EiJe+ui5crHXC8Uny6mDrfyv4AArwlTLppuK3BWvO5M0YK8u0dyp/jXZ+9ygI
	 6P8KMjlcBH1ZEyJZBSgEwmSdGixPF9Ib3DKol3rIo+FejmV1YZ4PaWy/TRe3eHlNDQ
	 we0zQBTD/XIlg==
Date: Tue, 18 Feb 2025 15:06:30 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dt-bindings: rtc: sophgo: add RTC support for Sophgo
 CV1800 series SoC
Message-ID: <20250218210630.GA872024-robh@kernel.org>
References: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>

On Sun, Feb 16, 2025 at 07:09:09PM +0100, Alexander Sverdlin wrote:
> Add RTCSYS devicetree binding for Sophgo CV1800 SoC.
> 
> The RTC (Real Time Clock) is an independently powered module in the chip.
> It contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which
> can be used for time display and scheduled alarm produce. In addition, the
> hardware state machine provides triggering and timing control for chip
> power-on, power-off and reset.
> 
> Furthermore, the 8051 subsystem is located within RTCSYS and is
> independently powered. System software can use the 8051 to manage wake
> conditions and wake the system while the system is asleep, and communicate
> with external devices through peripheral controllers.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> QUESTION:
> 
> I'm unsure about reg properties in the subnodes (child devices) of
> RTCSYS:
> - they will not be used anyway by the drivers because they genuinely
> overlap (the whole point of going MFD) -- therefore the drivers will do
> syscon_node_to_regmap(pdev->dev.parent->of_node)
> - as I understood from the history of MFD dt bindings' submissions, regs
> are encouraged, if can be specified
> - overlapping regs cause dt_binding_check warnings:
> Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/pmu@0)
> Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/rtc@0)
> 
> Shall I remove the MMIO resources from the actual devices or rather ignore the warnings?

Ignore the warnings is not an option.

Removing makes since if the registers and bitfields are completely mixed 
up. If they are, then I find it hard to believe the child nodes are 
separate blocks. And if they aren't, then it should all be just 1 node. 
You don't have to have child nodes to have separate drivers.

> 
>  .../bindings/mfd/sophgo,cv1800b-rtcsys.yaml   | 222 ++++++++++++++++++
>  1 file changed, 222 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> new file mode 100644
> index 000000000000..2dc7c2df15c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> @@ -0,0 +1,222 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sophgo,cv1800b-rtcsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cvitek CV18xx/Sophgo SG200x Real Time Clock module
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - sophgo@lists.linux.dev
> +
> +description:
> +  The RTC (Real Time Clock) is an independently powered module in the chip. It
> +  contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which can
> +  be used for time display and scheduled alarm produce. In addition, the
> +  hardware state machine provides triggering and timing control for chip
> +  power-on, power-off and reset.
> +
> +  Furthermore, the 8051 subsystem is located within RTCSYS and is independently
> +  powered. System software can use the 8051 to manage wake conditions and wake
> +  the system while the system is asleep, and communicate with external devices
> +  through peripheral controllers.
> +
> +  Technical Reference Manual available at
> +    https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sophgo,cv1800b-rtcsys
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^mcu@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      The 8051 subsystem is located within RTCSYS and is independently powered.
> +      System software can use the 8051 to manage wake conditions and wake the
> +      system while the system is asleep, and communicate with external devices
> +      through peripheral controllers.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc-dw8051

You can drop 'items' and use 'const' instead of enum.

> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      resets:
> +        maxItems: 1
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        maxItems: 1
> +        description: The SRAM controller to host the code/data

Somewhat questionable to have a phandle to yourself. Well, a sibling, 
but whether this is 1 device or multiple is a question too.

> +
> +    required:
> +      - compatible
> +      - clocks
> +
> +  "^pmu@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      Power-On-Reset (POR) sub-module, hardware state machine providing
> +      triggering and timing control for chip power-on, power-off and reset.
> +      Supports battery low voltage detection and interrupt generation, as
> +      well as button-triggered wake up from sleep.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc-pmu
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      interrupts:
> +        items:
> +          - description: long button press interrupt
> +          - description: vbat detection interrupt
> +
> +      interrupt-names:
> +        items:
> +          - const: longpress
> +          - const: vbat
> +
> +    required:
> +      - compatible
> +
> +  "^rtc@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      The RTC (Real Time Clock) is an independently powered module in the chip.
> +      Its calibration module uses a 25MHz crystal oscillator clock to calibrate
> +      32KHz oscillator.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      interrupts:
> +        items:
> +          - description: alarm interrupt
> +
> +      interrupt-names:
> +        items:
> +          - const: alarm
> +
> +    required:
> +      - compatible
> +      - clocks
> +      - interrupts
> +
> +  "^sram@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      Provide 2KB of SRAM, which can host software code or temporary data.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - enum:
> +              - sophgo,cv1800b-rtc-sram
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties:
> +  type: object
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    rtcsys@5025000 {
> +        compatible = "sophgo,cv1800b-rtcsys", "simple-mfd", "syscon";
> +        reg = <0x5025000 0x2000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x5025000 0x2000>;
> +
> +        mcu@0 {
> +            compatible = "sophgo,cv1800b-rtc-dw8051";
> +            reg = <0x0 0x1000>;
> +            clocks = <&clk CLK_SRC_RTC_SYS_0>;
> +            sram = <&rtc_sram>;
> +        };
> +
> +        pmu@0 {
> +            compatible = "sophgo,cv1800b-rtc-pmu";
> +            reg = <0x0 0x2000>;
> +            interrupts = <18 IRQ_TYPE_LEVEL_HIGH>,
> +                         <19 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "longpress", "vbat";
> +        };
> +
> +        rtc@0 {
> +            compatible = "sophgo,cv1800b-rtc";
> +            reg = <0 0x2000>;
> +            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "alarm";
> +            clocks = <&clk CLK_RTC_25M>;
> +        };
> +
> +        rtc_sram: sram@0 {
> +            compatible = "sophgo,cv1800b-rtc-sram";
> +            reg = <0x0 0x1000>;

How does the SRAM overlap registers?

> +        };
> +    };
> -- 
> 2.48.1
> 

