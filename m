Return-Path: <linux-kernel+bounces-332428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804FB97B995
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0847A1F2754D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A37E176FA7;
	Wed, 18 Sep 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQDDWhhW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F963DF6C;
	Wed, 18 Sep 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649362; cv=none; b=g1le4EuTtu42t0ytuUJ7g27mU4PxB350HFh76kuvMWBdDgi/YU1hzEdwBROLbkYbrM69cWd/iy0ewONpPgUOq9HmDTdlgg9Iu+pXxKUNReBhW1YJ0xttuCB6DVmziU59cUR+N1jXl7Znikap5qgnG9EzUahGJWXBroXZRRsPxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649362; c=relaxed/simple;
	bh=Qy5FllhBkPQbLsxTmUUnuogOwSaJdkkZ2cGgJ9vQjpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFBPjvyzDhKWe/PynSJeXiZh4LKS1h+DzT/2aA3LeBnuDsyFAntgbgJ1PBgtfaDYXhLToyYFllPmjli+CZpncW9CWgLJFvopzAEfw7Phm6s1IH9Yib/5Y9HxVT1JLa+Ofz+qSJ1qhUgIa7BIqbTVnlqXhSdqel+yHYNDePUlV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQDDWhhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5469CC4CEC3;
	Wed, 18 Sep 2024 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649362;
	bh=Qy5FllhBkPQbLsxTmUUnuogOwSaJdkkZ2cGgJ9vQjpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQDDWhhW+lVW+sgRvIjK+8Zu0WbtNPTRCiTbKuBFxU3oAUQ1AFTLTrTFc0j0SUOdB
	 +r5qp/NQhQ/eP4kcx9mq+2MhAQaol9rkBBsMnjMggWKOkADacZLb82aWEfcctdZcAq
	 xFpK3moxPGXjgCOW8sETJ+VK8aNbo+9GnnGlzsx0pYio/lGU+85GyAWYDjgSv1U2MI
	 taAHsIJNOv/2cuBz8EaQrZrDAkFxq5ODZdBorGimMhEwDQrFqFXCgfxPs06cEoJRTp
	 SLQBHYTgC7FmHRM3kLK/E5Y3f5ZRJ5r49hUTIL2PH1rphyKwtsOGJ/QcLL6oV8AYEC
	 NHtRuKkOsPJ3A==
Date: Wed, 18 Sep 2024 10:49:16 +0200
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
Message-ID: <ZuqUDJThMvReRskQ@finisterre.sirena.org.uk>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
 <ZulJuCu-QcMYrphP@finisterre.sirena.org.uk>
 <5ad81ed43d8bb2426c9ae7d22fdb4c7aeb905129.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2Zdp1ebFNH8qHs2"
Content-Disposition: inline
In-Reply-To: <5ad81ed43d8bb2426c9ae7d22fdb4c7aeb905129.camel@linaro.org>
X-Cookie: Editing is a rewording activity.


--r2Zdp1ebFNH8qHs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 12:41:16PM +0100, Andr=E9 Draszik wrote:
> On Tue, 2024-09-17 at 11:19 +0200, Mark Brown wrote:

> > This is an error on the input, not an error from this regulator, so the
> > notification isn't appropriate here.

> The input is usually a USB plug / cable. Is there a better option to repo=
rt
> this? I guess I could register a power supply.

Yes, that's a power supply.

> > > +	return FIELD_GET(MAX20339_INSWCLOSED, val) =3D=3D 1;
> > > +}

> > This does not appear to be an enable control, it's reading back a status
> > register rather than turning on or off a regulator.

> This is the regulator_ops::is_enabled() callback, shouldn't it return the
> status in effect? It's required to return effective status for one of the
> code paths in _regulator_do_enable(), when .poll_enabled_time is !=3D 0.

No, if there are separate enable and status bits it should return the
value written to the enable bit.  Some devices overload the
functionality, this one splits them.

> > > +static int max20339_set_voltage_sel(struct regulator_dev *rdev,
> > > +				=A0=A0=A0 unsigned int sel)
> > > +{
> > > +	return max20339_set_ovlo_helper(rdev,
> > > +					FIELD_PREP(MAX20339_OVLOSEL_INOVLOSEL,
> > > +						=A0=A0 sel));
> > > +}

> > This device does not appear to be a voltage regualtor, it is a
> > protection device.=A0 A set_voltage() operation is therfore inappropria=
te
> > for it, any voltage configuration would need to be done on the parent
> > regulator.

> This is handling one of the switches, and the input usually is
> a USB plug / cable.

> Based on the use-case (peripheral / OTG / wireless charging), the
> overvoltage voltage=A0needs to be modified at runtime for full
> protection.

Sure, but that's not setting the voltage of a regulator that's
configuring the protection.

> The set-voltage APIs seemed like a good fit for that, given the
> regulator APIs allow setting those thresholds already (during init).

Don't shoehorn vaugely related things into a somewhat similar looking
API, that'll just blow up whenever something actually assumes that using
the API does the thing it's supposed to.

> I'll see if I could maybe add a power supply as the parent and leave out
> all the voltage and current related settings here altogether and make it
> just control the switches, like some other regulator drivers do.

An API for dynamically configuring limits for regulators at runtime
would be OK too.

--r2Zdp1ebFNH8qHs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbqlAwACgkQJNaLcl1U
h9Congf8CFyanpADAaXWaU7Diss2zCzIVD69MBPxqVmx5zQMPd/5grAdWLtVhd/8
0md2SQHeC7lEeYMAngWsuHRdEbFaxzzJT5uvUYLZxQdeKZQE073huxNH3KBKS2lr
cA8VnFdGOCwsBasvBtQq4YIbkhM8Z+sEND9HpbquFTi1/jTZmEjIujMfBhk+Eke5
0OEGp5LXURRg8YEus2kWtAuC6vE/7a1BUyeMLWFL97uEUJBLhMyASDoXSbN5IXiC
38uiseS2udVMvWY8qt/tIwL/dEFCxwUFgRrDwePx1QJnewWsf5zcl7In6DbctPQK
AnvOtf2kxqYGvXOKtohaUPOdWXYrQQ==
=1Aeq
-----END PGP SIGNATURE-----

--r2Zdp1ebFNH8qHs2--

