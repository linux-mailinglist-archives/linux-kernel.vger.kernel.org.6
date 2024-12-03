Return-Path: <linux-kernel+bounces-430307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2999E2EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5270E283467
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F413205AAF;
	Tue,  3 Dec 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+0TLJnD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03DD1F76AB;
	Tue,  3 Dec 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264538; cv=none; b=GdRYiJBTGezn4XJ451rvWCRyq/vVEk8AxWIYxKRnVk8Fsq2UMAP44RphrZNSvqiiFaLJwVfV1qJDrCdg/Cx2KK+dNyrIWhd9w9Aor8va0mCnCnbjhdpYFcHQ5X8JlB94/hZFxcWDniOr/k5xMUsIerOJ/ssoRhf0wz0kicB22U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264538; c=relaxed/simple;
	bh=I4I5URB1VDk2Y1ouDFGGvz2k1B/mzf5I2HU3r9wirFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrpGp/selQkOXxVMfZvthuN+Do+0gkSa3ij10+DIfZPMUvASyloR+LrSuXBg310cfxLzhPQ9gvdiSx3CMYcKiis1NVkVQwU3dkvzEaprmzumWGDAr+uxgX5KDxwOH1pd6mjoWQz54k3u2j9sDmylFA6K2SAg1PS/N+SOTTmu5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+0TLJnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE0C4CEDC;
	Tue,  3 Dec 2024 22:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733264538;
	bh=I4I5URB1VDk2Y1ouDFGGvz2k1B/mzf5I2HU3r9wirFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+0TLJnDkKrzWZbina+CPZi6zr4SVit9pG0xtWnrXDk4QmTcFivDkf0wO+2arI3Y7
	 hoemoVk7ZiDIxpWmfNvPuCMDTxE9z3BlkKXjEN3LdbjiuvdDvEXmYvnRzKU7n1gDod
	 WoruJ9jAJOYeswjKTqJb1P+DGrfTnDsSjxF2gRgPHlP6ld5A/6OMqhXxDsBFLXD6aW
	 B2GQ7EE1HlLPNXc68jkF5BpnqmC7C5pxk6ceGo3tiVK7jnFcNp8sYiH4jDo0OFz9LH
	 hPymnB02MeY+Zni0byi+EcOyd1x/2mbI6hkzioezqcaaSB3eYqSJVbNyV52S4kw6xq
	 Tj3k6twbaDOKQ==
Date: Tue, 3 Dec 2024 22:22:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Message-ID: <dbb2de3c-cb29-4384-a00b-4fdedeab1a10@sirena.org.uk>
References: <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
 <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
 <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
 <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
 <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
 <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
 <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
 <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org>
 <1jr06pkof6.fsf@starbuckisacylon.baylibre.com>
 <37b656cc8272552ba07c93c5a9a59641.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfsej6gT1fRj3j9O"
Content-Disposition: inline
In-Reply-To: <37b656cc8272552ba07c93c5a9a59641.sboyd@kernel.org>
X-Cookie: Alimony is the high cost of leaving.


--vfsej6gT1fRj3j9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2024 at 12:15:48PM -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2024-12-03 03:15:41)

> > I suspect the the generic path is likely to trigger more discussion.
> > I'd like to be able to finish this migration, instead of leaving half
> > finished like it is now.

> Is the half finished migration a problem for this cycle? I was intending
> to send the revert later this week and try again next cycle.

Yes, this patch was triggered by me reporting that multiple boards in my
test farm have completely broken audio with defconfig.  It's already a
bit frustrating that -rc1 isn't working.

--vfsej6gT1fRj3j9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPhIsACgkQJNaLcl1U
h9D5iwf9Eohzpz2Z+ckFVyYXe/jKUAU36yzwFRoX5x5CT8xFgFF/zSLLbkQWNNgF
K/DLUkdb79PXfoiVKTM27FkJii1vQ5eUXudtXuOKOtk3s9PEGlZzaES9ieUXT3+H
rC/OJt/eVnlCSw53POeJUYNatrK6TBzS/7ZrYhYrii4D98vNo/q9R9b1ixjPR+ud
U5u4fZW3VO++tdYzYJzYgAAcnKcO7AuZbaFthys9MbT5ROAzNmFQV63Uj1BpaV93
rryPmwII4t9zDAyPAdpxuSduClQxJmlYHAeemw8sZDY8ufD+ot00ZyMakd9jbL0/
AzeMVkapZCI0kPNbR1lc4bduobU/pw==
=veKX
-----END PGP SIGNATURE-----

--vfsej6gT1fRj3j9O--

