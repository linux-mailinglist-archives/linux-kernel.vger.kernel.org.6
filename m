Return-Path: <linux-kernel+bounces-330921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33DD97A621
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D175B2D232
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084315B10A;
	Mon, 16 Sep 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCtmew8R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10015A84E;
	Mon, 16 Sep 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504435; cv=none; b=iZE0ZHmKNEILd21XwhywD/l3tQw+f5fGzR95NgvybzSdPpj5sTUQ9WR+Id070+HfMIjssqzMChUpPkB9gFByzJL6GD9L0hbZXaNabHOdaG+HhXOcL0uK62LHPLxYFNk3uv2gXRcLn91JGTI6UmGdBrv4Hp6RDzHeW1SvQS2Jk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504435; c=relaxed/simple;
	bh=QqNjHfV+bL/edqLFl7taMwluNBafAR8LxONwNNjOAcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogUmFv2q152kH8VPpGvelCSsYd2afS1FFgc9XoaMCTRlee3J/kvpRyPa48B827VwzKucf2V9NAVuy9aHx647GCMpAQuYfSKzVgrCfWkj8Uw8LgPD4yBqSB3maYyMZkcPrDgygpaudZR0yvixaNrqU3M+tFCm7tf7CVeRUuJSWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCtmew8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B2C4CEC4;
	Mon, 16 Sep 2024 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726504434;
	bh=QqNjHfV+bL/edqLFl7taMwluNBafAR8LxONwNNjOAcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCtmew8RuqFe0tIQcMcetN0cyzAHNDgdFZ96zEVYKfPmrkzcqwxb+1XhE7mAjR4uI
	 RxKQ7chmm1h6BYcrJXRsxT9njZjF6rjVr0+FErjNGqUjkGMgLomRcrQxQHUOufoZJK
	 Q56W8acdw/sfpxF1s6kcXcgR8FGgDk6g+4J46bIvaZvjNqkg6QWpFrERfBpIDB/XcV
	 E/fo1OC8fdawkQS+t1f6RjqYhvTh85RgAYOKLCkZYpFZm0daWBK6XVkr3QJR6wOdPB
	 TaLIt9sTOdxyZSoRXm/ItCMVC4RyphBNSwbYFAbtvvNYR+Sf4AIy7i2/X5hFkFSFTX
	 9HSjvaOEucs7w==
Date: Mon, 16 Sep 2024 17:33:49 +0100
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
Message-ID: <20240916-neuron-surfer-32db6440e1ad@spud>
References: <ZuIJgiN2xp6oPrHD@pineapple>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="762l3reB4+o5LV48"
Content-Disposition: inline
In-Reply-To: <ZuIJgiN2xp6oPrHD@pineapple>


--762l3reB4+o5LV48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 09:20:02PM +0000, Yao Zi wrote:
> Hi,
>=20
> rockchip,rk3588-cru.yaml, dt-binding for RK3588 clock and reset module,
> contains description of customized property "rockchip,grf",
>=20
>   rockchip,grf:
>     $ref: /schemas/types.yaml#/definitions/phandle
>     description: >
>       phandle to the syscon managing the "general register files". It is
>       used for GRF muxes, if missing any muxes present in the GRF will
>       not be available.
>=20
> But after doing some searching, I found that clk-rk3588.c actually
> defines no clock hardware with MUXGRF type. This is also true in in the
> vendor code[1], it seems there is actually no GRF mux on RK3588
> platform.

Have you been able to check the datasheet/register map for this piece of
hardware? Does it have a grf register region?
Wouldn't be surprised if it didn't, and the cause of it being in the
binding was nothing more than copy-paste.

--762l3reB4+o5LV48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuhd7QAKCRB4tDGHoIJi
0sfLAP4rUDigw1FDwiNdvnZREugTaL9WpuIT1BHZHS4TrWxCZgEApyjlEt72BdfD
fapeDQzlfMZjPRcI/2jXPFZkPzGcuw8=
=2kPB
-----END PGP SIGNATURE-----

--762l3reB4+o5LV48--

