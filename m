Return-Path: <linux-kernel+bounces-210216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D39040EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA0A1C237A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A153B192;
	Tue, 11 Jun 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVK+Wppn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48842C694;
	Tue, 11 Jun 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122328; cv=none; b=gykI1K6KyyKITriz/IR8zHgdinL37W2ITPrvuOV8zZGFOyIlkQRZ5rlfPmRjUH9j7fAvIFKkgYEBYkdHzZV8FqBHZ0MvQhaLCNWrwzsI+TI+mMamqCXHe6eFBiiXY+fkFs8pvqvZbZcascXgridXIUKlWCpUSCueSFz7yS1NxnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122328; c=relaxed/simple;
	bh=aJeW2N3kwCz5oB5MHCriHIh05QZu77JtFLwwq8ApGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRlnjtcofHAMfFxolxXV1waiUuCTpgWKV9mwYtVNsIwJOEeWuzT3fYAFuzGw/3Pm1BVoOC84bFDfuCLMR/wa+9cy+Bv7gFENOTG7fY2bNkUc7chxmF5Q+gyQYK6lp+/BrFeV6gNkWe2/kf63DisVddxrRp/w7Kt8RZr7bBMg6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVK+Wppn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30FCC2BD10;
	Tue, 11 Jun 2024 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718122328;
	bh=aJeW2N3kwCz5oB5MHCriHIh05QZu77JtFLwwq8ApGUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVK+Wppnos2Eafl97QCMr2wdlm/2KelWydzXxwnCLqUxDoPSLbKXLE271XLZjkrte
	 5djNSV+lx9sZkprvFxfdo5CL4kbyEdw9lmWaT1MKEziFI+8thhCPBu70hZ9ycDCuN1
	 xL73+msP+cFrzPDaCvgvLVkCRnHAwlFX49GItoKAFqRqTEcq+zhT/n3nPzFVoDg6to
	 Lg0/sByxIkG7WYQ3rdUHWohXZkumAp0iLs1bRF4EoDz61s6oNt/E36UswwbaNXZj0k
	 /R0hYfTkrNewOYYdmhF2R4atxDfHFQ9IyJsxH7QWTOzosghxwRZgMyaR9doznST0Lo
	 fi3kguYpwwPIA==
Date: Tue, 11 Jun 2024 17:12:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI
 is hooked up
Message-ID: <Zmh3VmRfGEU6pGps@finisterre.sirena.org.uk>
References: <20240611145746.1454663-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hy4b+bAfizSELLR"
Content-Disposition: inline
In-Reply-To: <20240611145746.1454663-1-rf@opensource.cirrus.com>
X-Cookie: Your love life will be... interesting.


--4hy4b+bAfizSELLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 03:57:46PM +0100, Richard Fitzgerald wrote:
> If the ASP1 DAI is hooked up by the machine driver the ASP TX mixer
> sources should be initialized to disconnected.
>=20
> The silicon default is for the mixer source registers to default to
> a collection of monitoring sources. The problem with this is that it
> causes the DAPM graph to initialize with the capture path connected
> to a valid source widget, even though nothing setup a path. When the
> ASP DAI is connected as a codec-to-codec link this will cause the other
> codec to power-up even though nothing is using it.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: dfd2ffb37399 ("ASoC: cs35l56: Prevent overwriting firmware ASP con=
fig")

This doesn't seem particularly different to any other unhelpful chip
default, I'm not sure why it'd be so urgent that we'd hard code a
default?  There were some other devices with things like bypass routes
set up.  The capture path getting spuriously triggered feels like
something that should just be sorted in general (TBH I thought that
worked OK but it's been quite some time since I looked properly).

--4hy4b+bAfizSELLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZod1UACgkQJNaLcl1U
h9CBAQf+OhZdPDxTYMLChOAhYTNb0+Q25t451LvA/upiJjwv4Wz/TNIntO6kFK2c
8ntuUtQlz/SSqBwrYDTbQbPT8f37cKiXEN/VggO6LIFbLvoaNsuxMUVrs557l+u9
Kh2NltpGwT0tsIF1Se0uTxaHCRbW25jW73sGjjUVnkdesGGGA03uejObLNxMoSxb
GBBdSy5PbML9buuiqz7HeP8e8wyi+/Qg/M+oD0loP+3AJShbYgp3/92f1gDQpPJk
9GWYAz8FdIsCyLY5GwOrcViV6l6DX/mFbH2+sF386uz/XsT7psQurHhTG4oKPSlB
ioBDd73aX0JCg0csiL83a9YcA36IXQ==
=6QSb
-----END PGP SIGNATURE-----

--4hy4b+bAfizSELLR--

