Return-Path: <linux-kernel+bounces-291099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B7955D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEB2B20E47
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BEC143C7E;
	Sun, 18 Aug 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJx/Mv7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0333CFC;
	Sun, 18 Aug 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995556; cv=none; b=tyS6QU6L4Hj/rudW87fjmq6O9b40mLcvLWaVFD8DQeDDBOakJ/zdc/p2JKrtY1v4JKForKlftx2/iaZT1TGzML4FFBFxs33pVwha58b6ZT1hBSJj4ji95TiPN0kfgqg/iwMGhRKATO4YmR65cyPEj9ZFxArJ+2VIp4ydrFL+53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995556; c=relaxed/simple;
	bh=puy82X73of98/57pg6dp3PYkdE1fTuT9RzejeNrtwA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHgd9SM4nz3Pjg8yq5+tLjSvDPna1EAaFHLWCVD3Ki4NLHT0bzMyIPI5tyRKhWx4TGl35pYwj/l8Lx5GUyrMLb2d7HcCH+f+3kWjTalEpWa24VlFZkuR5cLdtDtYfU+T+AbxAuY2PzSSPUfLTobsZzkThzMGJ/+3C2xHHrrTcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJx/Mv7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4CFC32786;
	Sun, 18 Aug 2024 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723995556;
	bh=puy82X73of98/57pg6dp3PYkdE1fTuT9RzejeNrtwA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJx/Mv7Ce1BwZMOEm9xojqqHPEHjjJtpUgPClvMzjKxINTr2vuqPbZvH7GZc06tGK
	 ed2rvS4F/cw5H4qwHdAn9Um8OZBYmtlRKimU/4g/v0ntT+NLbo4wQ6VOfFOL/suvo2
	 qvdleHU0q7BSO6Ga5wgnY4qdxyhE9HDylG26tuvEvTogfwBTZPN2or9vXvBjYDho9n
	 o2sLO5tD6JhJ9NOAGBVrTKZbuovm0Q8PYa3hZG4pZAuRkbdkKF3+KiwHhzAhpJ2PjP
	 T4Mpk07+H1MevV6zLvrmv0y8T3XpzA3hhJZ6xhenDFzlToUkAGKYsTczrJI5Tw2A87
	 8+/0b4cchvD6w==
Date: Sun, 18 Aug 2024 09:39:14 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-binding: memory-controllers: fsl,ifc: add
 compatible string fsl,ifc-nand
Message-ID: <20240818153914.GA120816-robh@kernel.org>
References: <20240814212958.4047882-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814212958.4047882-1-Frank.Li@nxp.com>

On Wed, Aug 14, 2024 at 05:29:57PM -0400, Frank Li wrote:
> ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
> and compatible string "fsl,ifc-nand" when ifc connect to nand flash.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
> 	failed to match any schema with compatible: ['fsl,ifc-nand']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add address-cells and size-cells
> ---
>  .../memory-controllers/fsl/fsl,ifc.yaml       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> index d1c3421bee107..c12bb7f51db62 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
> @@ -58,6 +58,27 @@ properties:
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

These only apply to child nodes, but you've disabled any child nodes.

> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: false

You could minimally make this 'type: object' instead of false.

Or does this follow the nand controller and chip bindings? May not being 
older binding.

> +
>    "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
>      type: object
>      description: |
> -- 
> 2.34.1
> 

