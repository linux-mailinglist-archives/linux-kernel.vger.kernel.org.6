Return-Path: <linux-kernel+bounces-290364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31709552C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B27F283E30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F21C6889;
	Fri, 16 Aug 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx6W6EXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB91C57A2;
	Fri, 16 Aug 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845356; cv=none; b=TgrcbKFZC2NxEZgLgLS5Nh9bTr58jIftWhADz0On0PoKFJn+5khAdF2sQj421AFBrhs87r8JEzZbkqveRxisJlR6dlGOO9iZ7+ii3QnsvX+r3pZy1mA00jYVrLclLvjXqf5YPkmH7CkwGPl0enoLX+EsWbW0FRACltx+iPlb1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845356; c=relaxed/simple;
	bh=IxqlRnOXUIqa7r8bKHY8KpHpr2TCvW8vicEFg+O8oVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOJvp2a+vf0n7nPUAX6mvHosFKlkw8UMZVOZK10lMF0woeZkDO7Sz2tUoLx3477Dfn2ZAn6BP4pjOWk7yircCFYNKQ2u9ADc8GBJyJcQn5/tG0vPs0mnMvXDulOguDe4X1mmPVCvJ6hWmT+kWpf9YDhFYcDmhAtY5cb92SfWMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx6W6EXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4B8C32782;
	Fri, 16 Aug 2024 21:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723845356;
	bh=IxqlRnOXUIqa7r8bKHY8KpHpr2TCvW8vicEFg+O8oVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx6W6EXAnzo6s/zuEpZzbNbyhpVUmkyx4RKab9cXlP619twZi/IDD5TLquJUa1i16
	 I0eJCD7Mw4kb29YV2NAasEpEJIsAW248cRqcrhaUfHJ8Mwc72rTCe8ySIOCltyWD6d
	 njGmdAtODbUa1PLSur4B1fyNOyLMThl+Kc2Hb7n16XL6BlOfgkmvP+ZJOuC0v6c6dZ
	 65kC9yx3nOyLVYoAbRmUaymoQYckMi/I3vJU/+UIiUJQcWIyRoGsQXYnlNrXg5ZgL9
	 o5s58UBHMuXiAL5AwCHlXXcmHEGM/KC6ZCfHz9E4OO70jacPBDmezv4On+L6Ajt4/z
	 eBKtm6Z/VxMlw==
Date: Fri, 16 Aug 2024 15:55:55 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to
 yaml
Message-ID: <20240816215555.GA2302157-robh@kernel.org>
References: <20240814181727.4030958-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814181727.4030958-1-Frank.Li@nxp.com>

On Wed, Aug 14, 2024 at 02:17:26PM -0400, Frank Li wrote:
> Convert binding doc ltc2978.txt to yaml format.
> Additional change:
> - add i2c node.
> - basic it is regulator according to example, move it under regulator.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> 	failed to match any schema with compatible: ['lltc,ltc3882']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
>  .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml

I'm on the fence whether to move this...

> diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> deleted file mode 100644
> index 4e7f6215a4533..0000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -ltc2978
> -
> -Required properties:
> -- compatible: should contain one of:
> -  * "lltc,ltc2972"
> -  * "lltc,ltc2974"
> -  * "lltc,ltc2975"
> -  * "lltc,ltc2977"
> -  * "lltc,ltc2978"
> -  * "lltc,ltc2979"
> -  * "lltc,ltc2980"
> -  * "lltc,ltc3880"
> -  * "lltc,ltc3882"
> -  * "lltc,ltc3883"
> -  * "lltc,ltc3884"
> -  * "lltc,ltc3886"
> -  * "lltc,ltc3887"
> -  * "lltc,ltc3889"
> -  * "lltc,ltc7880"
> -  * "lltc,ltm2987"
> -  * "lltc,ltm4664"
> -  * "lltc,ltm4675"
> -  * "lltc,ltm4676"
> -  * "lltc,ltm4677"
> -  * "lltc,ltm4678"
> -  * "lltc,ltm4680"
> -  * "lltc,ltm4686"
> -  * "lltc,ltm4700"
> -- reg: I2C slave address
> -
> -Optional properties:
> -- regulators: A node that houses a sub-node for each regulator controlled by
> -  the device. Each sub-node is identified using the node's name, with valid
> -  values listed below. The content of each sub-node is defined by the
> -  standard binding for regulators; see regulator.txt.
> -
> -Valid names of regulators depend on number of supplies supported per device:
> -  * ltc2972 vout0 - vout1
> -  * ltc2974, ltc2975 : vout0 - vout3
> -  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
> -  * ltc2978 : vout0 - vout7
> -  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
> -  * ltc7880 : vout0 - vout1
> -  * ltc3883 : vout0
> -  * ltm4664 : vout0 - vout1
> -  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
> -  * ltm4680, ltm4686 : vout0 - vout1
> -  * ltm4700 : vout0 - vout1
> -
> -Example:
> -ltc2978@5e {
> -	compatible = "lltc,ltc2978";
> -	reg = <0x5e>;
> -	regulators {
> -		vout0 {
> -			regulator-name = "FPGA-2.5V";
> -		};
> -		vout2 {
> -			regulator-name = "FPGA-1.5V";
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
> new file mode 100644
> index 0000000000000..20ae6152a2572
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/lltc,ltc2972.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ltc2978

I know the original was bad, but we can do better here.

> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc2972
> +      - lltc,ltc2974
> +      - lltc,ltc2975
> +      - lltc,ltc2977
> +      - lltc,ltc2978
> +      - lltc,ltc2979
> +      - lltc,ltc2980
> +      - lltc,ltc3880
> +      - lltc,ltc3882
> +      - lltc,ltc3883
> +      - lltc,ltc3884
> +      - lltc,ltc3886
> +      - lltc,ltc3887
> +      - lltc,ltc3889
> +      - lltc,ltc7880
> +      - lltc,ltm2987
> +      - lltc,ltm4664
> +      - lltc,ltm4675
> +      - lltc,ltm4676
> +      - lltc,ltm4677
> +      - lltc,ltm4678
> +      - lltc,ltm4680
> +      - lltc,ltm4686
> +      - lltc,ltm4700
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description: |
> +      list of regulators provided by this controller.
> +      Valid names of regulators depend on number of supplies supported per device:
> +      * ltc2972 vout0 - vout1
> +      * ltc2974, ltc2975 : vout0 - vout3
> +      * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
> +      * ltc2978 : vout0 - vout7
> +      * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
> +      * ltc7880 : vout0 - vout1
> +      * ltc3883 : vout0
> +      * ltm4664 : vout0 - vout1
> +      * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
> +      * ltm4680, ltm4686 : vout0 - vout1
> +      * ltm4700 : vout0 - vout1
> +
> +    patternProperties:
> +      "^vout[0-7]$":
> +        $ref: regulator.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        regulator@5e {
> +            compatible = "lltc,ltc2978";
> +            reg = <0x5e>;
> +
> +            regulators {
> +                vout0 {
> +                     regulator-name = "FPGA-2.5V";
> +                };
> +                vout2 {
> +                     regulator-name = "FPGA-1.5V";
> +                };
> +            };
> +        };
> +    };
> +
> -- 
> 2.34.1
> 

