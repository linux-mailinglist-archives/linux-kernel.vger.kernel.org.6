Return-Path: <linux-kernel+bounces-309730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3336966FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B551C215CE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9D116BE0D;
	Sat, 31 Aug 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBuyteZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530213B2B1;
	Sat, 31 Aug 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086563; cv=none; b=XeFhFVDfKzdXKepCJnU8D00S8CnHWEntGl4krrrdpAjuNXvht5V+vnnH6XtlfwTnv4xlRtWKOpjosGqYGeSA0zAkT0g9TY4y7PZCnZDaOMXTCkqSeAirSX8hAakQ6mnBhk2hIB/uu6E95aGSw2s5BAjU2VTE3AAYkqLYfEr4FH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086563; c=relaxed/simple;
	bh=RJ8RqrepOIn9xN7g8pAcnilEva80xBqyvr9dmVEw2zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM2KoVdcmb9/ZAyMdxHWAzRsWdUsIXtnXLPxsHADwfNiddMAry2+s+Y62Okywqwk/CYC3Zah7T6Y0Wn3swRJFPT5fXxT4GaHh5P8igjJuZdyI/XJDwWmdrVHnL5Imk3GLP1GtQoQv1r443mFM8uff91xU/ASzdSeLlBoVmZF35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBuyteZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29751C4CEC0;
	Sat, 31 Aug 2024 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725086562;
	bh=RJ8RqrepOIn9xN7g8pAcnilEva80xBqyvr9dmVEw2zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBuyteZuyjY3yTglAvhZuBB7/ogERVv7og59ZpGejQNvz5v6WBRJqXsvfgOGAfrEE
	 Zmx2e2NguG2ZARY5UCiX+xPlnFrCGzytGZpu5T+XvxC8WYgkbttuwRnoBSs3S+cv5q
	 t/Je+S8FwqypyxiYM+pcHSmO8mzI8+e2EDpKKBUsQj3Vl3UokIwV8/gUa+6RqYmLnw
	 vg1J9Vxxt+BWdXppLpZzgDkmKh0XxeE3CO5Jh89J4CG88ZotMllzWKgUXesCB/6etl
	 kN5CVi0C+d+aJ7NyzaoQ7cNZDesBxMAGwopgjGbjvIMXzL4U53+N0M1Y7+IDDXx5oZ
	 Yf6Oza0gW3k1w==
Date: Sat, 31 Aug 2024 08:42:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@softing.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Message-ID: <ypez4vjmasehqflgi4ylylpicldabf2dc6wwjco34qr2zmkdvx@enejrjjyaulf>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>

On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
> >From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00 2001

Some junk ^^^ above. Please investigate how you send patches.

> From: Tobias Sperling <tobias.sperling@softing.com>
> Date: Fri, 23 Aug 2024 12:08:33 +0200
> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8

And all this suggests malformed patch.

> 
> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> analog-to-digital converters. These ADCs have a wide operating range and
> a wide feature set. Communication is based on an I2C interface.
> The driver provides the functionality of manually reading single channels
> or sequentially reading all channels automatically.
> 
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> ---
>  .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
>  Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
>  Documentation/hwmon/index.rst                 |   1 +

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run  and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

>  3 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
>  create mode 100644 Documentation/hwmon/ads71x8.rst
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml b/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
> new file mode 100644
> index 000000000000..e422c4ebd207
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ads71x8.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +

Drop blank line

> +$id: http://devicetree.org/schemas/hwmon/ti,ads71x8.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - None

Fidn a person... otherwise why would we care?

> +
> +description: |
> +  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (ADC)
> +  with an I2C interface.
> +
> +  Datasheets:
> +    https://www.ti.com/product/ADS7128
> +    https://www.ti.com/product/ADS7138
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7128
> +      - ti,ads7138
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      The regulator used as analog supply voltage as well as reference voltage.
> +
> +  ti,mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      Operation mode
> +      Mode 0 - Manual mode. A channel is only sampled when the according input
> +        in the sysfs is read.
> +      Mode 1 - Auto mode. All channels are automatically sampled sequentially.
> +        Reading an input returns the last valid sample. In this mode further
> +        features like statistics and interrupts are available.

Use string instead.

> +    default: 0
> +
> +  ti,interval:
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    description: |
> +      Only considered in mode 1!
> +      Interval in microseconds a new sample is triggered. Is set to closest
> +      possible interval, see datasheet.

User proper unit-suffix.

> +    default: 1
> +
> +  interrupts:
> +    description: |
> +      Only considered in mode 1!

What is "considered"? Driver considers? This does not matter. Describe
the hardware and if this is hardware related, you should have
allOf:if:then restricting this.

> +      Interrupt specifier the device's ALERT pin is connected to. Level must be
> +      IRQ_TYPE_LEVEL_LOW. If not configured the digital window comparator (DWC)
> +      is not available.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ads7138@10 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "ti,ads7138";
> +            reg = <0x10>;
> +            avdd-supply = <&reg_stb_3v3>;
> +            ti,mode = /bits/ 8 <1>;
> +            ti,interval = /bits/ 16 <1000>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +            status = "okay";

Drop

Best regards,
Krzysztof


