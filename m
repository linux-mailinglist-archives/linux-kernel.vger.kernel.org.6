Return-Path: <linux-kernel+bounces-340792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D59877F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626801F25351
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2315B137;
	Thu, 26 Sep 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhj9tCcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57528158853;
	Thu, 26 Sep 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369815; cv=none; b=lW/ir2KIIEpAz3oS1XSTmSGp5ojFskY8RFJy0lr7p+R7x6EzWiayDHQjuzR5/dAgUbfP+WFoqD6eHQRNe1f1dAHgnmB5Vg17JNTnTkazI9uBKi8t71g3Unmtkryzoqq4Us88oJkGdjsPc64F6oWLM7zjP/HRxYZrI0LRjTy112I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369815; c=relaxed/simple;
	bh=EEXMZ5BTfHmxlTIWPOb6TPeSVlPnjEBarDCP+2U+KJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUt80unfNwnaOwwQVTJkVAor2WUlxs51bcL0red0+4jLeOCxIllfL8cLrI9d+tBK/hI9eBqS5Ikh1+XFzTrfN2kW2CWTNq0B0EVgTKlG4xSOVyj3RCBx66ctPBKo+uCXB0A5fo0zpYNNESpCpUGGQPb7x0gyBjM0xMDy3zJ0CQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhj9tCcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D8C4CEC5;
	Thu, 26 Sep 2024 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727369814;
	bh=EEXMZ5BTfHmxlTIWPOb6TPeSVlPnjEBarDCP+2U+KJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhj9tCcDOwf6jthplt9hPGRxBlFy8SD8TQK90HErECG8QSltwzV4cAEPWidr5TReC
	 P4LhdiBQKdorvD7sftMrTja0iIJvyE0UA7MGjyLKwBUwUPAJoarIPtDgt8gMIQ4wKf
	 HCJoky5shks/rjMOZLjaDBxF0F21CTphHmfuS1qOS4j9+fRRY05cmHuR06rEP7ZwGt
	 hbOnRZqfrg4WKOZCaGJssYYRFJkDZfXG6jxeklv5Z08SWQockqFSGdKi99lfdn19w5
	 VSPhA7dYWWRiQDMe8S3nRqLTf3R6s16wggAwjATGpYTTGZ5n5He7vaNRTwtG3EaW57
	 n55j5m9pQ6Unw==
Date: Thu, 26 Sep 2024 17:56:50 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Wayne Chang <waynec@nvidia.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: cypress,cypd4226: Drop Tegra specific
 GPIO defines
Message-ID: <20240926-anybody-purify-f4befab2be4b@spud>
References: <20240925173449.1906586-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkMV/3HYf1xN56hr"
Content-Disposition: inline
In-Reply-To: <20240925173449.1906586-1-robh@kernel.org>


--kkMV/3HYf1xN56hr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:34:48PM -0500, Rob Herring (Arm) wrote:
> The Tegra GPIO define is a problem for the magic code which extracts
> the examples and fixes up the interrupt provider. This was partially
> worked around by putting #interrupt-cells in the parent. However,
> that's incomplete and causes a warning when dtc "interrupt_provider"
> check is enabled. Just drop the Tegra specific define and simplify
> the example.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Right, there's no need to have a tegra specific thing here at all, its
just an example..
Acked-by: Conor Dooley <conor.dooley@microchip.com>


>  Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml =
b/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
> index 89fc9a434d05..0620d82508c1 100644
> --- a/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
> +++ b/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
> @@ -61,18 +61,15 @@ additionalProperties: false
> =20
>  examples:
>    - |
> -    #include <dt-bindings/gpio/tegra194-gpio.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      i2c {
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
> -      #interrupt-cells =3D <2>;
> =20
>        typec@8 {
>          compatible =3D "cypress,cypd4226";
>          reg =3D <0x08>;
> -        interrupt-parent =3D <&gpio_aon>;
> -        interrupts =3D <TEGRA194_AON_GPIO(BB, 2) IRQ_TYPE_LEVEL_LOW>;
> +        interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
>          firmware-name =3D "nvidia,jetson-agx-xavier";
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> --=20
> 2.45.2
>=20

--kkMV/3HYf1xN56hr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWSUgAKCRB4tDGHoIJi
0k5qAP4iz34mSweP66n+p3/FePwauGkQ0mhw8qmxVpY3UNyJ4gD/XzzJf0H5yNaY
IENON2ztQeIib7y4j1NZ3mWF4QWIjQs=
=zFVI
-----END PGP SIGNATURE-----

--kkMV/3HYf1xN56hr--

