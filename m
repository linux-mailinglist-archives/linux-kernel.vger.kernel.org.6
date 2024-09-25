Return-Path: <linux-kernel+bounces-339288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D285A98622E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E07F1C27331
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AF188704;
	Wed, 25 Sep 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxaooV7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A24176FA5;
	Wed, 25 Sep 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276239; cv=none; b=u7ofL/G016ov4beuCEQ1X/w1u3TK0zhTE/P1D6ZPXs/Gk+svnO5/Bw76HxxRZLmId1/qlrgcf6nkFv7H85BH/ywbsdSSMySLeWZE8WA8c//ZmPzLGB5XyksvjLDspgaTDTp18hE74gcmWbscsSEN91eRkWaGxFJNFJd/N7FfkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276239; c=relaxed/simple;
	bh=9SYCC7mLQOM3OuiI7cpij+d1MGpKZ8J9VMN2/6n6G0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX1dGfW/H9mQVAa4x3mVtGm4noVy6SLIW3cSNAcQKLODz2UY1RfBYFZOSIGcfYHyRLyc994f8Ffy5gL8QnwprBNQii5NJvoAaXInMePW4Dy/d55IGY3unPTSEBzqQdALZrzqj5qMAUksJLNU2qpe9plakoNh1mG4xQdIj7jK1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxaooV7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6D8C4CEC3;
	Wed, 25 Sep 2024 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727276239;
	bh=9SYCC7mLQOM3OuiI7cpij+d1MGpKZ8J9VMN2/6n6G0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxaooV7Mtx9r2NdPDWFS18359xSFnLg962Qnpl1y++JiS8j6cHBsCkZGWKjj88jJZ
	 NudCyI0z1d7Tpk+ZX3PBiWH8hfM0A/vWJw7eOfL/NJIcQeaZmbqyS7ICjf1kRHHAjG
	 WjNTKP3pR5Xx5f8DtOm8GUjCRxOYTcmtT6Ojkyj+WCFlME8IEuzeWlYqV74rXT7Huc
	 1x1JWP6kwFyYJ0oYBJ+OUCFciiox1HwNuZJBrZI8HY/HGSyhIWLjAqT6KbvCkITz3v
	 iPjfdLluRfPzIx/GSV0OR0p5zaZdwUimM5T0PyA5AAKPQNFVvHkjkKFiE96SduQLGL
	 SUVFWFaWz4+wA==
Date: Wed, 25 Sep 2024 15:57:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: Document the btt3 i.MX28 based
 board
Message-ID: <20240925-sulk-unsafe-2a175b3ae578@spud>
References: <20240925143129.4081815-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ipq2zLzyU4Jp5GR6"
Content-Disposition: inline
In-Reply-To: <20240925143129.4081815-1-lukma@denx.de>


--Ipq2zLzyU4Jp5GR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 04:31:28PM +0200, Lukasz Majewski wrote:
> The imx287 based btt3 board is very similar to xea in terms of used SOM
> module.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

I already acked this:
https://lore.kernel.org/all/20240912-hardcore-swagger-0d18494c5d56@spud/
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index b39a7e031177..2b5c405d15ef 100644
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

--Ipq2zLzyU4Jp5GR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvQkygAKCRB4tDGHoIJi
0uIsAQDoGp8ddfbMEMpRBAzjVk94DKxaTnXLF0f09XIc+EkDQAD9HKfgv0LRKcCn
dx8tu2FLa8k1fTP4j4rFIl755oMsQAw=
=TUpg
-----END PGP SIGNATURE-----

--Ipq2zLzyU4Jp5GR6--

