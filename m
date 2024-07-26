Return-Path: <linux-kernel+bounces-263261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78BA93D365
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936031F24A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157D17B503;
	Fri, 26 Jul 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6JWWmqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409D2B9DB;
	Fri, 26 Jul 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997983; cv=none; b=sR0DFBLZ4YaVhphB0fPbziqtU7ph/Z2xnGW9gIZ+XXTyiVr+4ECcLOSzNADdjSDaOiOtm8JJyd8xtTosfB5C/9c3kXorcKHXK6t97QFXLoVXpiJhmjlmMnDhLpqJY5TPHjTBHjROonp8A5iyzeFWJq7W+78AIIsDLnRvkP4zJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997983; c=relaxed/simple;
	bh=W/Q2VBfV6fDJKX1ZqjaPGWunIuWzmZLmn5Xdx9gGl9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZONLmSvsi7qyvaNPOP/uWREWE50+4vAuyS4QfsQ+ltvfKXdG9VqdQalulzUf0UEfnd3miDMWeIjQ9lz5wCPS+Uv4Oq7dYzoORefNoVQvTDrmgVSJAeIQuOd7CdKXdfSj96YRZd44BSR+flFZYPN2cemTvGo3Qz5LjMZWWDAlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6JWWmqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C305C32782;
	Fri, 26 Jul 2024 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721997982;
	bh=W/Q2VBfV6fDJKX1ZqjaPGWunIuWzmZLmn5Xdx9gGl9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6JWWmqNDjQZFjceAzCkRiSONsAsE3Tg7Zf14UcXGzGPLbCuZb/voxqmqhSdNB2KW
	 28Q2deAt/nv7UhAMDxRW/001hCpTvaq8PJa34heqWUrubWI05IFtmi4x88UqaGcFwl
	 Eq6/JOsP9uU82t8+IjX/H7vJVwXFCBZO8hpcvVNu2GnHJEQmLWeCKMBz2m8JKreyWG
	 eO71PArpdCTKob+fuDLNMkhuLoOpHhtytZvXErtCUZWIBzBJ+FVx+0B3yJAHEjAh5H
	 YuAHDcL0eTHWgjeXJsRIPYB8PTeI+0TimyWQeHzGtWOBCAMMnAGR06WXC9vTdr7xBQ
	 izjouJkBN+qhg==
Date: Fri, 26 Jul 2024 13:46:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: remove non-existant spi device
 from jh7110-common.dtsi
Message-ID: <20240726-likewise-satin-81a7a4a3885c@spud>
References: <20240716-majesty-antler-d9bedc7fd0af@wendy>
 <CAJM55Z9FAH-uiNmXDELM0gkYjHue+g8JQgOryxOCv4OXJ9f5EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oZLvSg5CtS81Y1Gm"
Content-Disposition: inline
In-Reply-To: <CAJM55Z9FAH-uiNmXDELM0gkYjHue+g8JQgOryxOCv4OXJ9f5EA@mail.gmail.com>


--oZLvSg5CtS81Y1Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 08:29:39AM -0400, Emil Renner Berthing wrote:
> Conor Dooley wrote:
> > There is no rohm,dh2228fv on any of supported JH7110 boards - in fact
> > the dh2228fv almost certainly does not exist as it is not a valid Rohm
> > part number. Likely a typo by Maxime when adding the device originally,
> > and should have been bh2228fv, but these boards do not have a bh2228fv
> > either! Remove it from jh7110-common.dtsi - pretending to have a device
> > so that the spidev driver will be bound by Linux is not acceptable.
>=20
> This patch is correct, but as you mention the fake device was most likely=
 added
> in order to use spidev from userspace with random devices added on the ex=
posed
> pins. In case someone actually makes use of this wouldn't this be a regre=
ssion?
> What is the right way to support this?

Unfortunately, there's no "right way" that's supported for for this
particular case. If people want to use spidev for their device, they
should either document it in the bindings, add the compatible to the
spidev driver and use an overlay to add the device to the dts or they
can r bind the spidev driver to the device from userspace.

The other thing, which doesn't exist yet, is a connector binding. The
folks are Beagle are currently working on creating a connector binding
for the Mikrobus connector - but that's rather far from complete at the
moment.

Cheers,
Conor.

> > Fixes: 74fb20c8f05d ("riscv: dts: starfive: Add spi node and pins confi=
guration")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > CC: Emil Renner Berthing <kernel@esmil.dk>
> > CC: Conor Dooley <conor@kernel.org>
> > CC: Rob Herring <robh@kernel.org>
> > CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: Albert Ou <aou@eecs.berkeley.edu>
> > CC: William Qiu <william.qiu@starfivetech.com>
> > CC: linux-riscv@lists.infradead.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/ris=
cv/boot/dts/starfive/jh7110-common.dtsi
> > index 8ff6ea64f048..395436ec0f97 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > @@ -346,12 +346,6 @@ &spi0 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&spi0_pins>;
> >  	status =3D "okay";
> > -
> > -	spi_dev0: spi@0 {
> > -		compatible =3D "rohm,dh2228fv";
> > -		reg =3D <0>;
> > -		spi-max-frequency =3D <10000000>;
> > -	};
> >  };
> >
> >  &sysgpio {
> > --
> > 2.43.2
> >

--oZLvSg5CtS81Y1Gm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqOamgAKCRB4tDGHoIJi
0gFPAQDTaqVqm80i5t4bOVDsRiIvq4FlwJU27Ol3l7bXNjFl9QD+NFzwpkuQtaMR
7Td5Zj+cKPezLGcIubKy+fQhQ4oUcAc=
=33EL
-----END PGP SIGNATURE-----

--oZLvSg5CtS81Y1Gm--

