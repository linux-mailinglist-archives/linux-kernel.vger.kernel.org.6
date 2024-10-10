Return-Path: <linux-kernel+bounces-359572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CF998D75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5A11F21110
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0576D194C6F;
	Thu, 10 Oct 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5ljNeSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E727468;
	Thu, 10 Oct 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577859; cv=none; b=s7YQ63rvRrRzxkz6W9fWQkA5w7prVoamyYnUMoWXJ5S9pySHfc7J9elek2enIQ7a1tWJiYoq9MJXJKeGD8iPs5tLGaWXcAZKRk1nDchI5iKhZ1a+QsOowLNcTVNOSmlCcp4fVmRp7+fVTZQ79z5xvrtNsKnDbm8MDL0+46Cq/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577859; c=relaxed/simple;
	bh=RvXBvlR7KwJyYd3hdJSqaH+DwBsVzPsqPvzyV+x7tcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRKbwCzTmRQtHSowITrQ5zorzI18MEqL1xmS2RiwsPBHBsy4eB8Dyg2USifgoqPV1JdDs5wbk9DVB5lRUHmM4xgUk+RzFDRbVa0wdJgTE2hC9YXQrsIHDr3PegSoM70h1MdCOWzc8ZE467qG1ND2L/qvMbBDfni3hfJV4rLeb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5ljNeSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D2FC4CEC5;
	Thu, 10 Oct 2024 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577858;
	bh=RvXBvlR7KwJyYd3hdJSqaH+DwBsVzPsqPvzyV+x7tcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5ljNeSFqRdxZcAjhXzkaR2TwHxsc7CDFqc+mqN3UChAb0+XMovek5jY0j9/cbkiW
	 5k30JBcReTY/h+DKkk7wu4VKTC8VdCqatuLgH9U432KhHdQCyAPeFgub09ysvdmWjt
	 hGOGOAwQdKRyxlAVzRI+W3DAjwz6VWMVKOkaSwqF3xqQROMBxtZFw3gbMudIMu5bkE
	 A4zkwVfOBMkXxMJWuLffMcu1UyPpfD0ocj4GzxCIUNpF0k1cs+e/WwnSRg81z4z/oq
	 KFfr06xfcZ7CZbJ5UTZix8zMTskuUs6g0VvqqGteK4dEBnCVXhXcP/SYA6rUaMNxPi
	 A++x4hMbmbuOQ==
Date: Thu, 10 Oct 2024 17:30:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Willow Cunningham <willow.e.cunningham@gmail.com>
Cc: willow.e.cunningham@maine.edu, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: Fix L2 linesize for Raspberry Pi 5
Message-ID: <20241010-acutely-majesty-c044c7ce6f0a@spud>
References: <20241010150409.262087-1-willow.e.cunningham@maine.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xiSaRYVtkHY9fRuh"
Content-Disposition: inline
In-Reply-To: <20241010150409.262087-1-willow.e.cunningham@maine.edu>


--xiSaRYVtkHY9fRuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:04:07AM -0400, Willow Cunningham wrote:
> From: Willow Cunningham <willow.e.cunningham@gmail.com>
>=20
> Fixes: faa3381267d0 ("arm64: dts: broadcom: Add minimal support for
> Raspberry Pi 5")

This btw Willow, is meant to be...

>=20
> Set the cache-line-size parameter of the L2 cache for each core to the
> correct value of 64 bytes.
>=20
> Previously, the L2 cache line size was incorrectly set to 128 bytes
> for the Broadcom BCM2712. This causes validation tests for the
> Performance Application Programming Interface (PAPI) tool to fail as
> they depend on sysfs accurately reporting cache line sizes.
>=20
> The correct value of 64 bytes is stated in the official documentation of
> the ARM Cortex A-72, which is linked in the comments of
> arm64/boot/dts/broadcom/bcm2712.dtsi as the source for cache-line-size.
>=20

> Signed-off-by: Willow Cunningham <willow.e.cunningham@maine.edu>

Down here, on the line before your signoff. Perhaps Florian is willing
to fix that for you though.

Cheers,
Conor.

> ---
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/=
dts/broadcom/bcm2712.dtsi
> index 6e5a984c1d4e..26a29e5e5078 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -67,7 +67,7 @@ cpu0: cpu@0 {
>  			l2_cache_l0: l2-cache-l0 {
>  				compatible =3D "cache";
>  				cache-size =3D <0x80000>;
> -				cache-line-size =3D <128>;
> +				cache-line-size =3D <64>;
>  				cache-sets =3D <1024>; //512KiB(size)/64(line-size)=3D8192ways/8-way=
 set
>  				cache-level =3D <2>;
>  				cache-unified;
> @@ -91,7 +91,7 @@ cpu1: cpu@1 {
>  			l2_cache_l1: l2-cache-l1 {
>  				compatible =3D "cache";
>  				cache-size =3D <0x80000>;
> -				cache-line-size =3D <128>;
> +				cache-line-size =3D <64>;
>  				cache-sets =3D <1024>; //512KiB(size)/64(line-size)=3D8192ways/8-way=
 set
>  				cache-level =3D <2>;
>  				cache-unified;
> @@ -115,7 +115,7 @@ cpu2: cpu@2 {
>  			l2_cache_l2: l2-cache-l2 {
>  				compatible =3D "cache";
>  				cache-size =3D <0x80000>;
> -				cache-line-size =3D <128>;
> +				cache-line-size =3D <64>;
>  				cache-sets =3D <1024>; //512KiB(size)/64(line-size)=3D8192ways/8-way=
 set
>  				cache-level =3D <2>;
>  				cache-unified;
> @@ -139,7 +139,7 @@ cpu3: cpu@3 {
>  			l2_cache_l3: l2-cache-l3 {
>  				compatible =3D "cache";
>  				cache-size =3D <0x80000>;
> -				cache-line-size =3D <128>;
> +				cache-line-size =3D <64>;
>  				cache-sets =3D <1024>; //512KiB(size)/64(line-size)=3D8192ways/8-way=
 set
>  				cache-level =3D <2>;
>  				cache-unified;
> --=20
> 2.39.2
>=20

--xiSaRYVtkHY9fRuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwgBPgAKCRB4tDGHoIJi
0uzZAQCpO0K+/ZDCC1EYM+s6KiX2MO9HP6VMM+G46urh1C1sOQD/WXBx9RY6YGjr
If8S1v3uE4Y19HqUDENiw4qyRli9CwI=
=/VfI
-----END PGP SIGNATURE-----

--xiSaRYVtkHY9fRuh--

