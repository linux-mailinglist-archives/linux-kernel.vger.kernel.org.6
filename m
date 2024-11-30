Return-Path: <linux-kernel+bounces-426181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3F9DEFF1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8950163415
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81515665D;
	Sat, 30 Nov 2024 10:34:32 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F528EA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732962872; cv=none; b=WE516Ok0W7c0SYktetWbNmalNaRK/FPbWx6ArPQL7S5It4+c2tf1mjqUQX5qWZIpKF02gJZXRrE9X+7vYa1wU7H4tHwfUaayOlWaDjzm/qiHdBr4pcRW6skKGY10PpTo+5m1uKsqjjhQ91w7pbChUHK9vagSTR+UXshCuyJeQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732962872; c=relaxed/simple;
	bh=JSBJ1/bWK3QTp/vHaELpNZ0W7lJSYrSIVr3oxkKdc+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCOkTqiP5S9eA+qKi85HHHgNg853VS3mGvYePbMhplC4Cdyh/SqdD6xdYZTpRCzow/YSfUIG1rZEfQGwBnj+QBHmbiCxUtz0/K+2goAGSnLlTIhLOnRryLOMs3fWpNLfBMbq9Y1K9RUikDCD6fekuzzP4ciGRBh4HsNvRvXAIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 2CE631F00053
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:34:14 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id C8903A48CA7; Sat, 30 Nov 2024 10:34:12 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 71B76A48C9A;
	Sat, 30 Nov 2024 10:34:10 +0000 (UTC)
Date: Sat, 30 Nov 2024 11:34:08 +0100
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
Message-ID: <Z0rqILFESdje9qUn@collins>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
 <ZzzdT0wr0u1ApVgV@collins>
 <20241120-wild-stimulating-prawn-ffefb7@houat>
 <Zz20dquzl5_2_3TQ@collins>
 <20241129-amazing-whale-of-proficiency-ee6fd2@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnBcvG6sakiQSko5"
Content-Disposition: inline
In-Reply-To: <20241129-amazing-whale-of-proficiency-ee6fd2@houat>


--RnBcvG6sakiQSko5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

Le Fri 29 Nov 24, 16:37, Maxime Ripard a =C3=A9crit :
> On Wed, Nov 20, 2024 at 11:05:42AM +0100, Paul Kocialkowski wrote:
> > Le Wed 20 Nov 24, 09:01, Maxime Ripard a =C3=A9crit :
> > > > > If anything, the status quo doesn't impose anything, it just roll=
s with
> > > > > the hardware default. Yours would impose one though.
> > > >=20
> > > > The result is that it puts a strong limitation and breaks many use =
cases by
> > > > default. I don't think we have to accept whatever register default =
was chosen
> > > > by hardware engineers as the most sensible default choice and prete=
nd that this
> > > > is not a policy decision.
> > >=20
> > > You're making it much worse than it is. It doesn't "break many use
> > > cases" it broke one, by default, with a supported way to unbreak it, =
in
> > > 12 years.
> >=20
> > I think this is exaggerated. Like I mentioned previously there are *man=
y*
> > situations that are not covered by the default.
>=20
> Note that this statement would be true for any default. The current, the
> one you suggest, or any other really. The fact that we have a way to
> override it is an acknowledgement that it's not a one size fits all
> situation.

Again the debate is about which option has the best advantages over
disadvantages. I'm not saying the default I suggest has no issues, but
rather that the benefits very clearly outweight the issues. Hence the many
situations that would be supported with the shortest debouncing period (both
short and frequent interrupts) versus the few broken-hardware use-cases
(related to interrupt storms) support with the largest period.

> > The fact that I'm the first person to bring it up in 12 years doesn't
> > change that.
>=20
> Sure. It does however hint that it seems like it's a sane enough
> default.

Or maybe people didn't realize this mechanism existed, failed to understand
why their device didn't work with Allwinner platforms and just moved on to
use something else. Indeed it's all very subjective interpretation.

> > Sofar the downside you brought up boils down to: badly-designed
> > hardware may have relied on this mechanism to avoid interrupt storms
> > that could prevent the system from booting.
>=20
> It's not about good or bad design. Buttons bounce, HPD signals bounce,
> it's just the world we live in.

Well I'm an electrical engineer and the first thing we were told about
buttons and connectors is to include hardware debouncing. The second thing
is that it can be done in software (which again is done in a number of driv=
ers)
by just disabling the interrupt for a while if it happens too often.

So I'm quite affirmative that taking none of these into account is constitu=
tive
of a broken hardware design. No electrical engineer is told that they shoul=
dn't
care about this because the SoC will filter interrupts for them.

Of course it's fine to use this mechanism when it exists, but it's not a
reasonable expectation to just assume it will always be there. This is why
I think it's not a legitimate reason to make it a default.

> But let me rephrase if my main objection wasn't clear enough: you want
> to introduce an ABI breaking change. With the possibility of breaking
> devices that have worked fine so far. That's not ok.

I believe it is highly questionable that this constitutes ABI breakage.
To me there was no defined behavior in the first place, since the debouncing
configuration is inherited either from the reset value or the boot stage.
There is also no formal indication of what the default is, anywhere.

Changing the default configuration of hardware is commonplace. One might
for example introduce a reset to a driver to get a clean state because it
happened that some boot software would mess it up and it went unnoticed for
a while. Would you also call that ABI breakage?

I think there's a number of situations where it's much more sensible to cha=
nge
a default state to avoid very visible and practical issues. And it does hap=
pen.

Also my understanding of the "ABI breakage" rule in the kernel is that no
userspace program should stop working when it was implemented to (correctly)
follow some kernel-related ABI. It doesn't mean that we cannot change any
default state, or that everything the kernel does should remain exactly the
same ad vitam.

Sometimes it just makes a lot more sense to have these fine adjustments.

And honestly I would be extremely surprised that this specific change resul=
ted
in any actual system breakage, as we can be hopeful that electrical enginee=
rs
did their jobs correctly.

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--RnBcvG6sakiQSko5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmdK6iAACgkQhP3B6o/u
lQwY+A/+Mx6lAA29BKNESENc/7aLP1mUgozB0ZAEC61WoFp3E5lgJlLXRZ6BskT6
rMLusd9qkkVUgfpa7traa32fZDrt6QL34VEbgV19bAQIhNkr+XScVSyhTrEd0kQG
tqf1ODSXBXfZCnqXKHaKuKnuFygsdmsHynTRUyflzKqYykio+gR2ntduhbQvmWSy
8CASUfSXxO/n5VkzOM28S67qjqHV/9JunCB6r80RkX/4hzkknaitTqy9qG4Hz5Qw
B+oiWIBmxaxsAfOd8Lf6YVf+VmC7lrh2IcL6/KNP+MiV8J9htXhstEHLnPEVYRU3
pFG8aZrOhB1NCIOUCZ9yl/kpcwbbGLqF6+pctXKYswvu3GttuGACYTAZHu+a+qqE
pF+gV9hG3P1rGENDpPQ//Iah5voiOvTJ2BsPuCcJPhYXX0SpisytclKAKzDDm/Hq
fZKkgJ9wixVsLvWmmVTMXq64OSd+R6wW4q5qVmjtn2DnXOMDyEj95lkF7vciK5Zl
sy4U960Rd/tuQkKUowsVQQifBYEuw4vMi5lFEGfp0Uy82dSYGMh6p1VCPsSCGakL
Cf6zb6Qb2r/863yairjGeunDwBVwF+HtuVo1P+kqpY42p2YIM1JECgrBzIkoesVv
T5XafEnKFegBGGQ8QRaSLsanf1ALjbrrQwEpeyJOAXPghByRrXA=
=Uc2g
-----END PGP SIGNATURE-----

--RnBcvG6sakiQSko5--

