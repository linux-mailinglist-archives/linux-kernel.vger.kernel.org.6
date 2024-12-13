Return-Path: <linux-kernel+bounces-444657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0EF9F0A62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC0283E67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F541CC8A7;
	Fri, 13 Dec 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0DrOFzW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782261C07FC;
	Fri, 13 Dec 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087991; cv=none; b=dHMjf0ZbONk8BsxP90lNsHbHLRtPN1W8gKY5UtSzpaQEx5f4xYNupt9lIBW3+1p9a/b/BMkHNIIS2lYOUBlEYro4vafi8z54gL4B+Y0WSgA4WKH4DwG1uf3vzt8CQply3bbw0L2Q0SI2wSEdKo121EST0vpK0JcMkcrqVjeD8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087991; c=relaxed/simple;
	bh=gfNtJViyjv6IWzkrbJzLL6JeNTj+0uEA9pj0kqDGYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw6KcfqFgwXvLR3jMgIm5Cu9976XeKaH9mSdsn4MW2ps3WfpCekVIFV/4FkzqwgoI9/tUyPAjSfHCAaD5OwWTbiDKA5Q54CzcTVQo6Guqee3tTAgUmb9Kmnvtf4QTBe5GXquYfJrhUm1T6wyaIrXRxScrrUIWXqrE5C/tPpWXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0DrOFzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C13C4CED4;
	Fri, 13 Dec 2024 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734087991;
	bh=gfNtJViyjv6IWzkrbJzLL6JeNTj+0uEA9pj0kqDGYdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0DrOFzW1lzj5avOj3VsULdBxX1szCjke3bk3l9X3tPOptnSVhjtOm1yY4EupAmsX
	 732bY1I7KbmuE4efk+iMzdltyGMsPt6WRbS2PR+pb4kdRdIddXCa9ddMs7BEZx4vml
	 /csW5g/BXKgPSFmYYPqWMAQS98jBF97G8IWZXmHAsKfogWmV5LxuFJ9TMpX9kmrGKR
	 Blc1FLw0CbYC2kZBfiiwqr9pqP6jQ22bZgJQtUR5XA3J3ZccDu0wgqsFQFE86bFUj9
	 Qo0CYSf52VCQrFNeTiCQu6Ddxv0pq1zketrHigUbnvxbAfyJSLSRnfvoQD3294p/gg
	 dBBesW0QHBHmg==
Date: Fri, 13 Dec 2024 12:06:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, kernel@axis.com, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add D3-323-AA
Message-ID: <wy7nyg3cztixe5y5rg4kbsbbly32h547hwumwwvrfme4fdgsj5@znfpypleebrb>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
 <20241212042412.702044-2-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212042412.702044-2-Hermes.Zhang@axis.com>

On Thu, Dec 12, 2024 at 12:24:09PM +0800, Hermes Zhang wrote:
> Add Devicetree binding documentation for Nicera D3-323-AA Pyroelectric
> IR sensor.
> 
> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> ---
>  .../bindings/hwmon/nicera,d3-323-aa.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml b/Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml
> new file mode 100644
> index 000000000000..31690e630b5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nicera,d3-323-aa.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/nicera,d3-323-aa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nicera D3-323-AA Pyroelectric IR sensor
> +
> +maintainers:
> +  - Hermes Zhang <Hermes.Zhang@axis.com>
> +
> +description: |
> +  Nicera D3-323-AA Pyroelectric IR sensor
> +
> +  datasheet:
> +    https://www.nicera.co.jp/wordpress/wp-content/uploads/2022/01/D3-323-AA_e.pdf
> +
> +properties:
> +  compatible:
> +    const: nicera,d3-323-aa

Undocumented vendor prefix.

It does not look like you tested the bindings, at least after quick
look. Please run 'make dt_binding_check' (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

It does not look like you tested the DTS against bindings. Please run
'make dtbs_check W=1' (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

> +
> +  reset-gpios:
> +    description: The GPIO pin connected to the reset pin on the sensor
> +    maxItems: 1
> +
> +  clk-gpios:
> +    description: The GPIO pin connected to the clk pin on the sensor

What is a clk pin? Usually clock pins are clocks, not GPIOs. This needs
explanation


> +    maxItems: 1
> +
> +  si-gpios:
> +    description: The GPIO pin connected to the si pin on the sensor

In all description please drop redundant pieces. It cannot be anything
else than GPIO pin and cannot be connected to something else than the
sensor.

So basically the only useful information you wrote above - after
dropping obvious and redundant pieces - is "si".

Write something useful, what is "si"? This applies also to "clk".
reset-gpios can be without description, because it is obvious - cannot
be anything else than reset pin. OTOH, you could say if pin is active
low or high.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - clk-gpios
> +  - si-gpios
> +

Just one blank line.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sensor {
> +        compatible = "nicera,d3-323-aa";
> +        reset-gpios = <&gpio4 12 0>;

Include the header and use standard defines for GPIO flags.

Best regards,
Krzysztof


