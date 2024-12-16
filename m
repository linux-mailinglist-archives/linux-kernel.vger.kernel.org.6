Return-Path: <linux-kernel+bounces-448054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02BC9F3A79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103571888FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8341D1730;
	Mon, 16 Dec 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1ZSoq6G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740E1CEEB6;
	Mon, 16 Dec 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379870; cv=none; b=fJqSAtS5dMkIjDkuqQEsC6TjsqBcrXoEhse6oDXzp1lyres9UcmB7UesGZqJrwQRLD7EvS20IKhRnB+/zDh4GqHBWH1mHp1gdzfjt7opYribfRHp5WN7hNZq/YqVXvc4ECnpmLNGVctwBtr+tcKy5t/GVtZIvctrH2G43Neq1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379870; c=relaxed/simple;
	bh=lkk98hRwhqZmwQEshqTnBcBCUrNRCwUxIABBB4mSJDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeWbCPsbbDtYlR4wM3/v7VjIc2/YHW+dFgC5E1cLbcZGdkUDRAFPKAXZxOg8HkZ3PNsGw6R5OQIC9JzbTmSFKnAJ86Z2PZVHOeGPkRdM1cTneU1M9ppuUq66IicAHuWjN//8ziQyDiZLsKtBwtaDVNKJf/0ILT6E6WL1Qr7VxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1ZSoq6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B72C4CED0;
	Mon, 16 Dec 2024 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379870;
	bh=lkk98hRwhqZmwQEshqTnBcBCUrNRCwUxIABBB4mSJDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1ZSoq6GxisXu1A8l+XUeE3e/87SOeoSJw1h79l7SBGMMaC2R2/a3mlY8F0YY6H2p
	 faOnDgoZRmK7SQeGffp63FkZgTeUNQcJ+qc6lcw1EjOyNYtAZJoVkIVTM/bLDqwk+K
	 fGeNP1VMw8l/9YoLVZZ5D8jTML6mEbrvvOnZlkQ78tE6zpDQ/xedTCMBt/PZ5VB3BG
	 Lq28a3VRRetDaKPKpnBMZw/g9lUquh8GgSqeBudnHCHKg5AItUZ7lV7oll3JqYCCd1
	 EWDpYYMpU7jWJDEOBdNW8cvt/QhDgzsU877VSIJMdvGfG5WKVKbbg6sIg7Iz5Azfzr
	 0QPK4y5+dW1IA==
Date: Mon, 16 Dec 2024 20:11:05 +0000
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: Use named
 definition for mmc1 card detect
Message-ID: <20241216-rounding-padlock-25a55bfad108@spud>
References: <20241210040652.164030-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Xhj8PbiuSf1P2l9"
Content-Disposition: inline
In-Reply-To: <20241210040652.164030-1-e@freeshell.de>


--6Xhj8PbiuSf1P2l9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 08:06:46PM -0800, E Shattow wrote:
> Use named definition for mmc1 card detect GPIO instead of numeric literal.
>=20
> Fixes: ac9a37e2d6b63 ("riscv: dts: starfive: introduce a common board dts=
i for jh7110 based boards")

I don't think this is a fix. Don't resend for that, I'll remove the tag.

> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 48fb5091b817..12a90d38ab31 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -281,7 +281,7 @@ &mmc1 {
>  	bus-width =3D <4>;
>  	no-sdio;
>  	no-mmc;
> -	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	cd-gpios =3D <&sysgpio GPI_SYS_SDIO1_CD GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	cap-sd-highspeed;
>  	post-power-on-delay-ms =3D <200>;
>=20
> base-commit: 708d55db3edbe2ccf88d94b5f2e2b404bc0ba37c
> --=20
> 2.45.2
>=20

--6Xhj8PbiuSf1P2l9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2CJWQAKCRB4tDGHoIJi
0jQcAQC0h2JuDDyQXflhrr72Iny3UoInADf6RdtNzdx3ZjrBQwEApDFAen0ljmkx
Ib4yz3oRzyNeDuMY1z5bLXM3qZofnQo=
=nL2z
-----END PGP SIGNATURE-----

--6Xhj8PbiuSf1P2l9--

