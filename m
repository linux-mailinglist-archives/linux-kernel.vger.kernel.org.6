Return-Path: <linux-kernel+bounces-352019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617ED99192D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292AC28279D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861FF156C62;
	Sat,  5 Oct 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o11AYQI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2540C15;
	Sat,  5 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151408; cv=none; b=mI0JNE4rBYZWQecRTz9T+/u/mJDitDu45GRSFdJVlgKXi4oWeMVdEF3cEjYVZxIVptsy7EFShR/sIJSbIZRCAyRUSISt2q2VXJ84H6/oazgLSMFhwXQ3A0ia8gYIMO5oIv8c+sqzMKRA6tQdMg049McpT6LQ+SjJ2sSuL+XUrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151408; c=relaxed/simple;
	bh=z4gaMaqg3Qk6lcaCoRlk18X/H4t7OlOiQT6qkqTE8To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKQIN2Z0CYmEVYHYkO+nynOBuVWxuqOhe9rpDQSebVR+tdAvBoiHCVqeOnnBJDUrCUkVxz4vcrd3Pm4LAIaAhThhPropxDxatyaIHt1MFugDaBYOV8JZIfNsiPDF1MwsNWo6OYzi7k+c7cIYTyNAYFVAM+RPYBxLrQh1/PFlOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o11AYQI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572FEC4CEC2;
	Sat,  5 Oct 2024 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151407;
	bh=z4gaMaqg3Qk6lcaCoRlk18X/H4t7OlOiQT6qkqTE8To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o11AYQI81PbeHF+tykM9NCsWEN/xq+FfVe+4/J+yoknqfuKkRPzrJZDlRsHq83tw2
	 1nFJ1m/SKVpFspq2rwVltKLBG3G9rccSHkvnS/0ffcNeqpPFEuRuqMl8JhBZTMlLfi
	 0VzAr/aOJcZbc0LtFiwXqytYl6C3IlasUH6sbDqXWNgFfyEfLuVNHzXiRseRpxVWa9
	 JC0sRPmCHwygz4q11fOtnSW/lqpttlsQOa66OOX66PfJLWoCTnNHSnUzvQZgM8vNUT
	 rU640UyZ/DhYOqe9/guSz1r6yl6SjmZBchrPD3ZhkBTQ11uSZoVaFcjTXMCqSuWC5k
	 yNYqPugzkINQA==
Date: Sat, 5 Oct 2024 13:03:26 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq:
 workaround wrong interrupt-map number
Message-ID: <20241005180326.GA447512-robh@kernel.org>
References: <20241003214315.638668-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003214315.638668-1-Frank.Li@nxp.com>

On Thu, Oct 03, 2024 at 05:43:15PM -0400, Frank Li wrote:
> The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> function to parser interrupt-map. So it doesn't consider '#address-size'
> in parent interrupt controller, such as GIC.
> 
> When dt-binding verify interrupt-map, item data matrix is spitted at
> incorrect position. So cause below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
> interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
> is too short
> 
> Reduce minItems and maxItems to workaround this warning for
> 'fsl,ls1088a-extirq', 'fsl,ls2080a-extirq' and fsl,lx2160a-extirq.
> Other keep the same restriction.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - remove duplicate function in commit message
> - only reduce miniItems for after 1088a chips
> - maxItems change to 9. Otherwise report too long.
> ---
>  .../interrupt-controller/fsl,ls-extirq.yaml   | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> index 199b34fdbefc4..1bfced6ed620c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> @@ -82,14 +82,37 @@ allOf:
>              enum:
>                - fsl,ls1043a-extirq
>                - fsl,ls1046a-extirq
> +    then:
> +      properties:
> +        interrupt-map:
> +          minItems: 12
> +          maxItems: 12
> +        interrupt-map-mask:
> +          items:
> +            - const: 0xf
> +            - const: 0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
>                - fsl,ls1088a-extirq
>                - fsl,ls2080a-extirq
>                - fsl,lx2160a-extirq
> +# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
> +# function function to parser interrupt-map. So it doesn't consider
> +# '#address-size' in parent interrupt controller, such as GIC.
> +#
> +# When dt-binding verify interrupt-map, item data matrix is spitted at
> +# incorrect position. Reduce minItems and maxItems to workaround this
> +# problem.
> +
>      then:
>        properties:
>          interrupt-map:
> -          minItems: 12
> -          maxItems: 12
> +          minItems: 8
> +          maxItems: 9

I think it is probably better to just not put in any constraints. It's 
never going to be parsed correctly.

Rob


