Return-Path: <linux-kernel+bounces-425271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597F9DBFB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D583D28180B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052411581E1;
	Fri, 29 Nov 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3auW3c1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECE45C14;
	Fri, 29 Nov 2024 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864812; cv=none; b=fD5rojiJGMkb4pfU5QkF6OOkWvasfPuUBGeTLHA1qvWIKHY2Gqh5ErP7txqG7B00bAMMyJ9L0apCWdfxd3FgLz7WoVveIx40vv5lVmHZxTDdypfpacsQBHfXiOq2qeraL/IBvRrvkqMzJoRaVQe6Cxa78EXPiIxpOE1s11pfD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864812; c=relaxed/simple;
	bh=f5K7i1Tg3ZRRth7tKZoWQuEu/Q0cKzBkqzpXHnSj30I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAC3HDx2lXwjQAMFbjDZR3LomkDJQBOUE/zqVVwnIjVLkNdca6g528FIZBaIG2ydQqFPVIbUIBHaQR0+1gRgvJS3yAlCBQvF9tgkeArYgPLhZF2RFvIPk+n1NiaIPAPgM9EzL4+bY/wE6myh7T0XwvrUg+rVT+K18N4f21jHpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3auW3c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464C2C4CECF;
	Fri, 29 Nov 2024 07:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732864811;
	bh=f5K7i1Tg3ZRRth7tKZoWQuEu/Q0cKzBkqzpXHnSj30I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3auW3c1D7g2OnfW0zxlaGz+VnEVe0MCoZTpLvcH6B9G6ew1dDAd3wpTK3sVHcQYq
	 q60LnPtWyeJVczx7yxjhZG2BIV5OUAuYcVR1iUlpwHM+qmIzpWAyAZrkubtKDIM8vv
	 Rs41J8fBJi4LVu6xiJGe5zubQ2zG5drEcvnq0MZvgJjcLgFm6gPr4IEKA3z643ff6F
	 207rFsAanfxSzmUr7iaQtkqcVlt5VREJDTUHPSdmXacMQQ+amOyknnIzvq2QmYYLED
	 +Cd2zUuMEj3A3p/InDtwR4HLslNxMWi7KSTu62o40z8H0tCi2SKRl+o2D4bCmXtGEF
	 4BEAYOv2hBLuQ==
Date: Fri, 29 Nov 2024 08:20:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, u-kumar1@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: misc: bist: Add BIST dt-binding for TI
 K3 devices
Message-ID: <ho7ktcnbtl7mvamfthqho23co2fc4z7bgjha7pu4wivxm6ndhu@tfbpveonhckz>
References: <20241128140825.263216-1-n-francis@ti.com>
 <20241128140825.263216-2-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128140825.263216-2-n-francis@ti.com>

On Thu, Nov 28, 2024 at 07:38:24PM +0530, Neha Malcom Francis wrote:
> Document the binding for TI K3 BIST (Built-In Self Test) block.
> 

A nit, subject: drop second/last, redundant "dt-binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../bindings/misc/ti,j784s4-bist.yaml         | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml

soc directory, not misc.

> 
> diff --git a/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml b/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
> new file mode 100644
> index 000000000000..bd1b42734b3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/ti,j784s4-bist.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 BIST
> +
> +maintainers:
> +  - Neha Malcom Francis <n-francis@ti.com>
> +
> +description:
> +  The BIST (Built-In Self Test) module is an IP block present in K3 devices
> +  that support triggering of BIST tests, both PBIST (Memory BIST) and LBIST
> +  (Logic BIST) on a core. Both tests are destructive in nature. At boot, BIST
> +  is executed by hardware for the MCU domain automatically as part of HW POST.
> +
> +properties:
> +  compatible:
> +    const: ti,j784s4-bist
> +
> +  reg:
> +    minItems: 2

Drop minItems

> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: ctrl_mmr
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ti,bist-instance:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      the BIST instance in the SoC represented as an integer

No instance indices are allowed. Drop.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ti,bist-instance
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        bist@33c0000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Come with something, don't just use device name.

> +            compatible = "ti,j784s4-bist";
> +            reg = <0x00 0x033c0000 0x00 0x400>,
> +            <0x00 0x0010c1a0 0x00 0x01c>;

Misaligned code.

Best regards,
Krzysztof


