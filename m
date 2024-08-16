Return-Path: <linux-kernel+bounces-289601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB7954805
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62991C237A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE0191F75;
	Fri, 16 Aug 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR7gj1vH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D54A3E;
	Fri, 16 Aug 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807500; cv=none; b=bgITk3SC2gvN/01kn6emAJJ1RkLdUxZeCPgCaC636m5Dt2mMnCXFn5Z5bpncxrQWGjMsdQ135XyMBKoYai+hxj0mWoSvTtjLA/vSES8wkN3kNiy/BsR+aginQ8mBUNeihvW6XxostiiYF4lgH2LKLn58JDACNoZLqhqjNrXTW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807500; c=relaxed/simple;
	bh=v3nCRbmuSbwcE+yYidwDnoLtrw6/cMvAkIp205tnkHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HESQb9HjK5Hx3+ZD38eKzM/7P4Zr7YosvDDi4Fic+ZViHVTPWouqUJqFxyx9Xle5u52pCmujj7Gf4pUa1Rz4FI0N+qKQ70ySUxmDBvlukDkNGTNRNiRmZk22tcgwEpYW+kLsU6Igw3950surfMnchsmmtBQnnFBiRnBsLGnYbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR7gj1vH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F85C32782;
	Fri, 16 Aug 2024 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723807500;
	bh=v3nCRbmuSbwcE+yYidwDnoLtrw6/cMvAkIp205tnkHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TR7gj1vH1LXLqWdx0p/m6xpZXWgTc3r6GQp3RGBcRCkWNA6Dm2k6pL/USGmaYZJJn
	 B0ncvFKRiIJgYARseBJlRu71rMNpoIy9qCqBLj8SqYERmGTtSGJKU9rRhZZEeYWVaE
	 ix3jpAzSZKZHutTrPUNwrSzBrG5OfV5nI7ZO9l54iK15zBEqb2lrd+L65ZRLEByBb2
	 Nn/GGrP28QFhgwS3WYF54FmwkCVjq0pvzcfVz88WvGg9GYJ48jmzcyW26M8O1YmYnx
	 xmfmbWbJoFVuqpb5zq0VVq/IIMQm4WgAJbaP+gy5dfNwTAEDnIg9sfrduBEvRt7DcR
	 IaWbtHEZOG/uw==
Date: Fri, 16 Aug 2024 12:24:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
Message-ID: <6e7e2d13-45cb-41ee-beae-f495f70733d0@sirena.org.uk>
References: <20240815131832.944273699@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9tt/q4mpRTGnnLGZ"
Content-Disposition: inline
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
X-Cookie: A Smith & Wesson beats four aces.


--9tt/q4mpRTGnnLGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 03:25:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--9tt/q4mpRTGnnLGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/NwUACgkQJNaLcl1U
h9AAmwf9ED6ZycIHzhQYgxWIm9sXoy3iVWoWeBfNodsUNhYscXcL0/buEipfWQvn
bI/ZB7AFAucvSyH8BQT1KDTzDbmhcAnbafmhxuVdc4FTGpobLUM75V5a0bV6g05G
QhFUqczwSSCCIzNesuz5vjMro4YsIEJTLGGvU/NwRj3RvpwQz1Xxrakw1NRI1Oj8
+WXkqWRXtJQ278VWXmeOqvv8HfDAiQ8O10iQcqSQ1HsFnW7cklzxacFJzaN1+LGk
VjwSzWKA8t2bkiwlo0GC5aiXQL0SKnIDcB+tuT/p8C+pRwPiL/dr8MBUd1Aweewc
ZYEar77saBCMKKJ+lV3c0Xx1LKLeIA==
=OSCW
-----END PGP SIGNATURE-----

--9tt/q4mpRTGnnLGZ--

