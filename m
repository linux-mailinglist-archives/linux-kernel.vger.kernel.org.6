Return-Path: <linux-kernel+bounces-310692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FEC968031
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C71A1F233C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9B18595B;
	Mon,  2 Sep 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdV0graF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D516C695;
	Mon,  2 Sep 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261070; cv=none; b=R0QufIykNwATZsD33gwniOwz3NQmE6/lZ5tRYiZSJhKGZF6iwK27Uoo+yUHrYhqA5YnIuAVOoLPiOW/Boj6SoRd9CbFtqp87ZcfzNr0exyNon5AMcrWIW8MnLtjaSoY8B9c7TL+LWdxFRKHlVc8WXEbxm+8pQ2rsF74kQowM9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261070; c=relaxed/simple;
	bh=qMkQznHAdfXGd0UEsfT+EpORLG4corUXuRreY7UWUbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFu9+1vOaK7Gf1zEAdErDttK6BAa87odykqGADPsTEy5dlibp6JKosnKL7oAlFs5XeZ2Ns4BDeYTGX8SLSExajBfQ40Mi2SueM6aNxpLIxmfCHPkvtLx2ZyJeJ5ax8PDz9PF3tEO28oBV7wbGJzMcwwp8GO2u+UFu3pD4x159n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdV0graF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD694C4CEC2;
	Mon,  2 Sep 2024 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261069;
	bh=qMkQznHAdfXGd0UEsfT+EpORLG4corUXuRreY7UWUbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdV0graFY5X+YvbbHv4MxHlxyUQPvejYrFL/0FWiixN1GMMxpnDO7Euz/7mByVL1L
	 /QgW12NtzMtIxN09Hm0HoJSGwxZ50D57vMaCZIa3QtW6n47R7gR0sOCqghdbSwFFnA
	 mF+3bpnS22386CMGzK9hpD2JKvhh4oY2QauDkab0wG5OCQALXz0cHa0kraUnlFzRln
	 ybOPOIfVZkLxytZ/PlsiWDWFZXlGCZb3LX5Q9Ax4AVAPmizC5tqrD4/6TGgpKQwHHl
	 416edA7HKHKFIM0Dra5/oryULlHxer1mxhWwXzCp7mACluyPB/8AM1hDSpc7lrjY7M
	 Q7zxLwk567hXA==
Date: Mon, 2 Sep 2024 09:11:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	"open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: memory-controllers: fsl,ifc: add
 compatible string fsl,ifc-nand
Message-ID: <l2xjrs7txycf3uhhhyzypfzoem2fr4fsvbyg3bt4ktfpbzxz47@loiytha55oml>
References: <20240830191144.1375849-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830191144.1375849-1-Frank.Li@nxp.com>

On Fri, Aug 30, 2024 at 03:11:43PM -0400, Frank Li wrote:
> ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
> and compatible string "fsl,ifc-nand" when ifc connect to nand flash.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
> 	failed to match any schema with compatible: ['fsl,ifc-nand']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - add partition child node for nand
> - Only partition property is used at ppc
> Change from v1 to v2
> - add address-cells and size-cells
> ---
>  .../memory-controllers/fsl/fsl,ifc.yaml       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> index d1c3421bee107..5a11224da8914 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> @@ -58,6 +58,32 @@ properties:
>        access window as configured.
>  
>  patternProperties:
> +  "^nand@[a-f0-9]+(,[a-f0-9]+)+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: fsl,ifc-nand
> +
> +      reg:
> +        maxItems: 1
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 1
> +
> +    patternProperties:
> +      "^partition@[0-9a-f]+":
> +        $ref: /schemas/mtd/partitions/partition.yaml#
> +        deprecated: true
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: false
> +
>    "^.*@[a-f0-9]+(,[a-f0-9]+)+$":

This pattern is for NAND already. I don't understand why you are
duplicating it. If this part does not work, fix it.

Best regards,
Krzysztof


