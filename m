Return-Path: <linux-kernel+bounces-179130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0933D8C5C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11F91F22E94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAEA181321;
	Tue, 14 May 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+wgz9O0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF643AA3;
	Tue, 14 May 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715717324; cv=none; b=Bhri/g4jZxxn3itvAVNRSy7+x12iraTUgAaheB2RKt72e1QbjbHsqW99+ghTjI4xwjIpELiyArpPa2r+B522HSDkaP0MZwu3Uj9rbZWd/lVyRzCM6Njf/gFxREr2CXaOqPo/bd7K4hwkoz34oQXp/+BiAhCDE0nDBenChaNd+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715717324; c=relaxed/simple;
	bh=D/T7x/GG4sZteF0hVP4VnwbmWL5m6mNjYQaNHV88+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrjwIoWg6hewqmirVY0/JK1zH4F0NMk5drS8ICkdckv+EHljCteFU/3PH9rIH224lXopqPqujXJqDct2qeQxltDAi7Bhx0DJtPypAs4efv2w5UHgxiRa+itD5Is15oYoELMOm6KBC8I6tJMZyO0X1YiyDivs6ceJse7yrja1iRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+wgz9O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97B4C2BD10;
	Tue, 14 May 2024 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715717323;
	bh=D/T7x/GG4sZteF0hVP4VnwbmWL5m6mNjYQaNHV88+8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+wgz9O0/+LJ+UzfkiiqqUlnPDJXJVvsRiJdvQD/k1BmIZ7d9UGuTrP0scGeO7rvg
	 nnmvjBDC7ReKN8pG+weKlpvksHGnpyJPMSK1cpUQfD7sKBE/l4EmVPCHtNt1WhL2PL
	 Cs82IQU8wi7jA+ENznDsDHnHNl0lNEXJxT8R/XZL0GTwsE79YmCD7E9nC65TzM+/yC
	 V0ryknc6CAHXBBf+X+l1JpGgAvLQj0Fq1lb3Lf/loSoGyfGEHRXudON0n4Hrm1gXJH
	 X4V7XLpwSzSH6fXNC8XfnFuLXgD8f15rexDG19YGJgCkBOGiS+sui4ssXhKnN9cKuD
	 AIrsaBhCeoZ2Q==
Date: Tue, 14 May 2024 21:08:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Marek Vasut <marex@denx.de>,
	Alexandre TORGUE <alexandre.torgue@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Pascal Paillet <p.paillet@foss.st.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
Message-ID: <20240514-entryway-idealize-fcd5ed0e1de7@spud>
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
 <20240513-stabilize-proofread-81f0f9ee38b9@spud>
 <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v5WMLClVVf+t+TTk"
Content-Disposition: inline
In-Reply-To: <d73d4435-75d6-4cea-b38e-07c7ceae3980@foss.st.com>


--v5WMLClVVf+t+TTk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 08:02:21PM +0200, Patrick DELAUNAY wrote:
> Hi,
>=20
> On 5/13/24 17:16, Conor Dooley wrote:
> > On Mon, May 13, 2024 at 04:34:20PM +0200, Marek Vasut wrote:
> > > On 5/13/24 11:56 AM, Patrick Delaunay wrote:
> > > > Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
> > > >=20
> > > > Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > > ---
> > > >=20
> > > > Changes in v3:
> > > > - Replace oneOf/const by enum; solve the V2 issues for dt_binding_c=
heck
> > > >=20
> > > > Changes in v2:
> > > > - update for Rob review, only add compatible for STM32MP13 family
> > > >=20
> > > >    .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | =
4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp=
1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pw=
r-reg.yaml
> > > > index c9586d277f41..c766f0a15a31 100644
> > > > --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-r=
eg.yaml
> > > > +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-r=
eg.yaml
> > > > @@ -11,7 +11,9 @@ maintainers:
> > > >    properties:
> > > >      compatible:
> > > > -    const: st,stm32mp1,pwr-reg
> > > > +    enum:
> > > > +      - st,stm32mp1,pwr-reg
> > > > +      - st,stm32mp13-pwr-reg
> > > Should the st,stm32mp1,pwr-reg be treated as fallback compatible for
> > > st,stm32mp13-pwr-reg or not ?
> > >=20
> > > In other words, should the DT contain:
> > > compatible =3D "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg";
> > > or
> > > compatible =3D "st,stm32mp13-pwr-reg";
> > > ? Which one is preferable ?
> > >=20
> > > I think the former one, since the MP13 PWR block could also be operat=
ed by
> > > older MP1(5) PWR block driver(s) without any adverse effects, except =
the SD
> > > IO domain configuration won't be available, right ?
> > Aye, the fallback sounds like what should be being used here, especially
> > if another user of the DT might not need to implement the extra domain.
>=20
>=20
> Yes it is the the only difference but I think that type of fallback is no
> more recommended for different device and
>=20
> the PWR device on STM32MP13 and on STM32MP15 are different.
>=20
>=20
> The other user of the non-secure device tree don't use the yet the PWR
> driver for STM32MP13,
>=20
> so for me the fallback is not needed for non secure world (Linux/U-Boot).
>=20
>=20
> So I prefer to introduce a new compatible in Linux kernel before the
> STM32MP13 PWR node is really used=A0 to avoid ABI break in futur.

How is it going to break an ABI? If the mp13 implements a functional
subset of what the mp1 does, then that's what fallback compatibles
are intended for. Marek's mail suggests that this is the case, and
therefore a fallback should be used.

If code written for the mp1 would not work on the mp13, then a fallback
should not be used.

Neither I nor Marek are saying that a new compatible should not be
created, in case you misunderstood that. This only affects the binding
patch, and your driver etc are free to use the mp13 compatible.

Thanks,
Conor.

--v5WMLClVVf+t+TTk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkPExgAKCRB4tDGHoIJi
0lZxAPwIDe/A/kGb5gcwIj8lI3dHHZQdauZu9LR30h2gq4Wi1gD+Loqv0IXxNvGo
Kbchr2W1JHnBZNmnJCbCA/PPPTAfWAs=
=vWSp
-----END PGP SIGNATURE-----

--v5WMLClVVf+t+TTk--

