Return-Path: <linux-kernel+bounces-266108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E793FB38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BC4283E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FB16D4C3;
	Mon, 29 Jul 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+1c8rKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B9155CB3;
	Mon, 29 Jul 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270263; cv=none; b=iyQvtIb0vGnDOX6Dq9Tz+wWoUjJUKOwqmLRwSheGyv85VGSL7uJ/HrhyCVE/GHeLLHKZf0q9IRYWeQ4TZIzNpVfw2oXTfGoOgig4osN3rI/9hKC9FYAqN0egx9Psk+o/9jnYB39z1FTpH4vDSo1b2iVjBHpMCTxC1DAnYuQPQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270263; c=relaxed/simple;
	bh=l8H2IXNduLjaDFq4uzdv2ABfSwp1JmIL297CIumWoH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b82YJ1StO4sTNF2mZRUkjb0JHu9/plPnr3UZN2Qt9y5CAxHyyEMiMPyDscFSQp7kKWxB00QrT24Gt+opkCTHb0Ocnp8V1rztC3SAkDA5xVGv0qA2xjDRj4FeVoQPnUj3GRFati+c97gT3HcEBgzTl7nntjeQRHQwsTPG9yTTf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+1c8rKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FD1C32786;
	Mon, 29 Jul 2024 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722270263;
	bh=l8H2IXNduLjaDFq4uzdv2ABfSwp1JmIL297CIumWoH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+1c8rKJD+oaqxi/02EDAQuLll17nKIH9QHqxOYX1qCasqal85zLqU4akTuDz+3rO
	 I6m1jhOlerd1GzYGp50LTjIIg0grmhOWBomsAwSz8z3JvTTlrVZ0XtC+MgmpkSFVMl
	 Z93OMHMz21smvszr3lxoiwXAFBOoWLRwJEpD8J7120wa65RsBXZkS7Tbss0WDBfF+e
	 gHpQaIv1ko0x0leR19wL37wXHqqsmxiX4Z9S72e5Qg66lk7uPOkVHcn70LmWMSMxvy
	 79wQME/KN7GraryR8vyDwcGzsEmDHys7v6fpiWZ5Ow5G2AqCrQGQ4RGo92rrWEsGch
	 W7B7EE0hL2kqw==
Date: Mon, 29 Jul 2024 10:24:20 -0600
From: Rob Herring <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: tglx@linutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dharma.b@microchip.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 16/27] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Message-ID: <20240729162420.GA855988-robh@kernel.org>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070818.1991013-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729070818.1991013-1-varshini.rajendran@microchip.com>

On Mon, Jul 29, 2024 at 12:38:18PM +0530, Varshini Rajendran wrote:
> Document the support added for the Advanced interrupt controller(AIC)
> chip in the sam9x7 SoC family.

The diff tells us that. What would be useful is how it's different from 
prior designs. Number of interrupts for example...

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v6:
> 
>  - Changed the compatible list to only sam9x7's. Removed the Acked-by
>    tag as there is functional change in the patch.
> ---
>  .../devicetree/bindings/interrupt-controller/atmel,aic.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> index d4658fe3867c..d671ed884c9e 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> @@ -23,6 +23,7 @@ properties:
>        - atmel,sama5d3-aic
>        - atmel,sama5d4-aic
>        - microchip,sam9x60-aic
> +      - microchip,sam9x7-aic
>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 

