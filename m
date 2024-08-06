Return-Path: <linux-kernel+bounces-276669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9A9496CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D328A38F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B45481B7;
	Tue,  6 Aug 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRDu42hk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC3482E2;
	Tue,  6 Aug 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965358; cv=none; b=piofFYC5ZrueIOZVsgbMBsIPUT52jj+lbYRX1PgLDVR5zlTk23KbORIWZgT1dFu2PbWvMHd2s1/PKYlkvToyYL/AzObzd3AZpPbLTKgNHJ8k4j+l5x6wBn0Nv9Vz7+tv9sx/M55fFEBgqsEQqJEoclG8OKWjfanUvSA40aY9Sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965358; c=relaxed/simple;
	bh=DofvQUUcQFIETiczpIF5gJHLeGYi8mKOd63Og3SACc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhJPDBOVzshBvzWc9lFFOJ/EQtvNKXsFpIoL0JDWwXOerx8QJS3tK9r35vvVebagjxgrYtZRbA3hHnOYQcb+rE/CoXwosH3hNJMCokZSebSU36KFdRW3GbfJxKTA6gQtkOffELPgdVCRIxpjjcRbsvM4IDbz6WnvRy39nuslpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRDu42hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B64C32786;
	Tue,  6 Aug 2024 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722965358;
	bh=DofvQUUcQFIETiczpIF5gJHLeGYi8mKOd63Og3SACc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRDu42hksbv/tG52EbZeMZeva3thQioloHG/Z1Qw7xVZQAhDp5Gs804PeAQMBdnix
	 dCfqnFN3B+/GtHuSKoSYLT/8dG39eSny57VmPTy9yX7MbLs+ZTGUGvlZ/nwbE564hF
	 qbQtNaKe48/NFBNt9sr36hoUb0Obp/pp1RIf8WzwJwOD5cgoNFXsArMLlvQae7RPYj
	 YEnIHr9wZkunFUSEEJ27eNd7b1X86fDetDMG3i25ilou8Ci6bcKzoIOD8Melhs4aTC
	 3XLKpPcauLjyp3+o6lczmtb7VzuBg1SbQ0eZz6sgJEQqr0+qJb9riNlSRvHZD7XdLc
	 O2XA1cXEI3ZWQ==
Date: Tue, 6 Aug 2024 11:29:17 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to
 DT schema
Message-ID: <20240806172917.GA1836473-robh@kernel.org>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>

On Fri, Aug 02, 2024 at 03:06:31PM +0930, Andrew Jeffery wrote:
> Address warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: interrupt-controller@1e6c0080: 'valid-sources' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> and
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/copro-interrupt-controller@1e6c2000: failed to match any schema with compatible: ['aspeed,ast2400-cvic', 'aspeed-cvic']
> 
> Note that the conversion to DT schema causes some further warnings to
> be emitted, because the Aspeed devicetrees are not in great shape. These
> new warnings are resolved in a separate series:
> 
> https://lore.kernel.org/lkml/20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au/
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 ++++++++++++++++++++++
>  .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 -------------
>  2 files changed, 60 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
> new file mode 100644
> index 000000000000..3c85b4924c05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/aspeed,ast2400-cvic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Coprocessor Vectored Interrupt Controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +description:
> +  The Aspeed AST2400 and AST2500 SoCs have a controller that provides interrupts
> +  to the ColdFire coprocessor. It's not a normal interrupt controller and it
> +  would be rather inconvenient to create an interrupt tree for it, as it
> +  somewhat shares some of the same sources as the main ARM interrupt controller
> +  but with different numbers.
> +
> +  The AST2500 also supports a software generated interrupt.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2400-cvic
> +          - aspeed,ast2500-cvic
> +      - const: aspeed,cvic
> +
> +  reg:
> +    maxItems: 1
> +
> +  valid-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      One cell, bitmap of support sources for the implementation.
> +
> +  copro-sw-interrupts:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      A list of interrupt numbers that can be used as software interrupts from
> +      the ARM to the coprocessor.
> +
> +required:
> +  - compatible
> +  - reg
> +  - valid-sources
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#

Doesn't really look like this schema applies to this binding. Drop the 
ref.


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller@1e6c2000 {
> +        compatible = "aspeed,ast2500-cvic", "aspeed,cvic";
> +        reg = <0x1e6c2000 0x80>;
> +        valid-sources = <0xffffffff>;
> +        copro-sw-interrupts = <1>;
> +    };

