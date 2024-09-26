Return-Path: <linux-kernel+bounces-341079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D742A987B30
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB101C22071
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AB1A0BEA;
	Thu, 26 Sep 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/JjJk5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA91A0BDC;
	Thu, 26 Sep 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390239; cv=none; b=JcIPgmquaWc+rQKNxm6jKlO/VFG0I2EkS10OZJFV3DKKGny1eqSfVtevd+NitkBcRhVQhdlPilbQmd9Lr6SnMXy7B61ml7CE7aObiHojxfhZLi/x6jcEO2+rRHtw5x+QstNmXB6VFbs6QwsdCIuFmVkP87JS4If+cRHr4VU+tE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390239; c=relaxed/simple;
	bh=fBlDT+t+lXuUmaW16stj9OGmjvnkKgQvnsys3tk0Kgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9n+pPD+vYxKx1cWR9XkL00i1S9w+uY257izGAJa3rTAfoHRVzc8N5mTL5LB+EWTGEvyXTojXIkOZ4MfkyLwz259L6izCceroOBH5FDJBKRStuxkZ1IPBFfykk7PAq+3liorsNktewYUwPcZjUUQZS6wJ4diq9AvputOTDKrtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/JjJk5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE7AC4CEC5;
	Thu, 26 Sep 2024 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390239;
	bh=fBlDT+t+lXuUmaW16stj9OGmjvnkKgQvnsys3tk0Kgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/JjJk5lBZTJthy9vmFBZeyiftLhpLm/ItiGZCHSgOUc3NkJmOFRVlq5TGk3jlJqC
	 hX15SqCAiYjJHIP+WDEmmNZfpCsm5qaJ+q1Mv/xhWnPfdJ1kmHiyblsHubmHPIpVsJ
	 7mLQRaecmOshwbJ0LdSkdShcEa9dEJZRHEOMwLZFMDa554mwGKctQrhtC25YUDM5eV
	 Vmz7NMD0ad4uMsCrrws3TuTKuT8JWWKskt6VN9acVA2+b2qZxrPLOm8XyoElG8cPsl
	 E9SCo7gkGZkKqucgGu/A7sxGRMu8b4TenGWOnweFHoA1kItW0+GQdSOhBr/k76I8P/
	 KkAmaLwXl1Veg==
Date: Thu, 26 Sep 2024 17:37:18 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] dt-bindings: examples: Add GPIO hogs and variable-lists
Message-ID: <20240926223718.GA3116989-robh@kernel.org>
References: <20240926134218.20863-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926134218.20863-1-krzysztof.kozlowski@linaro.org>

On Thu, Sep 26, 2024 at 03:42:18PM +0200, Krzysztof Kozlowski wrote:
> Same Devicetree binding can be expressed multiple ways thus no wonder
> we have multiple variants of similar concept.  All such code could be
> cleaned up, but even then new contributor might not be able to find
> good, existing binding solving their case.
> 
> Add subdirectory with two Devicetree schema examples (GPIO hog and
> variable lists like clocks), hoping it will grow with reference-designs.
> All these bindings use valid compatibles, although with "test" vendor
> prefix, so they will be validated by DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> If approach is accepted, I will come with more ideas, as commented
> during LPC DT BoF to creates examples based on review.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/example-schema.yaml   |   2 +
>  .../examples/gpio-controller-and-hogs.yaml    |  72 ++++++++++++
>  .../multiple-variants-and-variable-lists.yaml | 110 ++++++++++++++++++
>  .../devicetree/bindings/writing-schema.rst    |   6 +-
>  4 files changed, 189 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml
>  create mode 100644 Documentation/devicetree/bindings/examples/multiple-variants-and-variable-lists.yaml
> 
> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
> index a41f9b9a196b..0aece1823fde 100644
> --- a/Documentation/devicetree/bindings/example-schema.yaml
> +++ b/Documentation/devicetree/bindings/example-schema.yaml
> @@ -25,6 +25,8 @@ description: |
>    indentation less than the first line of the literal block. Lines also cannot
>    begin with a tab character.
>  
> +  See also examples/ subdirectory for more detailed code snippets.
> +
>  select: false
>    # 'select' is a schema applied to a DT node to determine if this binding
>    # schema should be applied to the node. It is optional and by default the
> diff --git a/Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml b/Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml
> new file mode 100644
> index 000000000000..597a847daa12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/examples/gpio-controller-and-hogs.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/examples/gpio-controller-and-hogs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: An Example GPIO Controller with Hogs
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Conor Dooley <conor@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: test,gpio-controller-and-hogs
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 32
> +
> +  gpio-ranges:
> +    minItems: 1
> +    maxItems: 16
> +
> +  # Not every GPIO controller is an interrupt-controller
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +patternProperties:
> +  "-hog(-[0-9]+)?$":
> +    type: object
> +    required:
> +      - gpio-hog

The best way to ensure this is done right is eliminate the need rather 
than adding examples to be ignored.

I think we need to make gpio provider bindings reference gpio.yaml and 
then handle hogs there. Generally, the pattern is that providers which 
just list properties don't have a $ref to the provider schema and are 
always applied. Schemas that have child nodes like bus schemas are 
referenced by the specific controller schemas. GPIO started out as the 
former, but the addition of hogs made it more like the latter. That of 
course means that every GPIO provider can have hogs, but I think that's 
the right answer even though I'd really prefer no hogs at all.

Always applying schemas like gpio.yaml has some benefits over relying 
on applying it via $ref, but that's diminished once everything has a 
schema. Of course, we can do both at the expense of applying the schema 
twice.

Rob

