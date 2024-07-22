Return-Path: <linux-kernel+bounces-259393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E16939539
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F0DB21A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D238FA3;
	Mon, 22 Jul 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew4j3S7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F9C224FD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682609; cv=none; b=GB6tarbKNDnlJUEQC4SaH50rPFVsUqjJfElr03tK+BlhUPF04fkCEsi17o6QdkiuNhZo+ldoQ1Eoqi99b4K+YN4cKpr/GWuqeZ2ShIds2v2QdVhmSzUFtNti44D0XTNiXplS/gPhgq3u8DCHRRcCCJ+Y5sy1sKTEJfT2X8A27ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682609; c=relaxed/simple;
	bh=M84YmXOOZxzGa0L7FvgC24POY1B1JjlXsEniI61LiQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VyhNPpcYy/cZzu2UWU5JEqKop9qrTYOGQFtyT2bdsGkdmnwTxqoPPHvtSJxDPdUOE9RIURUZ7PzMBaZ8xnpxwhzw0CB3jno8pUnjo04wmUFtei6vDbAXY+kB2cxwlxZYA+lRGEjbF8YVNyGAXCYnskh+ldnH4ZwOS+nEfZxlg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew4j3S7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237DEC116B1;
	Mon, 22 Jul 2024 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721682609;
	bh=M84YmXOOZxzGa0L7FvgC24POY1B1JjlXsEniI61LiQo=;
	h=Date:From:To:Cc:Subject:From;
	b=Ew4j3S7IRxsvhp67tVPN+KTyd7m5Ts2qNmHZKJnbl5AxLaF2mRfcFzai4HeDUqbGl
	 aVAyW/LZfdwhJ+3n0+BRuJon+87PceNle5mgQzI1uOBhxxO19/D+UgLNygrQ6YjtRu
	 6QdXOjWCR5FKHG6T1HQYzx9+u1BoMjfPRA2uzK+eqZJpN5klRSMhoCmpxdXE4Ydvsa
	 S9IiBOf7AkdfDd6ASl+nYq+4qHzSe4WhH9y381o53jJOJ0CAV47pL/EKHzC+svfe5/
	 aLtjQ63V7GGlafu3G+1etZcJ7PyE8oIxmxARsEY1bsxZYQUfz3R2drcBfaSAB/5WFG
	 q9hzGFBabzNjw==
Received: by mercury (Postfix, from userid 1000)
	id A972D106097F; Mon, 22 Jul 2024 23:10:06 +0200 (CEST)
Date: Mon, 22 Jul 2024 23:10:06 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.11
Message-ID: <g6m7rjparpj2iy27hgi347ctlf7qq7xyetonu2p5ylcwvzw7za@rjzn7mtxgjjq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uwjop5b73lktmyw"
Content-Disposition: inline


--2uwjop5b73lktmyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.11

for you to fetch changes up to f02cfe6950479b04fb75cf8424a852af7c50d3ad:

  HSI: ssi_protocol: Remove unused linux/gpio.h (2024-05-27 12:19:06 +0200)

----------------------------------------------------------------
HSI changes for the 6.11 series

 * drop unused gpio.h header from SSI McSAAB protocol driver

----------------------------------------------------------------
Andy Shevchenko (1):
      HSI: ssi_protocol: Remove unused linux/gpio.h

 drivers/hsi/clients/ssi_protocol.c | 1 -
 1 file changed, 1 deletion(-)

--2uwjop5b73lktmyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaeyqgACgkQ2O7X88g7
+ppBrA/+MI62aVIeLizoc+TnM3MeH+5tcOFdOY7YS0dU+dXNiIOeKQfgSgGl0kOu
eVI6PK2DcMQcngqMXlLOaINvlclEKBx3//cTZX3Ic8nwa8Rpfgf48dF+iT4JNv0g
Sb2tF2m01LDeKCMrUjTExnz0lO7vXW0FcX4mSGdZ3uifYoqurXzT7YWhsoiDWgsn
JVDdkIZyRB4Cm+KCmtiYacjedE4C8wvKyabD+ZsZS1GWTG8NN7l3A5iVn2Dz1Oky
DtCe0Bxrec4nj/JvwLZN35Ly6YDyWe/JbXaTki6d7FTIzADw9ZfYxi3W+o61Ve2w
gBzF3hkgWzus6mwY4jkyTb8gSPzYYEUTjv9ygywxTQyMvyDko8vi058os7dquxN3
KuEG5puKWGpJr0yrY+xvq1kny+V5zb9GcER9XFnRFYC9euLJqBhzVxE0fYj6Kxbp
BxsZYR40xIIS2DEmQlk40/XOMF+Zl3+Lt7D/4vdE08OKYmab2g86RcNAycJR/E3N
iS+AzQJPFxZ4c32sRof/8Oi+7cG1E2JLg7U4dOa9sWsY3iGvyNTOy9A1ZrhE/rqt
mb4hphM6sEhkYkHEKmCwRpdmiANbF2uJnY12qSJJJrrdn+ZfXgR38itZHub45h+x
Rx7pY1oiQEA7saL+A2iVtGpB+oOnwBYiHCz16E1Tetqq8RUYGFk=
=Dzgr
-----END PGP SIGNATURE-----

--2uwjop5b73lktmyw--

