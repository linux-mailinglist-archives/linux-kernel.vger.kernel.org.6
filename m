Return-Path: <linux-kernel+bounces-533653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBFFA45D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A5D1736A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8E2153C8;
	Wed, 26 Feb 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDcQvtCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8274322A;
	Wed, 26 Feb 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569732; cv=none; b=RH8nWKQDbdY4DF03MGlYXO99soNGb5pY3nay/sgouZycg3QjQQH2OT/9mJwME0JSzq2bqphf/BBiA4koZ2HMFVAPJWuwZlgfC1xGV8taY5sD1DXMM/q3JgqgZzA/0oowYDdcY9RMcNBK3vu4yBbriWbuu7qubQLSwibNxeDK9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569732; c=relaxed/simple;
	bh=Y18CQNs0L+XFUrMs7xJNhaibdlj4yhyXeV9G5NktoPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+En9aXmU8JQWLtGsuFbV4FG/DujIFUHiojoG/bjhvbfHTjj5WBroqzOeJT8Mu18TaIutFrPnMbuTzzkACkQUiHEAgcYk1ktbDay97Gdk2eXldR9ruUEEJgMm+VsToF8tOHsgxn98G2yfLWMpJwwSr8++Zhhlxmi5UwzTT8nas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDcQvtCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFF2C4CED6;
	Wed, 26 Feb 2025 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740569731;
	bh=Y18CQNs0L+XFUrMs7xJNhaibdlj4yhyXeV9G5NktoPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDcQvtCag2xtXASOLbx7dX/58yvrbkfroUGes9kKr3X0TykKR2tU/rnIfR13Y5uWL
	 OHNwy8n8S/nRf2FzyNYBAIegKqqUjKngWLokARqVN3v6Z0b/IyM+u+tDrRSYJxKunw
	 Rr3v7ts1t8xOJpaE7n0uClORzCpHbwLB0QObO8lrqGE4f45ryZcsJ9IKUHESYm0Zhh
	 JEptOD1t/gTYtwHtHyvRPzAVgV1E1kACszJTA38CnEuoeY2XepbzOFKiG4pCQDZ1bm
	 wbY+ZQI0vNadashXAu+x9sth0PbBL9sDYT1u275J9j0qOD/jfzWfNUfT6RJ987oWSC
	 kAJ0xD0kfrxRA==
Date: Wed, 26 Feb 2025 11:35:27 +0000
From: Mark Brown <broonie@kernel.org>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Message-ID: <8afb3d94-336c-4e33-a73b-fc690f287556@sirena.org.uk>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
 <a7f7d4dc-283a-40b9-bb1b-0bc8aceb99c1@sirena.org.uk>
 <SA1PR03MB634020464A151651A08ECAACF1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Je8O42lRvDoqDRl"
Content-Disposition: inline
In-Reply-To: <SA1PR03MB634020464A151651A08ECAACF1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
X-Cookie: I've been there.


--2Je8O42lRvDoqDRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 02:24:58AM +0000, Torreno, Alexis Czezar wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Regulator driver for Analog Devices ADP5055
> > > + *
> > > + * Copyright (C) 2025 Analog Devices, Inc.
> > > + */

> > Please make the entire comment block a C++ one so things look more
> > intentional.

> Am not familiar with this, is this where each line use // rather than /**=
/?

Yes.

> > > +static int adp5055_en_func(struct regulator_dev *dev, int en_val) {
> > > +	struct adp5055 *adp5055 =3D rdev_get_drvdata(dev);

> > Just use the standard GPIO and regmap helpers for this.

> Confused on this, I thought these were standard 'regmap_update_bits' and=
=20
> 'gpiod_set_value_cansleep'

You've open coded the operations instead of using the framework helpers,
you shouldn't need to anything other than supply data here.

--2Je8O42lRvDoqDRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme+/H4ACgkQJNaLcl1U
h9B+XQf+P/mXfUV7Xo03nASx7ByqkyBy+VqAFOV8jDrwsw6tOmybAhlTpuC2we7w
fklbKSvRmpMz2uU2lQwQ9q3eywDPEwlG3ezhb4fkujAy2pYxVhoRrmz4QyPpE7aM
VDGnRcm1V2cRO5L0roR31kGvC7tSoMmNkl+Cb0cfeAuEpF5zdA+0T+OVR8s7/2LR
uAqMh/pPeDd4ydL9QoIltNqzgDWUMhp/JcLyuaNchs0rEK0LhwAXzJwra2DkmjGs
gh+wtVKPea5CX+SSq2C7A/4KGiGadrJWqFiZYA1nXsv1N6PlHqrFvXhTLHyNe8p/
y6Z/kZLYuzRFZOgXTAG+gx879XaW3w==
=bu8m
-----END PGP SIGNATURE-----

--2Je8O42lRvDoqDRl--

