Return-Path: <linux-kernel+bounces-192296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5DC8D1B37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE94D28617A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A2916E86E;
	Tue, 28 May 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ7rKd1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE826F08A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899129; cv=none; b=KR3grBjnH2rppzLzOr62l+4GD+aEyp2nl7Ir0oT+C5oVezLlRNgtDWczCB1YilXC2EYj0GZhEjxDCP5CikrZvT1PUddHONSsO+nhaiDMmRXFbCV9ZX2BizqdJppEcbtIPmWNF3y7+pgcOFnOls6xOtTTDed3Wn++DVKMb1oSesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899129; c=relaxed/simple;
	bh=heYcbJtCEW+dq6j2wJP9WW+Gn4Vb87pce+x+lbqqQKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFN3/J802q293BQ9c+Tywrz9tNS8r/bxCbkJqYWXViCl0zfaYINs5vP9iu+8aUnyVGnndlgAxczVzrfxTnKWuy+K6yVQClW6jdPpQfuKbUqTFiMuq+MUOaHRk+8e099EcTsnnKeWPhhytvN+SpZPUMZM3NXRW9cBIAQqUxNHRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ7rKd1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC66C32782;
	Tue, 28 May 2024 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716899129;
	bh=heYcbJtCEW+dq6j2wJP9WW+Gn4Vb87pce+x+lbqqQKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZ7rKd1k4dCz/Sa41Ph5xrl6E4sbj315XRk+hkAw3idZVW87EXCus9is6fPfzGGe2
	 Cvdnxbiaj2+Qd8M9xgQwKOdk2Dkx3Kba7q0KIfJTrILRBiC251bWZZ+LWBCDdvBhkz
	 tBHPJZCHBwd3g1nNsWDQLcLBMOoRvwx5zteU4t6VubsMVG/CLI4Vswh6YbWmSWNOck
	 P7tSUAFhLiWpblMyVMCyvicPtMGwwC2Pz5Ctt+fIekrnSAJeFTL2twpRtDKGFoy6Ju
	 oWuVE33MdvJP8b/XI79yDl7qAbw2YrP3jBOAosbYilfPSxaeq4y9aRKRd5RJoxQGyx
	 d+JwE15djy2lg==
Date: Tue, 28 May 2024 13:25:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Alina Yu <alina_yu@richtek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rtq2208: remove unused
 rtq2208_regulator_ldo_ops
Message-ID: <70125571-5add-47d2-b127-c57e67c59df9@sirena.org.uk>
References: <20240528121222.3675312-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qv9XlwF2d5FsuGwk"
Content-Disposition: inline
In-Reply-To: <20240528121222.3675312-1-arnd@kernel.org>
X-Cookie: How do I get HOME?


--qv9XlwF2d5FsuGwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 02:12:13PM +0200, Arnd Bergmann wrote:

> I did not analyze the change to see if this is the only required change
> or if there should still have been a reference instead. Please review
> and confirm, or provide a different fix.

Fairly sure there should be a reference in _init_regulator_desc().

--qv9XlwF2d5FsuGwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZVzTQACgkQJNaLcl1U
h9Ac8wf/UX4kU00XKnRrYPAtd6PycUzmq8wb8gxkMMlwZgD5i1DFctc7wNrZXJHV
3hc7LtsgWzCkz1nZsf2w5zbUhA5XHe4CCqtDO3Kq9ANafFijR48qWnmu8/xsg8Pw
rMt6tlI1AOP6/fyXVBB95XZxMzzL5P9eGBT4/YCWnSYO+kZHPhYFD2rgH95pNepV
v13rh9RmClfy4qaJkXIbFOKX8vqJqJFb74XYb/f6/+FcTj2hoATMZyJTG/snproQ
xgzKXJQqAPyRh4r65xHA/1ps3IbgEbiIkPdKcr9GjFLC6ONOgfI2ZB4NEf9riE0A
lh0U+qwM7emivGNSpMEZh1s7Db9R5g==
=RnI0
-----END PGP SIGNATURE-----

--qv9XlwF2d5FsuGwk--

