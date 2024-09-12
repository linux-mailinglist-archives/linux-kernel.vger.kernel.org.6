Return-Path: <linux-kernel+bounces-327017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F50976FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398D31C23A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94561BF80E;
	Thu, 12 Sep 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un8Pm1yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6B450FA;
	Thu, 12 Sep 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163868; cv=none; b=GYWMj8EiCrn/9mre1T3bCDuRPNjcpm7Vq5DQKPwC1sWELuuiuUBdXod99Cjxqc9bFBymP+7gFPlVQdPrn3pZnI5PgyTPhPEAk79EW8sTgCZNmJ2SiQQ4efyRDax31xNLxYgoaLrO7Yj6Px+y3N2atpNMpvm6FtHJyxT6uOSuYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163868; c=relaxed/simple;
	bh=BwrRcSsqz0YiXi3pcxgbCGIoms2B7OsuEhfuqSvJd3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1RBxKstN4yYs8p9t8pIAdZquJVI+WpnbZXnQYpybWJKAGdO6SjEkyHlD5hYdCy8xXj0q03UKkvu2c3jB0PoRme55Nz4GD9GL5+vA4Yv7KzHKF43eo4TK64SRXnOUNS8HBPqVBQ724TngCeqgtm/zo5qAAXjTUuoWQvCuphvEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un8Pm1yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A690C4CEC3;
	Thu, 12 Sep 2024 17:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726163867;
	bh=BwrRcSsqz0YiXi3pcxgbCGIoms2B7OsuEhfuqSvJd3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un8Pm1ykLG/zlWnKpzf3WUnA9/F4MoN9k8B6+gD8Y/niCzTJ51w7h068GLRd96Ytj
	 v4Y07HPIxghbaVwmlld8orX/855C67S6ok0cLBY3zS68tJBmT0xz5wYxe6Ea8j7FEy
	 9RiMwzkLpGIqu+Lt9Qf4MPIPlCfvLJKZTAJYN/dXhSEVKzjWnKAgYCPFZN6UbL0LM5
	 YCojuH3H8V8DQ9XhxnF52PKUOI13130KDFFoj60TYcSnIGp/w/gdLdRfalbQz3s984
	 9tRdxJC58uNtI/tDnQwsm0sZJUqapWkFgN8w5Wywvgy59HcoU/Jd/P61uuIHUpXcVZ
	 BdfgRbaTFcTgg==
Date: Thu, 12 Sep 2024 18:57:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: Document the btt3 i.MX28 based
 board
Message-ID: <20240912-hardcore-swagger-0d18494c5d56@spud>
References: <20240912124825.2528984-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I2AMAVctH7rGhPJI"
Content-Disposition: inline
In-Reply-To: <20240912124825.2528984-1-lukma@denx.de>


--I2AMAVctH7rGhPJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 02:48:24PM +0200, Lukasz Majewski wrote:
> The imx287 based btt3 board is very similar to xea in terms of used SOM
> module.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 80747d79418a..f290c824a91b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -97,6 +97,7 @@ properties:
>                - i2se,duckbill
>                - i2se,duckbill-2
>                - karo,tx28                 # Ka-Ro electronics TX28 module
> +              - lwn,imx28-btt3
>                - lwn,imx28-xea
>                - msr,m28cu3                # M28 SoM with custom base boa=
rd
>                - schulercontrol,imx28-sps1
> --=20
> 2.39.2
>=20

--I2AMAVctH7rGhPJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuMrlwAKCRB4tDGHoIJi
0v1FAQCv6hRSIVryj1EuRuiQPd/4a27nLSPCBuGNv+RnagZJCQD/U+xL9Rq/Cxi5
eHyLmRNdtrKXwOr8mmGevUMwb5VTMgo=
=IutQ
-----END PGP SIGNATURE-----

--I2AMAVctH7rGhPJI--

