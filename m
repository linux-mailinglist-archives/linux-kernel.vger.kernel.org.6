Return-Path: <linux-kernel+bounces-521708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C92A3C0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682327A51AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8F1EDA15;
	Wed, 19 Feb 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYALs8ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFD1E1A3B;
	Wed, 19 Feb 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973673; cv=none; b=PG0uh56q2bMAEXapjbKCQJV0jXGWTK8VWTiIJm2q2Pqr9uQSToYWwpTqbIbnG1Wdp0WP53P2kajsBGnuwI+QLtldtvJPjs+h/B3TAXumJpClHpTtJFnnVP79qYox79I66CCidBQ/9jawuj9bT4Z7KWDoB1DL9qxPf1cwWex+JOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973673; c=relaxed/simple;
	bh=Ah42zirfWgU7LWvxY7zMUQ4RD7yPe5FX8hB+F2CoHHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4Aau0VyxSIZpAtVgOeVfgQ2L8oUTxjtsXoUdWcNPN9MFPVJi9ooZFOQQhAumixq5Ju9/wOmeTcmknrM914b6nPMRebC6OBJao8pI28ZNy9d0Hc3DBmK24GWVjiM4EtaBaX3mNSdVkhTWIsUtIjuMex99YlPxfJwP9L1fu1wAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYALs8ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77A5C4CED1;
	Wed, 19 Feb 2025 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973673;
	bh=Ah42zirfWgU7LWvxY7zMUQ4RD7yPe5FX8hB+F2CoHHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYALs8mlbi80V0H9lBr2L6F0iHCBN4XUWOVGk+LKaazfCU1YIeJuhTiWtFu30Mdym
	 jFK0zrrdW2Z2r2o1RR+khR/GixdY2NgQ6ol1lcjyWOY8GuRlQzZZ/ydapTBTZaYnxS
	 JbmeTJLEIDvYn2zAFOpkqSRacgZ3UnXhTfdp4NxQBAG579XeRhgISYQZvEQoADPHcs
	 hDfAthn8qvHJMHmt64/YPbTmkbj8SXfMBkB3wj5vw6UzNOxCoxQrG6FJm6vC5hfuO1
	 bN7jNyw27C6lJa+N5UQIzhWw7LxBdf/wjKBxoXIwZH36zalnABun5AsqALa4xYBi+b
	 sm0DoNZ3StZCw==
Message-ID: <fd70f78c-68a5-43ec-9eb2-3f06c5d7a20d@kernel.org>
Date: Wed, 19 Feb 2025 15:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: emc2305: Add YAML binding
 documentation for emc2305 driver
To: florin.leotescu@oss.nxp.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com, carlos.song@nxp.com,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 Florin Leotescu <florin.leotescu@nxp.com>
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
 <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250219133221.2641041-4-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 14:32, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 

A nit, subject: drop second/last, redundant "YAML binding
documentation". Three useless/redundant terms. The "dt-bindings" prefix
is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

And drop all driver references - you put it everywhere.


> Add yaml-based Device Tree bindings documentation for emc2305 driver
> The file provides the necessary structure, configuration
> and other parameters for Device Tree definition.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> ---
>  .../devicetree/bindings/hwmon/emc2305.yaml    | 95 +++++++++++++++++++

Filename matching compatible.

>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/emc2305.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/emc2305.yaml b/Documentation/devicetree/bindings/hwmon/emc2305.yaml
> new file mode 100644
> index 000000000000..51e2a82d8f25
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/emc2305.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/emc2305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EMC2305 i2c pwm fan controller
> +
> +maintainers:
> +  - Michael Shych <michaelsh@nvidia.com>
> +
> +description: |
> +  The driver implements support for Microchip EMC2301/2/3/5 PWM Fan Controller.

This is a binding so describe hardware, not your implementation.


> +  The EMC2301 Fan Controller supports only one controlled PWM fan channel.
> +  The EMC2305 Fan Controller supports up to 5 independently
> +  controlled PWM fan drives.
> +

Missing fan-common reference.

> +properties:
> +  compatible:
> +    enum:
> +      - hwmon,emc2301
> +      - hwmon,emc2302
> +      - hwmon,emc2303
> +      - hwmon,emc2305

Nope.

Was it ever internally reviewed?


> +
> +  reg:
> +    description: I2C address of the emc2305 device

Look how other bindings do it.

> +
> +  pwm_output:

NAK.

There are so many issues with this code, from trivial incorrect quotes
and not following DTS coding style, to actual duplicating other schemas
or common part.

Sorry, get it first internally reviewed.

> +    description: "PWM output type Push-Pull/ Open Drain"
> +    maxItems: 1
> +
> +  pwm_polarity:
> +    description: "PWM polarity"
> +    maxItems: 1
> +
> +  '#cooling-cells':
> +    description: "cooling state range"

Do you see any binding like that? Any?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    thermal_zones {
> +        a55-thermal {
> +                trips {
> +                        atrip0: trip0 {
> +                                temperature = <55000>;
> +                                hysteresis = <2000>;
> +                                type = "active";
> +                        };
> +
> +                        atrip1: trip1 {
> +                                temperature = <65000>;
> +                                hysteresis = <2000>;
> +                                type = "active";
> +                        };
> +
> +                        atrip2: trip2 {
> +                                temperature = <75000>;
> +                                hysteresis = <2000>;
> +                                type = "active";
> +                        };
> +                };
> +
> +                cooling-maps {
> +                        map1 {
> +                                trip = <&atrip0>;
> +                                cooling-device = <&emc2301 4 6>;
> +                        };
> +
> +                        map2 {
> +                                trip = <&atrip1>;
> +                                cooling-device = <&emc2301 6 8>;
> +                        };
> +
> +                        map3 {
> +                                trip = <&atrip2>;
> +                                cooling-device = <&emc2301 8 10>;
> +                        };
> +                };
> +        };
> +
> +    }

This DTS is also in very poor shape - even your indentation does not
match. Drop redundant parts - entire thermal.

> +    emc2301: pwm@2f {
> +       compatible = "hwmon,emc2301";
> +       reg = <0x2f>;
> +       #cooling-cells = <2>;
> +       pwm_output = <0x1>;
> +       pwm_polarity = <0x1>;
> +    };


Best regards,
Krzysztof

