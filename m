Return-Path: <linux-kernel+bounces-305308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5DB962CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924951F21262
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A11A3BBA;
	Wed, 28 Aug 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM9p5BaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342E1A3BA1;
	Wed, 28 Aug 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859839; cv=none; b=G0HtoT1u4FYiu0dIdYR6jD25F8+Ql8FP0xWXfy6K/dfV1tH2tOU/OyAm+ZAeP5MyRyNMBBTyZygIuQmMF9nfjqrBbqSP4pLD9uRbOn+GlDEZuGh+Viika7sUVzSjfmRFFUufIld1hTZTdzV737n5rKE0QKB4+KLVZsnrg1dgoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859839; c=relaxed/simple;
	bh=O1np8QZosEnT6CoJAfAm5I8eCz/Wg1ludBX9Ys2fqNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XomTwVTIiyquxE7ov76UGQP9Fd0YIYPkdzOJcYKLL9buqYykZOBawvaLdYxMQF08FD1wAPVDE4nBqETgp6MD4bDmtOrwh6I8zSuMqDBN27ng7BtuyixG9FU3LzaS1byTZW1oM+K5sX2Js8irRq9UoD/IHOwaGFxvcN/lshQIXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM9p5BaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4481BC4CEC2;
	Wed, 28 Aug 2024 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859838;
	bh=O1np8QZosEnT6CoJAfAm5I8eCz/Wg1ludBX9Ys2fqNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM9p5BaNivmnBBNVQtIrY1QD/tt2D8vbyGNQJWbE/aNYyf9Ai19AItTi0zYbbsxpc
	 cOz9D8KA9z8oOPxEo6f4coWNLLAyfQGK/EcKtB/koEVm/99JC3kAI4oGo/rnOVboez
	 CXdZxx75UAnq/BlX3epzAAIpFD9nGyZ5HiAGVZWSCvPIe7eIOJUpIu6kmF1JnUs1Pu
	 HoMDio+OjRoHc++NIpmoaItRP5ojrmAn9xFtkGTprrXOhgi16p7UP6ZPGMwoNqmk3B
	 XGudqvaQXKjof0S0nKt/soF7IjlzE6SjYDUjz4IhNl8BKZbIFjovIVhQXH35CPToSk
	 JJuCwgX6mYxfQ==
Date: Wed, 28 Aug 2024 16:43:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: clocks: add binding for
 gated-fixed-clocks
Message-ID: <20240828-throwing-gigahertz-739c6e5cfe84@spud>
References: <20240828101503.1478491-1-heiko@sntech.de>
 <20240828101503.1478491-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Db0ifl1sg5TNrM6U"
Content-Disposition: inline
In-Reply-To: <20240828101503.1478491-2-heiko@sntech.de>


--Db0ifl1sg5TNrM6U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:14:59PM +0200, Heiko Stuebner wrote:
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional oscillators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.
>=20
> This adds a binding for such oscillators that are not configurable
> themself, but need to handle supplies for them to work.
>=20
> In schematics they often can be seen as
>=20
>          ----------------
> Enable - | 100MHz,3.3V, | - VDD
>          |    3225      |
>    GND - |              | - OUT
>          ----------------
>=20
> or similar. The enable pin might be separate but can also just be tied
> to the vdd supply, hence it is optional in the binding.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

With Rob's fix,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Think the current name is more clear about what this is, thanks.

--Db0ifl1sg5TNrM6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs9FugAKCRB4tDGHoIJi
0ioGAP9mr9TXvsHOB+f0UQl60vnvgov9rBd/RyNqG0bUJQ2Z9AEAl60Yci5bd+Ip
VBFjGowWn1g+Jvui5emsFf6wjDDbxg4=
=KmNA
-----END PGP SIGNATURE-----

--Db0ifl1sg5TNrM6U--

