Return-Path: <linux-kernel+bounces-376967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FEA9AB82F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA751C24315
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8181A3028;
	Tue, 22 Oct 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fswnKFZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B51C9EB3;
	Tue, 22 Oct 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631151; cv=none; b=LsDyoGLcTmkPzVATHrO+SO2KcIWe2qyglUN13c6zHGPHtw/fD+fJN2ym4usLBawFbYZhODy1kOahLv4k2rF2mDJBnp25qo+0nZ/MjaA/PWCI/dbMjXzzOW5GIH9X9MwpN9azTU0yYg1vfmOx3dsv3FCZV0Nw6yAW0X2CzZFZ+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631151; c=relaxed/simple;
	bh=0lgMKpiUtSa5Y0IO5Fez2IdYcPpznGcnBP4KF/IpUoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXGuYUIfBIfolvHLDxt8Wf4/pLKY4mpvQU8AGFRBI+N3OxF9ibBiKoXlNprG4A+eMc6yJnzlh2SMlDKqTMfSUTAqUXd+njfjpDMc7yLLIsc26NyUC1vAfKx4u66Px3x+tGPbwkolNQdLXgQK57Johxe8r/pHVD27+Cppt2FvA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fswnKFZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21FCC4CEC3;
	Tue, 22 Oct 2024 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729631151;
	bh=0lgMKpiUtSa5Y0IO5Fez2IdYcPpznGcnBP4KF/IpUoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fswnKFZ6A323RzWw0uwM3AzdIwKqAAExj7OYGGoP6WF+SkAzPksk27DJmkmtvp448
	 1O+jMaCn00q+0CLGwMUAcB15U1kt3KJQ+HdWtXa6nZ3KqhhgkEBnzSbA1cLO7HJyuC
	 +xDrCBdsK8fnocscZOsdQJZ8J5y/3SMtblws34qhn1FHbeyOk0PSyMOdV48XYgpCMC
	 gItXcfpc4I+SsdVwngEPfPHC6R86kkzXeiKc6MWO1+HfTuRmjd1NTJ7umIfMhEOvGH
	 UhRPR6OWJIXbl5MKxSkeE7pdxMgRHMBSQOdAoWXKyESJVclJfszi3XTjbxVf9IZ9ZW
	 ha5Dv/dBCH5Zw==
Date: Tue, 22 Oct 2024 22:05:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
Message-ID: <20241022-elongated-chaos-7e47ffcaf073@spud>
References: <20241021173631.299143-1-andreas@kemnade.info>
 <20241021173631.299143-3-andreas@kemnade.info>
 <20241022-refurbish-laborious-e7cc067966dc@spud>
 <20241022194221.43b9073b@akair>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q0tlSaOjefS2/9zM"
Content-Disposition: inline
In-Reply-To: <20241022194221.43b9073b@akair>


--Q0tlSaOjefS2/9zM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 07:42:21PM +0200, Andreas Kemnade wrote:
> Am Tue, 22 Oct 2024 17:59:10 +0100
> schrieb Conor Dooley <conor@kernel.org>:
> > On Mon, Oct 21, 2024 at 07:36:30PM +0200, Andreas Kemnade wrote:
> > > +&i2c2 {
> > > +	/* EPD PMIC SY7636 at 0x62 */ =20
> >=20
> > Could you explain what you're doing here, please?
> >
> I am not sure what you are really after with this question...
> So I am guessing a bit.
> I describe the hardware as good as possible. The sy7636a (apparently
> =3Dsy7636) driver could probably be used here but the driver and its
> bindings needs to be extended to specify an input supply and some gpios.
> So at the moment I could not use a machine-readable way of fully
> describe the stuff here. But I want to put a human-readable mark here
> so if someone extends the driver, he/she might be aware that there are
> some possible users and candidates for a Tested-by here.
> For the JD9930 it is even worse. No driver in kernel. I have a pretty
> dirty one requiring some rounds with the brush before sending it.
> So the mark is good for information what is missing and for teaming up.

Your guess was accurate. Please note in the commit message why you're
doing this, so that it's obvious why you've put comments rather than
device nodes in the file. Thanks for explaining.

--Q0tlSaOjefS2/9zM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxgTqgAKCRB4tDGHoIJi
0q2jAP4+zRsL80+LNEZYvIokZeHMGfj1mDuI5FQ/XwaCRJgPlQEAzV91bKIOFo2f
aPFp9m000zVauZkcI4P5JPPEzgXNxgg=
=V9ek
-----END PGP SIGNATURE-----

--Q0tlSaOjefS2/9zM--

