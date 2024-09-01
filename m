Return-Path: <linux-kernel+bounces-310185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264A9675F8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B405282237
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3B15FA7B;
	Sun,  1 Sep 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snIbC2cI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091051F951;
	Sun,  1 Sep 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725188126; cv=none; b=UXLcl5nFu+4uCP6sRnOs1+C0j0GHJhINXW6J68A9xbMidqzqKvJBe3pXEIOyqnb/mxuJqIgyKCT8MLzu/VaHOr2+EYSolTmubd1a0T5WkR1QMzTDd9nVimOiX4gf2HbRZvu7AHb1z0InfqCsMbMoTY0LBAWMmlIK1QRgsZyoqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725188126; c=relaxed/simple;
	bh=plraTNt54P+K1V16ayCFlHbsakgVBMkJL+ftRk9B3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO3VqJc6U4fDToir2uO/N/lfkOhm1gsKFz4utsP1oM4np2fR3zVDxSLd7OYuNpSNZ/qdYNobo8QzQc6G9YE+pFRKUhMd7nO48hilKXz3i131PGNtic4yt01XW6/C3cbX5QD3rAK7fZunnzioFRWbkWkdJhJE2iFjpocTtMSNghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snIbC2cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F9AC4CEC3;
	Sun,  1 Sep 2024 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725188125;
	bh=plraTNt54P+K1V16ayCFlHbsakgVBMkJL+ftRk9B3+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snIbC2cItHQrF3rilQGwIjmsM/tQ25x+Ri3zNnhnnBDQRkEHOfsTzX5M5UoSV67QV
	 yV5XL1CCK52Uc0ZNMNpA3GxJIf+4t2I+3juws8FfCPJ6xoB4TgUOf0y8Hl9UBBVyv+
	 6DV0zddiF9EZ7yQtUPrLo2TEJThHrsAZciy6i6eEKscPV6dOfuy9Bmxzu8DCXtLMTz
	 VRhhz/taDkiJXqqMJ3X77imli91Q17F46QDv0O/NatHBjP0xrxVsnsaePJfbOm5Gf4
	 +L/Z6F4WTN5bV/HvJhE1agzfAT35OisK69BJzxXa4sTowXjUsKUhZfW3oUL6FPAEt9
	 JAwLH4VI3MCrw==
Date: Sun, 1 Sep 2024 12:55:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: Add clock controlers
 of Spacemit K1 SoC
Message-ID: <w4alphet2d56ojfpm5ibgxdkleb54uvvfsrw5iktzph7xsg3zj@ybofz6uo7qd4>
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>

On Sat, Aug 31, 2024 at 03:47:12PM +0000, Haylen Chu wrote:
> Add definition for the clock controllers of Spacemit K1 SoC. The clock
> tree is managed by several SoC parts, thus different compatible strings
> are added for each.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---

This wasn't ever tested...

>  .../bindings/clock/spacemit,ccu.yaml          | 116 +++++++++++
>  include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++++++++++++++
>  2 files changed, 313 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
>  create mode 100644 include/dt-bindings/clock/spacemit,ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> new file mode 100644
> index 000000000000..90ddfc5e2a2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/spacemit,ccu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spacemit SoC Clock Controller

What's the SoC name?

> +
> +maintainers:
> +  - Haylen Chu <heylenay@outlook.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spacemit,ccu-apbs
> +      - spacemit,ccu-mpmu
> +      - spacemit,ccu-apbc
> +      - spacemit,ccu-apmu
> +
> +  clocks: true

No, this must be specific. min/maxItems

> +
> +  clock-names: true

No, this must be specific. min/maxItems

> +
> +  spacemit,mpmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing "Main PMU (MPMU)" registers

Explain what for.


> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/spacemit,ccu.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +
> +additionalProperties: false

This goes after allOf block.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,ccu-apbs
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          const: pll1_2457p6_vco

Don't use some weird, fake names. That's pll or vco or whatever the
input is called.

> +
> +      required:
> +        - compatible
> +        - clocks
> +        - clock-names
> +        - "#clock-cells"
> +        - spacemit,mpmu
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,ccu-apbc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +
> +        clock-names:
> +          items:
> +            - const: clk_32k
> +            - const: vctcxo_1
> +            - const: vctcxo_24
> +            - const: vctcxo_3
> +
> +      required:
> +        - compatible
> +        - clocks
> +        - clock-names
> +        - "#clock-cells"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,ccu-apmu
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          const: vctcxo_24
> +
> +      required:
> +        - compatible
> +        - clocks
> +        - clock-names
> +        - "#clock-cells"
> +
> +examples:
> +  - |
> +    syscon_apbs: system-control@d4090000 {
> +        compatible = "spacemit,mpmu-syscon", "syscon",
> +        "simple-mfd";

Messed indentation.

Anyway, parent device nodes should have complete example.

> +        reg = <0x0 0xd4090000 0x0 0x1000>;
> +
> +        clk_apbs: clock-controller {
> +            compatible = "spacemit,ccu-apbs";
> +            clocks = <&pll1_2457p6_vco>;
> +            clock-names = "pll1_2457p6_vco";
> +            #clock-cells = <1>;
> +            spacemit,mpmu = <&syscon_mpmu>;
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/spacemit,ccu.h b/include/dt-bindings/clock/spacemit,ccu.h
> new file mode 100644
> index 000000000000..ce84690684ff
> --- /dev/null
> +++ b/include/dt-bindings/clock/spacemit,ccu.h
> @@ -0,0 +1,197 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */

Use the same license. (one pointed out by checkpatch)

Best regards,
Krzysztof


