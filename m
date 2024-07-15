Return-Path: <linux-kernel+bounces-252730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD59931769
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3581F22745
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5F18E76C;
	Mon, 15 Jul 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="B0EJk0B9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9F18EA8;
	Mon, 15 Jul 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056549; cv=none; b=P99No/RYsJcB+6lVsZV3CIQQVd88L3lGMwKM87H45n9R7G+K3wPReROSENzj+V1ru7h4fZDz5T7+e7l9aA+n+E9YBBNdCPotYU5YryCq4WMEuPcNnDIS1iBlgrtab8n+euK3CeKH02TeshEPjlfdCy6bITZAylxglYBoXgip2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056549; c=relaxed/simple;
	bh=PrfWqZ+oyP+xbwWswn799ArjrVELnraTZtJ/Lt1Dsy0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jX2GuOPG8ekzNvVoNKyWPC/aE/QaKyYTYBQAMWXRtvFRpb4PSsRn7HP+fxKT7XjRT4OqCjTYHu1DF2ZNEZqbodJmhXR2vOZZ3hAeHHQ6frTlCQkN8Zc4RPV0MplRaMOqG88j+b6KqSv6FXEiwWeBqbGBs1bx9Z5wcosoeQ5WbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=B0EJk0B9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721056545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ve+HcnJKK/0EVhGwswCoyHDfbPprdzw5K51U2Jo6x/A=;
	b=B0EJk0B941xU9Jc6UF4nz2OIfVUSQ5xWnDCQzRw366fRQ9I4f1pHLxM7AcPRFSX70uG2SM
	WDvAWM1Xh/Rc9bSFqd06E/UQOsaj992OIxPvSueXLI78/wuRor44IG+CQLNu21YiM6iCaA
	0kbfTTnbm8czhZQIGxEdV8BQFaEk1QJYkMMlxCK1QH/g7AzxY1FIAu2VsxyDYcX5+VLYCr
	nh+TJYpSqXufAALuX1USpynn42z5UiZ/XtuMTgmkJNFURQpPCG4XcOwWnoY7bBkhrsfKHB
	p8QYP6sbUVCnOE1ahYxv5WqaIJas5bphT3dXuSF2uWPdqc24beAzduCJuHFVYw==
Date: Mon, 15 Jul 2024 17:15:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
In-Reply-To: <20240715110251.261844-2-heiko@sntech.de>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
Message-ID: <ec84dc37e2c421ee6d31294e08392d57@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

Please see some comments below.

On 2024-07-15 13:02, Heiko Stuebner wrote:
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional oscillators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.
> 
> This adds a binding for such oscillators that are not configurable
> themself, but need to handle supplies for them to work.
> 
> In schematics they often can be seen as
> 
>          ----------------
> Enable - | 100MHz,3.3V, | - VDD
>          |    3225      |
>    GND - |              | - OUT
>          ----------------
> 
> or similar. The enable pin might be separate but can also just be tied
> to the vdd supply, hence it is optional in the binding.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> new file mode 100644
> index 0000000000000..8bff6b0fd582e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Voltage controlled oscillator

Frankly, I find the "voltage-oscillator" and "voltage controlled
oscillator" names awkward.  In general, "clock" is used throughout
the entire kernel, when it comes to naming files and defining
"compatible" strings.  Thus, I'd suggest that "clock" is used here
instead of "oscillator", because it's consistent and shorter.

How about using "gated-clock" for the "compatible" string, and
"Simple gated clock generator" instead of "voltage controlled
oscillator"?  Besides sounding awkward, "voltage controlled
oscillator" may suggest that the clock generator can be adjusted
or programmed somehow by applying the voltage, while it can only
be enabled or disabled that way, which is by definition clock
gating.  Thus, "gated-clock" and "Simple gated clock generator"
would fit very well.

> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: voltage-oscillator
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-frequency: true
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description:
> +      Contains a single GPIO specifier for the GPIO that enables and 
> disables
> +      the oscillator.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: handle of the regulator that provides the supply 
> voltage
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clock-frequency
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    voltage-oscillator {
> +      compatible = "voltage-oscillator";
> +      #clock-cells = <0>;
> +      clock-frequency = <1000000000>;
> +      vdd-supply = <&reg_vdd>;
> +    };
> +...

