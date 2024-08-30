Return-Path: <linux-kernel+bounces-309049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F9966587
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994201C22A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1C1BD50B;
	Fri, 30 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPhCVHgS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56E1BC9FB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031773; cv=none; b=VxWhAbSR2tvNJtu9VqQ69owKtMGJ24wv4xmfOlRKqmDBDv3EJ6q9Z+/CGnYP38sq+mJ5AYkEUtYMtgtVsjid+Z+Fh7KerLi7Bsp6fdjJwvzysLI8IlIchB6J1WJlM2iUf8nv4z8qK+wXYc6RFZOgL7V4s/d+x50RRYPf/w9P6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031773; c=relaxed/simple;
	bh=M4bDsHwjmBNjfe/UWNRn/3FxrHfZZWijHkVxDhuFGuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6m/4L/HnuGwPQr3yiRLJwyKl57JyvrvSjQuWTF5KNWzc3PCQWJhSydhY6UT57siLE+p7rENz9zBgEpEjVIW59lytT1smoMpfUAs1+zm/N0sytj7nndOjLVir6hS3X4K4TXailuBHIjmsIEYDY/Vk48t6IukuveLjIqRw7NWxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPhCVHgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521EFC4CEC2;
	Fri, 30 Aug 2024 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031773;
	bh=M4bDsHwjmBNjfe/UWNRn/3FxrHfZZWijHkVxDhuFGuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPhCVHgSQ5bPygJ8OZVdTGiBEmV9Dp4YR4CfnFGbBjkBC0h5bnN/i7BbawR+SWvcl
	 jQOwvzS2ySSfQ9gMo1zPgXHmjeFi7z85QvwLcq28nPm6rH+711FiiKVUc3O2yS3kjX
	 dSgplhb0/HMGUpuRWxauFiw0GlMT/XlxSw08XTKqtlAI/1ZM5VPCIPsWGcJp8H0L77
	 GFuAqW9l7QAG4YO5QjkYT5I5CvtrmhkOmYKU/R7X+pQ+5LzCTfUkAgX2RNsMyDZ2jL
	 I/ZILDcWcLwkQP4Um9CG9W86vj9LAngVEElUxdSDKQFmskj0serpTeAdnW36BeeYSw
	 4DSwulP/6YGSA==
Date: Fri, 30 Aug 2024 16:29:29 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: vDSO: quash clang omitted parameter warning
 in getrandom test
Message-ID: <be19c940-fce5-4d04-9d5c-414e68839d88@sirena.org.uk>
References: <ZtHjejGdhZnZu4WQ@zx2c4.com>
 <20240830152429.490640-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pan753wPjYecaX8y"
Content-Disposition: inline
In-Reply-To: <20240830152429.490640-1-Jason@zx2c4.com>
X-Cookie: for ARTIFICIAL FLAVORING!!


--pan753wPjYecaX8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 05:23:52PM +0200, Jason A. Donenfeld wrote:
> When building with clang, there's this warning:
>=20
> vdso_test_getrandom.c:145:40: warning: omitting the parameter name in a f=
unction definition is a C23 extension [-Wc23-extensions]
>   145 | static void *test_vdso_getrandom(void *)

> Add the named ctx parameter to quash it.

Reviewed-by: Mark Brown <broonie@kernel.org>

--pan753wPjYecaX8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbR5VgACgkQJNaLcl1U
h9BTDAf/YAt2RN/ePS9u5IwkWH2qWTIaNY5FeZ/FWZFNUxoVI1WOs5EovkDSvz7p
9SjyfeVsVi/LpjBQtEcOKiCJ2ktn+ZNwYhvt6Knx0i8JcbZ9SvA2RrNxqvaGGyO1
GmPKB3Rn6eNUg6EtAnywuUUzSn9XtvJMBaaYJmb6UBwjhlQE61ULYFBfzdKjJGIx
JdJExm+72eRzIOJxJkTmwipfBc9Yyo27+y38/s0RyXqFNU5DXfXPPOovKCZU6BDW
2DA+NciAsHf9Ba/X3qIOC7LWM5Izcoou4GlBaj13l3kPEyI7PtjpYkGhs27+WlE7
yughm1T60tBevi+pYkvWjdtZoYBd2w==
=vlJp
-----END PGP SIGNATURE-----

--pan753wPjYecaX8y--

