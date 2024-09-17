Return-Path: <linux-kernel+bounces-332073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC097B50C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3202843F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D8192B67;
	Tue, 17 Sep 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyE8X+Gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19482AEEE;
	Tue, 17 Sep 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607635; cv=none; b=ZE8zLdcN3jf9ik6SyRz5mw9tK23XA/2I+T1GMObfvUcj2A5dtsOpEagSKLGXtVOs8XShYzRJi2R81y9yFrsYeNlGrcXUltE9fvOnwovyJO6q/KxTV2O8l3D4Ee4R8/SEUsi6wizaeQ6eQqUSoSZLVz9jX/uoDNSycj3zCOJ7x/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607635; c=relaxed/simple;
	bh=h6tfNn4BixxJYWQYKrDQLr7/eqjQkFy0kULBd/P+I4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD2glWYTSx+z+ruNNbVVk7yHm+/XIHqbv+7WXR6GpZE+KC61BiXyTGYcqOrg1mlMRQ2q3laEUXs0vkbQMtUhV9wiEusmzIwURJN5wCl752r5Bxm//6X7d8sOE6WkhaLtrHjT3BnAURG8tP2EzChNWIBNlA+UnqzPhrkN73IzxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyE8X+Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DC3C4CEC5;
	Tue, 17 Sep 2024 21:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726607635;
	bh=h6tfNn4BixxJYWQYKrDQLr7/eqjQkFy0kULBd/P+I4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyE8X+GqWp7Z/p5furrj0+eAxM/KsS6HaBJHLmVLo8Koq88/0VSzkyTGN5IKW1HZG
	 OPwMjuyM78k+lDKtOBlMtoDD5NvXGC/HfGb0ZP4s+t0l70B3tkUCXZeU0Q/u/X0M/Q
	 a54APR/wJoX5/8nmIxkF6XPa3vuriJP7Jy7pCGTgpleDJnyjg/vJppLeEKS8rrwkm8
	 PUV0AxR9m5qcOUzETL8CZ409Ff01O8bxO3wotbiUby33e7RDVvXN89v5cQqtYX4P/C
	 gPYxufC+CdP2VL3vdg9U2I7ilIp5Y6DgI5t6CP5vLyuEb7fjJ4SSh3pNKahZ/CrqYg
	 DQM4Xhac7Mb5A==
Date: Tue, 17 Sep 2024 22:13:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: Possible misleading information in rockchip,rk3588-cru.yaml
Message-ID: <20240917-flypaper-december-3719ea838b3c@squawk>
References: <ZuIJgiN2xp6oPrHD@pineapple>
 <20240916-neuron-surfer-32db6440e1ad@spud>
 <ZuhtMHgx8XlZaayp@pineapple>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RIDGw94K0j/yawb4"
Content-Disposition: inline
In-Reply-To: <ZuhtMHgx8XlZaayp@pineapple>


--RIDGw94K0j/yawb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 05:38:56PM +0000, Yao Zi wrote:
> On Mon, Sep 16, 2024 at 05:33:49PM +0100, Conor Dooley wrote:
> > On Wed, Sep 11, 2024 at 09:20:02PM +0000, Yao Zi wrote:
> > > Hi,
> > >=20
> > > rockchip,rk3588-cru.yaml, dt-binding for RK3588 clock and reset modul=
e,
> > > contains description of customized property "rockchip,grf",
> > >=20
> > >   rockchip,grf:
> > >     $ref: /schemas/types.yaml#/definitions/phandle
> > >     description: >
> > >       phandle to the syscon managing the "general register files". It=
 is
> > >       used for GRF muxes, if missing any muxes present in the GRF will
> > >       not be available.
> > >=20
> > > But after doing some searching, I found that clk-rk3588.c actually
> > > defines no clock hardware with MUXGRF type. This is also true in in t=
he
> > > vendor code[1], it seems there is actually no GRF mux on RK3588
> > > platform.
> >=20
> > Have you been able to check the datasheet/register map for this piece of
> > hardware? Does it have a grf register region?
> > Wouldn't be surprised if it didn't, and the cause of it being in the
> > binding was nothing more than copy-paste.
>=20
> Have checked a public datasheet[1], RK3588 does have corresponding grf
> region and there are only clock related bits in PHP_GRF_CLK_CON1[2].
>=20
> But these gmac clocks bits are used in dwmac-rk GMAC driver[3]
> internally, out of the common clock driver, rk3588-cru. So I don't think
> the CRU needs access to the grf by design.

That sounds like a reasonable justification for deleting it - but please
check U-Boot etc to make sure that other projects are not using this in
a different manner to the kernel. If they are not using it, then please
send a patch :)

--RIDGw94K0j/yawb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZunxEgAKCRB4tDGHoIJi
0tzwAPsEW69ocfhtVR+GMWt0pS+MPPaBskZvsdl4XuVumMe3NAEAvsgdPy+i81Ec
ZX8q4UQyEvwTSKQHOQvpLTNM8UhH0gw=
=GlRo
-----END PGP SIGNATURE-----

--RIDGw94K0j/yawb4--

