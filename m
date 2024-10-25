Return-Path: <linux-kernel+bounces-382171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC609B0A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DD71C22831
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FED209F57;
	Fri, 25 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ57wxgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C31FB895;
	Fri, 25 Oct 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875234; cv=none; b=j0vY7jrMJkoGyZey71CoJtUflJAAWuyngAD6LNRYrtNbavq/kgF57BKuy/WY8sVfm/KULcF91qQID3u7ahDbobX7xFnP5a7TFAksdLvtZexMEcEomLm7TR5T+kjY+oq4GvRDWwafcUEaIdiLHwmYK0z7ZHWrtaXuV7fpmzsFhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875234; c=relaxed/simple;
	bh=mZ20vGt23x6kwR08MBJTGLjtyFlZt4JECmZ6eocGZhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8HN8HVH25S6AmE98YBDWA6iWFuiU38tzEafBALYDK8+CbRGKY9VHdBycLHHezYhf0jrNiZw14fQxngkA7iXDNsRd49tg0cuo3R4pErvCoP4NEsDp4xDuZd3uTIEd3ZRrl39El8wc4UpmFQUTkwsw3tRShwZIM63ASd0iwqMoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ57wxgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE92AC4CEE3;
	Fri, 25 Oct 2024 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875234;
	bh=mZ20vGt23x6kwR08MBJTGLjtyFlZt4JECmZ6eocGZhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJ57wxgQl26dw00jvHIkCz8BY1qNcJDhne+yEt/g4C1GpC37DYHrUWIihVaeIarNp
	 mssbN/R1+BPJk1WgortTtVjvlA22spTtqlYk2OFsAkDieVUX1r2N00G1nLUzB5nbf7
	 paofRo4TGF7QfBOFz0NKmyuw3T7aoLxozQejOcE42tC0jkSCFCMmX2ZuzilWIysDm4
	 y2YEDe4wDXobiG49pUP3NdDDMvdEq8W64uvE66Ufxse+n3T/sLOzgbUskepEVbMchJ
	 WeFTB1FvrvdUImm86JPec/9AwCpIotR7+NxC5801UHdVrASyXDQJkI4PdRuYqFlcQj
	 LvcddiaYd8rOQ==
Date: Fri, 25 Oct 2024 17:53:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: riscv: document vector crypto
 requirements
Message-ID: <20241025-defile-blaming-12fc1e3a62e0@spud>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
 <20241024-pungent-lasso-42dd3512a3c8@spud>
 <20241025022411.GB1781@sol.localdomain>
 <20241025024224.GC1781@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C3HU7TQO57knau1B"
Content-Disposition: inline
In-Reply-To: <20241025024224.GC1781@sol.localdomain>


--C3HU7TQO57knau1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 07:42:24PM -0700, Eric Biggers wrote:
> On Thu, Oct 24, 2024 at 07:24:11PM -0700, Eric Biggers wrote:
> > On Thu, Oct 24, 2024 at 01:34:33PM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >=20
> > > Section 35.2. Extensions Overview of [1] says:
> > > | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the =
composite extensions Zvkn and
> > > | Zvks-- (sic) require a Zve64x base, or application ("V") base Vecto=
r Extension.
> > > | All of the other Vector Crypto Extensions can be built on any embed=
ded (Zve*) or application ("V") base
> > > | Vector Extension
> > >=20
> > > Apply these rules in the binding, so that invalid combinations can be
> > > avoided.
> >=20
> > It looks like that part of the spec is wrong, though.  The Zvknhb and Z=
vbc are
> > correct, but the list of the composite extensions that at least one of =
them is
> > included in is: Zvkn, Zvknc, Zvkng, Zvksc.
> >=20
>=20
> I am attempting to fix this in
> https://github.com/riscv/riscv-isa-manual/pull/1697

Looks like at least one person agrees with you, but I'll wait til that's
merged before submitting another version. Thanks for reporting it.

--C3HU7TQO57knau1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxvNHQAKCRB4tDGHoIJi
0rPiAQDKaBX0AuIAHT3DnlKh92juYKdfZUvId9M1ah/kZAXt0QEAmmMl+zMQ+XSZ
rnymJW1NSZtykaUKiLZaZ5MgTaVR6Ag=
=nlLZ
-----END PGP SIGNATURE-----

--C3HU7TQO57knau1B--

