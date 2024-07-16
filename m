Return-Path: <linux-kernel+bounces-253725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B206F9325F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BECF283E13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A2199E99;
	Tue, 16 Jul 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWXuIdi9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459417C64
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130873; cv=none; b=PLRZtwffd2aFGlStx6xtTkub+DNRDxX/MN/VjOG2nX402nqtYTY9Gcq6yQz6kMu9K5AptNgZG4b3Eig8ylAlPHjOFnXvK+r98vfFCzGAVjNkks6hKY3HPkgHj7spvj460R1TJ4L/0rg/6yejlGm9nc68vD4eGY/CRggRQqNERaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130873; c=relaxed/simple;
	bh=qd+8PcpS5VAT8ZcybLRAQKqwEquloGKZwObXuV5cLqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF9WzZ7wc5BMo1GfIjnK1aDyvFVInkj64w8KxTY8EL8/3/QftgvuTzcV/td69UpT360Xo02hux9eUd8sem9jr934+zjq2JhUEHEAS5Wsn+o+2eTfAj9UvJ1rSETCnvbMsDgmzWmu21QuD/NOLGy3rTDwJVqzOGIfHTZz9KaYKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWXuIdi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADECC116B1;
	Tue, 16 Jul 2024 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721130872;
	bh=qd+8PcpS5VAT8ZcybLRAQKqwEquloGKZwObXuV5cLqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWXuIdi9pjTuclV+NQXA4V5Hy/iRaTh0kKNmU1Q4igStMmQLU8mwhQbZjP1sIg1mn
	 lMXRaZsv6W9t3wf/sfLBWOmEPX86NTBCnY8046l66D0I/mLIxq98+l4Lqo19WaZXmD
	 HyaHf8sw2CUrLKX8yJcgBQ2+LDNVym63tNe7ZCLORX97L8cDB06mChI1IFObdXDesT
	 NR5SRXUZyPY8dJfVqsR0OHHYzAK1FH3p2s6vx3qvVFeqkaA/a3e24XEtevwOveV7S1
	 1Ub5ku3f7GOoj9Zvhbi4t93vj2YdlPwDKwX32owwyS30VD9PSE1wm24HNe+lLxwJoq
	 Lclt++Ehv/JzA==
Date: Tue, 16 Jul 2024 12:54:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] regulator updates for v6.11
Message-ID: <2fc61ef6-4c1d-4953-91db-aaf460be079b@sirena.org.uk>
References: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
 <CAHk-=wg03gdyDBv8ep-UmL=QdNr3278Oa21o93Eiysy8gDoJNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h/7NH+z9GK6MRxRE"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg03gdyDBv8ep-UmL=QdNr3278Oa21o93Eiysy8gDoJNw@mail.gmail.com>
X-Cookie: Think honk if you're a telepath.


--h/7NH+z9GK6MRxRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2024 at 06:15:27PM -0700, Linus Torvalds wrote:
> On Mon, 15 Jul 2024 at 07:15, Mark Brown <broonie@kernel.org> wrote:

> >  - Support for Mediaktek MT6312, Qualcomm QCA6390 and WCN7850, Renesas
> >    RZ/G2L USB VBUS regulator and ST Microelectronics STM32MP13.

> Grr. My arm64 testing shows that this is

>     default ARCH_RZG2L

> and turns on automatically, which might make sense if ARCH_RZG2L was
> some kind of "I'm building for this platform".

Yes, I've actually got a fix queued for this already which came in
before you pulled that which moves the default away from the arch
setting.

--h/7NH+z9GK6MRxRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaWX3QACgkQJNaLcl1U
h9C/CAf/e+2zZRQJ3+gIpZVD+Pw4lef3Oi3AQ1Diz6QRJPou13G+55qO5g1uHCY6
EqeC9lypZ0rYBnGuqKp7Op6bLVwpIg2R9nmChqLkuR/8c8QmQBpL9HWRnwWOVf+v
wAfF9ZbpculEUB8j6/zS2kllN2PoD6ou/ZV5L65FaG2BWmR5CNEM5zSlUjAp6vFj
HD50KisdD2zptq+uRIBeaAZOY2i/ThST/QkYZTX9Du1TnVOFRqq9Uz6Eh0kGkY58
wYTOb5LQd0OaAyxJvAxmmcD7K6sa7pICqUNhkO+9zPV+JI/b5K7mAh5G7FNk6pJ6
U+3uc/D6UiapjZWI8EhUIinO/s3+PA==
=ascN
-----END PGP SIGNATURE-----

--h/7NH+z9GK6MRxRE--

