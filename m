Return-Path: <linux-kernel+bounces-219126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523590CA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A67328F2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C77158A17;
	Tue, 18 Jun 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLE+3EmF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2072E64C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709249; cv=none; b=YGT2+w5BV26qX2Pla4KDaZFy7+sMRZ8Mi/FNga46Pq7PfdqjaxMaUwPVhc8EaXzB+nVNcm0vXacMa7TnNHZsf7b9dmOgxaff1sTEml42AJXq42Jtp9A/fn4UBh0ks/SUZt8OzNcnUqZH68VYR4Z9jRWLPPbV0YnZIel7VlgBNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709249; c=relaxed/simple;
	bh=gsoN9bsY0Ylo+lc1Cq9XA37iwfd1xzM6Aee7rnvKp+o=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=jmPFNt/5lA+W6IHZjyxWcBxML7sVZj3ksNhEuQlb7SRyv1ivQ3BizrchIowdH7GMSq7YpiJhHLiALaoscUfLhh/iBjbN6vwcvUKpA+qnBQp30hj/xB3VhQAGqbZ7O/OSpqy9apz50rvKKWiSTW0w7SAg7rrm4BaN09gAr22ZsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLE+3EmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718F8C3277B;
	Tue, 18 Jun 2024 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718709248;
	bh=gsoN9bsY0Ylo+lc1Cq9XA37iwfd1xzM6Aee7rnvKp+o=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=SLE+3EmFyZIadEXuElCV2DEid0uH63iaCN1BJp6a7K+KfFvX93YdSUyQRGRh0zx4V
	 7TMQYGW2BQqf0qyeEnh+GFmPuoPM1FU62obH73qTMia1l586tTT/yl0oKGchmESrN2
	 7FmMRngDDMzDxp66Qd9/r5hqCGFlgBuCNeWSXGxXVryko3pFOLY4sjbEPOXGqIXvNo
	 +umleYT+raE9mRu6RRTxcICvTOSOlDTXRJLM2Eey1sNbAM/u5iV3rwg31A+a5vqzTF
	 saohvY1NvMiP/onUxUJagWJNbFS/xC4GWOIGoAKKit1Jb+JiBOa6Y8B5BCQ2uenFFa
	 a/ZI8A5pN4D7g==
Content-Type: multipart/signed;
 boundary=15a9403428c9151ae6f526bf0d43cad5e1d85be656b58492aa9773431918;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 18 Jun 2024 13:14:03 +0200
Message-Id: <D233KUGR81P5.1BJ8JSACE7C6A@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: winbond: fix w25q128 regression
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "e9hack" <e9hack@gmail.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240610074809.2180535-1-mwalle@kernel.org>
 <76f8be4e-3050-4ae6-93b4-9524a0689022@linaro.org>
In-Reply-To: <76f8be4e-3050-4ae6-93b4-9524a0689022@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--15a9403428c9151ae6f526bf0d43cad5e1d85be656b58492aa9773431918
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tudor,

On Tue Jun 18, 2024 at 12:33 PM CEST, Tudor Ambarus wrote:
> On 6/10/24 8:48 AM, Michael Walle wrote:
> > Commit 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
>
> That commit did:
> -       { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
> -               NO_SFDP_FLAGS(SECT_4K) },
> +       { "w25q128", INFO(0xef4018, 0, 0, 0)
> +               PARSE_SFDP
> +               FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>
> > removed the flags for non-SFDP devices. It was assumed that it wasn't i=
n
> > use anymore. This turned out to be wrong. Add the no_sfdp_flags as
> > well as the size again.
> >=20
> > Reported-by: e9hack <e9hack@gmail.com>
> > Fixes: 83e824a4a595 ("mtd: spi-nor: Correct flags for Winbond w25q128")
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > Hartmut, Linus, could you please test it on your boards? Also, do
> > you have a real name we should put in the Reported-by tag?
> >=20
> > This will also need a manual backport to the stable kernels due to
> > the new syntax. But that should be straight forward.
> > ---
> >  drivers/mtd/spi-nor/winbond.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbon=
d.c
> > index ca67bf2c46c3..6b6dec6f8faf 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -105,7 +105,9 @@ static const struct flash_info winbond_nor_parts[] =
=3D {
> >  	}, {
> >  		.id =3D SNOR_ID(0xef, 0x40, 0x18),
> >  		.name =3D "w25q128",
> > +		.size =3D SZ_16M,
> >  		.flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> > +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>
> and here you add dual and quad to trigger SFDP parsing I guess. All fine
> if the old flash supports dual and quad read. But please update the
> commit message describing the intention. With that ACK. Would be good to
> have this merged soon.

Right. It's not because it will trigger the SFDP parsing, but
because that what was tested by Esben. We're lucky that this will
trigger the SFDP parsing ;) I'll explain that in more detail and add
a Link: to the bug report mail.

-michael

>
> >  	}, {
> >  		.id =3D SNOR_ID(0xef, 0x40, 0x19),
> >  		.name =3D "w25q256",


--15a9403428c9151ae6f526bf0d43cad5e1d85be656b58492aa9773431918
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZnFr/BIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hiLAGAg+Khd4RBojemy8adXmvaISa79v2rcf5r
+KI0MNrT8r1TlCYHMwpebvKmTBFAZxS4AX9qoV2l2Cy7D882vKVYJTT58IsH8QtG
jujq6cZWjdcC8gSPaEhSiDBLrl08GY/KRI4=
=UUef
-----END PGP SIGNATURE-----

--15a9403428c9151ae6f526bf0d43cad5e1d85be656b58492aa9773431918--

