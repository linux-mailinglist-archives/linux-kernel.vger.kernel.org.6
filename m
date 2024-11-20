Return-Path: <linux-kernel+bounces-416169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B8D9D41B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B18B301DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5271AB523;
	Wed, 20 Nov 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABmdkL8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA308156654;
	Wed, 20 Nov 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124037; cv=none; b=bDsYdvm8lUsAsilLPgyZKDRBRhiEyBolYQRWr2B5w1cPZiDMMYopJ4cwWRpd2K8X+JSkRpjbHhMAxCiTMefMjbYkIkpoAXS9hFFk+cIMUDzJPt7E6sPL23ulTEN7zOPeObRbhrC/DYX+LhfoLjJqkcNL9/X30vkCZkexO3XgI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124037; c=relaxed/simple;
	bh=y+FLFUlPKrzv86POSOSeMvyo1rzeSiaoVDFrDLcyA9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG62HS7XsY5JyD7CUFnXnFgVqe2kJl5Y83iPLitam2BlkiaVn4RE30CH5RwBuEV1aBfXbe4PxfEzPoEjrXlOJlX+halFHT16TSN69RUDK75BCsrLvEJFreF1C+f0LeJv0WSnCk6BB1XuwzNgDmGHfZx7IQD9aCvqpq0uab5bzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABmdkL8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8895FC4CECD;
	Wed, 20 Nov 2024 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732124037;
	bh=y+FLFUlPKrzv86POSOSeMvyo1rzeSiaoVDFrDLcyA9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABmdkL8K7j4FAI71MfhGNBzs0kNQI4kgyYT5hC4XA7IFXRzk70qqn/QCYqgX3AaCk
	 0lY8pNIa5I8MS6FNbflLbbzzVq7jqe2Nky/dhPHfetg/YbaUUqfExgCe6WipCVYg5y
	 IELD7Ma370RFABdxEAj4cZ/96icSHGAEpCYfMs9FYvpcNgkt7DTbODOCnM6Q+GBWkT
	 /SyHSuFj2dPuoafLZo4Q2vx5qHynV6WJIlYG7QykEiRgEGrS7bm9AAJ7nN0kwhBnUG
	 hrYZSsCmuMi7Sf4gDlRK6Pv9zuIbw8HjURNaqR+6pnvoDAqGc7Hp6t9JbTraxD2DFz
	 GvrIaQF5bu+Xg==
Date: Wed, 20 Nov 2024 17:33:53 +0000
From: Conor Dooley <conor@kernel.org>
To: JuenKit Yip <hunterteaegg@126.com>
Cc: conor+dt@kernel.org, linux@roeck-us.net, peteryin.openbmc@gmail.com,
	noahwang.wang@outlook.com, marex@denx.de, lukas@wunner.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: add sensirion,sht3x
Message-ID: <20241120-huntress-rickety-ebea29bb33b8@spud>
References: <20241119092208.74360-1-hunterteaegg@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L5Vq6PG/5+kK3HjJ"
Content-Disposition: inline
In-Reply-To: <20241119092208.74360-1-hunterteaegg@126.com>


--L5Vq6PG/5+kK3HjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 04:22:08AM -0500, JuenKit Yip wrote:
> add sensirion,sht3x as trivial device for devicetree support

This has 2 supplies, an alert pin and a reset. I don't think it is a
trivial device.

>=20
> Signed-off-by: JuenKit Yip <hunterteaegg@126.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 9bf0fb17a05e..be006b21b1ea 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -333,6 +333,8 @@ properties:
>            - sensirion,sgp40
>              # Sensirion low power multi-pixel gas sensor with I2C interf=
ace
>            - sensirion,sgpc3
> +            # Sensirion SHT3x-DIS humidity and temperature sensor with I=
2C interface
> +          - sensirion,sht3x
>              # Sensirion temperature & humidity sensor with I2C interface
>            - sensirion,sht4x
>              # Sensortek 3 axis accelerometer
> --=20
> 2.39.5
>=20

--L5Vq6PG/5+kK3HjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4dgQAKCRB4tDGHoIJi
0mFGAP9apPZhT+9T2RXtgS3djpWNyaKM7SQWquGG9meoH5vqPgD/crV1O9WqRj6y
gM5H3EmmfHD4FvzzfQaQqPwsq3UDpgg=
=MJVY
-----END PGP SIGNATURE-----

--L5Vq6PG/5+kK3HjJ--

