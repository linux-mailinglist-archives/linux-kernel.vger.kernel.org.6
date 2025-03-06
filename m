Return-Path: <linux-kernel+bounces-549351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740D5A551A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EECC3B1C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5D215F6D;
	Thu,  6 Mar 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk3KX6zp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558D20FAAC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279253; cv=none; b=YRuvz07743Casz02zbg1Mo0IktwMTHRGupYf8q0GIGYxxjKC8xoGXYJUc8EPxR5EW9N1b6j4mLARSvDF6u9u310x3uBmvJBD+NSV7gYwXq78oICkokWdW8jxHo3dfOObna274JNToNhV2HqKbvZyr13iOHwJNUyZG5aWvz5N1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279253; c=relaxed/simple;
	bh=qmew9N890LQz41I96G6gTo7b5NoYq+LHIcuWvtAjqhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqsqQQ2mPbqSy3qTxvahw20GdGE4dZ6KN/IMga61kfORMlULvOHhzUqX2Z7Qc3e5xTf70OTTmSCZLim5HWZ3Hz+bh4+Xi+3aU8tjeTpq2A9VMkr6OeXLenV0d6g95ZFm/TBoSPIlGmday4tSmjSteoGHuI8jJx6eJAx+DOHLCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk3KX6zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DC1C4CEE0;
	Thu,  6 Mar 2025 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741279253;
	bh=qmew9N890LQz41I96G6gTo7b5NoYq+LHIcuWvtAjqhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pk3KX6zpLRYFtaeOOU7LCDCvqGq34e3+EOgp7JiSmyNicg7sVkdl4uRjjnxHdk7jZ
	 X6kETBuFILbvSBkAwbeMGKSbNMMVkVCEO9cudPYoXGug0BdVtTYyesIXUxQTbsdrSm
	 YYdM1wRn8/6/rQY2OgD1aPznovKMSOY9rQxnS8C4ccmkDK2h8nnDPpB3+xZ7hWDccI
	 AOQ+lVSodp29JFSCCox/Le1hxESOTUEH4B6RT7gPERd6JM+JiWqvt99ctAL66Bo9ou
	 6Wy5hjWdgF+QQjiGeNiapOaNdXE5zWmEWBdMB9j/DzDzO+rxWZT/OYziBwB3+uHfTE
	 sMEomaEAHqJmw==
Date: Thu, 6 Mar 2025 16:40:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr
Subject: Re: [PATCH] riscv: add Andes SoC family Kconfig support
Message-ID: <20250306-finale-chatroom-c620ff284d8c@spud>
References: <20250305030526.1986062-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vQim4Phh7trms/cN"
Content-Disposition: inline
In-Reply-To: <20250305030526.1986062-1-ben717@andestech.com>


--vQim4Phh7trms/cN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 11:05:26AM +0800, Ben Zong-You Xie wrote:
> The first SoC in the Andes series is QiLai. It includes a high-performance
> quad-core RISC-V AX45MP cluster and one NX27V vector processor.

I'd expect a config option like this to come with the user, which in
this case is the dts etc for a board using the QiLai SoC or drivers for
the SoC. Without dts or drivers, there's no reason to ever enable this,
so where are those patches?

Cheers,
Conor.

>=20
> For further information, refer to [1].
>=20
> [1] https://www.andestech.com/en/products-solutions/andeshape-platforms/q=
ilai-chip/
>=20
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  arch/riscv/Kconfig.errata | 2 +-
>  arch/riscv/Kconfig.socs   | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e318119d570d..be76883704a6 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -12,7 +12,7 @@ config ERRATA_ANDES
> =20
>  config ERRATA_ANDES_CMO
>  	bool "Apply Andes cache management errata"
> -	depends on ERRATA_ANDES && ARCH_R9A07G043
> +	depends on ERRATA_ANDES && (ARCH_R9A07G043 || ARCH_ANDES)
>  	select RISCV_DMA_NONCOHERENT
>  	default y
>  	help
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1916cf7ba450..b89b6e0d1bc9 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -1,5 +1,14 @@
>  menu "SoC selection"
> =20
> +config ARCH_ANDES
> +	bool "Andes SoCs"
> +	depends on MMU && !XIP_KERNEL
> +	select ERRATA_ANDES
> +	select ERRATA_ANDES_CMO
> +	select AX45MP_L2_CACHE
> +	help
> +	  This enables support for Andes SoC platform hardware.
> +
>  config ARCH_MICROCHIP_POLARFIRE
>  	def_bool ARCH_MICROCHIP
> =20
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--vQim4Phh7trms/cN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8nQEQAKCRB4tDGHoIJi
0jT2AQCKZVdssBZSIJkKffobBzbN32p6AzBmy+PGIjHiz6mE4AEAzKZDacmHtjVO
6HyA1zLnh9IEm1KF3Oy+O/ZEhBNJ0ww=
=14cR
-----END PGP SIGNATURE-----

--vQim4Phh7trms/cN--

