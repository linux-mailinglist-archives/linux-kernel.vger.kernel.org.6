Return-Path: <linux-kernel+bounces-309260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6A96683A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0969B28330D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB61BB6B4;
	Fri, 30 Aug 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMY24y3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B481C6A5;
	Fri, 30 Aug 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039784; cv=none; b=d+fpAYlEZhJfdWn125vrG7sZLwZoiQuBjEsKbknBlCA/a1LBo3nVIME7OEIerYzep0my1Qfu3TqEMmtUPAimCF2E+L43JyT8kRopD+y8G84P2Si1lpys2phexK2Sc1DGmf6KIWA6DorEIB73x0iP9r8vwMzol6O39PKTfGW4AHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039784; c=relaxed/simple;
	bh=uG9/JQIdbEu96p4oSPxyLfmE2ss4VuClCzwnEHEd22Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/TklF5PuLDAFFk5Bu8YrqbBOo10Aok2YXoMBggTDiwF2PmPRcGyFTZjNVS5x9JA7b1rovNH77bDLseDvXMrkR4Ozqn/TGjzVw0VurU3xkl0JACPxX98U6bTCZC4TPMW7MLgYlzammw33XS1m69tsgWQuddUq3fhLPbtISlwDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMY24y3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB1DC4CEC2;
	Fri, 30 Aug 2024 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039783;
	bh=uG9/JQIdbEu96p4oSPxyLfmE2ss4VuClCzwnEHEd22Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMY24y3fqm3RrXNMQJyMYA/rf7AeYALggfmKOq0odYWcDsz11dMiKMhC/m485kK3x
	 68h0KBrW830HXw9lwy1tXecOASizcUcyX9I8i76GKHpCnyQ4m5zBKc6qTrx76iRtWx
	 rw95H0KjRmA9h5p5jyTgqKEADo38kSwk6k4pB72vwk+ZrfIOg0Q+Kmbzfu0XEwFBzj
	 QefRMQOXiV6GliOv22oSVsFV0+8UfJw6zUT0+ds9qje3DtOYFJTrGCqwUs6oL+hA4t
	 2g6+269msUVRq1GA7f1hKjCt3Fnbv/7Jj16o1lHyilyCDmV5hDcvcfmore+OxojdbX
	 y9TQvwInF+XMw==
Date: Fri, 30 Aug 2024 12:43:02 -0500
From: Rob Herring <robh@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
	srk@ti.com, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: ti, gpmc-nand: support partitions node
Message-ID: <20240830174302.GA551760-robh@kernel.org>
References: <20240830-gpmc-dtb-v1-1-792cac1ef3cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-gpmc-dtb-v1-1-792cac1ef3cc@kernel.org>

On Fri, Aug 30, 2024 at 03:27:53PM +0300, Roger Quadros wrote:
> Allow fixed-partitions to be specified through a partitions
> node.
> 
> Fixes the below dtbs_check warning:
> 
> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: nand@0,0: Unevaluated properties are not allowed ('partitions' was unexpected)
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> index 115682fa81b7..c2143f943e7f 100644
> --- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> @@ -61,6 +61,11 @@ properties:
>        GPIO connection to R/B signal from NAND chip
>      maxItems: 1
>  
> +  partitions:
> +    type: object
> +    description:
> +      Node containing description of fixed partitions.
> +
>  patternProperties:
>    "@[0-9a-f]+$":
>      $ref: /schemas/mtd/partitions/partition.yaml

This and the addition should be replaced with a mtd.yaml reference.

Rob

