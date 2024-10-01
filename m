Return-Path: <linux-kernel+bounces-346243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A13A98C1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37789285731
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147241C9EB8;
	Tue,  1 Oct 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRuIQdjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103633D5;
	Tue,  1 Oct 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796686; cv=none; b=jYo8ZIVR1pOUnwdOLP6SatJcXpwacbQbg8PEIc1+VNum2arc3zTMzO2t82fo5bji+Eced9VZWfBGNbEHrqmJBYHfeaSmVQFepTEEnlHwqq1bi6pUotFG3+7iOw1+lfmJheMV34kS93MfN4GhK3N6OUAjeYxt93Ud0e1rRBsLS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796686; c=relaxed/simple;
	bh=JTjMeNjAdjcmlXBo4g1OYjHb8ddMEYPTWyFl5S+f3Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdovAgaWNo0yjKKK+C6ipQ0FkQ+F6OqyxxXsdKwoSZZkBYqqKyhtXDo7iYlPQgp7VIfU1JARZKmyyrWl3H5NxewYLZiqVVkrUhlF5+9x1jrzOU3gXkcpojZPUL223EPREF3GFcYt7KMhQusdZojTgr6bvBBNBXOX9/C4/DYDl+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRuIQdjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE2C4CEC6;
	Tue,  1 Oct 2024 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727796686;
	bh=JTjMeNjAdjcmlXBo4g1OYjHb8ddMEYPTWyFl5S+f3Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRuIQdjmGzWE9tAgt1bkBn1uYU8vXEtQKjdeuYPoCSsXIw8nZQvKapHO1bDLbXU9g
	 HJ4HEa0SNiMYEKbuKt5G7nvxJUKKFn3e7qub3T/BWvATjy0Nw44YPQVq/9+4S5AsHv
	 A6c/2T3rJWHL6FUXi3//WZUzxa6SDFtwFZxEurBDNXpmfo42MDU1cFLtqy3+l3I7RB
	 7sNE4RGFcllB6TGK3JNFntauk7e/Mkz9wKwPyFxLZIqs/Wt3XRXOYm9iJCwZMyxFBd
	 HZBp4hkvslt6Rzh11p38mDEEZOYEIqK02cQV9+VKKrmCGCQDijC+Egv7lz3N84NPJ3
	 HdGuKClpsDk7Q==
Date: Tue, 1 Oct 2024 16:31:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Alexander Dhal <ada@thorsis.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: microchip: aks-cdu: Add label for LED
 sub nodes
Message-ID: <20241001-sleet-bronchial-867258945373@spud>
References: <20241001152541.91945-1-andrei.simion@microchip.com>
 <20241001152541.91945-5-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pp7amhUoR3YGJ6qY"
Content-Disposition: inline
In-Reply-To: <20241001152541.91945-5-andrei.simion@microchip.com>


--pp7amhUoR3YGJ6qY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 06:25:41PM +0300, Andrei Simion wrote:
> Add the label property here and use the old node name as value to stay
> stable and avoid breaking the userspace applications that depend on those
> paths.
>=20
> Suggested-by: Alexander Dhal <ada@thorsis.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Shouldn't this be squashed with 3/4 so as not to break it in one commit,
only to fix it in another?

> ---
> v1 -> v2:
> - added in v2 by suggestion of Alexander Dhal
> ---
>  arch/arm/boot/dts/microchip/aks-cdu.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/=
microchip/aks-cdu.dts
> index 0c3373ad1723..b65f80e1ef05 100644
> --- a/arch/arm/boot/dts/microchip/aks-cdu.dts
> +++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
> @@ -99,22 +99,26 @@ leds {
>  		compatible =3D "gpio-leds";
> =20
>  		led-red {
> +			label =3D "red";
>  			gpios =3D <&pioC 10 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger =3D "none";
>  		};
> =20
>  		led-green {
> +			label =3D "green";
>  			gpios =3D <&pioA 5 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger =3D "none";
>  			default-state =3D "on";
>  		};
> =20
>  		led-yellow {
> +			label =3D "yellow";
>  			gpios =3D <&pioB 20 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger =3D "none";
>  		};
> =20
>  		led-blue {
> +			label =3D "blue";
>  			gpios =3D <&pioB 21 GPIO_ACTIVE_LOW>;
>  			linux,default-trigger =3D "none";
>  		};
> --=20
> 2.34.1
>=20

--pp7amhUoR3YGJ6qY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwVtwAKCRB4tDGHoIJi
0puLAP9wTZxsWq9bQcikzeyGjPnJ9hykcLmPOcqId6xgxzKIywEAgLxNnEe+o0No
sgVGhPNyUqz+VHFmJwNhgI92IxjAPgs=
=yRwO
-----END PGP SIGNATURE-----

--pp7amhUoR3YGJ6qY--

