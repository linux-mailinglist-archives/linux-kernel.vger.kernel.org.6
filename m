Return-Path: <linux-kernel+bounces-290266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1866955187
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E330B2181B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461521C461E;
	Fri, 16 Aug 2024 19:34:48 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE21BDA90;
	Fri, 16 Aug 2024 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836887; cv=none; b=H+A7bJvXfwKGeIjJBCO4GHpuBBd928fEJml86XtRWK/BogsYmpw+eskvIhRe47z6plRgBhGR8IYDS8bNHdGIH1Z1csCeV8AZCtWBcRGhM9Jbax75MB16i9vQg+0jlpg1FCxKbzp42iLtpFhgHM9UXi1tPW2B/07ykNfMf4Iin6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836887; c=relaxed/simple;
	bh=cG9IFK24Xt85Di46e93qIxn3NtGFyMASqg7UK3yFink=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUBu26mtqlH3nsVPtXSKWKYrlPn7carB5lsiS0qjrmKNcUWbRtIpkAp13NFBBw0wywjFKQdXjLaAG4hs/3ok+02fwuTib+KTZIh75/KtyDulyoK527A2A+XSi7gJc/9de8TnPm5qWGBE7XYEh04mb87qIpEiQe+Wq2wZ8V522TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3D3531C00A1; Fri, 16 Aug 2024 21:34:38 +0200 (CEST)
Date: Fri, 16 Aug 2024 21:34:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/350] 5.10.224-rc2 review
Message-ID: <Zr+pzUSX97GvJEyG@duo.ucw.cz>
References: <20240816101509.001640500@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UdEPW0NgBQK0hZOt"
Content-Disposition: inline
In-Reply-To: <20240816101509.001640500@linuxfoundation.org>


--UdEPW0NgBQK0hZOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.224 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

(5.15.165-rc2 (aff234a5be72) passes test, too)

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UdEPW0NgBQK0hZOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZr+pzQAKCRAw5/Bqldv6
8vfQAJ449THy2kV2W5zR8B5nbVSpzoJh1wCfcPp7Bmvk3m3QuS/EVGUvYKkvw2o=
=Quay
-----END PGP SIGNATURE-----

--UdEPW0NgBQK0hZOt--

