Return-Path: <linux-kernel+bounces-255569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D8934256
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529D01F2305D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA318410F;
	Wed, 17 Jul 2024 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKNzXu4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B581F94D;
	Wed, 17 Jul 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241468; cv=none; b=O03ywlCd+np7HKByZ1eVN451PrKJnMVwQ5/0YakW74NGArjaOSwAfHiG85isN1r3nHrACeYNVS1w1tus3G6VnJ69d4kMjLSnNMYDoQzIkiwFu+eVrajnLw/d95SUyd2fykt9EktpES38NLp8lhdSIr9Wud95jie2XzYEnSR90dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241468; c=relaxed/simple;
	bh=v+bz9xwix6kgl7QEy3+vLmceD7rtb3mkK470E2BHlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcbNc4xIKCv00wU/q/I07lcPLv2QbJ0wh2qOCTr+B+fMBTEqX7DWsjJKS4eexGlW46/FXH5x3EDJivMaCxePjPt9Pogrv46V1dQeWFUMjTIN44N0XERU0F1zDWFQIxKjqRbIOFGxAMNZHzObNUcQvEkcwhrq3a/0eTMSd1oBTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKNzXu4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40CEC2BD10;
	Wed, 17 Jul 2024 18:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721241467;
	bh=v+bz9xwix6kgl7QEy3+vLmceD7rtb3mkK470E2BHlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKNzXu4rfHU9x3DqC53pttJi0yXC7haDLiEgSnq0IRXEDMQxPbU9h5nq/ljAzoZiu
	 f8il1noCTO4lx4ejlwAah3PmXSP8q+hwr/9aaXYcb+/oRSfdNdkIEhC6oJvgXJmI5y
	 f6CcteTqiL3S7vGCP6UEgFdNmCmix/nf6yjl61aEDZd2XwtaAJgSP7U5VPKdqycflq
	 8VF1O7iLxWk4y4hoYIfCPNDozRBBbtrp3bh1EbGdpsyevrSGH1loBD+BBYYq52zz96
	 cqUTtBuSO0hZBxdYblzYm1YuSMRE+QirzysTo2UWtPrFwOL5LPHVBCJS3RAydxdINX
	 pc9oj2k4hKm8Q==
Date: Wed, 17 Jul 2024 19:37:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
Message-ID: <979ee1a4-802e-4078-bb5f-1ea1246b7b69@sirena.org.uk>
References: <20240717063758.086668888@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mv7s6qTVc2LODbOh"
Content-Disposition: inline
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
X-Cookie: You should go home.


--mv7s6qTVc2LODbOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2024 at 08:39:41AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--mv7s6qTVc2LODbOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaYD3QACgkQJNaLcl1U
h9B1Ygf/cVb1/C2otV7onh5oTpRtq7ck3lkAij13VrjDnMYFsg2LtXOPKu+GO8aG
6vqFlPMPaBpRjfZS8lQqvMzehaGbYu4wvm0V7Fz025jurJaSWXMcb5Ro50cNTmvi
ScN200AyMWWQlA+3QJ+biRvhvDLw1mZdcLOyzcUbV2JQy6o1vdqd/tnU70Dz5BBS
j1t6N+g/t/2kE6yt9cPFRdLpkx/WfHSeMPbIsM19J3IRa2BTs9o6ol1THXRfxFMN
IUM9TalHMO6kgvrOLGoQV7qY71pmgpZ/vVYWXh16FdRc+lkZMgMHp+x3ey3K9dVZ
Z/FPsYilSncjQy8toM9SswydxpqYsg==
=27sV
-----END PGP SIGNATURE-----

--mv7s6qTVc2LODbOh--

