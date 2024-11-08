Return-Path: <linux-kernel+bounces-401653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32289C1D77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C10283031
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820F1E908A;
	Fri,  8 Nov 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3KoZdsB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206AC1DF739;
	Fri,  8 Nov 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070815; cv=none; b=pdMG/i+Wl0mM4yWWVe07gn3k+sAmmulghw18ggZRKnT5sluXSWuxN1mkblS4/BxzuGx30AQp3+wQwAibhEtj06QdAhzz5wk+Lr5uOVKgOQjKIHHjhXt2hUvX5tPRo7/xrJC9R+6sb0Qhg/jLR34NBFEfuSluBcAYkhec4E7R68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070815; c=relaxed/simple;
	bh=y/Kf87eKmLNLY/Pl6BexjMOvlzrToTbYbyL/whC7b6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPjujfgFlpql1n4tW05aswckF6vz5Cl2/2zhjA5Fna/ZXIuBFKTixmFZvFW1X+40f2+8yqN2PbJuDXVa0PMIlnGbexY2k6DfU73CyxtxInCg0N87wPbrTt820/uBD1KgFY0lx2ovZN042+T4v1gXew2P/zKt5JDermtNHsmXHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3KoZdsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0552C4CECD;
	Fri,  8 Nov 2024 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731070814;
	bh=y/Kf87eKmLNLY/Pl6BexjMOvlzrToTbYbyL/whC7b6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3KoZdsBulurFEoez6qaLgXQZwlCTTNMNzpje46ub1SfZtp1AfXl0dL9fus5yBbke
	 2vjPA20pJ26+2rO1zo1OW70fly3KkvvJ9GXwUKmdIeOaGvEsLIAcPgiHIYSiDTru9u
	 ierzBNhRX1yvLaR45cWPDAEkubsNFRswvVs9DicztzXHaDZJxgox6uBb0jdfgTrJZZ
	 q9cl5g+VnV4PdOfyHFPSLAWNBneX0IoIx4ocni3bxsOrFpyObXNRWms6Q1cnRoxDLH
	 ywYItaMQklSPLPsdUMxybIzq3oixZ2URgsgovNCWIo/c6UrqwxSrHb/AOYLj/IrDVH
	 eTRfLN1bHCY8A==
Date: Fri, 8 Nov 2024 13:00:10 +0000
From: Mark Brown <broonie@kernel.org>
To: John Watts <contact@jookia.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph-card2: Purge absent supplies for
 device tree nodes
Message-ID: <ffeeb9cd-7593-47b2-8fef-ec80cdfcb809@sirena.org.uk>
References: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nHnIxcBMEGVirgC2"
Content-Disposition: inline
In-Reply-To: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
X-Cookie: Do not overtax your powers.


--nHnIxcBMEGVirgC2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 12:37:15PM +1100, John Watts wrote:
> The audio graph card doesn't mark its subnodes such as multi {}, dpcm {}
> and c2c {} as not requiring any suppliers. This causes a hang as Linux
> waits for these phantom suppliers to show up on boot.
> Make it clear these nodes have no suppliers.

Copying in Morimoto-san.

>=20
> Example error message:
> [   15.208558] platform 2034000.i2s: deferred probe pending: platform: wa=
it for supplier /sound/multi
> [   15.208584] platform sound: deferred probe pending: asoc-audio-graph-c=
ard2: parse error
>=20
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  sound/soc/generic/audio-graph-card2.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/au=
dio-graph-card2.c
> index 56f7f946882e831cc4474c86b31f69e15de1549a..68f1da6931af2161dc8815b8c=
04d10cd614cc182 100644
> --- a/sound/soc/generic/audio-graph-card2.c
> +++ b/sound/soc/generic/audio-graph-card2.c
> @@ -270,16 +270,19 @@ static enum graph_type __graph_get_type(struct devi=
ce_node *lnk)
> =20
>  	if (of_node_name_eq(np, GRAPH_NODENAME_MULTI)) {
>  		ret =3D GRAPH_MULTI;
> +		fw_devlink_purge_absent_suppliers(&np->fwnode);
>  		goto out_put;
>  	}
> =20
>  	if (of_node_name_eq(np, GRAPH_NODENAME_DPCM)) {
>  		ret =3D GRAPH_DPCM;
> +		fw_devlink_purge_absent_suppliers(&np->fwnode);
>  		goto out_put;
>  	}
> =20
>  	if (of_node_name_eq(np, GRAPH_NODENAME_C2C)) {
>  		ret =3D GRAPH_C2C;
> +		fw_devlink_purge_absent_suppliers(&np->fwnode);
>  		goto out_put;
>  	}
> =20
>=20
> ---
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
> change-id: 20241108-graph_dt_fix-d1f0db88a696
>=20
> Best regards,
> --=20
> John Watts <contact@jookia.org>
>=20

--nHnIxcBMEGVirgC2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcuC1kACgkQJNaLcl1U
h9DcKwf9EY5TwHTmMcHD+uk+/GHN5AgWcnmwg6lonWAYNVX4R0W8AnXRVS3uYOEv
DoleuIXezl92+1HiKUsroKj72LeG0GwLO+MBoyVQ25n2q4lUmLz1crtAmeeSkscb
qTaZJr1JwvtrGfOpecatE3fgxxq/3uPcC5PdxlRn8ZogYea5j98uSvyqHr3G4dbV
wVXKWXavZ96W06V7w/MjAm9/R465xt8CItLd53eYnT0IUGtE8bMZNIewm/xVVnEm
Io5ZtCSNdgKtEb0JqUY9dksX6gzhObZMSSQ6xIBSiFHtTkj0lLy7IIFfoJRON7i5
XyQQO7M6YAGpj/r9izQSAQ0do4B+fA==
=1KJj
-----END PGP SIGNATURE-----

--nHnIxcBMEGVirgC2--

