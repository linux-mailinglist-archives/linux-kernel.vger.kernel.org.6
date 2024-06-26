Return-Path: <linux-kernel+bounces-230837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904DA91828A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AED91F211E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D0181BA3;
	Wed, 26 Jun 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq69pMEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E1178362
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408870; cv=none; b=Wyh2WqDFRKE9iGZ8s2Ml41Gdx4U7x0oclI6hIYCRQgHntEyozG//PEj1b0Q95tN8ztr2fZEkHUBkC07p6VJxfFsRMJWgEJdJzgi5wsxZZFLKWTS2YrWUrluMSpiI5e3xePOaHSNjHjQQig72Z7rP+8+y9clEccfBYWXEoj7+uwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408870; c=relaxed/simple;
	bh=E3IselMobiJI8seDX3QY8p1hoY3Ox5xAWjz1e1BwllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHoxgGlDHh0Q82AqrXPFiy2bAbxpfZs/F3UGIZOkpPeTz1Y4qyeynVXmxE4QSU3bqp8bO2K+yMZJJ9KNs57c57nXsNvP3Zs8GkjFFw9Omez2djn9xmOy+2jXVhrRzmzxP3Wzex6BAwSEMDzHq5Kq4wphrqbS7az+KWAcLKsQFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq69pMEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CB8C2BD10;
	Wed, 26 Jun 2024 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408870;
	bh=E3IselMobiJI8seDX3QY8p1hoY3Ox5xAWjz1e1BwllQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kq69pMEC9RAQYpo0KTNkKG4E3+MFn4h5GPK0DRneFYMcAwSH4TzIc31snnTvPjMdv
	 yqiHD9fAZQyjQqJTYbTxXQ5TwfsXX/UdPvvd6OKIhjd8/VnpHBcYpePGjRSq2CpzMW
	 6ftyV7HqFJ0RPwUwGViTVNiXbklEIX0IbC4t8wUD/iK1mX72G1WH5an4pwYMaeHr3I
	 DSSbvUWyMhFdHIdQ7/TtrzJetq5OS+NiFepFc05HDhGm7sfPjVitdO6Ei0E0jCBQ1s
	 sS299RtRQ2hnVHEFnKoaH8UIWC8TY1m1yt8EfDo7xvw9rzwOQ8ZURxadhLkjBGbonv
	 yVgyaKxeMZYkw==
Date: Wed, 26 Jun 2024 15:34:27 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MAINTAINERS: drm: vc4: Add Raspberry Pi as
 maintainers
Message-ID: <20240626-dynamic-certain-barnacle-cffc84@houat>
References: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="difu4vxpq2uxo35u"
Content-Disposition: inline
In-Reply-To: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>


--difu4vxpq2uxo35u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 02:19:25PM GMT, Dave Stevenson wrote:
> Add myself as maintainer for VC4 alongside Maxime, and
> our internal review list as reviewer.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

I just applied both patches. Congrats :)

Do you have a drm-misc account already?

Maxime

--difu4vxpq2uxo35u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnwY4wAKCRDj7w1vZxhR
xfT+AP9L53kv36EVdIJxvR/7+QNnp/7UFcz62mwmHaSVF/M0yQEAh1qVB6p4zpr7
9lLOi3pGKMI7OlWiOCifOIGYF1cxqA8=
=jXy/
-----END PGP SIGNATURE-----

--difu4vxpq2uxo35u--

