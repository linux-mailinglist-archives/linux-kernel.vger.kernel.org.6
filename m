Return-Path: <linux-kernel+bounces-258884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3A8938DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2641C20E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD616C875;
	Mon, 22 Jul 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ+ZojLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC216B39E;
	Mon, 22 Jul 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645569; cv=none; b=g2fheL+uqvywzPHOR2g0U/+jS9PdojlTMPybg3W9nctLeJBQldc+c3FfNTYLPnLb/1fYcBTWiVjD/5YhEB6KmN54kElrIFLZGXYrBAStEgIhCzZOMKPqDUbqPtl8wT0P+4SrbNVZXAOcLzk5bOME2Mk4+U0yZLfa9LxraoAba3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645569; c=relaxed/simple;
	bh=d/phvPCFH5b62HPy+3QDiw3vQq0Av/LO7MFoVObg1OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd+CMImM8x+zbTTnWevXLy5GX+n7e9zfovfEx4R/9Fd1C7Q/53oQzP+otRpKb8B/cEmBW89xAuMqbp5kxln/XLvucoMnxvr19erO4vfl8VARO65m5aQ9sZMb1cgBHGeWlMct4wVEzc+Tf0m0+m2pM/rxOuF6PBz6zg6Ks4tYB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ+ZojLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8916BC116B1;
	Mon, 22 Jul 2024 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721645569;
	bh=d/phvPCFH5b62HPy+3QDiw3vQq0Av/LO7MFoVObg1OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJ+ZojLFM9Wj7orCKE8k7kcHLxHlKDc0UmBL6mlLiI1+nGrswWaYt4dlLn2NCnrF1
	 8OWQtO4pdoDt8x9Ula19MWuGDi/VhCmFklM4ceq/cybFABERPEEIYpPj/RfbmFsXPd
	 4mQNMffonA2NgGqzo2ejWetGC7SncY23MDq8cVuCXHU/nhpTq+AGgwmxabJxqmKEHw
	 PflzdO28df1xUtHspYtlb21s2IvsCv2MKcSyh1TCpRze0tJKnYY38ISnTpcduFPYWh
	 v/S1eRd4mXnsTHHU/CoQpK6r6JbcK9Wc9zUZ74A7bHNInugUMYhUV8EJGD/qtZfmuN
	 FiwFIZhe7GTMw==
Date: Mon, 22 Jul 2024 11:52:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Audu <jau@free.fr>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sti: add missing probe entry for player and reader
Message-ID: <d85590f2-88b3-4bc2-b7b8-9f96a5d5bb17@sirena.org.uk>
References: <20240721-sti-audio-fix-v1-1-a8b1ecf61cb4@free.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwcgTLsscWO31/aR"
Content-Disposition: inline
In-Reply-To: <20240721-sti-audio-fix-v1-1-a8b1ecf61cb4@free.fr>
X-Cookie: Everything you know is wrong!


--uwcgTLsscWO31/aR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 05:40:02PM +0200, Jerome Audu wrote:
> Restores the audio functionality that was broken
> since Linux version 6.6.y by adding the missing probe
> functions for the player and reader components.
>=20
> Fixes: 9f625f5e6cf9 ("ASoC: sti: merge DAI call back functions into ops")
> Signed-off-by: Jerome Audu <jau@free.fr>
> ---
> Specifically, the probe function in `sound/soc/sti/sti_uniperif.c:415` is=
 being replaced by another probe function located at `sound/soc/sti/sti_uni=
perif.c:453`, which should instead be derived from the player and reader co=
mponents. My patch correctly reinserts the missing probe entries, restoring=
 the intended functionality.

This should be in the changelog, your actual changelog doesn't describe
the actual change at all.

> The patch modifies the following files:
> - `sound/soc/sti/sti_uniperif.c`: Changes the visibility of `sti_uniperip=
h_dai_probe` to non-static.
> - `sound/soc/sti/uniperif.h`: Adds the declaration of `sti_uniperiph_dai_=
probe`.
> - `sound/soc/sti/uniperif_player.c`: Adds `probe` function to `uni_player=
_dai_ops`.
> - `sound/soc/sti/uniperif_reader.c`: Adds `probe` function to `uni_reader=
_dai_ops`.
>=20
> This ensures the correct `probe` functions are utilized, thus fixing the =
audio regression.=20

This detail isn't really needed, it just describes the content of the
patch.

--uwcgTLsscWO31/aR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaeOfsACgkQJNaLcl1U
h9C03Qf/QXpJLlhj+1SJvQdYxrSRwLJKrcGsmk/kgcE+JjBKDzZe2iW2nK6+fJgr
sxQtN1ytBBbvvsB2ZYRamU85xpsVdhQ6a10U110NYztC5JJ3HS/XPSuhVjVZk5zs
rH+k1mzi/Zu/hmo6Jbdhf+73wPXF3uW7s+0/Ov3Fm6agDoIzd6xwcTe6BcW044ak
o9c7ObJcKl0G2mdUQZ0RVbrQ/6eME01yqhUJoxPR6ArZ/HBMdKrmLO3lg5vSxzmq
zFxCZJvYa9I/Rug4s67JptLVW86TCQRGzO0gbFWDPfD0t71SjBBDYNTGLyEmvA1p
/Dgv9Is1wL6SjvhG17XKQ75DuGlZfg==
=o3Ai
-----END PGP SIGNATURE-----

--uwcgTLsscWO31/aR--

