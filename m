Return-Path: <linux-kernel+bounces-351313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F2990FCB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48BCB2DA61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0A1ADFF6;
	Fri,  4 Oct 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4AxrR7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C011ADFE7;
	Fri,  4 Oct 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069224; cv=none; b=c3FeOqjAEXcfoTM6Y1WvuyLk7B+IAYAee9OFXlJmwg/i8ZwRI+FX6V1bSpkTIxaHZWaVVLhknXKg7fwtk0vYbYVnvMKro2Fgphf2eYOOdfdEeuJ56kFxvF2VR1DDdjjD/jD5JE3KE8TcOxZ8AfLT8uJKJZtgDYCJPPXg7siXorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069224; c=relaxed/simple;
	bh=LO7IT7YT1qD7yM7AZD5y61ywl5y1t7QTlluAg+gpH6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoVD3FCnOWd13Ikaee6ah5XJ1g0ncKMvXVV4ZHKZuQrMulN65iCC7um3JycRMl1Bf/vOu1DrO+EFoga1SuJRrPs2uMVHX2k2MnEFvKZmJkqxEwABMdJZcslUbE4httIDHKee3nVGkamO05ARMZKv+xWdL+TsBeIbdFHZIqbP8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4AxrR7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C786BC4CEC6;
	Fri,  4 Oct 2024 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069223;
	bh=LO7IT7YT1qD7yM7AZD5y61ywl5y1t7QTlluAg+gpH6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4AxrR7iqWKCHfmYLaiYLbU/xQvHK4wZ83aSmDGQ7Zn80DJ7NTPhISoM5jxKTN7u5
	 tFxT9yZ0yQW+Q8tqwIUb4hSWbnUSespXXO5fI1jFl7TGljrRg4H91qqheql/2qCmcd
	 Towrz29qpcofP54F1gEZ0YM5iuknG0TElu7tLnrbU7zJi8OxKRezkCOBBz/G9I4D+Y
	 Wl2rPeGl1mn1Il6lzeYwUlKoeG+/yflZrMfW5Ed7+bxNRtHlRe0cCOc/Ve62rJHLF5
	 q07GPbmfhyOaScGz+4T+1/aMLVFHWSNia4WLPRsrfQHkKIeS+O539yTB36vkrLZNYg
	 HcPYFmAcYl8mw==
Date: Fri, 4 Oct 2024 20:13:38 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?KO+/vdC777+9KSDvv73vv73vv73Ose+/vSAo77+977+9x7vvv73NsO+/vQ==?=
	=?utf-8?B?77+90LDvv70p?= <ingyujang25@unist.ac.kr>
Cc: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sound: soc: uniphier: Handle regmap_write errors in
 aio_src_set_param()
Message-ID: <1fe9cb78-2412-47fd-a0b1-1d3a42385684@sirena.org.uk>
References: <SE1P216MB2287F4D575CFBDC9755E896BFD6A2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z8USiPpMzZodHO/3"
Content-Disposition: inline
In-Reply-To: <SE1P216MB2287F4D575CFBDC9755E896BFD6A2@SE1P216MB2287.KORP216.PROD.OUTLOOK.COM>
X-Cookie: A bachelor is an unaltared male.


--Z8USiPpMzZodHO/3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 09:15:18PM +0000, (=EF=BF=BD=D0=BB=EF=BF=BD) =EF=BF=
=BD=EF=BF=BD=EF=BF=BD=CE=B1=EF=BF=BD (=EF=BF=BD=EF=BF=BD=C7=BB=EF=BF=BD=CD=
=B0=EF=BF=BD=EF=BF=BD=D0=B0=EF=BF=BD) wrote:
> From 791716bf359b8540c519810848fd1f8006d7c3c5 Mon Sep 17 00:00:00 2001
> From: Ingyu Jang <ingyujang25@unist.ac.kr>
> Date: Thu, 26 Sep 2024 19:40:04 +0900
> Subject: [PATCH] sound: soc: uniphier: Handle regmap_write errors in
>  aio_src_set_param()

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Z8USiPpMzZodHO/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcAPmIACgkQJNaLcl1U
h9CViAf/e5GEbzMuPdV1VC3qzLJlu8BlGwAP2eFN0CsIpEOGlvD8UoyDbmG4tHhb
Hh50h1x8mEF9kLS8pnpP+z137DhTDy4LreUXSGyQywl3r1gn4anWTLzaDy8ed7+E
1xRO3IXBttz/FVt84rx8PPidcz87NYDpb4+oJmEYnwWdGj3Wf9ADeIJlqcf2c3Mz
dyQId5XyAJJ8Pf1RAi+TfAMV5wh7gjP5UmQ/tkcFuxSEdc9KqlcsBiYUimnRFaBh
Qwli+uvo8lelH6m2hj20GfgBt15jviaC3gvovs1odVw1VNakCay9Xsxa5b3rJ0Li
Fybnn7jTP7DNQYfDu3H03Mo2FEfM5A==
=eplN
-----END PGP SIGNATURE-----

--Z8USiPpMzZodHO/3--

