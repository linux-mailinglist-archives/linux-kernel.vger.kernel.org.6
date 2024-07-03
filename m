Return-Path: <linux-kernel+bounces-239878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E7926658
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1B1F252A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179F217E907;
	Wed,  3 Jul 2024 16:48:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED34181D00;
	Wed,  3 Jul 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025319; cv=none; b=okJNGC6ZfjZxiM7pZv7mfIhHwIMbOFWA3ILvWh8lbHQ3MsRlNDFLHhuPitx1339VVleO6AfXSMhRNUnHKovLf1k8+pXOfY55TuzdzpOdAAt3A9/13MA1goV6K9UGDqT9/tdHbDMKpLVPoE4DdPH4t4fUA+e3d5YPSHKx04TvXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025319; c=relaxed/simple;
	bh=InoK4ml7ZZ/2UJP+RLwxOjMLsVApYWiAFOXBBekWALQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X64Tkst3m6SjLyYSZ4Le43R3vbUIk1szeDwvxoQTcCb6oAF5xbfzspfzyYuq/zF9wAj1Nh3ACEJGW90XlAM2zj3aEyp8V09QkSMWfhO5p9itJ8xdFtHEEXa5kTow+OXhu2WBIepzySCehDtSigCBDxmgECl6PLkkC2DkeI+ljDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1FC6A1C009A; Wed,  3 Jul 2024 18:48:35 +0200 (CEST)
Date: Wed, 3 Jul 2024 18:48:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 000/139] 4.19.317-rc1 review
Message-ID: <ZoWA4WaDXnRYhmM2@duo.ucw.cz>
References: <20240703102830.432293640@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3PMb5PS4q/ZNf3y8"
Content-Disposition: inline
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>


--3PMb5PS4q/ZNf3y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.317 release.
> There are 139 patches in this series, all will be posted as a response
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

--3PMb5PS4q/ZNf3y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZoWA4QAKCRAw5/Bqldv6
8shWAJsFCRFuaFW3pRNe7rbFewRynBEbYwCgiBKO87yW2LzpDqlCBlYN4Fkm2YQ=
=g403
-----END PGP SIGNATURE-----

--3PMb5PS4q/ZNf3y8--

