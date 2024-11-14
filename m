Return-Path: <linux-kernel+bounces-409222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12809C8952
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C8B24C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBD1F9404;
	Thu, 14 Nov 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQHAMNvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AF1F8917;
	Thu, 14 Nov 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584551; cv=none; b=AXxHkK15VzSo88ao9AhdF662tMfazN98VSCdYZj8H9OxZ/tEbxXy/46gryFV0BECWMpquQYFJOtD3miNRqcOcNQjeDgHp2pwz5rIj9dIwvTUlqieXuMpZrgAm/F1rYWTF40r7fXq2j52WzQiJ85ud4B2I2OXrU6u7IODbNmYs1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584551; c=relaxed/simple;
	bh=xUGHZDJyHnRsMWo5XBPmfd5sEStqMlmHUm2I238eKsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbK+AAPK1OaVWoSudKjXCmKOqB3416QR/bbnAgKxOW+XUgrli8HR17EYKu/y61gsTznOK/1HExkaONL/3ClQQZqypiN2m7StuvVUf/Q9kTUXkB9CK5Ko+m1UHSvZcLYKzvY75drurZeA9yXBwe7xqv3TIdkjBwhAfLamfYTjioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQHAMNvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FB6C4CECD;
	Thu, 14 Nov 2024 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584550;
	bh=xUGHZDJyHnRsMWo5XBPmfd5sEStqMlmHUm2I238eKsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQHAMNvVLThR+eMdfABSwEOUMriGZjXe4FPzfTweoSxlLyc/mp3Rls0mai/nVTjkz
	 Nat5pHpdBh4oMXg1pofzTYQ7pDSzvaYcdJu8uuKHd35Vi409cPJKwt/+N42s7O6Q+s
	 r4++mv/lPQRjDwckg3ojAzxLfjajp0UCO1M3Xas86WMdOuFct9F3RFEHTSViRHq6tY
	 6neOmESV2QggywJSPaIEckIdAMlZ0Mj21A2w64iQBkKFi4C1ZqJRbL2yPhwTxABSXf
	 TXjRcVA8jgPPhQACdKIE3OCVbljK34lcZejC+1Mj7Y7i59DH8Ziw+AQvojXT3SuQ4t
	 PCV9H5sHNibxg==
Date: Thu, 14 Nov 2024 11:42:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthias Reichl <hias@horus.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RESEND v2] ASoC: hdmi-codec: reorder channel allocation list
Message-ID: <ZzXiJIyf8Iyb7f50@finisterre.sirena.org.uk>
References: <7697010E-E0F2-419F-8378-FC3E491EE1E4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="usOhYHKopyrymRii"
Content-Disposition: inline
In-Reply-To: <7697010E-E0F2-419F-8378-FC3E491EE1E4@gmail.com>
X-Cookie: We have DIFFERENT amounts of HAIR --


--usOhYHKopyrymRii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 09:07:00AM +0400, Christian Hewitt wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
>=20
> The ordering in hdmi_codec_get_ch_alloc_table_idx() results in
> wrong channel allocation for a number of cases, e.g. when ELD
> reports FL|FR|LFE|FC|RL|RR or FL|FR|LFE|FC|RL|RR|RC|RLC|RRC:

This doesn't apply against current code, please check and resend.

Applying: ASoC: hdmi-codec: reorder channel allocation list
error: corrupt patch at line 6
error: could not build fake ancestor
Patch failed at 0004 ASoC: hdmi-codec: reorder channel allocation list

--usOhYHKopyrymRii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc14iMACgkQJNaLcl1U
h9BV4gf+LJ5mkc6iJE3lOhouUfTDTYAb0HCe2hehR3zHxG5fml6bhZRD+qZGXAUN
Gt6MOhYkXGEBje6OzQcULFUQX8rgEOqMErf0AHylleearH4cceI126kmUxituqrz
BRFnNP+6qdXMX6VvEJnVYOO3zgVsriCs8nJxrFP9Xx2wRmrkvtaBlF0Fpb+zK5Sk
x4su143PQwjAstdpAPyuAfbM3yBKzuTHuc8I87dXdpRpmvFTLl3KTK9vjFmr9dQO
L8REdphCs5400JrG8Qk8BJEL95UI50pB7srN+eY1q1SpBM47zN2Md8SahJXJQ1wt
+++5gMzxxcbPg49N7IO6/WI7xAMzbQ==
=KPnd
-----END PGP SIGNATURE-----

--usOhYHKopyrymRii--

