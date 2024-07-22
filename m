Return-Path: <linux-kernel+bounces-259149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4369391E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635E81F22202
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBE16E868;
	Mon, 22 Jul 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcYB0Q7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFC16CD18
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662592; cv=none; b=gzB3FaqValNTXvY4iLv2Kv0F273Sw72PwTksWdkJ9Ngq8Awl61/uw9fkVr0NCm2wmwMUOv4nOEpFLclY/ejK9tTorVuxD49ZNxfWZ3a3lO8Wk3uC9U739qV9WwLA7v3JllKnu3MiDQ20oz405hbJgyVtWYLiXB8w+Zw4LH3zOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662592; c=relaxed/simple;
	bh=c8XJUKVipzgG6bshh67IQzibzrmFTB9DjTJesJCKQU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MStB3SXg4T8ugcsexdbvOpEzL6s+FFxfspNuAbH5tJD5H89f4a+4/l29uSUT1Uq/bAY9O/bZcg5kZ4Kid2IoG7BTackdnRxsiQuoGaKGu90b1vE/42dSfpRDj4Q/klEXlZdsGXbUxmXoz6APl1WxVuEIL1ucw6228cA+ri9ccgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcYB0Q7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57A3C116B1;
	Mon, 22 Jul 2024 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721662591;
	bh=c8XJUKVipzgG6bshh67IQzibzrmFTB9DjTJesJCKQU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcYB0Q7PYhoYQOalscTo9Z2t2Jzzb+QUwxd0+W28AkLJveb5bzS9mhD8o4N9tunBl
	 UR5Qu6N0SVOAcri/6B5XQb70robfoLrcNC35irosf7CH6YhU4ZCe+aUlZNo5d7k2Fg
	 bLCiWqCBUNTtg1+/SkZCCp3pq4D/yNUIMHQ15eQ2DBDVaKa02Rs7FtfUYrwuRQJEvU
	 jALuHmvMbpqFcDTFg8ksKsamLhBzauFLH8oMI9XC5vVO1ueA1BDf+KZMY7DQMJtqYm
	 f2bNUp+zsR5mqMqY8xds1+MaweuvDOtXDbGUm4Vqfl71t+n3zQ9ILWh85oa/7F5DvU
	 XKIEmmQGB/GKg==
Date: Mon, 22 Jul 2024 16:36:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cache: StarFive: Require a 64-bit system
Message-ID: <20240722-audible-stopwatch-d3f45920991c@spud>
References: <20240719163841.19018-1-palmer@rivosinc.com>
 <20240722-banter-balance-ead2d4bae7fd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n6QJBe2aH/xjIHwA"
Content-Disposition: inline
In-Reply-To: <20240722-banter-balance-ead2d4bae7fd@spud>


--n6QJBe2aH/xjIHwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 04:33:27PM +0100, Conor Dooley wrote:
> On Fri, Jul 19, 2024 at 09:38:41AM -0700, Palmer Dabbelt wrote:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > This has a bunch of {read,write}q() calls, so it won't work on 32-bit
> > systems.  I don't think there's any 32-bit StarFive systems, so for now
> > just require 64-bit.
> >=20
> > Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> if you wanna take it - might be worth being explicit about it causing
> build issues for rv32 though.
>=20
> > ---
> >  drivers/cache/Kconfig                   | 1 +
> >  drivers/cache/starfive_starlink_cache.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> > index 94abd8f632a7..db51386c663a 100644
> > --- a/drivers/cache/Kconfig
> > +++ b/drivers/cache/Kconfig
> > @@ -18,6 +18,7 @@ config STARFIVE_STARLINK_CACHE
> >  	bool "StarFive StarLink Cache controller"
> >  	depends on RISCV
> >  	depends on ARCH_STARFIVE
> > +	depends on 64BIT
> >  	select RISCV_DMA_NONCOHERENT
> >  	select RISCV_NONSTANDARD_CACHE_OPS
> >  	help
> > diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/st=
arfive_starlink_cache.c
> > index 24c7d078ca22..8ee9569771f8 100644
> > --- a/drivers/cache/starfive_starlink_cache.c
> > +++ b/drivers/cache/starfive_starlink_cache.c
> > @@ -19,7 +19,7 @@
> >  #define STARLINK_CACHE_FLUSH_CTL			0x10
> >  #define STARLINK_CACHE_ALIGN				0x40
> > =20
> > -#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
> > +#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39ULL, 0)

Actually, Emil pointed out on IRC that this looks wrong. Should probably
be GENMASK_ULL(39, 0), not GENMASK(39ULL, 0)



--n6QJBe2aH/xjIHwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp58fAAKCRB4tDGHoIJi
0rGDAP9YAE/K5up87c62L88UahOr9K6q0vu4D0I6JD+zYMEkAgEA+SctjzzOCIrn
vHJwoYoORNBsXuX8hIG/EqOc9zSfXQ8=
=ZoRM
-----END PGP SIGNATURE-----

--n6QJBe2aH/xjIHwA--

