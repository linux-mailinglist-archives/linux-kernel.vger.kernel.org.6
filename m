Return-Path: <linux-kernel+bounces-179036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191D8C5AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C963B282909
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1A180A6A;
	Tue, 14 May 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVSAm+Q7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9982B9D7;
	Tue, 14 May 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709686; cv=none; b=qBxKBcd2VoF/yVYXM6M87YGQdMPvjbtcxYovWAfT96cunRY2m1q3irJECAaTjRZf1WNVtDo0Rr6QE5ABRoJlCuKgPvDw42ZB08w5RY4ey/TMTd//nWbWAMQ6UByOMxkLSzqgXfxH3VBYH2EywnDZP1K1fisIfxyelyLdGAIiy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709686; c=relaxed/simple;
	bh=Bc0wnqBHezPEtPKq9Cw+J6D4ZphM4Nqpns2kp7JEKHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kezz7jRLPBSRXTnVPnqxMzs/9ldmrCJAjL5p0PoZc3WvB0295Z8I93eSpLy1q/5RfYytFjBGI/JdDVIgBCkaKcmsJK0wbZzxG89FMaaJfSn+RgR9HH5LJC0xABlnO/AxnId40DlnAJ7yNIXlGbKh14uNLnp2g6lEwkXli02Q4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVSAm+Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8E1C2BD10;
	Tue, 14 May 2024 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709686;
	bh=Bc0wnqBHezPEtPKq9Cw+J6D4ZphM4Nqpns2kp7JEKHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVSAm+Q7jYM0tMpv4biueBN83sAVh5OHFylqNh5+9zQ+7+cMZg8Ntwyu2jg8qlKMa
	 Du8JgN5ms8MXa0m+vB1PuwbNbRR5EbOuiGlfNZwd3UDv/xNIonLJ1s3nKtk5+WuO1n
	 Bwx8LvTuk7H3kZeYRYs6C65w5MeUUIIXjNXqLJKrRsU4xqdesxJ1VYMO0BodazZFJi
	 wEU9DVG84W3FixjeJu5b2dxl/Zhf4gtkOGjQR0d8xM6Q3jknGFkJ7DLkd2rGVvaE0S
	 /wJt+J/i0x1WzmAVhLrKC1icMGahXzTyKYLsx3sW+HF2YCoom7dZJbIH1Olx/HdENk
	 P9xE7vvmXUZsA==
Date: Tue, 14 May 2024 19:01:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, johnny_lai@richtek.com,
	cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240514-plunging-chair-803d9e342e6f@spud>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
 <20240513-tissue-repave-13d2e3bf88fd@spud>
 <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y6XnTRi+fElIVr2m"
Content-Disposition: inline
In-Reply-To: <d97752ed-4032-4681-b28f-17f149fdc3d4@sirena.org.uk>


--y6XnTRi+fElIVr2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:34:29AM +0100, Mark Brown wrote:
> On Mon, May 13, 2024 at 05:22:54PM +0100, Conor Dooley wrote:
> > On Fri, May 10, 2024 at 08:06:25PM +0800, Alina Yu wrote:
>=20
> > > +            richtek,fixed-microvolt =3D <1200000>;
> > >              regulator-min-microvolt =3D <1200000>;
> > >              regulator-max-microvolt =3D <1200000>;
>=20
> > I'm dumb and this example seemed odd to me. Can you explain to me why
> > it is not sufficient to set min-microvolt =3D=3D max-microvolt to achie=
ve
> > the same thing?
>=20
> This is for a special mode where the voltage being configured is out of
> the range usually supported by the regulator, requiring a hardware
> design change to achieve.  The separate property is because otherwise we
> can't distinguish the case where the mode is in use from the case where
> the constraints are nonsense, and we need to handle setting a fixed
> voltage on a configurable regulator differently to there being a
> hardware fixed voltage on a normally configurable regulator.

Cool, I think an improved comment message and description would be
helpful then to describe the desired behaviour that you mention here.
The commit message in particular isn't great:
| Since there is no way to check is ldo is adjustable or not.
| As discussing in v2 series, 'richtek,fixed-microvolt' is added for that.
| user is supposed to know whether vout of ldo is adjustable.

It also doesn't seem like this sort of behaviour would be limited to
Richtek either, should this actually be a common property in
regulator.yaml w/o the vendor prefix?

Cheers,
Conor.

--y6XnTRi+fElIVr2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOm8QAKCRB4tDGHoIJi
0gEmAP4o7NTdR+NPyO2SBBx+xJS2PcXXapchLf9DJZ9ZomjMwwD5AX40LUjeIKEB
aR0bZK9YX8u5pX0M5rhLdjRaYib3igU=
=D1lw
-----END PGP SIGNATURE-----

--y6XnTRi+fElIVr2m--

