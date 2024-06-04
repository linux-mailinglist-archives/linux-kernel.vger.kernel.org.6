Return-Path: <linux-kernel+bounces-201002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC78FB8BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32AFB2D003
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59EF149E09;
	Tue,  4 Jun 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVjc73eX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4191149DF0;
	Tue,  4 Jun 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516139; cv=none; b=UGTPsBs5JuuMcBa8sEbZV/tsRoHVXU3fVwODELKcb1i6ASSMwld7vM4nsaZBj34MSV9mDeKvNEzOoqaqvyxMqTPJNbU4hkercmn1LvnSzmLJuZ5+W+FyJ/Z9v5fs8lJwy71hCX1578mF72OhRzsUjbYKLFMtf920eFgJjefL37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516139; c=relaxed/simple;
	bh=H6C5qSm/fcT/ixas+I5X8nmCjiwQueFN8EO+t4pDWPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfJWDve8mQMlEooxDkRAoxJJjL2z9fJq0sNfZ5HKdEFA5J4bAktnWM19PYKF2aA24iCHQQLEQfab5LkxnRMKvfUAHs4HWU0+tXJRY2cyz39KAb7gIuhIAlpevmu4VK8PxsHSq8j/01gcbJZ4f+pkMCJZIhxSvYyKupxJrTr+maE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVjc73eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C47C32786;
	Tue,  4 Jun 2024 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717516138;
	bh=H6C5qSm/fcT/ixas+I5X8nmCjiwQueFN8EO+t4pDWPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVjc73eXuEkiYBiAFb/BKiGBgzQUyWnbolzCjhhiJdJCaHxz3airD0st4YoHMNO09
	 e6JGqLjtgJgO7KUWFA66flzI2gvZDD9t5w1mII3xd9NQlJmcQB/CfBKF+XUU3Jqia2
	 VhUrXDGxzsUpsp3E6HnllqYMksVcL/6Bmlgk+V5sJL0jvhc7FhOE58xQ1IUnr1wOci
	 HzjTYYMZa7WGWjYs5SNAF02nqgVF8i1/zJ3qgM3Su09a2sBW0UxQglJUaoCQlC7lpC
	 2PoumUsIF+mtPIg3N4ChYbK8hmisuSidDi+Cd2nVFveDnTeEGjcnU3WUMK6oPUaByu
	 PJqLfuDRih5Lw==
Date: Tue, 4 Jun 2024 10:48:55 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: g762: Convert to yaml schema
Message-ID: <20240604154855.GA859849-robh@kernel.org>
References: <20240530211654.7946-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530211654.7946-1-ansuelsmth@gmail.com>

On Thu, May 30, 2024 at 11:16:50PM +0200, Christian Marangi wrote:
> Convert g762 Documentation to yaml schema and port all the custom
> properties and info.
> 
> Add the vendor prefix to name to follow naming standard.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v3:
> - Rename yaml to g762 from g76x
> 
>  .../devicetree/bindings/hwmon/g762.txt        | 47 -----------
>  .../devicetree/bindings/hwmon/gmt,g762.yaml   | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
> deleted file mode 100644
> index 6d154c4923de..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/g762.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -GMT G762/G763 PWM Fan controller
> -
> -Required node properties:
> -
> - - "compatible": must be either "gmt,g762" or "gmt,g763"
> - - "reg": I2C bus address of the device
> - - "clocks": a fixed clock providing input clock frequency
> -	     on CLK pin of the chip.
> -
> -Optional properties:
> -
> - - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
> -	       The higher the more.
> -
> - - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
> -	       and 1 (negative duty).
> -
> - - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
> -
> -If an optional property is not set in .dts file, then current value is kept
> -unmodified (e.g. u-boot installed value).
> -
> -Additional information on operational parameters for the device is available
> -in Documentation/hwmon/g762.rst. A detailed datasheet for the device is available
> -at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> -
> -Example g762 node:
> -
> -   clocks {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -
> -	g762_clk: fixedclk {
> -		 compatible = "fixed-clock";
> -		 #clock-cells = <0>;
> -		 clock-frequency = <8192>;
> -	}
> -   }
> -
> -   g762: g762@3e {
> -	compatible = "gmt,g762";
> -	reg = <0x3e>;
> -	clocks = <&g762_clk>
> -	fan_gear_mode = <0>; /* chip default */
> -	fan_startv = <1>;    /* chip default */
> -	pwm_polarity = <0>;  /* chip default */
> -   };
> diff --git a/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
> new file mode 100644
> index 000000000000..8c179cbbc65c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/gmt,g762.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/gmt,g762.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GMT G762/G763 PWM Fan controller
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  GMT G762/G763 PWM Fan controller.
> +
> +  If an optional property is not set in DT, then current value is kept
> +  unmodified (e.g. bootloader installed value).
> +
> +  Additional information on operational parameters for the device is available
> +  in Documentation/hwmon/g762.rst. A detailed datasheet for the device is available
> +  at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - gmt,g762
> +      - gmt,g763
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: a fixed clock providing input clock frequency on CLK
> +      pin of the chip.
> +    maxItems: 1
> +
> +  fan_startv:
> +    description: Fan startup voltage step
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  pwm_polarity:
> +    description: PWM polarity (psotivie or negative duty)

typo

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  fan_gear_mode:
> +    description: FAN gear mode. Configure High speed fan setting factor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clocks {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        g762_clk: fixedclk {
> +            compatible = "fixed-clock";
> +            #clock-cells = <0>;
> +            clock-frequency = <8192>;
> +        };

Drop. Providers are outside the scope of bindings.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

