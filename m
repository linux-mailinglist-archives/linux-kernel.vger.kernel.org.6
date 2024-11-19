Return-Path: <linux-kernel+bounces-414856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D2A9D2E94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9AEB2C5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E415574E;
	Tue, 19 Nov 2024 18:48:03 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1269146590
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042083; cv=none; b=cCUObphQ97OoS224iP7csp/Gchlg5QOOGC+IYKiyOo6hhp+MYdF/y1++WOP75pIK7a8ccnXQv3gDJxfT/2pxNMjBv10eWbtBtT9HdM+IArPBJ4g8VCmXQrzt20TnzEW1u9lnopRD0B1VqIe35KnysplNTynxgKD/V2utObi5NYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042083; c=relaxed/simple;
	bh=Irw4O2YBfJDRbHbUOD1Yfhf1NVRCcQ0AAlRSnc+onJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzDMqAb+T1APD87F1PjiE8dDEwYXrc9WoXpQYYrwhifXoutIlv58TvWqsTvIC/Q4e3fKCmBRpghZhxIniNQSgYqagXacf58dLp/B/07OGp94/bI6s+5WT0SvIP3PAn1A0zSzOVR5t1TliOVkK+qmIvJ0mQzjjkA5HQruDB01Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 916C71F00053
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:47:49 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 85CFFA47105; Tue, 19 Nov 2024 18:47:48 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 6B805A47105;
	Tue, 19 Nov 2024 18:47:46 +0000 (UTC)
Date: Tue, 19 Nov 2024 19:47:43 +0100
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
Message-ID: <ZzzdT0wr0u1ApVgV@collins>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pOsvlEEZGM4sREmv"
Content-Disposition: inline
In-Reply-To: <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>


--pOsvlEEZGM4sREmv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le Tue 19 Nov 24, 16:43, Maxime Ripard a =C3=A9crit :
> On Tue, Nov 19, 2024 at 04:00:48PM +0100, Paul Kocialkowski wrote:
> > Hi Maxime,
> >=20
> > Le Tue 19 Nov 24, 15:43, Maxime Ripard a =C3=A9crit :
> > > On Tue, Nov 19, 2024 at 03:08:05PM +0100, Paul Kocialkowski wrote:
> > > > From: Paul Kocialkowski <contact@paulk.fr>
> > > >=20
> > > > The sunxi external interrupts (available from GPIO pins) come with a
> > > > built-in debouncing mechanism that cannot be disabled. It can be
> > > > configured to use either the low-frequency oscillator (32 KHz) or t=
he
> > > > high-frequency oscillator (24 MHz), with a pre-scaler.
> > > >=20
> > > > The pinctrl code supports an input-debounce device-tree property to=
 set
> > > > a specific debouncing period and choose which clock source is most
> > > > relevant. However the property is specified in microseconds, which =
is
> > > > longer than the minimal period achievable from the high-frequency
> > > > oscillator without a pre-scaler.
> > >=20
> > > That can be fixed by introducing a new property with a ns resolution.
> >=20
> > Sure but my point here is rather about what should be default behavior.
> >=20
> > The issue I had will remain unsolved by default even with a new propert=
y,
> > since people will still need to patch their device-tree to apply it.
> >=20
> > > > When the property is missing, the reset configuration is kept, which
> > > > selects the low-frequency oscillator without pre-scaling. This seve=
rely
> > > > limits the possible interrupt periods that can be detected.
> > > >=20
> > > > Instead of keeping this default, use the minimal debouncing period =
=66rom
> > > > the high-frequency oscillator without a pre-scaler to allow the lar=
gest
> > > > possible range of interrupt periods.
> > > >=20
> > > > This issue was encountered with a peripheral that generates active-=
low
> > > > interrupts for 1 us. No interrupt was detected with the default set=
up,
> > > > while it is now correctly detected with this change.
> > >=20
> > > I don't think it's wise. If the debouncing is kept as is, the worst c=
ase
> > > scenario is the one you had: a device doesn't work, you change it,
> > > everything works.
> >=20
> > I think this worst-case scenario is very bad and not what people will
> > expect. In addition it is difficult to debug the issue without specific
> > knowledge about the SoC.
> >
> > My use-case here was hooking up a sparkfun sensor board by the way,
> > not some very advanced corner-case.
>=20
> Are you really arguing that a single sparkfun sensor not working is a
> worse outcome than the system not booting?

No, what I'm saying is that this is a very common and basic use-case that
most users will expect to work out-of-the-box.

Also the possibility of interrupt storms happening is nothing new (and it c=
an
still happen with any non-external interrupt). It would typically result fr=
om a
hardware-related issue and there's no reason why it would happen on
correctly-designed boards. If anything, it would allow spotting these isues
more easily.

I think it comes down to whether we expect an interrupt controller to "just
report interrupts" or whether it's reasonable that it applies extra policy
to cover for unlikely (yet very problematic) situations. I think it's good
that it supports that, but also that it should not enforce such a
restrictive policy by default.

> > > If we set it up as fast as it can however, then our risk becomes
> > > thousands of spurious interrupts, which is much more detrimental to t=
he
> > > system.
> >=20
> > Keep in mind that this only concerns external GPIO-based interrupts,
> > which have to be explicitely hooked to a device. If a device or circuit
> > does generate such spurious interrupts, I think it makes sense that it
> > would be reflected by default.
>=20
> I mean... debouncing is here for a reason. Any hardware button will
> generate plenty of interrupts when you press it precisely because it
> bounces.

Well this is why we have both electronics to filter out these frequencies
and code in related drivers to implement such debouncing.

I am not arguing that debouncing is not important, I am saying that it
should not be that agressive on every interrupt line by default.

> > Also the notion of spurious interrupt is pretty vague. Having lots of
> > interrupts happening may be the desired behavior in many cases.
>=20
> Which cases?

Any kind of data sampling happening at high-speeds really.
And this situation also concerns interrupts that are short even if not very
frequent. That's a very large scope of use cases.

> > In any case I don't think it makes sense for the platform code to impose
> > what a reasonable period for interrupts is (especially with such a large
> > period as default).
>=20
> So you don't think it makes sense for the platform code to impose a
> reasonable period, so you want to impose a (more, obviously) reasonable
> period?

Yes absolutely. Anything that brings us closer to "you get what is really
happening with the hardware". The sunxi controller doesn't allow disabling
debouncing entirely, so the next best thing is to have it with the smallest
period.

> If anything, the status quo doesn't impose anything, it just rolls with
> the hardware default. Yours would impose one though.

The result is that it puts a strong limitation and breaks many use cases by
default. I don't think we have to accept whatever register default was chos=
en
by hardware engineers as the most sensible default choice and pretend that =
this
is not a policy decision.

> > Some drivers also have mechanisms to detect spurious interrupts based
> > on their specific use case.
> >=20
> > > And that's without accounting the fact that devices might have relied=
 on
> > > that default for years
> >=20
> > They definitely shouldn't have. This feels much closer to a bug, and re=
lying
> > on a bug not being fixed is not a reasonable expectation.
>=20
> No, it's not a bug, really. It might be inconvenient to you, and that's
> fine, but it's definitely not a bug.

I agree it's not a bug, just a poor default choice that is neither document=
ed
nor explicitely announced. For all we know U-Boot could configure that to
something completely different and that would break the assumption too.

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--pOsvlEEZGM4sREmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmc83U8ACgkQhP3B6o/u
lQy7bA//RV0AZdk6FyU8kSMY1+c4UIngeMhQ+vi5hu25q4aPypeHcV8ul/joLX4B
UTuzBphN8goisYZfUBBdO7sn6IyGbNY4DjgYqWZ3VcHzo4gLCTpbwZch7vAoZqvI
HrUR20a/QGh11BnN+9ZCuFUFBJ1m3X6XbKrR1/Zgm26/qpRN4tgRFYoB5T3jVGDk
TGSXaKqrx2VqdntzPt3WyPXbosWGDkp5z1dhUgH6HCUPpybNSNt0blPmpcKOpgmi
WP3k3rgTrXbR8p0EaenwRmnDcTQECx5Y6lHQc5/pCc72THWOUCmStNkKCB5SnqQy
43jadYzR4v9YNpfE3s+u5iGk8xbtWNu6HxSF345Ibj1zjV8p1Gsh98a0Ha13WMvf
ReHxfj+MaCL52nBDkFCgQ6BQaJIplnKkkgfddJwnejTgLaouAKPoBkxNjwRcBVUG
k4QhVpo/SHlnSlSz7snR6EgGTc5U1QEHpb1MpM5JUVh2nVvSRY4Amr/LfEIOoevL
Q8gmhbnR0qZvFVVyZsLn5BH++QWccU8TiQnQf4n+uPytK0Df+bsBgFae2vdyUipl
ZbH6W6gHAm3SBiQ2k7MrIMkildK8Ej3klmuCxp9xCrzJLIhPEpbAIRfgUnFeiad7
zZZjo3DTpfZqc/p+So4jhkSVTZtSJ0IQtaIUGWC/ujbwOmYDerc=
=sruz
-----END PGP SIGNATURE-----

--pOsvlEEZGM4sREmv--

