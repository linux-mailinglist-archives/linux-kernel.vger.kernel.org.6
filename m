Return-Path: <linux-kernel+bounces-406735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30A9C6331
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F440B335D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D8219E5E;
	Tue, 12 Nov 2024 20:58:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D720A5CF;
	Tue, 12 Nov 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445087; cv=none; b=tmBY8oF9/8GmRM7sinUKWsa63s/0/Rnk53htq1OrDGiqrc+c3duYF8rdglbHbp8mMwPqdaRWxcWBbbGA3ikSjCZgkxJxM45UkKqWcDRpCbB4Qi5W/0Mxjtdz9lQKxlBGXECrUH4SOEhvq1VeGdEM35ptCnDXYWKbozr/xLWJVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445087; c=relaxed/simple;
	bh=57IMcks0UzNbvv0P63HRcg/VqJkgmnJEQVaZIG3NtMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPlRP1agAUg3pYzkVXRi20Kf5AkIRNZBUR5Ppg4syEaLrx1Hy3vnYm5aswp3BQ47gtU1CxmOXFd3DS1korGTxjrqboe4oEcmzgovAhKp8UZ5d8myqeJwASryEjoJhmL1CR/ua8iNLRRvbIDtv4FnTZsiyq9fr2n4N39DPp1MRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 794311C00A0; Tue, 12 Nov 2024 21:58:03 +0100 (CET)
Date: Tue, 12 Nov 2024 21:58:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
Message-ID: <ZzPBW26qjxwOu1pL@duo.ucw.cz>
References: <20241112101900.865487674@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JZyBI9jf13Ow+if5"
Content-Disposition: inline
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>


--JZyBI9jf13Ow+if5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.11.y

6.6, 5.15 pass our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JZyBI9jf13Ow+if5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZzPBWwAKCRAw5/Bqldv6
8i+gAJ9VqEchISICs4AYWdlbGpyw9gLUxACgpb/g5M8tXJVyCB0cUFDSU+JMn0k=
=BkfG
-----END PGP SIGNATURE-----

--JZyBI9jf13Ow+if5--

