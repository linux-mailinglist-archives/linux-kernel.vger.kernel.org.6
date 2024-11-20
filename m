Return-Path: <linux-kernel+bounces-415560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA059D37EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441AC2850FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13619C57C;
	Wed, 20 Nov 2024 10:06:04 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34618A6A8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097164; cv=none; b=ch0y0tYR8dIxSI6KWF3GcXucXWgLNHChQvAA0o7gHv2SWmmCE7V4v4XKsJGQ+V8Bhp84OPVbLFvDZK0UW4UfxNHCvMPnqK3UVltkVOE3nMUnpp+mL4cK4NeAbdXYqedwB8sYmlXsyspJHErt13uer/C2YRCnfiIZ0U4RNMhIXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097164; c=relaxed/simple;
	bh=dd428CXBDTjHrrnAJZKziNKjueoKbD3ItkypPONoNGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV8TY5eyLOcPoaVjX9nXR1cyeBOW7+/PDc/A9vuAV0nQO2Zb6ns3bolJdT71bbDtKE/SPPYIiFxWjVMQc8NK+BMIT0BLG9RT7wyR3vGmDMsyz6KRQ0wr/Pt9m7Cb8bGmEPYUpdOsxSOxghiAk00Jdaz57YeFQXnGUZSWOAD0hXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id B407E1F00053
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:05:52 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id F0CA0A472B6; Wed, 20 Nov 2024 10:05:50 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 18C00A472AD;
	Wed, 20 Nov 2024 10:05:49 +0000 (UTC)
Date: Wed, 20 Nov 2024 11:05:42 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <Zz20dquzl5_2_3TQ@collins>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
 <ZzzdT0wr0u1ApVgV@collins>
 <20241120-wild-stimulating-prawn-ffefb7@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6ghTuBK8ae4AVwyp"
Content-Disposition: inline
In-Reply-To: <20241120-wild-stimulating-prawn-ffefb7@houat>


--6ghTuBK8ae4AVwyp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le Wed 20 Nov 24, 09:01, Maxime Ripard a =C3=A9crit :
> On Tue, Nov 19, 2024 at 07:47:43PM +0100, Paul Kocialkowski wrote:
> > > > In any case I don't think it makes sense for the platform code to i=
mpose
> > > > what a reasonable period for interrupts is (especially with such a =
large
> > > > period as default).
> > >=20
> > > So you don't think it makes sense for the platform code to impose a
> > > reasonable period, so you want to impose a (more, obviously) reasonab=
le
> > > period?
> >=20
> > Yes absolutely. Anything that brings us closer to "you get what is real=
ly
> > happening with the hardware". The sunxi controller doesn't allow disabl=
ing
> > debouncing entirely, so the next best thing is to have it with the smal=
lest
> > period.
>=20
> That's an opinion, not a fact.

Yes and I'm trying to explain why I believe this is the most sensible opini=
on
here. I'm not saying everyone *has to* agree with me.

> > > If anything, the status quo doesn't impose anything, it just rolls wi=
th
> > > the hardware default. Yours would impose one though.
> >=20
> > The result is that it puts a strong limitation and breaks many use case=
s by
> > default. I don't think we have to accept whatever register default was =
chosen
> > by hardware engineers as the most sensible default choice and pretend t=
hat this
> > is not a policy decision.
>=20
> You're making it much worse than it is. It doesn't "break many use
> cases" it broke one, by default, with a supported way to unbreak it, in
> 12 years.

I think this is exaggerated. Like I mentioned previously there are *many*
situations that are not covered by the default. The fact that I'm the first
person to bring it up in 12 years doesn't change that.

Sofar the downside you brought up boils down to: badly-designed hardware may
have relied on this mechanism to avoid interrupt storms that could prevent
the system from booting.

If that happens people can always increase the debouncing time with the
property as they need.

My point here is that the property should be used to accommodate for
broken hardware and that the default should work for most use cases,
including things as simple as an off-the-shelf sensor board.

That's all.

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--6ghTuBK8ae4AVwyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmc9tHYACgkQhP3B6o/u
lQwTwQ//b5/fEXs5MceVNZECSEGGRsRCPeXKBJxJTKSzzU0G/5fYb7pOYwBALMUU
hNwu6/naY9STcTWXw7JcnwiLucbB+cUfdMM2E+9wIZjGX1SqDVi2AETX+tfDXSqz
/zenXv9tc0lNJdaF+eTp+zW4tNANIQIqtcUe8jn5EojzjBJNNBBulY5PeCqQxSpM
c+UZZDC2NGfy3wKkXw2uIbxBref4/qINz/QCkREUX9pX9nVJAPVl2an0lDgeHGu0
8VvQCMyVyaqjWcqhD8FvNoVCmP2r48Mg9suyyLiNyl94icWXCsLnqDgT380VeMuW
or/3YRfFNmyxc0UmKybEjiVyDv4EZNPnbgoTLzuNHeYs3k+jAQVxjH8SzEuKf/+Z
WO1ujWuv9nF/w7Q+sUiChNu+fqsVF7V+Zk0SyHsznUczy6OdND4dsIA8k+lv6Nhj
sOHl83QakOsLyFbQaSYfagfqVchkhChrLmYwpR++Je3zGBKJvP+1piLSq8LiBDQT
f6t6KScCJAqw7JN8dFbKuo51EUX5iW5niBe7Dwx5+CjumXQUFZHjRxqEiVUzGJ1e
d/iOHVO0eFV/HWrWOORE2GnhOcx2UPyudpfPQJoMoa+b2o0v4znCv3icaDwN0NaD
Kkr365Oez56+9DGeZiy5jTGd5PUEZCJrGaJdPjPMZ4JJL4/y/dg=
=PmWt
-----END PGP SIGNATURE-----

--6ghTuBK8ae4AVwyp--

