Return-Path: <linux-kernel+bounces-177773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71948C447A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2456E1C22E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640115442B;
	Mon, 13 May 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQq0r5sP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D75695;
	Mon, 13 May 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614967; cv=none; b=DhbGmzSoS9NKLhX2Dvencd5b//83vsweUW7NZ9nUzfEPSo6KHW8qLhlxhNCsRKXYYcQzMtWdh7cQ4oM3outUmZAVuY/l6p9zX9WmgDa5Uii0FP37nlZx0PzbXxdwIfW6+Svm4xBDA+JCSSvEpLMW58ovMadpMS+V1YJ71gOAsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614967; c=relaxed/simple;
	bh=F3u3mKadL+3EZX5zWP3ezeTiqNbAGqyfcxAJ3U4RsoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMeW0CE5ATJNTZtdJlNqI8iLQbO8ja4Ve+89EW6PgWCA4X1BBdO/6L4bGSsQQToyJVVlxoL1x++N8nbB1QMwt+YwZyGemtjlesdXhuaQTm4gpm7u6gi1aSvbD3t/GwcAdIRTcfyxQEgEFo9qIz3aeEbg4W4tPNy5u933zts0IFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQq0r5sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A22C32786;
	Mon, 13 May 2024 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715614966;
	bh=F3u3mKadL+3EZX5zWP3ezeTiqNbAGqyfcxAJ3U4RsoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQq0r5sPRu78vdVdG+L7slIqkDQjf6Glz1m5xloulimbwvyaf331+Ts9RCGWXWy52
	 V5vY3mLQKoDMBoynd61Q9m1bcEHA3vkD0gLfksydJ0E8t3+F1YYcYKXiAZuP5L7kVa
	 v/5vfwkbYqYujFK0vsdNj+99Rp8YfMc0G38VhSQJnDLeLrnwLQvT1r5r1kya6YbuN0
	 PhYnKGz+dJ1DeDeOj4mvpmJKE8YypTO1AL3rYJZZ6XJiYymY5qDge1FiOXpazziSgT
	 U+ezmPVVPiXunoqCLxG0MOEuPSUwmxAfrJidFr/5CZ+rdd+SPsDj4uIv0sGa5N0NRN
	 E4d0RuCySxi5w==
Date: Mon, 13 May 2024 16:42:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, neil.armstrong@linaro.org,
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
	kernel@sberdevices.ru, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240513-capsule-sadness-4d387baf2bed@spud>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-3-ddrokosov@salutedevices.com>
 <20240511-secret-barcode-e25c722ddf1d@spud>
 <1jjzjxzy4d.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RbuUotNKYzyDBfFf"
Content-Disposition: inline
In-Reply-To: <1jjzjxzy4d.fsf@starbuckisacylon.baylibre.com>


--RbuUotNKYzyDBfFf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 02:04:41PM +0200, Jerome Brunet wrote:
>=20
> On Sat 11 May 2024 at 14:08, Conor Dooley <conor@kernel.org> wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > On Fri, May 10, 2024 at 12:08:54PM +0300, Dmitry Rokosov wrote:
> >> The 'syspll' PLL is a general-purpose PLL designed specifically for the
> >> CPU clock. It is capable of producing output frequencies within the
> >> range of 768MHz to 1536MHz.
> >>=20
> >> The clock source sys_pll_div16, being one of the GEN clock parents,
> >> plays a crucial role and cannot be tagged as "optional". Unfortunately,
> >> it was not implemented earlier due to the cpu clock ctrl driver's
> >> pending status on the TODO list.
> >
> > It's fine to not mark it optional in the binding, but it should be
> > optional in the driver as otherwise backwards compatibility will be
> > broken. Given this is an integral clock driver, sounds like it would
> > quite likely break booting on these devices if the driver doesn't treat
> > syspll_in as optional.
> > A lesson perhaps in describing the hardware entirely, even if the
> > drivers don't make use of all the information yet?
>=20
> That is nice but it is only possible if/when we have perfect knowledge
> of the HW being implemented. I don't know about you, but I rarely get
> perfect documentation for HW, let alone a public one.
>=20
> Those things are bound to happen as we implement support for the HW and
> discover how it works, not to mention the mistakes humans will
> inevitably do. If Linux was only supporting perfectly documented HW, it
> would not be supporting much of them I suspect.

I mean, you can say what you want chief about what you did or didn't
know, but there's a line in one of the drivers that was added back when
the original driver was that talks about the missing clock, so you can't
really act as if there was no knowledge about it. If it hadn't been
previously known about and TODO-listed, I would not have made these
comments.

> Stable API is already hard with ioctl but there, both sides are
> perfectly known. That is a fundamental difference with the 'DT ABI'
>=20
> Getting it right on day 1, every time

Wind your neck in, I don't expect you (or anyone else) to get it right
on "day 1, every time". I only expect it to be dealt with in a way that
is compatible with the existing devicetree.

Thanks,
Conor.

> - because things are set in stone
> afterwards - is unrealistic. As a maintainer, I do spend a
> disproportionate amount of time checking the bindings submission because
> I know how painful it gets to fix things up down the line.
>=20
> Unless I missed the simple solution to this problem, we can expect the
> problem keep happening again and again, no matter the number of lessons
> learned.


--RbuUotNKYzyDBfFf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI08QAKCRB4tDGHoIJi
0jSxAQC8QxVuGHYq7syN68cgLxp136YiQh2236yQnHQf+MYYrgEAzT7ENp3HENlz
kbYC+C95klbNPHlpS4gAQN2AoaUk4AM=
=84uz
-----END PGP SIGNATURE-----

--RbuUotNKYzyDBfFf--

