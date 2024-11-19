Return-Path: <linux-kernel+bounces-414485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE09D28C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FCB1F21C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A11CEAAD;
	Tue, 19 Nov 2024 15:01:03 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DC1CCB25
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028462; cv=none; b=V+GInyYoUG045jRaKvqN2Dmul6sCea4byP1Q2wB3xSbDcKGJVY13PUAybQblvnAOb4WkDYGtMnU7mYOLiFar5IzP/lBIstCKklMU1zohdhqzQXGvIsGqyyTUa8Whd8g9lPGiwzxhGMdT5vAERSRQPcYMxe0B0gOEAjSJZ5zkzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028462; c=relaxed/simple;
	bh=Ro4AT1dy3+fn9DWFhz4fu0FRRDOujrJK2DSxFWLtzgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMGNc8O6A9yyBCdH+DJTedvKUyAge8VwHIgJRCgV7Q4jv8pMWmC/1wci0T6eI2h5Qh6l28NxzHrGHUoeYl92STVs7j9xDz3PmI6tJWRu+kcuLUKOvNweLzKE5dGobJIfKFlT3fpTFoXjjckhcQydxnKi0Jk8wmjo8ThJoySwEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 6FF871F00051
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:00:54 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id E3172A4702C; Tue, 19 Nov 2024 15:00:52 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 5D5C7A46FDB;
	Tue, 19 Nov 2024 15:00:51 +0000 (UTC)
Date: Tue, 19 Nov 2024 16:00:48 +0100
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
Message-ID: <ZzyoIABRArkGoZBn@collins>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRr05HQbsjo+d+pA"
Content-Disposition: inline
In-Reply-To: <20241119-prudent-jasmine-lizard-195cef@houat>


--nRr05HQbsjo+d+pA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

Le Tue 19 Nov 24, 15:43, Maxime Ripard a =C3=A9crit :
> On Tue, Nov 19, 2024 at 03:08:05PM +0100, Paul Kocialkowski wrote:
> > From: Paul Kocialkowski <contact@paulk.fr>
> >=20
> > The sunxi external interrupts (available from GPIO pins) come with a
> > built-in debouncing mechanism that cannot be disabled. It can be
> > configured to use either the low-frequency oscillator (32 KHz) or the
> > high-frequency oscillator (24 MHz), with a pre-scaler.
> >=20
> > The pinctrl code supports an input-debounce device-tree property to set
> > a specific debouncing period and choose which clock source is most
> > relevant. However the property is specified in microseconds, which is
> > longer than the minimal period achievable from the high-frequency
> > oscillator without a pre-scaler.
>=20
> That can be fixed by introducing a new property with a ns resolution.

Sure but my point here is rather about what should be default behavior.

The issue I had will remain unsolved by default even with a new property,
since people will still need to patch their device-tree to apply it.

> > When the property is missing, the reset configuration is kept, which
> > selects the low-frequency oscillator without pre-scaling. This severely
> > limits the possible interrupt periods that can be detected.
> >=20
> > Instead of keeping this default, use the minimal debouncing period from
> > the high-frequency oscillator without a pre-scaler to allow the largest
> > possible range of interrupt periods.
> >=20
> > This issue was encountered with a peripheral that generates active-low
> > interrupts for 1 us. No interrupt was detected with the default setup,
> > while it is now correctly detected with this change.
>=20
> I don't think it's wise. If the debouncing is kept as is, the worst case
> scenario is the one you had: a device doesn't work, you change it,
> everything works.

I think this worst-case scenario is very bad and not what people will
expect. In addition it is difficult to debug the issue without specific
knowledge about the SoC.

My use-case here was hooking up a sparkfun sensor board by the way,
not some very advanced corner-case.

> If we set it up as fast as it can however, then our risk becomes
> thousands of spurious interrupts, which is much more detrimental to the
> system.

Keep in mind that this only concerns external GPIO-based interrupts,
which have to be explicitely hooked to a device. If a device or circuit
does generate such spurious interrupts, I think it makes sense that it
would be reflected by default.

Also the notion of spurious interrupt is pretty vague. Having lots of
interrupts happening may be the desired behavior in many cases.

In any case I don't think it makes sense for the platform code to impose
what a reasonable period for interrupts is (especially with such a large
period as default). Some drivers also have mechanisms to detect spurious
interrupts based on their specific use case.

> And that's without accounting the fact that devices might have relied on
> that default for years

They definitely shouldn't have. This feels much closer to a bug, and relying
on a bug not being fixed is not a reasonable expectation.

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Specialist in multimedia, graphics and embedded hardware support with Linux.

--nRr05HQbsjo+d+pA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmc8qCAACgkQhP3B6o/u
lQyNqA//fhpdAVQqvylMo3Gk1qRhGxC1NmnJ/zDVaQLE/LckTaAdUDZ/pjbZrZW2
QKEsyYqTPGMtFLPcVOSEcgQqSFN66NF8VlgD87+nve80O9cLhK+aaTqs82+Llnvu
4TITELiMmX42AIBSyG4mRJwl65hC00gKLO8FjL27yFUpeOTcH9xwBlBugQCYuFkO
Z9kx+j8VOvEyHpPbAHKm8nxxFXO+Xvx08kTgId2+geSFA+xFRq7P+m3Ae+ua3MoU
2CmrZpoE0A0rGZgWhP0N/l20EiiBn2OSZYPpDZhtItHhkRbN5vZDsp6VXjtTUAVO
QRoG1yj+Kpto2TDc1qq6ZhoDug4nQNhjo9JTHUoGsLckxmfAoqbWNYxEYEAEPcd8
6K5HliuDSPlWdRh189E8QwP/GYXBB0MBm0fJIXS52K1KH5m2nCMSu2i1BFBld6U0
yM2kPU2CTrty+GFdA/QTwbA4IdOxLJMpO7qT0SNlsBDEno8Ce1vOxUbtduMLtz8/
wnKVgdOF2VCnhh8BALSWB8tNcLgsktgmzLHqc4Q86QKaSQkxd2oMX0HlQyDBTnox
cdvAPrO4Mj62BNvlxrmFFzwl9wtnuy33qhylxrDo/ZVnfQBUCQGjp+L0+oXYRM5C
rM7L73RZeCVAS10PxqpsBx6pSlwng2TGJ8m/OEmMWdTYFeKF0fc=
=s7ew
-----END PGP SIGNATURE-----

--nRr05HQbsjo+d+pA--

