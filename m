Return-Path: <linux-kernel+bounces-283298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B6294EFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A085B1F22BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B9183CBA;
	Mon, 12 Aug 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnEIIjLH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828514C5A4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473376; cv=none; b=Yjr0J8bIDLiPY85IDTdYkaB5S1dmogQne9OhXpQgFkO0W54greGQVa1xHDTviZsQpc2IHSdCvP5sODa2ooZxh+v2jBYMlsZ5Ov2rwt/rVcxeG654fT0Df82rCJpZ1g0WTJVoCSMcjWfoUk4ngKhl84R3j3CF6F9MxsBrwMY+YHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473376; c=relaxed/simple;
	bh=lU+Uhh+y+aAM6ENiDfkeg8F/8dKDJUSDm5cZcLbNfgA=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=gco1IRN/g0W8EC81cpa82PHISKcyujGlg51QhcUaGxXSCx1xFpzW9URMlJbrjf3+2A2lbImoaSjhHZu1OZDs8d4mWhKjnFvag0iwHpucHCCKQ000tfyqcPtVM2EExeDI6pbFlx9CnEamk50kFINcuX1L3eWVdVzVd+zyO/JKA8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnEIIjLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C706C4AF09;
	Mon, 12 Aug 2024 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723473375;
	bh=lU+Uhh+y+aAM6ENiDfkeg8F/8dKDJUSDm5cZcLbNfgA=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=PnEIIjLH++sDNBhaLdXNEy+Gqef6G6P6ciwi133jAfdOPaFjfbOkdw1X10bN8KBeH
	 mbwjemJxGwrkoda7oh/Ltk82isxmHLc8N6mV9jmpg/hqDI1JICw2rS25MaDQ72yKDu
	 AgSgUDGJ4oezxUk6IPxU99hvzCbN6hbxRiHiUqrrTL3Mx7QsUmD1r75Ri9t/8DnFgt
	 rJDyp1bQ8pSLFYRgxKg1fzYkd3AGMCouWlt83Mg8l0Y0knEWq2YmGTtPz5IJT+KTtI
	 uNe6JHc9GzKngrTmQLPoxivoMpWPp/0MNmygWv4CcOrZmrmZwb8ae/F2F+eEt/y5f2
	 y1tUshVzYLEVg==
Content-Type: multipart/signed;
 boundary=936a0167f95709de7bcfad0449549450e6c28ada1f5126b8ad66eda4afb2;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 12 Aug 2024 16:36:11 +0200
Message-Id: <D3E0BKGQIZ9R.1ULZZ93E18VGM@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: winbond: add Zetta ZD25Q128C support
X-Mailer: aerc 0.16.0
References: <20240804221535.291923-1-mwalle@kernel.org>
 <mafs0v805zwlv.fsf@kernel.org>
In-Reply-To: <mafs0v805zwlv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--936a0167f95709de7bcfad0449549450e6c28ada1f5126b8ad66eda4afb2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > Zetta normally uses BAh as its vendor ID. But for the ZD25Q128C they
> > took the one from Winbond and messed up the size parameters in SFDP.
> > Most functions seem compatible with the W25Q128, we just have to fix up
> > the size.
> >
> > Link: http://www.zettadevice.com/upload/file/20150821/DS_Zetta_25Q128_R=
evA.pdf
> > Link: https://www.lcsc.com/datasheet/lcsc_datasheet_2312081757_Zetta-ZD=
25Q128CSIGT_C19626875.pdf
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> [...]
> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbon=
d.c
> > index e065e4fd42a3..9f7ce5763e71 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -17,6 +17,31 @@
> >  		   SPI_MEM_OP_NO_DUMMY,					\
> >  		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
> > =20
> > +static int
> > +w25q128_post_bfpt_fixups(struct spi_nor *nor,
> > +			 const struct sfdp_parameter_header *bfpt_header,
> > +			 const struct sfdp_bfpt *bfpt)
> > +{
> > +	/*
> > +	 * Zetta ZD25Q128C is a clone of the Winbond device. But the encoded
> > +	 * size is really wrong. It seems that they confused Mbit with MiB.
> > +	 * Thus the flash is discovered as a 2MiB device.
> > +	 */
> > +	if (bfpt_header->major =3D=3D SFDP_JESD216_MAJOR &&
> > +	    bfpt_header->minor =3D=3D SFDP_JESD216_MINOR &&
> > +	    nor->params->size =3D=3D SZ_2M &&
> > +	    nor->params->erase_map.regions[0].size =3D=3D SZ_2M) {
> > +		nor->params->size =3D SZ_16M;
> > +		nor->params->erase_map.regions[0].size =3D SZ_16M;
> > +	}
>
> Since the size is 16 MiB for both Zetta and Winbond, why do you have
> these conditions here? Why not just do it unconditionally? What
> situation do you want to protect against?

Two things, I want to make sure, the values I'll overwrite (which
were set indirectly by the SFDP data I check here) are really the
"before" value I expect them to be. And secondly, I want to
fingerprint the SFDP as accurately as possible. I mean you wouldn't
need the SFDP version either. Think of a preparation for a possible
.match() callback in zetta.c. That would probably look like this,
i.e. check the flash id and these four conditions.

What are your concerns?

-michael

--936a0167f95709de7bcfad0449549450e6c28ada1f5126b8ad66eda4afb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZrod2xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hsRgGA8mJnYuTjf8+k8Eb84oremKVsPySQr0La
pDBEoW6frwYqISVoGFwXcxRqFmYAtelOAX9U9tqvJYLDveZby4CIQhXZpQ9Kx5jb
FVA+zGxanAjfzTIypTnhLdOtEed3TGGNApo=
=V4LY
-----END PGP SIGNATURE-----

--936a0167f95709de7bcfad0449549450e6c28ada1f5126b8ad66eda4afb2--

