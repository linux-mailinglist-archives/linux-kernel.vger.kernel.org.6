Return-Path: <linux-kernel+bounces-444827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E59F0D19
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D7B283280
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A91E00AC;
	Fri, 13 Dec 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lreHv4Bg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBDF1E0084;
	Fri, 13 Dec 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095602; cv=none; b=jzhbZ+H6u7pa67RXfvzNPXPl8UllXcbuyEZRGqZv6j/bXkEdbmypOUg/Dmilae1TWUiRQVIFSSSRJrKjw7IFDCBpks9/xABwW/onFF918UU/C7lLfKEy06B//lG8DwVTdrNnTzrge3mT3+eGE0RPWdod0vIG3uEQ10uTJSPMttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095602; c=relaxed/simple;
	bh=DNhLWtHd+rI37iA/grjqQn+TyGl+nRz6iImpeWLn97c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6cXVCHOAh13d2F/3xbgxqKVc+K2o+mgfJJtNChCbj7hNs0SLuGJMeatEZeVxsyGvy3a9mgY+ypSi5dB5igTyd5bS48YA5vD0boc/9Cewxjnod2A3u9TqKCdU2rY4kceSHfVhM8CImpFfjLutAsi1/HPNRlBhzdhLxhFnTRSIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lreHv4Bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3181C4CED6;
	Fri, 13 Dec 2024 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095602;
	bh=DNhLWtHd+rI37iA/grjqQn+TyGl+nRz6iImpeWLn97c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lreHv4BgMI2Ish9fWuayuj0nUCPCO5CUzoF3JL6lJVHcii9YCmHS31lMBBOfxX1qk
	 +u1XCet3HfcP7yM8YQBeTcvdQcbGVoeRL7Aodex1xaL+j2iOdQ/V/11g/CUITxRs8z
	 UhUA0mKDFKb5aD6kRsCU/KyakM+r/X4HevLxHSGhIBsIxF8kDAJFSTrjduUOgQuK1i
	 TmjcK0oDC8R3CJuqnDWXFIyOQa34uT06eEbPDQnOSwgUhF2dyz8j2Ak+Dg4QEzOUID
	 xHUgMD2Lj4E/N9Gi5p/oObL2b3KB0OumpAuJXXo1UNCDEZY4h8Ao8UaTFjrj0fpvxc
	 UWrZBa9yn1O4w==
Date: Fri, 13 Dec 2024 13:13:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
Message-ID: <8c4ebee7-a086-4e1a-ae1a-2da26a9cd911@sirena.org.uk>
References: <20241212144349.797589255@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KjKo2+ea8FWMSyUr"
Content-Disposition: inline
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
X-Cookie: Not for human consumption.


--KjKo2+ea8FWMSyUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2024 at 03:49:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--KjKo2+ea8FWMSyUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdcMusACgkQJNaLcl1U
h9C56gf8CLzXMlmpIZ8/4u2Zk9uSuOhydvxtRgswdKT4Vm7iXOGr5sgxLZRAnM5/
sTs5DjUd53kGoxNxAIlJrjMuZVTrQi1uQj/o3LgNGhu/GlyqY/boTpJqIQIq2xs0
52t2MA86jIvxrUX5QaYfK/zvAEHDE85UgutVRqNQIod49AzBjzd68U77IENyCCLq
L7aOBTyj+HOlhqSnJCCHJq0PJm4AAUwUjLeNzDFk/JdtIFm3unxpbiMw4rWjI1t2
qjJ/fqNn+0hqEROXGtcdzFHJRMwp+0k8QPyFPQOdjAALVE1AvNbJtFGcf+Vem1i5
cJlAhsYaPczhG69bvHy0SZnixkbv2w==
=he6L
-----END PGP SIGNATURE-----

--KjKo2+ea8FWMSyUr--

