Return-Path: <linux-kernel+bounces-305063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9019628D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2561C21C23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC833187879;
	Wed, 28 Aug 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INzfTGWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A71862B3;
	Wed, 28 Aug 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852256; cv=none; b=j9N7nhtwg321PYwN4YK/bZtCJEbtMJJd+j+c1C1U3EUhVbbgbfaLQbwXbyA8EBCICtEWXFQpXlwa0lhudo5DpGDAeEU4FO/9LhF3hL4X71gVBqQDEhp0urA99D+JKUOWrrNzLGcDozGuRX2v75pN6mqe5L/ZsZePRqdsRqM5XWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852256; c=relaxed/simple;
	bh=KohNPqr7ETWS1kn2mut3vxJ3dYAgefPzIWcOnMsMYbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka8LUicFYsjwYAWmGwsVFLlDsy0DHxMVo6VjmUk0Weu8X2lPF+5nVg0UvdMyA/R3Pmy788oc+7gc19hDZ1AIQNd4I2IexdZ2p8Dpxjfrd9OXwqTKfzZLsF29o8q2+UZq91B4R7T13Y8PFmL9s52TQPyG2QzOxSRCDBbqG5ij5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INzfTGWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678A7C567CD;
	Wed, 28 Aug 2024 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852255;
	bh=KohNPqr7ETWS1kn2mut3vxJ3dYAgefPzIWcOnMsMYbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INzfTGWQgjSGxFUugGU75A1T0mwNFfF4fX90FT9O9cVaM393Ulvdi7uKyrdJFcvR2
	 y5Ws07VOxJcysms6pYzTxxvUTFTGKd30OTX3pP60KprUDd/KMOW8rJCA/DgJiYfmOx
	 6VE6QCTavp1L2aYIKnEkiHioIvSC6UXsY4wtvBggunCVe4BUfUhRu8s6IfEzdZGSBg
	 TfXuzu/NLeYjM+SsZ4lpxsm/aTtFUlOQrvX295diXSCVvWzwB3Mk3JlHJ/WPv/5IoT
	 sG8W1XDrqxuzPMtavBl0lLsnw91y8Kv19uBxzphElOfLEIPL4kwjbsl9otSMINvgpf
	 OY8SUCl+tntzw==
Date: Wed, 28 Aug 2024 08:37:33 -0500
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: clocks: add binding for
 gated-fixed-clocks
Message-ID: <20240828133733.GA3650798-robh@kernel.org>
References: <20240828101503.1478491-1-heiko@sntech.de>
 <20240828101503.1478491-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828101503.1478491-2-heiko@sntech.de>

On Wed, Aug 28, 2024 at 12:14:59PM +0200, Heiko Stuebner wrote:
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
>  .../bindings/clock/gated-fixed-clock.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml b/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
> new file mode 100644
> index 000000000000..76d264770d35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/gated-fixed-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gated Fixed clock
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: gated-fixed-clock
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
> +      Contains a single GPIO specifier for the GPIO that enables and disables
> +      the oscillator.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: handle of the regulator that provides the supply voltage
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

clock-1000000000

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


> +      compatible = "gated-fixed-clock";
> +      #clock-cells = <0>;
> +      clock-frequency = <1000000000>;
> +      vdd-supply = <&reg_vdd>;
> +    };
> +...
> -- 
> 2.43.0
> 

