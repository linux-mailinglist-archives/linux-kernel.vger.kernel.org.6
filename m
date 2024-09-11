Return-Path: <linux-kernel+bounces-325551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90BE975B35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC6E1F2147F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C071B6551;
	Wed, 11 Sep 2024 19:59:17 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BA1BA896;
	Wed, 11 Sep 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084756; cv=none; b=XRrzBKkVTsNFZ3Dz5JAWIa8lmYWPX4IwCemPvHk6/qtJ5AoCwY5tirfTzslgcSF5kb+PoGMOsL7hfKm+fW1cCBNlSFs1aAvQDe656kzZvT408g5AeBrASJLRvBxtiz1mdwUaVQEgEp1wmHr824o2fY8LO7I29F+5zsT7dOmU18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084756; c=relaxed/simple;
	bh=TUWzvb3yw6nbEmODiVJTh4wv8+p9tUgIBBWID6mK1ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORMD/TKt3tbRwYglejepjrOQRiphoSCKk7M+ks7GZ9ns7MbWUJlX/cmfEMAIJ6+GgDJYwgYE6I8OxCOdtePZA5ty8+BRxjycflnv0o7OtDdu6slmYhLckj5mdRLD4NDU3FF4XIFX3r8R2RKCM1Tp0s36L79hR527D5pE6T5SoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 622661C009C; Wed, 11 Sep 2024 21:59:13 +0200 (CEST)
Date: Wed, 11 Sep 2024 21:59:12 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/95] 4.19.322-rc2 review
Message-ID: <ZuH2kHBofUxZySDZ@duo.ucw.cz>
References: <20240910094253.246228054@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zy1+klCtqGobHtex"
Content-Disposition: inline
In-Reply-To: <20240910094253.246228054@linuxfoundation.org>


--zy1+klCtqGobHtex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.322 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zy1+klCtqGobHtex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZuH2kAAKCRAw5/Bqldv6
8ji7AKCVq7v7YDdVhTNpwL9sG0U1P1/pVgCWLohrT7ITMTdRUkkbfVoOsbEhVQ==
=VmUP
-----END PGP SIGNATURE-----

--zy1+klCtqGobHtex--

