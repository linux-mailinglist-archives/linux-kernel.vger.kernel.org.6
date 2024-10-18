Return-Path: <linux-kernel+bounces-371718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F949A3F20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140E1C210E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C844375;
	Fri, 18 Oct 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUUBO1Cc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE84084C;
	Fri, 18 Oct 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256689; cv=none; b=n7L4s8gDOaGvjcr7TLZrBc9P/Z19UL5p+PYIMZnOs5a/aBF92Ji8sdiKiTrgYW874fXYIpkMVxoATqLMli6VpUbSlSNxvt4n3bFG5iPyvY3Mkn1/Ie6GGKsnDRz9QlKFUKnsBxHJTA6CaUFj9tuG+YVtviK4eOyxE1rG3SZpFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256689; c=relaxed/simple;
	bh=vkeST0HZ6U+cwIuAiBvC+R+grfkTjVnzYe4h2PQfbOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bA+2pyTlNe7A31bFekbSZ6eyliXjusfof4FoBIIafqjlAVZhqACSnnSKxQbHxs5WmCiSEK6N6HqDINxCc/JoU7cW7dIRRh6HGClhmCEIoHoQI2VwJ6Kr1NsseoJj1V4sYYsJrutQ5wdBKkORFopkpgZ96xPD9L9B2IHH9DD22nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUUBO1Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C360AC4CEC3;
	Fri, 18 Oct 2024 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729256689;
	bh=vkeST0HZ6U+cwIuAiBvC+R+grfkTjVnzYe4h2PQfbOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUUBO1CcQhBJB+h6W6Gm279RltOANp0SfGRIBvZvWFXSXeCjFisJ7THDubZTwPys8
	 VxG2gU8D42EFx5LnQvgoj9CF6NGmVcpMpZqMveuNq60v2K8jBmcg/mBiG7RAapSGYb
	 QlMrMzNCMuQmXUq+e1A5quORz/4jrEPd2SaNAv+iwwcL658dcUy3aeUYsDvp3y28J+
	 J2cXhsEa2YqZdCKDIO7TQ8368EckT06mzGpDSRkrWUUTovA6XeRDb51AxkQHbG9j6r
	 uPlyPjJAkJflhoFFU7uZnSeGAGU2q9R8CYJxyTkkTfVIcKnodpWPNWzVWAwVbai2tM
	 jVp70oB3OkDZg==
Date: Fri, 18 Oct 2024 08:04:47 -0500
From: Rob Herring <robh@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: soc: ti: ti,j721e-system-controller:
 Add PCIe ctrl property
Message-ID: <20241018130447.GA40439-robh@kernel.org>
References: <20241016233044.240699-1-afd@ti.com>
 <20241016233044.240699-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016233044.240699-2-afd@ti.com>

On Wed, Oct 16, 2024 at 06:30:40PM -0500, Andrew Davis wrote:
> Add a pattern property for pcie-ctrl which can be part of this controller.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/soc/ti/ti,j721e-system-controller.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> index 378e9cc5fac2a..2a64fc61d1262 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> @@ -68,6 +68,11 @@ patternProperties:
>      description:
>        The node corresponding to SoC chip identification.
>  
> +  "^pcie-ctrl@[0-9a-f]+$":
> +    type: object
> +    description:
> +      This is the PCIe control region.

What goes in this node?

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.39.2
> 

