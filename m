Return-Path: <linux-kernel+bounces-208990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1842E902B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F64C1C221BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6721514C6;
	Mon, 10 Jun 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4YSj1We"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A218E2A;
	Mon, 10 Jun 2024 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058064; cv=none; b=n1W7eTroLibYTbxXJ/T4Yb/Gx0QWIn4fCPOhv698C9UK6JQqq/VFKnNNDUvGMBJNniDmYMb+8vypEuBxmTl2PkEAdoVH7cHApaREYwzj2o7g21fzGIKfAVD9ULwMrgWhMaOs1mC/2CLadk3j6bOBzlpJpuoetyLpmRxE932d8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058064; c=relaxed/simple;
	bh=pl6keJwPlGBjGuebt18yLI6GtwU9xIevymMuRab/vLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea8WqdF4VJpYsCcnmzDNOLhdZDSKnWYukNvXVbmmfMkeAisteq2e3BGBtZ7gbYGUU7baQKctGa/s1cSRmnp94Pz+B8YOBVv7aoIR5mJR/71mhDziJcv8vrKaVh9LRjnuZUdpDYWko/wUaFpKjv6ZfiOrC08u/PYcFUxfKS9oYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4YSj1We; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A9C2BBFC;
	Mon, 10 Jun 2024 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718058064;
	bh=pl6keJwPlGBjGuebt18yLI6GtwU9xIevymMuRab/vLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4YSj1Wek5SPedwirmW2S6v4vcVcKkM/ixw20phNWnY8ljYuYUOgu7bGEbaN44uA6
	 GcdJJigQwwTnIyzrEjVL5CGHv70AGx0NlxrI2V2q2YvIxewHElXyzpcRS0Qi6Axd0W
	 Bw4JRSP+bUWIaFqHV97RDyd9dbvw/h1AVwY+lbcGw+uA2EfhzVyN7H6mfKK/NgfjAJ
	 0BSPn+eZScC0g0nu+73N40DigghH6sAHBmotrpP2lz3NdzZp8dYCQBxMY39WN/0rJ/
	 iUMyKdPXTsN/Pj+oEXq0R2MBmkJym0GXu2fn6HjyAKIM2fWl/rEKEsHDN8KMM30JmT
	 EREj7kR19fo5Q==
Date: Mon, 10 Jun 2024 16:21:03 -0600
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: convert tas571x.txt to dt-schema
Message-ID: <20240610222103.GA3160412-robh@kernel.org>
References: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>

On Fri, Jun 07, 2024 at 11:54:35AM +0200, Neil Armstrong wrote:
> Convert the text bindings for the Texas Instruments
> TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers to
> dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/sound/tas571x.txt          |  49 --------
>  .../devicetree/bindings/sound/ti,tas57xx.yaml      | 129 +++++++++++++++++++++
>  2 files changed, 129 insertions(+), 49 deletions(-)

Looks like 'port' was undocumented and should be added.

> diff --git a/Documentation/devicetree/bindings/sound/ti,tas57xx.yaml b/Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
> new file mode 100644
> index 000000000000..fa6d6c1c8535
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,tas57xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas5707
> +      - ti,tas5711
> +      - ti,tas5717
> +      - ti,tas5719
> +      - ti,tas5721
> +      - ti,tas5733
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO for the active low reset line
> +
> +  pdn-gpios:
> +    maxItems: 1
> +    description: GPIO for the active low powerdown line
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  AVDD-supply: true
> +  DVDD-supply: true
> +  HPVDD-supply: true
> +  PVDD_AB-supply: true
> +  PVDD_CD-supply: true
> +  PVDD_A-supply: true
> +  PVDD_B-supply: true
> +  PVDD_C-supply: true
> +  PVDD_D-supply: true
> +  DRVDD-supply: true
> +  PVDD-supply: true
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas5717
> +              - ti,tas5719
> +    then:
> +      properties:
> +        PVDD_A-supply: false
> +        PVDD_B-supply: false
> +        PVDD_C-supply: false
> +        PVDD_D-supply: false
> +        DRVDD-supply: false
> +        PVDD-supply: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas5711
> +    then:
> +      properties:
> +        HPVDD-supply: false
> +        PVDD_AB-supply: false
> +        PVDD_CD-supply: false
> +        DRVDD-supply: false
> +        PVDD-supply: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tas5721
> +    then:
> +      properties:
> +        HPVDD-supply: false
> +        PVDD_AB-supply: false
> +        PVDD_CD-supply: false
> +        PVDD_A-supply: false
> +        PVDD_B-supply: false
> +        PVDD_C-supply: false
> +        PVDD_D-supply: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>

You aren't using this.

> +   i2c {
> +     #address-cells = <1>;
> +     #size-cells = <0>;

blank line

> +     codec: codec@2a {

Drop label

> +       compatible = "ti,tas5717";
> +       reg = <0x2a>;
> +       #sound-dai-cells = <0>;
> +       reset-gpios = <&gpio1 15 0>;
> +       pdn-gpios = <&gpio1 15 0>;
> +       AVDD-supply = <&avdd_supply>;
> +       DVDD-supply = <&dvdd_supply>;
> +       HPVDD-supply = <&hpvdd_supply>;
> +       PVDD_AB-supply = <&pvdd_ab_supply>;
> +       PVDD_CD-supply = <&pvdd_cd_supply>;
> +     };
> +   };
> +
> +...
> 
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240607-topic-amlogic-upstream-bindings-convert-tas57xx-5af1e564e6a1
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

