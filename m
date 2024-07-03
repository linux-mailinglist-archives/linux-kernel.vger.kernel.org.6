Return-Path: <linux-kernel+bounces-239768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A009926521
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F64B1F22B98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE1181B9F;
	Wed,  3 Jul 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgNu5Ods"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F38177980;
	Wed,  3 Jul 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021305; cv=none; b=gBC8132tqiISeeVrXaIOujjTGnyqKeGeQ3PD0m9Bkpc4MbjuenprQH1Hsy8ZsplUpcZ/N9Oq/3/aScINzcqnALCwuQf2CHLsas5TEbEAd4G8WYCxp2MTRU2D0eaJYI35vNBjCRaa1Bt3A2BLlTYjMHHNEEkVgE6pC072WlJvLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021305; c=relaxed/simple;
	bh=8QrU4tdc4O7uvfChN9kjeYliOuT7HD1Ihq7NwYTkLgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU57+EzhMWXqzN1yKK2Ro3yblD9NNnpa60qGXK+E2N1+5jNDKVrLnXUgZVee4l4vPxr1RABxFojQy7Couz0pZcMR3A9ANuHsK/1ayKK6hOF2ynJjXaGG5azUoTpDuDzsEKzLsZRqK4n0f8cHR+FI2O2G9kUTcJtHdBJ0xIfrfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgNu5Ods; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FF6C3277B;
	Wed,  3 Jul 2024 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021304;
	bh=8QrU4tdc4O7uvfChN9kjeYliOuT7HD1Ihq7NwYTkLgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgNu5Ods8UbxEF91YLLjBIALaSGfBsSNvI618Ni6ieQ1D6FMGKGQ0p5RS4dDJbQw+
	 Ajko1cFny/AMmMjIA6+JAch+qpxbumjlwe0ZBhtXLiTcd1axsLl4Mo3KaWduapYCdo
	 4CoWXZY8eC9TmqzUFYyOcvUrD1yqJHHcO+K8SuNljob0KGjHwsjlXmeUzi5CYkumjh
	 dbyt1VIrnZbxWU2VQ8Q+jBnEwGCDshea5gpPz/9A9M9rktGKihbQWyJs4jsRAr+sRW
	 wVR3s4dXE0GrBdApANcvUBoxSDEnkhE3X8Do+beocuhKESDMo/DN5Yv6wVYbhJpK2x
	 UkETpB7a23AwQ==
Date: Wed, 3 Jul 2024 16:41:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dharma.b@microchip.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Message-ID: <20240703-dentist-wired-bdb063522ef7@spud>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3P1wqdHr/mHz/9qd"
Content-Disposition: inline
In-Reply-To: <20240703102814.196063-1-varshini.rajendran@microchip.com>


--3P1wqdHr/mHz/9qd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 03:58:14PM +0530, Varshini Rajendran wrote:
> Add the description and conditions to the device tree documentation
> for the property microchip,nr-irqs.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

This needs to be part of patch 14.

> ---
>  .../bindings/interrupt-controller/atmel,aic.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel=
,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,ai=
c.yaml
> index 9c5af9dbcb6e..06e5f92e7d53 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.ya=
ml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.ya=
ml
> @@ -54,6 +54,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: u32 array of external irqs.
> =20
> +  microchip,nr-irqs:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: u32 array of nr_irqs.

This makes no sense, did you just copy from above? Why would the number
of irqs be an array? Why can't you determine this from the compatble?

Thanks,
Conor.

> +
>  allOf:
>    - $ref: /schemas/interrupt-controller.yaml#
>    - if:
> @@ -71,6 +75,14 @@ allOf:
>          atmel,external-irqs:
>            minItems: 1
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,sam9x7-aic
> +    then:
> +      required:
> +        - microchip,nr-irqs
> =20
>  required:
>    - compatible
> --=20
> 2.25.1
>=20

--3P1wqdHr/mHz/9qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVxMwAKCRB4tDGHoIJi
0iH1AQDvRPpGyTjiFj+CE9KXyVN45mw6rl8Nyksg/dpCyi+KFwEApgBkyYjvcBLe
KCkJcrbqbQgiVj5SSv0x2yVBZelIZAs=
=EFzl
-----END PGP SIGNATURE-----

--3P1wqdHr/mHz/9qd--

