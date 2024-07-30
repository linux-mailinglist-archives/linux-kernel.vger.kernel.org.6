Return-Path: <linux-kernel+bounces-266867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30D9408E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C392B23A42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39545161939;
	Tue, 30 Jul 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjVTieLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF792114
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322269; cv=none; b=g8hq7R1Meym8QioOBn5jh45E85/x0gNgJx1QRBWDYQ7JutQUyL8J5Ugp6AE/ENwW4AXUWQCUdkq+D8Cr6rQnfBzTjxfNzjV4Dhk421NJuJ8s4i0ktFN4gAgJR2Z8Ks77dTsko3KRCQqZMz4GuHUluCHIPK+gdNUvCl7xa2QaXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322269; c=relaxed/simple;
	bh=1WFcT64RSEjm7Ii66YeE3ETbzhdz0+SBx8kjGGmN/B8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=efyIOx5/xp2zo8y0Pc5oPg/qfk4suWOW6NAH4Nh55SX9anV+EJvMJ7y6v6S4a0rF5Kcc69EfV6nenGRFELabahxfZ8tK9Pj+w5UNaEKbaFqL+ahQiGTsBJ+cdz2l9Yrw6ce0GJ90aeadcnVgQNrRs6XWu6Iivj+94BajsHOqW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjVTieLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093C1C32782;
	Tue, 30 Jul 2024 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722322269;
	bh=1WFcT64RSEjm7Ii66YeE3ETbzhdz0+SBx8kjGGmN/B8=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=WjVTieLVyO13O1v5Q4hSk6J2fGOI1AN8W5V/uK8KClhZlqljIFaZMyM3mfNDejImh
	 AT6nhFEu9viOm0yXMJar0Qes3eeRoFBwMlcIqro81wZvtTG+beiohFmfU48yh+klCj
	 n6oXht/PuZARsL00DBtxCavGidXet1FvyNBO+QDtkadV4mRsGogmM0ZQN1oB3cms/Z
	 kCsjg8DP0165QhGR6qmy6HJglbQv21Z4JlXEeg+gC5Suabz43vhkdpxP8bY1YahQin
	 pp0DBoDoqsIFQ/y070rm0vJlZwNYU4jn9E+HBK6NJfNvvuhP+j8YVm42F9rCpBFybf
	 /9nqvVr3iUvRA==
Content-Type: multipart/signed;
 boundary=8174d0b0f781d51f8f766bb0a557a7d87b11217219900dbe638b81c96dfc;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 30 Jul 2024 08:51:05 +0200
Message-Id: <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Richard Weinberger" <richard@nod.at>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Brian Norris" <computersforpeace@gmail.com>,
 <linux-mtd@lists.infradead.org>
X-Mailer: aerc 0.16.0
References: <20240726185825.142733-1-computersforpeace@gmail.com>
In-Reply-To: <20240726185825.142733-1-computersforpeace@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8174d0b0f781d51f8f766bb0a557a7d87b11217219900dbe638b81c96dfc
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Jul 26, 2024 at 8:58 PM CEST, Brian Norris wrote:
> These flash chips are used on Google / TP-Link / ASUS OnHub devices, and
> OnHub devices are write-protected by default (same as any other
> ChromeOS/Chromebook system). I've referred to datasheets, and tested on
> OnHub devices.

Out of curiosity, there is also a hardware write protect switch
somehow, right? At least that's my understanding how verify boot
works.

>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

This looks good:
Reviewed-by: Michael Walle <mwalle@kernel.org>

But could you have a look whether this flash supports SFDP.
According to the datasheet it looks like it does. In that case,
could you please dump it according to:
https://docs.kernel.org/driver-api/mtd/spi-nor.html

Thanks,
-michael

> ---
>
>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron=
-st.c
> index 3c6499fdb712..e6bab2d00c92 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -436,6 +436,8 @@ static const struct flash_info st_nor_parts[] =3D {
>  		.id =3D SNOR_ID(0x20, 0xbb, 0x17),
>  		.name =3D "n25q064a",
>  		.size =3D SZ_8M,
> +		.flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +			 SPI_NOR_BP3_SR_BIT6,
>  		.no_sfdp_flags =3D SECT_4K | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id =3D SNOR_ID(0x20, 0xbb, 0x18),


--8174d0b0f781d51f8f766bb0a557a7d87b11217219900dbe638b81c96dfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqiNWRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hyeQGA4/ZtgLhE6bvlVn3L9QYDW7xKRuKnWIUf
ciNmd6WMnsUZHW7N5UtlkVI30mL3AD7lAX4/eY/6fSnexk/cBYIkWEAf0NL69/gJ
z6MjfMTf+WD7OhTC6Ck2VyDgELNG+MRyHag=
=S/s3
-----END PGP SIGNATURE-----

--8174d0b0f781d51f8f766bb0a557a7d87b11217219900dbe638b81c96dfc--

