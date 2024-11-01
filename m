Return-Path: <linux-kernel+bounces-392646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67E9B96AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371E0B21EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05541CCED7;
	Fri,  1 Nov 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNugFRiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C751CCB2A;
	Fri,  1 Nov 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482757; cv=none; b=Xs3pArmsVujH3bevrG5LJBosa6vpsiX6ZOav57WBfsug/+GRuoqJd/Se7nueTw7fJ86ZYksJ+0eUpkm4YTfWGjYmk/SzVh4kavceSbqPABkiOeLJu2fLPkrH+lIKZGSwXV/uTzJNrunf2+LNrSXfz8WE6bSjX6OObl0kGRfs8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482757; c=relaxed/simple;
	bh=MjpluMk4z1Rdc7ccRrPusPdZsycZJ1/7Dl1Io0hhDd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFxkJwExmuxsMugytDoj42xXiXfwJn6A88ZDGFTFcRBKTUwI8EW4pxAqvXdc/FZYz5XCAtNsTfky8eHZ7k9VJOKRhk5WXY2WHAvPK1YuHM6G9nOKeu+6B9dFAm7edKAF/kQzrzUr3AFs/ttDvAMw2Z3LpbJnYM+UyavUzbrhTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNugFRiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4ECC4CED2;
	Fri,  1 Nov 2024 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730482756;
	bh=MjpluMk4z1Rdc7ccRrPusPdZsycZJ1/7Dl1Io0hhDd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNugFRiWXU9A1hv0yLrPnNuqZWo/NBrOFcGqfFlDK4gWybtlvZuoCNl+xcrBGUYdP
	 OWJ/PlOntDhgHvzfpTtieKf5A0bMLOFaz/ruk/y/KmzHzo2MgkXQho/c1oYD22G4W1
	 b3iCEs9xsocPs1dZflBHc5ZEQSk14PuA2/drhm1SCS+hKb13/ZHluOX7lACK4B81M9
	 Y9HHvanYUTX6Aa0i91zO6apUgfleVN/5XOtnMPunbeUQrvT0th4DppCBkAs4+WLY3c
	 Bd1KqSp+/JZoJdHn9nD6+Drkxg0iWix+QdpgwBpt3OIPaeveosCxqX+LLdczdp69Mm
	 EYoCxGjcKYtvg==
Date: Fri, 1 Nov 2024 12:39:14 -0500
From: Rob Herring <robh@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/10] dt-bindings: soc: imx-blk-ctrl: add
 'fsl,power-domains-boot-on' property
Message-ID: <20241101173914.GA3786619-robh@kernel.org>
References: <20241028102559.1451383-1-dario.binacchi@amarulasolutions.com>
 <20241028102559.1451383-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028102559.1451383-2-dario.binacchi@amarulasolutions.com>

On Mon, Oct 28, 2024 at 11:25:24AM +0100, Dario Binacchi wrote:
> This property lists the state of the power domains, indicating whether
> they have been left on or off by the bootloader/firmware.
> This information becomes relevant, for example, in the case of supporting
> the simple framebuffer.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  .../bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> index eeec9965b091..00aa0b8d8ea9 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> @@ -56,6 +56,15 @@ properties:
>        - const: csi-aclk
>        - const: csi-pclk
>  
> +  fsl,power-domains-boot-on:
> +    description: |
> +      Provide the on/off (1/0) status of the power domains. It allows
> +      specifying whether one or more power domains have already been
> +      initialized and left powered on by the bootloader.

Sounds like a common problem *if* we wanted to fix it in DT.

Why can't you just read the h/w registers to see which domains are 
powered on? Perhaps because some are on, but you want to turn them off.

Also, for simple-framebuffer, I think you can list the power-domains to 
keep on.

Rob



