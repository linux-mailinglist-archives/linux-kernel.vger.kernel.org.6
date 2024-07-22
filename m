Return-Path: <linux-kernel+bounces-259378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B474A939504
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501C9B21A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8238DEC;
	Mon, 22 Jul 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUdXH/va"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDED2556F;
	Mon, 22 Jul 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681922; cv=none; b=WgLNOMIpEccxMXRLMtNNy+BC0rv6L2UHFX3uXjY2Qk4wh/COYinUYLaa9PHX+S8RycQ0JvGTMlb+P5J6ykI3ZOKjt7Asm8lfyyXyRNhT6+FMjAoCJNsQeA65/YN45EfYz5yp5xyApJJrLV3RHkTV5e+xl7vkkRoitM+m41KqdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681922; c=relaxed/simple;
	bh=oOoSVVZeEDv9+nG3nIfqETixsW3aB3cW9w8A1n80zJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uglQS5MwWeWcZrm7vT6nP9cT+uc6tNHRQnMP1B/H7I+zTkc6zSQIG3clyU4E9Sq68NcZrZbR/v6Kh34Lx3b0zwzrpDsN65ts6EukX5BgR54yfnTafYkQa87RyVtojgug0KthfGJRIIuHI+X66gMMeFu4E2To32rhQB8LGwk5rME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUdXH/va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E251C116B1;
	Mon, 22 Jul 2024 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681921;
	bh=oOoSVVZeEDv9+nG3nIfqETixsW3aB3cW9w8A1n80zJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUdXH/vaI0wFKGYuU8Wv3NWim6gzbRUlsPxlFSWIfhNa8lMttHeFPgViY/dj7hGya
	 trkcHb3ioEjdGPEQLLOjDbDEGIRYk1ofV5FnuU1j+7SICuxSNPZJRmTeJDgrmpk3Vh
	 VU921oLOIww474pPnSvMWnuuYkoUqsx6IF8gNlP6IUvDQBaxFgEfQRu2bCQW9wFiw2
	 b3GQrT4mEChAI3jzjbIKui22uuy0VbrIf39cT7yuOzMfWErycuEYzx4REighCfcenk
	 E8g/3Y+oqXm9hICBqma9YwFbih66F3Tu9FxuHl0LGbUMOp07Tjtj2TF9rUSdvtlCOt
	 7PUnjr12rcBpg==
Date: Mon, 22 Jul 2024 14:58:31 -0600
From: Rob Herring <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Borne <jborne@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 10/37] dt-bindings: kalray: Add CPU bindings for
 Kalray kvx
Message-ID: <20240722205831.GA72915-robh@kernel.org>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-11-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722094226.21602-11-ysionneau@kalrayinc.com>

On Mon, Jul 22, 2024 at 11:41:21AM +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add Kalray kvx CPU bindings.
> 
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: New patch
> ---
>  .../devicetree/bindings/kalray/cpus.yaml      | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kalray/cpus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/kalray/cpus.yaml b/Documentation/devicetree/bindings/kalray/cpus.yaml
> new file mode 100644
> index 0000000000000..cdf1f10573da7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kalray/cpus.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kalray/cpus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray CPUs
> +
> +maintainers:
> +  - Jonathan Borne <jborne@kalrayinc.com>
> +  - Julian Vetter <jvetter@kalrayinc.com>
> +  - Yann Sionneau <ysionneau@kalrayinc.com>
> +
> +allOf:
> +  - $ref: /schemas/cpu.yaml#
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +    description: |

Don't need '|' if no formatting.

> +      Contains the CPU number.

Ideally this is tied to something in the h/w and not just made up. If 
so, detail that here.

> +
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: kalray,kv3-1-pe
> +          - const: kalray,kv3-pe

What's the difference between these 2?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  enable-method:
> +    const: "kalray,coolidge-pwr-ctrl"

Why is this needed if there's only 1 possible option?

It doesn't need quotes either.

> +
> +  interrupt-controller:
> +    type: object
> +    additionalProperties: false
> +    description: Describes the CPU's local interrupt controller
> +
> +    properties:
> +      '#interrupt-cells':
> +        const: 1
> +
> +      compatible:
> +        const: kalray,kv3-1-intc
> +
> +      interrupt-controller: true
> +
> +      '#address-cells':
> +        const: 0
> +
> +    required:
> +      - compatible
> +      - '#interrupt-cells'
> +      - '#address-cells'
> +      - interrupt-controller
> +
> +if:
> +  properties:
> +    reg:
> +      const: 0
> +then:
> +  required:
> +    - clocks
> +
> +required:
> +  - reg
> +  - compatible
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    cpus {
> +        #size-cells = <0>;
> +        #address-cells = <1>;
> +
> +       cpu@0 {
> +         compatible = "kalray,kv3-1-pe";
> +         device_type = "cpu";
> +         reg = <0>;
> +         clocks = <&core_clk>;
> +         cpu_intc0: interrupt-controller {
> +           compatible = "kalray,kv3-1-intc";
> +           #interrupt-cells = <1>;
> +           #address-cells = <0>;
> +           interrupt-controller;
> +         };
> +       };
> +
> +

One blank line.

> +       cpu@1 {
> +         compatible = "kalray,kv3-1-pe";
> +         device_type = "cpu";
> +         reg = <1>;
> +         cpu_intc1: interrupt-controller {
> +           compatible = "kalray,kv3-1-intc";
> +           #interrupt-cells = <1>;
> +           #address-cells = <0>;
> +           interrupt-controller;
> +         };
> +       };
> +    };
> -- 
> 2.45.2
> 
> 
> 
> 
> 

