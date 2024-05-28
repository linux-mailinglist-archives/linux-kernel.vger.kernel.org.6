Return-Path: <linux-kernel+bounces-192361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2168D1C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D97287718
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE4C16F838;
	Tue, 28 May 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMyk3/ER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F717E8F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901410; cv=none; b=URLUCD1AFD5a82KQyIcsNcGlUyk1nSS+FgeSK6OKQ9mBMWAAN1IxBlq6SmPqeTMbW0nMn4Q1DH1O9nMHUTlDLLns9ZEBj7g5oSH/Xicwvaem7rX2ZvHp+vhJ//k9/vpfAK1TvCX5Lu4gh5+EWeciiqPspFfuIY9o803NGDF+Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901410; c=relaxed/simple;
	bh=9v4W6iOSUjtGZaBCccF+kLlyiZYLVuG5P+57Ga/1odQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9Qh+QceAY/HRmBqaT0xCo3XOxweTrIUWxxd+fTc3pB5At+uLIoki5U1meFsnVZE3zSR/2vx+3kpw0Bxu0Rxq1pHxI6lUr+cGj3kvTM2H/Pzu4raIdYiSOHH9wwCJOInB9KgM7a7b5f6EnvtSF2NNfnsSoepENgOwqc2LqhzyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMyk3/ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B9AC32782;
	Tue, 28 May 2024 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901410;
	bh=9v4W6iOSUjtGZaBCccF+kLlyiZYLVuG5P+57Ga/1odQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMyk3/ERiSHEgU0VZs0WGbWEaoNlPMX74d/mMZrBLgxcpB5wc3XcMtwFiVJZW5fh+
	 f7gNDIEwQ2B1kRoJR8DW7p0QhwmZ8pBVSozHTprp2fXNLJQTKQOJNzLACaPaasV7fh
	 B8dzEQoypqqE5+utX+o5HgQySc8TuJPsuPNdojl978DYs9TpUbL3XWyUYVq0+uAwgl
	 ulIyR4if5KcWn8FeWFjzKbBGGQt0q2x3HHIXA6GCyOWV/hje+JQL7E1b2RT3p2dAcz
	 uvc2dv/kTKgcIDR9O193xpTFduVJyWzXOZj6rLUW9xRgXyqAe4iSvHi9FfbAMheO8x
	 p6TRHUIIUeuPQ==
Date: Tue, 28 May 2024 14:03:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Alina Yu <alina_yu@richtek.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rtq2208: remove unused
 rtq2208_regulator_ldo_ops
Message-ID: <56b9bccf-b9fc-494a-97f1-40b5bb0f6767@sirena.org.uk>
References: <20240528121222.3675312-1-arnd@kernel.org>
 <70125571-5add-47d2-b127-c57e67c59df9@sirena.org.uk>
 <7391d6a4-0c0b-456f-a2ca-cf3dafa67c5a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nULyeNePWk0eNBQy"
Content-Disposition: inline
In-Reply-To: <7391d6a4-0c0b-456f-a2ca-cf3dafa67c5a@app.fastmail.com>
X-Cookie: How do I get HOME?


--nULyeNePWk0eNBQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 02:38:30PM +0200, Arnd Bergmann wrote:
> On Tue, May 28, 2024, at 14:25, Mark Brown wrote:

> > Fairly sure there should be a reference in _init_regulator_desc().

> This is how 38bcec0e7cbb ("regulator: rtq2208: Fix
> LDO discharge register and add vsel setting")] changed
> the lines:

In fact there's a series in flight which adds support for fixed voltage
mode and fixes this, though we'll need a separate fix for v6.10.

--nULyeNePWk0eNBQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZV1h0ACgkQJNaLcl1U
h9BkWAf+JPFSscJ/OSF/r2NYE1MrG5Kkyepxht/TlcWy01ETWuAU4oKScrCcZREj
KP7Oyf0KzVp+x8ZfS7KNA25gcIvfuJ8bKWT7FoCbgrIu02LsrZhvTCyiQeO1nSKb
7wMORHV0qSzW85zngupDxGFr6/J9YxWfhadELkAEXWuGOSDt5XDQZymxbVeIbWTk
yZGOri9kaX8+lntjx9ng8A8B0jmAGKA8ZHhe0NmWz3fIeTbPJej+HlcqPZHh/kOw
sw6YeSY+pkCXz8GFrFNvPQAiVwKNPkOE+eqZ2LPVJR21PnHHI692OKHdlx+NqjCQ
hqiQ+yPzO2BUkmJLBX9mWMAeOLa05w==
=kfwu
-----END PGP SIGNATURE-----

--nULyeNePWk0eNBQy--

