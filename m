Return-Path: <linux-kernel+bounces-510765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02914A321A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ED31645B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCB205AB1;
	Wed, 12 Feb 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="U8SEPOdi"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3921E7C07;
	Wed, 12 Feb 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350843; cv=none; b=deGjRBvp8KhmBIsqqsI7ngbRuT6G02cRD16kTGYTfqF1p87NJCilrqvqTMcCfbIYJXos2dBRrgV8B2gDtgQmZnDXbACvsLGYDnkf4/pgvIbxGx22D3XKxSdrBi3XPK72b5H8vjvvgxmMik6oYPmZB4BGOqVFh4YlutyCzFvhGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350843; c=relaxed/simple;
	bh=fYb509GJX4mJmBQ9q+7TCra5wgHfB7rENTA6mGtENMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXhWHWMaDjqRsmNdK1XAv0jpxHyj5wmryPLwPPq0Un7X0AammMxg9FHWgYjgAwGWYqwxmkyWOTlmnNg5Ty+ckSDtCe7Xp4P1wWzylo80UQ5YAT8wG17uklsY551tOAWQecCDqlz+WTwebz424Xb5nT90++l/f7Gkxa91XEKyKa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=U8SEPOdi; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3537F103718DE;
	Wed, 12 Feb 2025 09:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739350352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+RLuKCPgbk66xBwKo0bHakN65cbNdQ5/VO/8/oew2w=;
	b=U8SEPOdi01GyjnbRegQ5WMTYC5uwO8C9/23SgBVfiWI7fSIXfi5wqT5MFIR9uP9mKwa/md
	LbpwQPjvP/5N/AyQiSUENllQ6jxifVfo5GWaN/vSEfkq9VF6wiMl+lu6dn8WX3HJHrEuBN
	aMvHEMawFnIJ7Kwq1HUY2NEb5H2dOYjEGQL0pBSI15gjBpjMZUnoAss5hHMpOfjRGKsfU6
	Q51FUIJlcbawZ380T0gWGtKVagBKWQPzaVr8aajuSwCTdJbLzrAA1IjinIWDkRw5geG8W7
	aaYEWFU5SqIzsWhXVyjw1qcHEqvLLkcTGvjJpmoap04vav7sVVBuJb23vtVGUQ==
Date: Wed, 12 Feb 2025 09:52:25 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan
 Wahren <wahrenst@gmx.net>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v11 3/3] ARM: dts: mxs: Add descriptions for imx287
 based btt3-[012] devices
Message-ID: <20250212095225.52479de4@wsk>
In-Reply-To: <20250206102732.0b44ba8f@wsk>
References: <20241107085705.490940-1-lukma@denx.de>
	<20241107085705.490940-3-lukma@denx.de>
	<20241119165236.69438f75@wsk>
	<Z1aucR3ueKIxOjSX@dragon>
	<20250206102732.0b44ba8f@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VFMFU2XxV.3onaK0LW06GAk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/VFMFU2XxV.3onaK0LW06GAk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> Hi Shawn,
>=20
> > On Tue, Nov 19, 2024 at 04:52:36PM +0100, Lukasz Majewski wrote: =20
> > > Dear Community,
> > >    =20
> > > > The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are
> > > > to some extend similar to already upstreamed XEA devices, hence
> > > > are using common imx28-lwe.dtsi file.
> > > >=20
> > > > New, imx28-btt3.dtsi has been added to embrace common DTS
> > > > properties for different HW revisions for this device.
> > > >=20
> > > > As a result - changes introduced in imx28-btt3-[012].dts are
> > > > minimal.
> > > >    =20
> > >=20
> > > Are there any more comments / suggestions for this patch set?   =20
> >=20
> > Patch #2 and #3 look good to me.  That said, I'm waiting #1 to be
> > applied first.
> >  =20
>=20
> Patch #1 has just been applied by Rob :-)
>=20
> Could you apply #2 and #3 then?
>=20

Can anybody pull those DTS changes?

Thanks in advance.

> Thanks in advance.
>=20
> > Shawn
> >  =20
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/VFMFU2XxV.3onaK0LW06GAk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmesYUoACgkQAR8vZIA0
zr2XFAf+P9Nhc1UqqZv502pM9by1vXiZIEPVm2lPBXAPQca5fKVy1u/ftLNXfFis
w9dGzKFNVAqNc736vwTqO/X81nA7KhA5y/uR/qwDCMfJfeT0wNZTKqwzsaUelNZ1
JSQJgrZVWgNlARw8ezu9E2URHi1KZk/PZ1+b0gnvRtE1K8HXCKi6zzNQrpvrDjXw
j6AGUunaBXbIcigV9Yr3PQZbjsL53kO0UeVQsksKKnuYgvz20U6hr0KPPIcfOevC
aCLjybN4gIY4FCGa2dh3WUNHq9o4QyQhVyPArgS744F51uS2yLusDUHZgxDZHVc8
eYPW6Yq+TKKFTaNqB3sSnPIbp2/8/Q==
=u75r
-----END PGP SIGNATURE-----

--Sig_/VFMFU2XxV.3onaK0LW06GAk--

