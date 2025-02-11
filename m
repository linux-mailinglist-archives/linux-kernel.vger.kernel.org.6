Return-Path: <linux-kernel+bounces-510134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFFA3189E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE792168981
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0C0268FE7;
	Tue, 11 Feb 2025 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY0DPekn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A061DDC14;
	Tue, 11 Feb 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313082; cv=none; b=eFAEzqQdFapviHaqnpW5AAtgyuLJwZSMAP4W0L5SxxkKsPcoXD35Ig8H2P9nrTpRk2GjOGDHWG87Wln9DBbmjiw21KdGq8x3jrDKZi6u2OQlxrEQnF+xnGYle+0yWs3YY4ktAcH86fThUgB7B1WUzRwPV1nypXy+197jekIlBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313082; c=relaxed/simple;
	bh=oKiytre//4VdWD8ww4w5uW85mMA9TzV2kpcRlAyNNLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC/W+kMvH75QDt2fXUtn7WTdi7PvGYtAObP/dpTtvEWeVJoL0OKt/ayqnRl8HrNEvaKjfVaf6gIu+iHXrknA63U1LPUaBhrXZpYQdxUsBrllEC2fYP146XVaeTs8zoNlsI4fQqnicUaev74twzESlDzzimRtd/YqP9ohy2zk8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY0DPekn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFB1C4CEDD;
	Tue, 11 Feb 2025 22:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739313081;
	bh=oKiytre//4VdWD8ww4w5uW85mMA9TzV2kpcRlAyNNLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YY0DPeknXpkCAAXSI/htfS+mSF4sQokI5EXqV26pE0Iiz3gWGhUcsu/Sl0AoqKAba
	 o2eMhE0iKTOth9xArDpXJaNhj3z6uPjHgwxl05oTMjZ5Cf3gxbtCo3/FMmG+kI8jwJ
	 ltLNGMdGV7/JWngxIjQSB8qzLlYlGfWqjtzYNHlgKVMHg2SmGIw/kCMeVgTvvhwUsN
	 BCC7YBZP1oV/RpxEieng1tfx44s7eUjwVJzZaQk7mBNByXnn/bJqcorcaH0gMsuhiV
	 eecy8beIZkmC68h62ApUK0Ldk46fbbDAXuN2Q8y+NsNmbHN9yD6T82EC6I/YLJNj1c
	 rldcDOK2FCMYA==
Date: Tue, 11 Feb 2025 22:31:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <d42f6600-4233-4438-9636-d2892f3d11c1@sirena.org.uk>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-4-francesco@dolcini.it>
 <20250211221904.GA1270109-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AS7+IzE+cm9e530p"
Content-Disposition: inline
In-Reply-To: <20250211221904.GA1270109-robh@kernel.org>
X-Cookie: Printed on recycled paper.


--AS7+IzE+cm9e530p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2025 at 04:19:04PM -0600, Rob Herring wrote:
> On Thu, Feb 06, 2025 at 05:31:50PM +0100, Francesco Dolcini wrote:

> > +  wlf,retune-mobile-cfg-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description:
> > +      List of strings for the available retune modes.
> > +      If absent, retune is disabled.

> Is there no defined set of names?

No, this set of names is for system integrator specified tunings so they
can make up whatever is appropriate for their system and use cases (or
otherwise amuses them).  The names will end up getting exposed directly
to userspace as options that can be selected at runtime.

--AS7+IzE+cm9e530p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmerz7IACgkQJNaLcl1U
h9CJ/Qf/e19uP4duTkk/90jausJYsKrWocRj+OfkBnGKJcpqBYoYbYAL93oFPaq1
ldCKokt7jBx3WlAFR9SmxZkRUi4V0HgwyiD4mVdkpyWQyxP/E4XCT+vM5Su98K6l
71gTIc5LUO3E3FABIulpIKiVzAHO0T3B+d8pTN9ebAjP80tSRrFJjDOsCJwSNSSh
KAInIVy9XhAaHVNtVJGEuM0j/AgLR3Ny1vm/0tzpKR2tvPGQz1y4WXYB4ikuIqIV
m2a49nrOUSw4Zje3er7HsbKDBnjVulrjMXVSF1Mc+dZJmJCw2GDtDPLDh/GzH4bG
o5Le8tlk3/qzTcci/yUk6zNUtpba1g==
=kP6n
-----END PGP SIGNATURE-----

--AS7+IzE+cm9e530p--

