Return-Path: <linux-kernel+bounces-529418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D4A42580
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440B67AB1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA761624D9;
	Mon, 24 Feb 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muGMUS3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF32837B;
	Mon, 24 Feb 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409607; cv=none; b=S9yZvLgKv/pgY0TbdpWcO012RiXXi/3WCR/Qu0O0peXiqdJpRRMMvgoOwDb6yd4uZ3P5CF+lUxgB3TQjv5jzxB/v9WXy7wcAVI9akOaDww+TFASo19T/7yrLETtnyvcggRNeeck1wGUXRx5qmQT752BwvWn01Isxmnm/eiwNN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409607; c=relaxed/simple;
	bh=WhLrnvT/vsmJ4XaZG6h/I7B5d0//boKEBZZvxXFIVmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a43eBDdsz/B7K43RU6oeS3lpmnRcC8SfpTrkH726CaWAGxg15VEL5vTKL/CDmWBiOEdl4eRj+QeRfKAP7zntU3++oISqdV6GZyHakQLZsq0fYKXdfmxUgVTepjp01xkhK5fH2QbxzE0kZD/ocESE5O5EyaNwNdT57JrZN3yPPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muGMUS3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90282C4CED6;
	Mon, 24 Feb 2025 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740409606;
	bh=WhLrnvT/vsmJ4XaZG6h/I7B5d0//boKEBZZvxXFIVmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muGMUS3NJF2CC5UKvyULzw2qmp/DAsCdyb6NZQnmDriT2tcIGzj/zEeZWhRQJz77f
	 keQvzV8kMUdRRFQ4FaS4nsVRVLHgFEMQb/icDx7UgKn2C+28caLVsx9CBMeZf8vwoB
	 9YsBwue7m7kcJnAV80NlmLf3V/BITF138JZ9DvThbW+d7i8EnWEls8uY1+MOi1u/WU
	 k3bwQmNbSituCgKEUuV000LMredBagi3YQNo6je0H/I985yzAbhLZ2h0UObWiFmEpf
	 PvdbG8ZZoaUqnvpCBvE06IHqH5/m22DRYC+XUUjlahYncAAbLEfLlBgnZ+HVbX6kKo
	 1zgtkOuO9igpA==
Date: Mon, 24 Feb 2025 09:06:45 -0600
From: Rob Herring <robh@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Guenter Roeck <linux@roeck-us.net>, broonie@kernel.org,
	conor@kernel.org, Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ir38060: Move & update dt
 binding
Message-ID: <20250224150645.GA2786847-robh@kernel.org>
References: <20250221213837.1594057-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221213837.1594057-1-naresh.solanki@9elements.com>

On Sat, Feb 22, 2025 at 03:08:34AM +0530, Naresh Solanki wrote:
> Move dt binding under hwmon/pmbus & align accordingly.
> 
> Previously the DT binding was invalid & wouldn't work with pmbus driver.
> Pmbus driver expects a regulator node & hence added the same.

This still doesn't really capture the previous discussion. With this, my 
response is still 'fix the driver'. It seems there is something about 
this is a common driver...

> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V2:
> 1. Update commit message
> ---
>  .../hwmon/pmbus/infineon,ir38060.yaml         | 61 +++++++++++++++++++
>  .../bindings/regulator/infineon,ir38060.yaml  | 45 --------------
>  2 files changed, 61 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
> new file mode 100644
> index 000000000000..e1f683846a54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,ir38060.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,ir38060.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon Buck Regulators with PMBUS interfaces
> +
> +maintainers:
> +  - Not Me.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,ir38060
> +      - infineon,ir38064
> +      - infineon,ir38164
> +      - infineon,ir38263
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller.
> +
> +    properties:
> +      vout:
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
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
> +        regulator@34 {
> +            compatible = "infineon,ir38060";
> +            reg = <0x34>;
> +
> +            regulators {
> +                vout {
> +                    regulator-name = "p5v_aux";
> +                    regulator-min-microvolt = <437500>;
> +                    regulator-max-microvolt = <1387500>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml b/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> deleted file mode 100644
> index e6ffbc2a2298..000000000000
> --- a/Documentation/devicetree/bindings/regulator/infineon,ir38060.yaml
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/regulator/infineon,ir38060.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Infineon Buck Regulators with PMBUS interfaces
> -
> -maintainers:
> -  - Not Me.
> -
> -allOf:
> -  - $ref: regulator.yaml#
> -
> -properties:
> -  compatible:
> -    enum:
> -      - infineon,ir38060
> -      - infineon,ir38064
> -      - infineon,ir38164
> -      - infineon,ir38263
> -
> -  reg:
> -    maxItems: 1
> -
> -required:
> -  - compatible
> -  - reg
> -
> -unevaluatedProperties: false
> -
> -examples:
> -  - |
> -    i2c {
> -      #address-cells = <1>;
> -      #size-cells = <0>;
> -
> -      regulator@34 {
> -        compatible = "infineon,ir38060";
> -        reg = <0x34>;
> -
> -        regulator-min-microvolt = <437500>;
> -        regulator-max-microvolt = <1387500>;
> -      };
> -    };
> 
> base-commit: 8df0f002827e18632dcd986f7546c1abf1953a6f
> -- 
> 2.42.0
> 

