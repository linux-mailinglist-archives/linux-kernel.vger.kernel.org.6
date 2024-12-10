Return-Path: <linux-kernel+bounces-439581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44F9EB154
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F70188909C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B41A9B53;
	Tue, 10 Dec 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPHhLSEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990B1A3AB8;
	Tue, 10 Dec 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835285; cv=none; b=guNkhjTdRqsAOlBNo1auEdM2YE5ywcFr0u+e0obOUdtQc1iF9hm/TnVMgFscW9WLTC7RApxBy7AimIiR83SFfUQ6eGXdmvOdKh/OnqOXBpywKgolTwHJPC9Iwq3CQpxf5LQoqlkaNboql5YaRuq7PJM+VXWW31I5ksFfnLmVALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835285; c=relaxed/simple;
	bh=CPp3kxBq4AszQqqvCIkOXMQnJT5LAeqC4Snv1FDwMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNXknjhBenhifNKbKj8XYsoCx7XeEIYlGd0lK8CFkIPcXKHsCTIxIUaZEjRasbrahs/yQ6S+o1z+g5jUvJfw7snrWfjREb29Nmh2bTt9sNO7rS38Lrqsq7Kj082WofcgBFSRkm4ulUFe8d/E69SzEqT2CDIm39yroaqADbkhjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPHhLSEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31EFC4CED6;
	Tue, 10 Dec 2024 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835284;
	bh=CPp3kxBq4AszQqqvCIkOXMQnJT5LAeqC4Snv1FDwMr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPHhLSEW6WV7DXYU3ifKQD8pgmllav1Cx94qOQ1MZ5TEaFUyeLan/E+2Tf1JX0Gck
	 kC3BZb58b1+En4kXBwGDArUnNiZGktDvYlY/8oNCdD4mlg/TQzsnudvtikpaPELhcW
	 Yf0VY1MQUFVWIlvJ20NM05J6/F1tunkRU3I6BnGMAxQ+9tqAL5jrLwUL0vi2SEZllF
	 y7GI76IfJf/7m3jFQZtefPXz6Dwi5FAGHmYckrSHV6FAtWGnWjHctMVIE/VWips7iy
	 E3JOQUw0urGMYUjjpDtKXo8YE5k66YCTcLaaQxIJIgwAjvH4krLIhdytWBoAVzDwFW
	 +9pGJepMUH28A==
Date: Tue, 10 Dec 2024 12:54:40 +0000
From: Mark Brown <broonie@kernel.org>
To: anish kumar <yesanishhere@gmail.com>
Cc: ckeepax@opensource.cirrus.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH V5] Docs/sound: Update codec-to-codec documentation
Message-ID: <d7cb771e-9389-41f1-a9db-b72fd907cce3@sirena.org.uk>
References: <20241207193441.15767-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YN7N9+7H2hBoG3Xc"
Content-Disposition: inline
In-Reply-To: <20241207193441.15767-1-yesanishhere@gmail.com>
X-Cookie: Leave no stone unturned.


--YN7N9+7H2hBoG3Xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 07, 2024 at 11:34:41AM -0800, anish kumar wrote:
> Updated documentation to provide more details
> for codec-to-codec connection especially around
> the scenarios and DAPM core details for C2C
> creation.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YN7N9+7H2hBoG3Xc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYOg8ACgkQJNaLcl1U
h9Bc9gf/U+GG/1lhwjVsTqGNudPe7gKxxxe571RfLNqtdyuOWis7bm7VqDEobphF
K1+86R22yVQH3mdNI+OcbIiV8JBajr6dkLZdTABZnKqKkBLG9hvZUlE5CFmyaRT8
yZhCHmC3OZJPZQcOlw0vRPo/02p5ghafNmo3umyej5WgMxhwNs3cu8ziTUVjKK9I
yBtDIxZ9k5gBcEd1EfCNeKru3Vg++pBJGMca+0/fHmK6CS9GR3EzfMpu/vh5FI4G
Eb2+fPj5Kb8pK2C2K8Pr9T6wxOs5BQMm5HtFkwD63JaNIQImzphFBUApeM1ZnXVw
2MLBAL8HEbGGMeXDAazUev9vWyq9qg==
=8uBf
-----END PGP SIGNATURE-----

--YN7N9+7H2hBoG3Xc--

