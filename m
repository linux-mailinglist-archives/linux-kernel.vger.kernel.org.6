Return-Path: <linux-kernel+bounces-425726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D9B9DE9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D59BB24895
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074014A60F;
	Fri, 29 Nov 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5DSdd69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1C145A17;
	Fri, 29 Nov 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894664; cv=none; b=O//bb0Huf9uesWZezlTvsO3fAYOwNCJKCpJzTtX1gvqPhMHST1qvrxCgphNALffRkMKcttWcnJNiYf3xCVsH5DYb3GvLya4mYHGZDI2SnHGViLu9xteFbhFrbtURaPRxUZ+XH/ODTdZxfiGqEKLyDMvJKqMCmPwhmmeRY6jOdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894664; c=relaxed/simple;
	bh=B8ZduSCXx+T9t862mFfTVamD3ZvIyVqH4xZpWXNHI8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNIPIbQVCw4IL8AQ+Xw9jX+qi2taTR5mWuh2daZZzjTvkUY4AOhymQ/XMWblimCXhDIQCaSZ1OcVLvdhCyggtZ1Sze8iYsCHlPBH7e6WNrQGeXD8Y19YKhasSkKmsepFrlHWbbIVqLaZITOvaHxWIk5EI69+KbSciFIuneW4/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5DSdd69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D866C4CECF;
	Fri, 29 Nov 2024 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732894663;
	bh=B8ZduSCXx+T9t862mFfTVamD3ZvIyVqH4xZpWXNHI8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5DSdd69wrziYSI7Y481XqxoGe44LO/arqKa2tz4/uZFMGslQMfwZC1ZLUPGewepR
	 emsKb9hU+gqOKFa7psWcnFDLQVKphFIyFeKdAY1ybWodFsP4U0GB7i2v7r4H7Sm/hn
	 hxv1gNulM2xM523moMfb5WFLHD5NppVHUiSjGUdwPPgI9+6xcRhr/vleHLxOhGXbF6
	 P35JKxGiDY0elKcnuplnPDyikTsOgnAtNls3+myOBdRYrcFXC8/A/g5NSO21gHJDBL
	 gFXSGPOwQ80eRItrGdyeE++p/V1Y1cJ6j8kRzFzxgqK/teDjw4rXLM3J4E2hi7abtR
	 /fbSizfWvVL5Q==
Date: Fri, 29 Nov 2024 16:37:41 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <20241129-amazing-whale-of-proficiency-ee6fd2@houat>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
 <ZzzdT0wr0u1ApVgV@collins>
 <20241120-wild-stimulating-prawn-ffefb7@houat>
 <Zz20dquzl5_2_3TQ@collins>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4fudffiqskytk6s2"
Content-Disposition: inline
In-Reply-To: <Zz20dquzl5_2_3TQ@collins>


--4fudffiqskytk6s2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
MIME-Version: 1.0

On Wed, Nov 20, 2024 at 11:05:42AM +0100, Paul Kocialkowski wrote:
> Le Wed 20 Nov 24, 09:01, Maxime Ripard a =E9crit :
> > > > If anything, the status quo doesn't impose anything, it just rolls =
with
> > > > the hardware default. Yours would impose one though.
> > >=20
> > > The result is that it puts a strong limitation and breaks many use ca=
ses by
> > > default. I don't think we have to accept whatever register default wa=
s chosen
> > > by hardware engineers as the most sensible default choice and pretend=
 that this
> > > is not a policy decision.
> >=20
> > You're making it much worse than it is. It doesn't "break many use
> > cases" it broke one, by default, with a supported way to unbreak it, in
> > 12 years.
>=20
> I think this is exaggerated. Like I mentioned previously there are *many*
> situations that are not covered by the default.

Note that this statement would be true for any default. The current, the
one you suggest, or any other really. The fact that we have a way to
override it is an acknowledgement that it's not a one size fits all
situation.

> The fact that I'm the first person to bring it up in 12 years doesn't
> change that.

Sure. It does however hint that it seems like it's a sane enough
default.

> Sofar the downside you brought up boils down to: badly-designed
> hardware may have relied on this mechanism to avoid interrupt storms
> that could prevent the system from booting.

It's not about good or bad design. Buttons bounce, HPD signals bounce,
it's just the world we live in.

But let me rephrase if my main objection wasn't clear enough: you want
to introduce an ABI breaking change. With the possibility of breaking
devices that have worked fine so far. That's not ok.

Maxime

--4fudffiqskytk6s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0nfxAAKCRAnX84Zoj2+
dk7LAYDGqN4+FFKYNkVeh8uBncZUXNq1+3hQGCVKth0yfd3qHhn9VImj9CLuhxpe
0uuZEIkBf18IaV+JYJMvpW2AWpLOCDfVa5A+SLz6MGRXBt8mhAfrxGWV/K10P8XN
7auTbJcbqA==
=P+2t
-----END PGP SIGNATURE-----

--4fudffiqskytk6s2--

