Return-Path: <linux-kernel+bounces-430336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2B9E2FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D84DB2C86F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0DD20ADEF;
	Tue,  3 Dec 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn3dN8Xe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3220ADD3;
	Tue,  3 Dec 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266763; cv=none; b=fYf6JCgU6qL1tNYsFqUbMWWz6n/Fkrjp/Ug70H3iK2kNnQVZsoVtd3Z+6zCu+09DbVuLs1qrFMu8t6dODVgZwUFBuhz078+tsn6l3AUoR945rs2rkvdZU/836V+n8kGAIFTYRFfWST9TQHiAvzJOQCcibUB59K7tirQEZrl0lQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266763; c=relaxed/simple;
	bh=RHovkVW6REiiiCFyAhJ+JqNCBa0opkh9DJwle8ld2R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nadL32J7gue6A0PZt1cvYgw6PCT5vnef8f77tP1Kr7vZ1m9RqIOg9fQUaf/DvdOnxMJkN1pY6wqmkoqSI/SOM2yW7Xaws5LwgzLgUL0EF1a8FaLKjvTxLzlFEuGPXcW+dH3j6SYoqXv6ON22FRKhh4DmAxppf4cUQRA9NOvpavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn3dN8Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A55DC4CEDC;
	Tue,  3 Dec 2024 22:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733266763;
	bh=RHovkVW6REiiiCFyAhJ+JqNCBa0opkh9DJwle8ld2R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn3dN8XeKM5vVkOfP7bFH82cyF2OhOe7YMZqUkY3EgOXMhYPv8lzs76l6dxOdv8Ng
	 Lb+v/wLBHkzoHCGe0kYd38ICn8tMeBTNyjxXHaTVZq0plXNY9ZOZN9o8nnlRSz+5mx
	 DxUBtOKuYVoZVDtwwPa1sUm7o1okC8KfhoZ1GX9dKBdGZ1/pSHPJaq85Xu0O5IGncw
	 bRASROsD9nHFm8zo0NZAr+lJRW6Uk1UHeEqscZGtdDQEC25TeHUGgObOntX0ScRG6Y
	 rMZHWHH+rQgZULwczzz4FKW4uPe2zs+o9eQZqTjtUdw/5uFvVHr0LLRrzlvae3ezfv
	 Z2qjCA0a2vDrQ==
Date: Tue, 3 Dec 2024 22:59:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Message-ID: <31edf979-e03a-4c9c-bb93-59ceea6b44a1@sirena.org.uk>
References: <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
 <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
 <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
 <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
 <ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
 <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org>
 <1jr06pkof6.fsf@starbuckisacylon.baylibre.com>
 <37b656cc8272552ba07c93c5a9a59641.sboyd@kernel.org>
 <dbb2de3c-cb29-4384-a00b-4fdedeab1a10@sirena.org.uk>
 <c982c5061ea6b0d465dd8b7fefc59cc7.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oHjAMmplQrPbLqyA"
Content-Disposition: inline
In-Reply-To: <c982c5061ea6b0d465dd8b7fefc59cc7.sboyd@kernel.org>
X-Cookie: Blackout restrictions apply.


--oHjAMmplQrPbLqyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 02:32:56PM -0800, Stephen Boyd wrote:
> Quoting Mark Brown (2024-12-03 14:22:04)

> > Yes, this patch was triggered by me reporting that multiple boards in my
> > test farm have completely broken audio with defconfig.=20

> I thought that commit 5ae1a43486fb ("clk: amlogic: axg-audio: revert
> reset implementation") was sufficient to fix the problem. Is that
> incorrect?

Yes, it should be - it didn't appear in mainline or -next yet and was a
bit more buried in my mailbox than this thread but I see it's in now.

--oHjAMmplQrPbLqyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPjUEACgkQJNaLcl1U
h9Ck5wf+IvbqQTemhM/dZRBZBQkVRYqK48KrdX0LIz2UA9Ezxw90SsDD8aKlYrfS
eaHXd1CUNlZu+BLoA4GwTxjF/Qysu0xs1vd3DscOZ6NkFgMIU3g/THIXv4gGCxLp
6PCBcOlNxmtOPIHaW8HgUEJpn9EsvJyEC+KQ47vVbZWnnkIkYoWrVj19uJacKfcI
EQu0TxpKuj3Z21YqEFBRIvTCy/ZXfFLXy39EthD/0q/LUmQ7oLySJl5MLXeh0Wls
Gvme2HfCtenwVhZ1glILuB/Fcqcg1wZlbnhrv4B/9E+dqUh/9lkgwoeILLzInWpc
l0p1PqdwpqlE+vH9uPWGGmMzQRdwfg==
=Tcei
-----END PGP SIGNATURE-----

--oHjAMmplQrPbLqyA--

