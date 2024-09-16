Return-Path: <linux-kernel+bounces-331071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753397A800
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386141C24AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEE915CD64;
	Mon, 16 Sep 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdD5q3dL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE12E659;
	Mon, 16 Sep 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516573; cv=none; b=mHkHzwDAucdD1fP5zh7Roqv30ZiEy8uqzM+j78hrEpc1IsHjZPOENH7PS6d/BYH//bjgXXVukv/qtqn+CMH001Wlha96CYV4N2RulsMj8W9cjdwAlDCfLvjpxfc78U36I9FXfMgsquNsBqSJsSnG8qxYD6tPghq23/jdBfDJXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516573; c=relaxed/simple;
	bh=XqGZ2D0eFfmQ0wRAHzQLxJtep5CdGS45aey8K4YMTAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+OddBMOaX/cvF8WrjAhaxWxb6h1OHfrhNC8s4DLoyLfHy37V06K3wRiLduEMQVMccM+LQK/5NPrAlsidh183BFa2pOPFE75WYUThStL2e4bNUhTlM4dewxd9MSK6jgfAn95ky3Wv39cKUmXXPZERLQGJ/npTac/K4i5JqCUBcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdD5q3dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B96C4CEC4;
	Mon, 16 Sep 2024 19:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726516572;
	bh=XqGZ2D0eFfmQ0wRAHzQLxJtep5CdGS45aey8K4YMTAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bdD5q3dLy1DexGEvODNRSHWKhLX8ih/ChY3KiHVmz1PjUos5AoxdZB9QHMVwkwmF1
	 uy4lGaStAF2PyiZA37gtqv5f38Eewik/d7wwrElnB2+8+pDzy6ueQOEDlL1THLJ+2+
	 c4uM/IddQBCXcvBy6Mi5Eqyo38TuxFXR1jv03n6AxI4jJhsZ2BPdmT+wk110pXqYGv
	 4wxkcsEsisvNwTyaxpnbnVxpdsYJYChyGitcBRlmwwA+4eUkYa33GVel02R7O7IqrP
	 bEaQLYIalKwFlQtOVucm/EIMtM3F6tMn2l9VhWq3zZsq7Mlkce9E6tonU3JjFdbSex
	 gTNV5DeMLfnbQ==
Message-ID: <90c9f1a8-fcfb-49f5-803e-cb0ec14463cb@kernel.org>
Date: Mon, 16 Sep 2024 21:56:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: regulator: add max20339 binding
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
 <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/09/2024 18:48, André Draszik wrote:
> Add device tree binding for Maxim MAX20339 overvoltage protector with
> load switches.

Subject:
regulator: dt-bindings:

See submitting patches.

> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/regulator/maxim,max20339.yaml         | 171 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 177 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
> new file mode 100644
> index 000000000000..ef6490cf5a6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max20339.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX20339 overvoltage protector with load switches
> +
> +maintainers:
> +  - André Draszik <andre.draszik@linaro.org>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The MAX20339 is an overvoltage protection (OVP) device with integrated load
> +  switches and ESD Protection for USB Type-C applications. It protects low
> +  voltage systems against voltage faults and surges. It also integrates two
> +  load switches with current limiting, configurable by hard- and software.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max20339
> +
> +  dig-supply:
> +    description:
> +      Input supply for the device itself (DIG pin, 1.7V to 1.9V). In absence of
> +      Vdig, the IN pin will power the device.
> +
> +  gpio:
> +    type: object
> +
> +    properties:
> +      "#gpio-cells":
> +        const: 2
> +
> +      gpio-controller: true
> +
> +      gpio-line-names:
> +        description: Strings describing the names of each gpio line.

Drop description.

> +        maxItems: 1
> +
> +    required:
> +      - "#gpio-cells"
> +      - gpio-controller
> +
> +    additionalProperties: false

Does any existing driver require this to be separate node? I don't see
here any resources, so these properties should be in main device node.

> +
> +  insw-supply:
> +    description:
> +      Input supply for the outputs (IN pin, 3.9V to 28.0V). Also used as supply
> +      for the device itself in case dig-supply is not wired up.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  lsw1-supply:
> +    description: Input supply for the outputs (LSW1IN pin, 4.0V to 10.0V)
> +
> +  lsw2-supply:
> +    description: Input supply for the outputs (LSW2IN pin, 4.0V to 10.0V)
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    properties:
> +      insw:
> +        type: object
> +        $ref: regulator.yaml#
> +        description: Represents the switch connecting IN to OUT, INSW.
> +
> +        properties:
> +          regulator-ov-protection-microvolt:
> +            enum: [5850000, 9700000, 14500000]
> +
> +        unevaluatedProperties: false
> +
> +    patternProperties:
> +      "^lsw[12]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description: Represents the load switches LSW1 and LSW2.
> +
> +        properties:
> +          regulator-ov-protection-microvolt:
> +            enum: [0, 1]
> +
> +          shunt-resistor-micro-ohms:
> +            description:
> +              Value in micro Ohm of the resistor connected between the SETx
> +              pin and GND. This value is required to be able to calculate and
> +              program the current limiting threshold register.
> +
> +        required:
> +          - shunt-resistor-micro-ohms
> +
> +        unevaluatedProperties: false
> +
> +    required:
> +      - lsw1
> +      - lsw2
> +
> +    additionalProperties: false
> +
> +anyOf:
> +  - oneOf:
> +      - required:
> +          - dig-supply
> +      - required:
> +          - insw-supply
> +  - required:
> +      - dig-supply
> +      - insw-supply

oneOf looks redundant here. you allow any combination, right?

> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators


Best regards,
Krzysztof


