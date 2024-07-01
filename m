Return-Path: <linux-kernel+bounces-236222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B35891DEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CED1F21D25
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B914A604;
	Mon,  1 Jul 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT4f8WEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F587404F;
	Mon,  1 Jul 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836319; cv=none; b=lHiRrpVvbiy/B4o8SRA2vRllcoBXRgD7aWSHXtjBPZ/30G/10T4HBU9G9O2RqaElpC2M1CMWP070vJbcouuh76ekBw+VpC22+9Qao/pppiVm2uxn94TpRBdFVxpsMmq9MRT5OXBhvfbXO9AAvqvJxkj5tK5XwdJ0PyMQ9sRrEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836319; c=relaxed/simple;
	bh=ngfLZvGV6uNktSmrI51yAbmgEtk/48MHEWS6ypeymyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb5Bsj2n7/MQevw6WFpuqPnHIqMneAChBiRNpZzAJLODZy2IVqaSPPQAJKVSwoGJJ1neBybMEJymReIjlMns5mS1jh/6JOze1Ml9089JKkWcD11HN00dxYamWI3OhyRRlFQSIE4UdxmWqhdlpPPlSb7MNGhW5oxoijbC7vnezZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT4f8WEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F0AC116B1;
	Mon,  1 Jul 2024 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836318;
	bh=ngfLZvGV6uNktSmrI51yAbmgEtk/48MHEWS6ypeymyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MT4f8WELSRTQzhacSmF5U6XENMjFHm/V1ehqU/8RQFmoiEN3M63QkYwdNIWGpjjax
	 50w04mD01aEgUvzPqhwE9/T2zPRk7wM+W5iKB5J/erAhOnGYleoUgb9HiJLqWE0hbC
	 nmFwK9jcUAAntb0ckGzTNW9W3jCgXSn3MkAniGaWpnjQJ1sVvwICrz+oGmz5MX2Zav
	 utyhyQzEuZ/Wxg8UjLI2d5IKmLKb7RWTy7YokMimNoOL7JKFR91JzTSIFmlLwKy80F
	 ri8F2stJDEOBoLd06AjZeRBIv3wyFPFklCjBTYrfos0Z6KZZcRld7ffXfLJf5AbOwX
	 ysxOybwj3We0Q==
Date: Mon, 1 Jul 2024 13:18:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: starfive: add pcie1 on the star64
Message-ID: <20240701-jaundice-enroll-1473aecce983@spud>
References: <20240626-traverse-excitable-a1d9be38a9da@spud>
 <SHXPR01MB086332671CEBE2D0A21ED695E6D32@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xupLm0cCcA85XjGZ"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB086332671CEBE2D0A21ED695E6D32@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>


--xupLm0cCcA85XjGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 10:45:15AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > It was reported to me that the star64 actually /does/ have an exposed P=
CIe port,
> > despite the commit message there. In my original conversation with Mind=
a,
> > they said that pcie1 was available there and pcie0 was not, but the v2 =
patch
> > didn't actually add pcie1 on the star64.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > I think I'll just squash this in and fixup the commit message, since th=
e patch is still
> > at the top of my branch.
> >=20
> > CC: Minda Chen <minda.chen@starfivetech.com>
> > CC: Conor Dooley <conor@kernel.org>
> > CC: Rob Herring <robh+dt@kernel.org>,
> > CC: Emil Renner Berthing <emil.renner.berthing@canonical.com
> > CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-riscv@lists.infradead.org
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > index 2d41f18e0359..b720cdd15ed6 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > @@ -39,6 +39,10 @@ phy1: ethernet-phy@1 {
> >  	};
> >  };
> >=20
> > +&pcie1 {
> > +	status =3D "okay";
> > +};
> > +
> >  &phy0 {
> >  	rx-internal-delay-ps =3D <1900>;
> >  	tx-internal-delay-ps =3D <1500>;
> > --
> > 2.43.0
>=20
> Hi Conor
>=20
> The jh7110-pine64-star64.dts is in linux-next tree. I have not noticed it=
 before.
> Should I squash this to my patch? Can my dts patch be accepted in kernel =
6.11? Thanks
> (The same with Starfive PCIe patch set in linux-next, which will be merge=
 in 6.11, right?)

I already applied your patch, I'll squash this into your patch and queue
the result for 6.11.

Thanks,
Conor.

--xupLm0cCcA85XjGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoKemwAKCRB4tDGHoIJi
0hl5AP4tq/0cGJ4J8cwlO45COR2B2WBVRKqZ2766zlqVGyzPxAD/UBj0CMvcQrG6
TqLmV/Av2kgk7raSUv6G+/bKAKfz7gw=
=OgkJ
-----END PGP SIGNATURE-----

--xupLm0cCcA85XjGZ--

