Return-Path: <linux-kernel+bounces-384391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03269B2980
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F3E1F25A04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6721DBB35;
	Mon, 28 Oct 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MupB10g9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150541DB951;
	Mon, 28 Oct 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101341; cv=none; b=r2GbpWKFpw94E7CTtllP6DsGMdrswKNVLV3vsFyXf+Hfw674viSjkbHjaiAeRRTHaNRDokETMEVPjutGch+JFhhBwB6/XI/SboEnA7lADpgCWm7TmzAmecpTggQj3Hg3qi16rygQOQ4o1ZV/PiOVJKVy0XGv777pMNqlq+/01KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101341; c=relaxed/simple;
	bh=EWJQDD7obHTMVklwOprn4LOtstavOuKcai/H4EXO3xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j34ck28LR9eQJkmU8vleQoK6Idu7R+3qWHJNvxbGWE69y8LRaafE6MLBRX2/Q4k0DPkr1tTwQttWRkDeTIOiMP60LLUn4FpvyUn2SBCj0DGx+N4VB34v+w7PDHqL7javXRjVGDbUwupvhiNyZbIySj64dH8yjm+hr6xks6O0E4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MupB10g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD510C4CEC3;
	Mon, 28 Oct 2024 07:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730101340;
	bh=EWJQDD7obHTMVklwOprn4LOtstavOuKcai/H4EXO3xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MupB10g9s5uE7FnsWht3D3JW07DASnhSjQMXk/eIKeUiLjoNB3nO7ZU+I9Q5+S7EW
	 N64+vwYpmPwTPy1zLGilVR14kIOQ0VKz9BzqzZMPS883iTPgGmBepUHOf+47in15t+
	 Ee9ysRPHKdlUUk2LvVf5S+5XvO5TZJ3MjxGtrXNDj/uHUQnf0jyfxrcScWl/B3cbJT
	 OG6p7/v3KjnejT/iF0kod8PTohS+T2KbbMW7ECAh6xci6tfPDeSS6rJw69o4h4MrW5
	 EAkKPKAGL88tANdPPhabKSwMW9Bln8BFGQvDsq+pIEknTL94F3RxwzVv6oaZyShryD
	 Uv8Jp4haIB4Kg==
Date: Mon, 28 Oct 2024 08:42:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add ltc4296-1 support
Message-ID: <3n65dk5apiscbsibv7va6eie2xpx5epwewzkewrf7pzjctjpwz@vuikaxmzicmu>
References: <20241025115624.21835-1-antoniu.miclaus@analog.com>
 <20241025115624.21835-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025115624.21835-2-antoniu.miclaus@analog.com>

On Fri, Oct 25, 2024 at 02:56:10PM +0300, Antoniu Miclaus wrote:
> Add devicetree bindings for the ltc4296-1 device.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/hwmon/adi,ltc4296-1.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml
> new file mode 100644
> index 000000000000..be73d59a7d65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +

If there is going to be new posting: drop blank line.

> +$id: http://devicetree.org/schemas/hwmon/adi,ltc4296-1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTC4296-1 5-Port SPoE PSE Controller
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The LTC4296-1 is an IEEE 802.3cg-compliant, five port, single-pair
> +  power over Ethernet (SPoE), power sourcing equipment (PSE)
> +  controller. SPoE simplifies system design and installation with
> +  standardized power and Ethernet data over a single-pair cable.
> +
> +  Datasheet:
> +    https://www.analog.com/en/products/ltc4296-1.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: adi,ltc4296-1
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells'

If there is going to be new posting: use consistent quotes, either ' or
".

> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  vin-supply: true
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object
> +    description:
> +      Represents the current monitoring channels.
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. ltc4296-1 can monitor 5 currents.
> +        items:
> +          minimum: 0
> +          maximum: 4

maximum is 3, right?

> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          The value of curent sense resistor in micro ohms.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vin-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hwmon@0 {
> +            compatible = "adi,ltc4296-1";
> +            reg = <0x0>;
> +            vin-supply = <&vcc>;

Why no channels here? What's the point of such node if you do not
monitor any channels?

> +        };
> +    };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        hwmon@0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            compatible = "adi,ltc4296-1";
> +            reg = <0x0>;
> +            vin-supply = <&vin>;
> +
> +            channel@0 {
> +                    reg = <0x0>;

Use 4 spaces for example indentation.

Best regards,
Krzysztof


