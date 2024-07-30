Return-Path: <linux-kernel+bounces-268091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DB942042
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463381F23EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F118B477;
	Tue, 30 Jul 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeBW4Ru5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B81482F3;
	Tue, 30 Jul 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366254; cv=none; b=cNxoGHZQUFqf1yeNiodNWUqzDB6kG8CpyZbcw5/S6t9D0XTYi3x/bGWNXEx35weG0deFFU7Obo1niC0k0a+1oy8tuzcA4E3HAwekhQuIZ/wejzJfGk4zV2bP085tTI7f+4DNriU5XrPkVjiJ2xJzc9TB1UIOVkuHMoq/fBinOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366254; c=relaxed/simple;
	bh=cTWmMAUEkIPPemcVLdlPwFZzIQEyuOsAsucTyaJ5yFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3gtlCRfQHXxdGRCNTFGXNB4WbBmaupex25sFzy9rJ9ORBiJgIRsaIlBZkHz6M+eifvoZR8HljIQqxUZWPT63xMR2b4e2O2htWnMOSt7YBsFoG026O/NsAlDy4BLXtrWBwuixaG6OyT+xuC+s2pwR/efkSE0cv2zzT1Zm+6vBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeBW4Ru5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B60C32782;
	Tue, 30 Jul 2024 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722366254;
	bh=cTWmMAUEkIPPemcVLdlPwFZzIQEyuOsAsucTyaJ5yFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeBW4Ru50UYOOqTL7WlprfqG8VDTllAtwJ54Z4vvZOIpBiemM5I6Ze4bao/HevlbQ
	 BCV8i45OGN5epLqMkoOXOX0/B18MAXA/UXAZh+HwH+tCVMWWYu5YkCyunQaa9j9grt
	 QhemmT0HxCO85acGaCv2fhG9soFfDilLwQaqMs2/3sUTmwdHR6SmDjOyg/n+CaKmzc
	 //v0LB4Qlq5xlbhsGdbX/1Vc9HNgSViShGCcxA+5lNEsukQF+MrS0cJAEf6Ib+RtyS
	 bmumVhVkrzHIRhIX7CD5OKBBBa1WBrdTSpa+fOTSq+MTh87x8JPwyH4QH4I3M094kO
	 qTYHUkFARlTmw==
Date: Tue, 30 Jul 2024 13:04:12 -0600
From: Rob Herring <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: conor@kernel.org, krzk+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/27] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x7 compatible
Message-ID: <20240730190412.GA1513088-robh@kernel.org>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070649.1990427-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729070649.1990427-1-varshini.rajendran@microchip.com>

On Mon, Jul 29, 2024 at 12:36:49PM +0530, Varshini Rajendran wrote:
> Add support for sam9x7 device compatible.

How is this device similar to sama5d2? IOW, why is the fallback 
appropriate?

> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v6:
> 
> - New patch in v6 to document tcb compatible.
> ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index a46411149571..2c7275c4503b 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -15,13 +15,19 @@ description: |
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - atmel,at91rm9200-tcb
> -          - atmel,at91sam9x5-tcb
> -          - atmel,sama5d2-tcb
> -      - const: simple-mfd
> -      - const: syscon
> +    oneOf:
> +      - items:
> +          - enum:
> +              - atmel,at91rm9200-tcb
> +              - atmel,at91sam9x5-tcb
> +              - atmel,sama5d2-tcb
> +          - const: simple-mfd
> +          - const: syscon
> +      - items:
> +          - const: microchip,sam9x7-tcb
> +          - const: atmel,sama5d2-tcb
> +          - const: simple-mfd
> +          - const: syscon
>  
>    reg:
>      maxItems: 1
> -- 
> 2.25.1
> 

