Return-Path: <linux-kernel+bounces-323923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BBF974558
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016F22866CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B21ABEB7;
	Tue, 10 Sep 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFg3heL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518318DF94;
	Tue, 10 Sep 2024 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005846; cv=none; b=Nz5zwBbeomPvg1suFvY7RDeUCimAqlWuPVONbTg5SnGMw0x4HpLLEeOVEMdFSyjjC5dVPaxzGb7Vta/4Jj08MmYlCeB7ldVd/FiRCnE0+7J7bGLwWuB9MOcCPy9oqnHIeLNI5GCPye1uY1dN8c2rTdQaun5/ZA0PEs5TL8SuhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005846; c=relaxed/simple;
	bh=nANtCbEGch1km4xkErTueW+tgGVZb3bNVME4BOMGSfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKw+A2drUpj4alrqCqHgRqXhnfy5D4QjFgPrkYtk/70tSdkHVwKnmHUdxcD4lnofoHS9n1a40ioyE1YmGywH8vaP1BKTMiJrGeJM80zFIkUphKK/wJd1K3ZKCxGj14qoU8m5jBBpD1vPNHGBUGFPDSqCRRt7pUwlRc1u5GEb2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFg3heL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3455CC4CEC3;
	Tue, 10 Sep 2024 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726005846;
	bh=nANtCbEGch1km4xkErTueW+tgGVZb3bNVME4BOMGSfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFg3heL/MwkexQqfywNygIYTri3JYVEWQCs+s0rcHCcxIykg0i73MK5h53K7kzsbv
	 QlA2p+xjbVmUcBqZsS5tkbOQ0k8E2cs7d1ijzjEP1SwiSQVnW9gtGm1KPrCMDcHNk3
	 jcljllPf+p2FbCTpg+Hkd3MzROCJKLarfNvf9QoDYfXq54ld2Swb6TUzPEFfaI/ceu
	 OeBtMSK7rmfGim0Gy0ZysSgOzcMlP7fwb3VtouQ0+M212CapoPEdi+UgvbC+yegFRO
	 0XfSB4M3ekRrr3vIErfZ+R16WvMsD1O73GHARri+5pC7MN2LGsx/GIDXs0+33PaYDT
	 Gg8UPIFeV0vCg==
Date: Tue, 10 Sep 2024 23:03:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix typos
Message-ID: <a8e6f267-9eae-48db-8a8a-b9e6d93809c8@sirena.org.uk>
References: <20240910211302.8909-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X2MA07bZH1pe+BHB"
Content-Disposition: inline
In-Reply-To: <20240910211302.8909-1-algonell@gmail.com>
X-Cookie: You're not Dave.  Who are you?


--X2MA07bZH1pe+BHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 12:12:41AM +0300, Andrew Kreimer wrote:

> -		/* See bellow for details how fix this. */
> +		/* See below for details on how to fix this. */
>  		return -EINVAL;

This is audio, bellowing seems entirely appropriate!

--X2MA07bZH1pe+BHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbgwkcACgkQJNaLcl1U
h9BITgf9FDWYrZs0GMvGcamu6USwaHDlIZZsWkEWMT6/PmaATkePV2rM6GQ/qa7Y
CbT4iiWzr+4o6zgeVpP8XBkZhH2Ae1OSrvEPVseK6uLtUsEQmafNhtXQWYNoheuV
6PjN5bN8iDed8+rdy3A3tHxWtq6wv4mGaF80cWv5QoIstbdib9SFkhakn9XtCjrv
f3UGaqEQWTJuLqeeD6TgHg8EfL3YEj8SbyW10skBzw8FaIva2vWCYjXDGKwX1mrP
aEkg5gvaeJp4i49FDqOydzmS5hHrAUAoOdLh4hTr0qQn3q5ABhmPU2QC5K/0Irn0
2kTmCiOMufrnhYq7sMB49xlqGOAWWg==
=9XCi
-----END PGP SIGNATURE-----

--X2MA07bZH1pe+BHB--

