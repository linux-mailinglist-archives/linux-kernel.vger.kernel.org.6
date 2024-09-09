Return-Path: <linux-kernel+bounces-321856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89197206F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8376E1C236DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52494178CE8;
	Mon,  9 Sep 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrvFPkWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD5176ABB;
	Mon,  9 Sep 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902798; cv=none; b=pDLCRqA3ANnCle/2Tu+dwEDR1xcQ05mSiFqv2QSjadkzlrj/kAhXbJjA3XMN3FvfAq7KF5UFXlS2QftvZ9I9+Fh5PgB/wLRdtgsXdHPLsdNGZaJeRUiCkc5A9vDJmVgNfe2DnfqM28XxwQO4Qp1uGy+k94TUJpfzJ242yvT4K1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902798; c=relaxed/simple;
	bh=AnFzIOts1bseLvgHbZIPxmk1t6OKKNJUx33RD6kae2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEJwgKVKkF4GiLxuN9GFDA/cV0tfTNsrlrMkZAyA/KrwDUdnXVSOqoiT+DLzjLdHh9HgT8JpRw2a2lPe65w92LHRWvf0aRmi+yBrpU7fSa76UEd+5PSogCSevDPEd4sWZOyhYYDSt1JbDqoeIdi9p6qvVzRmQk4If3HuqYQYI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrvFPkWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78DBC4CEC5;
	Mon,  9 Sep 2024 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902798;
	bh=AnFzIOts1bseLvgHbZIPxmk1t6OKKNJUx33RD6kae2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrvFPkWHSMaPqVTZKNs4pFHA5ZIzafs3P0GXZLU99ZBviTO8XFXslT+daQrLF4iBJ
	 CjVbSIVLTcaNHUASN/dkx6iFjI7cyWXFDdLtFb20XV4K5VU2oafTjY0uPnb1w/uELo
	 NG83u0fVMeTupV9nEUZGFR5Ss5SvZ94RfWrcAcnM5UtVXAshwx5CgrU0q2pnk3Ojwn
	 lV5s7OoIGvYIBLTJoIO4LUPPEKE7WU2XTTxukmCz3C/uxwiN2R/BeafVtVoDdaKHuF
	 v4JMvN6WMadXnk1GKr73/kj+OafS+EyPwKoQ0iFIGfxrSo3U3IHgiErL/B9EEhVJC3
	 +YNNzpQvLQVBA==
Date: Mon, 9 Sep 2024 18:26:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-ac97: Fix the incorrect description
Message-ID: <98f0a674-1636-449f-b9a6-5668021d114b@sirena.org.uk>
References: <20240908124124.1971-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OMzUP2TZUyaqgLUe"
Content-Disposition: inline
In-Reply-To: <20240908124124.1971-1-tangbin@cmss.chinamobile.com>
X-Cookie: Last week's pet, this week's special.


--OMzUP2TZUyaqgLUe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2024 at 08:41:23PM +0800, Tang Bin wrote:
> In the function snd_soc_alloc_ac97_component &
> snd_soc_new_ac97_component, the error return is
> ERR_PTR, so fix the incorrect description.
>=20
> Fixes: 47e039413cac ("ASoC: soc-ac97: Return correct error codes")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

That commit hash corresponds to "ASoC: Add support for allocating AC'97
device before registering it" which is not what your Fixes tag says,
there is a commit with that title but it's got hash
76f5aaabce492aa6991c28c96bb78b00b05d06c5.

--OMzUP2TZUyaqgLUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbfL8gACgkQJNaLcl1U
h9CODwf+OVduaE2xBOG/Qzm688Yss1s3G5TGCqNeubivPxXAQdvTBjmpgIBNgLrJ
/f1MJJPgxxY7tUZY/wTvQ3CnJXMOC9Em5gYtf5MX+ibsBzDaKkA/YPfoAGi5Egtk
EWBhCUzHu8HAE/8sOmE8El9aDokOtyUnQ7R5IUDVBl1oBxPcmZdH9ioP+ZqQijhM
cfRxi4bhRArk/DCQD1TKfCNYIEt09VSHGp5SM8p8b6LBe5vIXxPysxiDui/fHqpu
LQoct63sW4sUPHccLp5PMN9JwK4ioD6oBflVl1jWxqkHjAAEbZ26CiM2qYzekWLa
NRL3MQGC9eiy6CTR+0N4rlBlDDkQjg==
=SIrX
-----END PGP SIGNATURE-----

--OMzUP2TZUyaqgLUe--

