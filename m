Return-Path: <linux-kernel+bounces-211402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C34905134
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C388B21ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1B16F0D6;
	Wed, 12 Jun 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW3m6jnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C4146017;
	Wed, 12 Jun 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190952; cv=none; b=TRiTS8C1icnjlR3vmkhnkRuUCgKZ/+KmZSzj2YyfA35u5LFSwe4lno217iyG2/syx0ivxQ8FtNJdOcVoDjXpsL7m4tqEI+rw9O7DdakRX3OM5/kqh/KxmP+1K1rgcFbL2UeOFcLcVsBbT0rjewMxAUfOeoUJpXU3OTEyHf9AJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190952; c=relaxed/simple;
	bh=7d24fUeZ1zP8SH2Q+34h24RjLG4meZy6sShN3SzAN8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB6LhNBMJ1GlD7fHcKAUUC1Ta3a/BBJpdRE5jqV4NytPfi6FUCjFY6GgEggMyoOVw57rBs8Y7SrySZmCg1yOA5OKshfZCWOAGb6FJ3oCJkOepTDt9uYQb6zxEiBGx1swkzFYMHXS5cnpIXaRoVsp2ZyjCR+s3+wWivg26GOmaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW3m6jnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16653C3277B;
	Wed, 12 Jun 2024 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718190952;
	bh=7d24fUeZ1zP8SH2Q+34h24RjLG4meZy6sShN3SzAN8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW3m6jnb3gneinc4H/B0Gtb06vZCOSWj6qjo8a5u9z+DZVcY/GWNQK9eWzO+n6jU8
	 W09bJuoYg7mhVUYy84Sy1mcgWgKHAxdaUu3Xqg5FXCDbDA0HKL4TXBEWp19cETU+oB
	 swfc0FOlTdfZ5m6lPnxXT3btWIFc0ezWpwWSjU/AHyAl2XQCcVvG9EogMZ1PO5GnYP
	 A/qmULkTeXu1I56u1ihWbrHQawI0Pivnoz7IeDiZKCvYwdIvd9lTN5VUO3RSuY212R
	 NkzG9qSXU7QMXz9ILxMGruWywLWAITG4di/SDb7wI4IxFEfPspXSylnGA11cgL12/X
	 cyUr/xA9fw88w==
Date: Wed, 12 Jun 2024 12:15:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: Re : [PATCH v1] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
Message-ID: <20240612-italicize-cultural-a10b8a387520@spud>
References: <20240611015200.40996-1-minda.chen@starfivetech.com>
 <20240611-irk-hypocrite-a53e98e6c394@spud>
 <SHXPR01MB0863CFE4519C0D69E961620CE6C02@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Li8mNAUIEQ/ZV6y1"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0863CFE4519C0D69E961620CE6C02@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>


--Li8mNAUIEQ/ZV6y1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 01:48:55AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > On Tue, Jun 11, 2024 at 09:52:00AM +0800, Minda Chen wrote:
> > > Add PCIe dts configuraion for JH7110 SoC platform.
> > >
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  .../boot/dts/starfive/jh7110-common.dtsi      | 64 ++++++++++++++
> > >  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++=
++
> > >  2 files changed, 150 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > > b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > > index 8ff6ea64f048..1da7379f4e08 100644
> > > --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > > +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > > @@ -294,6 +294,22 @@
> > >  	status =3D "okay";
> > >  };
> > >
> > > +&pcie0 {
> > > +	perst-gpios =3D <&sysgpio 26 GPIO_ACTIVE_LOW>;
> > > +	phys =3D <&pciephy0>;
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&pcie0_pins>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&pcie1 {
> > > +	perst-gpios =3D <&sysgpio 28 GPIO_ACTIVE_LOW>;
> > > +	phys =3D <&pciephy1>;
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&pcie1_pins>;
> > > +	status =3D "okay";
> > > +};
> >=20
> > Do all 3 of the mars, star64 and visionfive 2 have both PCIe ports expo=
sed? I
> > assume if one does, all does, since they're basically identical?
>=20
> Visionfive 2 and milkv mars are all the same. Star64 do NOT enable PCIe0,=
 PCIe1 pins are the same.

This patch adds both PCIe instances for the Star64 though, since that
also includes jh7110-common.dtsi. I think you need to enable these in
the board dts files instead?

--Li8mNAUIEQ/ZV6y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmmDYwAKCRB4tDGHoIJi
0hRRAP9uJQeWEGeh7XescP1RuK/PppGYyYJPTZoCbrDpZU0wCQD/Q+mC+PcqoffH
44ymM0rcydKYlUsr+vX1H3OvOtKdnQU=
=UKtv
-----END PGP SIGNATURE-----

--Li8mNAUIEQ/ZV6y1--

