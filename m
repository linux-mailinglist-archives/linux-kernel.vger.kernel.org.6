Return-Path: <linux-kernel+bounces-430785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833899E3598
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34447B30232
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97E1957E9;
	Wed,  4 Dec 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk4LsECm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC0194147;
	Wed,  4 Dec 2024 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301395; cv=none; b=RUOEfDsgWWVEYDAZuvybZNMJROjODMypRJwwDToAgW/fEXBtsThyMuyw3OqErO7ant6gXuK1IIsSXAfpDyVZzqlBg7Iq0n7WM2iiPYd/EbYbRldO544Mk5EUYZjnx/tMR4EbXdqbMJihf5Jo6+oOw90W0jO0y0ZmTWYOZSC7eH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301395; c=relaxed/simple;
	bh=Lzg2IJdgrqJ0bc56IrwRYCpZJmAH3MXcmHZA/SIW1Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpNdkV5GsXfcU0g+0JCFmI2rInp4xlX7+N/TlX3gYu4e1QpTPPdxvwb5pAtADTopVYh1c+JeY+OGOKU+p04r1vNxKgxxWaVXfA0wmZAq1cjgrPRfEN6RAJmtOy7ziP9JgNYcLedMDwmgtAIbA1IpOqnEL0DHUr4koJ8NG2PHVj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk4LsECm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E13C4CED1;
	Wed,  4 Dec 2024 08:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733301394;
	bh=Lzg2IJdgrqJ0bc56IrwRYCpZJmAH3MXcmHZA/SIW1Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kk4LsECmm9KFg5qhkcFAmMs5CnXcU9vNp39v7bWtcoOHKG/AS+oSjr3A++e4rYPXW
	 dl8i/nfmmSH2GBfOslr/Rc79Ecny8TccybhgWs0NftakbkYHKkp/6h6VH/LEQ8t7/V
	 G+x5EDqmaxoS1sR8nLzykf8uYdRDp+34Wu9WgXyh3926zWvJtOjnYKXx9VORgAhDXx
	 uZymS/GzLp6Vtoe3uxrgPkym7VvOVuL3y1fq3dBJUugaC4vsjZNa6Iluc4L2cT7X7v
	 +01a3lbiOMSuDcsbBxAGobjyZFepwHMG3WQtu5B3/hAqZqSdUArVNGHR3BGkX6hmdG
	 RQFVlPubAjlMg==
Date: Wed, 4 Dec 2024 09:36:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: soc: ti: ti,j721e-system-controller:
 Add MAC efuse property
Message-ID: <f34b7uedhfvsebtluy4wca3l7u5rl2iwfmwbsfjjyvqizv3zk3@fsfjn5ezpeke>
References: <20241203173113.90009-1-afd@ti.com>
 <20241203173113.90009-4-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203173113.90009-4-afd@ti.com>

On Tue, Dec 03, 2024 at 11:31:13AM -0600, Andrew Davis wrote:
> Add a pattern property for MAC efuse which can be part of this controller.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/soc/ti/ti,j721e-system-controller.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> index ead0679b30e3f..fbaae3d1bef60 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> @@ -80,6 +80,12 @@ patternProperties:
>      description:
>        This is the PCIe control region.
>  
> +  "^ethernet-mac-syscon@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    description:
> +      This is the Ethernet MAC efuse region.

Actually considering my comment on the previous patch - drop.

Best regards,
Krzysztof


