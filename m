Return-Path: <linux-kernel+bounces-430786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0669E358E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32E928216A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A5195FEA;
	Wed,  4 Dec 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsbvJXY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754F18C03B;
	Wed,  4 Dec 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301411; cv=none; b=nM2iVyyC80WXIGB7UvozE91I/OuCIxR7gPYlwpA4/dFkyurdOlk8q1efx1DjtSOU77PibfUmKk91Z0GdMLJ2eabQszFhBdJB4LR1uB8BLSpcyn41BHyiPgSr1t1a7YoXxdp3edn1hqLACJGkotcHynIKN1nlCFaF87TQ9LSwGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301411; c=relaxed/simple;
	bh=oRmMsiAGKz2uDprT3RwogdQ1d1T5E1DOL9rZ8RdpDZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPaSq6ohjpofiz6xFTBMFsy2rsD6Exy9XOjnr3iL7Zb7Am9Sj012mBVKhK9k8uTCeV0RDFjOpFti7pc1/tWmU88V4+bOmsusZHOAnmqT/M7qHwdaVYJqh/8mbKH+1o2jb48guiCt2KGkvVEOmSl6KHEBwkR9YYqzUPmNLQrI+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsbvJXY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89127C4CED1;
	Wed,  4 Dec 2024 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733301411;
	bh=oRmMsiAGKz2uDprT3RwogdQ1d1T5E1DOL9rZ8RdpDZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsbvJXY52ZwNbczyGsr+B7Uks+9znmzK6DZMnLc+Zz5y2Fm27kjABnAULGSFvsKA0
	 sE+uyxCvYK0Hr39kW4Howe44SkH3fugb12KCVvOZK1VfsYEZaTzzkooNIvY6Se3i3i
	 5UDfsj+MLSpjvD+pUoJvf1ogzFxtX/Ks8xFlfOcqr0q8fhCyULL2fEBYjkDCB2b9PP
	 hUfpKVjWNc5PbTD4+vfEN4Zomc9U4nz43Nu+yVqbH021GOSGUBqmgcTaO0w7STIPh4
	 wJw7wIX0kxbPpjlYIxOU8Ac5nsfDG7VG8DbAJinmucgSS0Lmd+TjDe/Ledak6XLj9K
	 okzUwJurInRcg==
Date: Wed, 4 Dec 2024 09:36:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: soc: ti: ti,j721e-system-controller:
 Add ICSSG ctrl property
Message-ID: <6b4xyh6wjbwt6l44as53wnj57wrga4xscczzjpnxpewd6epxcs@q5odjtm237ny>
References: <20241203173113.90009-1-afd@ti.com>
 <20241203173113.90009-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203173113.90009-2-afd@ti.com>

On Tue, Dec 03, 2024 at 11:31:11AM -0600, Andrew Davis wrote:
> Add a pattern property for icssg-ctrl which can be part of this controller.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/soc/ti/ti,j721e-system-controller.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> index 378e9cc5fac2a..9ba9cb100ab30 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> @@ -68,6 +68,12 @@ patternProperties:
>      description:
>        The node corresponding to SoC chip identification.
>  
> +  "^icssg-ctrl@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    description:
> +      This is the ICSSG control region.

Drop, regions are not described in DTS.

Best regards,
Krzysztof


