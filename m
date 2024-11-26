Return-Path: <linux-kernel+bounces-422691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607F9D9D04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47EA162CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5BD299;
	Tue, 26 Nov 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWpGsXB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFD1DDA18;
	Tue, 26 Nov 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643968; cv=none; b=mWGWox7vp7+j1h6+LIAYZyp673gUKoEYPjyrrRcRw7E76CbUWP5uxiwAQtF5CMXguiiIRCg8tLv5NqwmzlDFxGnzbGlk/dRABxSI+jTMxGji1wv4u6R0tFj5IXhVQ1UKo5HjU2ub8Ao9MK4Mcw3i3XauVRPXKxvLJztfu24pdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643968; c=relaxed/simple;
	bh=NM3GF0xN32aTABQBi5Mj0ioGDDh9e9apDg1yImcCgn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFrHe4SOhSV/T7So56SyujQFsTjWHDV0Q3vImQr0LdF42TvUW6NajuYT2gItd4m6Gz8z1NiXCblz8YRRXPUqXWslKXA1VV9I5yM2C0Vg2XlsYGNN5cSxy0EwQVpmYK4TKec0qkYTHmg/i1+CSubVZaPsXn0NlOS3f3140vVD0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWpGsXB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC7AC4CED3;
	Tue, 26 Nov 2024 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643967;
	bh=NM3GF0xN32aTABQBi5Mj0ioGDDh9e9apDg1yImcCgn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWpGsXB6ODZuGGJaNJGPLS9JojBHYCb0M8cziC4ZF0gAs88bnpKU+4wP4sy09NOFM
	 AAvvEUujDVqwt9nrTqwsO4wR9V/FkIEXmwPCRQDiOqncETST7NwW9K3kPctLLmAINu
	 pIChB5+HKrhiWMrCqpYeiVQd5S+w3+VWeD1dAKcioATZUyNTaECUBZOaM4hehcLR8L
	 x4182JuTOpPM78EYpfGK6zUVc82c+PNIxc1pvIpnjDN144OhKuqHF3RsGpL+491ea+
	 PiHw1GUmLK8aJ6ZfB+ytiL6iT9mDs1IXf26TZ0Q6Eiz6wHlEzRWAcSaN9WlL2s+VGc
	 JEjCjWHtNcnzg==
Date: Tue, 26 Nov 2024 17:59:23 +0000
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Henry Bell <dmoo_dv@protonmail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] riscv: dts: starfive: jh7110-pine64-star64:
 enable usb0 host function
Message-ID: <20241126-unbraided-underhand-680b9482a24f@spud>
References: <20241126073836.17208-1-e@freeshell.de>
 <20241126073836.17208-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/78djKjc2HyFsLhU"
Content-Disposition: inline
In-Reply-To: <20241126073836.17208-2-e@freeshell.de>


--/78djKjc2HyFsLhU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil,

On Mon, Nov 25, 2024 at 11:38:17PM -0800, E Shattow wrote:
> Pine64 Star64 set JH7110 on-chip USB host mode and vbus pin assignment
>=20

Looks like the same thing here, so same thing here :)

Thanks,
Conor.

> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch=
/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index fe4a490ecc61..b764d4d92fd9 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -80,7 +80,23 @@ &spi0 {
>  	status =3D "okay";
>  };
> =20
> +&sysgpio {
> +	usb0_pins: usb0-0 {
> +		vbus-pins {
> +			pinmux =3D <GPIOMUX(25,  GPOUT_SYS_USB_DRIVE_VBUS,
> +					       GPOEN_ENABLE,
> +					       GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +	};
> +};
> +
>  &usb0 {
> -	dr_mode =3D "peripheral";
> +	dr_mode =3D "host";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&usb0_pins>;
>  	status =3D "okay";
>  };
> --=20
> 2.45.2
>=20

--/78djKjc2HyFsLhU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0YMewAKCRB4tDGHoIJi
0t66AP9HW0g6caIUNUVKF8Jw63De+iutnLDrv834ASt0W0V3GAEAtxo18pDD1ecG
rfcvf12D+s54jpd8Jz4LCOmqhzdusgs=
=vZzk
-----END PGP SIGNATURE-----

--/78djKjc2HyFsLhU--

