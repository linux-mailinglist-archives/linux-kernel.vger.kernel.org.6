Return-Path: <linux-kernel+bounces-392131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7979B9013
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616671C22F94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83091991A3;
	Fri,  1 Nov 2024 11:15:15 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B4322B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459715; cv=none; b=uO0YxpjPWr8nTSZKE9pZ2JPaHVDzxclCwzq/8dsfhdxc97Gv81GNLGJSwV2LI24f12iKufnNJ6pM9K6uSLd0J2JQRghAzJXcR/hRHaEmgFwylvfJL1oi78VZGWq0XdfU/OYsFwfwausU7JyKB+RssQbiOA5gWCcHWe9jaPYxRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459715; c=relaxed/simple;
	bh=bVvD0ugsVORG30joOEfg3hZxnBVOG2FKGEfX70rAqSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umVvs9o6UbumVnT8nz2BgToWBDx0f6BfVBN6JbNPOVrQX/xFvF1w0CJjullLC54oGLS5uIQimFSkpVOVgbwLtI+VW8lG7sG78ABWsALucjjXG/Y9AVJrA7yMfzUBjlyaEBxWj7UOW0nShmHgBJf8hB0sj6ECCSLirE/Lt6OEDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 548FB1F0004D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:07:46 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id E3A08A43F3B; Fri,  1 Nov 2024 11:07:43 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id E3B26A43F31;
	Fri,  1 Nov 2024 11:07:42 +0000 (UTC)
Date: Fri, 1 Nov 2024 12:07:41 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <mripard@kernel.org>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] ARM: topology: Allow missing CPU clock-frequency
 device-tree property
Message-ID: <ZyS2fZeIuK2Zuu2l@collins>
References: <20240929181936.644910-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tmqWi9WOi3e6nmMj"
Content-Disposition: inline
In-Reply-To: <20240929181936.644910-1-paulk@sys-base.io>


--tmqWi9WOi3e6nmMj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Le Sun 29 Sep 24, 20:19, Paul Kocialkowski a =C3=A9crit :
> Allow the fallback mechanism to continue by assuming the same nominal
> frequency for all CPU cores, while still benefiting from the static
> coefficient provided by the compatible-driven table entries.
> This is similar to what is done in the common arch topology code when
> it fails to find a clock to get the frequency from.

Any thoughts about this patch?

Thanks!

Paul

> The ranging mechanism (using the middle capacity) is unaffected by
> the use of a unit frequency and still returns values in the requested
> range.
>=20
> Also add a comment to clarify what is going on.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/kernel/topology.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 2336ee2aa44a..0eb743c65166 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -119,13 +119,23 @@ static void __init parse_dt_topology(void)
>  		if (cpu_eff->compatible =3D=3D NULL)
>  			continue;
> =20
> +		/*
> +		 * Use the legacy clock-frequency property (representing the
> +		 * maximum achievable clock frequency) as an efficiency
> +		 * coefficient (divided by 2^20, roughly 1 MHz) to the table
> +		 * value. If no such property is available, use the table value
> +		 * directly and assume all CPUs are running at the same
> +		 * nominal frequency.
> +		 *
> +		 * It is assumed that clock-frequency is either provided for all
> +		 * CPUs or for none of them.
> +		 */
>  		rate =3D of_get_property(cn, "clock-frequency", &len);
> -		if (!rate || len !=3D 4) {
> -			pr_err("%pOF missing clock-frequency property\n", cn);
> -			continue;
> -		}
> -
> -		capacity =3D ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
> +		if (rate && len =3D=3D 4)
> +			capacity =3D ((be32_to_cpup(rate)) >> 20) *
> +				   cpu_eff->efficiency;
> +		else
> +			capacity =3D cpu_eff->efficiency;
> =20
>  		/* Save min capacity of the system */
>  		if (capacity < min_capacity)
> --=20
> 2.46.2
>=20
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--tmqWi9WOi3e6nmMj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmcktn0ACgkQhP3B6o/u
lQx1VQ/+KVHk6g2TKOPsdPZAVMIpU74SpTvzrGBnWrE5sCRETjuZGnMFGooF8Wcy
iQE8MjM7DlkiDfE660ZK+fJMBosGpjrSAfeuQ+Rpe2O4HBhmffqkQr2TwEKvic//
/0sp9rcUL2nNIK47VPY/imYWN4LDTaOiv6vu02GdZTU3wuQNBmDVZV2gBQbDNuir
NFHOBvyNSTvUwog97wGv10xLywbmyH3cZiqhVrAdGEn5mkGdyFbCED8wpF/F/1fW
8ZKF5/sMtCG0faa7NSSCfJwhxo4hqZ0K18wqcqeuHHt2EWHbXJhCwYMnC/l5Twp7
2+kpsNiCpingYuP7quSwu8VEDCKUAOZgXCdaVQAFOP4Dcyi+WYoGP3hTQMQTcwSj
hzw5wdp3+JHrYHGyD5OYgfsQGC0238XHkxjdfrTVfUWmQWedin1Zrnt9pFzyxI0W
KGum0wmajxsUMLlBX5gT5486g7nrcdvgbUkz1LukCkD+Th+uBcrjhXRopzWFtWj2
hJ3tQT3hXZpGe2/1X4+H0gM+FltHIKNecJS1sCxpNsUP19Jap5ob/qxokrtIIWvI
reol1u1fu7wbrSHNyPOJHML4BZ+HZWBLXzoytQB6XtQhW46kwt4VXu6JdlCdt6QG
4Wx37ggz/4E9mh684Chp+Fj2QlAV5ipAzClSpOVkSn5nrHJhKKE=
=Yiek
-----END PGP SIGNATURE-----

--tmqWi9WOi3e6nmMj--

