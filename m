Return-Path: <linux-kernel+bounces-295540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC72959CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CBE281146
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E3B19993D;
	Wed, 21 Aug 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boyooSjB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79338192D7E;
	Wed, 21 Aug 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244993; cv=none; b=V7GAUmE5t5I3Vj9uU/MdutagPCnTGLyyp+FX8h7KnZg7UlA7BVt8g30RjgWISmf5vhfieBTLZY11QFAnPwK3c3ON0FXHnnQM0vlyYritevntNzRNtRitKwF480kbo/KHFn593HziZFqAJJLHrqQKw9uyn84rk0Fth/c3DC3rYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244993; c=relaxed/simple;
	bh=ypfaOaBLZUMjAJ1CWK0w2rd0JWS3swLCqOotou5s5+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQcFs9lm8+VQihAOedKQfAFGGDmH3IWDelDc1M3qz2i3drBU4IcNjxZGuRqpV5zrfYIn90oEsKolT1IKpu5vguA4Yx3rJ4dr+9OBN4vO0TNcTR47SJ9w25rp8a7d47q9FuZcuUKn7/EBFnRWY3dlmbAxLEKJfB2BrbpFuVzaiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boyooSjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6779C32782;
	Wed, 21 Aug 2024 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724244991;
	bh=ypfaOaBLZUMjAJ1CWK0w2rd0JWS3swLCqOotou5s5+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boyooSjBdT3C71LRr/6rjW2PRqnnNgBO45F2oCvHBrtJJ76OiWJ0DJN++zptZDwMZ
	 kOivnp0sbHCGX3X3POoV4KYFs+WpGoJh3uCxS8j6wklR4Ve5f9m87rfgAMAtqhWn/Y
	 89ezK/KJFQxmwDjj0sWNfVPS4CDemJFkQYECl2ZQdxdaPmcM6pPXtupdyzzLSXn9dO
	 MaTm7ftKXqvPTvuJWX5LARJxEli7gW9kLaAinr0pIQqivrgth9P16332VgIos1r+Vk
	 bDHjLYVMwWCoExbXYiXRax7iMed4eVQDkz+A69bj5F+oxaqRAmAkEosjd0djwVw7cj
	 lxhEvM7eVsRAA==
Date: Wed, 21 Aug 2024 13:56:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: dapm-graph: add component on/off and route
 names to graph
Message-ID: <f7c03710-161e-465c-b480-7b599c78a51d@sirena.org.uk>
References: <20240607-dapm-graph-v1-0-bb302970d055@bootlin.com>
 <20240820184406.6ff2654e@booty>
 <c4e2580f-1675-48b0-b59f-a076eced7675@sirena.org.uk>
 <20240821101748.41799c5a@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pC3SrSxH0gEvAY1w"
Content-Disposition: inline
In-Reply-To: <20240821101748.41799c5a@booty>
X-Cookie: You are false data.


--pC3SrSxH0gEvAY1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:17:48AM +0200, Luca Ceresoli wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so=
=20
> > on so unless there is some reason for urgency (like critical bug fixes)
> > please allow at least a couple of weeks for review.  If there have been
> > review comments then people may be waiting for those to be addressed.

> I'm sorry about the noise. I thought it was worth in this case because:

>  * this series has been sent 2.5 months ago
>  * there was no reply at all
>  * AFAIK and according to MAINTAINERS there is no patchwork catching
>    tools/sound/

> So it was looking much more like something gone into oblivion than
> being on someone's TODO list.

That would be the resend part of the mail - content free pings can't be
directly acted on, they're just noise.  Note also that you should
generally rebase and resend things after the merge window.

> After doing so now however, I must say that while counting the resends
> is easy, counting the pings in a somewhat reliable way is very time
> consuming. It would be nice to have this info in a more reachable way
> (MAINTAINERS?).

Feel free to take that up with the MAINTAINERS people.  It's hard to
specify things in a snappy one liner kind of way.

--pC3SrSxH0gEvAY1w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbF4/oACgkQJNaLcl1U
h9DjTQf+P9yJmRD8OMMrumB1nl0Tywv0Owh1/m1wrvD1w5fhBx/gYMdlHydsk2Zb
5OFeG1AWDBhM2zH6QXWCKFrmJIu+pyfik4x6Bb3WtbGRhn3VYkzfvTuoei4khb+W
MJSSKtjYjWfBPIZK3F7Wxykayi7ASfctgNI18PJWCWRL6RLszUfIjdxBsLBEAb/t
7I1xk042hgKFhbYbDYwTucazewhhdYylH3c/qE61suzNeC2HwOofsXq0jjrt3/wS
cziKXzK29ths731OxT5zemnkSqH5puSdZo6ejsgL81/H48yeOL7hQJuElpe+UG0L
/tDCbCxaSlsDCQ9V6ikuzZTpzsZ0Xg==
=xOm6
-----END PGP SIGNATURE-----

--pC3SrSxH0gEvAY1w--

