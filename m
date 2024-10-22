Return-Path: <linux-kernel+bounces-376304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C09AA2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF25B2341F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404D19DFA7;
	Tue, 22 Oct 2024 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBvi+bP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F219DF5F;
	Tue, 22 Oct 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603152; cv=none; b=uFoCxQhUg5U62astLMmkkJNzgiUJOWUR7vSaKFp06IcD2DzGKJlsyyp27r1rbSjUfyRBhuZq3X93kW+/LrY+lr5pYwHpGytpudv3niiVLa4SKKRL0E6aK9pUgmJzLzDShBzTO/qQt2KS7FLyXHmdr1rcnoOJCmbf5s5bBwWCteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603152; c=relaxed/simple;
	bh=7ESKou5zq9IymgraonECnbSiIZTp74/vzkwxutW5rZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad5pe1gCzfimf0aify93Av3795UchSZ/F53btNQvfr5Epv9g0L2Y/yxqmo6cptchiCyyU9e0yDx6EkdYDgjnGzHb5GFOUDiaA/BIKtF0wEs6g8qtmJ1LmYCmhnA84Yfu9dQaJKO0et/ve+LlyUEjgQbwB3ZQBp6WH0RzJSY5qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBvi+bP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27420C4CEC3;
	Tue, 22 Oct 2024 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729603152;
	bh=7ESKou5zq9IymgraonECnbSiIZTp74/vzkwxutW5rZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBvi+bP9EkC87XImGyMUF2UsV4sfqV1aqgOIrAVZYSr78doeF+HXqqZraYKRhLI5H
	 5O9szzhiKPLvRM/lriLYEbQGC3T+xx+VrFooqKvsPVWH7dOXFtb9oL9wESWXbAdC0n
	 OW2tStH4uO8vBDKHBt5r2qR918N8j18Nm1AmKGBpm8wnR21ymA/vSdteMH2gB7Mft6
	 rIHPym3R8KouaHUF69SNknDd/2s1MCjVoRqEqWUz6z7FSiHsALU9x0JsCeU6RutqEQ
	 bPq4mbGcuJSpajFEoNxE16rDigvI2ISE3x8+GukhJwSojk3WO/vigdG02Z5gQd7hdP
	 AJwFuTWyywOlA==
Date: Tue, 22 Oct 2024 14:19:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ca2ca07c-33c9-4d67-80b3-f8c506938ba5@sirena.org.uk>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <6dbbc85e-5a87-4605-8db6-92b191878d97@sirena.org.uk>
 <bae547a8-0a16-4173-9aa3-5c31e0a0b1e1@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F3L4+Uj0eovB8ftm"
Content-Disposition: inline
In-Reply-To: <bae547a8-0a16-4173-9aa3-5c31e0a0b1e1@leemhuis.info>
X-Cookie: Surprise due today.  Also the rent.


--F3L4+Uj0eovB8ftm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2024 at 11:10:36AM +0200, Thorsten Leemhuis wrote:

> I wonder if part of this is a "don't know how to do that" aka "lack of
> documentation" problem. I've recently seen some good guide or mailing
> list post how to bisect -next somewhere, but I think it wasn't in our
> Documentation/ directory. I need to search where that was (Mark, I might
> misremember, but wasn't it you who posted it somewhere?) and could work
> towards upstreaming that or some other guide. And don't worry, due to
> the different target audience it would be much shorter text than other
> documents I contributed. ;-)

I don't recall anything specific, though it's plausible I said something
in a thread that was basically just the bit about bisecting between
mainline<->pending-fixes<->-next rather than between -next versions.
You're right that we should have that in the documentation somewhere,
I'll look at sending a patch.

--F3L4+Uj0eovB8ftm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcXpksACgkQJNaLcl1U
h9BXAwf9HpeGav88rfe17V/DacJDvBA8PGtwWWcRTxpMwA4bNgZO8PlnS/yo87NU
jE0WVtixjtG8AvCTCL5I8ibuHuV61EnDgR2I5McK9KvoJvHqlDpmFfB21RGl3aBr
d63ey4Pn+JKp7MKGRxN6vhtY1QfrYYk5AzgRVPaYQBIdVGUx90WzmcpYXlRgPO4z
I/+Dw6kOYRp2G1kKnBllxwAO44WJFmfcsnm21O/qU3Jag0WhInqzO703kl1Tmfn2
9Q4WWt9BcHIWUGcsvS+o7UsI8pT8LwEZv8zxCvix/bLfsvDJKmwbS7lgqbD++4Tf
SeL2Yqxr2gQexQdn2NLNYTAoUyei2A==
=Gf0L
-----END PGP SIGNATURE-----

--F3L4+Uj0eovB8ftm--

