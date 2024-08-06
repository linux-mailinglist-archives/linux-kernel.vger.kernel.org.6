Return-Path: <linux-kernel+bounces-276525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2359494ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6101C223B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCA38DE1;
	Tue,  6 Aug 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgGZF8v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174A182C5;
	Tue,  6 Aug 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959766; cv=none; b=irxhjSio6O6SRb8r3mae9FoWJ9muBd908fQzWoeT2h7qjwcm3lM7jMgdNNFwOHvW4UTECNmt9HcKByWKsvGXkxxOP7IpkTmDHUpbCRu1uuP0VMLKjRWK21AqyJdh2l5yWUX7jMhLwm3wunV6l9xbbW5wiy7DZ3FrEZXdGzsqnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959766; c=relaxed/simple;
	bh=8rg1qtbaF6u8ML2igTUCabcp6Um29EIlKxqDJ5sQxVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov6eNaBRMs848nyJV4rjXfMmycvkGKlnsNJa1KrB/Utn5UbDEr/trd51c46Bm+uLY6jyiHZfRYq9JzdqbJLdYSaskoKzElnybZSSBExSub4BHwuq/G6Ua9RKEBoxgr2ESAGJn559pIMHfZN+bEOwJKK1U7noeI/hvebWgvJWlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgGZF8v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06290C32786;
	Tue,  6 Aug 2024 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722959765;
	bh=8rg1qtbaF6u8ML2igTUCabcp6Um29EIlKxqDJ5sQxVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgGZF8v7r4FPTlCGDBsOTuCxqSmc6BfuQyih2a3lr9dwrJ/ZVTJHkuSqGiw4jJUNT
	 jm21emfGR0OfwOH8PmnF5PANY9G2xU/NX989pNoVi193VJv5Dhe11b7SGFCorgLpBo
	 kwzO1iBXktMPCt2VX0CpxBeQtyp33OzPd5Kp73K9oxlGXEhqpeD8HhORzKry2ERpf3
	 JuhWfhf7lKMCq5/X9RNUAzlSHwG+C2MViSj9gVFSqo6CK8k2XJA6zmR0CG3W5BHCDg
	 cQpzsX+DnUZXyIixEc51poyr5wXOcaXMMkhjiAIw2BYSjUjZfWNw6WXHQUuhz0YfYM
	 7ka05HO5cv/Ug==
Date: Tue, 6 Aug 2024 16:56:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Jenson Display
Message-ID: <20240806-dispersed-cyclist-c2564e707535@spud>
References: <20240806133352.440922-1-frieder@fris.de>
 <20240806133352.440922-2-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a3qlea3eYiFB4XEV"
Content-Disposition: inline
In-Reply-To: <20240806133352.440922-2-frieder@fris.de>


--a3qlea3eYiFB4XEV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 03:32:59PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Add vendor prefix for manufacturer Jenson Display.

A link to their site etc here would be nice.

>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index a70ce43b3dc03..2b483eb5e364c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -750,6 +750,8 @@ patternProperties:
>      description: Japan Display Inc.
>    "^jedec,.*":
>      description: JEDEC Solid State Technology Association
> +  "^jenson,.*":
> +    description: Jenson Display Co. Ltd.
>    "^jesurun,.*":
>      description: Shenzhen Jesurun Electronics Business Dept.
>    "^jethome,.*":
> --=20
> 2.45.2
>=20

--a3qlea3eYiFB4XEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrJHkAAKCRB4tDGHoIJi
0rgJAP0dL98eJuEZ8jBK1X8p8mo3/jNH6hGVlTGoGEbc1jog8AD/dsiXJ77UtiwY
peWW8jMKS7AjwauhxYsn5zEx6ZOn+AE=
=GopE
-----END PGP SIGNATURE-----

--a3qlea3eYiFB4XEV--

