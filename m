Return-Path: <linux-kernel+bounces-259146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774029391E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2065C1F21CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B016E863;
	Mon, 22 Jul 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTd8KjIa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D116CD18
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662412; cv=none; b=VasxEezmS9qRcVZHrIeea38iDs1e1hJPCJmQhACW5k70YYUF+yO4McRpGpgCzEowimVrq3+QDI4w0ZL84TjfylRv/rHV0uJTkDALf//aQMGzLQBSqbCjzxdZ2NMkqpEGxB2MRH+VwLaQXAs+Wh8v6uY7Xc1urDUldRP7tAVCJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662412; c=relaxed/simple;
	bh=15Imh+OFzFlYBfvRORKJOPtZf3LObeq4k/Ll32cYq4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCFQCrVZhawQrOTSYsgUvCg8kZ1WiqrXqU7sZChCsbEwWMvm+EGvxFDkp8v6WR3frT2BuWqb91Zkn9ZJYdNHop7sCrUbC6eXAqtNOSKyoHMZMVTt+AZhU9YqufxeFcbC9gHjvBO6lYOvBWVqqhRinRdJc8LdIquDUbm8xsWanws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTd8KjIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1110C4AF0D;
	Mon, 22 Jul 2024 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721662411;
	bh=15Imh+OFzFlYBfvRORKJOPtZf3LObeq4k/Ll32cYq4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTd8KjIaWTRL96o59+FTMyeXyVvmUaF9nKnGHDMki2C56igprhfGt1eiwhuEkFbvx
	 aOKoYJNFd6c1rscHvVfL7laDKIQJC/U2LOILLSCpE8eIEljrujsjBBSiBzlrtYJBP6
	 bZ8U3G42IHuVIm2NU6HZtF+MAA72WperKHnsyq5WHFh2AxErHO4IoAxUnW0oK1b7+K
	 Z9JFRNUNZ2AyLrAg/7UL1c1YOfXcuAmVgiM4qTTsKp467KIxrFdczOxyiQqSDD4Waq
	 g8Lw01OSoiej6hOnQNExlfTe0ZfTMyd2+KEMKKpTGqiMYtbiHh67XJ4CBCaEOMb5kQ
	 +O8wm+lC0Uynw==
Date: Mon, 22 Jul 2024 16:33:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cache: StarFive: Require a 64-bit system
Message-ID: <20240722-banter-balance-ead2d4bae7fd@spud>
References: <20240719163841.19018-1-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yYG3E7Nx1SPq8byV"
Content-Disposition: inline
In-Reply-To: <20240719163841.19018-1-palmer@rivosinc.com>


--yYG3E7Nx1SPq8byV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 09:38:41AM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> This has a bunch of {read,write}q() calls, so it won't work on 32-bit
> systems.  I don't think there's any 32-bit StarFive systems, so for now
> just require 64-bit.
>=20
> Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
if you wanna take it - might be worth being explicit about it causing
build issues for rv32 though.

Thanks,
Conor.

> ---
>  drivers/cache/Kconfig                   | 1 +
>  drivers/cache/starfive_starlink_cache.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index 94abd8f632a7..db51386c663a 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -18,6 +18,7 @@ config STARFIVE_STARLINK_CACHE
>  	bool "StarFive StarLink Cache controller"
>  	depends on RISCV
>  	depends on ARCH_STARFIVE
> +	depends on 64BIT
>  	select RISCV_DMA_NONCOHERENT
>  	select RISCV_NONSTANDARD_CACHE_OPS
>  	help
> diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/star=
five_starlink_cache.c
> index 24c7d078ca22..8ee9569771f8 100644
> --- a/drivers/cache/starfive_starlink_cache.c
> +++ b/drivers/cache/starfive_starlink_cache.c
> @@ -19,7 +19,7 @@
>  #define STARLINK_CACHE_FLUSH_CTL			0x10
>  #define STARLINK_CACHE_ALIGN				0x40
> =20
> -#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
> +#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39ULL, 0)
>  #define STARLINK_CACHE_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
>  #define STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK		BIT(0)
> =20
> --=20
> 2.45.2
>=20

--yYG3E7Nx1SPq8byV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp57xwAKCRB4tDGHoIJi
0vqIAPwOOL4UUdb9ZZeCON6xMr9PV+oapD+cvpcj0rCtKB45ZAD8CNWB7YjcBpxE
+RXtgZPtDU0aI+z8h284aB3cjZ8WVgE=
=rlR+
-----END PGP SIGNATURE-----

--yYG3E7Nx1SPq8byV--

